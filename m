Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0D6BA15A
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Mar 2023 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCNVVi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Mar 2023 17:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCNVVh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Mar 2023 17:21:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D34E5C6;
        Tue, 14 Mar 2023 14:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPpyVM6tqDKnlaNaKYJ15pZgqldl7v+FG2earWkz+AsA+5dCtHJgSIILlXcu0GogPYhGhVB6NWLDEKzcLasSk8qSH8pHyiYacsv+4cT/ctE7VMgg7ebcVU5xlWqMz8DZ9vaYt+wiw1hqHXljrp5GYpA8TTNZgIaHzlLwujRmrtbbgTOH0Fa7qdwTFCSKoXeSOOG0lxwhkCUwmwWtpkzJWSyJpZYyR0FVAMl24JqcpQBV4qNsDeEX44z5CnpkjNbh1GikCkbXtiAV0PbEMX9R7V0wXX4XZTEZd2sZkDvoTFZrjVeXzNGO3+7WpV4mTHSvGldmdrQNlLpiJ7BUF35BMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uf9qLE51p8Mgk4OzctuREe/JJbk1v/bqHo+AAmTKpc=;
 b=l10bTAd55l51laACiWbzh6LEBTCqzygsPVfZjBIIItHh/ETIpKU/Cs4t8Q7a4nKPnGPBEjaRFbR6iG0wX6r/huXX+5GyNwIjllcguX1cE4n4hHcx+yzlvc/2pxXO8/TijPJkVyHvDev16yZ9HLBc5DHlHDDCGiYFlZTKL+9lxbEdH6kjY619wuLbbwqKhBfg+ltMPPDXsxfHqU3N+KlvTyuNC02HZ1+15FR33EyE40SbfQsfHgwi3R+YGHzaJrDAQg0GvlNRO0uvUTuw18mTYXhc4WYooFefU5tJqiEF96DI31S7btMrHepAf/dAsgrJBQGVSDsKhc6hOB6wdwwf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uf9qLE51p8Mgk4OzctuREe/JJbk1v/bqHo+AAmTKpc=;
 b=DD0C9ifrfSoO1N1MTX79HzHX0iAo4SacFc3TD1ZsuWmizH0ptRuklKuZFGr2wDjiS3xmsBZs/xXghpC0772+MZBQVn6vFH0z/0/ln6supHhnXfWvUg8Yw1gecAlkrcP/nnHtpD2YD37f8IxpqpJQivxchJlbcaBk1YiTt9rDttw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB3821.namprd21.prod.outlook.com (2603:10b6:303:223::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.3; Tue, 14 Mar
 2023 21:21:32 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6222.005; Tue, 14 Mar 2023
 21:21:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v8 5/5] Driver: VMBus: Add Devicetree support
Thread-Topic: [PATCH v8 5/5] Driver: VMBus: Add Devicetree support
Thread-Index: AQHZVlWavmnP9/zihkCnOeePRyBcgq76xKJQ
Date:   Tue, 14 Mar 2023 21:21:32 +0000
Message-ID: <BYAPR21MB1688962642EBF09FA8C7FAEBD7BE9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
 <1678785350-20400-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1678785350-20400-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b5536f3a-af01-4cfa-aa56-a34451e0d396;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-14T21:05:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB3821:EE_
