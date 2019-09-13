Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6932B1867
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfIMGh5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 02:37:57 -0400
Received: from mail-eopbgr1300120.outbound.protection.outlook.com ([40.107.130.120]:63906
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfIMGh4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 02:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnAwZpsXNZSduj9A978aNxUaI/IKbDWdbSyGFfVmdd3RK2L5sAybDkElEw2jS/5xbeG3CsOWRj7q5Zjaao96UZRZpUbuz263AWydyHtO2B7SZXfZzfriay/fYCarGoZuEcMbx83YyZY7nN455Y+WaRkLTRaerfQRbTtvVGOlAPFrtJBBuqRIOJOzQ0C5+6WCdJkGfYdm/wBW22pCz3GWLfK6Veka3zlHaqc70jAlD/TH2stDL1dFokydCjNOYyh5/cHr7tgtYhAloSnvikIbyK5g9R3OEoTGEX7quFiZPvQA7DjyZrQnJNVpChU+HfO9/PinYAp8/p/HzwcrIiU1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpFQ3fSvlzWzHo6tu36TU5GGCcT5nGwbFPKlmFt9Gnk=;
 b=YbzB4VJFGND6fsfvma3VU0N7kN5sb8D6Uj/wg2jg92SrZ2gnEbMqLc0CNdCJT8ygqYbYha4E/CWWLBU6GMTNGm6hWHR4rhVb2/3VQy1ocrvOy6Db7xrwO9/rPk3vHO6pTVaRce6TBHHyNcUXbAj8pPvjzYjVxKfCr1q8I5IeDJB/NV0WB5MpFI50Kmn4/MJEgiZH+KoJZLS6ES/l6U/jxOrH3wTqLSXl2cL7Xi5O0zf0pmbkkQ/IZzCcjTWhVfel4OT4y5CwQUrq52XBK8Feyxv3vnrXQmVKNG4GO6E5DfEOnt207Adk5dsTNKK6ivts7azi/K77UhEvciguc47dFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpFQ3fSvlzWzHo6tu36TU5GGCcT5nGwbFPKlmFt9Gnk=;
 b=LnqR4bXuUVuIXyL0KiZ8pDcNwsdxkSFfuC9FXx70Cc/g2bDj7dp1MSKrDWtZebQ/+irQLQ7AFwaSgats1Q1Ih27C/OGTT1Gx6okBTTMByeP/LzE5766YfJ8J4CpZAYuYSbgbcxyP1+/ulOeyCqms9GTk0ZZZEREIpVhFMi5DH68=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Fri, 13 Sep 2019 06:37:38 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.007; Fri, 13 Sep 2019
 06:37:38 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
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
Thread-Index: AQHVafjiL2AndauzGUaHnigxWapFw6cpJzCw
Date:   Fri, 13 Sep 2019 06:37:37 +0000
Message-ID: <PU1P153MB0169E5E73D258A034B4869DCBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190913060209.3604-1-weh@microsoft.com>
In-Reply-To: <20190913060209.3604-1-weh@microsoft.com>
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
x-originating-ip: [2601:600:a280:7f70:49e:db48:e427:c2a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bc4b9f3-6785-45b3-0e4f-08d73814df00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:|PU1P153MB0153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01531A845D6660BD7234D85BBFB30@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(14454004)(76176011)(2906002)(55016002)(99286004)(71190400001)(71200400001)(8676002)(81166006)(81156014)(8936002)(6116002)(478600001)(6636002)(9686003)(229853002)(1511001)(25786009)(6436002)(7696005)(2201001)(10290500003)(66476007)(66446008)(64756008)(76116006)(446003)(66946007)(53936002)(110136005)(52536014)(476003)(186003)(8990500004)(6506007)(33656002)(7416002)(102836004)(2501003)(86362001)(6246003)(22452003)(305945005)(7736002)(1250700005)(316002)(10090500001)(46003)(11346002)(5660300002)(14444005)(74316002)(486006)(256004)(66556008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tkAwKpY35VwMxE2f+lhrQUZYpGGUFRPniOiTkDSeSCYKTigqYqUpyJmeLwBqh6riXpINgMOtK/Hbn1FUbYulITzHEjkYlhvUi3iggOiIC0M5vCdOa4NEx6C8NN4uDE88sZr8lTFcEIT19M59jlWW5nTvLVru1D4MKUmjLkSN9NqVnnBbpiL1yTMKlOhep4lTRmX49NJ7YmOCatZwZd/8BScR3R6mKX0ZuQG6Vm1DOFnuQdFLOH3667659BztJfVEXxtIA1sfY5KZjZgXVXJB/J9hJ11W3/l4bUypu0AkvfxYql29C0wFR0uK/QTe8RB2fvuEa/p8q+zfw2tPyLUXyxZbpzHsGM+9sBe43JHgEmzJweq3tEuhZPtQ7/fkuxj8J7YwcIuWr5pJBG+hyebYXFhs617u2BTKu/xvS74HNIw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc4b9f3-6785-45b3-0e4f-08d73814df00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 06:37:38.3391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcgYO0zRAYLzjEersqHT0iE4fIPsOW9ybQm0j1nJX8tKIWbq1sxCb86QOOroHXjMpBrOf62BMCFvRUEuc/VPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Hu <weh@microsoft.com>
> Sent: Thursday, September 12, 2019 11:03 PM
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

Thanks! Looks good to me.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
