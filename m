Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF95F686DFD
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 19:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBAScj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 13:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjBASci (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 13:32:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB152BEF0;
        Wed,  1 Feb 2023 10:32:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntdJLe83+aXAhZLVdVI53VJEXDA/TTiLWZBe0sq8na9KVUl8EL5EZP60PNPUqGjRiqCvYTiYyKfVZ/B+bWhOG1SX4/hvtUWkmkh6LkyV6jet9Ek0ol4VkOVBvPJ+N2RO5PBl/4WAXW62Q5wluIF/+nr3q0J4csAmslS2tOyeKeIfkmzLD/VT214hSXkVOFheNYjw2E5hhSMjJ5TYKKWx6b3KzURV1IdWB8c5k7RtyKSSpN+3RDd7NA21VM/xK5CN3sRqGmk+fi7ysGXmK+crKLntzryRwoaG2U4YaCkF6ZAbg62RNzbS6kDe6Qy5B3mH0z9Ve2Rxr4sB51ctKsQLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnjsJlUdn4TISImb3mwTDhecC4ATi+uo1fUsu7+ifBc=;
 b=XVSTs0nASy7cvc2wDaLg0XSKR0lodu49DDPoSTF4z4ad0z4ooPk2tuoYz3IpzqcxlwoulQgbVKbMSsjuu/qQAHovLR052jXj7wMbaMZwrgsnyV2dCJ95NNRe5+XRfoStDvew1bKdNZn3XzQUtINZjiUV8cnTTF4HR72pc3zW/cMnCo/pAK6KUGPJ3jcUNxgFyGR4lNjlskRMMHkDJcK8HFg7sqbikCmUEZ2Y4d3h5JaF75b0zG1hPGQyL9XQxpFrGYfwbpnnLFqYdsfH/ROQLdHDe5Mk++jKmruLxbhaDqbTA2pN7Sz8NZIPlT16G8U+Ytusr28UilF5bgAXVlzRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnjsJlUdn4TISImb3mwTDhecC4ATi+uo1fUsu7+ifBc=;
 b=awnW1ULsuZQ0nTxxX7y40+Rgc4YdH0IGr1GZNBpLCFr0k04csIQUload2lIpPWyajzojcpncXL8UtVqE6irb+ZHXCR8oaMWCIrshsRiTCzLx1P1K4rHFAXjfkZUNu70wAyf1Nz18vfWI5XQaOvYNMfbkdLq/0YczXfprwYZfWNg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3516.namprd21.prod.outlook.com (2603:10b6:930:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Wed, 1 Feb
 2023 18:32:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Wed, 1 Feb 2023
 18:32:29 +0000
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
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2 3/6] Drivers: hv: vmbus: Convert acpi_device to
 platform_device
Thread-Topic: [PATCH v2 3/6] Drivers: hv: vmbus: Convert acpi_device to
 platform_device
Thread-Index: AQHZNZ9JXlHKvekU3Uq/tjJS/YXUy666YDpw
Date:   Wed, 1 Feb 2023 18:32:29 +0000
Message-ID: <BYAPR21MB1688C6978F68D904ABC00911D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-4-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675188609-20913-4-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3634d1b2-429d-4775-a498-0848d232c942;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-01T17:50:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3516:EE_
x-ms-office365-filtering-correlation-id: a35106e2-31a6-44b8-7d46-08db0482ad01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFqKdxKMH6QbrDSMCXmezU/1dYTRWHU0wNT8mUHfOUezmXIN5AQir3sDSpfX2e26cOPvxBGDgYHHyseOcWnMTDcbdjIGiKdI7U6G2iK7eFUUrDG2aZQsmyqPUT5oR/IeB4L/hM7F5qO0Z5bKiu/HCTnQ+ftOmApPLMZc/4glcaNn3Cq+kM3zdVqxy/VMplG1JRU9gwHUHYcHKfl1qorc0LnAfJ/ZcGopY3HZjTL9wPYy3aPK91ddu2U7uC65Xi/ru44/Aok5wUl9S44ao5fUsnqo+uJH4QeDxsQCc5Qvql5xR4rkAsWCc7s42bXvMzuAHjQizuELY8D7qxtjfHBeWKpy+cM6n3yaB+oOAICg2pkutvkSP6zTYiJTpoBzZzAdf2yoJ2cW0LEDiucZ76XMKC2vKNPQ4xfY1yy+XZ2gU9sT7SY/5Hj+xSXa1CtPVcRq9ctOOBWMcizN6X6FHvx7jqhBnazHT/IkfvyGZ8mYduf5hN8v2trkZEVntWn5ic1Mki4vQvp5FPq056pgk/3AsUn0NQEbIK5OocvwghYE4Ojo1g3MdaMvKR9KaqcriT+5qMCFsKwl/G923hyE7RKHMSmW7Kq5qRew+AAHRmEX3pkVFaHTyUQFCQskvB8agMcdDJ5e9xRlkFBsWx2HePGSVS8e4MSrM/lmzVFO81gS8SC/WPouV+WJlP6OkPgp1ngP3pKgcsvQcPGPzScDnE7qd/SH4aVKEJZwK5k76WUM8oWiXtMFx1qkpYdQo6MfABTt/j7iq6+38ezPdl+if/adbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199018)(8990500004)(478600001)(122000001)(186003)(66946007)(71200400001)(2906002)(26005)(7696005)(10290500003)(8676002)(6506007)(41300700001)(52536014)(8936002)(64756008)(76116006)(66476007)(6636002)(110136005)(38070700005)(316002)(83380400001)(921005)(82950400001)(86362001)(66446008)(82960400001)(66556008)(38100700002)(55016003)(33656002)(5660300002)(9686003)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8z0zjA5PCc1i7scjcNuqGzB2CsJrK7K5Wvyo/8zoJRwmHFp4vaOZNbJWkJC6?=
 =?us-ascii?Q?Kg6O+ceM+wZy5wwupCtvH/YjkC7KDhgXQNCKjYwGc6jAtaSFro+9ZHPeN/Ee?=
 =?us-ascii?Q?5gNK5WzPwj9Bm14zIls+jjLAZSPL28bWb5OrVIcDu+gCqQH2ngaxUL+yHub8?=
 =?us-ascii?Q?sP+rktybT9pzJRLKvlEb5wFIQKblGE6ZxVKI/w4QY1ApkP64Yt5QQi6XC+HP?=
 =?us-ascii?Q?2jRTT9h1mOyeWDQcDh/PjedIVMDYygOR/q8fhwVG9TLMMeRVxNpyh44fF26I?=
 =?us-ascii?Q?IBZ2TVpoY6yYBRwsEMt2VA+5rH7XLVnasfEdo5mQxOKGRBx5WYEnA1GSroeQ?=
 =?us-ascii?Q?QSsAY5D3BU/oIshSEglllYDcV5E6hkKA9fwmtEeTqaGoDBjzA0z85JTnczyf?=
 =?us-ascii?Q?v4MY2GG+e52zXSr63Yy58f5f3tmkQbabgXM0rhJNhiuwOTiJ7Wi1XSB4T3Gm?=
 =?us-ascii?Q?ZW0ONKSUjVfCRvlonatjUcEFAkODeS6dUjY41xL7py2t1iM0pVFRZZ/a3/hb?=
 =?us-ascii?Q?rl79ptxk6flUU8c/Nfdd6vGZqpAWC1p690gOnskmK4uzT0etkcWfSlgYYOqY?=
 =?us-ascii?Q?sFz0Hdk/o13t972kQVsCMgs2v1zVIf5gveV74N3UPRhBMh0NmjNGUwv3q9sf?=
 =?us-ascii?Q?Cbsubsk861Dirpgw/YdwfkorYuFzU/P7nY6kc/iUCSeW/fBqcfzE5YlQ+tuL?=
 =?us-ascii?Q?oLu4g8jJvY0uDiaCkPa3kiHTfVuDm00pvoYxRxjW/VNButle3DnwpSdUSTYi?=
 =?us-ascii?Q?gJIrJ3mDHZhXh9Qdg0kz81wAbbV+xTCqVBQzyfczgUVae9CPyJp6jKkTaSfA?=
 =?us-ascii?Q?Ef0nf4Al7wywMGq+3h6SFN/Nx4xXzWiWWT6pTSCp1TNU+81mU4+VFcJtGj/z?=
 =?us-ascii?Q?Rsv6Q2koJB6s7iZQrIkFFlV3YVll74vRegyf2y2Fx7H01GMVvEAcW+/5ySLW?=
 =?us-ascii?Q?LtXg/uC/KOqjwgV45A+/rTL/OEtGktInIDD2DlFrhaAx6tSvmzGO6XgWq+C1?=
 =?us-ascii?Q?pT5Zcv7A0RM6L6A92H3PycjpucV4l1dgUAquYxUCqd0yZiv5rYkLOimyXIY7?=
 =?us-ascii?Q?Dv9kf7Nfu3a+3ElQWiz/l+OwjvrY8O0Dn1tJxYpKHRbtabVRnzw+MzpmKhtt?=
 =?us-ascii?Q?jDzNmg6Q0tzM6V0bGMbDj9zSEXy6M7vjxNMuSrx/F5UajnvSyvUy90nSXx2P?=
 =?us-ascii?Q?MMftWf45AAuOfflBCANY+lK8RjuYRyZuXU7yLyEO1Cx35VTuhX8CsX4Y+n6S?=
 =?us-ascii?Q?3c4kFk1lzkTCcLCuCld0LJ3kDw4xNidrDqIb3p7a2HFhHOESdQb5M1i1fbuj?=
 =?us-ascii?Q?pkex9kmDyC/gw2v5DGmLQg644qiMIoWt8xKLVLTIAL8wztG4FGKm2BqZJpjy?=
 =?us-ascii?Q?XUTehhODrF4e+AkppQG6x76iEDPnS+rBj13bsLMqSiW7B42+dAove60MLOAu?=
 =?us-ascii?Q?fULyY4iq6i0sHmIck2C2opkaavT1uTtgZ4PwWzF557V8DgT4/EsHiiKAOSKy?=
 =?us-ascii?Q?kUhkkttSEE9553Um+bMNa1QdP6VXaLcVYc1FNc9We74FcoGC9rct6b4STPkx?=
 =?us-ascii?Q?hEqkxLsg/jf4Dlw0HCAGWflIj67CYbBTfn9bCx0C1RCjsi3UBNULkKhS7KEU?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35106e2-31a6-44b8-7d46-08db0482ad01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 18:32:29.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyjO+Ynq7ekst3sFWnCsBkx8WqRS04nXRTR84et/PRXyw1yHQVQLrgxCrRUnJ0oJYEQlxI2O8wnWgr2zHdVfKOfijpvY67+TkZcQuklo/yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, January 3=
