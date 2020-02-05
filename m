Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17A81529EF
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2020 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBELdL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Feb 2020 06:33:11 -0500
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:2455
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbgBELdK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Feb 2020 06:33:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9fT/y4a3SjHD7qdyCUkbtzbsrcZQRbp3Y8ZmSyzZkWdrEYg3vELCZDP5IprcHUXoCiWKjaGFLPl8UvowMaZFWoS7ZQNHfFInfUf0vvZ6R/hXyxLlS36JlTpPG/px0vxEQINLE5HpGVaTKiYH3NSQaryZKoRLYeV7rzdcu2ol5njl+n89vqD3zLMoGkNySCPQN+uH4gQQCH9I0lGYOz84d+CnmSqBrtHz429XTVTpEJ7AiYQ2JRc1FEQSKRigA/IKZbYVjCHarUuZaoKPpkfrHPX2CP86Hb2h1vgBAsx0ooLt+Gf+Xt7i4fxVOaOCWmwavz3KXbdzddz89C/CgYcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMEbBptqCNeTqjV8AVAwccmxKiwxRPweZnH6gnX1XU0=;
 b=diJ5CIMA0bebrYz3+UdvtxCOoJk2wpcVQICy50d8MYe8IKg1zrbVsrHYd1gg6oxH8aQOiCoH1iuNWIR6ANfqNoJfwgp+BHEOHhP+uJkJManwBitAsFxcJJRsTezPDHI+gt7Enr8zGOIuQGRjlobo0UWkscoGDoxSAnHY8xyF/NLGa3S4+SGTTN8AJ/0w4wF9bfAtvZqSQSW9mkoENRajbFTwpI53ad6+G4bC3jZSa9DWjT3CNYt+v438ycyorAT17KveZ09z2qikLZ57h8vMctAVYt9XGmRk2lo/l7Dv2U/J1FUPhXg/zCa/RJykCSAQbdAiDpdriTLvyf9imOBf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMEbBptqCNeTqjV8AVAwccmxKiwxRPweZnH6gnX1XU0=;
 b=PnLAEaz6DZ/O5zDYV0S0v78rrETxmYk3fkvlbMCSFZm8fnO+PkdGSOYJjYd5OV1WFVTLQYiQ7gp9vzg26dMkquUc57yqlELcNRWZWbnpUHxRYWJzyjabcVtI66kmrqvQLyMbHvOo0ZQbyYCz8z1GqK/iiPiCtma+vdzMNv6hEOQ=
