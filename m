Return-Path: <linux-hyperv+bounces-1113-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694487FC443
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA03282C6C
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222046BB9;
	Tue, 28 Nov 2023 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y3a6R9YT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2027.outbound.protection.outlook.com [40.92.22.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B74D5D;
	Tue, 28 Nov 2023 11:29:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmuDBVT8FZdilkkeNRpSqnkXjwmS5NLgO+AKFts3zU59kBvSaH+0FC49e75Q85BM82/hq4FwKsFEIhDHujAfvPtyJFJXlJZ/9wg5rCbQB0OZSvu0yRa893a8iVCNJ9CbvjnVFcsLJgaNS/1Ye94THyZOHk5E5QtrQtP2DHvJ5T1LfUHbHxuYoHwRivZnpzLIWhEk4o+Lt+uyW0YfJ/0Ni4bsgBMaiksKOJ2SO8hn+OAU4VjuMd6jT8ytz1/H6NjlArL5RspRd5FNoKwH2SlR+o4z97cXZbf42cM6zHDTb7q3CaH8/xBvO2TkRM2c2xVBsgcYiysWAaERJU7l77dktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6Y8Z6jdGSPLPOpVhoXNUQTQFlTM7Ct5l5M8MSaOHgY=;
 b=Ykp8rAZbUONZgXFpwvOjSKk2acyVNcSywjtPxBcxV+I3qZIotgq7EkCSI83V3VJkiI8oS4ot5P0+BLBbetuZ4vTv5yx9Z7hBg3WvGbM+ACdzgmDagZNNF9OsQIyhJxtJbqzNC8ntUgLt5i5nCssHyjatP+SdGKomUXvjxteGdJvQmDYjyvLYxrDG72bJdFfRVHBA60BxBd9hKUOby+tlAke+6UvzfaX40t4ZSHPqVNXYOK7rEDSS0653dvTEQdX6otC9U29b2kyR5bRPku0rGNYtBg+MzMzh/g5FPVDyMJ7CaHtLk4E5IrNelt0apVyPHOUDe9Bm4VaFlcBjGtk7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6Y8Z6jdGSPLPOpVhoXNUQTQFlTM7Ct5l5M8MSaOHgY=;
 b=Y3a6R9YT4v5eiBZiVap7xbw5m+j8qmJBXseE9WTNeqiUc0sN1iSEfE7h4MS8Uzduya3KIYqhbE8ttQOOQ5UrHX7YGM0pRjZwH1h+pi6ZX4t/iS2lUQW28EzMjegGI/yrCNd/ePRy+J8QX53MxuuAufALVfM/nNanBa3WcnFIfgPqaI4LZXn5AruUuezDUr8jCsTN3DveFGb8liRMa6Jvf+Hq4EM1GC3CE8mOcO1d0JRPy0RangQr1Bmz0S0t7sG9gE64j+mivnzpWNOCKM6nUO9qkqhIgQB2OULHG1dNUV94vevxRDrzypx2DXujCBKRUrfiabi4MYrm4OueBq3u/g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6536.namprd02.prod.outlook.com (2603:10b6:a03:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 19:29:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 19:29:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jens Axboe <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: Merging raw block device writes
Thread-Topic: Merging raw block device writes
Thread-Index: AdofxfWKzDnDIAxSQBW3cNh7xAf+zABOU3UAABM6mYAAONXboA==
Date: Tue, 28 Nov 2023 19:29:02 +0000
Message-ID:
 <SN6PR02MB41578DD2B7A1F25336B0224BD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20231127065928.GA27811@lst.de>
 <f2735bdc-1234-4477-a579-90bafa7ae4ea@kernel.dk>
In-Reply-To: <f2735bdc-1234-4477-a579-90bafa7ae4ea@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ifoWd9J2G44+K/0RZRbfumUtbDy2vf+y]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6536:EE_
x-ms-office365-filtering-correlation-id: 668471dd-b956-488c-feb6-08dbf0484707
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9AnG8Pr3Bw/1erosNowkZ/WXy5j27Zwrm0KZPD+YK6sI3+TGbb4AUH5+yWyPbcwIpefRblydwn9b9azVKvDx/J6mp3ics9jdG2dEDxq9LBRSdGIBKLyKelfZc108A+WS7WW4TczSofM9RIooAJQoRKBY1XlMCHaT7SO5tlBDIMFC9cq95AZ2M03J/lNEVcKk7STaoJ134ULCIT8tpEBGGPTvSv79/iQ9LKOjXRm8Y28NZucxwSXBCNqb6w417ZsMcoGTRN3m/zitniJvCMewv/+lYDJNuUhVP2kTa2zDTt9VHkd0DD4e9C3weprt1WHVqFHMKqdaT5D62Fn+MbYIkouyvpLckiPVwXW6ZiMRzPaq0Vlr+i7IgJj6k21nenQq8sGllr/PccHgwfCs86nZBx4QPtPoZHi6pqYBN6tLXM+8tRDXRPUqZupljUbeoqbrhJf3BN3fRUd+oZbSfgNiQ8YOHumMJaTIh8k5DIDfjlz+p9nw/QAsxno/mQ0xeYkkzT5iCE3f0KJgLEOSR2Wkja2tmBQdweR2f9Qwcl0tqrTgVe/Z8/IgFH7PaoN6Z/i8
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXZnRkZuTnQ0VHdrTm5MVDk1dHBkNURLSE4zRzVvdXArUkNZL05wUHpQRTBL?=
 =?utf-8?B?TUV2OVVnaloyeG9oNUFjcHQvLzc2VjJ3dndWOCtsOFQ1cW5PRG0rL0NUSERp?=
 =?utf-8?B?ZjZaZHZJUE4vTWhPeU5LVm9MOFNoZmltWHJIWjRBTnoyWjExQmxNdVVJcUVF?=
 =?utf-8?B?eXphbjVkS2JZd0ViOHJDMXBHZlczVUs4dlZnZjlMQWJUY3dkQ1RQWGQ5Z3JP?=
 =?utf-8?B?MVl3VjN0QzM1QU4vRlV5S3M1eFNPZUhTbnJLT292ZkpBdjlYR04wUUMxaXV1?=
 =?utf-8?B?ZVFxRldtbkRaYVlLK3FSQTZGOEZvU1JpTTRNMTkrQklUajh4Tmdvc3BZdUk1?=
 =?utf-8?B?Vk1YbTFaK2NaSHlYc3E3LzZaS0MzUk5MRTFyTDZNNXUyS3kvaDZjK2VWanNj?=
 =?utf-8?B?UnFveXdvamtIVzV1OVhuQ2drUk8wV0VjTURoUE9XdGwwMk1ZQjlUUzRaY1Iv?=
 =?utf-8?B?Q1VNVHk4TjJTckdoeUVTTWlRY3I3eWlPcmoxYUw1cWFZS3gxRUozeUQ0Mm8r?=
 =?utf-8?B?dzVpM3hjV0xNZkd2cG5BN1pFZGhwRmhrRXRSRjltTEc5UEJmcThDZVlLSGtH?=
 =?utf-8?B?NU9FWnhHaVRNQk42M0kzbkgvRGd1OVczMTJFcFdtRnlod291Smw3R1g4R0Jq?=
 =?utf-8?B?Mkh0WnhFU3VaL0xjcC8vZDJjS0grUkxmWUUyY2ZFWU8zeThxV2hZU2lJbis3?=
 =?utf-8?B?WXpOMnVIMHlHQUs5ZHVMT29aQ1lYcWlWaUltS3B1NTFUL0F3MjlleUZ5V3hB?=
 =?utf-8?B?ZU9vVit4bERvV2llMXRVRG9WTnZoVk92dTVBNnVadUc2TGlZVTNiVVRETTNI?=
 =?utf-8?B?a1FITE0yTHNjczJGV1pMSzk4Rjh2Wnh5Zk01Ujh3VWNCbHB6blE0YnhFT1l6?=
 =?utf-8?B?SHJUTlcyNXorRUd3WjNIZEpoT3lOR3V3UENNVXBwS1diaWJ0blFadGtMU3Rv?=
 =?utf-8?B?N1lLV3dQR2pnbEhPaTJ5Q0xoZ1FUT012SjlmelgvUE1NUGxRT04ramoxME9I?=
 =?utf-8?B?bko1U1ZJWnFoQWdPMmhNTHdVcHNiRlJST2NxamJLVStBeEZuK2NYUkxJdXNw?=
 =?utf-8?B?RjhKWFphQm9jcjQxOTFhWVhlNzJNR1lrZnNSS2IvbTdQYmRGWCtrNStCdXJ6?=
 =?utf-8?B?Y20wVDRsWUt1dlpKVk1VSWxzYzg5V0VnSXJkWG9pWG5idnRmaDZraENhSWVt?=
 =?utf-8?B?N05Reno5UXJUNmFpbmNlaDljT2tvZHNtb0pWSGhNc3FqRTMrejJrSmhHYUN2?=
 =?utf-8?B?YkZITGxaMXNubCtjbldhSUdERytRZHYweURxT3VrK1Fnb3BEdFA2OGQrbURZ?=
 =?utf-8?B?OTJUcmZIMm51a1ExR0U5VFZSWWdEK1U2Nnh6OVIvWUhjNzNhd3RKZjlSZXZX?=
 =?utf-8?B?emhhOEorell2VXRNNnBETzZMRlFoOWNpcFdqQzRqYitjQWk0SFJ0NGNPUWZT?=
 =?utf-8?B?QUoveUZLY2NRaEIwb285emFYNHVLd1lhY3pHcjk4UnhMMDQyVXk0d0tCQmJm?=
 =?utf-8?B?UmlmMDh0cFZ5Y2VYMVVVVGQ4Zk05aHRrV2czMjlaNHdnWWRxTCtRTm1xZlFW?=
 =?utf-8?Q?taKP+xwCQI07R888KLRciek0c8RM/YG2uSbxEw6sPFO+PH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 668471dd-b956-488c-feb6-08dbf0484707
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 19:29:02.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6536

RnJvbTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPiBTZW50OiBNb25kYXksIE5vdmVtYmVy
IDI3LCAyMDIzIDg6MTAgQU0NCj4gDQo+IE9uIDExLzI2LzIzIDExOjU5IFBNLCBoY2hAbHN0LmRl
IHdyb3RlOg0KPiA+IE9uIFNhdCwgTm92IDI1LCAyMDIzIGF0IDA1OjM4OjI4UE0gKzAwMDAsIE1p
Y2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+PiBIeXBlci1WIGd1ZXN0cyBhbmQgdGhlIEF6dXJlIGNs
b3VkIGhhdmUgYSBwYXJ0aWN1bGFyIGludGVyZXN0IGhlcmUNCj4gPj4gYmVjYXVzZSBIeXBlci1W
IGd1ZXN0cyB1c2VzIFNDU0kgYXMgdGhlIHN0YW5kYXJkIGludGVyZmFjZSB0byB2aXJ0dWFsDQo+
ID4+IGRpc2tzLiAgQXp1cmUgY2xvdWQgZGlza3MgY2FuIGJlIHRocm90dGxlZCB0byBhIGxpbWl0
ZWQgbnVtYmVyIG9mIElPUFMsDQo+ID4+IHNvIHRoZSBudW1iZXIgb2YgaW4tZmxpZ2h0cyBJL09z
IGNhbiBiZSByZWxhdGl2ZWx5IGhpZ2gsIGFuZA0KPiA+PiBtZXJnaW5nIGNhbiBiZSBiZW5lZmlj
aWFsIHRvIHN0YXlpbmcgd2l0aGluIHRoZSB0aHJvdHRsZQ0KPiA+PiBsaW1pdHMuICBPZiB0aGUg
ZmxpcCBzaWRlLCB0aGlzIHByb2JsZW0gaGFzbid0IGdlbmVyYXRlZCBjb21wbGFpbnRzDQo+ID4+
IG92ZXIgdGhlIGxhc3QgMTggbW9udGhzIHRoYXQgSSdtIGF3YXJlIG9mLCB0aG91Z2ggdGhhdCBt
YXkgYmUgbW9yZQ0KPiA+PiBiZWNhdXNlIGNvbW1lcmNpYWwgZGlzdHJvcyBoYXZlbid0IGJlZW4g
cnVubmluZyA1LjE2IG9yIGxhdGVyIGtlcm5lbHMNCj4gPj4gdW50aWwgcmVsYXRpdmVseSByZWNl
bnRseS4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIG1vcmUgaW1wb3J0YW50IHRoaW5nIGlzIHRoYXQg
aWYgeW91IGNhcmUgYWJvdXQgcmVkdWNpbmcNCj4gPiB0aGUgbnVtYmVyIG9mIEkvT3MgeW91IHBy
b2JhYmx5IHNob3VsZCB1c2UgYW4gSS9PIHNjaGVkdWxlci4gIFJlZHVjaW5nDQo+ID4gdGhlIG51
bWJlciBvZiBJL09zIHdpdGhvdXQgYW4gSS9PIHNjaGVkdWxlciBpc24ndCAoYW5kIEknbGwgYXJn
dWUNCj4gPiBzaG91bGRuJ3QpIGJlIGEgY29uY2VybiBmb3IgdGhlIG5vbiBJL08gc2NoZWR1bGVy
Lg0KPiANCj4gWWVwIGZ1bGx5IGFncmVlLg0KPiANCg0KT0suICBCdXQgdGhlcmUgKmlzKiBpbnRl
bnRpb25hbCBmdW5jdGlvbmFsaXR5IGluIGJsay1tcSB0byBkbyBtZXJnaW5nDQpldmVuIHdoZW4g
dGhlcmUncyBubyBJL08gc2NoZWR1bGVyLiAgSWYgdGhhdCBmdW5jdGlvbmFsaXR5IGJyZWFrcywg
aXMNCnRoYXQgY29uc2lkZXJlZCBhIGJ1ZyBhbmQgcmVncmVzc2lvbj8gIFRoZSBmdW5jdGlvbmFs
aXR5IG9ubHkgYWZmZWN0cw0KcGVyZm9ybWFuY2UgYW5kIG5vdCBjb3JyZWN0bmVzcywgc28gbWF5
YmUgaXQncyBhIGJpdCBvZiBhIGdyYXkgYXJlYS4NCg0KSXQncyBhbGwgd29ya2luZyBhZ2FpbiBh
cyBvZiA2LjUsIHNvIHRoZSBvbmx5IHBvdGVudGlhbCBjb2RlIGFjdGlvbiBpcyB0bw0KYmFja3Bv
cnQgQ2hyaXN0b3BoJ3MgY29tbWl0IHRvIHN0YWJsZSByZWxlYXNlcy4gQnV0IGl0IHN0aWxsIHNl
ZW1zIGxpa2UNCnRoZXJlIHNob3VsZCBiZSBhbiBleHBsaWNpdCBzdGF0ZW1lbnQgYWJvdXQgd2hh
dCB0byBleHBlY3QgZ29pbmcgZm9yd2FyZC4NClNob3VsZCB0aGUgY29kZSBmb3IgZG9pbmcgbWVy
Z2luZyB3aXRoIG5vIEkvTyBzY2hlZHVsZXIgYmUgcmVtb3ZlZCwgb3INCmF0IGxlYXN0IHB1dCBv
biB0aGUgZGVwcmVjYXRpb24gcGF0aD8NCg0KTWljaGFlbCANCg==