x-ms-office365-filtering-correlation-id: 1acd7cde-e329-4118-f8f2-08db24d21541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVF/BJjPNzisAb6brZCNczORbyoCoGMxJ8RH9PWrU/n+46qZH2XxdUq/w1q3kZraeCmpfKG2mwmjMf3RLwv/KpTdwJc+2f09zkJrsHenwp0Jvel7Xle2dz/blsjacYlvUSg4zqXhUVTM2XsvZbF+UjZJIXBG8Gs3Y9m9Kyk9tZOlc74frGpcJfgqRhQLyswQhUeOhPIHPLBNTQfyZo/gumfJ/qwVcVxQQc78o2JcRlRUXB5CL5KTb+6vOJCQHk+YFHKcMMmJde8O9QK9xqINMUicG92HxQYQX0/4+LkRNhAR0crbcJ0Ya38IapVEkUoaXJEQQ0ZkI+hicpBm+RmuJt2rlW8ix7Sla9tQDPdAorTmtvIge2Y5X6sdS51k2SQzABLERv42sDMTWEq/5XToMPv2/KqhiP7n0P1wODppSdKvI4PR+rG84LmSuKj6ryyDdy9GxSeozsFY629+vzVWQBmUjGFUKC69JKA0ladQ1AUpP4GYyHyokvVyCfQPnUDuBL609dOvRXQgT4oxTpHmS+gs+VAswYOytlWqTuZ5UxQCoF23eWXIqE3eZ1AGFFxc3FMQZ+B/owafeZLeLM4kDgtT1sxtLGbPTMSybim8+evwd+Spoy5sfYPn9Nt6IndJYdYzLL+mnjsTzYQhVVJBdlirRGR5KQZ+5BlhypyGIBrIl40nrl8iQgCQlti1DgYLVFrGvD6ll4dyfaGG2cP9um+UHdyzSJPF+uakoWq+hBXmI4hsG3bmKLZ5eHjd6ee6hMU4JYUSSdbFYjoFU3fABA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(7416002)(5660300002)(6506007)(186003)(122000001)(82960400001)(82950400001)(41300700001)(52536014)(33656002)(921005)(8676002)(7696005)(66476007)(66946007)(66446008)(71200400001)(66556008)(38100700002)(76116006)(64756008)(8936002)(38070700005)(9686003)(26005)(110136005)(55016003)(2906002)(316002)(86362001)(83380400001)(478600001)(10290500003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aIKoPd/5fWfSX8uR9JLPVJQ5rhjSVFxcJbVazrbLjZdIlNBU8V0pdlv0O9e0?=
 =?us-ascii?Q?8elhn9HhsNaWIk+4SHEfJHSIUDvkUS2SeK8ZjmZRAApJnpbCPFfBt85wekY/?=
 =?us-ascii?Q?qeB2dUP/AnWcS8aemSm2i4kTaln1uadsmdo9UTl2AeXoi/XCRvknoDbY7K28?=
 =?us-ascii?Q?Vdc++8blSdI7U2RHSi1pw3oooShDsRXATW1A4v29ooh/ONHQf9rjK7Wj0NUu?=
 =?us-ascii?Q?8RB+ymgpf/V7C+RLbr09GvVnIGsD3VQRZ8ttMVPdWe2RxENBdQd8tT4PdxiL?=
 =?us-ascii?Q?UaDzZOFBuylkqxHm4KaF/tCdeq6f/Jk2Qv55B3u7gtFNTBnhzW/ueQ5O8jxZ?=
 =?us-ascii?Q?oqeKBZOfffRouDaEAVHQBpCCZeY06i2XdV3Qj8dK7ZODnxscnzEILHJ3xIHV?=
 =?us-ascii?Q?bVdb/tH/MBADAVCs4g8dTEfSKd94ZlQYf7ul7tjoqV1m4AvXvC35SF3bj4Lh?=
 =?us-ascii?Q?nyv612sJ3lxFlTonsGMqHlKr4vLWe8kuEC3wB582xs6bMsHLJC+VzL6EqzoW?=
 =?us-ascii?Q?VteFwya9wPQXaiWjtESBHS7lY9PeiWvPdJ8wnyTC+htRvkF9XWwty7S8WPCP?=
 =?us-ascii?Q?KPSKjXbdjoSBVtv+bETaAwy9SIlneAckIHJ6YJ6BYnEcUS9Cbm4bjdQpPv9d?=
 =?us-ascii?Q?jbQbyeJHaKEa96lkYnrNTazuuICqS6voLeQ277teJP4ptVE0IGLVEle5SSyC?=
 =?us-ascii?Q?qEz3KAOmyZby0f8Vciyp0H3N8ABoENG+azwXKyQ8VjehWwCaCBHiZV3u/26f?=
 =?us-ascii?Q?FUez1FUYBlGzLvpg6kTiNlxxaGnP/hA58O7DoTBL8cQ7Y1JiPh2qO9P1BC3J?=
 =?us-ascii?Q?i+GqghhaQN7UfxPuSP5iJOrwUxFjmnY6JUPqGHDU+j9GeEVYdXmS1gBhpwV0?=
 =?us-ascii?Q?otPz9QIlAP6dQUeKiRM1sqkolfAxk33ava6D0/W/72dd9l4tlTt0lfISUi5k?=
 =?us-ascii?Q?YCYr5wOt32pMvc8oGzwppLqeEgg7cHBGpUn3llOm1DpZFp7Qd13d0QSXdBD6?=
 =?us-ascii?Q?D7Ngx+yYxDDzomYQcqFxNa6mZcH2ROwibXUOKwRXIUbv49ej15ErJ8jWvtBx?=
 =?us-ascii?Q?MNrYiX1SHcM702C0Sw55BZTYIjUiCvXlO56nIqHE/HOxo83zAkOK622x1pOS?=
 =?us-ascii?Q?iO9Q9UtMjD8VXeJdWd3hHXKq0JHsCrkIVADwo77bONcd2tj92O/iQY/Vjc4z?=
 =?us-ascii?Q?99C//YWgthdXRZJAVDmK/r+r5gRylEBv7TLO8P3YfiuLyACkPfomIajkDPn1?=
 =?us-ascii?Q?8BdQz6wrM2XrMyw6+4WifaDbSwhrEe7jz8kfJA88JPyhFFFvuqCi1IommunF?=
 =?us-ascii?Q?RAXGhLAB/dJUFzKMQ4CkPH5it/PYAhIjeZYYGAbeD4GRUiKY9880pi9GMZtA?=
 =?us-ascii?Q?M3ZjnYs575H/F8+cfoSZc8+n8NwQc8QdtY7ukMV9ZQZOn22JJMpjW1qZoAJg?=
 =?us-ascii?Q?loX0LBSGSx6IH1mcxUi5rqyv9utM6GsBr/JvOM5qtZbIGmQpiI7cyA7kPdg3?=
 =?us-ascii?Q?EPNlEndgVspvfQtuYwrImg1aEmbAbwiTnlKjSKzKrc/o3AFXqevCWKfCjkSV?=
 =?us-ascii?Q?wpb8nuzJl6B+k5jA9XLaQUp/tt3BlhxN8ewz5i9E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acd7cde-e329-4118-f8f2-08db24d21541
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 21:21:32.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi9leVWi+xJcyJCU8HtTnWXzcaFs8P3nXWVb0+8TVmroszm5GwWgj6knBuAuaADceHf+kqTXB2BAYDQcU1hytbxYcx7D893ay7/hvFxnxFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB3821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, March 14,=
 2023 2:16 AM
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
> [V8]
> - Remove the auto select of CONFIG_OF
> - Remove the dependency on !ACPI for OF_EARLY_FLATTREE
> - Used acpi_disabled instead of #ifdef and hence added a dummy function
>   for vmbus_acpi_add
> - GFP_ATOMIC -> GFP_KERNEL
> - used range.flags instead of hard coding flags
> - used __maybe_unused for acpi device id, removed #ifdef
>=20
>  drivers/hv/Kconfig     |  5 ++--
>  drivers/hv/vmbus_drv.c | 64 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 6 deletions(-)
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
> index 3ad2fa2b92e7..15097e1f3f2b 100644
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
> @@ -2143,7 +2144,7 @@ void vmbus_device_unregister(struct hv_device *devi=
ce_obj)
>  	device_unregister(&device_obj->device);
>  }
>=20
> -
> +#ifdef CONFIG_ACPI
>  /*
>   * VMBUS is an acpi enumerated device. Get the information we
>   * need from DSDT.
> @@ -2253,6 +2254,7 @@ static acpi_status vmbus_walk_resources(struct acpi=
_resource
> *res, void *ctx)
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
> @@ -2433,6 +2435,7 @@ void vmbus_free_mmio(resource_size_t start, resourc=
e_size_t
> size)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
>=20
> +#ifdef CONFIG_ACPI
>  static int vmbus_acpi_add(struct platform_device *pdev)
>  {
>  	acpi_status result;
> @@ -2485,10 +2488,52 @@ static int vmbus_acpi_add(struct platform_device =
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
> +		if (!res)
> +			return -ENOMEM;

I should have looked at this more closely in the previous
revision.  But if this error path is taken, does any cleanup
need to be done of 'res' entries that were allocated in
previous iterations of the for_each_of_range() loop?  It
seems like the cleanup and releasing of previously allocated
memory should be done.

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
> +	if (!acpi_disabled)
> +		return vmbus_acpi_add(pdev);
> +	else
> +		return vmbus_device_add(pdev);

Nit: Usually when there's a negated test with if/else, it's best to flip th=
e
if and else clauses so as to eliminate the negation.  It's just slightly le=
ss
semantic load for the human reader to parse through.  So:

	if (acpi_disabled)
		return vmbus_device_add(pdev);
	else
		return vmbus_acpi_add(pdev);

Everything else looks good to me.

Michael

>  }
>=20
>  static int vmbus_platform_driver_remove(struct platform_device *pdev)
> @@ -2634,7 +2679,17 @@ static int vmbus_bus_resume(struct device *dev)
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
> @@ -2668,6 +2723,7 @@ static struct platform_driver vmbus_platform_driver=
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