Received: from SG2P153MB0380.APCP153.PROD.OUTLOOK.COM (20.180.85.75) by
 SG2P153MB0189.APCP153.PROD.OUTLOOK.COM (10.170.142.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.6; Wed, 5 Feb 2020 11:33:03 +0000
Received: from SG2P153MB0380.APCP153.PROD.OUTLOOK.COM
 ([fe80::b4ea:2ab3:3c3f:db07]) by SG2P153MB0380.APCP153.PROD.OUTLOOK.COM
 ([fe80::b4ea:2ab3:3c3f:db07%4]) with mapi id 15.20.2729.004; Wed, 5 Feb 2020
 11:33:03 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [bug report] video: hyperv: hyperv_fb: Use physical memory for fb
 on HyperV Gen 1 VMs.
Thread-Topic: [bug report] video: hyperv: hyperv_fb: Use physical memory for
 fb on HyperV Gen 1 VMs.
Thread-Index: AQHV2+dTLIiZpDBwxkOf1aO+rPZO4qgMMTTwgAANoICAADZFwA==
Date:   Wed, 5 Feb 2020 11:33:03 +0000
Message-ID: <SG2P153MB038005492C6FE395B6523A8EBB020@SG2P153MB0380.APCP153.PROD.OUTLOOK.COM>
References: <20200205054359.ynzdaq6lalb2sv7w@kili.mountain>
 <SG2P153MB0380F76124DEE4F3728C056DBB020@SG2P153MB0380.APCP153.PROD.OUTLOOK.COM>
 <20200205080733.GU11068@kadam>
In-Reply-To: <20200205080733.GU11068@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=weh@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-05T11:33:01.5860674Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d6fc9c1-e2a1-432e-a498-5e623fe426ca;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [2404:f801:8050:3:80be::b832]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 104d1a50-7809-4cc9-48c4-08d7aa2f29b8
x-ms-traffictypediagnostic: SG2P153MB0189:
x-microsoft-antispam-prvs: <SG2P153MB0189027D6D9B5D50E32D4241BB020@SG2P153MB0189.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(71200400001)(86362001)(316002)(66946007)(52536014)(66476007)(66556008)(64756008)(66446008)(5660300002)(7696005)(9686003)(55016002)(6916009)(8936002)(4326008)(6506007)(966005)(2906002)(10290500003)(8990500004)(8676002)(76116006)(33656002)(478600001)(81166006)(81156014)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P153MB0189;H:SG2P153MB0380.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGUzvJ+yEuwwof0TbIAPfA3CQnPND9CevpRiCeUCIXhV38FwfqJgSYcAjjm6aqcHJGJjvzG49FCM/gsplysPCh33fLGrcGVrw1SOn/5XkYZun5Hf4cMU9N0QQy1BO8newlRyEhWxQtZPox3w6yPaBUUkLe6YVIh4gTLd3AFcsz1vDpwieICeAY7b0jR8IXu/6aPcri+RSlIZCXL9Mnv8DE7xDTJ7V40IJGJq0toI+Q30TZ7r0GM8PyjXB6VAkQk6pugMk/HYYppYc5t0X6joo9W//GKM4XK1RmxJjh2IKeNFXQOf+2UUIrCoQoQtfughidLrlUmTgCZFB39qdBGUv/BGKZyXAGxyr1w+3dRAkBRTOpw+7R9igGBf1Mga1ChSl3z5oidGz/yDkOI9ZckVnLBPKYwgGXVdiAzuypBe2ddagy5msFdM56Q0FDqVhzlUQzJ+J1qTmOdQJ63n2gXjxUUSpafvCJTQMnMSYYb1U7hUNVwG6fvJ6OCoVQtyg8wViadblIPEyftzhnP+t/lRBA==
x-ms-exchange-antispam-messagedata: q4QPHGpzAo65P8HJh8wRGGVyPddsT1Q/CmDn0XWYk6NMksEM8+b30KVvADbQyX8LBzwvIKw/WiT1t9IOVdJqZJprTIlnrs3q9ebzET33GDU26H/aP0ALYZqsVxEwkAdRo9b/YuZOITu78y2fLSaAQlUwVrOBMheglKCTIg0KFarW5juFWZIkwsRHg22fOJ7O
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104d1a50-7809-4cc9-48c4-08d7aa2f29b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 11:33:03.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCkG4WXWnFj6BMkhgfH1S8Uq0P10VpTg1PO6YqFw8dGvtIswKQBruNb9ZGbaahVKlKBDyMKMsddHnNOw6jr0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0189
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> > Thanks for reporting this. Would you let me know how I can reproduce
> > this warning or Error message? The build on my side runs fine without s=
uch
> message.
>=20
> Hm...  Sorry, I never publish this Smatch check.  I should do that.
> Anyway HCH explains the rules a bit in this email:
>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.=
or
> g%2Flkml%2F2019%2F6%2F17%2F155&amp;data=3D02%7C01%7Cweh%40micro
> soft.com%7Cff5687dc7bb648623d3708d7aa127a4b%7C72f988bf86f141af91a
> b2d7cd011db47%7C1%7C0%7C637164868648450097&amp;sdata=3D0%2B8Jwe
> 1A%2FtOW0LqF8t2hqymWuzZjVtUxBIKgMyOQdFc%3D&amp;reserved=3D0
>=20

I see. This is virtual frame buffer device on Hyper-V. It would not get add=
ress from=20
vmap or ioremap. On the other hand, if dma_alloc_coherent() returns address=
 without
page backing, this driver will blow even without calling virt_to_phys.=20

Dma_alloc_coherent() is the recommended interface to allocate large contigu=
ous
physical memory, in which case this call is doing so. I think you can ignor=
e this=20
in your check.

Thanks,
Wei
