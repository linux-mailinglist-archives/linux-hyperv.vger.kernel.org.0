Return-Path: <linux-hyperv+bounces-1326-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3221F80F594
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 19:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC709281ED9
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE89320B;
	Tue, 12 Dec 2023 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M/aYgfq8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2045.outbound.protection.outlook.com [40.92.19.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCAAA;
	Tue, 12 Dec 2023 10:35:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVs7gK6K7Cg+foAPII/er+JwfZeCy4edQA2R+IyZiLduv51e4nUCCMJYWsCg8/ZxDF9obb9z3DuuqdQs0ciG3gGx2Izv72kCXnQ9pT+W1KvKSU9paYHoMzjHHKkWcJnPjspMPURPz1jv+JB17xpYMKxbROGcTa+H7UStYmpy7U7SF73pmRCah9zB/+q9cdbi9d/DbSMzNt0loJXKnSwbiGxBBZknIe5y/A9KjPR6ersBCEb+0naMw+8oPks3fzJkrrVXkUNqn4uo0gCWCkTp1GaMNBYeAN5eNwQgqZsxuEyM79u/KrrOUMHywQS4nwClVdFkeg4UJLK+thoDM0vpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYQEx3nD6owAv7uZjAVo6yY0JiASjZnIGqM02bLLHbM=;
 b=jFgKNxM3d8xv5NttPjG/vMZvoZvYjm0WMQZ4Kc8X9XPPWG4JBl5BSPhm7WOdf5suC6qjXhahqjMuYJpvRYPhJ/3M35jT9Dp38DLnT0vFQcWNc9vfBE+B4BQzkyFu3y+/fYsJuGQHXkmmYWyyA5D54gX+K9AG6Np7jATbHu72nGrD/AyEIxIumbycD/GbumsNopTL168MQQegh5Eykgh50luPAJ29aB1TBBW+mDrPA51/THDUAEykwXz5bhziryZNR4WBX7XsdimYmqIVke8y1T8wE8e/RkCVTP2spyq1K6UmvgUlH20NVye8gyu2GIbj6R6r/zrAdQVmuDFxXS6+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYQEx3nD6owAv7uZjAVo6yY0JiASjZnIGqM02bLLHbM=;
 b=M/aYgfq8SMx7fcf3eS3jz1cwvndbA2sr2WPnb//gqcG9LTCxMibrxXnoH8ZjfyzAOfvHgsS+2jZS1J2NAmbGoRtT/aNSLWcCoT+aDP3YwwW96L6o5NNoThrJL45ih0hZpy2AWbmsSzCEh7+3r3wmgn0UVBxlDVUXgv3OrNZuI9AIhCWG99euEEuNV8o8PcTazDXFa3HxpComuqWV/UXEv2IjZlvzbuFb7DvvN9IwS7su692z8+rU+owWA87AknSEfceGsN1Hp6qGZeBg884Wbpj5Q15glygeRX4+xLcc0IrpawZ0jnweIPY2w+2qdKY/dy2HPwuBAgCQhS70h686bw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8667.namprd02.prod.outlook.com (2603:10b6:303:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 18:35:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 18:35:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "ardb@kernel.org"
	<ardb@kernel.org>, "Lutomirski, Andy" <luto@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a valid
 virtual address
Thread-Topic: [PATCH v2 4/8] x86/sev: Enable PVALIDATE for PFNs without a
 valid virtual address
Thread-Index: AQHaHMCfDTF3xlWByUOaPO0cv8EgVLCOur+AgAFOhjCAABdAgIAV34FA
Date: Tue, 12 Dec 2023 18:35:18 +0000
Message-ID:
 <SN6PR02MB4157AEA1E3B271D5C2CFA3F8D48EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
	 <20231121212016.1154303-5-mhklinux@outlook.com>
	 <3ddcad72637dece4bd3ecb7c49b8ad0e5bd233c0.camel@intel.com>
	 <SN6PR02MB4157A935C8B8F9DBB30F9512D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <00222b634b4ce443f8d1a793c4f8fe69b7ad39d0.camel@intel.com>
In-Reply-To: <00222b634b4ce443f8d1a793c4f8fe69b7ad39d0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ADFmctKyKWnYB5YmxZVKqgXpupNF/EKu]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8667:EE_
x-ms-office365-filtering-correlation-id: 3e5deee7-83cc-4ac3-3dfc-08dbfb411770
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jvKvw8gTwmk+tFOIufm2/tK+tpUwlZZyrr6oYX/j/8Z06M/TcethxAej/mEZQNlbfdTpMDdPkh9xXTIc2F8mPiYDQkLP81i2CdB21T081aKn5DwXFOmAgVIjSHitYVw/5LYraQJjE4jroR8Yzhu9ATy1jjZS2jZ3ucfa0FP1/xwmNRYRbwBWJFMvZeA/3SZV5y60K13VCtuyoRh5HBzVN5N5u2/EazUZZ7yqJ15AQzFWMJ/yrSJi0Kc+MEQp8M+bsSuE2JUTEsQpYBX6pErR573d2ToiiSFe1JQDs4T6q+VyWW70+4kImYKJvZ2FH30Y5FTh24B3T1MwnB/EowHnAl85Cgkl2nRcJWsDwjfdsYAVMzhW9iCCT+aU48Ry6ah3n8++5kq/P0Xb2ASP5YVBHuXICsFc1teYgHHI/ksTa1fgCmNvFRMq1QMZi46g3fpoxLwfLPIXsZ7ekw7vIs3Vf3QBDfoEXKDbS8WmXcqBHz4L0o2usyUhea6kR0fUsFqnXmgtJiijX/cWnh93N64k8tcIEhk8RuA2xD3E4/79RQYmqBFwF4V2eKpeR3qDz2Ib
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXBad0hJbWViUmZGY2N0ck42M0NuUWNWYVBRZXA3N2V5YXpzeE1SdFo3eFlB?=
 =?utf-8?B?TDNML0FlbWF0V3lJUGZYanNVNHNFNVRHTERRMlk1bFdSVlJJVXRpQVJjUVBz?=
 =?utf-8?B?a3k3VXZXTWN0NmpGLzFTcG54d0x1V3lWSGFCSlZVajlaK0JyQTFhL0hUTGJ3?=
 =?utf-8?B?VDROeHlYenJOS1FPVDhWY3ZPeTRPTEIrb2hjMHdobi9oVTZrQy92eGVoWEZE?=
 =?utf-8?B?bTBSUDhZSzNQOEFjb0RkRjhoNXd1OS9lVWczNjc1Wk9wUFU3RWNyRU1FVlJE?=
 =?utf-8?B?M0Y1MWM1SGVCV3dLVEhhUUFXcTcrWkpIeWRoQnpnc2ZDcERFRWVGTGZ2Ynlp?=
 =?utf-8?B?bUQvYmlkSDZJVlZFL1d5MUZ2YU1EWE5kNnFPS3l6cTBTRVJGODNOMmsvY3Vh?=
 =?utf-8?B?Wmw2OVZIL1ZJb05nNnI5RzZUT2JzQ25KSnkwWU9SM0FIZHdrUnpmSld6SVUr?=
 =?utf-8?B?OVlxaW5CWVNLYi8wQ2JJMmpRTUxTNVhhMXJJVVMyTlBDNzBWQzZjbng3M2ZG?=
 =?utf-8?B?UTBwcXQ2TjR1WU5WR3d5Zzd2NFlSRmkva1JHTUp1UDIxQjJxQXY1SVd1U1g3?=
 =?utf-8?B?WHdudEZxNFZ1NTdQako2eElUQldhOVZIcExPZVB3citTVTZMTkozcFdGOG5r?=
 =?utf-8?B?SHBNZEt2WDhtQWFadWVTbUZnRVIyeUlmd0NtamFyWFU1dVU3enVkYldiMDU1?=
 =?utf-8?B?STVsOGIxQWhaUm9Rd2FiNHcrckZodlkzMFhBYmNxZ0U1b05ScDVVYmVmSG8w?=
 =?utf-8?B?eVpKTEpzRSt1N05rd2FFZmphU0RNWFZkdG9SK0dDa0JkRDVid2RNRWxtS3ZJ?=
 =?utf-8?B?ZzlPQmszWXoxU0wxNVRHclFVSzBwVlFPaWNKQ2tNV3JHYXBJZFFqd2V6UElS?=
 =?utf-8?B?Y044eStoRzc0VzBaR0JPM1hMSHVibkVtaFBBSXl5TklhUjBwR2tsT1NQQjV6?=
 =?utf-8?B?QXRWKzZwcGYwRlFZYWxwOEpjYTh0ZGNRQjNSZ2pRemg5Rk9oT0pNbm9rUFlu?=
 =?utf-8?B?bWI1VkVEME5LUWpOMVhtRXd3VzU4amUxdVl4S3JBZ0pqN1o2N0ZSMlFja01O?=
 =?utf-8?B?cjVHS2kwZk9qeVZSbFRGRTdnY2tRTlQyTWl4OEVGRXJQR2YrYXZubWs0T3JX?=
 =?utf-8?B?b2czUXlnT1ZZQmNudCtVWnhhSVp3QktrWHAxS0UwZlNTUkRpUldOT3RzNGs5?=
 =?utf-8?B?cEhEb3dFVHl1SnMrdDhYNzN2YVBibHlYZTRwcVZXZlpIdktuVkFjQUtRUmJn?=
 =?utf-8?B?TlFUblo4TU9MSHk5YXh2c2piaEw0SUg3eVE4dXJQREp2QmhDcVlQd1JnVDdH?=
 =?utf-8?B?Z2drMTZldlB4SVNjNFY1QzdWZTh2bDhwQWRBQ29mK2JVNmxQL2VtSytiUnJ4?=
 =?utf-8?B?OEIwT2hENzl0aHhVN3ZQK0lOZ1ZTanBwZjRDUzN1Y2pQeXhmZ1JEZzNuRy9s?=
 =?utf-8?B?a29wNzl1ZXNQV3V6NXdnaVNuMUlCRU9IWWNvSCs1d1V6aktFK1RYd2ZxS3VE?=
 =?utf-8?B?cjB3SS9OVE13eEFId05vamM3ZlhoZEI0dXhOaTA0elRNeGVDaCt4enFNTFdo?=
 =?utf-8?Q?MTexvAQADEUaRfe7ez6P6usERwgFRKRqJ7EsLRh/ZwvIJu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5deee7-83cc-4ac3-3dfc-08dbfb411770
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 18:35:18.7367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8667

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBUdWVzZGF5LCBOb3ZlbWJlciAyOCwgMjAyMyAxMDo1OSBBTQ0KPiANCj4gT24gVHVlLCAyMDIz
LTExLTI4IGF0IDE4OjA4ICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiA+DQo+ID4g
PiBTb3J0IG9mIHNlcGFyYXRlbHksIGlmIHRob3NlIHZtYWxsb2Mgb2JqZWN0aW9ucyBjYW4ndCBi
ZSB3b3JrZWQNCj4gPiA+IHRocm91Z2gsIGRpZCB5b3UgY29uc2lkZXIgZG9pbmcgc29tZXRoaW5n
IGxpa2UgdGV4dF9wb2tlKCkgZG9lcw0KPiA+ID4gKGNyZWF0ZQ0KPiA+ID4gdGhlIHRlbXBvcmFy
eSBtYXBwaW5nIGluIGEgdGVtcG9yYXJ5IE1NKSBmb3IgcHZhbGlkYXRlIHB1cnBvc2VzPyBJDQo+
ID4gPiBkb24ndCBrbm93IGVub3VnaCBhYm91dCB3aGF0IGtpbmQgb2Ygc3BlY2lhbCBleGNlcHRp
b25zIG1pZ2h0IHBvcHVwDQo+ID4gPiBkdXJpbmcgdGhhdCBvcGVyYXRpb24gdGhvdWdoLCBtaWdo
dCBiZSBwbGF5aW5nIHdpdGggZmlyZS4uLg0KPiA+DQo+ID4gSW50ZXJlc3RpbmcgaWRlYS7CoCBC
dXQgZnJvbSBhIHF1aWNrIGdsYW5jZSBhdCB0aGUgdGV4dF9wb2tlKCkgY29kZSwNCj4gPiBzdWNo
IGFuIGFwcHJvYWNoIHNlZW1zIHNvbWV3aGF0IGNvbXBsZXgsIGFuZCBJIHN1c3BlY3QgaXQgd2ls
bCBoYXZlDQo+ID4gdGhlIHNhbWUgcGVyZiBpc3N1ZXMgKG9yIHdvcnNlKSBhcyBjcmVhdGluZyBh
IG5ldyB2bWFsbG9jIGFyZWEgZm9yDQo+ID4gZWFjaCBQVkFMSURBVEUgaW52b2NhdGlvbi4NCj4g
DQo+IFVzaW5nIG5ldyB2bWFsbG9jIGFyZWEncyB3aWxsIGV2ZW50dWFsbHkgcmVzdWx0IGluIGEg
a2VybmVsIHNob290ZG93biwNCj4gYnV0IHVzdWFsbHkgaGF2ZSBubyBmbHVzaGVzLiB0ZXh0X3Bv
a2Ugd2lsbCBhbHdheXMgcmVzdWx0IGluIGEgbG9jYWwtDQo+IG9ubHkgZmx1c2guIFNvIGF0IGxl
YXN0IHdoYXRldmVyIHNsb3dkb3duIHRoZXJlIGlzIHdvdWxkIG9ubHkgYWZmZWN0DQo+IHRoZSBj
YWxsaW5nIHRocmVhZC4NCj4gDQo+IEFzIGZvciBjb21wbGV4aXR5LCBJIHRoaW5rIGl0IG1pZ2h0
IGJlIHNpbXBsZSB0byBpbXBsZW1lbnQgYWN0dWFsbHkuDQo+IFdoYXQga2luZCBvZiBzcGVjaWFs
IGV4Y2VwdGlvbnMgY291bGQgY29tZSBvdXQgb2YgcHZhbGlkYXRlLCBJJ20gbm90IHNvDQo+IHN1
cmUuIEJ1dCB0aGUga2VybmVsIHRlcm1pbmF0ZXMgdGhlIFZNIG9uIGZhaWx1cmUgYW55d2F5LCBz
byBtYXliZSBpdCdzDQo+IG5vdCBhbiBpc3N1ZT8NCg0KU29ycnkgZm9yIHRoZSBkZWxheSBpbiBn
ZXR0aW5nIGJhY2sgdG8gdGhpcyB0b3BpYy4NCg0KT0ssIEkgc2VlIG5vdyB3aGF0IHlvdSBhcmUg
c3VnZ2VzdGluZy4gRm9yIGVhY2ggcGFnZSB0aGF0IG5lZWRzIHRvDQpiZSBQVkFMSURBVEUnZCwg
dXNlIF9fdGV4dF9wb2tlKCkgdG8gY3JlYXRlIHRoZSB0ZW1wIG1hcHBpbmcgYW5kDQpydW4gUFZB
TElEQVRFLiAgIEhvd2V2ZXIsIHRoZXJlIGFyZSBzb21lIHByb2JsZW1zLiAgX190ZXh0X3Bva2Uo
KQ0KcnVucyB2bWFsbG9jX3RvX3BhZ2UoKSBmb3IgYWRkcmVzc2VzIHRoYXQgYXJlbid0IGNvcmUg
a2VybmVsIHRleHQsDQphbmQgdm1hbGxvY190b19wYWdlKCkgd2lsbCBmYWlsIGlmIHRoZSBQVEUg
InByZXNlbnQiIGJpdCBoYXMgYmVlbg0KY2xlYXJlZC4gIFRoYXQgY291bGQgYmUgZWFzaWx5IGFk
ZHJlc3NlZCBieSBjaGFuZ2luZyBpdCB0byB1c2UNCnNsb3dfdmlydF90b19waHlzKCkuICBCdXQg
UFZBTElEQVRFIGFsc28gbmVlZHMgdG8gYmUgYWJsZSB0byByZXR1cm4NCnRoZSBQVkFMSURBVEVf
RkFJTF9TSVpFTUlTTUFUQ0ggZXJyb3IgY29kZSwgd2hpY2ggaXMgdGVzdGVkIGZvcg0KaW4gcHZh
bGlkYXRlX3BhZ2VzKCkgYW5kIGRvZXMgbm90IHRlcm1pbmF0ZSB0aGUgVk0uICBfX3RleHRfcG9r
ZSgpDQpkb2VzbuKAmXQgaGF2ZSB0aGUgbWFjaGluZXJ5IHRvIHJldHVybiBzdWNoIGFuIGVycm9y
IGNvZGUsIGFuZA0KdGhhdCdzIGhhcmRlciB0byBmaXguDQoNClRoZXJlJ3MgYWxzbyB0aGUgY29u
Y2VwdHVhbCBpc3N1ZS4gIFRoZSBQVkFMSURBVEUgdXNlIGNhc2UgaXNuJ3QNCndvcmtpbmcgd2l0
aCBhIHRleHQgYXJlYSwgc28gdGhhdCBjYXNlIHdvdWxkIGJlIGFidXNpbmcgInRleHRfcG9rZSIN
CmEgYml0LiAgSSBjb3VsZCBpbWFnaW5lIF9fdGV4dF9wb2tlKCkgaGF2aW5nIGNvZGUgdG8gdmVy
aWZ5IHRoYXQgaXQncw0Kd29ya2luZyBvbiBhIHRleHQgYXJlYSwgZXZlbiBpZiB0aGF0IGNvZGUg
aXNuJ3QgdGhlcmUgbm93Lg0KDQpUbyBnZXQgYSBzZW5zZSBvZiBwZXJmb3JtYW5jZSwgSSBoYWNr
ZWQgdGhlIGVxdWl2YWxlbnQgb2YgdGV4dF9wb2tlKCkNCnRvIHdvcmsgd2l0aCBQVkFMSURBVEUu
ICBUaGUgYmlnZ2VzdCBjYXNlIG9mIHRyYW5zaXRpb25pbmcgcGFnZXMgZnJvbQ0KZW5jcnlwdGVk
IHRvIGRlY3J5cHRlZCBpcyB0aGUgc3dpb3RsYiBhcmVhLCB3aGljaCBpcyAxIEdieXRlIGZvciBh
DQpWTSB3aXRoIDE2IEdieXRlcyBvciBtb3JlIG9mIG1lbW9yeS4gIEluIGEgSHlwZXItViBDb0Nv
IFZNLCBjdXJyZW50DQpjb2RlIHRha2VzIGFib3V0IDI3MCBtaWxsaXNlY29uZHMgdG8gdHJhbnNp
dGlvbiB0aGF0IDEgR2J5dGUgc3dpb3RsYiBhcmVhLg0KV2l0aCBteSBpbml0aWFsIGFwcHJvYWNo
IHVzaW5nIHZtYXBfcGFnZXNfcmFuZ2UoKSwgdGhhdCAyNzAgbXMgd2VudCB0bw0KMzE5IG1zLCB3
aGljaCBpcyBmYWlybHkgbmVnbGlnaWJsZSBpbiB0aGUgb3ZlcmFsbCBWTSBib290IHRpbWUuICBV
c2luZyB0aGUNCnRleHRfcG9rZSgpIGFwcHJvYWNoIGluY3JlYXNlZCB0aGUgdGltZSB0byAzNjgg
bXMsIHdoaWNoIGlzIGJpZ2dlciBidXQNCnN0aWxsIHByb2JhYmx5IG5vdCBhIHNob3ctc3RvcHBl
ci4gIEl0J3MgZGVmaW5pdGVseSBmYXN0ZXIgdGhhbiBjcmVhdGluZyBhDQpuZXcgdm1hbGxvYyBh
cmVhIGZvciBlYWNoIHBhZ2UgdGhhdCBuZWVkcyB0byBiZSBQVkFMSURBVEUnZCwgd2hpY2gNCmFk
ZHMgYWJvdXQgNiBzZWNvbmRzIHRvIHRoZSBib290IHRpbWUuDQoNCkFsbC1pbi1hbGwsICBJJ20g
YmFjayB0byBteSBQbGFuIEIsIHdoaWNoIGlzIHRvIG1hcmsgdGhlIHBhZ2VzICJub3QNCnByZXNl
bnQiIG9ubHkgaW4gY29uZmlndXJhdGlvbnMgd2hlcmUgdGhlIGh5cGVydmlzb3IgY2FsbGJhY2tz
IG9wZXJhdGUNCm9uIHBoeXNpY2FsIGFkZHJlc3NlcyBpbnN0ZWFkIG9mIHZpcnR1YWwgYWRkcmVz
c2VzLiAgIFNpbmNlIFNFVi1TTlANCm5lZWRzIHZpcnR1YWwgYWRkcmVzc2VzLCBpdCB3aWxsIG5l
ZWQgdG8gaGFuZGxlIGV4Y2VwdGlvbnMgZ2VuZXJhdGVkDQpieSBsb2FkX3VuYWxpZ25lZF96ZXJv
cGFkKCkgYW5kIGRvIHRoZSBhcHByb3ByaWF0ZSBmaXh1cC4NCg0KSSdsbCB0cnkgdG8gZ2V0IG15
ICJQbGFuIEIiIHBhdGNoIHNldCBwb3N0ZWQgaW4gYSBuZXcgZmV3IGRheXMuDQoNCk1pY2hhZWwN
Cg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+IGIv
YXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCj4gaW5kZXggNzNiZTM5MzFlNGYwLi5hMTMy
OTM1NjRlZWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+IEBAIC0xOTA1LDYgKzE5MDUs
MTYgQEAgdm9pZCAqdGV4dF9wb2tlKHZvaWQgKmFkZHIsIGNvbnN0IHZvaWQgKm9wY29kZSwNCj4g
c2l6ZV90IGxlbikNCj4gICAgICAgICByZXR1cm4gX190ZXh0X3Bva2UodGV4dF9wb2tlX21lbWNw
eSwgYWRkciwgb3Bjb2RlLCBsZW4pOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIHRleHRfcG9r
ZV9wdmFsaWRhdGUodm9pZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdA0KPiBsZW4pDQo+
ICt7DQo+ICsgICAgICAgcHZhbGlkYXRlKGRzdCwgbGVuLCB0cnVlKTsgLy8gaWYgZmFpbCwgdGVy
bWluYXRlDQo+ICt9DQo+ICsNCj4gK3ZvaWQgKnB2YWxpZGF0ZWRfcG9rZSh2b2lkICphZGRyKQ0K
PiArew0KPiArICAgICAgIHJldHVybiBfX3RleHRfcG9rZSh0ZXh0X3Bva2VfcHZhbGlkYXRlLCBh
ZGRyLCBOVUxMLCBQQUdFX1NJWkUpOw0KPiArfQ0KPiArDQo+ICAvKioNCj4gICAqIHRleHRfcG9r
ZV9rZ2RiIC0gVXBkYXRlIGluc3RydWN0aW9ucyBvbiBhIGxpdmUga2VybmVsIGJ5IGtnZGINCj4g
ICAqIEBhZGRyOiBhZGRyZXNzIHRvIG1vZGlmeQ0KPiANCj4gDQo+IA0KPiA+DQo+ID4gQXQgdGhp
cyBwb2ludCwgdGhlIGNvbXBsZXhpdHkgb2YgY3JlYXRpbmcgdGhlIHRlbXAgbWFwcGluZyBmb3IN
Cj4gPiBQVkFMSURBVEUgaXMgc2VlbWluZyBleGNlc3NpdmUuwqAgT24gYmFsYW5jZSBpdCBzZWVt
cyBzaW1wbGVyIHRvDQo+ID4gcmV2ZXJ0IHRvIGFuIGFwcHJvYWNoIHdoZXJlIHRoZSB1c2Ugb2Yg
c2V0X21lbW9yeV9ucCgpIGFuZA0KPiA+IHNldF9tZW1vcnlfcCgpIGlzIGNvbmRpdGlvbmFsLsKg
IEl0IHdvdWxkIGJlIG5lY2Vzc2FyeSB3aGVuICNWQw0KPiA+IGFuZCAjVkUgZXhjZXB0aW9ucyBh
cmUgZGlyZWN0ZWQgdG8gYSBwYXJhdmlzb3IuwqAgKFRoaXMgYXNzdW1lcyB0aGUNCj4gPiBwYXJh
dmlzb3IgaW50ZXJmYWNlIGluIHRoZSBoeXBlcnZpc29yIGNhbGxiYWNrcyBkb2VzIHRoZSBuYXR1
cmFsIHRoaW5nDQo+ID4gb2Ygd29ya2luZyB3aXRoIHBoeXNpY2FsIGFkZHJlc3Nlcywgc28gdGhl
cmUncyBubyBuZWVkIGZvciBhIHRlbXANCj4gPiBtYXBwaW5nLikNCj4gPg0KPiA+IE9wdGlvbmFs
bHksIHRoZSBzZXRfbWVtb3J5X25wKCkvc2V0X21lbW9yeV9wKCkgYXBwcm9hY2ggY291bGQNCj4g
PiBiZSB1c2VkIGluIG90aGVyIGNhc2VzIHdoZXJlIHRoZSBoeXBlcnZpc29yIGNhbGxiYWNrcyB3
b3JrIHdpdGgNCj4gPiBwaHlzaWNhbCBhZGRyZXNzZXMuwqAgQnV0IGl0IGNhbid0IGJlIHVzZWQg
d2l0aCBjYXNlcyB3aGVyZSB0aGUNCj4gPiBoeXBlcnZpc29yIGNhbGxiYWNrcyBuZWVkIHZhbGlk
IHZpcnR1YWwgYWRkcmVzc2VzLg0KPiA+DQo+ID4gU28gb24gbmV0LCBzZXRfbWVtb3J5X25wKCkv
c2V0X21lbW9yeV9wKCkgd291bGQgYmUgdXNlZCBpbg0KPiA+IHRoZSBIeXBlci1WIGNhc2VzIG9m
IFREWCBhbmQgU0VWLVNOUCB3aXRoIGEgcGFyYXZpc29yLsKgwqAgSXQgY291bGQNCj4gPiBvcHRp
b25hbGx5IGJlIHVzZWQgd2l0aCBURFggd2l0aCBubyBwYXJhdmlzb3IsIGJ1dCBteSBzZW5zZSBp
cw0KPiA+IHRoYXQgS2lyaWxsIHdhbnRzIHRvIGtlZXAgVERYICJhcyBpcyIgYW5kIGxldCB0aGUg
ZXhjZXB0aW9uIGhhbmRsZXJzDQo+ID4gZG8gdGhlIGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSBm
aXh1cC4NCj4gPg0KPiA+IEl0IGNvdWxkIG5vdCBiZSB1c2VkIHdpdGggU0VWLVNOUCB3aXRoIG5v
IHBhcmF2aXNvci7CoMKgIEFkZGl0aW9uYWwgZml4ZXMNCj4gPiBtYXkgYmUgbmVlZGVkIG9uIHRo
ZSBTRVYtU05QIHNpZGUgdG8gcHJvcGVybHkgZml4dXANCj4gPiBsb2FkX3VuYWxpZ25lZF96ZXJv
cGFkKCkgYWNjZXNzZXMgdG8gYSBwYWdlIHRoYXQncyBpbiB0cmFuc2l0aW9uDQo+ID4gYmV0d2Vl
biBlbmNyeXB0ZWQgYW5kIGRlY3J5cHRlZC4NCj4gPg0KPiANCj4gWWVhLCBJIGRvbid0IGtub3cg
YWJvdXQgdGhpcyBwYXJhdmlzb3IvZXhjZXB0aW9uIHN0dWZmLg0K

