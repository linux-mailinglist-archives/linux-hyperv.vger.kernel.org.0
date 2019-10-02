Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53055C48D8
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Oct 2019 09:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfJBHxM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Oct 2019 03:53:12 -0400
Received: from mail-eopbgr1320127.outbound.protection.outlook.com ([40.107.132.127]:45664
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJBHxM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Oct 2019 03:53:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IblUSxUBtvMvaoOKBnbOKPBb4qBtRnrE59T27aTmxIlF/d3Ni//S2a/oeEjM4M82Cm5uKpffKcspo8ZiMbZRUHl62DSPXI9Cj+XKTNoA5jqIWhjX8h7RA69Jh4jraJi6+Jm4D3IPboloW6qAUMS5hdeu5mrfOCtS2im/Ba24iKqVAXYAscICOJcRojWguUCD+dxBKX4OiDKcs9DWsBf+mSDUT8HfIoHvLTY5EAof131NpoP5RLksvELYr7wvc0R7A40W8Kbg5kNjw1aDVlAV9JVdUaWr1DHRdQ9OmGgBEZnnMqTRuoGskzqsqrebr1RtuB6C4sbYcPOBuAcIoXOfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXDa3z7CtxUM0rT/KWg5xdmUMq6f1lZL1bcExHOoPkk=;
 b=n0E6xHgTabBo9sytKmU50Nt/cdTEQuR0CQ5bwhcyi9O10ZF85WBaJXJRxacmMedUxqAkAmZbnfd9wJB29t6U6ZvV7YwVPox5nyNET0Tkm65Sz0aARSy6W+s5WSgjQtXXcuAfVOeW/kRiieH0FSesULM3/jsOUWAAezsNP1YyBGqobo0w6M2pe9EZTDwzhcWtVwECgPx2IXyC7w5t5wvbOJSWAK6myYF/KXkSGZST3X49/0GwiKllV8UPwrrPsnuKBaF/4Uiw+9Od0XPF93NVF1lA0ezAkKzb99FaEAOl/ySN4V7pT9oYBSosIL0FU+tAm2VcPGn659WPCM4Bw/3Q6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXDa3z7CtxUM0rT/KWg5xdmUMq6f1lZL1bcExHOoPkk=;
 b=I4sE+0YQOxQ6S+JXHL+lLFHzscByD3bWbRxeC5B6um7Gh8eqS5wyQnyf8ugNez9bYVpspDQU4trmn+bsORzBUuhfYmmoJZywrFKEF3H6PA79e5IXN30aH+YH5UeTwbFwq9n/Y3D/61gaHMmIW+1CT42CPk9f8mXSH1/DnxBv3lU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.6; Wed, 2 Oct 2019 07:52:27 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Wed, 2 Oct 2019
 07:52:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>, Wei Hu <weh@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
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
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Topic: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVeIhjL2AndauzGUaHnigxWapFw6dG+x3A
Date:   Wed, 2 Oct 2019 07:52:27 +0000
Message-ID: <PU1P153MB0169724E7E7432F1100EE96ABF9C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190913060209.3604-1-weh@microsoft.com>
 <20191001184526.GE8171@sasha-vm>
In-Reply-To: <20191001184526.GE8171@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-02T07:52:24.4667624Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=547f0316-4218-4dff-a043-6acef2fda046;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:24b0:cdff:a7c5:c70f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ddb93dd-ff4c-4817-4f16-08d7470d785e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0155:|PU1P153MB0155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB015560A70E66A6DB5323DBAABF9C0@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(55016002)(2906002)(22452003)(316002)(10290500003)(6506007)(53546011)(305945005)(7736002)(102836004)(33656002)(10090500001)(54906003)(4326008)(52536014)(7416002)(71200400001)(110136005)(71190400001)(8990500004)(5660300002)(186003)(1511001)(14454004)(25786009)(6436002)(14444005)(81166006)(229853002)(8936002)(8676002)(81156014)(256004)(76176011)(476003)(107886003)(6636002)(486006)(86362001)(74316002)(478600001)(66446008)(76116006)(9686003)(6116002)(64756008)(66556008)(66476007)(66946007)(46003)(99286004)(6246003)(11346002)(446003)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mM/Ca0HXHoT5UU4mA4rQPX099PlOd+8hm2k4TvZxjEp9/PBGWed3MtI4YFlTV49rqAx449pMH61ntS+upZgSSRjUS9MUD3iZdJhCxFGEsbYI32PHH3+0wpfFV5yCvbgwu+BDS+MFAIfUX3c3aISv4rXCz1sG0vbMUQ1XshxI/J5va5isvkrAF8tpjaB/73ER1E9uKaLkhGssMhYRJ3+gPvZoB714YSEFkv7JZWwzpAuCUfBIMIIMC6XdBPTqxMdXpIbVXJifjp9BvadnSIwR8HsFY3gw9roD4tj3lTuSjTP4bNZuRgOmpDb4XMKywOYBjk0os86EIvsFs3aE+P7l1bj5tlWbeEb5QH4SXSVoSu3QxU/mKynoyPDEEzlhlOSRUbhhcddFkTQHaeJlPQ2BAboHVP5ygWpbHPT0Hx58kAs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddb93dd-ff4c-4817-4f16-08d7470d785e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 07:52:27.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0axoKhLk+q2SVIQHMNQEKEPlRgotOGo0gjgNh9Y+iJE2hCN6KQLFLXouY9uLUmoDXzg3/QOEfDKi0qSIFpWbUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Tuesday, October 1, 2019 11:45 AM
> To: Wei Hu <weh@microsoft.com>
>=20
> On Fri, Sep 13, 2019 at 06:02:55AM +0000, Wei Hu wrote:
> >Without deferred IO support, hyperv_fb driver informs the host to refres=
h
> >the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter the=
re
> >is screen update or not. This patch supports deferred IO for screens in
> >graphics mode and also enables the frame buffer on-demand refresh. The
> >highest refresh rate is still set at 20Hz.
> >
> >Currently Hyper-V only takes a physical address from guest as the starti=
ng
> >address of frame buffer. This implies the guest must allocate contiguous
> >physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> >accept address from MMIO region as frame buffer address. Due to these
> >limitations on Hyper-V host, we keep a shadow copy of frame buffer
> >in the guest. This means one more copy of the dirty rectangle inside
> >guest when doing the on-demand refresh. This can be optimized in the
> >future with help from host. For now the host performance gain from defer=
red
> >IO outweighs the shadow copy impact in the guest.
> >
> >Signed-off-by: Wei Hu <weh@microsoft.com>
>=20
> What tree is this based on? I can't get it to apply.
>=20
> Thanks,
> Sasha

Please use Wei's v6 patch, which can apply on today's hyperv/linux.git/s hy=
perv-next branch.

Thanks,
-- Dexuan
