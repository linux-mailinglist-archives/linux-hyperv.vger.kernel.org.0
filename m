Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0E15BA78
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 09:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgBMIFY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Feb 2020 03:05:24 -0500
Received: from mail-eopbgr1300133.outbound.protection.outlook.com ([40.107.130.133]:58272
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMIFY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Feb 2020 03:05:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1xgDNZGpi20WKm+fv/U8mBwnZEluyHMjs3Z7en1aikRwXa8gHvxJD94ugfxvrZoDesSW9h7DcWB+g0/mkWm22rmIA2oPzhVWJrsDjlpuy39WHCN0o5lilxh/Gihe3PzuyR436VQCUzc3kTtsNKvS82yWE+zp5fk3+qtCM44ZtaDhsle3jbIVcDBOh32A5NsAT+sb88jebSqpkfsDFM9ZA83VmjoboN9p8iOsAz5RMccvwH6l3rKNqJ89QJGbcurBghZgpfKX32+D9CoEY7FFnf84INB3D8wL/glLKJKN4FqF+QftkSEHdkj7AK2dFYSOPxLrr7Jj1oXsR0e4OmuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSxxQ/8GxlQBsqziWZvDTVuYo6C8cbG0FI/BJ4BTxIA=;
 b=jvt1P3/PwqQH5HbA3pqfjREsECm8bBBy0omLR/EuwbBU+Yj3WPL9BPpQyGhOLrO+gQGsHSzUifNE6ABxpsnFBkcSxPzlj6o146ejTWv0kTraFFfiD5gn4qbvW0hwdwzi22ublRrM2yyQbajTtIaAjyawLeslrJTf7b1PDOXbOe/l3kTQx5cwSvm5MAYNTpd4m9xhkxvm6EKAxPJitoMY7792U2h0KBQY+LkrEJ+jDXsT3YkvSNiRNXGhVOM0wVCfQ2eF4ANmbb7fyhKzvmGYagw9Yx3ZWqnBlDty7chAmEKebFV6mf3ooXeX6AzVG6ximuvDXApltx+bk6pLT2r7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSxxQ/8GxlQBsqziWZvDTVuYo6C8cbG0FI/BJ4BTxIA=;
 b=R1Gv8pFEOkvq9lNTVT8HBOacic+8sRIYb5GYKNDsHeMMaNt4sQUXmiwtnm7KPhnWHpn0r6FWDcbROCcoOr9du9uj19xR6iJpM218nU6L+aR2Scu8YIk8MGf0XbIzzyx3Ft0tRbQH2xwseSM6YNDVdqmsN2Qt1/CAe6GneuP6v4I=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0115.APCP153.PROD.OUTLOOK.COM (52.133.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.2; Thu, 13 Feb 2020 08:05:12 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%5]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 08:05:12 +0000
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
Subject: RE: [PATCH v3 3/3] PCI: hv: Introduce hv_msi_entry
Thread-Topic: [PATCH v3 3/3] PCI: hv: Introduce hv_msi_entry
Thread-Index: AQHV38PZxjAi0xWAZkW4JMZC1Le8B6gYh+3QgAAy54CAAA4VUA==
Date:   Thu, 13 Feb 2020 08:05:12 +0000
Message-ID: <HK0P153MB0148D7765062717B0AE6B4D3BF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200210033953.99692-4-boqun.feng@gmail.com>
 <HK0P153MB0148834D630E95D055CE051CBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <20200213071407.GD69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
In-Reply-To: <20200213071407.GD69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-13T08:05:11.0063302Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=be0e12ed-ec9a-4b73-af28-bf51c564fb77;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:c129:4d3:3571:d407]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a9a73f4-7b13-4307-8b78-08d7b05b73e7
x-ms-traffictypediagnostic: HK0P153MB0115:|HK0P153MB0115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB01153389E8789D1C512D5471BF1A0@HK0P153MB0115.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(478600001)(10290500003)(4326008)(71200400001)(66476007)(76116006)(66946007)(86362001)(66446008)(64756008)(66556008)(52536014)(5660300002)(4744005)(81166006)(81156014)(316002)(54906003)(8990500004)(8936002)(8676002)(2906002)(33656002)(6916009)(186003)(9686003)(7416002)(6506007)(7696005)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0115;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GX8oidkgMYPCMRRv4istMJshhNgzvZyIpNom2vQTvjJLc3Pw1cgk+okLFv6mbE1C2ouV19wCIY0gipTmWdBZwuwvYyi00gEz9ddwy70HyEym0xnl2tE+Bz0p9cp/wfkHVeXTjR+L39+d118UNeZIW7f/uiVvuV11hyaqbRAueBdzgSyN6cu/vBnu4n/vTYxqkipoM6/D87J1mqB2NzORcSvAD7uX1mtLDH88PEZsgxRMLaKvfgvWPCIYm1vZjCfkoTYGcAQOx+/flInzOJ2jhuyFSihGJyt3O+0KfXD5cuX4vmWbYmg4oBAwlP3hcPCMMOwhy5CyxaeSqAt4xsU1AmG37N8p1fG05YDR+qHf3dpGAHlgwhlxye7ljqBFs3HuDQ466zjQLnrz2l0Cf9r+nLhr1rUidsyAvdOsXpGKHiemcpAhfuaEZyu+abmc2DAL
x-ms-exchange-antispam-messagedata: 5C+BnCY3Q+W6KYbBpVg1RgC1+ki8E2XtcuU+tZmElUMOyxfkMKTCelJPRJLqnEMNqgWVjKYXrxTpGwphAPqt3tPKvOP0MxJNM1pVOdCGaWHp41HvG6ag6GNvtuqb9Eh113XQyaltFkCnt3P5Pj6TAlec4qEJptvfTdafc+lqp3GU05ZTPBmsGXvcsiaI8M6CmHnL66nHt+mh//wctNPgFw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9a73f4-7b13-4307-8b78-08d7b05b73e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 08:05:12.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJF+8EeFacBdy4Np+JTT2zLIvRkGJe6tjbmLflz6TaJgagMBOlqro1nKOh5ITwFTQnIhJpHWfNR26iP8yoNmOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0115
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Boqun Feng <boqun.feng@gmail.com>
> Sent: Wednesday, February 12, 2020 11:14 PM
>=20
> On Thu, Feb 13, 2020 at 04:18:01AM +0000, Dexuan Cui wrote:
> > > From: linux-hyperv-owner@vger.kernel.org
> > > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Boqun Feng
> > > diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> > > b/arch/x86/include/asm/hyperv-tlfs.h
> > >
> > > +union hv_msi_entry {
> > > +	u64 as_uint64;
> > > +	struct {
> > > +		u32 address;
> > > +		u32 data;
> > > +	} __packed;
> > > +};
> >
> > Just a small thing: should we move the __packed to after the "}" of
> > the union hv_msi_entry ?
> >
>=20
> Actually, in TLFS header, it's common to put the "__packed" inside the
> union, rather than after the union. It makes sense because union is
> different than struct: the alignment requirement of a union is already
> decided by the "as_*" member, so no need for "__packed" attribute.
>=20
> Regards,
> Boqun

I see. Thanks for the explanation!

Thanks,
-- Dexuan
