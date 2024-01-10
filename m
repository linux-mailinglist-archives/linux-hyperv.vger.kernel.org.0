Return-Path: <linux-hyperv+bounces-1411-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C963829FDD
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3412428467D
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233E4D59F;
	Wed, 10 Jan 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ieGdhSqv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52634F1FA;
	Wed, 10 Jan 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4UWkCALF59Z5mnZP1hNTVu6XJbGwE9D7QZrU0Cw5jb6Z9heylU/jrG6i9wZlO0ZIlgj17ei2pdw/d7sHzW0anT9GkYAdo83m0VoaxHRQFrc9Jdscd/pG+/2xB12EnfLsnhnh8jaUkBEPiCURt1UPxIy2Y4rX1J7IfogE8fMZkfsI4XO0K9gb+zbj/O2LtT/s5+v6esMMZ5SgcAcx2JSPw7HTQw+UKlUzMniev47TJynnBrOIpFK4ZO8A7tDPU4EezXvkQwkUVRgs1RVZSFQ9GgkESBr/vmwqlOKf0c3alNZnzuQ3jOd9GyyHRQFz1quTb+zDsHoyHgmhXUTvtBMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lydDfVtjC6uQZ3TH97p0m2pnzAWZD5QVHp6JxLWMmiU=;
 b=dpJgBGfnrzL6tAWHovQIdBtAL/d8nRm9IL9qSGZhXHADCDOvT12tn0aqh81chHEsAFZcIrswvLDC4EUUt203SYhiZPXuoc0H9CWN5PD8JMr4L5evqK6fyMHgIGK74b9l9ub9m8fN2oMfYykDtWAVpLDP4BPThkvQNQtu1BBCyKiW8YiEUaDCbac66XNTLZmW9HChQFnPn6uhfs6UnCFfSAmusxtl1OWtoqSgqNWO3jaWMhvY3oXloW0v2y4jWfs5l1sWdZpu3WverA7WV15ugCsRaDHo0eZODbkSy4J2iPelQM3AJN3j5FPlUsS/lGLyVRwV7MBDh+dxJrhO/Y5caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lydDfVtjC6uQZ3TH97p0m2pnzAWZD5QVHp6JxLWMmiU=;
 b=ieGdhSqv2j7HVfqYjDrWPLPyMGJYEzEX3OfdyYbnGMHqdLGovNnEXGTTM5t2RM8bCwGkHGYMBA11hlbmFi3JaOdgtdCmBBzAjyRdHPQyTYg0EXAa2CjtyJwZ5Zv9ZJdHcBohQCRU/gjfOBzZjoiZ1K8poa84gcp5okXB465WGvRSPkBYMi24vJlnPg27V2exlrMM5ckJBbImkC1cZm9cmaj4xHB2PWYNTfLzyZLBxXW+RKuM/Y3bxAa0ELZMCS9btGsFBplbq/oZVdKtR17mXPS/g+MJIEfxxIYGFV+MRDatnto1yYqs7lkeSNBbHOW0FCslsw9hbCnlicogRlFzbg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6745.namprd02.prod.outlook.com (2603:10b6:5:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 17:53:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 17:53:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Topic: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Index: AQHaQ7PyvvrIb8tUYUye7rRKlkvVrLDTNj6ggAARj4CAAAp1kA==
Date: Wed, 10 Jan 2024 17:53:17 +0000
Message-ID:
 <SN6PR02MB415767E13A2CA055EB154011D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
 <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1910913d-c3fe-45ab-a871-deda5318e2cf@web.de>
In-Reply-To: <1910913d-c3fe-45ab-a871-deda5318e2cf@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ll1+VucPqJM3zZY/J9+rZhQlHFcAhdYM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6745:EE_
x-ms-office365-filtering-correlation-id: 6af7bc59-f020-4e26-3c5a-08dc120506cf
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XiYslDLLfdkzBVis25dRNGgwE+LeRAG9g4Q9Bz67/ZmrGJ2eLcPRnKYx0YABAEZgXjx58qyoygdmAFc9TNXnzwJucJeozyEHXroaflldHzyObbVtgE53Dg1lgdPzX/GlO4hebLMbgNxXIYqZScnwDUGK52Ja4bAKF2khhtvr4a3bRvJkaRrtEeblfOCQ/iL99iZYqIwle0Q1Tb3PUf62k5R8UVnYGqHVbczlwBuw20Va28DBDi1oLQz/lRZrOXRrkxG9FY7K0qmYGV6EYIKvZ+kCyN1UGXtZjZmWLFIDPlSo8U3R20Rk8doJzt4LN3LI89T34D6qQbadbj3pDG5cOa0XzljYacewhQVVHAFSSDt5MTR88hFEUtYxi5WDbv4E9vJgswxIxOvqdh4ATx77nl7sn2qfSXXiJuRrVkQiP3M+HmBUJULtFY61E6FleV5wjnTltsLnNq0yUlf9boDku/LxSWvnBIAPhFInjeXZQer93CUWkQcX/zrTDS87qPLk2XQz+iDL6vdW3AfkQLLxjHm6c1ujYaN1P1ILfMbpNJ9PL/z0QCP9gDfSSG0C6Y1j
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnVQenpZZFBteE9EaWhUODZ4Z0liNDZtYkozSmpROURuSThpS0dlQ05OdU5B?=
 =?utf-8?B?S2R5bG5wdk1ONTNmZDVkV2EyWkNjSHZiaWNDdkQ1eFZsR0t1ZUdwUVE3ZVBW?=
 =?utf-8?B?dlJwekJQUFNpdzI4QkpsZ0t0ZTlkNlhyT3BxREliek4yNmtmQS9IN2tzMmFi?=
 =?utf-8?B?TmZ3YU1oLzlweVRvYXZJV0VJWlhicGVCQ3hVcUpRajh2N1N6K3cwZnI3M29V?=
 =?utf-8?B?WkFvVVR1Um0vOVBvcmYzMU10bWpFUlNXYWN1VktKaSticzQ3TFpSeXc0cXNY?=
 =?utf-8?B?SmpaOUZ3MXI0V1NXbmpUYUEzcnVLcUg5TTFnMzc5VjVGZmVtMm1uaFNyc2dj?=
 =?utf-8?B?eTMreVk4ZjVUUjExam41OTliaExTU3A4dHRMdFJtSXNWNjVjQS9aRHFTN2tu?=
 =?utf-8?B?SStHVTRvY2FGUUx6RVBva0k3T2FieVlXMzRaYzBGM2RlMnZDS0Q0THlhMGJX?=
 =?utf-8?B?bVJrZnEvdzNFT3lBdFNYNXo4amxIbUhiblQ1RDkwSzJ1N3ZwOExGVUVEMlVr?=
 =?utf-8?B?aTNDRktNcThaSWRWSUppRU5zZktiRFdkWnlrWkZ3TUx4RytaL2FEcTgySVpV?=
 =?utf-8?B?a0h0MkhnYTdRU1BkU0tieTUrMjM5UDlXbThJL1d6UlIrdzg5WFZOM2lIYTNs?=
 =?utf-8?B?NGVpN1BUblJaSlNPVUJzNkkyQ3Rmc0tFMUJ1eXFFLytxck5uQzY3S0lORUZP?=
 =?utf-8?B?bHZWZ1g3ZWg4cTJPa3ZZVk1rNDZPV0phSXVWenJWK2lrUmF2OUIrRng3SHNu?=
 =?utf-8?B?elVLUTFzU1FLL2M3cmJFbWdZZXBUZVpQVi95QnpMbE9qWXpHeEQrSU9ONUxw?=
 =?utf-8?B?bzRybmsxSEdtK2p5Sm15NEJqMXdOOU1yY0hkanBQNG04Mlp1QTdHKzJ4SU5S?=
 =?utf-8?B?NS9ITGI1OTVkbVNqYXN2KytPWjk4TzcwcUFBbFJOQmpuLzVnL1J1VkxVL05n?=
 =?utf-8?B?ZCt6ai9KZWQxbUs5MkhxQ1FtcDR0YmN1Tms5eWxaSEZNODRwTGdGVGR1QUJO?=
 =?utf-8?B?U0xOam11U3BEYmNwQkpzZDJxZklwYW9JM1UvUkcxTVk0QmZDU2pmVkFYcUVr?=
 =?utf-8?B?SDJyUnhnZHc4N1VNZVIzV0F1cS9ZVTBDNERRMHhyR1lFK0VMQ056UnRWaHJU?=
 =?utf-8?B?SlVyOEhPMkRXa3dmbDVjejBReHB2SmxEVHVsa2JkTXFILzBob1Y0RUZTYmJ6?=
 =?utf-8?B?Vk0ycS9nSlBISVA4NGZzdllUOWZpcUZua2QyQ2VjMDBmTmJ6ZkZ2SWlqZG5x?=
 =?utf-8?B?S0FCS2dLU1RBeWhNbXFVUFlSUmtMRER2Tjh2V3BjUitTZ0liRUhpcitFZmZW?=
 =?utf-8?B?WmpScUFPejkyWHV0WTJSSlMxY2NHN0tYZXlnRUdpbFVpSFY0dnlrRkJwdm15?=
 =?utf-8?B?MUxCc2hVMzc5Z2wyT1VGeHlxR3Zra1JFanFubU1NZEFOOHEvWXFscFRPek5X?=
 =?utf-8?B?cGpnUUhvT3J5cFhiY1hqU0IyTkJWWi85eHFiWVU1WFdVanB0U1JXZlFRcGUz?=
 =?utf-8?B?SDBWbUVXZnZwWHhTNFV0ZkdwNGpOT1Q2b0UvUXZ0MUtobVlhMk5ubEd1OXRB?=
 =?utf-8?B?dWpVMmNsUzNITTcvM29zZWMxeFpFSWJqNXBHNmdmVHRrbDFEckt4eVNTbnZR?=
 =?utf-8?B?TXFVcWxHOWNWeEI4MERVWEVFc3FUeGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af7bc59-f020-4e26-3c5a-08dc120506cf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 17:53:17.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6745

RnJvbTogTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gU2VudDogV2VkbmVz
ZGF5LCBKYW51YXJ5IDEwLCAyMDI0IDk6MDggQU0NCj4gDQo+ID4gSXQgb2NjdXJyZWQgdG8gbWUg
b3Zlcm5pZ2h0IHRoYXQgdGhlIGV4aXN0aW5nIGVycm9yIGhhbmRsaW5nDQo+ID4gaW4gY3JlYXRl
X2dwYWRsX2hlYWRlcigpIGlzIHVubmVjZXNzYXJpbHkgY29tcGxpY2F0ZWQuICBIZXJlJ3MNCj4g
PiBhbiBhcHByb2FjaCB0aGF0IEkgdGhpbmsgd291bGQgZml4IHdoYXQgeW91IGhhdmUgZmxhZ2dl
ZCwgYW5kDQo+ID4gd291bGQgcmVkdWNlIGNvbXBsZXhpdHkgaW5zdGVhZCBvZiBpbmNyZWFzaW5n
IGl0LiAgVGhvdWdodHM/DQo+IA0KPiBJIGZpbmQgdGhpcyBkZXZlbG9wbWVudCB2aWV3IGludGVy
ZXN0aW5nLg0KPiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvY2hhbm5lbC5jIGIv
ZHJpdmVycy9odi9jaGFubmVsLmMNCj4gPiBpbmRleCA1NmY3ZTA2YzY3M2UuLjQ0YjFkNWM4ZGZl
ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h2L2NoYW5uZWwuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaHYvY2hhbm5lbC5jDQo+ID4gQEAgLTMzNiw3ICszMzYsNyBAQCBzdGF0aWMgaW50IGNyZWF0
ZV9ncGFkbF9oZWFkZXIoZW51bSBodl9ncGFkbF90eXBlIHR5cGUsIHZvaWQgKmtidWZmZXIsDQo+
ID4gIAkJCSAgc2l6ZW9mKHN0cnVjdCBncGFfcmFuZ2UpICsgcGZuY291bnQgKiBzaXplb2YodTY0
KTsNCj4gPiAgCQltc2doZWFkZXIgPSAga3phbGxvYyhtc2dzaXplLCBHRlBfS0VSTkVMKTsNCj4g
PiAgCQlpZiAoIW1zZ2hlYWRlcikNCj4gPiAtCQkJZ290byBub21lbTsNCj4gPiArCQkJcmV0dXJu
IC1FTk9NRU07DQo+ID4NCj4gPiAgCQlJTklUX0xJU1RfSEVBRCgmbXNnaGVhZGVyLT5zdWJtc2ds
aXN0KTsNCj4gPiAgCQltc2doZWFkZXItPm1zZ3NpemUgPSBtc2dzaXplOw0KPiA+IEBAIC0zODYs
OCArMzg2LDggQEAgc3RhdGljIGludCBjcmVhdGVfZ3BhZGxfaGVhZGVyKGVudW0gaHZfZ3BhZGxf
dHlwZSB0eXBlLCB2b2lkICprYnVmZmVyLA0KPiA+ICAJCQkJCWxpc3RfZGVsKCZwb3MtPm1zZ2xp
c3RlbnRyeSk7DQo+ID4gIAkJCQkJa2ZyZWUocG9zKTsNCj4gPiAgCQkJCX0NCj4gPiAtDQo+ID4g
LQkJCQlnb3RvIG5vbWVtOw0KPiA+ICsJCQkJa2ZyZWUobXNnaGVhZGVyKTsNCj4gPiArCQkJCXJl
dHVybiAtRU5PTUVNOw0KPiA+ICAJCQl9DQo+ID4NCj4gPiAgCQkJbXNnYm9keS0+bXNnc2l6ZSA9
IG1zZ3NpemU7DQo+ID4gQEAgLTQxNiw4ICs0MTYsOCBAQCBzdGF0aWMgaW50IGNyZWF0ZV9ncGFk
bF9oZWFkZXIoZW51bSBodl9ncGFkbF90eXBlIHR5cGUsIHZvaWQgKmtidWZmZXIsDQo+ID4gIAkJ
CSAgc2l6ZW9mKHN0cnVjdCB2bWJ1c19jaGFubmVsX2dwYWRsX2hlYWRlcikgKw0KPiA+ICAJCQkg
IHNpemVvZihzdHJ1Y3QgZ3BhX3JhbmdlKSArIHBhZ2Vjb3VudCAqIHNpemVvZih1NjQpOw0KPiA+
ICAJCW1zZ2hlYWRlciA9IGt6YWxsb2MobXNnc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gLQkJaWYg
KG1zZ2hlYWRlciA9PSBOVUxMKQ0KPiA+IC0JCQlnb3RvIG5vbWVtOw0KPiA+ICsJCWlmICghbXNn
aGVhZGVyKQ0KPiA+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gPg0KPiA+ICAJCUlOSVRfTElTVF9I
RUFEKCZtc2doZWFkZXItPnN1Ym1zZ2xpc3QpOw0KPiA+ICAJCW1zZ2hlYWRlci0+bXNnc2l6ZSA9
IG1zZ3NpemU7DQo+ID4gQEAgLTQzNywxMCArNDM3LDYgQEAgc3RhdGljIGludCBjcmVhdGVfZ3Bh
ZGxfaGVhZGVyKGVudW0gaHZfZ3BhZGxfdHlwZSB0eXBlLCB2b2lkICprYnVmZmVyLA0KPiA+ICAJ
fQ0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAtbm9tZW06DQo+ID4gLQlrZnJlZShtc2doZWFk
ZXIpOw0KPiA+IC0Ja2ZyZWUobXNnYm9keSk7DQo+ID4gLQlyZXR1cm4gLUVOT01FTTsNCj4gPiAg
fQ0KPiA+DQo+ID4gIC8qDQo+ID4NCj4gDQo+IFNob3VsZCB1cCB0byB0d28gbWVtb3J5IGFyZWFz
IHN0aWxsIGJlIHJlbGVhc2VkIGFmdGVyIGEgZGF0YSBwcm9jZXNzaW5nDQo+IGZhaWx1cmU/DQoN
ClRoZSBmdW5jdGlvbiBjcmVhdGVfZ3BhZGxfaGVhZGVyKCkgaXMgcmVzcG9uc2libGUgb25seSBm
b3IgYWxsb2NhdGluZw0KdGhlIG1lbW9yeSBhbmQgZmlsbGluZyBpbiB2YXJpb3VzIGZpZWxkcy4g
IEl0IGRvZXNuJ3QgZG8gYW55IHByb2Nlc3Npbmcgb2YNCnRoZSBkYXRhIGFuZCBkb2Vzbid0IGdl
bmVyYXRlIGFueSBlcnJvcnMgb3RoZXIgdGhhbiBtZW1vcnkgYWxsb2NhdGlvbg0KZmFpbHVyZXMu
ICBJZiBjcmVhdGVfZ3BhZGxfaGVhZGVyKCkgc3VjY2VlZHMsIGl0IHJldHVybnMgYSBwb2ludGVy
IHRvIHRoZQ0KYWxsb2NhdGVkIG1lbW9yeSB2aWEgdGhlIG1zZ2luZm8gcGFyYW1ldGVyLCBhbmQg
dGhlIGNhbGxlciBiZWNvbWVzDQpyZXNwb25zaWJsZSBmb3IgZnJlZSdpbmcgdGhlIG1lbW9yeS4N
Cg0KVGhlIG9ubHkgY2FsbGVyIGlzIF9fdm1idXNfZXN0YWJsaXNoX2dwYWRsKCksIHdoaWNoICpk
b2VzKiBmcmVlIHRoZQ0KbWVtb3J5IGFmdGVyIGNvbW11bmljYXRpbmcgd2l0aCBIeXBlci1WLiAg
IFByb2Nlc3NpbmcgZXJyb3JzIG1heQ0Kb2NjdXIgd2hlbiBjb21tdW5pY2F0aW5nIHdpdGggSHlw
ZXItViwgYnV0IGluIGEgcXVpY2sgcmV2aWV3LA0KX192bWJ1c19lc3RhYmxpc2hfZ3BhZGwoKSBz
ZWVtcyB0byBoYW5kbGUgdGhvc2UgZXJyb3JzIGFuZCB0bw0KY29ycmVjdGx5IGZyZWUgdGhlIG1l
bW9yeS4NCg0KTWljaGFlbA0K

