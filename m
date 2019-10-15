Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7ED770C
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfJONGg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 09:06:36 -0400
Received: from mail-eopbgr730097.outbound.protection.outlook.com ([40.107.73.97]:32999
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbfJONGg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 09:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHDcGZwVm4HiMmI4zNWtdylm0jcD6jkdGLtHzpNfryGMuLRssONni1+MRolW2mdfwiPcEfSq6ph03vka6FySkeiKafuXkj8idD6Snr5UNIcMJ1AViWwF3AjRLc3ZGxHLR7Bol+JJfz3CTJl1ATtMk0Y+MaMAFx6VWEgvElSf9CGpyrLS/WplJ9R1Vo/lm02wublT3UhoZfps2Jo8mAG+vQ4QuxOqQYDC+ZFxsSKl2nBepLnxXw4cTZaq3HiBKbTn0R73P1LqYCRRUIDm5DlQ2JLM20E8ppU/aYa+uDwRyAoBNpHCWn077CNXKA/q/Z6OwQhL+adTWzsAH5OMMZzMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwkSsJ7uUmCNGWcnEbwtdw9Hc8H6403x4LdJH20u79Q=;
 b=ceyMaQVxSuzHegND5nVJ4UIflH9yB72vZTHTdSbnzgVx+b55jqTyAmV5AGGBTrl6kh5/2p0ZAMQsVXD8TrpOc8LaZFmw2HNU6bWPJgxVbQVur+j+F+z6MzvbVh5zvECP5BhFqtSrgI6vg52YrZRxg682UpWWRri+O6ADtI7JHGeKttr/jNDr1xknZsn3dxdSUBAWGOS/G0em43YEzp8vy1PEJTa7w/GdD1tOGhjVlf1sR2vlRYK7PpHByI0i24Gn3mjv7M3GpgEMmE4HtR/q2KDZFdVx5jW7Byk300H32uYWabsTMkoPKZqoyXoybDeyOQ/jISgr8dcnpXjJ1+mDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwkSsJ7uUmCNGWcnEbwtdw9Hc8H6403x4LdJH20u79Q=;
 b=N3nEbHkqV9NebWjssPkDcXtoRPS6xeq2YuXfXiQ2yyNl3TK1VNMW/t3Q2bwtc48217QGb8Mfr5cTyZdHRYW+3qB2JZWyKWxMIEfj7lu5heGcZuKqXjeYcXN+l7x+CKAxlVFTy6tId1R4rebOvpEICKkK2m2XpdK3ByIy97aEWII=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0188.namprd21.prod.outlook.com (10.173.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.4; Tue, 15 Oct 2019 13:06:33 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e%11]) with mapi id 15.20.2347.023; Tue, 15 Oct
 2019 13:06:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, vkuznets <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v2] x86/hyperv: Set pv_info.name to "Hyper-V"
Thread-Topic: [PATCH v2] x86/hyperv: Set pv_info.name to "Hyper-V"
Thread-Index: AQHVg0RIF4xP+GrFYUaioMALFqP6h6dbq8mA
Date:   Tue, 15 Oct 2019 13:06:33 +0000
Message-ID: <DM5PR21MB01377F713A553FCF721EF99DD7930@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191015103502.13156-1-parri.andrea@gmail.com>
In-Reply-To: <20191015103502.13156-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-15T13:06:31.2366612Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a42cd8a-92d9-4e4c-9cdb-10505339effc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65103363-64da-47a8-53a6-08d751708104
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0188:|DM5PR21MB0188:|DM5PR21MB0188:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB01882523B9FF0143C52267F1D7930@DM5PR21MB0188.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(7416002)(9686003)(14454004)(66446008)(33656002)(2201001)(66476007)(76116006)(66066001)(2906002)(11346002)(7696005)(6246003)(74316002)(99286004)(446003)(186003)(66556008)(66946007)(64756008)(76176011)(10090500001)(6436002)(256004)(55016002)(25786009)(71200400001)(26005)(4326008)(8676002)(102836004)(81156014)(81166006)(229853002)(6506007)(5660300002)(4744005)(6116002)(8990500004)(86362001)(71190400001)(8936002)(478600001)(486006)(316002)(22452003)(10290500003)(2501003)(110136005)(54906003)(7736002)(476003)(305945005)(3846002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0188;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdIz54meN3WPOpWH/wQXIk95ATAZ3I8JxxdoWlApC8iqTUAKaiqN4zHVWzcQf6PUEC2Kd+J6qUmhlDZBvm3+vzCt8iJR9uV1eMyfQMFv3Wiq1uJcEqGQymX3teIQ9y7K6rUBXpc9SsXVwuI650IUMN0ylU2ZTwMFmZA0/GVsSI0Me/qNdYKJ+Qy8cNtj1ZoQJ9biWeNfb4rgT+l6qSBsQajvrXZWCAD7kBD4jWYmTC5sC6tYtYcIskpnm0mYxN7Q1Toz1v7Hk5pUogwUW296SJVSovpMHo7z/62cfI56jEeC0aZ/eD9Yp5ptzev0+0Bknhg+iFgc9A4Iq/d+n38d/GS1akqzCX+UpeSJjD9jU29Z5pHSmTnA4EBphbLp9SGdUQeIQj4dCCIq3NP5O3UZAxEpC7hfVN7r0SQ+NX5pzgk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65103363-64da-47a8-53a6-08d751708104
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 13:06:33.7496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtu2ncpU4LwARKevawn1OfSc3IKaUPxIhxT55DcHKVli3VucGqnKIkjtTC083hHKzs9FqGoxfcFuxnswAiq77MnNV1jQwe40Kz8/c2gnZyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0188
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, October 15, 2019=
 3:35 AM
>=20
> Michael reported that the x86/hyperv initialization code printed the
> following dmesg when running in a VM on Hyper-V:
>=20
>   [    0.000738] Booting paravirtualized kernel on bare hardware
>=20
> Let the x86/hyperv initialization code set pv_info.name to "Hyper-V";
> with this addition, the dmesg read:
>=20
>   [    0.000172] Booting paravirtualized kernel on Hyper-V
>=20
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
