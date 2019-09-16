Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A13B4377
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Sep 2019 23:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfIPVqq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Sep 2019 17:46:46 -0400
Received: from mail-eopbgr1310090.outbound.protection.outlook.com ([40.107.131.90]:18560
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfIPVqq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Sep 2019 17:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHX/HT8PfiRc1W7hPZGfjpfPPSxQP7GLA8+dRTv5LnzpTATHzVS9H6y3flm/9RGyk80IpR3/jWv7EaQGX9Tdq9A5U7fUVtwBzpQmRv+ltwUezDCX562DxTMjmoJijhoi5sdYlEwgD0yi/U1cJeNLdf4tCH98S9gDHDd4QHp1SMbWFehw9KTurHhcQGg9srNeZX/Kf0Ycg4WSSyPbF5JAM5BfVG2i0fs5N2wEPMmv0EC5ifV6Xrui+lbUE2yE5rvXTSOpqbXO8mznk7pAaa+HfJp0ZYW2bMmSC+cm1i+R7dD4J95zNnePnWxzloyrKrJphKucLXL3G3yZ3ecCsHWycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZrfhKH5K2D4QgBlCAvCP6kIBGUu3MWa/oEZXYyU5XE=;
 b=KM/AfNai6XJoxKmrjNcaqWExdR7ggPgi97D48FwYswS6iZuHgkhNQ168rx63iI4HEwj4iFwBken9fiyngzP1p/PC1snubO5eCBh1Ov9hRoC+KW5k5UeSk3uWHtFztizAlqRDBbh/swsW30k0qvyKvMsLzz5754DWJIUH4tbfdPDRGpy4cjcSyK0WKLBZ+VNdEVBo14GDw0gDuA3MZdmerUVwdU8CvwZCCkiUt5nEwruzEk6zzctUqZtsFjesEthKHq35vckuAo1MVll9kQAX+ddjObxU8wyhZZgoS2W1S2K4v58GhCbW0SK24a4SyVUkIowniPJpQuriPulVO7aoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZrfhKH5K2D4QgBlCAvCP6kIBGUu3MWa/oEZXYyU5XE=;
 b=huYHTmGJKOfIsyKN30murd2e8ROxPO9VeMx2523dThOGU2KiCH4nDCItNEaarX5ta4RFk2wEfeQWomSyZ5C+RrfaKltHu+IUTmNnmXAnUOAfblX8j0bSUyIRBijzQxtDYvxT6AfIM/z0m9eAzVwSXkB8Q9IX8AfF5TFfrnBk+GU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Mon, 16 Sep 2019 21:46:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%8]) with mapi id 15.20.2305.000; Mon, 16 Sep 2019
 21:46:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>, Wei Hu <weh@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
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
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Topic: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVafjiL2AndauzGUaHnigxWapFw6cpJzCwgAW1MOA=
Date:   Mon, 16 Sep 2019 21:46:35 +0000
Message-ID: <PU1P153MB0169C4B30F86AE8B652A575CBF8C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190913060209.3604-1-weh@microsoft.com>
 <PU1P153MB0169E5E73D258A034B4869DCBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169E5E73D258A034B4869DCBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-13T06:37:36.0011933Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d71db6b2-3d7b-491a-98c9-03546d3c3e58;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:58f6:aea4:93d:b127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 795de931-06f2-49bd-57e3-08d73aef592b
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0201:|PU1P153MB0201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB020109B3FCFB04E882C35B1BBF8C0@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(13464003)(189003)(199004)(66946007)(2501003)(478600001)(8990500004)(6636002)(8676002)(305945005)(7736002)(74316002)(6436002)(10090500001)(1250700005)(53936002)(55016002)(22452003)(486006)(2906002)(81166006)(229853002)(14444005)(256004)(8936002)(6116002)(476003)(46003)(446003)(11346002)(52536014)(25786009)(76116006)(186003)(14454004)(81156014)(6246003)(9686003)(110136005)(71190400001)(71200400001)(316002)(7696005)(2201001)(86362001)(7416002)(33656002)(10290500003)(5660300002)(66446008)(64756008)(66556008)(66476007)(6506007)(76176011)(102836004)(99286004)(53546011)(1511001)(241875001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfWMvDSHcfjqDW+II0zqnWUNPmCrHe9B8PnpMk64+0MRiKlopGtSyuT4A8xjVHtSzLpmVKDj/wyFLq6itAREMi46XZkDQ+97QsyQ9otHrtW4d4H9fI52qvfRsTI7ga+VeagbRn8doTqEvsgukvHZ3eTVdsuRh55KyWm45jg3mBevaoq7H+90skvgKD6SU1h3PS5eXtgvRTWGTVVVEGEqO9dIR6Vnpm1R62lOZWuNxO8AgdL2yeVFkg8vo4NEfKY6wUTUVipqIniipJ8FTxPQcD4i+ZgxBS37qBTJZaAJ9w8FrICdMhI/PTtxnE2XrEO8hjAFzbQltdJ9ujr59BCt1fx+7r4ODvr39rodzfnXrhnLgIKcX/49CrULO2anwtti1UM+YUH0JgC+4S3hBea/o+E/++ZBdKW3FOPA+lTnCgM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795de931-06f2-49bd-57e3-08d73aef592b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 21:46:35.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCMS989hu3Wt3OAt/8pn78Ohh9SoSHD5HcDrOh14Fx2diRbhtW6Trk3UZsghO/tOMA9MhDhTgn8hdnMhdzgtFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Thanks,
-- Dexuan

> -----Original Message-----
> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
> Sent: Thursday, September 12, 2019 11:38 PM
> To: Wei Hu <weh@microsoft.com>; Michael Kelley <mikelley@microsoft.com>;
> rdunlap@infradead.org; shc_work@mail.ru; gregkh@linuxfoundation.org;
> lee.jones@linaro.org; alexandre.belloni@bootlin.com;
> baijiaju1990@gmail.com; fthain@telegraphics.com.au; info@metux.net;
> linux-hyperv@vger.kernel.org; dri-devel@lists.freedesktop.org;
> linux-fbdev@vger.kernel.org; linux-kernel@vger.kernel.org; sashal@kernel.=
org;
> Stephen Hemminger <sthemmin@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Subject: RE: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for
> Hyper-V frame buffer driver
>=20
> > From: Wei Hu <weh@microsoft.com>
> > Sent: Thursday, September 12, 2019 11:03 PM
> >
> > Without deferred IO support, hyperv_fb driver informs the host to refre=
sh
> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter th=
ere
> > is screen update or not. This patch supports deferred IO for screens in
> > graphics mode and also enables the frame buffer on-demand refresh. The
> > highest refresh rate is still set at 20Hz.
> >
> > Currently Hyper-V only takes a physical address from guest as the start=
ing
> > address of frame buffer. This implies the guest must allocate contiguou=
s
> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> > accept address from MMIO region as frame buffer address. Due to these
> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
> > in the guest. This means one more copy of the dirty rectangle inside
> > guest when doing the on-demand refresh. This can be optimized in the
> > future with help from host. For now the host performance gain from defe=
rred
> > IO outweighs the shadow copy impact in the guest.
> >
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >     v2: Incorporated review comments from Michael Kelley
> >     - Increased dirty rectangle by one row in deferred IO case when sen=
ding
> >     to Hyper-V.
> >     - Corrected the dirty rectangle size in the text mode.
> >     - Added more comments.
> >     - Other minor code cleanups.
> >
> >     v3: Incorporated more review comments
> >     - Removed a few unnecessary variable tests
> >
> >     v4: Incorporated test and review feedback from Dexuan Cui
> >     - Not disable interrupt while acquiring docopy_lock in
> >       hvfb_update_work(). This avoids significant bootup delay in
> >       large vCPU count VMs.
> >
> >     v5: Completely remove the unnecessary docopy_lock after discussing
> >     with Dexuan Cui.
>=20
> Thanks! Looks good to me.
>=20
> Reviewed-by: Dexuan Cui <decui@microsoft.com>


Hi Wei,
It turns out we need to make a further fix. :-)

The patch forgets to take par->update into consideration.

When the VM Connection window is closed (or minimized?),
the host sends a message to the guest, and the guest sets
par->update to false in synthvid_recv_sub().

If par->update is false, the guest doesn't need to call
synthvid_update().

Thanks,
-- Dexuan
