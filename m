Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC913CD7D
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2020 20:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAOTx4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Jan 2020 14:53:56 -0500
Received: from mail-eopbgr1300134.outbound.protection.outlook.com ([40.107.130.134]:11552
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729061AbgAOTxz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Jan 2020 14:53:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1Uv+O4bpGxCIqdVgyV1sRQmY+qrjIn14M5ZVApO7YPoLiUVI23F04pF00f/FyAR/0dvRg8991J2fW7aunRLnat4KD1l+99lAmWmMw2EJrwKc1kcUbPcAevhbV3icotL/nVbDTXoTwn2AdfFknQul52VpgEjl2ajZWviHN12mshaeHsxC3h0Jx5Fsx69BuyRbNlC4ln9LjKbKnFYimSnF6pgZVrgANUSFarfcaF2kcY3rWnBGgk10F0zbAPwwq5uOxwWn4Cd4CFncZDn9A2FQF2fFRi4FozjTzzSWg2IvnBlUdSDtaJnze4HXhbXV8ivY/SJdKCjetNdtx5+ESV/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tze5gmvtgQVHB8B30YoWMLNlORwzHYHbbdBib0AAjlM=;
 b=CUxV9RnzZR14w4k80mgJe7EtDaptLn0YtK2pkurwQ36oOzpAppGc7wU1cCadunyr9AXFBJ2fxQ9cnnRJ9qXNxpBU93+kWeVyeqs1GFv+x0Lsbw00A7WFA883WI97h3nXeXEoDjI1Nfv6jW6i+XBpfRcdRBh03l0Vwq4y1I7d8NXxTBtBHGnBCPLRrMdGDnwwupLZ1PWqV8n6AV6OGOl+LEv+BiNaTivdMTgKt2CNXEaIkhAdVw/N6Fb+vr/Iu/SLhXKxY+7KSBuw1w7NkKjErBsbs/nzBLA8FCTy6GJql6mF/1EipBWdha5DoStRDIys9B/iEweLUuSC509mYXZA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tze5gmvtgQVHB8B30YoWMLNlORwzHYHbbdBib0AAjlM=;
 b=W1taM/GfMCcOF+GkJNfwGMJ6nKvLmRbI6DVvKa8o+Q/luIv5keeiRZB6IpvJB3jPBe4ZXNGL5Zt66Mxks5iaKg7S/wrLGTUgRb9gp0rJtl8eilLHETDq0H62o2UBS+B7tx5yTEcZFZDA0GjjHN1ktHWHKtdNL3Z3621iIer/xPw=
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM (10.170.172.151) by
 KU1P153MB0199.APCP153.PROD.OUTLOOK.COM (10.170.175.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.2; Wed, 15 Jan 2020 19:53:01 +0000
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::8554:391a:5b2f:1d51]) by KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::8554:391a:5b2f:1d51%8]) with mapi id 15.20.2644.014; Wed, 15 Jan 2020
 19:53:01 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of
 hibernation
Thread-Topic: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of
 hibernation
Thread-Index: AQHVyJv2n9lkqyt02Uq48kiJZ1WZDqfsKE6w
Date:   Wed, 15 Jan 2020 19:53:00 +0000
Message-ID: <KU1P153MB01505A56BACA9DA4AF0E7BABBF370@KU1P153MB0150.APCP153.PROD.OUTLOOK.COM>
References: <1578350444-129991-1-git-send-email-decui@microsoft.com>
 <20200111162657.GJ1706@sasha-vm>
In-Reply-To: <20200111162657.GJ1706@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-15T19:52:59.5901958Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9ed1895c-1d7e-4989-a476-4e14ba31c7e4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:ccfa:a1ff:3d4a:ddd8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20e9382a-7060-40dd-cbfb-08d799f48707
x-ms-traffictypediagnostic: KU1P153MB0199:|KU1P153MB0199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1P153MB01998D3D58D7B2DB973849D0BF370@KU1P153MB0199.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(10290500003)(478600001)(186003)(2906002)(6506007)(52536014)(107886003)(53546011)(7696005)(110136005)(5660300002)(4326008)(71200400001)(8990500004)(76116006)(55016002)(966005)(86362001)(33656002)(9686003)(8676002)(66556008)(81156014)(66476007)(64756008)(66946007)(8936002)(81166006)(316002)(54906003)(66446008)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0199;H:KU1P153MB0150.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Te9ut19NDCloWqQbz3zomq6VyRwAcv+17AqDRVqZKgaZNqDiPaa0g+WdMcahQRWjCzEKdbkZyQ5DPr77z2BuD8BMp2TdsYoZlkIjstA23xaflGf4CMNkpmAQ1w20quD/oOZNGprWnKsL8C36dtQWLj6Ejzrz5ZNlwm5utEIVTYCes1+PTvhScz/BCSVaapybBmCLM5IT3KaMS5JKvSEywD7+tgRn9tuICvX1/X+2S2DqV/+9CmEiNVbDhJuxEfl/r2XVXQQfaecT3n8s1eI0V7FGaKX24tRVnZeNJNssXBrLcn+KNM0J875YJBKpMSi14RAhv3aHOK4H8yzSv/NqgZv/z88kufo/Cd9xbYVYEsX53KnO89S06OVnpdPHTcBWK2AKNanNmlsezcTx02Gc456iTg1mS5K+VXaoMbREeolLXopmbx1xpo9tQyrp7Cjj9BJ+jpsten7lUe1TE8p9FdH2UT3PoX2j+9s5yK6Dgcm2Vl2fd5wdsN5TEjqCxCrgd64EDqjbhe+cHKqxOzLGhQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e9382a-7060-40dd-cbfb-08d799f48707
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 19:53:00.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A70THePywhBsuDIm4PK3Dqs5wX9z5YAcxgiddAVGMOUXpZwG82Ziatcni+W4rx8ZSwoll2C9o1BxZO5VeOhoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0199
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Saturday, January 11, 2020 8:27 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; dmitry.torokhov@gmail.com;
> linux-hyperv@vger.kernel.org; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>;
> Sasha Levin <Alexander.Levin@microsoft.com>
> Subject: Re: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of
> hibernation
>=20
> On Mon, Jan 06, 2020 at 02:40:44PM -0800, Dexuan Cui wrote:
> >Add suspend() and resume() functions so the Hyper-V virtual keyboard
> >can participate in VM hibernation.
> >
> >Note that the keyboard is a "wakeup" device that could abort an in-progr=
ess
> >hibernation if there is keyboard event.  No attempt is made to suppress
> this
> >behavior.  If desired, a sysadmin can disable the keyboard as a wakeup
> device
> >using standard mechanisms such as:
> >
> >echo disabled >
> /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
> >(where XXX is the device's GUID)
> >
> >Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> >Signed-off-by: Dexuan Cui <decui@microsoft.com>
> >---
> >
> >This is a RESEND of
> https://lkml.org/lkml/2019/11/24/115
> >
> >Please review.
> >
> >If it looks good, Sasha Levin, can you please pick it up via the
> >hyperv/linux.git tree, as you did last time for this driver?
>=20
> This will need an ack from the input driver maintainers, unless they
> want to give a blanket ack to this type of patches.
>=20
> --
> Thanks,
> Sasha

Hi Dmitry,
May I have your Acked-by for this patch?

Thanks,
-- Dexuan
