Return-Path: <linux-hyperv+bounces-1422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189782B9EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 04:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2172F2816F7
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 03:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBAB15C9;
	Fri, 12 Jan 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UnB/P6Ab"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2032.outbound.protection.outlook.com [40.92.22.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007B15AF;
	Fri, 12 Jan 2024 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIlh6/p70YMBIqelHhM8VVBSYpDTywLCQyiuIcC4VDJKmL03nS2EK4ypz5EVazhRH3jprBnYc6TnLkfhMHaQC1N8i1YGp/lfDeR8YqzRJg1bf7KW6sfexEra+lUMTkGGZAf5AYSwQrtoNXbjdYz7UqdGE2n7kLVCI3mvQCp9MMJvcXZZafj90UfOzR48xujz0F/p7a4qMN2kP3ZWiy7VdO8q0BMoYMvUkmo1X0KDQ+iR+lvYWLiOGjU1ZNCmQa9dyefdddTdg9qkb+/kt9nGA5XJrwXkemzMjSwCaLhFg9LpxGZMfsXvwldZFCE32dnXD/97aYX3sToWJGwcvKU4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq6bvPYfTly13f83xxexXjrsdQzdnunThkyhGuN8TbI=;
 b=Xev8br/8FQB26uS74oSo+5MLF5K2arBGQH/REl4o+oyflrZcxa28z4Tv5ZeerDjYa1zoRbfY2BslX7ln4kkM2dfgquFuMFrb3vk+tXV7GwMGfUoH/gUlcJ3IfD36LT1rj5j47nfrXsIzJoBOgNWUSoJhwKSJMe9fLB7270WUwu0KOO8Jgu0dm1R+IvwyLp6C2k8+/vCTjnzQnaony/TPl5agvFrKF4xnGOknOf5AaBCe1At9b2t97PPvt0alkBiQItg32Pu/lueqiwgW0s+tgIsGkTfowh9gr30PGxBTmVkzon9aijYOH/jpFR8mCHWQcuTNoTJpvpaQVtFLm9NTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq6bvPYfTly13f83xxexXjrsdQzdnunThkyhGuN8TbI=;
 b=UnB/P6Abu2oIG4+lFjrK9Qt897gdwgYdBIVdjgGepzgh92VvjO+ckHWpcQY1GMBFjzZaL7dZfOBj76TiK9fxxRUF57msBmk4gz6GuxHqViwkwe/72SihhhPEGDajYbD1OPnJYu2jIXRKBIH3WW1WG1BtYYCaQ4s8vK2StMWU7uqomPC7x9q1QJ8A9o1FTVqVR/qirPiGbq36VqDgtp0xNYBBInpc7slPJwuyUFxBXtKkX06fwg50rW4S8pJvTqtMANCZni6xy690imzc3bwpM3fSnq8oVuJ0GdCUArfDidCZ4/NUHWpX05rgBAH200TMm75oLSeX/7HL4Sig9m+cJQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7776.namprd02.prod.outlook.com (2603:10b6:a03:325::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 03:19:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 03:19:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"Lutomirski, Andy" <luto@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Thread-Topic: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Thread-Index: AQHaQAV1hr9Lx3Gdjk27VQG8PMUDvrDVW/wAgAAvntA=
Date: Fri, 12 Jan 2024 03:19:55 +0000
Message-ID:
 <SN6PR02MB415728EA80420231DF35BB36D46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
	 <20240105183025.225972-4-mhklinux@outlook.com>
 <21f41af44fcc2ce52bdb40c7560fc7c9c0d56ec4.camel@intel.com>
In-Reply-To: <21f41af44fcc2ce52bdb40c7560fc7c9c0d56ec4.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [pf0jo6XTkv5bBVG/GWAipU/pTq1+3SRb]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7776:EE_
x-ms-office365-filtering-correlation-id: 468ccc1b-b408-40bd-d9ce-08dc131d5990
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EYRtYTLra3aSncRWc/lxiQFECz3du1rxPUcRjankMDjEch9CuXLMGxAGZ3vcjZ2tOMAldtJsoMyKLIi8rA+Nducj5tR9AHwZYbrEgB6sc/xHIog5iqdLAKXGt6XG0DJM+pH/s/H6oEb1pWmK/nc4ibLE4FP9+Fi4gwS0ZcX0dwNhEjMwskgaWuPquMOTxsnoifmb0klMd4kOnuW1RSredR3eeLfvsHrYrg5m98g32qzGnqN3o/M8liH61IYA1fLZw1Kk0NaHi3kpj8Uz7NlPjCslYKNYJkQI7UJX8q8ZBRU51JySDFXzYl3rsbiyZ3YAvjgXXSIInFPrgupW1f937ywTSwoC1rgVbjiZhtcPymdiPy6sbv4GL5Hom25ZeRtzTZAKdfFFKV+G5Gc1q/VzzKEvOlAsXNEkdOuqFvpyc0h8UlmMHLmL/0tDZn6gWOeE96+UhtHfRjTLVJhCc9mSEmDZJjtXi5K0Hpa3hqd8Ixsd/p4SQ7jOmeRBi4vg8rKS55JB2jcIsAk+YR0R8fGYrIyhY57e8mB7nCGyf8lfuXY96oR+iXsA4jQdYECYs2D1
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eklmZzBFai9LV3dialkvVnY3RkN2L3VJenBMUlZQNmtqbHhmdXhCQmhHOENl?=
 =?utf-8?B?elNxeU9JWGlvUUMzZG1JaEsvc01JQnozcmh4Q3ZpUU9sOHhKRmh3aXV2R1NS?=
 =?utf-8?B?VjVFSzRrY1lBaDFQSHAzdUx4TXhjcnFjSjNBeCtCejFrWlZIU2tBZG5SeWNP?=
 =?utf-8?B?bU4yRHllUm5uT1BsQ0dzSmlRRzdTa1kvQXdDTjFFTXg4UjFvMWh5MEFhbVFa?=
 =?utf-8?B?TzBnVzdIYU43cXp5ZnpPU2EvazBwTU5OeWNpbDdGYlVEbHlwNmI4U3pJeWJq?=
 =?utf-8?B?c3paWFdGTlMxUWF2aWJGWmRUUjNXN0NrbHF5ZXFiK0kvYWlyMDBIeDdzSzBh?=
 =?utf-8?B?VmxYbmVhVno1Z2ZqWU5jYkFqb3ZyWEh5QzZKTmUvcnkwQ1NjUWN4cW1YZitY?=
 =?utf-8?B?aURka3VwQkFGNkJYQmhzTml6NWR4R2JtNmtRYlErS0N3MFppRnBUZjZ1bnRI?=
 =?utf-8?B?TC9OajFxdlFQMzZhZDhaTjNyT2g1VmRCSTUwZTRyUEtralFMd003WEVKNEY2?=
 =?utf-8?B?VUtBTzBHSXo1KzdNNFlGa1htQWdveWsrQ2UzU0VpYmVxUFI5L0dGTWgrTHNm?=
 =?utf-8?B?empmSVl1RTk3aDVDMlcwNzlmRnpTb3lvMUhteE1FdnlubjMvd2l2UVJwRG56?=
 =?utf-8?B?SzA5d1VFYnAxaks3djg4STNWb2RZbWVtLzdSTUNzRTlBMEFaKzV1c2VXY1pU?=
 =?utf-8?B?S1V1RjY2Z3QvblpyMU10aG9ob3luRmhlSjUvQW9GY0FjY3ptZElKQVhoUnpF?=
 =?utf-8?B?UkJZZW5NQXZZZitjU2Ryd2crNFFIbUxhMG5RTExyWmtsQ2Y2M0J2dzYxN0ln?=
 =?utf-8?B?RFBXdUh1MlNwbWoycFBxOS83SVhuRmlSWjZGblkwYVJUSE0vVXpLcGo2V05Q?=
 =?utf-8?B?UjZBWDl0VWl1OTVPMTBDajdoTFZQVXJyTzE5cmJvVFFRTnZXL3dsSGtYZEZw?=
 =?utf-8?B?ZTM3RWhnM0lqYUcvWFdRSzNwZWl6VEpxU3lOTExWSE5KQTk5c2RjTHU2c2NX?=
 =?utf-8?B?ZWMzTFdFVVNmc2JkMVVUZHI0TVlEdm9oajAxZmNWWW5ybUVCSGJ1bWFwNHR3?=
 =?utf-8?B?cE5KZ2RjRHFnK3M2Lytqb21VdmZUeWNZRnpGT0x4ZEJSS2hoY2pzN0J6YkRT?=
 =?utf-8?B?UU5WL1RkUnhFQ01Eblg2KzE0OTh2MDBhK3BrbVZOZjdhMmYyQVpkMHZTSWVa?=
 =?utf-8?B?WENuRzJ4T2JBOEdyaEcwUnVKelNOdFNOWUdweURYRHk2RTNVVHA2dDNJc3FB?=
 =?utf-8?B?SXZTak0wbFZRbmljbVpoWXFrWFBjS2kybzIvQ0VMdXkwdzlhN3NySCtwMkpK?=
 =?utf-8?B?VDJpT0Z2UzNXWVdUa21YWlVoVlVYMzVYRVhTMFRYLzZIMGpFME5veEhhRXNK?=
 =?utf-8?B?RThtNHA1WmluNXd1R1pkeE9NWmRyS0FJckJBOG9tendiTkpPNi83U1lvOVBG?=
 =?utf-8?B?T09adWE0bnZCOTRobnVYdnZycDR5ZkZMVmlSd2c4QnBBaVhnV1hqTGZENEY1?=
 =?utf-8?B?bkt3YXdHSTlZM1BIMFl6aWpraStCaGVFc3JIQllLZHZrN1NkMkFBMDF5cXNo?=
 =?utf-8?B?TEV1SXJXYk1Vc1pCUWh4L2tqa2IwVEgrWWNoOWM2clQ4MG42OGNFaWdJQmg4?=
 =?utf-8?B?Q0J6cDI3elNOU1E1YnAyUXVNNGp6ZXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 468ccc1b-b408-40bd-d9ce-08dc131d5990
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 03:19:55.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7776

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBUaHVyc2RheSwgSmFudWFyeSAxMSwgMjAyNCA0OjI3IFBNDQo+IA0KPiBPbiBGcmksIDIwMjQt
MDEtMDUgYXQgMTA6MzAgLTA4MDAsIG1oa2VsbGV5NThAZ21haWwuY29tIHdyb3RlOg0KPiA+IMKg
ICogaHZfdnRvbV9zZXRfaG9zdF92aXNpYmlsaXR5IC0gU2V0IHNwZWNpZmllZCBtZW1vcnkgdmlz
aWJsZSB0byBob3N0Lg0KPiA+IMKgICoNCj4gPiBAQCAtNTIxLDcgKzU0Nyw3IEBAIHN0YXRpYyBi
b29sIGh2X3Z0b21fc2V0X2hvc3RfdmlzaWJpbGl0eSh1bnNpZ25lZCBsb25nIGtidWZmZXIsIGlu
dCBwYWdlY291bnQsIGJvDQo+ID4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgcGZuX2FycmF5ID0ga21h
bGxvYyhIVl9IWVBfUEFHRV9TSVpFLCBHRlBfS0VSTkVMKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFwZm5fYXJyYXkpDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biBmYWxzZTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnJfc2V0
X21lbW9yeV9wOw0KPiA+DQo+IA0KPiBJZiBrbWFsbG9jKCkgZmFpbHMgaGVyZSwgYW5kIHNldF9t
ZW1vcnlfcCgpIHN1Y2NlZWRzIGJlbG93LCB0aGVuDQo+IGh2X3Z0b21fc2V0X2hvc3RfdmlzaWJp
bGl0eSgpIHJldHVybnMgdHJ1ZSwgYnV0IHNraXBzIGFsbCB0aGUNCj4gaHZfbWFya19ncGFfdmlz
aWJpbGl0eSgpIHdvcmsuIFNob3VsZG4ndCBpdCByZXR1cm4gZmFsc2U/DQoNCk9vb3BzLiAgWWVz
LiAgSWYgdGhlIGttYWxsb2MoKSBmYWlscywgbmVlZCB0byBzZXQgInJlc3VsdCIgdG8gZmFsc2Ug
YmVmb3JlDQpkb2luZyB0aGUgZ290by4gIFdpbGwgZml4IGluIHRoZSBuZXh0IHZlcnNpb24uDQoN
Ck1pY2hhZWwNCg==

