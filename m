Return-Path: <linux-hyperv+bounces-1106-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C867FC056
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 18:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482211C20A93
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2AA37D02;
	Tue, 28 Nov 2023 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gTRZMyaU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2057.outbound.protection.outlook.com [40.92.19.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF8D5B;
	Tue, 28 Nov 2023 09:34:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRJDh4dxpphcTcqJQw1XBOeLW5BFOj+THmU/ynQhs/1Cx1HwCaLV0IKLJbY7P41Hh5pFpcS77oJQ0QhNjE4eramHHDuAP/BmSjzPBmMeJX39lK7Qy0Ek6S1Qhp3c5fziQU2rI2rSaRJ68Inta2AqRNlocU4NNe1Vw5jBsQPOVgb1QUS1cAVUcaDRYOSCNB/c7b7Dzw0J3c6Nh+wNvFv9MtMjKYkW+FdI9ZQu656ZAJhZLAE5KwouSPay9b/SBAgQKtaGQZoepbQStyyXBR5RTqTd1DqR8XJxG4XgFxam0OUkWIeEVWU+gibLPp5HyiqFGSVf1vbOPD/1IVLtmeP7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etZG95++lXbBRptlcgOqOny5SulXi8w1E68hcgafbVc=;
 b=IIDQTiqt8YYXvTNSGB0dK5bFyyG7wrdfW6vFRwWaPXY58et89rWk+eGzJykuMJoYGsTLqvV1QaLdR/KDxClNFvYHa0usD7LXlkvZN3ChfCgPlKBbwyfjwj8Z2knguU59S7l8BxUWwYhyPvT4OmgOOWH7pHQN9Tm+6bxDGfbywLh2/s3ohj+Wx7SJA/6tYaXtr0D4G5smJV/aMMbIavrVhYD6+UYu2p5VOxt8zxvqqJg0cv460SyLNnDyFUP6L36cPeMUhuEjRfsRK7r7Bu52gjXOvGgdpMFAHEife5vSMyrM+dwSuoxKgTzEdCMUZx8EKO3aaAybwwBWMw4PzfDGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etZG95++lXbBRptlcgOqOny5SulXi8w1E68hcgafbVc=;
 b=gTRZMyaUfhgOZeR0FpB44hPw1XG/tA+ItmZgThK3mBx0cRgifJFy4seIzF5gTKu4Tql9vicHs8irFpzIZOm8Gew8h5+D9/GRSOxHI427jBJS9RAMF1Mk+GNKTztI1nYTl3CuPoJTRPuOsAsYN2VC43MCeAGTlx89dItIr9D8+9s/9Rvnjii1w/qKsomIfZO7z4VcZMBwagRJumpStl8FLKV8GBIPdjuYjIshWVePUGf01BwtzVAlZ2CQ/v+Aoa5QmkhXJSzh3IuEH+r/el3P3HxaE6c3gQaVIv9yfI8N2s2QvrCzwXasSBQIF8fFL5JeTS96MZuCB802HE8g6DAifg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7157.namprd02.prod.outlook.com (2603:10b6:510:17::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 17:34:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 17:34:38 +0000
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
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 2/8] x86/mm: Don't do a TLB flush if changing a PTE
 that isn't marked present
Thread-Topic: [PATCH v2 2/8] x86/mm: Don't do a TLB flush if changing a PTE
 that isn't marked present
Thread-Index: AQHaHMCZqqw22lSVnUqFkh2+XRP0FrCOxoeAgAE5LFA=
Date: Tue, 28 Nov 2023 17:34:38 +0000
Message-ID:
 <SN6PR02MB41573431683896536879EF40D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
	 <20231121212016.1154303-3-mhklinux@outlook.com>
 <4a64d05c80c9c490d291af881a86c3d853160060.camel@intel.com>
In-Reply-To: <4a64d05c80c9c490d291af881a86c3d853160060.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [vVoMCQPoqiUQ+vIvcEVURONnMzuvxNgX]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7157:EE_
x-ms-office365-filtering-correlation-id: 802ff28a-270a-412b-3996-08dbf0384bc8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7MQq/Z+861MpMmRItJtj4KzAPPrjAVzD9uoqjipBoN9ZdA3OyUwbV9tiJAI1m90sq5UnOv+nPweu4SmQIkgONBmRODRfGGbAKeOyKl9ODiRWEHpJyRU39m5HhXnkzWWMzC6aEd/vwW/94Txf09BAuPS+BzjrlzFjsEs+1oZDs/vNe+xic2ZL0TRMGnRQ0IgBNGdQ8UqOQ2dBrX7jPxbwG0Sp6Zw8L5KADRSQe6X7CG3WWpRZ9ZQtEfUYgpMtra6BB1uiDtcr+fHGBG5ktvRnDY+9NFP8TkbhG76rqZvF6trcq4HAqIjqJ65b+V22s9LHrUu+AWznu9KWyRTEFuZARuCUhUrtHUafClWcTRypFgmeolQ9L31GT087iltuS0Uxn4RBSkpTaZ2dXvS9lx5TZ5VnhFROB4qQv6mKnUcNsoiriB55vG46kD/V8uPqPg0YJHUJq86J+vJL//z+uAIffEc1zWuGglyK7S2gtlakrE/sCcCmi38pwVRLtQnnhc+JYv+byREj6sjOJJUZ9QBnB9iCYyvNpWZSt3Krygv2FeLmGK+LeQmHuM7hXGfCyJ8M
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1dObzdwMDNCMlBGbEM0RmlkK2NBSVlxK0E1cUtPdUVhek1uL2k1d0xsR2lm?=
 =?utf-8?B?cDJmTE50MUtsUWlKVDEvRmYyNm9pOVJIa2VjdkFMZHlQdmxqRzFHWEhoWHZ1?=
 =?utf-8?B?TVN3TU42bHdDQnZPT3o3LzJ4RzFMdEdkQmNZS1VBUXFEbUk0SGd6QTZLSWkv?=
 =?utf-8?B?MTB6MXFlSEc4V01XTjdURDNtdkwyUExtMkNBRmhWVS9IbXA0S01EZmZsNmNr?=
 =?utf-8?B?Qi8zTlZhYjRrVFQvZ0tSTGdoY2l5ZUo1ZDJDRUxqNzRkb2FVdkxheWVFdERl?=
 =?utf-8?B?MzJrRllsaGpRTGF2YW1PYTg2NThJbWNjZmNZbHZwM2RteThiUmI0cnp3SENN?=
 =?utf-8?B?MFRNSWhaUlJvYXhCNFRQUmJLNVl6UFEvK1lFTG9RYzNaUmxtRERzcXV3NFhS?=
 =?utf-8?B?QTV2b2x0UExOUzBpblZNQ2lWZkRSRWcrRFpDNXNNWWt3eFFSQXJFWGlyOGdL?=
 =?utf-8?B?dTNMZVFvL2pQbW5aenBSZGRnbEtZcFJGVTh3YSthaCtqT0Z1VllFTzROTDNB?=
 =?utf-8?B?MnM5TlIrM1FiQS84UXcwUll3YW5aUGlxVXdSd0VadkJhK25FaFVCeW1YN2hW?=
 =?utf-8?B?eFYvWUhLWXlXMzRjZnJYbjMzYTcyTjhsSXdOVHhVakFpQW9QVFc3M3RSSlcv?=
 =?utf-8?B?OWJxeU4ya2ZjL1ovRk1MS2ovZDRIVDFCMCt3NTJ4TUJlejI3dFRWRTNYVHo1?=
 =?utf-8?B?S2lCUGx0TUU4VkZGa0N6NXdOUU8yWmg4bXRQbnM2U3prUWlLOHRvZW9BTk9j?=
 =?utf-8?B?ZFErNTVrOW4zc3N1dXEyb2I2elZmZ0dVc0pCRlR2OGg3MUpkeVl3S2ZoR052?=
 =?utf-8?B?TFQ3T2xBNVFDekhWM0VkVjdKRFVvbE9mdW9yL3pQTGZJbTJkNlBER0VJU0M3?=
 =?utf-8?B?VVYxYzFPWmtHNC81Tjh3eEJPNDArNlJCNVRzd3JZSEJLSlc2dHJtVzFIc0VD?=
 =?utf-8?B?RUFBWjVwdkVjUGlOQU0veGtTWVBVclJHUGJ3WUFUc1ZvT3paSzhwTGMxZ1RQ?=
 =?utf-8?B?OEdsUWp2Y2EwUVhBT1lnZGlDVUpKalFrU3NybmpxN0x0b2M4UUdxME41ZVR3?=
 =?utf-8?B?S3NTR2ZITUFSTDBSUGh4dERmbS80VmxFa29BRDNKZXZYNTZxTWpHUVkzQlBW?=
 =?utf-8?B?c2N6MFJiNGxEMzNCWGVKaHdTTFhJVnpjZHpWb3JJUzdTa3ZzNlVkaXowSzhx?=
 =?utf-8?B?eVBKa3NienF6c2hSZGd2UlE4LzhtTjU1WE5vMytXVmhybjIxZ0JFYk03Y2w5?=
 =?utf-8?B?eFpWOEJCc2FUMTg2WmIxTUN3cFFSZ2RURG56cnpLNnV6Yld1a0xUcnpBL2VB?=
 =?utf-8?B?WDNOeGFzKytlei9nbjdJbU9kNkZFeXZ4U1RmNUN5L3JsYmswZ3NFQlZZYjRi?=
 =?utf-8?B?Y0xFblc5UzdxWjV5em1IRWx5Z2Y5WUdNUTBwcUliK1ZqTEZCQ1dSTkJzUWhJ?=
 =?utf-8?B?VllyVER3OU80MmJRWmUwNEh3UmxOWTlWL0pUejcybXUzVXlJMkdJeGx2Q1lz?=
 =?utf-8?B?R2h4S0Z3RU5RVzAxcldSckRyVVBJSlNkTEplalltWkE0b3llWWNyRk5VY3lk?=
 =?utf-8?Q?hl7XuW24OC87ZI1oMlnhGlMn7pM4HNAUA+LJBi9R05ON/G?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 802ff28a-270a-412b-3996-08dbf0384bc8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 17:34:38.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7157

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDI3LCAyMDIzIDI6MjEgUE0NCj4gDQo+IE9uIFR1ZSwgMjAyMy0x
MS0yMSBhdCAxMzoyMCAtMDgwMCwgbWhrZWxsZXk1OEBnbWFpbC5jb20gd3JvdGU6DQo+ID4gLS0t
IGEvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYw0KPiA+ICsrKyBiL2FyY2gveDg2L21tL3Bh
dC9zZXRfbWVtb3J5LmMNCj4gPiBAQCAtMTYzNiw3ICsxNjM2LDEwIEBAIHN0YXRpYyBpbnQgX19j
aGFuZ2VfcGFnZV9hdHRyKHN0cnVjdCBjcGFfZGF0YQ0KPiA+ICpjcGEsIGludCBwcmltYXJ5KQ0K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocHRlX3ZhbChvbGRfcHRlKSAhPSBwdGVfdmFsKG5ld19w
dGUpKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgc2V0X3B0ZV9hdG9taWMoa3B0ZSwgbmV3X3B0ZSk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjcGEtPmZsYWdzIHw9IENQQV9GTFVTSFRMQjsN
Cj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAvKiBJZiBvbGRfcHRlIGlzbid0IHByZXNlbnQsIGl0J3Mgbm90IGluIHRoZSBUTEIgKi8NCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChwdGVf
cHJlc2VudChvbGRfcHRlKSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjcGEtPmZsYWdzIHw9IENQQV9GTFVTSFRMQjsN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNwYS0+bnVtcGFnZXMgPSAxOw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ID4NCj4gDQo+IE1ha2VzIHNlbnNlIHRvIG1l
LiBUaGUgUE1EIGNhc2UgY2FuIGJlIGhhbmRsZWQgc2ltaWxhcmx5IGluDQo+IF9fc2hvdWxkX3Nw
bGl0X2xhcmdlX3BhZ2UoKS4NCg0KT0ssIEknbGwgbG9vayBhdCB0aGF0IGNhc2UuDQoNCj4gDQo+
IEkgYWxzbyB0aGluayBpdCBzaG91bGQgYmUgbW9yZSByb2J1c3QgaW4gcmVnYXJkcyB0byB0aGUg
Y2FjaGUgZmx1c2hpbmcNCj4gY2hhbmdlcy4NCj4gDQo+IElmIGNhbGxlcnMgZGlkOg0KPiBzZXRf
bWVtb3J5X25wKCkNCj4gc2V0X21lbW9yeV91YygpDQo+IHNldF9tZW1vcnlfcCgpDQo+IA0KPiBU
aGVuIHRoZSBjYWNoZSBmbHVzaCB3b3VsZCBiZSBtaXNzZWQuICBJIGRvbid0IHRoaW5rIGFueW9u
ZSBpcywgYnV0IHdlDQo+IHNob3VsZG4ndCBpbnRyb2R1Y2UgaGlkZGVuIHRoaW5ncyBsaWtlIHRo
YXQuIE1heWJlIGZpeCBpdCBsaWtlIHRoaXM6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
bW0vcGF0L3NldF9tZW1vcnkuYw0KPiBiL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4g
aW5kZXggZjUxOWU1Y2E1NDNiLi4yOGZmNTNhNDQ0N2EgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4gKysrIGIvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnku
Yw0KPiBAQCAtMTg1NiwxMSArMTg1Niw2IEBAIHN0YXRpYyBpbnQgY2hhbmdlX3BhZ2VfYXR0cl9z
ZXRfY2xyKHVuc2lnbmVkDQo+IGxvbmcgKmFkZHIsIGludCBudW1wYWdlcywNCj4gDQo+ICAgICAg
ICAgcmV0ID0gX19jaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIoJmNwYSwgMSk7DQo+IA0KPiAtICAg
ICAgIC8qDQo+IC0gICAgICAgICogQ2hlY2sgd2hldGhlciB3ZSByZWFsbHkgY2hhbmdlZCBzb21l
dGhpbmc6DQo+IC0gICAgICAgICovDQo+IC0gICAgICAgaWYgKCEoY3BhLmZsYWdzICYgQ1BBX0ZM
VVNIVExCKSkNCj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiANCj4gICAgICAgICAvKg0K
PiAgICAgICAgICAqIE5vIG5lZWQgdG8gZmx1c2gsIHdoZW4gd2UgZGlkIG5vdCBzZXQgYW55IG9m
IHRoZSBjYWNoaW5nDQo+IEBAIC0xODY4LDYgKzE4NjMsMTIgQEAgc3RhdGljIGludCBjaGFuZ2Vf
cGFnZV9hdHRyX3NldF9jbHIodW5zaWduZWQNCj4gbG9uZyAqYWRkciwgaW50IG51bXBhZ2VzLA0K
PiAgICAgICAgICAqLw0KPiAgICAgICAgIGNhY2hlID0gISFwZ3Byb3QyY2FjaGVtb2RlKG1hc2tf
c2V0KTsNCj4gDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBDaGVjayB3aGV0aGVyIHdlIHJl
YWxseSBjaGFuZ2VkIHNvbWV0aGluZzoNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBpZiAoIShj
cGEuZmxhZ3MgJiBDUEFfRkxVU0hUTEIpICYmICFjYWNoZSkNCj4gKyAgICAgICAgICAgICAgIGdv
dG8gb3V0Ow0KPiArDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBPbiBlcnJvcjsgZmx1c2gg
ZXZlcnl0aGluZyB0byBiZSBzdXJlLg0KPiAgICAgICAgICAqLw0KPiANCj4gSG1tLCBtaWdodCB3
YW50IHRvIG1haW50YWluIHRoZSAiT24gZXJyb3I7IGZsdXNoIGV2ZXJ5dGhpbmcgdG8gYmUgc3Vy
ZSINCj4gbG9naWMgaW4gdGhlIE5QLT5QIGNhc2UgYXMgd2VsbC4NCg0KT0ssIEkgc2VlIHlvdXIg
cG9pbnQuICBJIGhhZCBub3QgcmVhbGl6ZWQgdGhhdCBDUEFfRkxVU0hUTEIgcmVhbGx5DQpoYXMg
YSBtZWFuaW5nIGJleW9uZCBqdXN0IGluZGljYXRpbmcgdGhhdCB0aGUgVExCIG5lZWRzIHRvIGJl
DQpmbHVzaGVkLiAgSXQgcmVhbGx5IG1lYW5zICJzb21ldGhpbmcgaGFzIGNoYW5nZWQiIGluIGEg
UFRFLiAgSSdsbA0KaW5jb3Jwb3JhdGUgeW91ciBzdWdnZXN0aW9uLg0KDQpNaWNoYWVsDQo=

