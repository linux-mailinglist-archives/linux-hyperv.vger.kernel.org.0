Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB46C1F58
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Mar 2023 19:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCTSRl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Mar 2023 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCTSRQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Mar 2023 14:17:16 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202534F73;
        Mon, 20 Mar 2023 11:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEPsBLj83OyIaNQjz2XCClDPa7vY0ulfWSpdNJiL7FRPVgeQ4Vmlhqx5P3OyJO2NNf79DDmuh8k+uDak0A50TLu+jBhmmFHcxoF0MEHFwkKCNuEzWT2gscEZ+DveG+GZb5hiOWwBQbFXaJ+Sc3LhEJ5SR8avLvxcuJ4KRV0OYJ/groBfW+SRAMooFFwfX2J8/Rqptl1GcxHvBfI0JwR6wTDONRLUG5Razj89HJYLhLNvpvfVvT8FsZ2Kd6myzdcfQrhh6GCMKahV3WzREXlaBRyy/f/AobytOjv4ySuV1tJnhZ4Fbs0/qJdoXy9UqtU/yoMgmt30mfULBXwT5L1P3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMgGzWhubNlHb2KC5BJUuLkNYZ+9UIc9+6s5r7W0ooI=;
 b=NSs7zji17MbxMdd+4VcafRMnw49L9lLYMWDCbGXgK4PP3Rx3n5IJthvCdy4op9jYEV7DGBaQzeLkXlc5jk1E91HVX9x46X56tEk6rNLJDT0BunPvGohHIU6YjnG2nGSpmQcPWfDoy02tluWPfJFQnW5MtjXmebIZhXM6KgBsPSWp2ZJkdb93KWKOkfuHH5TxIGbCSMvAJgPyQCr4DtVwphW/ibeKT8HlJAJ00znXhSo269gHTxJH+NhamUpaLdoO7rYhmpcyi+7VwzciEI94FNSYs72nOAjNEnwFgzxM9tHQ1Fqp1HLs4OFEIw6fdP+lmshOu+MRD/nL7IbXjVr/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMgGzWhubNlHb2KC5BJUuLkNYZ+9UIc9+6s5r7W0ooI=;
 b=iNZqogyqs57kkSBB/yIFQK5BS61NimUFXL27AsHa0JbLY5Eg35ovFG5dkDMbhPvzobqCSZIMaVZy+nxUhgBzye/CZw5Tui4TMT4L7N9S7+Sj68oAaXBssN6KxOAeN885f07FdHTYMZRT9AH+fKwaEuPbvIDVdXRIBFKZZWLgSKg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1453.namprd21.prod.outlook.com (2603:10b6:208:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.2; Mon, 20 Mar
 2023 18:04:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.002; Mon, 20 Mar 2023
 18:04:16 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v9 5/5] Driver: VMBus: Add Devicetree support
Thread-Topic: [PATCH v9 5/5] Driver: VMBus: Add Devicetree support
Thread-Index: AQHZWwBDpvUkyd9oQUaDzsOlV6PYEq8D9mMA
Date:   Mon, 20 Mar 2023 18:04:16 +0000
Message-ID: <BYAPR21MB16886FA07CD37C9C033A4682D7809@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
 <1679298460-11855-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1679298460-11855-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba5ba23e-0a9e-46cd-8fec-7b7e7fd05f7a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-20T18:02:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1453:EE_
