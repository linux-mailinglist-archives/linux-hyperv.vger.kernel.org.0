Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268782B864D
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 22:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKRVKV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 16:10:21 -0500
Received: from mail-eopbgr760131.outbound.protection.outlook.com ([40.107.76.131]:38374
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgKRVKU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 16:10:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3i0DtaB1vD5p3F4CSuQoagOnWG1x2zUkmOPLVU0JztKcYae+Ic/grNRBD5ZL79LYCrRFQEQgfwdJqCda847boO+si96OP3uvmNorJXdR0QMKoVjre/L6v3wX2z0cpR3V2n1T/jtR/6ueo1VUvT4tuALMAStKnSocc5qPbFJnadU1nKk9XzvbYz83Qi0ErXccAyXNrt+PEzkrvzkboXc9ZQtvk+5dh1V+7xuWrNWfGURqukSfiXLpOaor5sY/IVWjSdbcm0Z1t+WdI9HcUL0DOznwZ08vE9WcRIzpO1kvM0KYz2PARRwcULAWMzJCjY7jvcbZlz6/Mbw9jxB1stNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqpFdQ8mmv4U2nruJICqKoj638bRtARkASq06thBeQc=;
 b=VjvO1QwTPN67Wvd1DUZI6uCygbJWJnJk7rRDHkfIgDSIZd0nleAnTOKrijFL09Wpb+Ds8Se+mcZf2xG3HjVDkdWCFBZpksUbhYDbGUTOK+oFzqQnad0dNfwhGpo9487otAl+I3gUw9ll11Jc3rKptMMj/+0IE/LdQgnRvZt8omA+2P4UV9Er4yO1U4U03RUkbnAOcvg4cq4O93+7kf/n90TJncdSUQvWONMjGL5nQ9v2TBqnuc0jszOp3FI33rDjHLCv1X5Cki76XDnBpqilqnodWsYIJrT0xkzxoqMwt/1nLnPnX9aE/JfUtj986InNMBUllRxEc4Rv/fbl4LRxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqpFdQ8mmv4U2nruJICqKoj638bRtARkASq06thBeQc=;
 b=U+ZD4zTRTiamlKO7NaQJJ+lGW+Gcn6z/7hmsaaC3YQfURr1Vo9QFX7WQyhhgLaxRY0K8RpK/kyj8kNQPa3gZ/Kh1b46N1rqtKdi2cLDdwTLKwpyp/WXL9oEXnFk24UC+1PTUp9GrmEoeDSOOQE7E8UaLs3Oshp+lLrwV0nzFDjU=
Received: from BL0PR2101MB0930.namprd21.prod.outlook.com
 (2603:10b6:207:30::18) by BL0PR2101MB1074.namprd21.prod.outlook.com
 (2603:10b6:207:37::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.4; Wed, 18 Nov
 2020 21:10:14 +0000
Received: from BL0PR2101MB0930.namprd21.prod.outlook.com
 ([fe80::519c:fbb2:7779:ed64]) by BL0PR2101MB0930.namprd21.prod.outlook.com
 ([fe80::519c:fbb2:7779:ed64%9]) with mapi id 15.20.3564.033; Wed, 18 Nov 2020
 21:10:14 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Wei Hu <weh@microsoft.com>
Subject: RE: [PATCH] video: hyperv_fb: Fix the cache type when mapping the
 VRAM
Thread-Topic: [PATCH] video: hyperv_fb: Fix the cache type when mapping the
 VRAM
Thread-Index: AQHWvT5KhwldvT+p4Um7gZbK1gSfZKnOY9TA
Date:   Wed, 18 Nov 2020 21:10:14 +0000
Message-ID: <BL0PR2101MB0930F078E217A251CC0C457ECAE10@BL0PR2101MB0930.namprd21.prod.outlook.com>
References: <20201118000305.24797-1-decui@microsoft.com>
In-Reply-To: <20201118000305.24797-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a2063ea6-8251-4af5-bc46-1f6100d7b0de;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-18T21:09:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [75.100.88.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2b5b725-a294-4baa-b9a9-08d88c0657fc
x-ms-traffictypediagnostic: BL0PR2101MB1074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR2101MB1074D7A81EAFFE7384DE89D5CAE10@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJVDnZikjW5ierNAkJ4y5a+J/oyKT00fRCStxm435GEeeV+TK29iamsCB46iQI8NBz81VcJy2guI8WezzoGZOgn+xm+6gQ9jm5fsA3R52bRyShEHQQWdy3fVEAIvAWHTw25LIJCTnLBrFrJ4rI+uwjsbs9xddWupcnDwDcsU3hbFu58Jmb/YdgfVzKdQOnNxC/gF2olRqsACZQZ2aeCvwdgjUamv7F1ne9NfB8Hb4dY6ffLtcX4Q/GVlrn0lIeG3a/mX5GUC8fPK2VtyMF/VVQQUvaVYjP13arDoAvEBn0FC11WeGb54J3ffS/2zcN8chR34VIvy33mStQoJxhGtCx5aUcxdYDDwouXpSfxX/pu9DdQpw/yNAQzsVw41zI8nT3UWnIm+6dvxASUo6nmRILQZrbeD0GEtYC7yZNlb7SWELL1CAWQEYV0XiuBYkCRP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB0930.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(6636002)(66446008)(71200400001)(55016002)(76116006)(9686003)(86362001)(7696005)(5660300002)(8676002)(83380400001)(2906002)(66556008)(66476007)(4326008)(53546011)(6506007)(110136005)(26005)(33656002)(82960400001)(966005)(478600001)(66946007)(10290500003)(82950400001)(8936002)(316002)(921005)(8990500004)(186003)(64756008)(52536014)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oQ9Zulbgx/rt/z6gBORa2f6cVrfsd1xmAI8GY3iOQPexLNF9gbcXNyNKr+LT?=
 =?us-ascii?Q?2CeBHEj1bKKuy1gpRJq+woBYkmwm68mrFOqtKd18OnPJ63VpZCvxp69o9zW2?=
 =?us-ascii?Q?07IPSF11M3ux9yYlWmOCJH9yUZyp7vVU2EHkKqjGpPB/RfoN3DksoeXsE+pM?=
 =?us-ascii?Q?qQfaNBab548kEo3LC6fRg7UHL/BH+lPs3E1xgV9a0okfxC220D2bQE5zkxL9?=
 =?us-ascii?Q?tmi0MvHZfmh8RSyDKT8q5H91wSZqYwolEKVaIelhco76Ju63e4INpaglwAjn?=
 =?us-ascii?Q?9o0xi8YQjaVPSsoR9tHfHMlkDNl2hP+YyglZlpm1VW3vlft/yWKZD8BqT9nJ?=
 =?us-ascii?Q?0JF5rn+ESCMZWPcebSuS3FLZIgbmSi3OIK8LD7mMxPJDk+px8UPYnUcva5k6?=
 =?us-ascii?Q?kqamtUQWLhYhkmkIabMOt2IlSGb8y/6wRYXeDjBqpyURo3+FCp/0ka+WCgct?=
 =?us-ascii?Q?sq+9rJwTFDb5z5D8GfgxEMlH1VZ8Tn0QF2lZVQFyfSB3NGNQeNbdBbPBZscM?=
 =?us-ascii?Q?0twPdVkt9S0Iojx0Bw5Sm1vS2GIj1/Dwi6tMgnNT3cmFrTnOnWl82MEf5FIP?=
 =?us-ascii?Q?mi8G+4NUfaURUPci5vdfS2oa+RPC69EDYjNCIPRNgFAsEJrbt8FrBfUi+wDj?=
 =?us-ascii?Q?lG9+HkPqgcUp+5CZ19g1s6nyD+PPfWAVmXX21b1JdDg6Ad53/Jil6SWAjOIC?=
 =?us-ascii?Q?MMGmag9H+FNHIqQo7nti/JzoVui4ZZbRP5nv9CbZlYnlcaXprC9SmSk/acJt?=
 =?us-ascii?Q?EX7i2i4IynL5QSXKUaRBBIiZ/NzvlX8n9DDFYh0STphpm9RYY+dKmqZTooL0?=
 =?us-ascii?Q?imnVsJxuZu9aSXWUIAXONb9aUhfLABieu5QJ4xEVD3iRAt9MgDB/4QuI7nRl?=
 =?us-ascii?Q?slCmqNYOae7CboApH9KvQQjbILt7z44RjZ+qg8jersKI+1KpqG70bSQfJb71?=
 =?us-ascii?Q?mVuNDJfBtw39mG8f6P/J0W73OKSznFmIPnrOLr0vras=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB0930.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b5b725-a294-4baa-b9a9-08d88c0657fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 21:10:14.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOBONuGpemogsfeYZoRG3ODQxxOHQsjyVesrpLY7TbyFTHX7MXKUH4Eh1F0BNBQ2waHmgqu895+tfz4dyuxeJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Tuesday, November 17, 2020 7:03 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; wei.liu@kernel.org;
> b.zolnierkie@samsung.com; linux-hyperv@vger.kernel.org; dri-
> devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>
> Cc: Wei Hu <weh@microsoft.com>; Dexuan Cui <decui@microsoft.com>
> Subject: [PATCH] video: hyperv_fb: Fix the cache type when mapping the
> VRAM
>=20
> x86 Hyper-V used to essentially always overwrite the effective cache type=
 of
> guest memory accesses to WB. This was problematic in cases where there is
> a physical device assigned to the VM, since that often requires that the =
VM
> should have control over cache types. Thus, on newer Hyper-V since 2018,
> Hyper-V always honors the VM's cache type, but unexpectedly Linux VM
> users start to complain that Linux VM's VRAM becomes very slow, and it
> turns out that Linux VM should not map the VRAM uncacheable by ioremap().
> Fix this slowness issue by using ioremap_cache().
>=20
> On ARM64, ioremap_cache() is also required as the host also maps the VRAM
> cacheable, otherwise VM Connect can't display properly with ioremap() or
> ioremap_wc().
>=20
> With this change, the VRAM on new Hyper-V is as fast as regular RAM, so i=
t's
> no longer necessary to use the hacks we added to mitigate the slowness, i=
.e.
> we no longer need to allocate physical memory and use it to back up the
> VRAM in Generation-1 VM, and we also no longer need to allocate physical
> memory to back up the framebuffer in a Generation-2 VM and copy the
> framebuffer to the real VRAM. A further big change will address these for
> v5.11.
>=20
> Fixes: 68a2d20b79b1 ("drivers/video: add Hyper-V Synthetic Video Frame
> Buffer Driver")
> Tested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Hi Wei Liu, can you please pick this up into the hyperv/linux.git tree's =
hyperv-
> fixes branch? I really hope this patch can be in v5.10 since it fixes a
> longstanding issue:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2FLIS%2Flis-
> next%2Fissues%2F655&amp;data=3D04%7C01%7Chaiyangz%40microsoft.com%
> 7C7e371bb6f79f41aae12208d88b556c85%7C72f988bf86f141af91ab2d7cd011d
> b47%7C1%7C0%7C637412546297591335%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=3DStqnT%2Fx1XVoVWUZbJz5BNjaCIdtuNmSf2JoyLSt0c%2B
> Q%3D&amp;reserved=3D0
>=20
>  drivers/video/fbdev/hyperv_fb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/hyperv_fb.c
> b/drivers/video/fbdev/hyperv_fb.c index 5bc86f481a78..c8b0ae676809
> 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1093,7 +1093,12 @@ static int hvfb_getmem(struct hv_device *hdev,
> struct fb_info *info)
>  		goto err1;
>  	}
>=20
> -	fb_virt =3D ioremap(par->mem->start, screen_fb_size);
> +	/*
> +	 * Map the VRAM cacheable for performance. This is also required
> for
> +	 * VM Connect to display properly for ARM64 Linux VM, as the host
> also
> +	 * maps the VRAM cacheable.
> +	 */
> +	fb_virt =3D ioremap_cache(par->mem->start, screen_fb_size);
>  	if (!fb_virt)
>  		goto err2;

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thank you!
