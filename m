Return-Path: <linux-hyperv+bounces-1404-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A022829364
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 06:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6424B2623F
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 05:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30779DF56;
	Wed, 10 Jan 2024 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ThExBPkB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2051.outbound.protection.outlook.com [40.92.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624EDDD2;
	Wed, 10 Jan 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuyZojAGjPiRvPiTjcmYEmj4cqzFNIPM5JcSF+omLuHk8FtU8nkt4VuSSU6ciSpn0nZxSRqxxbkRjrBr23CndpRuFlfGij5qIGGB1piGDCz8MM9Rn6HcuKReCn6uXuncl7qMHxq/zQ+ZryNgLDg4NGMHS1iNgx2slSQ0+JCWi6MXe4moEGxlTSJtcJlD/pUVCXgnAxS8BBajAOVvqT30dUIxbfEI5/G3WYecLabFcJXmpBKOSU/6H8UlrRnLjX7dTDVGhqiCPC1x8GBSYRH7cIpu1QwIzSSgy9ut5K098YEccXj0ga5QrhLlTwl+N1MPdR3Re6pQJSLXQWfVWSfDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h8thN5ERseZzihjfOHStkll+XCMSFt2+I2ADGhzw9k=;
 b=jrV2LVC648wvy+vjcYWKkd1L7iGmQI6hKsYGkNqLcKPX75/1zbeayP1GRGNjCgrQR3tqPa9gfrVyrDtY8XI9FDrfmEIUigJLAW3H7A1FA0nUOhIWmKtCr4mkkj5tL2Oe1rJK/xuRkBHJJbpXSWMitgFY1jqxm5Mrf4W2Zd4YRppmy5CIuE5Nm+KOVcEDq/CUw/QPIwFp99GiE9Uy7SBjOp/l9Y+AZpLC7hlMrbHzqcQXT3fjOUtV7GXu0PmqGZSz6Oce5i+3TJXj0Zzwr6TenBHOBpoyKxigClV12KLCAWXbE20PLJR1lrm9NVGvRnOiu5bNnRpou9VxAPokLBuFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h8thN5ERseZzihjfOHStkll+XCMSFt2+I2ADGhzw9k=;
 b=ThExBPkBeXtvrmQqhut9G7no3fK249Ti1r8XsJMFmTxPKwsdq+pdvkUaL5KhCC5FsbYuWobwoIjVm1tjR4zlLwLmCWIRNQ7HqPVRFHrCRVdbcU3WLanJxDwjFn1jHtzZdRDJhQtUqVdpDLGcwSFmXXCHFeX0UjEaf9yW7xXD02c4lAzSVbjkWvdjcqjfyVYES3KZwpMm3gJ0amf1fxy2GgF10Mg5AFcqM4vOKHCojJj3IKx9+lkD3U44Hs5+wnq15znRI6QCCkhp3TO53lZAgcZSMbcHBemfE7QnfoJdGp83ou3CRg8z26xbFFAPjvHyupxi7BvYv9jF/hVe2QshLQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10094.namprd02.prod.outlook.com (2603:10b6:408:190::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 05:41:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 05:41:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: [PATCH] Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Topic: [PATCH] Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Index: AQHaOC8dfueBlyqEhk6cjvGC9x0MmbDSmVng
Date: Wed, 10 Jan 2024 05:41:00 +0000
Message-ID:
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
In-Reply-To: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [WG+4JS+OLxBygT8RaC33IlF+YZY48UWa]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10094:EE_
x-ms-office365-filtering-correlation-id: 935c3a8e-81b4-46e7-61b0-08dc119eba31
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrwI1Z0TlZ/k50Duo0hg8LKEa1BJ8/v3itAbThSpi90YtxqTcfsmb3Rrv9wl2m8BKYqRTKfSlt7z/cUryNWJ0QuIN7z8opFBrhdwnY4ibLuWNBNVjoGZjEcsTuvVqkK02AJ0cXr4ksVCQFv/plKegWVRxk2WI2ADIa4KUYBZrjZaQ25cXzeNNYR4nxXtJeV02g/ZpzS4eys9qQz2u0AoT+ZpZbsL506frNYd/hxWhZ2rPIRtgC57/yZ9Q14FtYPb2zZnIfVI5H6LeDk9HPbUhRbqcfL5NbbSiklUOIJuaBVDhErMQiRPFDPVQTjbetZxf2CuTeIc5iigU/IFjIrL60bGXvBYrDptlumf7KOGdFw1/m345/gEmXIU0+mT4bHliaYfADXLs7URfjZDGUTiOaFq/UvpTVPY4n56Lp/UESjjzfnP7Bx0k2Eqh/p3W7q2XMIUQ0TSBPY0Cot7cMNTtCSxq+oMo4WroA8OvtFN7o4gtQRU7kRD+wbmyvRKrhHM5jt4nm7yCBZ8+UYI07Fu7jiXR/EuJNCwARCi/pYWQ51Kwt/809CRBnMgLOhHY/pBjWhMyIGqANiuNvePXvRw3Aehhli+a2f1uykhRhTlRvLtcTMlUWD3MfpbrBAqEVAcEI/dnyzCWgRBimhbsel6gYGcQTXOvrwZUkDfNYPa3LHhyI5qwm6Bf5XaOFlgKCD1ss+0xcJvA/kNwr0VCg8yKJ5sjvlRr2PpuDtQ8cEgfs3PTDJC/9CcIGLjBU04d9P5XQ=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m85T54TuzGv5QCskV7vf6XteRWsMBFO3QYy7xKcBqqeQ/o2rD9lsHUb9OsTabQkGabRFzqwcGSaimqglb+0Ac4w1vv0k5ZbQyspQJtt9oNTr2MOmTPlPEmrN0qFhw2PedpsJzmdUnyOQjvRGwPjJKkgTnxm2SEoM5e3uTVLpkgce/aZTOnJeNr+V1ZRfXLmjKKKfQHRuR/CpVcwJrE95cVbjpjzYkDX1kCnnMYTP2mE3LbEwsNYLGI/IbT6Yv8SxOv5hJqcpohgyj+7b7ufBFadsTpVYUDkH6V10rtK4AXL64FOUm8xcc8sF/n2Ah/WVK1xGA0yondfRX6g6/YM7sHbHkVTIihq2Qdaf4ayQAimMJIglyU8EWD0o+9KjYkymJFR3wbhrtSDEhkZyYLCGz/TjL9ixG9w8a41LH/3ipx6lsc/+pzXxXw2Wr/QsuGaQIYckqKbqycCcVR2DBxfyMfRsX+v2iRYM0DPqxbmzmb6SX0g41oi78DrJt7Zy9qXZBg57GRGm2sNI7WnYsHAjmrA1+hFrQUU6kUwNkk6ivVjWJs3Hglnhrn+vlTw441Tl
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkJ5di9CRU1FMWJiYUU4WEw5TlRFaTdyR3VDaC95cjM0b2NuODh3WmxrOXEz?=
 =?utf-8?B?WG85c0VEWU8weTRhdFZYLzlTUFkyVFVBaXBZcnRXTHhFeHFFUmtVTTd1alpJ?=
 =?utf-8?B?MVgyNjR1blZqUTAvdEgvaHJnMGJ4UTF4OGdkQVk3ME5IRUxLOFpnVGNTTndn?=
 =?utf-8?B?OG16dVlWdCs3RjN2SXlMQWlzdW1yM1JKTDZNNTVWMTVuOE5WK25xV25TY011?=
 =?utf-8?B?TWQzUFA5ZlpNb215MHBENjRqMG1XU0lqTDlFZi9ESGtqZ2pON1JwSjFlZGEy?=
 =?utf-8?B?UmVueWRRdldoajFGVkhPRDY0TWYyaFFhZmMrUTBkVmkrQmFKYklGOVRLbEE4?=
 =?utf-8?B?WC9aOExFZWxDdmdjQnN1dk5WU1d6ci9ZZVdSWUlxODBZY0t5ZDNNMWNZWm93?=
 =?utf-8?B?U1JSQVV3N0hUV2p0OEFucTZMUkpCVnBxR25UNXN3SFBtTFNLQnJzUm0rQ2VD?=
 =?utf-8?B?MTVqUXNyQjd1SWcxUE9uYzlyTFpTaDZlU3hPTHdRaHdmR2l5aWRJNWZDT1NV?=
 =?utf-8?B?SHIrZGxGVkV0ZVZaRUF0R0w3KzJ5cU9PcHBEWHFqMENtakZIL2Y0Mk02OWhE?=
 =?utf-8?B?YktLYk4rNzFUYkpBclRPek1kSHdCWW1rekgzUmZPMmw4aVVlZEhIU1JqMVNZ?=
 =?utf-8?B?VjhHb09sbE9lRXlNdkU1aHVQc3llSm5YUUgrSEVUMW1RNmRMN3U3b0xuYUV3?=
 =?utf-8?B?bmRteFc3VG03aE5rNEk3VENPem9IZmgwQ1JnQnBWdGJTNCtJRytjMTAyaml1?=
 =?utf-8?B?TVBHblNvdGpZdGdKbDMyU28zdzlkbDd4aTdSS2VwckFqbGV5ZDk5WUVTTTA4?=
 =?utf-8?B?MnV3UEJhL252TDdKbGxFTDdnd3lOY3JvRmlZdUNDN1MxTnRadzgvYTFzWHVK?=
 =?utf-8?B?Q21QdlZ5ZmNHc3E1UXVLdmhjNkZiWENFNVRNUll4MUY0VUR4ZytEMGFGY29w?=
 =?utf-8?B?dSthSkRZRVZ1YTJ0Y3dnSWtBVjdyRHVUeEVUYkRsMG5URnptems3ZUlrN1N5?=
 =?utf-8?B?Y2VSbG13THlNQis2VUNGb0Z4K2ZPcmU4SjZZSWdseVVmNmsvQ2RjUXkvRVBE?=
 =?utf-8?B?M1lpNUJvUzlNSnRidncyOUg1OTJHaHJzT3BWYWorRVFPQVRtTHFaZFJlMzBM?=
 =?utf-8?B?M0Y4SzhudmNPL3V6WkJIVVR6dlUzczFwLzQvWnZ6Zzh0YTVqRk8zREVJcmFu?=
 =?utf-8?B?ditKZ2VtZkJQTXNlWHRwUFJYRTR5NW02RW5YbHFITlFXQ1hXVlhUNFl0R3dM?=
 =?utf-8?B?andDNEhBOUFpckJOaUdpaENBNkt4TkJlTE9CTGtaRFNwYXU1TEtiODhNYkVV?=
 =?utf-8?B?MGpLWTg2VWJjQm1kT1doWDRKejJJUFl2SGFNUGtRSlgwbHlBamRLM1V5R0RW?=
 =?utf-8?B?V1oraE0yQnhZZFlPNy81NXloNzdlWlN3Sk1ZYnlCSlpTc0dWVW1zM2M3eXVk?=
 =?utf-8?B?WnllQjZsR0U5Y2tCL0VVbEhtbUFEREs4Q2JUTnJ0bXRMNWNsTHdHcjNvQy8v?=
 =?utf-8?B?VGxVeHNjRzZKdVVqdzdJZityc09jRnlwV1pnVWpMZDBEOUozQWIvWWNjUkhy?=
 =?utf-8?B?SHdEVk1OdlNLejZxVHN5Zk05Sk8zcEpnTFg5a2xCeU5GZzd0RGRxWFZEWjk3?=
 =?utf-8?B?bHJmcDlXbkJqWUZVTUx0Z3Q0UzFuYmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 935c3a8e-81b4-46e7-61b0-08dc119eba31
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 05:41:00.5917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10094

RnJvbTogTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gU2VudDogVHVlc2Rh
eSwgRGVjZW1iZXIgMjYsIDIwMjMgMTE6MDkgQU0NCj4gDQo+IFRoZSBrZnJlZSgpIGZ1bmN0aW9u
IHdhcyBjYWxsZWQgaW4gdHdvIGNhc2VzIGJ5DQo+IHRoZSBjcmVhdGVfZ3BhZGxfaGVhZGVyKCkg
ZnVuY3Rpb24gZHVyaW5nIGVycm9yIGhhbmRsaW5nDQo+IGV2ZW4gaWYgdGhlIHBhc3NlZCB2YXJp
YWJsZSBjb250YWluZWQgYSBudWxsIHBvaW50ZXIuDQo+IFRoaXMgaXNzdWUgd2FzIGRldGVjdGVk
IGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLg0KPiANCj4gVGh1cyB1c2UgYW5vdGhl
ciBsYWJlbC4NCg0KSW50ZXJlc3RpbmdseSwgdGhlcmUncyBhIHRoaXJkIGNhc2UgaW4gdGhpcyBm
dW5jdGlvbiB3aGVyZQ0KImdvdG8gbm9tZW0iIGlzIGRvbmUsIGFuZCBpbiB0aGlzIGNhc2UsIG1z
Z2JvZHkgaXMgTlVMTC4NCkRvZXMgQ29jY2luZWxsZSBub3QgY29tcGxhaW4gYWJvdXQgdGhhdCBj
YXNlIGFzIHdlbGw/DQoNCkFzIEknbSBzdXJlIHlvdSBrbm93LCB0aGUgY29kZSBpcyBjb3JyZWN0
IGFzIGlzLCBiZWNhdXNlIGtmcmVlKCkNCmNoZWNrcyBmb3IgYSBOVUxMIGFyZ3VtZW50LiAgU28g
dGhpcyBpcyByZWFsbHkgYW4gZXhlcmNpc2UgaW4NCm1ha2luZyBDb2NjaW5lbGxlIGhhcHB5LiAg
VG8gbWUsIHRoZSBhZGRpdGlvbmFsIGxhYmVsIGlzDQppbmNyZW1lbnRhbCBjb21wbGV4aXR5IGZv
ciBzb21lb25lIHRvIGRlYWwgd2l0aCB3aGVuDQpyZWFkaW5nIHRoZSBjb2RlIGF0IHNvbWUgdGlt
ZSBpbiB0aGUgZnV0dXJlLiAgU28gSSdkIHZvdGUgZm9yDQpsZWF2aW5nIHRoZSBjb2RlIGFzIGlz
LiAgQnV0IGl0J3Mgbm90IGEgYmlnIGRlYWwgZWl0aGVyIHdheS4gIEkNCmNhbiBzZWUgeW91J3Zl
IGJlZW4gY2xlYW5pbmcgdXAgYSBsb3Qgb2YgQ29jY2luZWxsZS1yZXBvcnRlZA0KaXNzdWVzIGFj
cm9zcyB0aGUga2VybmVsLCBtb3N0IG9mIHdoaWNoIHJlc3VsdCBpbiBjb2RlDQpzaW1wbGlmaWNh
dGlvbnMuICBJZiBsZWF2aW5nIHRoaXMgdW5jaGFuZ2VkIGNhdXNlcyB5b3UgcHJvYmxlbXMsDQp0
aGVuIEkgd29uJ3Qgb2JqZWN0ICh0aG91Z2ggcGVyaGFwcyB0aGF0IDNyZCAiZ290byBub21lbSIN
CnNob3VsZCBiZSBkZWFsdCB3aXRoIGFzIHdlbGwgZm9yIGNvbnNpc3RlbmN5KS4NCg0KTWljaGFl
bA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5z
b3VyY2Vmb3JnZS5uZXQ+DQo+IC0tLQ0KPiAgZHJpdmVycy9odi9jaGFubmVsLmMgfCA1ICsrKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvY2hhbm5lbC5jIGIvZHJpdmVycy9odi9jaGFubmVs
LmMNCj4gaW5kZXggNTZmN2UwNmM2NzNlLi40ZDFiYmRhODk1ZDggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaHYvY2hhbm5lbC5jDQo+ICsrKyBiL2RyaXZlcnMvaHYvY2hhbm5lbC5jDQo+IEBAIC0z
MzYsNyArMzM2LDcgQEAgc3RhdGljIGludCBjcmVhdGVfZ3BhZGxfaGVhZGVyKGVudW0gaHZfZ3Bh
ZGxfdHlwZSB0eXBlLCB2b2lkICprYnVmZmVyLA0KPiAgCQkJICBzaXplb2Yoc3RydWN0IGdwYV9y
YW5nZSkgKyBwZm5jb3VudCAqIHNpemVvZih1NjQpOw0KPiAgCQltc2doZWFkZXIgPSAga3phbGxv
Yyhtc2dzaXplLCBHRlBfS0VSTkVMKTsNCj4gIAkJaWYgKCFtc2doZWFkZXIpDQo+IC0JCQlnb3Rv
IG5vbWVtOw0KPiArCQkJZ290byBmcmVlX2JvZHk7DQo+IA0KPiAgCQlJTklUX0xJU1RfSEVBRCgm
bXNnaGVhZGVyLT5zdWJtc2dsaXN0KTsNCj4gIAkJbXNnaGVhZGVyLT5tc2dzaXplID0gbXNnc2l6
ZTsNCj4gQEAgLTQxNyw3ICs0MTcsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV9ncGFkbF9oZWFkZXIo
ZW51bSBodl9ncGFkbF90eXBlIHR5cGUsIHZvaWQgKmtidWZmZXIsDQo+ICAJCQkgIHNpemVvZihz
dHJ1Y3QgZ3BhX3JhbmdlKSArIHBhZ2Vjb3VudCAqIHNpemVvZih1NjQpOw0KPiAgCQltc2doZWFk
ZXIgPSBremFsbG9jKG1zZ3NpemUsIEdGUF9LRVJORUwpOw0KPiAgCQlpZiAobXNnaGVhZGVyID09
IE5VTEwpDQo+IC0JCQlnb3RvIG5vbWVtOw0KPiArCQkJZ290byBmcmVlX2JvZHk7DQo+IA0KPiAg
CQlJTklUX0xJU1RfSEVBRCgmbXNnaGVhZGVyLT5zdWJtc2dsaXN0KTsNCj4gIAkJbXNnaGVhZGVy
LT5tc2dzaXplID0gbXNnc2l6ZTsNCj4gQEAgLTQzOSw2ICs0MzksNyBAQCBzdGF0aWMgaW50IGNy
ZWF0ZV9ncGFkbF9oZWFkZXIoZW51bSBodl9ncGFkbF90eXBlIHR5cGUsIHZvaWQgKmtidWZmZXIs
DQo+ICAJcmV0dXJuIDA7DQo+ICBub21lbToNCj4gIAlrZnJlZShtc2doZWFkZXIpOw0KPiArZnJl
ZV9ib2R5Og0KPiAgCWtmcmVlKG1zZ2JvZHkpOw0KPiAgCXJldHVybiAtRU5PTUVNOw0KPiAgfQ0K
PiAtLQ0KPiAyLjQzLjANCj4gDQoNCg==

