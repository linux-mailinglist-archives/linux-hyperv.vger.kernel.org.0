Return-Path: <linux-hyperv+bounces-1511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22398849FA4
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 17:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC26B244F4
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D713FB34;
	Mon,  5 Feb 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="omaRc+ZA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2055.outbound.protection.outlook.com [40.92.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9E3FB09;
	Mon,  5 Feb 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151243; cv=fail; b=afrXgaOy0sVLH9obnXI/eyqxCgmBK2+ndYobIOSl96H9+q7awTL9YOf5R4Rh0IkjiB2Law9p6ANkP3pLY1+Y4fgOiiPLEixH6WovTQ5efkpRYqliIK01qIy5WS46DhGzuDOKvGuLUUtQaQBnCvp7404L/RP8D+eCSSD11cz4bHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151243; c=relaxed/simple;
	bh=vrY3Y4pdaCfb36imWKi/Qui7hF5+BT4jDKiQkBiSmNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u9pPQbI+QEYqoztvp4L+ESI+uWJ33jgVis7hfx3iyH6JxAzFdjRQe+8cHH3lpvsFE9fMIDYJ8I5MahBtBqU8NVXA0vYaz7H0/aoBSv89ezWcQIeidBgrbsUZSMh889ZuPCLv8qBHjvc0EuqypzZyTuF3vO3eOiHTiJAkA0bx/vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=omaRc+ZA; arc=fail smtp.client-ip=40.92.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD1KFnxBKvtzNPj7nBB3Z6v3qlMtet8AJ4fYwAt4zuvYE7CXMfBVf0kE9C9P2Rfvp51Db4LLPxiSrjPJXR3OtMknJmHb3DPNxp0aGq9kTHhuj34GCvhoLCCgtlrRioWo2pMhRaXV4X7xf1xFdQW5ZR7cXIyF9q2QNPsaMdGb0mxZzjF5FLAPl/YelyaTL1wZ/kAPOsitRHz0oPiWIfdr2wSaCjxiuZEEf56ifvbh+eUkTlnQnF467OCc7StIwpfDvZweq5rLY/rPhgbwaZoN3UyGRFW59yEVkd4eQcIOWam83m4Sq9aKxLuK9p74wC0Pl7VsrDOWnY6aHpPoGVT43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrY3Y4pdaCfb36imWKi/Qui7hF5+BT4jDKiQkBiSmNE=;
 b=H7MdTkNcO1Y+iWlFth7x8UMxBz9A8MfYLOQe9wBMZri/6bVaZImBiekv7pBUmV/o6iGOCDCqatFh+9P4WBQgRV/WND0NAQOeqSQwwUo/uztMdtAj8MRBOvoIXyE1fMDEIf+ssJaF9VPA3SUcHUG28JB+75j4nlrQ1YidprAtDrgg4ak0AMVmaVoal8UOFeVkJco31l65fYF/o4rKBRdenFfEiFUbibDHVDBry72Q5PykULGEh/YkHYT8YhjMEV8HqpTAq08FasaSoUncznSpgSr8Ip6ENzrAj0J5YtYNCrn+7tnzyDdM3ScrNbGvSRTospPhRSPDCcFS2WEkOTOGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrY3Y4pdaCfb36imWKi/Qui7hF5+BT4jDKiQkBiSmNE=;
 b=omaRc+ZATF+zlHz5qcQq6qxoOPsMXTsabrlGj5kfZNTFdY6M5K0F6iPxVBGijemVa0eP3wZlNUVxxoo3T97efrxstasGEAeZH7Pbl2n4Na+akfom83FdBixFvCu5Q03D5+046EDSN+5z7iyWIFrwShBix2GxyVKkmbtm0WkP+F+FtJXsfadyVQ32UB+x5qwfEc0hEH1IFg6lm6GbQzSSm6HqS3s2r3rDfFVgqFFkMxNKMU4pxLWE0GK3/GNI61McYt0WdejU4jR3ki/8QNzB+WD07fESiX/urvLNcfDekNIsVY4+b3vYqk4YXHHhZ0LIm41pmo7u6mClxcjnizDTbw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9544.namprd02.prod.outlook.com (2603:10b6:930:76::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 16:40:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.027; Mon, 5 Feb 2024
 16:40:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] hv: vmbus: make hv_bus const
Thread-Topic: [PATCH] hv: vmbus: make hv_bus const
Thread-Index: AQHaV4iGhSzTSPrxL0WbSo2w3R6cULD79HwA
Date: Mon, 5 Feb 2024 16:40:37 +0000
Message-ID:
 <SN6PR02MB4157130171E614FED60FDC1ED4472@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>
