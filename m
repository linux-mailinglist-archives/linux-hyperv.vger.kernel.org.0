Return-Path: <linux-hyperv+bounces-2871-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9295F67D
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84221F25763
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1633E4653A;
	Mon, 26 Aug 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="evbeFzTo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2075.outbound.protection.outlook.com [40.92.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20105198851;
	Mon, 26 Aug 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689500; cv=fail; b=jKUcnD03UANwiFAZqqh9HaWNNxWDtvbOpk7bFoJIp4Y3dzbLFaQ00hjom8qcnpsMq3plM9zXZweKnYI49cgsfarGY8fNr/oRVya1X0436tXB+m4iZGpCCS89lz8j/xgDak1+bhU0Y6mFK7M0pxysAKA+VOrQ7GAeGHHY8jiXvcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689500; c=relaxed/simple;
	bh=0rugomumiG1kaukeKcLwPS3kEW9tHqUf5dv+m+3OVHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sLNICsNtG38bHERHyLQzV7sxjEmREp0wWgCSFmAMZt+BOMwceJr8AYrA9N8tG94pSxsi95tP7+ZgEovW9RwnqjnaqowsFv4s/3MzMksUaa75ddIywAuW47Y8/pqqO//yGZfAdypAhn48fj7JZ/JITRccm39NQDILVl3tpwvmZ6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=evbeFzTo; arc=fail smtp.client-ip=40.92.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1lx5aNiVgmf66FkwSYJC7kPUmziwc7U07GODLF7x+sZY3Eg37wC1ndkP25/O5CVo9A7jBzUT1RFqWjntHnvUnyOibX5IBodjt6Ul4ZaJ2iUsIZ7oLiU2rs06O2tV4ImROZjW7PAYnWvnMTT6cEYtA9jPL83cpL/8zYQEaBuDRtCZ2xDk+osepKxDtoSG13b1hAKgo/zNlWMRx8QLwNDPN3Exi52NLJIZjryExrpQ5g2WghrXedFZoT7KYJbDt8pZHgSUDuKHPTFSWF6DBHb/BelkhZbxD10Qk2ZTw0czBldZ2FX8y3/oT0FkjzhT3iLRm4FJTbQvwvUywI2hGoAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rugomumiG1kaukeKcLwPS3kEW9tHqUf5dv+m+3OVHY=;
 b=NO3SXgoD829rJEt8FHx0SMNPiAzfjjyn0fuLyyI6mlVaYUfGl4MnFPUHPaYJH/YhX9A8H5zP1GOZ1GABD7I0u+AWW3psJywezDIOyB8VZormLBxiHVmuqfPVInGJqbGaI6GsOPRjNesTpduLHZ+EC3iaufSeLYghvP6VwNrkXsEMr3slWNVqUwGmt6dfQjOyjdK7ooxtKk4QyCs5frnKB72jZxeRllatQLhRu5wpbeL4p+7bUIfF72vVQgnVL3AYwHBrGfjFmUFFMcwEVYrlMdWqpkwhm+yvRffi4WTzA1p65ukdlBU1sEHkTiRK8ewd2QgLbxryz5XDHEpKrMZfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rugomumiG1kaukeKcLwPS3kEW9tHqUf5dv+m+3OVHY=;
 b=evbeFzToBdp4fMB5JOxvFdevvTghfl+VWEpEDPuCa7GmkTnHsBl0Kh3Cja21q/Q13R5XuyWlBEpgLZ0LM/pjttHbYr7Cb42UCvu6KyAdW0eHbzTjO5YVqcH0E03ykvqJWKW8PgZwFWFIj3HikSDSKDoqt0/BaiqAjdKImtuEnyQx3B54JX4C9/mOVs9kGxpksnZEo+fEnICkaHs9VJDVZxkZOsY6zbrrVBo8XDsMwavH+JuyL7+oZSVYpgv3rrVW/G8HxrhL3T9EEeZxGeeJ20MjQIz7bZ2PbJtR3kl4dMLKaCmrSWslOAY1jK6kLoPue/5OnhXlXafHG2M0qQyMGg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7546.namprd02.prod.outlook.com (2603:10b6:806:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 16:24:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Mon, 26 Aug 2024
 16:24:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [RFC 0/7] Introduce swiotlb throttling
Thread-Topic: [RFC 0/7] Introduce swiotlb throttling
Thread-Index: AQHa9MJuV8zHlUlbFEOu4P5Y/AqjALI0ZmsAgADTyNCAAZ5XAIAC5aKg
Date: Mon, 26 Aug 2024 16:24:53 +0000
Message-ID:
 <SN6PR02MB41577933B499309EA3CE4DDBD48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240823084458.4394b401@meshulam.tesarici.cz>
	<SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240824220556.0e2587d5@meshulam.tesarici.cz>
In-Reply-To: <20240824220556.0e2587d5@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [39Y4UjfANeb63Oxf0VtHn8u6T1PiI4rP]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7546:EE_
x-ms-office365-filtering-correlation-id: 29a872af-ea87-4bbf-0423-08dcc5eb9dab
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 dfQHnQfG2k4vCgRQVBeiHCQyYx6vy8JJpAX0baunBp4jmw5X3c16duLKOYWada2E1i4bZ8ul2k/VJhDhIZL19A5TXtrxzYVJ4fd65L4lmmfE7vqPNLkXMaNeCAelzGbk7zLlfrygYaqi1tzVHkk7v8w6EDMho4wBNAOiBg1dNfjLbAcFk/9lOR5sx0ev2Z2XJrbLs812QwbEVZeS0b5XYLaTTtxIqGX0yYfcj8t2SC/WzfZk/s1hk/70Bf99M6Ov8HZaNCp74kmAMllyx7BpHB9eObTqGGYS7q0pbG9d88wl0eH9IqR7HQN/owhkzaAfn01Zg9R72VKAeDSqtScgXhPvdA4vFlaI+7axJ02AeRUEv9yWtRNNfIy8uUG6rSD8HPFHvZv/42cvmbaUpIXFr45xrwcb8dTmhLQDiT7hlEfuD0YCcJKE15t1WVg83ZouLQnUgd5wm/afn+ed5jUHqEuuX7gmO8Et3t8SGafNxiSclT9ot0BSzuRMakkz2+v7Nhy3QcS0IABg3ltVB0hfbT+T1A3APzj5OOA1ndcIbk77OQAB4CRkqRrnfL7DQKLqavt83siJDJak+KSOAWxoLftzPFS4+sxvlNOnRekTpbEATWbA1453umNp5K9l1EmMCb2DHOu0Ah4VhtcBPKKRRdqRil2InpPaXGMgwIme+piAF13ZZwaTi0NbbAn03gDL
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UU8rNVBSc3V0NU0zOTBER0g5NGZ0NjBkeFkrRFZIVVhGY1FRNkJwTjlUUUFW?=
 =?utf-8?B?ZjlSejI5Ri9Cb0lPUlJId1AyQnFQeFhYTVFIUEtJSUMxZ2xoV2FUTStxUkpq?=
 =?utf-8?B?STlCMWszbUdYcVNFMXpJTUJHYUdNYWd0ZkxWRjBRNlpWbU82VHFUMm5mNVFn?=
 =?utf-8?B?N2JKMWI1TVFkUTg4TU5NdUQ3L1loVzNmOEhTMmUyRzl3ek1nUmU5bjR1eURJ?=
 =?utf-8?B?MmlzRFBjcFh5ZXRsZHY3L21NMGJmaXRueTEwejhtSTk4bW45RUpuclY4NWFB?=
 =?utf-8?B?eENYdCtzY0J4TjErTFFLRm8rMW5mQ214MEw4ckN1Mm5FQXRGa3NPakt1dllj?=
 =?utf-8?B?OHBwa1U2MzRGdXlCTFdsbEZpLytRbkVPOEg0VkJTbzZNOS8zUCtaVWh5WThN?=
 =?utf-8?B?S0UyU25NY2llc25GVFF1OE9xclBTdUVHN0FDbjF3SVg0NEdsT3JtQXl2Nlc0?=
 =?utf-8?B?ZHRyZHdia3VWOTZIZHoybXRzRU9hYitIR3Y1QVBRb3dqMnN1S21laVpuamI4?=
 =?utf-8?B?VVovYkg1ZjFMb2grZUtkei9wTURucS9KZWRXVkVEZ0pVOUJ0ZnhZRmdtdFJz?=
 =?utf-8?B?ZEU2N1VYV0svTFdaMnd1SlR5akRucGU1SC9PMkpNVmJlVFpHeTFDSWVkaWx5?=
 =?utf-8?B?dUhTMFdJNmxBeWRRZTN5OWd1MmtFWEFTY2xIOU9JTWZDTmR6bWN5ZlB1RmFD?=
 =?utf-8?B?RnFsQTArL056dkZWQkt1UVI3Z0VnbkNtNS9VNDFJcFhmZ3BHQnNaWndhSkIr?=
 =?utf-8?B?YktVdG5NdFZLSk1hLzQycDZjMGJQRHF3cTRBTGw1STBlMzRCYkhXVDdNRHBG?=
 =?utf-8?B?SGUyYi9mOVc0aFdXckt5V1dINkRzcTVyMlI0aFMvSkxTVFRLSmRvVGVnTnNv?=
 =?utf-8?B?NWErZitxOUN4MWdPU3BEc0ZqT2czZDk2K2ZhVFF4alNTUytRdWlqZlNSY0Jq?=
 =?utf-8?B?UDRXejFka0RHZGxzUHpZeVNwdmpOTUd6U1NjWGY2ejFGOGZWTmZISG12WjNa?=
 =?utf-8?B?U2w1TDFuSXJZd05JN3JJMFI1MlNBNS8wSURobUNRRXAxWW1uZE1aZ2srRFcz?=
 =?utf-8?B?V1p2TVF4UlJIYzFaZlI3RmVGMnpjVDA4cTc5WkV2VjBxZmoxazFRK1pyZzZ5?=
 =?utf-8?B?akJIK2JxUnhvSWxtaGg5V2prOWRGZU9JR3ZMTk9aVEZvMjdkenNsMWJnVHlH?=
 =?utf-8?B?aW5OanVHOUFGRmgxODcvbHhCYzVlQjB2Sm1mb012eVc3UDYvUTJ0emFVK2Y2?=
 =?utf-8?B?WjcrTjFwTnJEMEtYRmFFeGFTSUZ5Z1pMU2F3U3RqTG0vRFhLZGp6MEtRYllO?=
 =?utf-8?B?eWxLMmJFUTNHRjRMakRrdmpnWGExYnRVZ293K2VubEVtNkcxZDVvVDZIcW5D?=
 =?utf-8?B?QzdDeWpxcDBmQVJVOU1tOUR5TU5JQVgwQ2QyQkRXc1hPcldub2w5bWNETURW?=
 =?utf-8?B?YXdVSGVXeUw5RzVoVmIrZUVYUmJ2WVE3UzFQZVNFendOZngvSWR6ZktmTTFB?=
 =?utf-8?B?Nkw1MTRTTnlCb0JIZXZKRW1EN0t6UjZrTkVHbkZCdXBwR3ZKaXZ5bWRkTmND?=
 =?utf-8?B?M3U3UVlhbnplZ1lKaGZtWlhWU0ZOazhjcXQ1eGx3Y2hVQ1hHK0ZzWnpXejBT?=
 =?utf-8?Q?FXxLj+nM2raD4uUzw+Y5oNDsYkkx33xgLOfuntUDzGGI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a872af-ea87-4bbf-0423-08dcc5eb9dab
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 16:24:53.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7546

RnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+IFNlbnQ6IFNhdHVyZGF5LCBB
dWd1c3QgMjQsIDIwMjQgMTowNiBQTQ0KPiANCj4gT24gRnJpLCAyMyBBdWcgMjAyNCAyMDo0MDox
NiArMDAwMA0KPiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+IHdyb3RlOg0K
PiANCj4gPiBGcm9tOiBQZXRyIFRlc2HFmcOtayA8cGV0ckB0ZXNhcmljaS5jej4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCAxMTo0NSBQTQ0KPiA+Wy4uLl0NCj4gPiA+ID4gRGlzY3Vz
c2lvbg0KPiA+ID4gPiA9PT09PT09PT09DQo+ID4gPiA+ICogU2luY2Ugc3dpb3RsYiBpc24ndCB2
aXNpYmxlIHRvIGRldmljZSBkcml2ZXJzLCBJJ3ZlIHNwZWNpZmljYWxseQ0KPiA+ID4gPiBuYW1l
ZCB0aGUgRE1BIGF0dHJpYnV0ZSBhcyBNQVlfQkxPQ0sgaW5zdGVhZCBvZiBNQVlfVEhST1RUTEUg
b3INCj4gPiA+ID4gc29tZXRoaW5nIHN3aW90bGIgc3BlY2lmaWMuIFdoaWxlIHRoaXMgcGF0Y2gg
c2V0IGNvbnN1bWVzIE1BWV9CTE9DSw0KPiA+ID4gPiBvbmx5IG9uIHRoZSBETUEgZGlyZWN0IHBh
dGggdG8gZG8gdGhyb3R0bGluZyBpbiB0aGUgc3dpb3RsYiBjb2RlLA0KPiA+ID4gPiB0aGVyZSBt
aWdodCBiZSBvdGhlciB1c2VzIGluIHRoZSBmdXR1cmUgb3V0c2lkZSBvZiBDb0NvIFZNcywgb3IN
Cj4gPiA+ID4gcGVyaGFwcyBvbiB0aGUgSU9NTVUgcGF0aC4NCj4gPiA+DQo+ID4gPiBJIG9uY2Ug
aW50cm9kdWNlZCBhIHNpbWlsYXIgZmxhZyBhbmQgY2FsbGVkIGl0IE1BWV9TTEVFUC4gSSBjaG9z
ZQ0KPiA+ID4gTUFZX1NMRUVQLCBiZWNhdXNlIHRoZXJlIGlzIGFscmVhZHkgYSBtaWdodF9zbGVl
cCgpIGFubm90YXRpb24sIGJ1dCBJDQo+ID4gPiBkb24ndCBoYXZlIGEgc3Ryb25nIG9waW5pb24g
dW5sZXNzIHlvdXIgc2VtYW50aWNzIGlzIHN1cHBvc2VkIHRvIGJlDQo+ID4gPiBkaWZmZXJlbnQg
ZnJvbSBtaWdodF9zbGVlcCgpLiBJZiBpdCBpcywgdGhlbiBJIHN0cm9uZ2x5IHByZWZlcg0KPiA+
ID4gTUFZX0JMT0NLIHRvIHByZXZlbnQgY29uZnVzaW5nIHRoZSB0d28uDQo+ID4NCj4gPiBNeSBp
bnRlbnQgaXMgdGhhdCB0aGUgc2VtYW50aWNzIGFyZSB0aGUgc2FtZSBhcyBtaWdodF9zbGVlcCgp
LiBJDQo+ID4gdmFjaWxsYXRlZCBiZXR3ZWVuIE1BWV9TTEVFUCBhbmQgTUFZX0JMT0NLLiBUaGUg
a2VybmVsIHNlZW1zDQo+ID4gdG8gdHJlYXQgInNsZWVwIiBhbmQgImJsb2NrIiBhcyBlcXVpdmFs
ZW50LCBiZWNhdXNlIGJsay1tcSBoYXMNCj4gPiB0aGUgQkxLX01RX0ZfQkxPQ0tJTkcgZmxhZywg
YW5kIFNDU0kgaGFzIHRoZQ0KPiA+IHF1ZXVlY29tbWFuZF9tYXlfYmxvY2sgZmxhZyB0aGF0IGlz
IHRyYW5zbGF0ZWQgdG8NCj4gPiBCTEtfTVFfRl9CTE9DS0lORy4gU28gSSBzZXR0bGVkIG9uIE1B
WV9CTE9DSywgYnV0IGFzIHlvdQ0KPiA+IHBvaW50IG91dCwgdGhhdCdzIGluY29uc2lzdGVudCB3
aXRoIG1pZ2h0X3NsZWVwKCkuIEVpdGhlciB3YXkgd2lsbA0KPiA+IGJlIGluY29uc2lzdGVudCBz
b21ld2hlcmUsIGFuZCBJIGRvbid0IGhhdmUgYSBwcmVmZXJlbmNlLg0KPiANCj4gRmFpciBlbm91
Z2guIExldCdzIHN0YXkgd2l0aCBNQVlfQkxPQ0sgdGhlbiwgc28geW91IGRvbid0IGhhdmUgdG8N
Cj4gY2hhbmdlIGl0IGV2ZXJ5d2hlcmUuDQo+IA0KPiA+Wy4uLl0NCj4gPiA+ID4gT3BlbiBUb3Bp
Y3MNCj4gPiA+ID4gPT09PT09PT09PT0NCj4gPiA+ID4gMS4gc3dpb3RsYiBhbGxvY2F0aW9ucyBm
cm9tIFhlbiBhbmQgdGhlIElPTU1VIGNvZGUgZG9uJ3QgbWFrZSB1c2UNCj4gPiA+ID4gb2YgdGhy
b3R0bGluZy4gVGhpcyBjb3VsZCBiZSBhZGRlZCBpZiBiZW5lZmljaWFsLg0KPiA+ID4gPg0KPiA+
ID4gPiAyLiBUaGUgdGhyb3R0bGluZyB2YWx1ZXMgYXJlIGN1cnJlbnRseSBleHBvc2VkIGFuZCBh
ZGp1c3RhYmxlIGluDQo+ID4gPiA+IC9zeXMva2VybmVsL2RlYnVnL3N3aW90bGIuIFNob3VsZCBh
bnkgb2YgdGhpcyBiZSBtb3ZlZCBzbyBpdCBpcw0KPiA+ID4gPiB2aXNpYmxlIGV2ZW4gd2l0aG91
dCBDT05GSUdfREVCVUdfRlM/DQo+ID4gPg0KPiA+ID4gWWVzLiBJdCBzaG91bGQgYmUgcG9zc2li
bGUgdG8gY29udHJvbCB0aGUgdGhyZXNob2xkcyB0aHJvdWdoDQo+ID4gPiBzeXNjdGwuDQo+ID4N
Cj4gPiBHb29kIHBvaW50LiAgSSB3YXMgdGhpbmtpbmcgYWJvdXQgY3JlYXRpbmcgL3N5cy9rZXJu
ZWwvc3dpb3RsYiwgYnV0DQo+ID4gc3lzY3RsIGlzIGJldHRlci4NCj4gDQo+IFRoYXQgc3RpbGwg
bGVhdmVzIHRoZSBxdWVzdGlvbiB3aGVyZSBpdCBzaG91bGQgZ28uDQo+IA0KPiBVbmRlciAvcHJv
Yy9zeXMva2VybmVsPyBPciBzaG91bGQgd2UgbWFrZSBhIC9wcm9jL3N5cy9rZXJuZWwvZG1hDQo+
IHN1YmRpcmVjdG9yeSB0byBtYWtlIHJvb20gZm9yIG1vcmUgZG1hLXJlbGF0ZWQgY29udHJvbHM/
DQoNCkkgd291bGQgYmUgZ29vZCB3aXRoIC9wcm9jL3N5cy9rZXJuZWwvc3dpb3RsYiAob3IgImRt
YSIpLiBUaGVyZQ0KYXJlIG9ubHkgdHdvIGVudHJpZXMgKGhpZ2hfdGhyb3R0bGUgYW5kIGxvd190
aHJvdHRsZSksIGJ1dCBqdXN0DQpkdW1waW5nIGV2ZXJ5dGhpbmcgZGlyZWN0bHkgaW4gL3Byb2Mv
c3lzL2tlcm5lbCBkb2Vzbid0IHNlZW0gbGlrZQ0KYSBnb29kIGxvbmctdGVybSBhcHByb2FjaC4g
IEV2ZW4gdGhvdWdoIHRoZXJlIGFyZSBjdXJyZW50bHkgYSBsb3QNCm9mIGRpcmVjdCBlbnRyaWVz
IGluIC9wcm9jL3N5cy9rZXJuZWwsIHRoYXQgbWF5IGJlIGhpc3RvcmljYWwsIGFuZCBub3QNCmNo
YW5nZWFibGUgZHVlIHRvIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHJlcXVpcmVtZW50cy4NCg0K
TWljaGFlbA0KDQpNaWNoYWVsDQo=

