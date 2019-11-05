Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E9EF516
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2019 06:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfKEFnw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Nov 2019 00:43:52 -0500
Received: from mail-eopbgr1300132.outbound.protection.outlook.com ([40.107.130.132]:47967
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfKEFnw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Nov 2019 00:43:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdGSgu2+7Dkp8m3Srq2Y3oiXbDTJxXZWhZpObOI8wRbtC50tyVUmkoaWnpVQ/gsoS1myGvtGPay30syHvTEUCG7ZDL6r9wsvmp17WPd3BLJP82q6k0K6t6+b6GmdUwCcRQYRbrMu59d7Os42K6i1aJeWFCEB7RjaP0wh3aXGQoRbIJE4mBp8t3zyEqhPmV/t+rKCrbGaJLaZwIdfHlnNBeKzk/Yl7Y8NlgTy8CPnBCHYvwReJ2umXHgX33p3YCAueJjSa5i6G3PIiel2eJUJINg2elGbiApLDlJWrVV4QnBfl+LCUTU8GURH+e7cKgYhbrcAhmIzKXV+JAfyuWCpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFSXigBgPw0k85MFZb7rvEDdWmKQwhYgeBoP5mkdDCg=;
 b=hlu7+EzaGlipzxj7cGpmOs0h1Uuw/lQwNVNp036b+kxEV4UhSqAM3De5xZG8R/Nk6w6P2IYOOM1pIwfkj2HHZSY0tgFa38jwpQlkY2SEXQsfvZeT4o4m1ow/9xjOoxgEYNWmC5tS2Do/wUu9ICI+k/l45j0dL1o4G5EFqT3s326JOmrQAehmQLcRjE6zxSPI29tXCx0jdIryN4xcSG1Lx8WHPfWDEYuvkEhhiBju9ShAqe1giMmemnH1lzGxzLnb8NCN5kZBmhkT13Ph1nDmAai/2LlwWdQXfiQs4rPCf/dlD3L5KpC+e6MQMJ4ThhK5CbjytGMaEwWjAB45jUto4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFSXigBgPw0k85MFZb7rvEDdWmKQwhYgeBoP5mkdDCg=;
 b=SPP4ymshpHvtO7FTZ5+QgeRqkjjtHUVtVfUbkZhIOgf0koabkHyPHvgEQR0REdlO0r+HSvr/LeidyVX1mhVmGa7L/pTZzV3X8c5B1sPEHA0y0RAoBIwo6hWOC6pGUJEVboN12G1e9YBnAtj0t9rTmgvw2nF1cBPYnaKn3FHKfk0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.19; Tue, 5 Nov 2019 05:43:04 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809%2]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 05:43:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Topic: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Index: AQHVbwXQRPtGDntMcU+sv4R8q5dPMac1q4VggAqesgCABFerkIAAR5AAgAAEvxCAA52PEIAAuuYAgDMQObA=
Date:   Tue, 5 Nov 2019 05:43:04 +0000
Message-ID: <PU1P153MB01699917C92952BAD6B7A1E1BF7E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190930230652.GW237523@dtor-ws>
 <PU1P153MB01696258D9983DF59D68E748BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20191003174530.GB22365@dtor-ws>
