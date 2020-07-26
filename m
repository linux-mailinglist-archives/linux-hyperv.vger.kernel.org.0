Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B56022E360
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jul 2020 01:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGZXxO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jul 2020 19:53:14 -0400
Received: from mail-eopbgr770099.outbound.protection.outlook.com ([40.107.77.99]:62787
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbgGZXxN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jul 2020 19:53:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/Oq0uY1MzQoLYpwkLjoVL+Q38WiWhoVaf0Vr6IVSMNHDxnLEOKr607y2numuka5Do2VwuZp/gpWmC154wEpzm1WcdSnGSTmHGnKkP4NdidMKvxwAqc2KoIL6XCgcjjz3XK6nuPGjnQuPKJ711VFkS7BM90llruOWJILfbR6S2dH8dIMWMLFroXc6oaZW6z04bvqfDyz/awZ6r5NLWu2SuO3/DXBNe7nEWupj+Zur9uAIwMYWs4lG3SVBOR5jF7eMcKzvs97DncJnsloDobM4KFoUt3shX5jPblZPfpwBdsue4TdqdccLQJIX0+UxGDNNBnYN+Cm3ljsNo0rO+5u3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23dNLbdYm33yzxtf5U/GwoY59bNaUSKwcjNQ9pMYvUs=;
 b=RrS/qy9+ObG5IxnrSQwopLEzQAQL9WS6J4lNeUbbhP7gqfA0h/Lkzwlrav+dG7iSbdBRoU2eS1apT7b1OJtygzlCXMmgc6e1172hVvhtdTbSWu5VM1kIuHvHo26BKgNRW4BpTZih651tBwAbinBijP+54IHwt5LJxbj31c43Tz5CDSYYw04H5D4k6YaM1oe0r4JeFHb85be0vIJjCFu+0XNEFmJGKxPblC69Yu60pKTzQrmdrUt1Fiv/IqQpCeRg9VAoaJg+iY8No40JHjX2GtriAPlhm0OMx491POiwS7AflLZB68autx4pz23piTF6zT5pZ9/CoCVD7DfGziQyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23dNLbdYm33yzxtf5U/GwoY59bNaUSKwcjNQ9pMYvUs=;
 b=IkJUkf8L7zIFfKlNVG5ygGW3kUqoJhixu5WK4pgY1svgFYnWO4RnIRUHvAojkuG8DD7uQET9w5kEtn8NLdjcsz4k4fA8kk7LNISKQItYaQ2gs9Lq/T8l/bT6ZoWXiJFNoIy/njAA+zLrrrt+Sqxuv9GN03EYPy3OWsutuW8DPgA=
Received: from BL0PR2101MB0930.namprd21.prod.outlook.com
 (2603:10b6:207:30::18) by MN2PR21MB1486.namprd21.prod.outlook.com
 (2603:10b6:208:1f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Sun, 26 Jul
 2020 23:53:11 +0000
Received: from BL0PR2101MB0930.namprd21.prod.outlook.com
 ([fe80::f5a4:d43f:75c1:1b33]) by BL0PR2101MB0930.namprd21.prod.outlook.com
 ([fe80::f5a4:d43f:75c1:1b33%5]) with mapi id 15.20.3239.011; Sun, 26 Jul 2020
 23:53:10 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Andres Beltran <lkmlabelt@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix variable assignments in
 hv_ringbuffer_read()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix variable assignments in
 hv_ringbuffer_read()
Thread-Index: AQHWYdnygalh4GYqZ06NpC1cNLe6jqkW9wqAgABi0YCAAzECUA==
Date:   Sun, 26 Jul 2020 23:53:10 +0000
Message-ID: <BL0PR2101MB0930440E86045F954B6118B2CA750@BL0PR2101MB0930.namprd21.prod.outlook.com>
References: <20200724164606.43699-1-lkmlabelt@gmail.com>
 <20200724101047.34de7e49@hermes.lan>
 <CAGpZZ6ugh-SprR=oMkktEVuEJvNrK06TLqgskey0JkCdZCmvMA@mail.gmail.com>
In-Reply-To: <CAGpZZ6ugh-SprR=oMkktEVuEJvNrK06TLqgskey0JkCdZCmvMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-26T23:53:09Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3a1913fd-5d61-40c3-a474-7fbb311a77d7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [75.100.88.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7e29429-37d8-4ad9-5406-08d831bf0d9a
x-ms-traffictypediagnostic: MN2PR21MB1486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB14864D0AD5F6C894AC447B9CCA750@MN2PR21MB1486.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LS1t12nzuKUOtPMNn2GikVQDEmW1K7Pw4xY4QQDXpKumgmakAk2SqtxyipJIY4OefF1Rv4+GbyKFVjNrQy3+4JsIVX31rBA+zMmm2nQ2N7R6C0+DyRMFzXWOlIzRXUbhZLlOu9mvpL2k1+SvHjzb0Po5wPUjblGA5l5XbM2CTcojMm7wy4E3bh2NjCeW+MzCr4yoiy50HzhXfWzNGhKg4cad8VInX6fHrADTVnnjyGOwFVDuN1Sh4mJXgGJHXzaaQWoPCE3Pj/537a1Yx63eXH8eCxjnJYaCrlwOhwUVNk1dbO87WE/YMqWcpwxosZFvHiJrvGA7+TBcR31X0z0TEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB0930.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(2906002)(55016002)(83380400001)(33656002)(26005)(8936002)(186003)(9686003)(8676002)(5660300002)(4326008)(7696005)(71200400001)(66476007)(107886003)(66446008)(66556008)(53546011)(6506007)(64756008)(478600001)(110136005)(54906003)(66946007)(82950400001)(10290500003)(76116006)(52536014)(82960400001)(316002)(86362001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6erMmafTIBcSjJryzKEtMuTi2ABog9/+mfJmanq2LpEMWntWZiKi+sYB9RtT93nu7pbSnRgnSt7X1NoNSv30ClroNqm53qqi1srozR0aM1l5FZJS0MjCEoU1sxL7lrzM3M6r4AG1Y6p655XJcjgif3BQTWn69zNORS9fKjD1JhIPHiwuokB1tVwioGIy6+QEXCvit/2v6g/JXu8Mzzv40UthrPkPeGvs9x3cjmwA8eIQA0mCh4s9nO4hpwpmv5VRyo/aGTPnsxHG4Xl1nyi0jHT63yxvfqO77y36RfN+csxDUWAnov9Cr5J31peNVJviQ2w2ztmBzf1fjTtgXfCufv8L0WQOSpcPGo6dWY9D0J1Hw0tTbc7wcqsQYBFSzT2/SdsmZBn2fFzdisB5zwJdpUFILvTamHTAbOvCK4O8dl2ky/A6Ol5kszotQiybbHTY4X2RdxnblDd/Tt/JClvAoyIxTH+Aj8LI17MJ6VYk7o0Bgs19kNUxpmRXtQP9vAQ/e4WdVzNSTFNBbUnOVSvpbgG12SkQEWu9t2Z4JEmerP2jibikD8xdCetQs/prnZlrMbfXxKjzjQcXx/xp1xf9FTa3Ele2cY7FBQSfHSDJkafdIANAdHFhLD0SlmKZyUVQAjmpwRSMfUVuPZjheJjSHQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB0930.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e29429-37d8-4ad9-5406-08d831bf0d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2020 23:53:10.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdqkWjZf0KCwp13ZTcAZ5EBNK55acKHAn/o72/nebdynxEfj4+q807JGHDwiCaN6ryvznB3/kZYyJnDLcQJp8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1486
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmVzIEJlbHRyYW4g
PGxrbWxhYmVsdEBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAyNCwgMjAyMCA3OjA0
IFBNDQo+IFRvOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+
DQo+IENjOiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IEhhaXlhbmcgWmhhbmcN
Cj4gPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1taW5A
bWljcm9zb2Z0LmNvbT47DQo+IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz47IGxpbnV4LWh5
cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBN
aWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT47IEFuZHJlYQ0KPiBQYXJyaSA8
cGFycmkuYW5kcmVhQGdtYWlsLmNvbT47IFNhcnVoYW4gS2FyYWRlbWlyDQo+IDxza2FyYWRlQG1p
Y3Jvc29mdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIERyaXZlcnM6IGh2OiB2bWJ1czog
Rml4IHZhcmlhYmxlIGFzc2lnbm1lbnRzIGluDQo+IGh2X3JpbmdidWZmZXJfcmVhZCgpDQo+IA0K
PiBPbiBGcmksIEp1bCAyNCwgMjAyMCBhdCAxOjEwIFBNIFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4gd3JvdGU6DQo+ID4gV2hhdCBpcyB0aGUgcmF0aW9u
YWxlIGZvciB0aGlzIGNoYW5nZSwgaXQgbWF5IGJyZWFrIG90aGVyIGNvZGUuDQo+ID4NCj4gPiBB
IGNvbW1vbiBBUEkgbW9kZWwgaW4gV2luZG93cyB3b3JsZCB3aGVyZSB0aGlzIG9yaWdpbmF0ZWQN
Cj4gPiBpcyB0byBoYXZlIGEgY2FsbCB3aGVyZSBjYWxsZXIgZmlyc3QNCj4gPiBtYWtlcyByZXF1
ZXN0IGFuZCB0aGVuIGlmIHRoZSByZXF1ZXN0ZWQgYnVmZmVyIGlzIG5vdCBiaWcgZW5vdWdoIHRo
ZQ0KPiA+IGNhbGxlciBsb29rIGF0IHRoZSBhY3R1YWwgbGVuZ3RoIGFuZCBhbGxvY2F0ZSBhIGJp
Z2dlciBidWZmZXIuDQo+ID4NCj4gPiBEaWQgeW91IGF1ZGl0IGFsbCB0aGUgdXNlcnMgb2YgdGhp
cyBBUEkgdG8gbWFrZSBzdXJlIHRoZXkgYXJlbid0IGRvaW5nIHRoYXQuDQo+ID4NCj4gDQo+IFRo
ZSByYXRpb25hbGUgZm9yIHRoZSBjaGFuZ2Ugd2FzIHRvIHNvbHZlIGluc3RhbmNlcyBsaWtlIHRo
ZSBvbmUNCj4gQEhhaXlhbmcgWmhhbmcgcG9pbnRlZCBvdXQsIGVzcGVjaWFsbHkgaW4gaHZfdXRp
bHMsIHdoaWNoIG5lZWRzDQo+IGFkZGl0aW9uYWwgaGFyZGVuaW5nLiBVbmZvcnR1bmF0ZWx5LCB0
aGVyZSBpcyBhbiBpbnN0YW5jZSBpbg0KPiBodl9wY2lfb25jaGFubmVsY2FsbGJhY2soKSB0aGF0
IGRvZXMgd2hhdCB5b3UganVzdCBkZXNjcmliZWQuIFRodXMsDQo+IHRoZSBmaXggd2lsbCBoYXZl
IHRvIGJlIG1hZGUgdG8gYWxsIHRoZSBjYWxsZXJzIG9mIHZtYnVzX3JlY3ZwYWNrZXQoKQ0KPiBh
bmQgdm1idXNfcmVjdnBhY2tldF9yYXcoKSB0byBtYWtlIHN1cmUgdGhleSBjaGVjayB0aGUgcmV0
dXJuIHZhbHVlLA0KPiB3aGljaCBtb3N0IGNhbGxlcnMgYXJlIG5vdCBkb2luZyBub3cuIFRoYW5r
cyBmb3IgcG9pbnRpbmcgb3V0IHRoaXMNCj4gYmVoYXZpb3IuIEkgd2FzIG5vdCBhd2FyZSB0aGF0
IHRoZSBsZW5ndGggY2FuIGJlIGNoZWNrZWQgYnkgY2FsbGVycyB0bw0KPiBhbGxvY2F0ZSBhIGJp
Z2dlciBidWZmZXIuDQoNClRvIHByZXZlbnQgZnV0dXJlIGNvZGluZyBlcnJvciwgcGxlYXNlIGFk
ZCBjb2RlIGNvbW1lbnRzIGZvciANCmh2X3JpbmdidWZmZXJfcmVhZCgpIHRvIGluZGljYXRlIHRo
YXQgdGhlIGJ1ZmZlcl9hY3R1YWxfbGVuIG1heSBiZSANCm5vbnplcm8gd2hlbiB0aGUgZnVuY3Rp
b24gZmFpbHMsIGFuZCBzaG91bGQgbm90IGJlIHVzZWQgdG8gDQpkZXRlcm1pbmUgaWYgdGhlIGZ1
bmN0aW9uIHN1Y2NlZWRzIG9yIG5vdC4NCg0KVGhhbmtzLA0KLSBIYWl5YW5nDQoNCg==