1, 2023 10:10 AM
>=20
> Use more generic platform device instead of acpi device. Also rename the
> function vmbus_acpi_remove to more generic name vmbus_mmio_remove.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 78 +++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d24dd65b33d4..49030e756b9f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/sysctl.h>
>  #include <linux/slab.h>
> @@ -44,7 +45,7 @@ struct vmbus_dynid {
>  	struct hv_vmbus_device_id id;
>  };
>=20
> -static struct acpi_device  *hv_acpi_dev;
> +static struct platform_device  *hv_dev;
>=20
>  static int hyperv_cpuhp_online;
>=20
> @@ -143,7 +144,7 @@ static DEFINE_MUTEX(hyperv_mmio_lock);
>=20
>  static int vmbus_exists(void)
>  {
> -	if (hv_acpi_dev =3D=3D NULL)
> +	if (hv_dev =3D=3D NULL)
>  		return -ENODEV;
>=20
>  	return 0;
> @@ -932,7 +933,7 @@ static int vmbus_dma_configure(struct device *child_d=
evice)
>  	 * On x86/x64 coherence is assumed and these calls have no effect.
>  	 */
>  	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(&hv_acpi_dev->dev) =3D=3D DEV_DMA_COHERENT);
> +		device_get_dma_attr(&hv_dev->dev) =3D=3D DEV_DMA_COHERENT);
>  	return 0;
>  }
>=20
> @@ -2090,7 +2091,7 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  		     &child_device_obj->channel->offermsg.offer.if_instance);
>=20
>  	child_device_obj->device.bus =3D &hv_bus;
> -	child_device_obj->device.parent =3D &hv_acpi_dev->dev;
> +	child_device_obj->device.parent =3D &hv_dev->dev;
>  	child_device_obj->device.release =3D vmbus_device_release;
>=20
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> @@ -2262,7 +2263,7 @@ static acpi_status vmbus_walk_resources(struct
> acpi_resource *res, void *ctx)
>  	return AE_OK;
>  }
>=20
> -static void vmbus_acpi_remove(struct acpi_device *device)
> +static void vmbus_mmio_remove(void)
>  {
>  	struct resource *cur_res;
>  	struct resource *next_res;
> @@ -2441,13 +2442,15 @@ void vmbus_free_mmio(resource_size_t start,
> resource_size_t size)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
>=20
> -static int vmbus_acpi_add(struct acpi_device *device)
> +static int vmbus_acpi_add(struct platform_device *pdev)
>  {
>  	acpi_status result;
>  	int ret_val =3D -ENODEV;
> -	struct acpi_device *ancestor;
> +	struct platform_device *ancestor;
> +	struct acpi_device *adev =3D to_acpi_device(&pdev->dev);

This doesn't work.  The argument to vmbus_acpi_add() is a struct
platform_device, which has a struct device embedded in it (not a
pointer).   to_acpi_device() takes a struct device as an argument,
assuming that the struct device is embedded in a struct
acpi_device, which is not the case here.  The resulting local
variable adev is actually pointing to some (perhaps negative)
offset within the struct platform_device, and uses of adev are
getting unknown random data from within (or before) the
struct platform_device.

>=20
> -	hv_acpi_dev =3D device;
> +	hv_dev =3D pdev;
> +	adev->fwnode.dev =3D &pdev->dev;
>=20
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2456,15 +2459,16 @@ static int vmbus_acpi_add(struct acpi_device *dev=
ice)
>  	 * up the ACPI device to behave as if _CCA is present and indicates
>  	 * hardware coherence.
>  	 */
> -	ACPI_COMPANION_SET(&device->dev, device);
> +	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pdev->dev));

