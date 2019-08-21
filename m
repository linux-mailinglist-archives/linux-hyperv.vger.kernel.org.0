Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAED9881A
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 01:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfHUXsu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 19:48:50 -0400
Received: from mail-eopbgr710111.outbound.protection.outlook.com ([40.107.71.111]:4938
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728953AbfHUXsu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 19:48:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHDSMZQO1G5dZ4yQA6Sh8/ANo2Lk4SKEDM2GEpmoKth5EnFzJasd6ct5MR2SRxXWXuZNiWa5MKs9rRdiQgvfLSrKYksmJxrMck4LbPk6Ipcj7b3E+W2TYlJZHEV8dM3GxFR1JSlsAbqRzZXHGIux77ugv1hwvv2/L38tbIVjk2wT17jo5OcT7dCoS3zOow+hTfJuC8Cnf4inMOsMwCb0Naf7i0jlA4CalOz7sru56D9sZWyg9gvOfH2YCCHmAwuTY1gtN+7DwzkAQXtfuycT07MW9BcN6SBj5lmonimw8TW0Qk/9Klrmy75GiXPm2zJFVtimacxoGPp8Qog+gBmqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH7nwlM/+hpNx86t26WSXT/zMv7P+jJ+z5xs9EcuC78=;
 b=jeEs4lEyqGWZQ6o/iqH2qp0CI96MVBk0fqf/kkmntHJaoKnI3mHAAYdskSP6xi5t10qQM/GmpYCT7voe3lUR3wYQ/fed/xfWdds8hkvwqQls8qwdXBsbad4Qidf0+nhzFa2vWCoohzEHJoPLrLMkcWfaUs1h/g0ryS7aznqZniXF/dza2Q1Xrq45SJV03oyI4kPFODKrpkPN6HXQMtf+82Pu08daBzaCEtcJN8Nybw/Jg5UF0L87Mvsd+Hae70rfUNpK+f9pz+z3/igniJyANXgSDQeC9Y0mIu0hG99NRI+w4tUNPCGS7zyJr/xEn4/XNMwGlofmsJTwGV8Ubq8YXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH7nwlM/+hpNx86t26WSXT/zMv7P+jJ+z5xs9EcuC78=;
 b=bkgDiLyxMpTOB6LBmmur1oWF3y24ysCkJ42j8SC4434ww6ugSdMJfpB9Yxr55b6nsRAeIe3zq7HH4GMUnpuz5Lw77ksv9aWfkuoL7Uvzdy7lQLWcokaHBf9wuwhNdAAnnwRmh4tRtYVu8dLrc2XT5yba6NLaS/v+4IoAISnrMwY=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0857.namprd21.prod.outlook.com (10.173.172.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Wed, 21 Aug 2019 23:48:42 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Wed, 21 Aug 2019
 23:48:42 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Topic: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Index: AQHVWBETUUvEuW2UmUKx6Ya3YUCalKcGQnDw
Date:   Wed, 21 Aug 2019 23:48:42 +0000
Message-ID: <DM5PR21MB01370CB55C3011582F6F8C5CD7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190821111007.3490-1-weh@microsoft.com>
In-Reply-To: <20190821111007.3490-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-21T23:48:40.2987691Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=61cf0715-0dfe-4344-9bb2-ea23cdedd11a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 140a388a-59ea-4168-5289-08d726921924
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0857;
x-ms-traffictypediagnostic: DM5PR21MB0857:|DM5PR21MB0857:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB08576ABB6735716E6FA4AEE2D7AA0@DM5PR21MB0857.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(6436002)(8990500004)(6506007)(102836004)(14444005)(256004)(81166006)(8936002)(66476007)(71200400001)(71190400001)(26005)(81156014)(229853002)(11346002)(476003)(446003)(486006)(4326008)(53936002)(55016002)(9686003)(66446008)(64756008)(66556008)(186003)(2201001)(86362001)(305945005)(7736002)(74316002)(8676002)(6116002)(1511001)(66066001)(66946007)(76176011)(478600001)(99286004)(76116006)(52536014)(6636002)(5660300002)(10290500003)(107886003)(25786009)(6246003)(2501003)(10090500001)(22452003)(33656002)(14454004)(7696005)(2906002)(3846002)(110136005)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0857;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rz6rdSyrXUzkuL1bD4c60pQVzfEnJ+47poN+A1hgSkB+tJ/yNUFqIoaOMFBuLBhWVUUIkkuOxuL10FPrySO4x+MHVWw++NFvgyviRzNhciXiUUHlCFLQFyZQ2NDtU/D+lT2Go5DkEdNvXESqKBbXfItPSOMQVWnB4jQO0o7rn0q6uW4XDhQdCEVGJWW7gigtMl/yx3Pvqv6VSlfBkK6MBi7x6lXmGNHqfbRDGxpUg/8vpWxVELjCWgtVlDWMa771TEq9jiNLCwNkVKTohvAxe8ONK1okbe9bn9syCTADMRoQ0F4lmYUVoVmxKD4CaPYmq642njkOZBXmRnqVWGo4HRYZKmXm7V5EmlJ3QzfM04qP6Z4tr1Ulqx5W4Ezl1kAU5SraDbnUMuPb7DU2Bvw4L6KAZGawrRaTw8hO7IrYLJk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140a388a-59ea-4168-5289-08d726921924
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 23:48:42.3026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NNVs01E1tOxkXgy7hZhGyBcQf+gaeaKQlHWAcLw6XPPbZFDAXxqEjdoWQi5bYQ8yMA0uFeJoSTJN2cYzXMf/MLRVRUB0dZRj3YTn46ew7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0857
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Wednesday, August 21, 2019 4:11 AM
>=20
> Beginning from Windows 10 RS5+, VM screen resolution is obtained from hos=
t.
> The "video=3Dhyperv_fb" boot time option is not needed, but still can be
> used to overwrite what the host specifies. The VM resolution on the host
> could be set by executing the powershell "set-vmvideo" command.
>=20
> v2:
> - Implemented fallback when version negotiation failed.
> - Defined full size for supported_resolution array.
>=20
> Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: lines should not be added to patches until the reviewer
has actually given a "Reviewed-by:" statement, and I haven't done that
yet. :-)  Such statements are typically not given until review
comments have been addressed and re-reviewed as necessary.

> ---
>  drivers/video/fbdev/hyperv_fb.c | 145 +++++++++++++++++++++++++++++---
>  1 file changed, 133 insertions(+), 12 deletions(-)
>=20
> +
> +struct synthvid_supported_resolution_resp {
> +	u8 edid_block[SYNTHVID_EDID_BLOCK_SIZE];
> +	u8 resolution_count;
> +	u8 default_resolution_index;
> +	u8 is_standard;
> +	struct hvd_screen_info
> +		supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT];

Is there extra whitespace on this line?  Just wondering why it doesn't
line up.

> +} __packed;
> +
> @@ -448,11 +542,27 @@ static int synthvid_connect_vsp(struct hv_device *h=
dev)
>  	}
>=20
>  	/* Negotiate the protocol version with host */
> -	if (vmbus_proto_version =3D=3D VERSION_WS2008 ||
> -	    vmbus_proto_version =3D=3D VERSION_WIN7)
> -		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
> -	else
> +	switch (vmbus_proto_version) {
> +	case VERSION_WIN10:
> +	case VERSION_WIN10_V5:
> +		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
> +		if (!ret)
> +			break;
> +		/* Fallthrough */
> +	case VERSION_WIN8:
> +	case VERSION_WIN8_1:
>  		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
> +		if (!ret)
> +			break;
> +		/* Fallthrough */
> +	case VERSION_WS2008:
> +	case VERSION_WIN7:
> +		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
> +		break;
> +	default:
> +		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
> +		break;

I'm tempted to put "default:" up with VERSION_WIN10 and VERISON_WIN10_V5
so that it can also fallback to earlier versions.  You would have a couple =
of less
lines of code.  But arguably newer versions should always go with
SYNTHVID_VERSION_WIN10 and not fallback.  I don't have a strong opinion
either way.

> +	}
>=20
>  	if (ret) {
>  		pr_err("Synthetic video device version not accepted\n");
> @@ -464,6 +574,12 @@ static int synthvid_connect_vsp(struct hv_device *hd=
ev)
>  	else
>  		screen_depth =3D SYNTHVID_DEPTH_WIN8;
>=20
> +	if (par->synthvid_version >=3D SYNTHVID_VERSION_WIN10) {

Unfortunately, this "greater than" comparison won't work correctly because
the minor version is stored in the high order bits.  Version 4.0 would comp=
are
as less than version 3.5 (which is what SYNTHVID_VERSION_WIN10 is).

> +		ret =3D synthvid_get_supported_resolution(hdev);
> +		if (ret)
> +			pr_info("Failed to get supported resolution from host, use
> default\n");
> +	}
> +
>  	screen_fb_size =3D hdev->channel->offermsg.offer.
>  				mmio_megabytes * 1024 * 1024;
>=20
> @@ -653,6 +769,8 @@ static void hvfb_get_option(struct fb_info *info)
>  	}
>=20
>  	if (x < HVFB_WIDTH_MIN || y < HVFB_HEIGHT_MIN ||
> +	    (par->synthvid_version >=3D SYNTHVID_VERSION_WIN10 &&

Same comparison problem here.

> +	    (x > screen_width_max || y > screen_height_max)) ||
>  	    (par->synthvid_version =3D=3D SYNTHVID_VERSION_WIN8 &&
>  	     x * y * screen_depth / 8 > SYNTHVID_FB_SIZE_WIN8) ||
>  	    (par->synthvid_version =3D=3D SYNTHVID_VERSION_WIN7 &&
> @@ -689,8 +807,12 @@ static int hvfb_getmem(struct hv_device *hdev, struc=
t fb_info
> *info)
>  		}
>=20
>  		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
> -		    pci_resource_len(pdev, 0) < screen_fb_size)
> +		    pci_resource_len(pdev, 0) < screen_fb_size) {
> +			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
> +			       (unsigned long) pci_resource_len(pdev, 0),
> +			       (unsigned long) screen_fb_size);
>  			goto err1;
> +		}

Michael
