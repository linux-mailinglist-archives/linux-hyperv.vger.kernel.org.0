Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D788F1A5311
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2020 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDKRUz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Apr 2020 13:20:55 -0400
Received: from mail-eopbgr1300133.outbound.protection.outlook.com ([40.107.130.133]:2784
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbgDKRUz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Apr 2020 13:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7Qxziah+gRAHPjcWOKzGHB6BfKJ9DVjEhlPT0fPgfULtgJOBpgL+oa8skSMXqPL1Tr2/9vAybPQUyqhkH4+NBogecxYADtXKz/it2Bc3oUvwW+N9G6hS/x6eoEJ9G754x0pmhMVKdZJWS2Vd0OvJCZEUDtdqoo4fr9IVgo+7F0YjkGgpryHmJO+sKY1AIeyIKOIYlUsOA+E9PAKp4VgyZ13fin2qCJv/pT75Dq/lWHtrA4Qb3B+Fs0Upn+f87ADQBTy+sGEcFxD8tRvM0g92hX/eDKbz8j2NCbA0HEpqQ8Gsh+YiWQfHkzP3gS2ma1wEHWgHvfqUEocGf3gKesJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mHgWXzKU5H6Hl0CziQ86yrMHJPIZi7vl/5LLQdJHNQ=;
 b=BD7Gld2xUB/BH2wi/FJoA/zxDGddcQU4jZOUVfkk0EFhx75LmPvKlYGVpCPGcy8KKHEL/Qp398bOfR+fh6Gor8jaY50IK6UuX0w3OLIg3oSpH1fLGzkRZZKxBL5MYGwMY3W48dCGMjqqVQbjRCTXiLqaLdCO6yUoBd0M7+3uzQ6QFLMYQFlKUtXj3K1BtsNkBgXMJ0QuqDMTmBnQVeTBUzKt/rCarR92kS1bgOMfx3u1ukgty6Cd/U5c8oBp9OCqV3AXAKfA9F4JFVN/jHl4xmY49LmXXezoUvqVX0Plp+5rT8DJHYgdePUFzpqIH1j/+nyNoTeGLQUEVlvWvzfZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mHgWXzKU5H6Hl0CziQ86yrMHJPIZi7vl/5LLQdJHNQ=;
 b=M00M0vLYV7S5tP8YrVE1qdrRPGvjpo6ons/f8EtvO7+5IEFndccFiMM1HmNG2FCktoM5TT9lwEt+NOhVWWYFQ3q/BrVhtpXbcAqa3OJpKIaRfdxPRDtGw8OQu+fF8jopDxLIb5HLmZvMuEvH77Zj1C5c3RsrQT8VyTIPIxRoGTM=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0307.APCP153.PROD.OUTLOOK.COM (52.132.236.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.4; Sat, 11 Apr 2020 17:20:12 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2921.023; Sat, 11 Apr 2020
 17:20:12 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Topic: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Index: AdYO+lVJkAFfrToQQYmccjddvm2wiwAEVA6AAC5hOXAAE0msgAACwDPg
Date:   Sat, 11 Apr 2020 17:20:12 +0000
Message-ID: <HK0P153MB0273B8F511D973C2428174EBBFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0273A1B109CE3A33F0984D34BFDE0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <CACVXFVO5Ni531JO+62CW4pV2y6gT98_8G=jiCJCZoqjkUBmo9Q@mail.gmail.com>
 <HK0P153MB027320771C7A000B85BF3B97BFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <55ba8004-55fa-4bd6-59e9-c21f9c0e75bc@acm.org>
In-Reply-To: <55ba8004-55fa-4bd6-59e9-c21f9c0e75bc@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-11T17:20:07.7914188Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=655d1367-f268-49d2-b97b-a0a42308529b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:50a1:820f:4f92:d9bb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdfd6c12-0e21-43b6-743e-08d7de3c980c
x-ms-traffictypediagnostic: HK0P153MB0307:|HK0P153MB0307:|HK0P153MB0307:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB03071ED94FADE8259BDB5712BFDF0@HK0P153MB0307.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03706074BC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(82950400001)(82960400001)(186003)(52536014)(7696005)(86362001)(5660300002)(53546011)(6506007)(55016002)(9686003)(4326008)(2906002)(8936002)(110136005)(316002)(54906003)(8990500004)(10290500003)(8676002)(478600001)(33656002)(76116006)(81156014)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyNGAjd1hGc+1moCpxIMoKNi+SubdrkCWMKuaFwWsIAu5rd8EAh2QX3aZZG5FZckmJ5U12km27ro2LU4scWS/W9YSvPGuekaLhXpiTBmamTc2axUPyibNa6Anj54cWJn7wKcYju0qobg+tKG3lItB2nfT0GPwDR9m6BKX0gZmfnO8lWd43ki4ytGzfwtf01sx4s7o8yUQsddXzb0BLMfc1igKpjfs/j6D0v59LTfhkhHMJ+ncTqjH01wnEEmWeIlsUjMDzxym+sMgKcLCDj2//GUUVEBsm7GKFLS3o7t6I8rukhBaL78KX0+xZewtNCpJ1rV4B2fa32Y5nkDtIq3oFjRhZyBFuJM4mjP8LUxMGPT2YsqygfMaJzZThDSTS9HhhuODFx8q4F5ozPDoT1fh6IWXIRg8E5Ho9sc8gLq5Br8QCSlxSSba7pkim1fg/cd
x-ms-exchange-antispam-messagedata: 0OkkaKDQ09Ut2NF5nXhgVO6QTwpXUtdqN7bZzwU9YfOI9RIldtHwYBuBQgEm2HdGT9sVyLDEzvDEc6LGecOt1gdeQPQLs43efU0ED+f3O2sylTROpHZChGUtH1Wwa1btIG3BwDWvM/DLZDGqadWISMUPiL1TCFKAlhE4IxjjB05IDIWfxk73nsYIFkFYwGWYRYjBCC0EE5+6fwIeu23+Cg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfd6c12-0e21-43b6-743e-08d7de3c980c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2020 17:20:12.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6gJ9IdeTuFRfW7y6dV/d47oMhL/iBcGS9RFFc1kRq/9mlVZNAMBgTM7suVQvrHo5nSXU6yKMiD5cNBcV7piqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0307
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gU2VudDogU2F0
dXJkYXksIEFwcmlsIDExLCAyMDIwIDg6MDMgQU0NCj4gDQo+IE9uIDIwMjAtMDQtMTAgMjM6MDEs
IERleHVhbiBDdWkgd3JvdGU6DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZSBjaGFuZ2Ug
dG8gc2NzaV9kZXZpY2Vfc2V0X3N0YXRlKCkgaXMgT0suDQo+IA0KPiBIYWRuJ3QgTWluZyBMZWkg
YWxyZWFkeSByb290LWNhdXNlZCB0aGlzIGlzc3VlIGZvciB5b3U/IEZyb20gaGlzIGUtbWFpbDoN
Cj4gIlNvIHlvdSBjYW4ndCBmcmVlIHJlbGF0ZWQgdm1idXMgcmluZ2J1ZmZlciBjYXVzZSBCTEtf
TVFfUkVRX1BSRUVNUFQNCj4gcmVxdWVzdCBpcyBzdGlsbCB0byBiZSBoYW5kbGVkLiINCj4gDQo+
IFBsZWFzZSBmb2xsb3cgdGhhdCBhZHZpY2UuDQo+IA0KPiBCYXJ0Lg0KDQpIaSBCYXJ0LCBNaW5n
LA0KSSBhZ3JlZSBNaW5nIGhhcyByb290LWNhdXNlZCB0aGUgaXNzdWUsIGJ1dCBpdCBsb29rcyB0
aGUgYWR2aWNlIGNhbiBub3QNCmFwcGx5IHRvIHRoZSBoaWJlcm5hdGlvbiBzY2VuYXJpby4gOi0p
DQoNClNvcnJ5IGZvciBteSBsYWNrIG9mIGtub3dsZWRnZSBvZiB0aGUgY29tcGxleCBTQ1NJIHN1
YnN5c3RlbXMgLS0gY291bGQNCnlvdSBwbGVhc2UgZWxhYm9yYXRlIG9uIHdoYXQgYSBsb3cgbGV2
ZWwgU0NTSSBkZXZpY2UgZHJpdmVyIChsaWtlIGh2X3N0b3J2c2MpDQpzaG91bGQgZG8gdG8gc2Fm
ZWx5IHNhdmUvcmVzdG9yZSB0aGUgZGV2aWNlIHN0YXRlIHVwb24gaGliZXJuYXRpb24/DQoNClRo
ZSBuYXR1cmUgb2YgImZyZWUgcmVsYXRlZCB2bWJ1cyByaW5nYnVmZmVyIiBpbiBodl9zdG9ydnNj
IGlzIHRoYXQ6IHRoZSANCmRyaXZlciBjYW4gbm90IGhhbmRsZSBhbnkgSS9PIGFmdGVyIHRoZSBk
ZXZpY2UgaXMgcXVpZXNjZWQgaW4gDQpzb2Z0d2FyZV9yZXN1bWUoKSAtPiBsb2FkX2ltYWdlX2Fu
ZF9yZXN0b3JlKCkgLT4gaGliZXJuYXRpb25fcmVzdG9yZSgpDQotPiBkcG1fc3VzcGVuZF9zdGFy
dCgpIC0+IC4uLiAtPiBzdG9ydnNjX3N1c3BlbmQoKS4gQlRXLCBhZnRlciB0aGUgU0NTSQ0KZGV2
aWNlIGlzIHF1aWVzY2VkLCB0aGUgaGliZXJuYXRpb24ncyByZXN1bWUgcGF0aCBhbHNvIHF1aWVz
Y2VzIG90aGVyIA0KZGV2aWNlcywgZGlzYWJsZXMgbm9uLWJvb3QgQ1BVcywgYW5kIGZpbmFsbHkg
anVtcHMgdG8gdGhlIG9sZCBrZXJuZWwncw0KZW50cnkgcG9pbnQgd2hlcmUgdGhlIG9sZCBrZXJu
ZWwgd2FzIHN1c3BlbmRlZCwgYW5kIHRoZSBvbGQga2VybmVsIHdpbGwNCnJlc3VtZSBiYWNrLg0K
DQpNeSBpbnR1aXRpb24gaXMgdGhhdCB0aGUgdXBwZXIgbGV2ZWwgU0NTSSBsYXllciBzaG91bGQg
cHJvdmlkZSBhbiBBUEkgdG8NCmZsdXNoIGFueSBwZW5kaW5nIEkvTyBhbmQgYmxvY2sgYW55IG5l
dyBJL08gYWZ0ZXIgYSBTQ1NJIGRldmljZSBpcw0KInF1aWVzY2VkIj8gLS0gaXQgbG9va3Mgc2Nz
aV9ob3N0X2Jsb2NrKCkvc2NzaV9ob3N0X3VuYmxvY2soKSBhcmUgc3VjaCANCkFQSXMsIHdoaWNo
IGFyZSBhbHJlYWR5IHVzZWQgYnkgDQpkcml2ZXJzL3Njc2kvYWFjcmFpZC9saW5pdC5jOiBhYWNf
c3VzcGVuZCgpL2FhY19yZXN1bWUoKS4NCg0KVGhhdCdzIHdoeSBJIHByb3Bvc2VkIHRoZSBwYXRj
aCBvZiB0aGUgc2FtZSB0aGluZyBmb3IgaHZfc3RvcnZzYywgYW5kDQppdCBsb29rcyB0aGUgcGF0
Y2ggd29ya3MgZm9yIG1lOiB3aXRob3V0IHRoZSBwYXRjaCBJIGNhbiBlYXNpbHkgaGl0IHRoZQ0K
cGFuaWMgSSByZXBvcnRlZCBpbiB0aGUgZmlyc3QgZW1haWw7IHdpdGggdGhlIHBhdGNoLCBJIGhh
dmUgc3VjY2Vzc2Z1bGx5DQpkb25lIG1vcmUgdGhhbiAzMCByb3VuZHMgb2YgaGliZXJuYXRpb24g
d2l0aG91dCB0aGUgcGFuaWMuDQoNCkhvd2V2ZXIsIGl0IGxvb2tzIHlvdSBpbXBsaWVkIG15IGlu
dHVpdGlvbiBpcyB3cm9uZyBhbmQgaXQncyAqZXhwZWN0ZWQqDQp0aGF0IHRoZSB1cHBlciBsZXZl
bCBTQ1NJIGxheWVyIGNhbiBzdGlsbCBzdWJtaXQgSS9PIHJlcXVlc3RzIHdpdGggdGhlIA0KQkxL
X01RX1JFUV9QUkVFTVBUIGZsYWcgYWZ0ZXIgdGhlIFNDU0kgZGV2aWNlIGlzICJxdWllc2NlZCI/
DQoNCklmIHRoaXMgaXMgdGhlIGNhc2UsIHRoZW4gaG93IGlzIGh2X3N0b3J2c2Mgc3VwcG9zZWQg
dG8gaGFuZGxlIHRoZSBJL08NCmFmdGVyIHRoZSBTQ1NJIGRldmljZSBpcyBxdWllc2NlZD8gSSBj
YW4ga2VlcCB0aGUgcmVsYXRlZCB2bWJ1cyByaW5nYnVmZmVyLA0KYnV0IHRoZSByZWFsIGlzc3Vl
IGlzOiB0aGUgZHJpdmVyIGlzIHVuYWJsZSB0byBoYW5kbGUgYW55IEkvTyBhdCBhbGwgc2luY2Ug
dGhlDQp2bWJ1cyBjb25uZWN0aW9uIHRvIHRoZSBIeXBlci1WIGhvc3QgaXMgZGlzY29ubmVjdGVk
IHNvb24sIGFmdGVyDQp0aGUgU0NTSSBkZXZpY2UgaXMgcXVpZXNjZWQuIFNob3VsZCBodl9zdG9y
dnNjIHJldHVybiBhbiBlcnJvciBmb3Igc3VjaCBJL08sDQpvciBibG9jayBzdWNoIEkvTyB1bnRp
bCB0aGUgU0NTSSBkZXZpY2UgaXMgcmVzdW1lZD8gLS0gVGhlc2UgZG9uJ3QgbG9vaw0KZ29vZCB0
byBtZSwgYW5kIEkgcmVhbGx5IHRoaW5rIHRoZSB1cHBlciBsZXZlbCBTQ1NJIGxheWVyIHNob3Vs
ZCBwcm92aWRlDQphbiBBUEkgdG8gYmxvY2sgYW55IG5ldyBJL08gYWZ0ZXIgYSBTQ1NJIGRldmlj
ZSBpcyAicXVpZXNjZWQiIC0tIGFnYWluLCBjYW4NCnlvdSBwbGVhc2UgY2xhcmlmeSBpZiBzY3Np
X2hvc3RfYmxvY2soKS9zY3NpX2hvc3RfdW5ibG9jaygpIGFyZSBzdWNoIEFQSXM/DQoNCkxvb2tp
bmcgZm9yd2FyZCB0byB5b3VyIHJlcGxpZXMhDQoNClRoYW5rcywNCi0tIERleHVhbg0K