This statement seems tautological.  If ACPI_COMPANION(&pdev->dev)
returns a valid result,  why would the ACPI companion for &pdev->dev
need to be set?  The original code was setting the ACPI companion for the
embedded struct device to be the struct acpi_device.   I forget why this
wasn't already done for the VMBus device when it was originally parsed
from the ACPI DSDT ...=20

>  	if (IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) &&
> -	    device_get_dma_attr(&device->dev) =3D=3D DEV_DMA_NOT_SUPPORTED) {
> +	    device_get_dma_attr(&pdev->dev) =3D=3D DEV_DMA_NOT_SUPPORTED) {
> +		struct acpi_device *adev_node =3D ACPI_COMPANION(&pdev->dev);

If earlier code in this function can get a correct pointer to the struct ac=
pi_device,
then this statement shouldn't be necessary.  You already have it.

>  		pr_info("No ACPI _CCA found; assuming coherent device I/O\n");
> -		device->flags.cca_seen =3D true;
> -		device->flags.coherent_dma =3D true;
> +		adev_node->flags.cca_seen =3D true;
> +		adev_node->flags.coherent_dma =3D true;
>  	}
>=20
> -	result =3D acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +	result =3D acpi_walk_resources(ACPI_HANDLE(&pdev->dev), METHOD_NAME__CR=
S,

Again, if you have a correct pointer to the struct acpi_device, then adev->=
handle
(like the original code) should be simpler than looking it up again with AC=
PI_HANDLE(). =20

>  					vmbus_walk_resources, NULL);
>=20
>  	if (ACPI_FAILURE(result))
> @@ -2473,9 +2477,9 @@ static int vmbus_acpi_add(struct acpi_device *devic=
e)
>  	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
>  	 * firmware) is the VMOD that has the mmio ranges. Get that.
>  	 */
> -	for (ancestor =3D acpi_dev_parent(device); ancestor;
> -	     ancestor =3D acpi_dev_parent(ancestor)) {
> -		result =3D acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
> +	for (ancestor =3D to_platform_device(pdev->dev.parent); ancestor;
> +	     ancestor =3D to_platform_device(ancestor->dev.parent)) {
> +		result =3D acpi_walk_resources(ACPI_HANDLE(&ancestor->dev), METHOD_NAM=
E__CRS,

Similarly, if you get a correct pointer to the struct acpi_device, does the=
 above
code need any changes?  I'm hoping not.

>  					     vmbus_walk_resources, NULL);
>=20
>  		if (ACPI_FAILURE(result))
> @@ -2489,10 +2493,21 @@ static int vmbus_acpi_add(struct acpi_device *dev=
ice)
>=20
>  acpi_walk_err:
>  	if (ret_val)
> -		vmbus_acpi_remove(device);
> +		vmbus_mmio_remove();
>  	return ret_val;
>  }
>=20
> +static int vmbus_platform_driver_probe(struct platform_device *pdev)
> +{
> +	return vmbus_acpi_add(pdev);
> +}
> +
> +static int vmbus_platform_driver_remove(struct platform_device *pdev)
> +{
> +	vmbus_mmio_remove();
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int vmbus_bus_suspend(struct device *dev)
>  {
> @@ -2658,15 +2673,15 @@ static const struct dev_pm_ops vmbus_bus_pm =3D {
>  	.restore_noirq	=3D vmbus_bus_resume
>  };
>=20
> -static struct acpi_driver vmbus_acpi_driver =3D {
> -	.name =3D "vmbus",
> -	.ids =3D vmbus_acpi_device_ids,
> -	.ops =3D {
> -		.add =3D vmbus_acpi_add,
> -		.remove =3D vmbus_acpi_remove,
> -	},
> -	.drv.pm =3D &vmbus_bus_pm,
> -	.drv.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> +static struct platform_driver vmbus_platform_driver =3D {
> +	.probe =3D vmbus_platform_driver_probe,
> +	.remove =3D vmbus_platform_driver_remove,
> +	.driver =3D {
> +		.name =3D "vmbus",
> +		.acpi_match_table =3D ACPI_PTR(vmbus_acpi_device_ids),
> +		.pm =3D &vmbus_bus_pm,
> +		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> +	}
>  };
>=20
>  static void hv_kexec_handler(void)
> @@ -2750,12 +2765,11 @@ static int __init hv_acpi_init(void)
>  	/*
>  	 * Get ACPI resources first.
>  	 */
> -	ret =3D acpi_bus_register_driver(&vmbus_acpi_driver);
> -
> +	ret =3D platform_driver_register(&vmbus_platform_driver);
>  	if (ret)
>  		return ret;
>=20
> -	if (!hv_acpi_dev) {
> +	if (!hv_dev) {
>  		ret =3D -ENODEV;
>  		goto cleanup;
>  	}
> @@ -2785,8 +2799,8 @@ static int __init hv_acpi_init(void)
>  	return 0;
>=20
>  cleanup:
> -	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> -	hv_acpi_dev =3D NULL;
> +	platform_driver_unregister(&vmbus_platform_driver);
> +	hv_dev =3D NULL;
>  	return ret;
>  }
>=20
> @@ -2839,7 +2853,7 @@ static void __exit vmbus_exit(void)
>=20
>  	cpuhp_remove_state(hyperv_cpuhp_online);
>  	hv_synic_free();
> -	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> +	platform_driver_unregister(&vmbus_platform_driver);
>  }
>=20
>=20
> --
> 2.25.1