In-Reply-To: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [h+AJGDIexJ/8UdXQ0SAXnG4NQKdemeVT]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9544:EE_
x-ms-office365-filtering-correlation-id: cbe37f9e-c87f-4720-cf93-08dc26692ea8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zDJhUI897Ev/TPa+fZgrlfq2Fw75OW6M3B6FL4rqgviWzYEPFOCwpbPzRoX0/RMwhdJPDjD0rlrlO/ft8uLFlttw6Aw8lx4NAZAVu8QhGB85T9wqLie94d4EgU/CpYMNSXXMDIDZOS7KNlP9hRw3DdnAbmzNpDpyYd6FyLxl2+hl/4V8kHIyG4xaPxVICQd8w2vKXfeDYeAYORrU5H3XWSWAnranZAsd0zi6Zx+O9pVax9LNbRPicg+QM/xYfUCCdk7Q5Tm2DEc8wUhO4RNIDz+qi1tqNUpNKnGR1ZzzmQ3NUq0WHw9BV4cgJXhomMXQlo5Era1GB2CrccvM1HBL3Ao9N22vUw9MfAiapSDT2OPqUHAf2yDzTKF/9+t6Q+3pws2UzNU/dc+T0D53G0z6Cds5CkDj/SIjGYytcLz8+8RgsIzJ30SWpRsbSx3E3Rd0/19ZcfR5cTQ/w9i/qe3Mh8oBu13hbr5katnn0ygsJnzsO6rtigljHdqzJY4xWQbilPV9DAu397d+a196bgO3ybUYOEpqkC4OyL5wCps0suuTVJNZFQ3AovK5aqBiuv9y
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHFlbHpFUUVOZUMrTlRrL1FFQ1BWQVZ5bkFpMHdCU0QydHhzbk5TL3FmeEsy?=
 =?utf-8?B?NThFa1g4SGRONEQ1UVc0aU9xZWx5TVV3c2tvNnJuL2JkdW05ZE1LdDJlSkFo?=
 =?utf-8?B?ME1mbE9lQm5aWU5JU0lkaHMyZWNSWEFvNlNlbjFXVkM5OEEvQ0Rma2o1azg0?=
 =?utf-8?B?QnNmVjE1RW5qelVNTXdZT2lmSkxoakpxRjIvODU3QXRrdDR4ZXZKZXdHekVX?=
 =?utf-8?B?UXlkK3pudGl4NndyOVNqQitZUjQxNEZGd09GdjEvMDY5VnVDdjJpd1E1ZE14?=
 =?utf-8?B?WkRFNms4MitKcVdrOFM1bUoyenhlR0hxVFBZL0VSVnlzZjI4YlVleHo4N2xn?=
 =?utf-8?B?YndwQllIM2tqNWhuVTJpK1hCYVpaVkRCMFNGbDJ0NDZZczJLWjdmMzh3NU1N?=
 =?utf-8?B?dDJtZ1d2V0ZYanBlUVlIbGo1VGhucS9VZk8vaWxjSWtmU0lMeHFMTm1YU3Z0?=
 =?utf-8?B?VVU5YWxvcWErV0s1dkdpZ2EzRzRSSGl0RmlhemtoTndQREM3d1JkdmFGVzlW?=
 =?utf-8?B?MlMzM0hnVEVIWUh6WGFaSlpwTW5Yam5JeVk0ZUJTUThTVldCN2dpQ0FXZnU0?=
 =?utf-8?B?ZWVYMUxxRDlqcFZ3SXkxRk9tTDNqZ3cvOXMvWTE5dXF4d2x1N0FtaXBCZWV6?=
 =?utf-8?B?REMxcjJnbUR4TTl6cHVGbGh6L2hCREJVR1FRSTBxSzZaNnpKVDg4TUlqaDlL?=
 =?utf-8?B?WitTa1lRYTJLODJ0VU5KT1R3MENBMGVZUVcxTGFhY2NzbmcvZ0NrUEovSCtI?=
 =?utf-8?B?UC9VZS8rNnRIMGR3a0FOcnU2SWZzRTh0bnJxVmVXQ2RLSHNKTjEyUi96WkVy?=
 =?utf-8?B?N1Z2dmJGZXVVM0o3Skw4MlVVMXRTUk9Ia2txOGIwZjFsMGhmczdBYlhWRitZ?=
 =?utf-8?B?TzdMdzBBZUJrSE1mTGlUODByUXNIaWN3dUNlTmdyZEhuZi80eWxXUUZqbmhk?=
 =?utf-8?B?OFpndW5VQXlLUUkrenJUNktYa1k3cWRyZHBCTTVFeXBhUUx2amxLNDNLRlZ0?=
 =?utf-8?B?VzFwMWRBUGNCRDMvK296ajJHMGFxRUJiK2R0TURITzczTmJiMVk1TU9sNVlm?=
 =?utf-8?B?ZWJ0cUNTN2FIeDRVS0R2d293dkM0c2x5Y084RDhXRjFyaGZVbW1rVk9hY2dp?=
 =?utf-8?B?TU1oRXFOY1VrUGkwWEd4OWc3Y3BHWUVCVmFEWWY3V0lGSEFLWktnL2kyeHF4?=
 =?utf-8?B?QkY2RERvbGZJOXljdVV5clVSb1liblBHbldGQk1pM3NmV2grRVIybUZ5TDRL?=
 =?utf-8?B?em1qSWNmQWNLVDRWWUdQR1NlNW8vS2tjeGloc1VVVTZ4d2FQL0RORmtodFc3?=
 =?utf-8?B?R1VGQnUwSnoxVEIxaUNPYmhtM09vc1hXV29naFJVTDI2QkI3RlhsU3lpUWcv?=
 =?utf-8?B?blB1aklVNDRLcUQrRzlZbGZkSTE3REJjSlM0Vmg1c1dBSU9qVTNzYjVsNXNh?=
 =?utf-8?B?YlhlTjZ4TFliR0pOa3FJUG8wK1RKSVcyYnFTS0xlQlN4dmJqdHFjbHc3Umxz?=
 =?utf-8?B?K0pmTFM4MFFkK1FCVzRlcHNZS0RQcDA0TW9wV1Q4VitoRnFwRERHdWVRbERQ?=
 =?utf-8?B?VWZhRzJsOHU3dTQvd2ZocDNBQ0RiV1hUcmluMzRBT3I0RjRyWVg4S01iV25I?=
 =?utf-8?B?Y2JjR3dqNnpNb2R2MzNrTElDUS9iSkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe37f9e-c87f-4720-cf93-08dc26692ea8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 16:40:37.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9544

