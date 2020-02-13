Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3415BA70
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 09:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgBMIEh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Feb 2020 03:04:37 -0500
Received: from mail-eopbgr1300091.outbound.protection.outlook.com ([40.107.130.91]:47856
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMIEh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Feb 2020 03:04:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPcGZHr6oyB6qnbjImya6h1LHC9gh5vp9fPJa1sDl6WNqsZjhSyyxZKKRZ9V+bo6amrNIw9J8rcZiwSlCVUMdTzwoRLociC3vBAHMjtI+lvsrwbwqw4W2EHbuIpl0kQbRQC9sgKe71/BnUfCgNoI30o0za55pEceJrT1qd4WmYYT6xKi0eP8l9jCeQmL0Sv9CMRn9LwlpSv71iPjw6/0VOqv6+U8DXToR2Nmzs3nzXF0JDEbGej4QeTC0uD41BbRw+GnrZI9kx74mvyZewVM8EAqvLchQnMDFFV8tUiiLfRGk8FxH4JvSlTVVv9gl2YrVkCU1UGZRhrtkeoB+n9aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/mCbT90+5LY4cNeeidnM+EpnH2dFZjdQ1N8cgb1s9E=;
 b=FWvtUOjpFQ6+f2JDunxcuFyBmO035K+nU1xCIz3jfxJFJbsZCiCDpAsGPEAjg0rxXdRdpnvmZL4HOvA+/XURDbmwlSERN36WV0Q/hVXsQq6OtnLUKu+nzrSV47OlFm29l8FBUguWOUNOoK20bZndgwbcIjmTgHPb6tmVmhbC+k0znvUyQOARxKD4AF5ZGrhY6QWkhvKhjcSvCsmnjFZjoAtDSV/l/LENwHrA/4Nng7sthQSj1Fs5Cxei264RCGUD16rCszbPLXCNurUkPrqM0rSK0ruYznWNgB3iW9ur1ZEXN7/+2A1d1yYn086wlmNTyg/1pS0eItH78DiLWunqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/mCbT90+5LY4cNeeidnM+EpnH2dFZjdQ1N8cgb1s9E=;
 b=LPFbgF0sQHH4PvpbH45g8nuoYjapIXfgJ/vsh9jrdckL8Z8+UdLp005P99YwmQNuZpweQNGK4EPfkPE2IH9nc3aNRaL6BTu+IPucfYRfnvGI8bO4b3LfQVD+fI9a+A2lHQSiQkdZPArdgWNjydGmbGXhIT075IsxyE5qhpUDSP8=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0115.APCP153.PROD.OUTLOOK.COM (52.133.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.2; Thu, 13 Feb 2020 08:04:26 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%5]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 08:04:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: RE: [PATCH v3 2/3] PCI: hv: Move retarget related structures into
 tlfs header
Thread-Topic: [PATCH v3 2/3] PCI: hv: Move retarget related structures into
 tlfs header
Thread-Index: AQHV38PcCYEihm8LGkypLG2suczj/6gYgpLQgAA7r4CAAApnoA==
Date:   Thu, 13 Feb 2020 08:04:25 +0000
Message-ID: <HK0P153MB01481E6561405D6B5C71A226BF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200210033953.99692-3-boqun.feng@gmail.com>
 <HK0P153MB01481A125819FC7660E067AFBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <20200213072623.GE69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
In-Reply-To: <20200213072623.GE69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-13T08:04:23.2575250Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8089e645-e97a-4ed7-b369-01c5ca63b1d0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:c129:4d3:3571:d407]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bac1703-98c0-4a16-65b7-08d7b05b5817
x-ms-traffictypediagnostic: HK0P153MB0115:|HK0P153MB0115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0115428001D3A413EA49965FBF1A0@HK0P153MB0115.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(478600001)(10290500003)(4326008)(71200400001)(66476007)(76116006)(66946007)(86362001)(66446008)(64756008)(66556008)(52536014)(5660300002)(4744005)(81166006)(81156014)(316002)(54906003)(8990500004)(8936002)(8676002)(2906002)(33656002)(6916009)(186003)(9686003)(7416002)(6506007)(7696005)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0115;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XjGX6Nhge5pBzP2Tx+7UHLieYvKkTGbqlFuX4bRGKL4ISBsRpwnHtRVvHbcZao1Rlgc8T3vaTH2mFRbWye8ynSD74gvCMLmC7kJlsay5yMgTE0AOYg7NUGUTR9n1mZrEYQYz60T4eBTDYyFrx2M9vT4ap59nrjaaGUbX26yDD42yPdK+HfheEcU6Lnd1LFhZfjHgYE02A1mZf21XsIS1p0prkSCPEuxacBnJcXTebrs223iWihV7Qk7vn7ljo7i7+YUjp9ukk6S7vLPLr0EwG2uZJnwSoSyf38w77iyqqOV6hRmHiz7sX5aquvN/9KAIZrybmBdpKz1u8Ei2Zu3Q5RgDoSEeuqCFyhbyOfrz3NFv5cz3pkmxRoctRhx3honFru5KgAwB3MTpCS2btWsdQteJOM6DDO5iUObFILwINc02PqWT+SLffkw6s7zKvUW7
x-ms-exchange-antispam-messagedata: rTVynAoEWoDIYdySJET6RUiP791EOtbbKgP4jtWWtHHvkQL/eh9XY0kRZj5+TPVR4OViADtokvKmbcYk+MvepV52tONhcCy+/kZD7qO1ZiwjcbS86kMQIoe+Jmt/6HXTpIsXt2eGumNS3o6ufhQRhqdBbf5pPUIfTzPzjjXunNH1sSbFEPNO9f2I1s+DXPGZ8ligwMtc/tWcPkIzWHp5JQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bac1703-98c0-4a16-65b7-08d7b05b5817
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 08:04:25.8467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTuuPzr+QtLwm7XbzT/F8hVI8WF8sJXtveOxcL5wJRG0LqjJnyVV+8q51umq7dE7aQJrno7v7jzAv9Dmjp8F4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0115
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Boqun Feng <boqun.feng@gmail.com>
> Sent: Wednesday, February 12, 2020 11:26 PM
>=20
> > Just a small thing: would it be slightly better if we change the name
> > in the above line to HVCALL_RETARGET_INTERRUPT ?
> >
> > HVCALL_RETARGET_INTERRUPT is a define, so it may help to locate the
> > actual value of the define here. And, HVCALL_RETARGET_INTERRUPT is
> > used several times in the patchset so IMO we'd better always use
> > the same name.
>=20
> This might be a good suggestion, however, throughout the TLFS header,
> camel case is more commonly used for referencing hypercall. For example:
>=20
> 	/* HvCallSendSyntheticClusterIpi hypercall */
>=20
> So I think it's better to let it as it is for this patch, and later on,
> if we reach a consensus, we can convert the names all together.
>=20
> Thoughts?
>=20
> Regards,
> Boqun

Makes sense to me. Thanks for the explanation!

Thanks,
-- Dexuan