In-Reply-To: <20191003174530.GB22365@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-05T05:43:02.8057448Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7acc6be9-0701-4b10-9eb1-cbcadb856d39;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:b08b:7990:46d8:efef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a333e6a3-e8d7-4b46-8b5f-08d761b3076d
x-ms-traffictypediagnostic: PU1P153MB0154:|PU1P153MB0154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0154E991B187E23E011BFD6EBF7E0@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(199004)(316002)(6506007)(6116002)(476003)(5660300002)(2501003)(71190400001)(10290500003)(229853002)(102836004)(22452003)(81166006)(6436002)(4326008)(2351001)(186003)(1361003)(54906003)(71200400001)(5640700003)(107886003)(6916009)(8676002)(8936002)(81156014)(7736002)(25786009)(305945005)(99286004)(74316002)(66446008)(55016002)(64756008)(66556008)(66476007)(76116006)(66946007)(256004)(14444005)(86362001)(10090500001)(33656002)(6246003)(478600001)(8990500004)(2906002)(76176011)(46003)(11346002)(7696005)(14454004)(52536014)(486006)(446003)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpVpObDFrSqU3znIPDdjRlWvQCAA2J9Y1qYJoadErOhS2LxDjO7wszthjXG4Xaacu62XsLY0GTsQKjmqUVXlhkeWex5mLYZfL8gegAxaEKiMJ0gaRIZ9cQyguEZgPcFufl7Q+u+I7FiXjc7Je/idhyh1hMAP+xEueda7SV8V1GWyg8DYd3bAlWj55FkyHygCOVM+9MspMlGG5ZdaEPMGUhw/LLwk/6xsiESktSR4m686Sjh1j2vm9Vm+XsYWQt5rPcwgT7m1onoo+KvjhlLJR9IW70Zb7CMvoEBOm7xzfcZJs8sA61fcNpas2rj2QwAAPnuXslkoV3bbZj5W3wduus8MhmtJnjCVtqUpeTetu8NxasyZNsZt95r0VTf+E2iy8whFHoMwMbjjBcE9aAB7/L711PBvcXSUCIYvifcl4m22x4jEsfG8ApR1uTo10gZ5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a333e6a3-e8d7-4b46-8b5f-08d761b3076d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 05:43:04.4076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+BBvFret92QWR6WtJOhkOap2JitkkI5ZUX/1UdMOyu8+KjD+nArPsGJ3QT3vlPSSlu30DjUc0ymdppEwYloMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tIDxkbWl0cnkudG9yb2tob3ZAZ21haWwu
Y29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAzLCAyMDE5IDEwOjQ2IEFNDQo+IC4uLiAN
Cj4gUmlnaHQuIEkgdGhpbmsgaW4gcHJhY3RpY2UgdGhlIGN1cnJlbnQgc3VzcGVuZCBpbXBsZW1l
bnRhdGlvbiBjYW4gd29yaw0KPiBhcyBmcmVlemUoKSBmb3IgdGhlIEhWIGtleWJvYXJkLCBiZWNh
dXNlIGluIHN1c3BlbmQgeW91IHNodXQgb2ZmIHZtYnVzDQo+IGNoYW5uZWwsIHNvIHRoZXJlIHNo
b3VsZCBub3QgYmUgd2FrZXVwIHNpZ25hbHMgYW55bW9yZS4gV2hhdCB5b3UgZG8gbm90DQo+IHdh
bnQgaXMgdG8gaGF2ZSB0aGUgY3VycmVudCByZXN1bWUgdG8gYmUgdXNlZCBpbiBwbGFjZSBvZiB0
aGF3KCksIGFzDQo+IHRoZXJlIHlvdSByZS1lbmFibGUgdGhlIHZtYnVzIGNoYW5uZWwgYW5kIHJl
c3VtZSBzZW5kaW5nIHdha2V1cCByZXF1ZXN0cw0KPiBhcyB5b3UgYXJlIHdyaXRpbmcgb3V0IHRo
ZSBoaWJlcm5hdGlvbiBpbWFnZSB0byBzdG9yYWdlLg0KPiANCj4gSSB0aGluayBpZiB2bWJ1cyBh
bGxvd2VkIEhWIGtleWJvYXJkIGRyaXZlciB0byBzdXBwbHkgZW1wdHkgdGhhdygpIGFuZA0KPiBw
b3dlcm9mZigpIGltcGxlbWVudGF0aW9ucywgd2hpbGUgdXNpbmcgc3VzcGVuZCgpIGFzIGZyZWV6
ZSgpIGFuZA0KPiByZXN1bWUoKSBhcyByZXN0b3JlKCksIGl0IHdvdWxkIHNvbHZlIHRoZSBpc3N1
ZSBmb3IgeW91Lg0KPiANCj4gRG1pdHJ5DQoNCkJUVywgSU1PIHRoYXcoKSBzaG91bGQgbm90IGJl
IGVtcHR5LCBiZWNhdXNlIGRyaXZlcnMvYmFzZS9wb3dlci9tYWluLmM6IA0KcG1fb3AoKSB1c2Vz
IG9wcy0+dGhhdyBmb3IgYm90aCBQTV9FVkVOVF9USEFXIGFuZCBQTV9FVkVOVF9SRUNPVkVSLg0K
DQpQTVNHX1JFQ09WRVIgaXMgdGhlIHNhbWUgYXMgUE1fRVZFTlRfUkVDT1ZFUi4NCg0KSWYgc29t
ZSBzdGVwIGluIGhpYmVybmF0aW9uX3NuYXBzaG90KCkgLT4gY3JlYXRlX2ltYWdlKCkgZmFpbHMs
IHdlIGNhbGwgDQpkcG1fcmVzdW1lX3N0YXJ0KFBNU0dfUkVDT1ZFUikgYXQgdGhlIGVuZCBvZiBj
cmVhdGVfaW1hZ2UoKSwgYW5kIGNhbGwNCmRwbV9yZXN1bWUoKSBpbiBoaWJlcm5hdGlvbl9zbmFw
c2hvdCgpLiBBbiBlbXB0eSB0aGF3KCkgY2FuIG5vdCBicmluZyB0aGUNCmRldmljZSBiYWNrIHRv
IG5vcm1hbC4NCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
