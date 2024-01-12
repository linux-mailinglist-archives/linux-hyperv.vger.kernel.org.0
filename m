Return-Path: <linux-hyperv+bounces-1429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E182C5D5
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 20:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7901F24C36
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970115AEF;
	Fri, 12 Jan 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ruNVJavn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2021.outbound.protection.outlook.com [40.92.44.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766114F6D;
	Fri, 12 Jan 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKiCuSwa4kg0FeFMkR+yqKL2wQ5pzmdZ03s3i/Fj7IMBGyCC33b7vAXJK9qEfSEmGHi1kGHuqWCoHTvUR6GLfX5FRzhxR3kKLRmlh/EqxUFMzFQtzJfbZDrqM0Hzi3p0V8BmQjx/jI4dve5mqBAV9qlRqK5E4UO08UKzZPrLDMYYytZ/3leEtlV7fQxWz/4mdjEMo17HfoyLze3RZ00HIzSHkBkORS9cyXt+a1icKTLuV0nkxN7VdQkQf6+kU+EhK11kVmWghd0VYvYodnvgt4U3O0MqKmHYTR855mIxtLUCZwWDl0qY9wgO0xUrMLlQnNUA650WyGcj5wOKlLDEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dfK6ONCMxanrqKmaQRg5KEHujvyZ3GrkgVC0WH9fcY=;
 b=fFVN/cQHRbx14JdUWs5GIoe144NZi9vmSmTWbrjdro0UuIf6ctKfiCR+6CWo03R361umJ7Ym4g74Srek9gumwtqh5SWT1V8Gkm5ms4QQZNDXp9BZSjhzZFv8UvtyA4QVe2yfrKB/Cb7SsHE3VQsCZ2MquESVzUslzfyn53uXkWIytk1sPz58fOgf/i/ZdhMk6y2+zVV98QkbdSfgO2wy6fBUC52yUugOf1NZD86TC0+tiel0NoBJdw6+ZtMPlu41NtsOVzFoyLswe1yNgilB/7uvL6UOCaYJSbBFCLsWc/dLL/62wJ2K9Cq82ezB7HvBNyCtKoocbLQR6rR5aynhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dfK6ONCMxanrqKmaQRg5KEHujvyZ3GrkgVC0WH9fcY=;
 b=ruNVJavnTo4tTIoupWssNdOAEf9nkIf2WCC9bc6ChL9SFZUwknNXS2qilIt2L4bvXLW9PfHUoxJo7+wOfTFyMZ7IjbTZb5gakHWqFVC9KTm00MWYU7IrjBXIb4ZNEGPZEdO8f7WCUtzvX+b8XTqy9ceeZ/3c2MVFOlbeEMUKM9g5mJFMQDeAxk1KVDF1H8WnNxY1mOhOlXfRorQnQlKj/4EanLaeO7kIadMpaFmvjq+mRPriIZDq3EQ5lPauNREz9UbLIyVVSttmMtkadMeq33lSusecc5f1YcrSMUc4eW23piBzr4WvdFz35aCrMCK9SRzeSIP8bnmtlSHCFv0A3Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7224.namprd02.prod.outlook.com (2603:10b6:510:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 12 Jan
 2024 19:24:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 19:24:35 +0000
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
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Topic: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Index: AQHaQAVimv7uqsPUukqF0M02BKDa3rDVauWAgADjM5CAACg+AIAAIslw
Date: Fri, 12 Jan 2024 19:24:35 +0000
Message-ID:
 <SN6PR02MB415720444A3D848D444BB58AD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
	 <20240105183025.225972-2-mhklinux@outlook.com>
	 <9dcdd088494b3fa285781cccfd35cd47a70d69c3.camel@intel.com>
	 <SN6PR02MB4157B123128F6C2F6C3600D9D46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3ddc237d9fbbe0aa8838babf0df790076017e9f7.camel@intel.com>
In-Reply-To: <3ddc237d9fbbe0aa8838babf0df790076017e9f7.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [qcSC9gfHTdX5OGwYzpIUOPfVqwbGTdjX]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7224:EE_
x-ms-office365-filtering-correlation-id: 75457c14-8ff7-4d31-c04a-08dc13a41c8e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 62BuYVsfHXjfPmMZL86fR65dCck/x+nTXlg6dt1DSrzsGdMSm3lFaFnm/aQccVqTcG7Ym+EteXyJR9orHJOuHKQvZKY2sNkLS3tvPiVckpQNcYeWd2BuF3VU1bZa+xPlY6yVWsHdr3YtLPaH7d2RLcODaJgrqf79bF7nieqPJX3D+z+ZUTka3XnROVKicqzaDUrUpLlFGecEFzyKFcQc30zDV1L9SF519XA8YrDGJQJqmQwXEKGRk5DegD0VP57eaJnvjPYIIQck5ZkorSHV1EU3pkAFG9NYxf/6oS1IhoV4bxFc4+9H0TqvyIn3tTKrVsMOEFAiBKHMhj9OecPvMsaWiRCLjlEV/hZudojiA/vjhoH/5LWFvHTauJReBpFG098eMuirnyuWk7lA/LaHEkbhZ94wjpCtivqBd8ZOpXfW10MErBbr/+etliQSMTN841aBYZ8GX2xwkqhowdhzo9dnfZlHb8esbNlT8kUBEohDPtKNHmN7Ne4ERf3ykKOL8ij49gRGIW1AUw7NrWmI2SD6qyKh6cKH+P3Pe1souAs=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnFmblNXL280QUhOK3BONzJPako2TUFmdk53Q0VmbjBObmFHL1pOU3NLeHdT?=
 =?utf-8?B?TWNyRzNEclBjMHVsTjhJeHc2SDd3UVhWZ3MxWGt2TTN3SGZoc1U1WS90K25v?=
 =?utf-8?B?NFpRcWZ1VjlFUVV6WWEyM2hxWk9NU3RGb0hQOGVhOWhmSGZFbTZIOUsxODBs?=
 =?utf-8?B?cG9hZEx0czBkcllGV1ZuNlI0ZzAyd3BMazJjdmRvUFF1aEVKUTBLWGw4NWdO?=
 =?utf-8?B?TDM3MURaZWd1RjZRbkZFbmRJQ3Rub2R2UDZGM1RzWnRsd0NHZUQwaXgrSW5w?=
 =?utf-8?B?OEdlTzRieEg3OEo0bHBVRi85Umdxd2FMbDFMRW9hSGVCcFZEYW1lR3B4cDgw?=
 =?utf-8?B?R3VJdWNVS1NtMTd3Wm5RalFoOWZPaXN1ampobXQ5WjZXbjlFR1YwcDgzWmVX?=
 =?utf-8?B?UWs2WnRaZUYvbEMrQU9vWjZIQ0U0bnRNaG9LYmZkYzNDMEJmRzNSM0dpY3hX?=
 =?utf-8?B?L2ptRnd2NVNEdkpVLytTclNUM0VYd05zSGdiRXJWTUJWbXhGOCt4UHozRjlN?=
 =?utf-8?B?ZERDOVpJTlBGaUYvMGhFcGdKTU5SeFQ5NTF0UFdYckxXb3M4V0FVUlBkcHNQ?=
 =?utf-8?B?ZkQvYytpY3htMTdFTTBPQ3diTHJMSmtQd1ZEekJTa2k3ZnpNSCtEb0lPUmpn?=
 =?utf-8?B?S2lOVGUwRTRDMnoxbERncGxuN0JaRlIvU0VVSEcrSG8zUnQzVGZidUJLaG9B?=
 =?utf-8?B?TGJmWEo3UDJmcURnd1VxcCtud0tXTU83UFd1RTQrM2VYc0RWR2k2WDQ2UnMv?=
 =?utf-8?B?WHY2Q2JJSk5DZEhXUHJGTW5QVUN2NitWK1JpbDF2RXgvQmxyY0plZG9YOGMx?=
 =?utf-8?B?alFtZVdDWnhvQlZhMFgyamVYSWJpVHo0anRUYzRaUHRDMDdlZFlyeXhvSHQ0?=
 =?utf-8?B?Y1RqRzJLb0pJMU1tb1RTdTJPZDE3WC9zek9yejVRODdQU3pzVjFRemhGTUlu?=
 =?utf-8?B?RUYyYXFlOVdNd3lBNnBORkYxaVowMUt4ekxPRzl4eUlxUEVydmdQbTlrVHAw?=
 =?utf-8?B?QTlxWnhHaTdzR2szbnJ6Sy94a1c4dUp4ZTFRNUVFVy9WcmpVUWdDVGlWZUZI?=
 =?utf-8?B?VFErdEJKeEhheUNWODZ3MzBjY1VIVnYyOFlBVmk4YkpJZ2RGdEtPVTh4V0xq?=
 =?utf-8?B?RGtMcWpHVVIvaGR6dUxHd3FqT0tyRldxNVlTYm9PNm4yUVlzQXJzcTVOa29a?=
 =?utf-8?B?M3FGOHlZUTZzaWpVT3FNZjhqTjU1QTBvQzNLUUJURXpiOVNuTitHZ2VZNUJ6?=
 =?utf-8?B?dllPQ2ZxZmpoaS9YT0Z1aDAwVjVlMnROVG5VTkpqV3dDaDB2QUxUUmxDRjN2?=
 =?utf-8?B?NWZ3eUNCT1Aya3VjYTBYc2cvc3lKSVpnL3Y4OWtMWVo2ZVU4MU04bTNFNmpa?=
 =?utf-8?B?MXVBdCtwZ080bG43NEl5SWEzWHJrNFY2MTNjWXdrdWtqVmQvUXlOM2djbFJK?=
 =?utf-8?B?RUxPZm9DWFNNMDV0cmlCMUJ1Y0wrek9vTVRDSUE3MEtnY0FVYytITXhMRit5?=
 =?utf-8?B?ZzJRUHFvc1l3MXJibnNJMVB3RzVWdjZHcURKRU80WW03VGcvbzIwWUphdmoy?=
 =?utf-8?B?QjN2OVdENjQyNkJVV2pxY0xia2tqVWZyZTUzTTNlaFRic3NGV3owVCtzUXM5?=
 =?utf-8?B?UDhoRWNCVWJmSGc0WjJ1SDlSWmtxb1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75457c14-8ff7-4d31-c04a-08dc13a41c8e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 19:24:35.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7224

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBGcmlkYXksIEphbnVhcnkgMTIsIDIwMjQgOToxNyBBTQ0KPiANCj4gT24gRnJpLCAyMDI0LTAx
LTEyIGF0IDE1OjA3ICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBUaGUgY29tbWVu
dCBpcyBLaXJpbGwgU2h1dGVtb3YncyBzdWdnZXN0aW9uIGJhc2VkIG9uIGNvbW1lbnRzIGluDQo+
ID4gYW4gZWFybGllciB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBzZXJpZXMuwqAgU2VlIFsxXS7CoMKg
IFRoZSBpbnRlbnQgaXMgdG8NCj4gPiBwcmV2ZW50DQo+ID4gc29tZSBsYXRlciByZXZpc2lvbiB0
byBzbG93X3ZpcnRfdG9fcGh5cygpIGZyb20gYWRkaW5nIGEgY2hlY2sgZm9yDQo+ID4gdGhlDQo+
ID4gcHJlc2VudCBiaXQgYW5kIGJyZWFraW5nIHRoZSBDb0NvIFZNIGh5cGVydmlzb3IgY2FsbGJh
Y2suwqAgWWVzLCB0aGUNCj4gPiBjb21tZW50IGNvdWxkIGdldCBzdGFsZSwgYnV0IEknbSBub3Qg
c3VyZSBob3cgZWxzZSB0byBjYWxsIG91dCB0aGUNCj4gPiBpbXBsaWNpdCBkZXBlbmRlbmN5LsKg
IFRoZSBpZGVhIG9mIGNyZWF0aW5nIGEgcHJpdmF0ZSB2ZXJzaW9uIG9mDQo+ID4gc2xvd192aXJ0
X3RvX3BoeXMoKSBmb3IgdXNlIG9ubHkgaW4gdGhlIENvQ28gVk0gaHlwZXJ2aXNvciBjYWxsYmFj
aw0KPiA+IGlzIGFsc28gZGlzY3Vzc2VkIGluIHRoZSB0aHJlYWQsIGJ1dCB0aGF0IHNlZW1zIHdv
cnNlIG92ZXJhbGwuDQo+IA0KPiBXZWxsLCBpdCdzIG5vdCBhIGh1Z2UgZGVhbCwgYnV0IEkgd291
bGQgaGF2ZSBqdXN0IHB1dCBhIGNvbW1lbnQgYXQgdGhlDQo+IGNhbGxlciBsaWtlOg0KPiANCj4g
LyoNCj4gICogVXNlIHNsb3dfdmlydF90b19waHlzKCkgaW5zdGVhZCBvZiB2bWFsbG9jX3RvX3Bh
Z2UoKSwgYmVjYXVzZSBpdA0KPiAgKiByZXR1cm5zIHRoZSBQRk4gZXZlbiBmb3IgTlAgUFRFcy4N
Cj4gICovDQoNClllcywgdGhhdCBjb21tZW50IGlzIGFkZGVkIGluIHRoaXMgcGF0Y2guDQoNCj4g
DQo+IElmIHNvbWVvbmUgaXMgY2hhbmdpbmcgc2xvd192aXJ0X3RvX3BoeXMoKSB0aGV5IHNob3Vs
ZCBjaGVjayB0aGUNCj4gY2FsbGVycyB0byBtYWtlIHN1cmUgdGhleSB3b24ndCBicmVhayBhbnl0
aGluZy4gVGhleSBjYW4gc2VlIHRoZQ0KPiBjb21tZW50IHRoZW4gYW5kIGhhdmUgYW4gZWFzeSB0
aW1lLg0KPiANCj4gQW4gb3B0aW9uYWwgY29tbWVudCBhdCBzbG93X3ZpcnRfdG9fcGh5cygpIGNv
dWxkIGV4cGxhaW4gaG93IHRoZQ0KPiBmdW5jdGlvbiB3b3JrcyBpbiByZWdhcmRzIHRvIHRoZSBw
cmVzZW50IGJpdCwgYnV0IG5vdCBpbmNsdWRlIGRldGFpbHMNCj4gYWJvdXQgQ29Db08gVk0gcGFn
ZSB0cmFuc2l0aW9uJ3MgdXNhZ2Ugb2YgdGhlIHByZXNlbnQgYml0LiBUaGUgcHJvcG9zZWQNCj4g
Y29tbWVudCB0ZXh0IGxvb2tzIGxpa2Ugc29tZXRoaW5nIG1vcmUgYXBwcm9wcmlhdGUgZm9yIGEg
Y29tbWl0IGxvZy4NCg0KS2lyaWxsIC0tIHlvdSBvcmlnaW5hbGx5IGFza2VkIGZvciBhIGNvbW1l
bnQgaW4gc2xvd192aXJ0X3RvX3BoeXMoKS4gWzFdDQpBcmUgeW91IE9LIHdpdGggUmljaydzIHBy
b3Bvc2FsPw0KDQpNaWNoYWVsDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjMwODI4MjIxMzMzLjVibHNob3N5cWFmYmd3bGNAYm94LnNodXRlbW92Lm5hbWUvDQoNCg==

