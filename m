Return-Path: <linux-hyperv+bounces-1391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B5827839
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 20:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAD31C23206
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8554F9B;
	Mon,  8 Jan 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m+HLxHQS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2094.outbound.protection.outlook.com [40.92.45.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35054F8D;
	Mon,  8 Jan 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8Uq9uVqNJY2/pSzJt2Pm0rpsypw6rOVhqxEoogs9aw5heY0kObvO9KjFXuNNPliKBB7NPFpPZXPN3cdP2egZEJRshovaKdBiso9VAh3Ko9tPW0/nfu0N93MGSFjzOH4Pqq4J3u7C1CRIWVjSfzUTguAZjMtz/gm/Sys5KSKNp6y8y9rMvFjUO2WAVMz1Q8YC9CN3Xxjs54rGtxGUfxhbxR+QwMILjCv9kcfATa+CCjTX+KuBNp6DJ7fx5ZQ20zGQgEhrtxNOSZ6gUmACubmKlv7//J8aRkRFJPrhN6mmlTtT7lOxdwvVHunguMI2sTV8+FSbCbu88BtdftL3GlfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBAJYt+t9E67EsoO+qOnl4qqzP0i7UhnoSQx1Z2JACU=;
 b=GZHQTChZmXPSKB4q77R3Vud6+1vKeL9YCHTgg3jihnmLuKZUQGUFutn0vwH/OxCpwhADYRKfw6Hz7mTyJL5Dx00Q8lxGGgKecGhBi7W8+ZqOyH26KyfgB/PZgkCFC9h0evhB+ADgE0rJqgDOjwoHoFjg9kqYiDgfBOIc6rVDz8urEX7zWO7lbbUNUCUK1qI2bHMkVV0GcuqB+uuccGGSjUe8ncyAZ0syLG4CKzQI5/Yo6aEfYD9vRFR6XCGKQL2xv27FuTnnwm/p4W76bceETLSUkDZFSyddJ8bRDOf9MweQ6hrqRK/hmJ+sslgmc2PSDLBLuU/eYkqlv35Nzjfn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBAJYt+t9E67EsoO+qOnl4qqzP0i7UhnoSQx1Z2JACU=;
 b=m+HLxHQS5yX4kE1jAkJEFTkPeLFucYEADZsV1YTbERStE/5/BwZro7WGIjzbJlgZlGr5Pkp+BMml1aKGill0FMY5kV8sXbNhh1EHrtbsxTPl8355cpDlgDk0tvuP2ZXukUpMPyiM6KBYTHSnfCrtv3OdWXuwQ0hOrFb1MAi11jRJFRlu900K0k2iGfwFN7o/ZGOD6HAkt3kIzu3sQpDvgj6/RGhFfoEMyFUItmCZR3KDnoEJ+wAARM24Bcg5EXVoscPy7L8BNY67AMpI0fwYoTZ3xNOzFbyVQLISRkpJth5jsmlGJmlCxZ6d7cPlKfW4hPcENC4nzr1AxtpyUC+c0w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7732.namprd02.prod.outlook.com (2603:10b6:303:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 19:13:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 19:13:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"hch@infradead.org" <hch@infradead.org>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ardb@kernel.org" <ardb@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>,
	"seanjc@google.com" <seanjc@google.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Thread-Topic: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Thread-Index: AQHaQAV1hr9Lx3Gdjk27VQG8PMUDvrDQQ2sAgAAH5GA=
Date: Mon, 8 Jan 2024 19:13:24 +0000
Message-ID:
 <SN6PR02MB415797321652A47E166A295FD46B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
 <20240105183025.225972-4-mhklinux@outlook.com>
 <a559406d-acd5-40eb-906e-2b8b11739e9e@linux.intel.com>
In-Reply-To: <a559406d-acd5-40eb-906e-2b8b11739e9e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [e9Kwn8fS9FRnnb8HSo+8SsOOgiZxf9m+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7732:EE_
x-ms-office365-filtering-correlation-id: d035d1e0-8d23-4639-020a-08dc107de349
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Lg6+rwT7105V4xPc10432QB8wehQRInFO7spHO7gol0XZokScAQINYT9UtCpJJpGQlkDD4jTTt/HUxzHUoMCtlgvOtDulkqzFqORNygeJM8P7kycSTTvw0nZXLkjCO5nSv3NdkF4SwTsiBLSUsfHkmIihQVQj/Z43VHStKa4hm5tt/4+gyEVgtFwCSMxJyUmCxyJ9i+94YB7Xme08mx9gJnNNi7EMR1B/vkZEYZehJiwoxmA8gitxdzA3Y24ugu8/1kegxMR/ViFeHj0ymIzM8vYLyHFQe3e6UvNuGfWYswc7Dkz1XLeyaUN2KMbsfswlgXZwY13zl3sd6uriDmk/TQdt4Nelt6NsEDxgKWlNEO00K0ALCMLGf75YmxJIkr3bmV3QCwRcSv3N9lHVPXDVYxJFCepB16PLe4XuaY0BQjFEn/xOtS5sCNbiwR/B6hJFYWy8DCdV54pkuEnpIRiSjLNNIFvHSEVVqabqxISZ67NRygZ7dqr177mebc8lp2ib5+hGyNVZOWs+mxM9kbjDZuOane+k+dRgqnBo6pkK08h/mHmdwLUJVO4UTTunWsW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUEzRS9oVXRUZVdvTnkyeU0vK1kvQWVJZFVEcHdGaVdhb25OTkFnakFsWTlH?=
 =?utf-8?B?UGtubGJLV3FlV0hyL1drN05OeDhQeXRkT05jOVZLQnY3K3llT2ZPMVRKRHNl?=
 =?utf-8?B?cE12L295WHE2T0Q3QjZpdFhydFdRSGs3RWpBQ0V5dFAvTTEyRHYvWjB3TEFR?=
 =?utf-8?B?eU1wWnl1U2JTZUZRUmd0dldCUWxYaGNxVzNxMFVNeTZiR3d1cU9yWkF4dlBj?=
 =?utf-8?B?SzdIR3h3dnphZzlpUXpsL2k3T1dublJaTXJOUW9Gc2g5MHFDZjdTT3I4NCtu?=
 =?utf-8?B?WHJXOEtEaW00UXJJVDlrR0duQWZHK1FBNktsWlRndEpvWnhpM2cwa0l6aTdP?=
 =?utf-8?B?eXpFbGd1WUdXSmxzQityTTloaVIrV0Z5L1hnL3JPanpnaWFNY2MzbU01YXRx?=
 =?utf-8?B?WUtGZ1ZyWFhmeDkvVTRHOE9ySFNxcm14OC84eXZ2KytmdFpCeGZHSnV3UVFC?=
 =?utf-8?B?T0grQXhzWXNHVlFJUTBBMTdxd25QcUppQjJFZ1dwRGxBU3Q0bUNadTZQVm1S?=
 =?utf-8?B?YWZvbEVRZXZrWkF0OFp4ZkpyMjRZNzNzcExXMHlUZlB0SFBoKzNuNk9lZEht?=
 =?utf-8?B?L2lPM1Z3MFMrUGJ5ZWZranN0M2E4cGowZUxRbWluSmFQTXVFRU9FVU94djdQ?=
 =?utf-8?B?Uk12a2o3ZlJHVlhzQTQzWHJOWXU2LytueEdiQ2dwcmVkYjBQQTRSZkVIMjJw?=
 =?utf-8?B?M2pmaUVPR3VTZ1lyT3FBTDRmNGRocDlIQjVsWko0Z2tDbGlNT3VaMjByREg4?=
 =?utf-8?B?eGRVcU1jMllGUFExTnQ3bDBObDZQdnU3aGhFWHI2ei9SRVIvcit4T01EZGZw?=
 =?utf-8?B?R2R5SERoaE81dnFpZVY5SWZiRG5aaDR2YUU5UUJnVG1KWVJnZnFPMHBvL2s3?=
 =?utf-8?B?Mnc1Y3YrUEd0STdPU3NFeTJxU3ZxdDJISXpwTXpsbWIxYXBkLzBPRUIzSFBX?=
 =?utf-8?B?aEM5N3ZXZmtBMTlSOWtYQnNmZkJlK0F4SFAwWCtyWWVHaHpZQjlvYTVrV0li?=
 =?utf-8?B?V1VUclE3dmQvd2tvVGFHMXE1QmR1aVJBcmlzSm5YZXpRMTh0R3Z0eTlMTXda?=
 =?utf-8?B?NHlFclc1ZG5LZ091Z0ZnWm45eE9wb1FzRmNRZVVHaDhJN0xOMjhuL3ZXT3VV?=
 =?utf-8?B?MW5yNEdrNGpXcENyTW9ib1h3S0IwZUNVVDU1R2ZjK1RMUWJOT2hJQWRlWjZj?=
 =?utf-8?B?M0ErZG4wNWsrekFuajZ0cWw4NlVDRGo3UjBtaEtYQ1BQSGtFOU9wekR6QzhI?=
 =?utf-8?B?ZjdXVkUzdUZTQ0RzMkxPWkVzM0tGb29rOGwzcXJxb29CNDJZcXNaV1k5Y1dG?=
 =?utf-8?B?Uzh4T3JjTDdZRGhTNWs2Q1RxM2xEM09hU3JuM0hrRVVHVnA2d1hNZzJIMzVG?=
 =?utf-8?B?dDZGaFoyajNlaVRxa05jRlZubDU5UGxSZ0dHS1BLTXZaK3A5cUljWGROOG1D?=
 =?utf-8?B?T2dlMzdFbFgzUnVCWTZpYTlvMkhpaXRqRjhjUnJlNHB2VHpGWHorZjZEVXJ1?=
 =?utf-8?B?MXpzUzlCSXZsckNuUlYvK05iOHBzbW05dld4TGo1Vk82enpqWXpNUVdvYUhF?=
 =?utf-8?B?dTF6RmdGOWdaUUZ3ejdTMnRLa3ZKVmpqUEdXVjI2bHhKRS9HQUJqTlIrV2Z2?=
 =?utf-8?B?SjJRN0tJY0VTMGt5Ui90NzZLMGl4dmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d035d1e0-8d23-4639-020a-08dc107de349
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 19:13:24.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7732

RnJvbTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3
YW15QGxpbnV4LmludGVsLmNvbT4NClNlbnQ6IE1vbmRheSwgSmFudWFyeSA4LCAyMDI0IDEwOjM3
IEFNDQo+IA0KPiBPbiAxLzUvMjAyNCAxMDozMCBBTSwgbWhrZWxsZXk1OEBnbWFpbC5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KPiA+
DQo+ID4gSW4gYSBDb0NvIFZNLCB3aGVuIHRyYW5zaXRpb25pbmcgbWVtb3J5IGZyb20gZW5jcnlw
dGVkIHRvIGRlY3J5cHRlZCwgb3INCj4gPiB2aWNlIHZlcnNhLCB0aGUgY2FsbGVyIG9mIHNldF9t
ZW1vcnlfZW5jcnlwdGVkKCkgb3Igc2V0X21lbW9yeV9kZWNyeXB0ZWQoKQ0KPiA+IGlzIHJlc3Bv
bnNpYmxlIGZvciBlbnN1cmluZyB0aGUgbWVtb3J5IGlzbid0IGluIHVzZSBhbmQgaXNuJ3QgcmVm
ZXJlbmNlZA0KPiA+IHdoaWxlIHRoZSB0cmFuc2l0aW9uIGlzIGluIHByb2dyZXNzLiAgVGhlIHRy
YW5zaXRpb24gaGFzIG11bHRpcGxlIHN0ZXBzLA0KPiA+IGFuZCB0aGUgbWVtb3J5IGlzIGluIGFu
IGluY29uc2lzdGVudCBzdGF0ZSB1bnRpbCBhbGwgc3RlcHMgYXJlIGNvbXBsZXRlLg0KPiA+IEEg
cmVmZXJlbmNlIHdoaWxlIHRoZSBzdGF0ZSBpcyBpbmNvbnNpc3RlbnQgY291bGQgcmVzdWx0IGlu
IGFuIGV4Y2VwdGlvbg0KPiA+IHRoYXQgY2FuJ3QgYmUgY2xlYW5seSBmaXhlZCB1cC4NCj4gPg0K
PiA+IEhvd2V2ZXIsIHRoZSBrZXJuZWwgbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIG1lY2hhbmlz
bSBjb3VsZCBjYXVzZSBhIHN0cmF5DQo+ID4gcmVmZXJlbmNlIHRoYXQgY2FuJ3QgYmUgcHJldmVu
dGVkIGJ5IHRoZSBjYWxsZXIgb2Ygc2V0X21lbW9yeV9lbmNyeXB0ZWQoKQ0KPiA+IG9yIHNldF9t
ZW1vcnlfZGVjcnlwdGVkKCksIHNvIHRoZXJlJ3Mgc3BlY2lmaWMgY29kZSB0byBoYW5kbGUgdGhp
cyBjYXNlLg0KPiA+IEJ1dCBhIENvQ28gVk0gcnVubmluZyBvbiBIeXBlci1WIG1heSBiZSBjb25m
aWd1cmVkIHRvIHJ1biB3aXRoIGEgcGFyYXZpc29yLA0KPiA+IHdpdGggdGhlICNWQyBvciAjVkUg
ZXhjZXB0aW9uIHJvdXRlZCB0byB0aGUgcGFyYXZpc29yLiBUaGVyZSdzIG5vDQo+ID4gYXJjaGl0
ZWN0dXJhbCB3YXkgdG8gZm9yd2FyZCB0aGUgZXhjZXB0aW9ucyBiYWNrIHRvIHRoZSBndWVzdCBr
ZXJuZWwsIGFuZA0KPiA+IGluIHN1Y2ggYSBjYXNlLCB0aGUgbG9hZF91bmFsaWduZWRfemVyb3Bh
ZCgpIHNwZWNpZmljIGNvZGUgZG9lc24ndCB3b3JrLg0KPiA+DQo+ID4gVG8gYXZvaWQgdGhpcyBw
cm9ibGVtLCBtYXJrIHBhZ2VzIGFzICJub3QgcHJlc2VudCIgd2hpbGUgYSB0cmFuc2l0aW9uDQo+
ID4gaXMgaW4gcHJvZ3Jlc3MuIElmIGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSBjYXVzZXMgYSBz
dHJheSByZWZlcmVuY2UsIGENCj4gPiBub3JtYWwgcGFnZSBmYXVsdCBpcyBnZW5lcmF0ZWQgaW5z
dGVhZCBvZiAjVkMgb3IgI1ZFLCBhbmQgdGhlDQo+ID4gcGFnZS1mYXVsdC1iYXNlZCBmaXh1cCBo
YW5kbGVycyBmb3IgbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIHJlc29sdmUgdGhlDQo+ID4gcmVm
ZXJlbmNlLiBXaGVuIHRoZSBlbmNyeXB0ZWQvZGVjcnlwdGVkIHRyYW5zaXRpb24gaXMgY29tcGxl
dGUsIG1hcmsgdGhlDQo+ID4gcGFnZXMgYXMgInByZXNlbnQiIGFnYWluLg0KPiANCj4gQ2hhbmdl
IGxvb2tzIGdvb2QgdG8gbWUuIEJ1dCBJIGFtIHdvbmRlcmluZyB3aHkgYXJlIGFkZGluZyBpdCBw
YXJ0IG9mDQo+IHByZXBhcmUgYW5kIGZpbmlzaCBjYWxsYmFja3MgaW5zdGVhZCBvZiBkaXJlY3Rs
eSBpbiBzZXRfbWVtb3J5X2VuY3J5cHRlZCgpIGZ1bmN0aW9uLg0KPiANCg0KVGhlIHByZXBhcmUv
ZmluaXNoIGNhbGxiYWNrcyBhcmUgZGlmZmVyZW50IGZvciBURFgsIFNFVi1TTlAsIGFuZA0KSHlw
ZXItViBDb0NvIGd1ZXN0cyBydW5uaW5nIHdpdGggYSBwYXJhdmlzb3IgLS0gc28gdGhlcmUgYXJl
IHRocmVlIHNldHMNCm9mIGNhbGxiYWNrcy4gIEFzIGRlc2NyaWJlZCBpbiB0aGUgY292ZXIgbGV0
dGVyLCBJJ3ZlIGdpdmVuIHVwIG9uIHVzaW5nIHRoaXMNCnNjaGVtZSBmb3IgdGhlIFREWCBhbmQg
U0VWLVNOUCBjYXNlcywgYmVjYXVzZSBvZiB0aGUgZGlmZmljdWx0eSB3aXRoDQp0aGUgU0VWLVNO
UCBjYWxsYmFja3MgbmVlZGluZyBhIHZhbGlkIHZpcnR1YWwgYWRkcmVzcyAod2hlcmVhcyBURFgg
YW5kDQpIeXBlci1WIHBhcmF2aXNvciBuZWVkIG9ubHkgYSBwaHlzaWNhbCBhZGRyZXNzKS4gIFNv
IGl0IHNlZW1zIGxpa2UgdGhlDQpjYWxsYmFja3Mgc3BlY2lmaWMgdG8gdGhlIEh5cGVyLVYgcGFy
YXZpc29yIGFyZSB0aGUgbmF0dXJhbCBwbGFjZSBmb3IgdGhlDQpjb2RlLiAgVGhhdCBsZWF2ZXMg
dGhlIFREWCBhbmQgU0VWLVNOUCBjb2RlIHBhdGhzIHVuY2hhbmdlZCwgd2hpY2gNCndhcyBteSBp
bnRlbnQuDQoNCk9yIG1heWJlIEknbSBub3QgdW5kZXJzdGFuZGluZyB5b3VyIGNvbW1lbnQ/ICBJ
ZiB0aGF0J3MgdGhlIGNhc2UsDQpwbGVhc2UgZWxhYm9yYXRlLg0KDQpNaWNoYWVsDQoNCj4gUmV2
aWV3ZWQtYnk6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuDQo+IDxzYXRoeWFuYXJheWFuYW4u
a3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+IA0K

