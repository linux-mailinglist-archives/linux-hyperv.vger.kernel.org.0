Return-Path: <linux-hyperv+bounces-1651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3986EA3A
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 21:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434941C2294F
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686EE3C46C;
	Fri,  1 Mar 2024 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CbfiC+OU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2040.outbound.protection.outlook.com [40.92.41.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F04C9C;
	Fri,  1 Mar 2024 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324511; cv=fail; b=Sw0a3ABgrnK1rUSgjimD54dB5/5ak5xkmZtJzMqLJEbNWhfTochvZRSubKQ0MDVviOIWHpFfL/kABkQd/wkoP2wm0fznLzpw93RqtUATPWzvIXyDTbzOLVDHNPOu5660DOxbxY0WuCVid8IIqkAlLRhKQiNvD+JfIZz3CHEGQCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324511; c=relaxed/simple;
	bh=J9+7Xhl/XOZGZxFzIx9EW5GyYxFqE+JLHp980sfdLtw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RojbHFg2VFzfdpRCDlxRSdBE8XQPHNyQMp8nP+OBk6PpkS5toiF0TJmhLkmbtj19djRCYvseb1YsiShVlzFwnFbJhgnzB5Da2KaWr8nFjAkYIsJI6zC0QVus+qNIK/tXWLEJvHXfC9rN8XvljIkfag7Q9rNAtQQlcymo8ecrNic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CbfiC+OU; arc=fail smtp.client-ip=40.92.41.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBbEpYHQ1dBiqpSu6QCii5iObXZja4PDnp1xqIniYrluw2e5xBCHJYxw7YLFq1MRRrZ1UtKZnXX6hFfx0tNHoNf6Jb70pXIo/oRvjwcIxhMKFlc4GM8uvG+gQPO2sbVfXYBL1b6YB3b50h6dQpiBR2qVejFY74jPVuQrmIkaXcVCqYYNKKXT9EDtC4Rj/veQ+AX9UHL1a7MHQruX/N4JmmI/FukkJ/48kcstH5k3oZoEm66NrSLmSZb9C4C5xCYZfMQdWv3X1hH8bSCiWam0HeeWF5o28tS0UmOniTaVMPJG5I76vpWuKuJsP+M8CmlMQBHh7PbP25JFny7G2qb9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9+7Xhl/XOZGZxFzIx9EW5GyYxFqE+JLHp980sfdLtw=;
 b=GveDsG3CwJHIpR2bpiCreVHezvFXhcjNm8A+wT06r7ip0FGYP8ldcfN4LhsOz6RvAC8Rp+RIFehw9ssdyg7LgASgV7MFUlGwD3w8niAF6rvXGUBYrRNJkNZuf1O+S24XibeW62/okdW30Q3so/SFswlQJyTsKVJQcW8JEtFJ9KPDfBRRmsy16j+ft5SoIWjMstvJu2HoiUKOOtcOVktP8RhlPYQJdVEFx+fhRhJHzWOeZ6ykFCGYiMHmtGiCtmj/K1ay28w4qCOSHniPqxKKzLIJ7w1Zk8JJJNuh8F0qgZ1LrAJz8u+V8ktiFVAdTI7wcsHOLBZO1pXGQ6LyT6qg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9+7Xhl/XOZGZxFzIx9EW5GyYxFqE+JLHp980sfdLtw=;
 b=CbfiC+OU1iPJZ0J0wDrvJza6acd5kEbA5Q+PPVpZYhtLpERiDmOExs7cfGjzU/L2CYD8koQ0OkYaDFGGAoHqDU9advxPgyaKL13D7u2jbhTX0SfVlgiDGSWlO7NrAP6Sj6/imVnD3N6FiaCAppE4w5qog286ynaNC7EOjcZGTNtKdWHj8f6YROHshe74DN5CVhdN/NwzIf7uBUsCy6Rcsa0sYwaRYL+t1a2KQwVHNiin6DXbusjaeDEpOTm7Tt0TB+KwUmZAT4GdePLuHPvPFLrp+wjUoCTaBCQ8g2dylrcTjaqTmvA3AKgWvjevfV1GJNEA8rkZqALgiQaMZQdDWw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8939.namprd02.prod.outlook.com (2603:10b6:208:3b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Fri, 1 Mar
 2024 20:21:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 20:21:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Topic: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Index: AQHaZTRYDcNuyb66Gkm4wm9TLGb/jbEjO5pggAATDICAAA9AYA==
Date: Fri, 1 Mar 2024 20:21:45 +0000
Message-ID:
 <SN6PR02MB415731A89ACAB7479B059D73D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
	 <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
	 <SN6PR02MB4157B2E6EC690B11AB334522D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <78da25c9160612bc60bb1b421a0226e4368db51a.camel@intel.com>
In-Reply-To: <78da25c9160612bc60bb1b421a0226e4368db51a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [JF6ensI3+dOrwhy2mEWXni9xhhb/4mm9]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8939:EE_
x-ms-office365-filtering-correlation-id: 8fb07cc5-866f-4062-ae5f-08dc3a2d3768
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrOFvOYWG/XGVp/4EGIZryPzIwMwSH0IwNb5vanyil/X70SzLXFaZW0AWtMLxjawPBmjVQbnI3q6PCoMxAGTzO/dtY+BftzrVvHjf1p9c8bW/36/H7xjdAarzpwaM20jwkpi8xRWXjaVRWr45Yucqhsp4+mAI1omElgnqQCHJ6MxGyPhiuFYlhy+jhODpNCvwHZR15jg5kgY+XyKpGV1dEX8kLHKJgAvIk+/XHeWJEO51IXljH5WREvEgVbWz5S86KbE8HlwbUAmebP5RMbtA5J/WsWfnc2EpuzMzn9uIYg4PbbFLg/935id0go5vwExouAitaSy2BUOSh18PhvN67LNQpS2lLGYwwhAbhQZAugaOn3MqiWBrK6lZCB24pl3KE4VZJGTyTWPusO6CO/MYmEHtwYIwe37e+N1K4qYMPHCHtFVRzuFKmdL2YCzWkFywb54hig8m5cO4hsMPTnkvlAIp6RU6XVB4kKFTqBW6qBBcPWtURhF07fMOf0OQmFqJKHHC3rhrjraLEhCKoLS9Bt3hCl8y0qFPphSHVwMyPngTFUHhy7bUEzJlmH6dbeoZEmkDwrPa2cv6RuEWUyAL2dMUj5QqWnisb0/WqJPh3nG4qlspG4Yr89isZBQAVjqfgW+oQPJl2tQE3d35VpNlOiExv/gsZdwXriU2G3WOxdkU2hacTBNAZ2qW06zb2gGRFcNNJd323yBkH/5YlGVo7dzdlZpL0TzN1ccRqc3f99OvcKC3QNkUp+1EAML1aerpxI=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NeU0VpcCTNvd1kweMNVviXH6tnF+uZEtktmTG6Mvc4iYKjSlBdWKbe+94Nn7tbe7wqOkD9NjHz0iB5lckjdeiIaKOgzZLkEar3U1k80KV/vmeJNb1e3ssHbhC4DjKzlCbFgJKdjcBoEreNSz9m0j1bffyYj8vxmNlaBBcHiG+AEC7PIlchZ3rRYqB2HKcK0BVI72pTmsjyVDoHZlULkyXpH06wNZh5gcXs2ilGRlZPiiSD3SdcIxKI4EIGlP9oHQpb/w8+3gxz67YQXqDRi1JDq23xWJ0/NoiQHx6+BqpITA4PnhfMQS/HIxnCVvB+pREuA3FPVwQ/WgCVdT5MCbYJUWqPsFBsL61W8fldsPWnWDQzknDrEEq0uMeJttUbBDFPgJY2bop/Ffr22qWdMiqDQSy0GOk+cuqeBU5w/AvTZPdAOOfrJUhW0Y2bbrGxL1T/5+ZQsViXKXvabfuWeDkzNhpPeym54O/a7AaYAe1tg7EFEO/gn1MVW+cgICS/+c0PDWB3g7eei/ia8INwUYzEycaT3/Pt02hXCafFOyQcFPYtPAdH16AiuJMOafJFag
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzFBY3QrTlZNSjgzSUMxQ1RqampNS1h3Y0Y3dzBzdnU2bEhGTHk0SmdyQzBs?=
 =?utf-8?B?Z3NiYU82NnZ6cGJ5UjR2d1FwT2lPNkJqODM3YjJpcEUwdVl0OHdxNy9ZaFJO?=
 =?utf-8?B?VnZOTENjYnZzWmVWSzNsOUh2aVZGamhnTjhXRlhpRFQ4Vlg4RWY1MFdBQ1FH?=
 =?utf-8?B?TERKemd1dCtNSStkMS9SN1lVRnI3TDZyL3cvOG83R0xvTDlKemRTMm16WkZF?=
 =?utf-8?B?b2l2b0lkRUNkcmYwZlNVTnJjOHp4MWM4bDViUmNidkRTTUJYSWlZZnFnSW9m?=
 =?utf-8?B?d2hycURtZEJRejZTVk5RNFFzTFd6TGRBa0JWMU9LOG1QRkh6eVgxUXBSVzJQ?=
 =?utf-8?B?RDA1Z0RkSjdhMmlVZFIvRWdoK2JkR3h3MERTVVcvS0l5aXphQTVTdmhyVytL?=
 =?utf-8?B?bm5VTDFFS1ZsRWhTMmJlVkpLYldKdFgvVWlOWGFjWUV1Tml4c1BBb1M5ci96?=
 =?utf-8?B?VStsbzUvaUs3WFZoVTdLMW5OaExkQjVyWkpPZ1ZTQ2xaNndNSFVFSyt3M1dL?=
 =?utf-8?B?cFdBNk05MWZPWTVxWXpia2l2SlZ4RDZSTkJ1dTZmeGFMS3ZXSnl5VGxtVU5a?=
 =?utf-8?B?TWxpOUFldVlESnFLeWI1TVJFdnFhM2xLZGJ3L3ptOWFLelZpZjZIUlplcGt4?=
 =?utf-8?B?YUh1TWFQeVFXanc0MzNsTG84Zlk1VXdrRHpMSUJDVnJ4ZThPU3BZaDhPUWEw?=
 =?utf-8?B?b0FOK0FraXVuZU9QSEhycUZMQVN4c05LNjQwcHAvU29qRTdWK1Q2b25KVXZ5?=
 =?utf-8?B?YTJEUGZGcW5GdkVEMC9VZkF6UllyZHhBR25meDVVNGNFQWFyYW1XdUdqQ0hY?=
 =?utf-8?B?dENVeVpzb3lCRFZoeVdKUTR0cFFDclNQT0UwaVBldDQ3QWtpRFhxZldFTURr?=
 =?utf-8?B?c0JTWWhwWWoyZkRNM044ZVNuQUVOWExxSzRaYnBubmkvb2Y1WHI3Y0d2d3lB?=
 =?utf-8?B?SHdLMDNlZXJadEU5bTJYbEJjaTBiNXNrdDNIY21WSUQ1RWcyY3R6c2kweTkv?=
 =?utf-8?B?N0VQeXFSblNvV0NGbkpXK3BxaTRLL1A2UHhPd0JZMjhXOFIyMVI1dUFDdy9D?=
 =?utf-8?B?ZEF3bHZ6MHJuaG04ZG1tZzBYdFpGY25kcG5abVJTNnluQ2FjSGlTTmxtZWcv?=
 =?utf-8?B?SU5MaUdrd2NSai9UaEJ4bDAwS09xcEFXM0tzeWphNDlJWHZNVk1NUW92WXky?=
 =?utf-8?B?ckdMTUk0eGduOUYrb1VKYkYwT2lLWHhvaFc4UWpUVFhwMVpmd2E3Y3k3N2NN?=
 =?utf-8?B?eHlIU211azRyZVhtTUJBUWVXQnNBWjZZVWlCY1JOcVBWR2JyVWV3T25sUUpV?=
 =?utf-8?B?bnN4U2diTm9ldnVnbERtUDZxTG91aDVCQkJPYm9qeUYySHlLT1drTDFkOVNK?=
 =?utf-8?B?VFhIM0xabjFXLzBodG84Zk5ON0FHRmk5M0NVWW5kMVlQbFFIdWVPaTdPT01Y?=
 =?utf-8?B?elRSL2tzMFphM1FOanJHNk1penNOLy9OUWtrbWtlcDEwLzFOK2lwMUhHcHQr?=
 =?utf-8?B?RlhSSkExMkdGcmIxTURMK01PYkowRFdqRWQxaVR5Y25uK0dzdHIvK0pzUWNV?=
 =?utf-8?B?R2VIYTRWcjFYRkMrVXZJWE92M01PU29Yb2FsdHE5MXAwQVJ5b05tUVcxUUJF?=
 =?utf-8?B?Z2JwVW5kM3pkTVRSY1lQS2pKRXhBeGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb07cc5-866f-4062-ae5f-08dc3a2d3768
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 20:21:45.6847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8939

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBGcmlkYXksIE1hcmNoIDEsIDIwMjQgMTE6MTMgQU0NCj4gPg0KPiA+ID4gT24gVERYIGl0IGlz
IHBvc3NpYmxlIGZvciB0aGUgdW50cnVzdGVkIGhvc3QgdG8gY2F1c2UNCj4gPg0KPiA+IEknZCBh
cmd1ZSB0aGF0IHRoaXMgaXMgZm9yIENvQ28gVk1zIGluIGdlbmVyYWwsIG5vdCBqdXN0IFREWC7C
oCBJIGRvbid0IGtub3cNCj4gPiBhbGwgdGhlIGZhaWx1cmUgbW9kZXMgZm9yIFNFVi1TTlAsIGJ1
dCB0aGUgY29kZSBwYXRocyB5b3UgYXJlIGNoYW5naW5nDQo+ID4gYXJlIHJ1biBpbiBib3RoIFRE
WCBhbmQgU0VWLVNOUCBDb0NvIFZNcy4NCj4gDQo+IE9uIFNFVi1TTlAgdGhlIGhvc3QgY2FuIGNh
dXNlIHRoZSBjYWxsIHRvIGZhaWwgdG9vIHdhcyBteQ0KPiB1bmRlcnN0YW5kaW5nLiBCdXQgaW4g
TGludXgsIHRoYXQgc2lkZSBwYW5pY3MgYW5kIG5ldmVyIGdldHMgdG8gdGhlDQo+IHBvaW50IG9m
IGJlaW5nIGFibGUgdG8gZnJlZSB0aGUgc2hhcmVkIG1lbW9yeS4gU28gaXQncyBub3QgVERYDQo+
IGFyY2hpdGVjdHVyZSBzcGVjaWZpYywgaXQncyBqdXN0IGhvdyBMaW51eCBoYW5kbGVzIGl0IG9u
IHRoZSBkaWZmZXJlbnQNCj4gc2lkcy4gRm9yIFREWCB0aGUgc3VnZ2VzdGlvbiB3YXMgdG8gYXZv
aWQgcGFuaWNpbmcgYmVjYXVzZSBpdCBpcw0KPiBwb3NzaWJsZSB0byBoYW5kbGUgaW4gU1csIGFz
IExpbnV4IHVzdWFsbHkgdHJpZXMgaXQncyBiZXN0IHRvIGRvLg0KPiANCg0KVGhlIEh5cGVyLVYg
Y2FzZSBjYW4gYWN0dWFsbHkgYmUgYSB0aGlyZCBwYXRoIHdoZW4gYSBwYXJhdmlzb3INCmlzIGJl
aW5nIHVzZWQuICBJbiB0aGF0IGNhc2UsIGZvciBib3RoIFREWCBhbmQgU0VWLVNOUCwgdGhlDQpo
eXBlcnZpc29yIGNhbGxiYWNrcyBpbiBfX3NldF9tZW1vcnlfZW5jX3BndGFibGUoKSBnbw0KdG8g
SHlwZXItViBzcGVjaWZpYyBmdW5jdGlvbnMgdGhhdCB0YWxrIHRvIHRoZSBwYXJhdmlzb3IuIFRo
b3NlDQpjYWxsYmFja3MgbmV2ZXIgcGFuaWMuIEFmdGVyIGEgZmFpbHVyZSwgZWl0aGVyIGF0IHRo
ZSBwYXJhdmlzb3INCmxldmVsIG9yIGluIHRoZSBwYXJhdmlzb3IgdGFsa2luZyB0byB0aGUgaHlw
ZXJ2aXNvci9WTU0sIHRoZQ0KZGVjcnlwdGVkL2VuY3J5cHRlZCBzdGF0ZSBvZiB0aGUgbWVtb3J5
IGlzbid0IGtub3duLiAgU28NCmxlYWtpbmcgdGhlIG1lbW9yeSBpcyBzdGlsbCB0aGUgcmlnaHQg
dGhpbmcgdG8gZG8sIGFuZCB5b3VyDQpwYXRjaCBzZXQgaXMgZ29vZC4gQnV0IGluIHRoZSBIeXBl
ci1WIHdpdGggcGFyYXZpc29yIGNhc2UsDQp0aGUgbGVha2luZyBpcyBhcHBsaWNhYmxlIG1vcmUg
YnJvYWRseSB0aGFuIGp1c3QgVERYLg0KDQpUaGUgdGV4dCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
aXNuJ3Qgc29tZXRoaW5nIHRoYXQgSSdsbA0KZ28gdG8gdGhlIG1hdCBvdmVyLiAgQnV0IEkgd2Fu
dGVkIHRvIG9mZmVyIHRoZSBzbGlnaHRseSBicm9hZGVyDQpwZXJzcGVjdGl2ZS4gDQoNCk1pY2hh
ZWwNCg0KDQo=

