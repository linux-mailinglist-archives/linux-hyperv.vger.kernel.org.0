Return-Path: <linux-hyperv+bounces-3173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CCD9AB53D
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11D6280A1B
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E61A4F01;
	Tue, 22 Oct 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jHPptEQY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010011.outbound.protection.outlook.com [52.103.13.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2B13BC1E;
	Tue, 22 Oct 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618723; cv=fail; b=bZ3SH4/8kViF8phoFN7Mboyzy07BGwTk9plSur3nePIlUkmqbrL386zvjE0bDcsZw3dTKKoCAqz/+AcSOrJZoqOkanTUM0k5J6qaqCk+cZhlOoSivflixTvO6+F82pfgtH6fTqcTPn/vmFQzibWzM6GvlbfJOJM0sofFnO6cGmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618723; c=relaxed/simple;
	bh=ee4QUhmJCPoULHOU0K+aGZu+HeiYR4uEbQ+9Si87Mbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmmJ7ynwIWbq6m8ROIiyWqDvaW04PI+8ekoKhWGqtE8f88CYORrlrwf5oioLBV81tuzV+XJIbca7OzhIodUcU72xlXYsfp+wK70G6V24t3GVUYdHwy6N/ylUTbEvV/gZLg/iusGCPNpWCyk18ZdYKJU9N+qrjmiEznOte9aBYsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jHPptEQY; arc=fail smtp.client-ip=52.103.13.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO1vuZCWUK5XdlKUA7gm98cSethEGfr3NJ3u1JeF4wP7xvBdD5eKfALagZJGrA8cH1oDeYP8hC0Op3IR3M03QkdCVtHl8mdvVK42jEOBJtdz+Wxv4Fx1Jip62nj58rOBhZgT7i943EUsTsotgekZvjWRPmtEEXJvffz5AIJJp112mYmsMrfA9oeeNfrioEdmxN0lQjNTowo9C9INFS1Xk56fkGBQiSdzuj+43YkyBsjErSUdtEF/EBH0xzCOzf8yoHC/y+6/s0kujaJwtnFKP9sM/w3ftnkw6CBVEMtaPFPFZ5Np7l2oSrcRrZtk+B/zaCiJbeyWRHABs87OUBofzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee4QUhmJCPoULHOU0K+aGZu+HeiYR4uEbQ+9Si87Mbw=;
 b=sL/TwueIDvPoMALMqnOukt8gaibXSFCAeBgfE5DGC5gNBJMQ7zI4p3TJVPCyHHo7K/kRZKBtv7Ch4JANw6ClQZTE8Nawmn9o8rkeI2yB38G5fcY9bdOQ3XUNZbpb9iSmnXdUKH9I5eZIEZrrF7+DcJS1S5j4wJWy4oBe0ZORKKLzXaxQ6ZUWrvreTGtwNBnRf4buRb/kR07kcA50PeZ7M7KoEUR2GbN8YcTAuUtC981wePLxmxz9CI6R0ovf6C7IwrzC8QrCYQz8NepfQFozSoSJ1d5nKEza+C2p47qnegK5gsjp5yffERwFRin0xJu1WcuJ4l1s2Jwks263At6gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee4QUhmJCPoULHOU0K+aGZu+HeiYR4uEbQ+9Si87Mbw=;
 b=jHPptEQY3zG02il68xAPB8TtMNvBR6LAfxSwAtaz02VeQvzKIuT70c3rPcGksvWRky4rIXKzsShnZi11b/V39vRjKn6IeQAX8q4lZ680olE5SUBY5P38OUFrNPpQmr+OqjQdOsRiL945M9lx4ep4pe3I/NELcU7Rlm1vfPiPRVvjEUd3ifXXc6DUAXHIbQbXzZ3Q50nJWPMcW6h4JSd7Rj3biQHHJxHVCHEc4K8sGepF8BVqc9IN0z2oiJAOT4k3PUgyx7chbsmQteZTMVHmifSJxSL8kFng0Trkm9UR5Fj3zRn7XkeVPc7n9tGzCdg5tWZkSjJp/F2/9Euhlod8MQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6588.namprd02.prod.outlook.com (2603:10b6:5:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 17:38:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Tue, 22 Oct 2024
 17:38:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
CC: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Starks <jostarks@microsoft.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, Easwar
 Hariharan <eahariha@linux.microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Index: AQHbIVUZK3+QpQzaU0GO9u2NqFEaQbKQqMUAgAHlewCAAIEuwA==
Date: Tue, 22 Oct 2024 17:38:39 +0000
Message-ID:
 <SN6PR02MB41576455C9F38EAA1B5D7807D44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
 <20241021045724.GB25279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <91756da8-f2c3-482a-95ee-6208e1205502@linux.microsoft.com>
In-Reply-To: <91756da8-f2c3-482a-95ee-6208e1205502@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6588:EE_
x-ms-office365-filtering-correlation-id: 3e177c43-e4c6-42aa-6c8a-08dcf2c05d88
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|15080799006|461199028|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 Ubp0dLor8SIDK4uUaTGlmUckPvg20NPzM0NTCzbd8+0zEBmuxi69+xkGKcVRBpT0vJmEcPmYXiBnLrzZfwEibLT73umUVIzAExQWCiQGo583e1H0fHQouA7phaP5ASBeH5lbdIL2XoS5sdbwot55GDJyRwEz5s9kFZ583ElnPd254I1RiEpuL299TB5cKOuQjGTHcz3nrCrNKyMvyNPwLUmzwcRs6EDsqhm/Io8baiKJtZ0aqwJzWBYk/izBFRQ18b47eCcedq52cd/gJKgpyXpZLeG+zXGrdw36B7oRJJcDrAlf4GKp7oG6QczioHoYdLKoLc92PONLyGf0knUSsRq24Lyi18aUQvJC+vn0LRKOZVOOVM3gq9ANBRbCphhCjRqvH72cRkvOaQV0POv8m+WK6EfnvgimtaOhLhUh/A4+ZQ2W0a/LH8e3dtKwLbijvhME85HeMuzVT2Z4Rg6jQETdKxOWTrZkDWNeh0RosEndnjliPDGZyJB2Xd19QI28qPkRDXUJ5iZAqBLuBFGfeEjIwxcZUXQimn7/ULD1PcSe8gVZioEJ6qfL3IiZODDtXWgto0BMmST4TKQrw42kuExep8BfdIJN+K4IzW+CKQoKZ2dXJFGi16l0MUPvUOJ5anVS+xb5Vs84ccTkQCY8vH8gmZBp3kkShAKqR4h0V41gqRcrio7GKt/i0H353K3RnPkYkZ3wBQntHOrf8HIrSQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFVxY3I0NzRsRXhIcCtUKzcvUXRXWUpHOTB1Mm96anJyU3FZV0xZR0ROaE9J?=
 =?utf-8?B?Z0wydzZaaXpSa2NTYjR6ODJFcXVoa1pIZjBLY01uUjU5VU55angrc0pxMG1u?=
 =?utf-8?B?RzN3VVRyYlYvTnRoMkE3OE1JME52QnVKa2Fnd3ZTNXg2SlU4TEIxOUxkSTE5?=
 =?utf-8?B?dDZMczBoWGMwaEhkM2szQXBYTVNsREFvdVRNeEZ5SWcvNGlpOVdZZGg2Q2t6?=
 =?utf-8?B?TEdXb3pUMUV3YUd4ZUJHSlI1cHZTWHo4SVZIWHhlbHNwQUtHNmFLeTFWNUJP?=
 =?utf-8?B?aHlhQTNWMk5HaGZuOEI2ZTNOUVZEVTRnMk1YeEJnajFqc0phOGwzaVlrWlVB?=
 =?utf-8?B?L0taNWJZK25PU25wT3RnM2ROTThWRnZHRVlQT2pyUVJaTzJQbEptZGR6SWRu?=
 =?utf-8?B?OEdQRjczSXNmK3VzbmM3SGJOc3RwYjZwNVppbEJqcTFmTXJqT0k4bG5DeDdC?=
 =?utf-8?B?c3VIVkh5cEpIZXFxNm1hVDVjbE83MC9GTnYvdTRUV3NYcktpNFVCTXpmY0Y2?=
 =?utf-8?B?MGwyWFF0QXBmby83RFBXTDIvK1E3ZEJQTDhBL3Zqb3VrZ0hKSHpQd2kxUmU3?=
 =?utf-8?B?dGtUa3N1dnVvVFM0V2dTNmNHZUw5QXF2S28wWERpZXBoVGNVVDUyVDI5MGM0?=
 =?utf-8?B?TlFjcE9pOUVxeE1Tc1JPOGs4Vjk0WjNPUTZ3U1hkc056aFVxM0pSc3NTV2lK?=
 =?utf-8?B?ajJtQkx6b3BFdVdBYWhETWNnSmRSdUZNUjFxSm52QkJzVDAxMHkvRmxSeHBK?=
 =?utf-8?B?dUtRSWFjYzFrdUsvY2lZMHo4OXpPdThVTGFOZ1VhQUtZSlVzeFRFdDVoc0dB?=
 =?utf-8?B?WEdRRFdpMDRlRUhpREJYYzFISHY2TUxDK1EyR0hFeG0wQXg3VXJYcWpMYjRS?=
 =?utf-8?B?OXE1MFlhdWY5bnFsZmY0QVRaSzNzU1NITSt5TmZnZ2ptVnh3dS9uWnRiT1M3?=
 =?utf-8?B?UnplcWxaL1ViMDBlQ3EwOU5pbDByeHhEdllSVHI4UnB2OTB6alBVWjV5akNx?=
 =?utf-8?B?bmtGM0hCRStmRVV4UkpESCtCd1ovS3RYWHJ0ZUN5Z3JXTHdRa1N2SUxPVkxa?=
 =?utf-8?B?T3pRYSsxaUkvaUwva2FPK2tKNlJuM1lTd1VCOHVBZ0RoWjdObkd3WjZGNm1J?=
 =?utf-8?B?SnNha3J2b2JJeEZPTDJRVDdNdVpzaXVCeEtKWW9CYjd1TVAwMnp6bWRTL0hW?=
 =?utf-8?B?dnZ3S0JaQWNpSyt1SzR5aTB2WU82OFdjdWdyVXJON3JaWE1hMGI1NGZFN2J6?=
 =?utf-8?B?NU41TUVtOTRHVmVmVmpNM3ZuOVh3c2dXaWFzcVBRQjRoK3kxMjBqV3ErdUhk?=
 =?utf-8?B?ell1TURQSGZHeExoZnZFMEo3bVdBK2NucEpGUE1kM1ZMZUVZTi9Xalk2RU1i?=
 =?utf-8?B?S3d4bHQ0NVlWc1dvRzl4VzZaMlZqSnA4QXRmN0FWZ2VoQjJwaGNxK24zaWlu?=
 =?utf-8?B?cHdFckJnUWhqQTJwM1FsYmNlRTZWZXczMmNycGVZQ0J5eFFLOTNMbTRVZk5H?=
 =?utf-8?B?cUFNblhKZTVuS2NVNTNHQU91NjVCaXRSVzFsV0NTSndUR0MzNEJyRG1mSHk4?=
 =?utf-8?B?OVhlN240NEt1QWdXYmRWYlBmMmY2azRHT2l3NnFUN0tNS2VoTHlQU3ZOY3Ny?=
 =?utf-8?Q?hS/pjOOwpN3CK+LXZO5C01ZAGkOyuSZOnO17isD3GMkA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e177c43-e4c6-42aa-6c8a-08dcf2c05d88
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 17:38:39.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6588

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUdWVz
ZGF5LCBPY3RvYmVyIDIyLCAyMDI0IDI6NTUgQU0NCj4gDQo+IE9uIDEwLzIxLzIwMjQgMTA6Mjcg
QU0sIFNhdXJhYmggU2luZ2ggU2VuZ2FyIHdyb3RlOg0KPiA+IE9uIEZyaSwgT2N0IDE4LCAyMDI0
IGF0IDA0OjU4OjEwQU0gLTA3MDAsIE5hbWFuIEphaW4gd3JvdGU6DQoNCltzbmlwXQ0KDQo+ID4+
DQo+ID4+ICsJLyogV2FpdCBmb3IgdGhlIGhvc3QgdG8gc2VuZCBhbGwgb2ZmZXJzLiAqLw0KPiA+
PiArCXdoaWxlICh3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoDQo+ID4+ICsJCSZ2bWJ1c19j
b25uZWN0aW9uLmFsbF9vZmZlcnNfZGVsaXZlcmVkX2V2ZW50LCBtc2Vjc190b19qaWZmaWVzKDEw
ICogMTAwMCkpID09IDApIHsNCj4gPg0KPiA+IE5pdDogQ2FuIHNpbXBseSBwdXQgMTAwMDAgaW5z
dGVhZCBvZiAxMCoxMDAwDQo+IA0KPiBOb3RlZC4NCj4gDQoNCklmIEVhc3dhcidzIHBhdGNoIGNh
biBnZXQgInNlY3NfdG9famlmZmllcygpIiBhZGRlZCwgdGhhdCB3b3VsZCBiZSBldmVuIGJldHRl
ci4gOi0pDQoNCk1pY2hhZWwNCg==

