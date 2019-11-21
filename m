Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06151048B4
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2019 03:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKUCr1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 21:47:27 -0500
Received: from mail-eopbgr1310131.outbound.protection.outlook.com ([40.107.131.131]:2389
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfKUCr0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 21:47:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR2WqiHncsAYhRXUgl+WNnYzxvu7211H2O8lbaA8j25/+9nI0tewL7GvIWwUevbFOOwMnFuii173YnPrFQJagM2weJCc6B1kNpfVkNDp+JI1ZNkVASUBIgwaHmu0Y8a48J9AFBQDNE8/XEaNDaVuh4nBhrmR9AdZURxiwKnvPLNMes5kGE7xYP7e1Jvr1uFiV2Y8Ccrc9JTRiRWLHxSTEfryqGKQGuDK7lPsDvih2+wLuKW/M/7vzipV3ptmgHkBBFzqNED/8+io8SK6Pr2T5i4ZnPILjnQBQk/+nxmdX3k0DYzciAiwGnX8Vbs6l19Q+FpA13RwM6HrUIiZwomGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhG3u5uFIBkgXzhDA6J+f1Lj13g1qlp+EQQY5NgoWv4=;
 b=V8MMnx6/o8l3m514t7U4wVhF5YmMmXHHL5/hMP36crhHtZPgKnsj4h2/QqGLP8QPHD9JZgfBssaLTcH8B8yv8Wo/nC32kwrspNzUVsPMbslvHZU2E/tmrq34ZJHV5A7tc3o2IZVmc6Z/RFWdZJv8m0XhVFmfhP813TpRhLGJkKudoXPrLs/DUvMIhCBl97JRSbFet9AFCaTpqJ3ZDuqXWAaW6Or5OKQFGrAoCWjhyXP75alJ1XXZdiVXg5vgFCqKXHb5H3kGW+A9myzv7rtENLz4JRhc3Dsi4YUlxnL6EQcqcbzAj6/+ySJH7oklc1ZqA27oA/LdOeP6SZpd8dqzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhG3u5uFIBkgXzhDA6J+f1Lj13g1qlp+EQQY5NgoWv4=;
 b=ejsEFJ+Sj+ovMvyDBBKv4ELgxTuaHoJEQ6ljEGQcRyKRhPep//OXJHHXE2jy6DQBcQ+HbPBzX8B9Bz7I8E2Ne0q6Rtq3kGM/0/T8XThX4jY6vJ6ppz5rD9qxOf26LXqIa7Xvyf8Iom63FfaWGahcT0aomI4/BvgtADK4LZ+jQjs=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Thu, 21 Nov 2019 02:47:17 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2495.010; Thu, 21 Nov 2019
 02:47:17 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH] video: hyperv_fb: Fix hibernation for the deferred IO
 feature
Thread-Topic: [PATCH] video: hyperv_fb: Fix hibernation for the deferred IO
 feature