x-ms-office365-filtering-correlation-id: 4c1a647b-9e94-4873-6270-08db296d84f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ct7OHPPf6qU6Da7ySyeIZPYyBza4fNrtE1MUP61NlrA3ULWKonO2+9Xhlc8QpltuN0m7vsCKO8D5LYurqHLi3+jtqVCKrNT/Puz02YgUerVa1ECe8Ox4Craqh01nCkGdLQ0Gs92Z8iPK/1zu/Cp9Ai/Vf54geolG1N8TcC85EqQBt/HeA97Fykyc6waIfl9zH5r1MMGG3GBrC8sTpu13A9EGOYp/3V0rfx0xG0bbemooTTtjBtBOUZqAf6lZlo31B10Z3d/0izLTjW0x3IrDSuXASjt7KNl8XFvaOl0rDME49oOqoSqxs47YhCMSKPWjBURVWdY5sKubia3Ye5465d5XuDUvJh2zOZR4jY/5IDInKfa7is2/hTj2TrVetsyR/Dvi9yf0INZYwYU+yOQt9ayaG2GvHRt/Hu+U5RKSpkG613Fm4Ib0MROsngoJYIbny76X/j2P/wA2TQOnI2yPfUg5rdRH8Z3CA4WRYAWLYXPXxsuRSnxQ3gF9srQbk09yVn/2r+eTYmSVACHsUt332bEPTCUoF33BJEmqnCclR+SRgKtPZ0kXXDbaSokU6DqhpmK1P3GhgxXft7R4BFiv1Glcz0Red4iZchnksHTxkxeyUijMEa+fsx4TI9rh42qTS/Gv9s95rgwXYhQHWAFMvEV8vHKYcXS1u0GqJdSWQO/sUvelIcnfmEVOqISAJZzK43NV9+E3tMHe1Lxf0qHdH2ZZnEtIiSIUlOR0+D0UO6tt0KQRVNqRTCwDN46dy/WM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(5660300002)(38070700005)(52536014)(83380400001)(8936002)(10290500003)(2906002)(55016003)(82950400001)(122000001)(82960400001)(38100700002)(8990500004)(186003)(33656002)(71200400001)(86362001)(316002)(66476007)(66446008)(8676002)(478600001)(64756008)(76116006)(66946007)(66556008)(7696005)(110136005)(26005)(6506007)(9686003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l5iaxK7MU44NtTCf2iP1Ps+aMl4oFnxva2xWGeXLX8gOkmjZDu7ZrYWErA8J?=
 =?us-ascii?Q?Li5002FDmRj/MlLrIfHNigECFWuDlhXkxRVk2XbnuxRkWsOY6H8xE+KExxrX?=
 =?us-ascii?Q?4m8Gl6BBiOv/fMOUlREDXfq/u9kvtdjYtixthqrfyXbzWEoz3YLaybXLJ+sU?=
 =?us-ascii?Q?CxjeRUSqjetyiahHB60lB1QfG2t/9elnrv4dS2PDCssX3/YXtmcQYVxKNwwd?=
 =?us-ascii?Q?yQ/LKE4O3hzwbOsxof1BaSP6jku7MJU5y20aQp+m6l528SfKTmNVpmacwHJP?=
 =?us-ascii?Q?2f46pQKodA/0OvnpYybG/38hoN8umjzNshvDG3bzEJmGiLBEvfHEFHPYj7af?=
 =?us-ascii?Q?N+tH0Prx83MFWU9PtKxWam/A7ICkOHSL7YBV+Ej4bHQvXHT0pAMUhAioFMfj?=
 =?us-ascii?Q?4D7/eG/M4tZn5zt6UEkno85XHTC4giSD/kIEUtL+Mo+tNcr3gARMtcGogtLp?=
 =?us-ascii?Q?K+Kj8Yvj/5budBsIf9huS5KphDSBf2NmF0LpLBGB+XmRKUA3IKlw0Q0CAK/V?=
 =?us-ascii?Q?kkMCaU3/jn7//yc/vuT/feRRGXhNJLdt/ADs+48pelqzwVW22bmQGVydiEQt?=
 =?us-ascii?Q?ss91Ne/fNyTzM4RtG1arFAXwznOY5Mg113ufAlz9+5TGIxt3/2/RMSUtZRt5?=
 =?us-ascii?Q?zk6NhSqOE207OHwVh92Fkrv7+n5FkV/Zy0bRV1Heo1IJl365RPUe9HJIi09g?=
 =?us-ascii?Q?1V2HcPIM3DMexUxMrTZ5tuIjIqQYIdU7zOYUmilAP918SrS8nlUH6bPjdKix?=
 =?us-ascii?Q?Zb7aFMtGkdMc9RTQJ7PCcBS+SBVjO9YQgZA7IhLu8Kv+RFHBG6Q6+5V3YIbV?=
 =?us-ascii?Q?PIwXGBC6LiydCEuKk7sF3vs8clPr51XSkJaR24O0wXmGphwmf9YV06Nm2LWk?=
 =?us-ascii?Q?ccuVBWs4dtUGF1MdaL7S0iHMLlZCU3PzdwZhRLPOcdSrsT/7/CHrtZM1mRSl?=
 =?us-ascii?Q?27vU5gG14ee79Yie+hbl8b/T6nEBqMurgGEvZL519F8cOmT0/BNHUSHXIJt/?=
 =?us-ascii?Q?B4Uv41pMsNQTZcafYlbkt/RvJt1woZDfIX1V08FDnwp+KpiqRty6JyjYzJYx?=
 =?us-ascii?Q?Yvu4XmUS6YumT5Cet3MXia5My+e3uo/nZQWdJpj7TvBfeQ+MNyUHSyWYUI4P?=
 =?us-ascii?Q?j5eBFSRr3h1rhyGvrBUJPD4SQ3jQCcWdQc6lR09gPjXLx9dqcKYBkcG6drgc?=
 =?us-ascii?Q?Cu1gMIH9SScNoIT7WMOZC2d4dYWUQRYER6KeV2ynCB/hg8/dsTjt4ziVg8Hp?=
 =?us-ascii?Q?77x7RNuoDBvqcavbiJBqHbYrvwvwV3GVTlwwoeYBmJEvI6JxkdwQuEukWtrv?=
 =?us-ascii?Q?xKVtrgl/nWZEjwNGHFHlLVb25drHE5x6SDAPr58XS7oiPjCV+A9raf96ppqk?=
 =?us-ascii?Q?cVZLyktuY2Rm3PnmkI8PvpbgOn41pSaJkMJagbgv2rmV2hfKrbb76DiSSgNr?=
 =?us-ascii?Q?s2qM5gjJW5M2ih7dyl/WkGDKeOPw1cdpe1PM5jsskxVAJz7tiRp3NPLlnq9B?=
 =?us-ascii?Q?Q2MDiC6YoojgLQvu+KXjBYSsiPOsBP+EksPEyfRaW823DOgrY+6UIQN4o+56?=
 =?us-ascii?Q?RtvFi74oQRcKPb+D13cBjVMZ90DJCS8emW4muZOBIE9rQC1C789BJqnqkZOn?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1a647b-9e94-4873-6270-08db296d84f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 18:04:16.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TInRUatS2P6SRklk9QIybwnI2GHi5//2JZb/rojRz8UDJhzLg7fGduFmTtt1lN8tx4eOgg4KtAAlypK0Ws5VLGEb2CGRJkgxmhCsTduYGQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, March 20, =
2023 12:48 AM
>=20
> Update the driver to support Devicetree boot as well along with ACPI.
> At present the Devicetree parsing only provides the mmio region info
> and is not the exact copy of ACPI parsing. This is sufficient to cater
> all the current Devicetree usecases for VMBus.
>=20
> Currently Devicetree is supported only for x86 systems.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V9]
> - Add vmbus_mmio_remove for error handling
> - Remove logic from !acpi_disabled to acpi_disabled
>=20
>  drivers/hv/Kconfig     |  5 ++--
>  drivers/hv/vmbus_drv.c | 66 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 65 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0747a8f1fcee..47132b30b7ee 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -4,11 +4,12 @@ menu "Microsoft Hyper-V guest support"
>=20
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
> -	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ARM64 && !CPU_BIG_ENDIAN))
> +	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> +		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select VMAP_PFN
> +	select OF_EARLY_FLATTREE if OF
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3ad2fa2b92e7..5de2d3bb8289 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -20,6 +20,7 @@
>  #include <linux/completion.h>
>  #include <linux/hyperv.h>
>  #include <linux/kernel_stat.h>
> +#include <linux/of_address.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
>  #include <linux/sched/isolation.h>
> @@ -2143,7 +2144,7 @@ void vmbus_device_unregister(struct hv_device
> *device_obj)
>  	device_unregister(&device_obj->device);
>  }
>=20
> -
> +#ifdef CONFIG_ACPI
>  /*
>   * VMBUS is an acpi enumerated device. Get the information we
>   * need from DSDT.
> @@ -2253,6 +2254,7 @@ static acpi_status vmbus_walk_resources(struct
> acpi_resource *res, void *ctx)
>=20
>  	return AE_OK;
>  }
> +#endif
>=20
>  static void vmbus_mmio_remove(void)
>  {
> @@ -2273,7 +2275,7 @@ static void vmbus_mmio_remove(void)
>  	}
>  }
>=20
> -static void vmbus_reserve_fb(void)
> +static void __maybe_unused vmbus_reserve_fb(void)
>  {
>  	resource_size_t start =3D 0, size;
>  	struct pci_dev *pdev;
> @@ -2433,6 +2435,7 @@ void vmbus_free_mmio(resource_size_t start,
> resource_size_t size)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
>=20
> +#ifdef CONFIG_ACPI
>  static int vmbus_acpi_add(struct platform_device *pdev)
>  {
>  	acpi_status result;
> @@ -2485,10 +2488,54 @@ static int vmbus_acpi_add(struct platform_device =
*pdev)
>  		vmbus_mmio_remove();
>  	return ret_val;
>  }
> +#else
> +static int vmbus_acpi_add(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static int vmbus_device_add(struct platform_device *pdev)
> +{
> +	struct resource **cur_res =3D &hyperv_mmio;
> +	struct of_range range;
> +	struct of_range_parser parser;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int ret;
> +
> +	hv_dev =3D &pdev->dev;
> +
> +	ret =3D of_range_parser_init(&parser, np);
> +	if (ret)
> +		return ret;
> +
> +	for_each_of_range(&parser, &range) {
> +		struct resource *res;
> +
> +		res =3D kzalloc(sizeof(*res), GFP_KERNEL);
> +		if (!res) {
> +			vmbus_mmio_remove();
> +			return -ENOMEM;
> +		}
> +
> +		res->name =3D "hyperv mmio";
> +		res->flags =3D range.flags;
> +		res->start =3D range.cpu_addr;
> +		res->end =3D range.cpu_addr + range.size;
> +
> +		*cur_res =3D res;
> +		cur_res =3D &res->sibling;
> +	}
> +
> +	return ret;
> +}
>=20
>  static int vmbus_platform_driver_probe(struct platform_device *pdev)
>  {
> -	return vmbus_acpi_add(pdev);
> +	if (acpi_disabled)
> +		return vmbus_device_add(pdev);
> +	else
> +		return vmbus_acpi_add(pdev);
>  }
>=20
>  static int vmbus_platform_driver_remove(struct platform_device *pdev)
> @@ -2634,7 +2681,17 @@ static int vmbus_bus_resume(struct device *dev)
>  #define vmbus_bus_resume NULL
>  #endif /* CONFIG_PM_SLEEP */
>=20
> -static const struct acpi_device_id vmbus_acpi_device_ids[] =3D {
> +static const __maybe_unused struct of_device_id vmbus_of_match[] =3D {
> +	{
> +		.compatible =3D "microsoft,vmbus",
> +	},
> +	{
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> +
> +static const __maybe_unused struct acpi_device_id vmbus_acpi_device_ids[=
] =3D {
>  	{"VMBUS", 0},
>  	{"VMBus", 0},
>  	{"", 0},
> @@ -2668,6 +2725,7 @@ static struct platform_driver vmbus_platform_driver=
 =3D {
>  	.driver =3D {
>  		.name =3D "vmbus",
>  		.acpi_match_table =3D ACPI_PTR(vmbus_acpi_device_ids),
> +		.of_match_table =3D of_match_ptr(vmbus_of_match),
>  		.pm =3D &vmbus_bus_pm,
>  		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
>  	}
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

