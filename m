Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173FEB6F0C
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2019 23:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbfIRVsI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Sep 2019 17:48:08 -0400
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:47135
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388161AbfIRVsI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Sep 2019 17:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eamRKjM9p6R6x/ocL6svpEpg2MI6IzkIimcPFJjWWVmvWslrjKWyTr5PIPFy+KaE7AwgDpTBRrjHaeAkhOpcTj25vUBLfetQXWJQLb+fG6a/GLeYTw2rEqLckbwx+LQMC/R/wdgD1DYWlP16nVy/R/VeDAmS8hj8jooVQU79oVcZUolHI45d7qY8e8hEuyQ/v0+ikNpF0IhEyi8cuKjUusXVkz85yb0ghPSnylIJwWTLorwAV+UqyiEVskIOv4NdgOgN2nYsetPd4EzNu81OeAN5AVA6dysBIuZMq1DWSlPdRgCdjQYv4I1zcAoxpDdc4QGkQL1sGWrnvaD7AXMhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh2FKCWSuEotyGTjypH6Zue2u5Zb4sbK9lTKeZQriB0=;
 b=oNBjlHraF1M8f+yKegbueiktpqh1l6/aR++mpsY7V4PPaaR3Bk5xkw1KfkQW0Xg9RzxzuLkw+f4YTi9egI4UHSoWuYVhfaFB7m0QqXrfYNENoA+7NFDGf1ZVLssJiUkHMAjSa/LNa8HQosG462LVFGMMCguPoidGS5ZUaWjGS9IdAoZ8H9L18vI6KRrkqZiTUq7cyKu8AS3hECbZjwFbzIn1almGt4WyqM8heDigmfSf3z+nagB1S4vw/yWS5UPcuX63SBZPFYPTr/sp/LIOo2TFsa2mYbOmTepgTYptUIs5kPXKO7cZn3KNB8MFZPltalXSoGI94k+w79eCwIofmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh2FKCWSuEotyGTjypH6Zue2u5Zb4sbK9lTKeZQriB0=;
 b=JRFpkB4oc6BpPER98wftqf4VuUGJUUnwEfKr0x14fvqgWG5KJS6CD4Z141Qbu0P8wNYoJyjgUZuAUJ0OWI5SXQvNcUG2+WHO9VnsltbB3KF44xfyWT0m3q9IDwUcTxr/9FhTtTRyYRM5G5apNechKFrZatgUcJShiQSCUzDuL1k=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0826.namprd21.prod.outlook.com (10.173.172.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 18 Sep 2019 21:48:04 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::7d6d:e809:21df:d028%9]) with mapi id 15.20.2284.008; Wed, 18 Sep 2019
 21:48:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "info@metux.net" <info@metux.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Topic: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVbebF21J2EyXx3k2x6FCXKaeI5qcx+W9w
Date:   Wed, 18 Sep 2019 21:48:04 +0000
Message-ID: <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190918060227.6834-1-weh@microsoft.com>
In-Reply-To: <20190918060227.6834-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-18T21:48:02.5575555Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=30212914-bdb7-4059-a1ca-460e579deda0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:99c:b2aa:3faf:294b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af0721b1-4e76-444e-c912-08d73c81e27f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0826;
x-ms-traffictypediagnostic: DM5PR21MB0826:|DM5PR21MB0826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB082626F3B24E7AFB92B9B605D78E0@DM5PR21MB0826.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(86362001)(22452003)(6436002)(10290500003)(25786009)(9686003)(7736002)(1250700005)(478600001)(14454004)(81166006)(33656002)(6246003)(8936002)(8676002)(99286004)(6116002)(6636002)(10090500001)(81156014)(6506007)(55016002)(229853002)(8990500004)(2906002)(102836004)(110136005)(2201001)(446003)(71190400001)(71200400001)(486006)(316002)(76176011)(305945005)(186003)(1511001)(52536014)(46003)(66446008)(7696005)(66476007)(256004)(66556008)(74316002)(64756008)(76116006)(5660300002)(7416002)(476003)(2501003)(14444005)(11346002)(66946007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0826;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CqlHd7YfQxYgobyBxK4n5dR0c9j7VlKagM30nCliK2YE4e9jG5Pt9+vUNhmxGmC/5AttWkTW09MKpEb1C2mX7lrWmd+PhIpF6e5SmfgB/gpIUW3bDS20Rc7dxymtkyvS4MYhhGfsvQYOzqphUMY/fTf5a1VZz4IAMtnGEeF4i9YNWEEqLsNqiyFa516Jn8HXF6TQGDJWhn7c3GajJVOQJ0ROpD0xTOdVmjxyBQReuaOQrVFbxBR2dciVgvx95gcCvPp+E+bfpOFN090cLngQmJMztJdXWt7ildSWYw5JJEXMmRUSZbFJ21YeLuDJSRFPneIiIrktfZBFJqtGdD85Mm31njP0OCffgrTeT5Od45oLZt2OKnNJ1roJ5su/WvcfhXCdhP/aKm/IPK4aH5FhOcdP7GuFG6PPzaABduwK8Hc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0721b1-4e76-444e-c912-08d73c81e27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 21:48:04.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DbYU6D+hKg7KD5j39PwaiacK18LW7LS8K3NNsTAi4Mjxb2qZAAAD7++KhGVhlBecPs2Z/GfC/5vq7oajS4C2hZOdK39VUsn1AEjQv6B0d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0826
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Tuesday, September 17, 2019 11:03 PM

>=20
> Without deferred IO support, hyperv_fb driver informs the host to refresh
> the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter ther=
e
> is screen update or not. This patch supports deferred IO for screens in
> graphics mode and also enables the frame buffer on-demand refresh. The
> highest refresh rate is still set at 20Hz.
>=20
> Currently Hyper-V only takes a physical address from guest as the startin=
g
> address of frame buffer. This implies the guest must allocate contiguous
> physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> accept address from MMIO region as frame buffer address. Due to these
> limitations on Hyper-V host, we keep a shadow copy of frame buffer
> in the guest. This means one more copy of the dirty rectangle inside
> guest when doing the on-demand refresh. This can be optimized in the
> future with help from host. For now the host performance gain from deferr=
ed
> IO outweighs the shadow copy impact in the guest.
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Incorporated review comments from Michael Kelley
>     - Increased dirty rectangle by one row in deferred IO case when sendi=
ng
>     to Hyper-V.
>     - Corrected the dirty rectangle size in the text mode.
>     - Added more comments.
>     - Other minor code cleanups.
>=20
>     v3: Incorporated more review comments
>     - Removed a few unnecessary variable tests
>=20
>     v4: Incorporated test and review feedback from Dexuan Cui
>     - Not disable interrupt while acquiring docopy_lock in
>       hvfb_update_work(). This avoids significant bootup delay in
>       large vCPU count VMs.
>=20
>     v5: Completely remove the unnecessary docopy_lock after discussing
>     with Dexuan Cui.
>=20
>     v6: Do not request host refresh when the VM guest screen is
>     closed or minimized.
>=20
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 210 ++++++++++++++++++++++++++++----
>  2 files changed, 190 insertions(+), 21 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