Thread-Index: AQHVn3IaBpxutL9CjUq7Dxtj1Of6aKeU7Drw
Date:   Thu, 21 Nov 2019 02:47:17 +0000
Message-ID: <PU1P153MB01699A8B75901F896F1E4503BB4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1574234028-48574-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234028-48574-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=weh@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-21T02:47:14.6204741Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e51bbfc-6a79-4f24-a8ad-0c7f07e32939;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.233.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 001c367f-1a7a-4580-27d3-08d76e2d1f83
x-ms-traffictypediagnostic: PU1P153MB0140:|PU1P153MB0140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0140FD7265CA0524D11E5E31BB4E0@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(13464003)(76116006)(66446008)(64756008)(33656002)(7696005)(10090500001)(76176011)(3846002)(6506007)(1511001)(8990500004)(53546011)(71200400001)(6116002)(71190400001)(8676002)(66066001)(6246003)(305945005)(2201001)(6636002)(7736002)(229853002)(99286004)(26005)(74316002)(6436002)(110136005)(52536014)(478600001)(966005)(25786009)(10290500003)(9686003)(14454004)(2906002)(86362001)(186003)(102836004)(55016002)(81166006)(476003)(11346002)(8936002)(2501003)(14444005)(256004)(5660300002)(316002)(81156014)(66476007)(66946007)(446003)(486006)(22452003)(66556008)(6306002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMl0iMpsWsM+xYs/hUOBop2wo50ifZYrGPAPFCqZWUdPAbNurvX3b//JL3PFP9Fy9sUSzlC+ZQZ6pEVpp/z0Ca4NdzHBklu0Z3ehC/ziqH+EIhdHegPKmDCuMVPqlQ4dP++YDKOhO2akHsDiqfiBQfpxo3ZYx5tGj8cmTzZdovf3gSMgS/WRH9nbNbPRr3C5T9h7Tq+13nXg8h2rRaAwUV79kRWLxbn/zdBqnSUGG4UpRqb9s4mD8z4pXrJ5rLAKnJUDIMTHB396Jedtm56I0OoixFWxl5QhhBoz3HdDYa7tdhR/m6ePWL+fV94um4WyIQHGqbM19hvfZT+M/mIui5Aaw7FC8J6DwjK+1/7sbRNPZNeacgjcNjx1iQoZIpcf4G2N1iosYcZLxaq23nqb8T5yomfty4RMtR29tRsJZgyoqb4Bkt8oFTKt0jWPNWZ1sAy1t7KDr1OlxJH2Nq8qQPV2C5soJGjSAze//KPfl1A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c367f-1a7a-4580-27d3-08d76e2d1f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 02:47:17.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZfHwwLxt8mwTWUUv2vTAyA5wgyzITXF1ypleNuZNxROYy10E6XLtSRcC2EP37VgezxgZnkXBL4tJFxvflsqXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, November 20, 2019 3:14 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> sashal@kernel.org; b.zolnierkie@samsung.com; linux-hyperv@vger.kernel.org=
;
> dri-devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>; Sasha Le=
vin
> <Alexander.Levin@microsoft.com>
> Cc: Wei Hu <weh@microsoft.com>; Dexuan Cui <decui@microsoft.com>
> Subject: [PATCH] video: hyperv_fb: Fix hibernation for the deferred IO fe=
ature
>=20
> fb_deferred_io_work() can access the vmbus ringbuffer by calling
> fbdefio->deferred_io() -> synthvid_deferred_io() -> synthvid_update().
>=20
> Because the vmbus ringbuffer is inaccessible between hvfb_suspend() and
> hvfb_resume(), we must cancel info->deferred_work before calling
> vmbus_close() and then reschedule it after we reopen the channel in
> hvfb_resume().
>=20
> Fixes: a4ddb11d297e ("video: hyperv: hyperv_fb: Support deferred IO for
> Hyper-V frame buffer driver")
> Fixes: 824946a8b6fb ("video: hyperv_fb: Add the support of hibernation")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> This patch fixes the 2 aforementioned patches on Sasha Levin's Hyper-V tr=
ee's
> hyperv-next branch:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhyperv%2Flinux.git%2Flog
> %2F%3Fh%3Dhyperv-
> next&amp;data=3D02%7C01%7Cweh%40microsoft.com%7C451143ff78f04401d9
> 6f08d76d893a84%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637
> 098308493217121&amp;sdata=3DP2fo%2F1TJUMIj5FtJCOp2QwDrghhVfPSCEJ4f1
> vkOXvI%3D&amp;reserved=3D0
>=20
> The 2 aforementioned patches have not appeared in the mainline yet, so pl=
ease
> pick up this patch onto he same hyperv-next branch.
>=20
>  drivers/video/fbdev/hyperv_fb.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv=
_fb.c
> index 4cd27e5172a1..08bc0dfb5ce7 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1194,6 +1194,7 @@ static int hvfb_suspend(struct hv_device *hdev)
>  	fb_set_suspend(info, 1);
>=20
>  	cancel_delayed_work_sync(&par->dwork);
> +	cancel_delayed_work_sync(&info->deferred_work);
>=20
>  	par->update_saved =3D par->update;
>  	par->update =3D false;
> @@ -1227,6 +1228,7 @@ static int hvfb_resume(struct hv_device *hdev)
>  	par->fb_ready =3D true;
>  	par->update =3D par->update_saved;
>=20
> +	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
>  	schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
>=20
>  	/* 0 means do resume */
> --
> 2.19.1

Signed-off-by: Wei Hu <weh@microsoft.com>