RnJvbTogUmljYXJkbyBCLiBNYXJsaWVyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+IFNlbnQ6IFN1
bmRheSwgRmVicnVhcnkgNCwgMjAyNCA4OjM4IEFNDQo+IA0KDQpOSVQ6ICBGb3IgY29uc2lzdGVu
Y3ksIHdlIHRyeSB0byB1c2UgIkRyaXZlcnM6IGh2OiB2bWJ1czoiIGFzIHRoZSBwcmVmaXggb24g
dGhlDQpTdWJqZWN0IGxpbmUgZm9yIHBhdGNoZXMgdG8gdm1idXNfZHJ2LmMuDQoNCk90aGVyd2lz
ZSwNCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4N
Cg0KPiBOb3cgdGhhdCB0aGUgZHJpdmVyIGNvcmUgY2FuIHByb3Blcmx5IGhhbmRsZSBjb25zdGFu
dCBzdHJ1Y3QgYnVzX3R5cGUsDQo+IG1vdmUgdGhlIGh2X2J1cyB2YXJpYWJsZSB0byBiZSBhIGNv
bnN0YW50IHN0cnVjdHVyZSBhcyB3ZWxsLA0KPiBwbGFjaW5nIGl0IGludG8gcmVhZC1vbmx5IG1l
bW9yeSB3aGljaCBjYW4gbm90IGJlIG1vZGlmaWVkIGF0IHJ1bnRpbWUuDQo+IA0KPiBDYzogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU3VnZ2VzdGVk
LWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBT
aWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpZXJlIDxyaWNhcmRvQG1hcmxpZXJlLm5ldD4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9odi92bWJ1c19kcnYuYyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gaW5kZXggZWRi
YjM4ZjY5NTZiLi5jNGU2ZDlmMWI1MTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaHYvdm1idXNf
ZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiBAQCAtOTg4LDcgKzk4OCw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyB2bWJ1c19wbSA9IHsNCj4gIH07DQo+
IA0KPiAgLyogVGhlIG9uZSBhbmQgb25seSBvbmUgKi8NCj4gLXN0YXRpYyBzdHJ1Y3QgYnVzX3R5
cGUgIGh2X2J1cyA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYnVzX3R5cGUgIGh2X2J1cyA9
IHsNCj4gIAkubmFtZSA9CQkidm1idXMiLA0KPiAgCS5tYXRjaCA9CQl2bWJ1c19tYXRjaCwNCj4g
IAkuc2h1dGRvd24gPQkJdm1idXNfc2h1dGRvd24sDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6
IGNlOWVjY2EwMjM4YjE0MGI4OGY0Mzg1OWIyMTFjOWZkZmQ4ZTViNzANCj4gY2hhbmdlLWlkOiAy
MDI0MDIwNC1idXNfY2xlYW51cC1odi0yY2E4YTQ2MDNlYmMNCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gLS0NCj4gUmljYXJkbyBCLiBNYXJsaWVyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+DQo+IA0K
DQo=

