Return-Path: <linux-hyperv+bounces-1755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB587BE20
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF951B21254
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5376EB56;
	Thu, 14 Mar 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i3irSvlK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2025.outbound.protection.outlook.com [40.92.23.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556BB5C8FF;
	Thu, 14 Mar 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424593; cv=fail; b=pRBFhmArf9UwOpmzfCqERLIepGHG0RtSMaG3ZHHCiVTf8CQqCRi0DTOODmoNTuwEsY/YA2ueawVlZ3u9seYHLtX1ELF3aPIfsTjAvXR/bCarHtme3tTorT1juuTphbNM03NpFyynhrgK3SJE2ne/k2D/zNEKdbsRCNIvMPNEMVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424593; c=relaxed/simple;
	bh=DTJcJRI+DFbsFW5THcpK/nhWJoyh8B9w4iDrCu8Nng0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYDRxp4hdDkqgngloeRp2VbkXIcSO0CuFxD6JdyVpMEoCxeASmuw0JySP350Y5IU5yLXcCY4904l1L6HbDkrBOifL46PKoO46kWM7z1yHgk7pD/Tv+XORwOr76NwBMvFQsWaM6rG7gtjnohEHor+hIzM0BBTYwOt4Efoa5KSKQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i3irSvlK; arc=fail smtp.client-ip=40.92.23.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkQVDXKECJvdayqB1QA123+5wQhZFzTzyduYYgi5Z4+mEAC8S6uGSbNdyICYiMMJnAoEagIkR1q0vIkbqZYiv4RUFWh1VSpbHIi52+Kzfy6j80RxOyG9VI1c2k+GtZShWb3HHOPrP8/dn4Gujyd5EwJx4e9+ys2QGlbO8XKdkmafGx3JYN2LEdhxWRaCY+O9PvK+aAxJy/RFiyTHNy/Aotkf1L5JHGyZU87rmxkqqAlzWHHnSfi3wbtVn3DNhLAgtTYfV/d6w67P7FmZJy3SNWlMLyO9V7qVOYo7VQjqnKawq9OqLBoA6pwCfxRiAwgqai3Z2Mw2LXWUcxF5SIuNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTJcJRI+DFbsFW5THcpK/nhWJoyh8B9w4iDrCu8Nng0=;
 b=HVu19YQ122/Re9CpDH9iHSwHgbFsA5Dc8t24Y9YDWjS34dwjcaOBicgijB0mtO47UzM4aEelAqYRQdZ6K7AHWjBEKPBl9jWnGpaX+c3xacYw+wPAj6JR6dIJ4hbFUFn9Pdf8wVhJppeSG3UoIzkVSfKHfBHODHj34vvB0E9Pne1pLHc9dymqKszBhNHjkyo208W8P9Jig4z8ZKBvR3SV+v/cItFJtHvNfieL71NDjxcoJk0bj4rEVhzgIfoqnZVi+T2+khNcDaee4o0R8kYf9xvCIrBOmsxRbhYGh5WkxrFetdnjrI1Gma47OB4I2W902LcrzD9ha/qHcxhcrktm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTJcJRI+DFbsFW5THcpK/nhWJoyh8B9w4iDrCu8Nng0=;
 b=i3irSvlK7cpdMi4a9a/MvihnHbfUIUaX1M197jG1fXWe+pPOOjou56drRPrlKtjbVr0gSIVwQWMFkI8QWj6sp4SkV3P65lHqxq0wmj7leaGMdGRaDcZvC4TbxgYdC+nWONenlIT9EZORdtneivIrNs2ktLEeulYSQIxlIuEQZdRgvv1mO8dFU5+7eMY2lDcPR2n4AxoOs6yhrtd/4BOUayURqzA0GhSKUIRcularQBayHRlfl3MTpU2uWhPmDlH86B2FnVA5IAOgkdt6eFlkYtNAVX9SdGOAaQgeXItzPuqtTLWtHS6+zt7u7RJLk8y9SR/EOonvqoynS9ua/gR2jA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8720.namprd02.prod.outlook.com (2603:10b6:a03:3d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 13:56:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 13:56:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
CC: "elena.reshetova@intel.com" <elena.reshetova@intel.com>
Subject: RE: [PATCH v2 2/5] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
Thread-Topic: [PATCH v2 2/5] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
Thread-Index: AQHac8+ebtKw/xenqkGKdXOMVR+SlLEzjW4AgAAMTZCAAKC7AIADCekQ
Date: Thu, 14 Mar 2024 13:56:27 +0000
Message-ID:
 <SN6PR02MB4157CC7305AEDE7520565A0DD4292@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240311161558.1310-1-mhklinux@outlook.com>
 <20240311161558.1310-3-mhklinux@outlook.com>
 <13581af9-e5f0-41ca-939f-33948b2133e7@linux.intel.com>
 <SN6PR02MB415742AEEE7F1389D80B6E51D42B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4e6627b2-30cd-4c50-bf2f-24cf845cd4bc@linux.intel.com>
In-Reply-To: <4e6627b2-30cd-4c50-bf2f-24cf845cd4bc@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [efyAPacvzj0NV++u89FFlxMFmlm1nq9c]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8720:EE_
x-ms-office365-filtering-correlation-id: 244dbe9c-6cdd-474f-54f6-08dc442e8b60
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tzBZGSgIU/bEwQ+/1mPkmgYFYXrSs0IzQGOThftoxUbDG18XbC4kriE9nB9CYzLBzxO2bEm4XAL7hgetbY7PWWrUQ48u9BZo+AU2xp2YUPPg7Hx5BdeVf8KA6I39OtdhXrCZfCftBjFbQ/W9L9uLFbipEGgT42aLXONxRytwisNW4mKV3Qr/tXdyW14PzbQIo9mhqQwLVBVFGxyAzlDZ5aULgM3FbwWTv4to2L9wqJWOTaXy5RlbLvEcZR7pLzjvp1/9qxEf50S0rVH+H2sL++hdbVAzWNn9zPGpawJoRQ/jy57grfBRvMtUC6/U2LPZyqJ2Gn563bgOL2nxbCsZduVSqsyttbSJ50Eel0yOVybl7FBK+2twB83lE1ONaD1kTeEHg6uqLOljjykXtfjcNWh9+aiSjoa0BZgO1JY01A0pcnTXmSE+I7JTstRzQaBxYXwT6qlL0R4qdXj5uMrvTGNTEm9oSCDvgF+//o2/FmvRjhUX1B0+AZRG0Lh29rfVrF9knh5D3I+C/FDxn/DtVgn4kTcH1aeTmKsm3AJRUPpfCCPdBz53RPIftFK7TtP+
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWRUVEpWd2hVNW5TVnlGQ2p2czFuby9QNC9SVlNwb0R3c3NTcm1QdlBpQUFH?=
 =?utf-8?B?bS9IZnBnd3lCL3NVMVlrR0V6VEl2dnZRaEN5cjRyVXFvR0w0NzlkOXlqY1A5?=
 =?utf-8?B?eUlpY010ZWpUNHU0ajBXMW96VnpHK2ovSTNVdzAwdXc0bkJrd2t6TXdaa3VN?=
 =?utf-8?B?N2s4RTA5QWFlcU9YNEhuRDlUTFl2M1l6VkRBVDNkK0lsZ3VlM2w1NEdEMHdl?=
 =?utf-8?B?TTg1WDMyVjgybHZhUXFwRVA2aGErOFlSY2VNU3VXazJRR0hhdTQvemxtc0Jj?=
 =?utf-8?B?ak1XdzZKbkxzaDY5U3BLcDlqTlk4V0V5c3pJeEwrMjFUK0dOUWNyZGQ3dWlU?=
 =?utf-8?B?cm1acWRva0U4aGpvYmRBR0wrZENYRmtyUG1KaHcvRityQXZab0s2SUNQRjYw?=
 =?utf-8?B?S3ROQ1AyVDY5akdleXVBc0prQ1lOWmRSMThkZXkzS0piSDRoSHNqU1czUnlG?=
 =?utf-8?B?Y1hNNm9yS0RUUXRVUjU0dFQ2Qmd4M2htTXdQWmsxQW1xTEp0cTNIZWFrQ3px?=
 =?utf-8?B?b2dDVHJrUS8wYWFZalVnUm4rMkE4NzNvQzZuWHVTQmdlbzZSdjY2djRSRmxN?=
 =?utf-8?B?MzI3U3p5cTY0S2JOcWRsWmlMdFE5czhzdDZaSFZqQjJCSm5XNldSM3R0MFIy?=
 =?utf-8?B?eXNHNG1vaXFhVHc0aHZuMEJ1RW95NUsvSjR5ZWExNkZRcWd4YW9xekw0Yno1?=
 =?utf-8?B?OTBzR010MDRrTytRZm11aTNNS1BUUGFUdTZvUlc5T2MyQkVjOGhHdmowTFZO?=
 =?utf-8?B?QnVzV1ZlOEJrYjhBQzZjb05YeGtsc01MV0Flb1daYjVocC9jbkx3NThlaVhL?=
 =?utf-8?B?UC9oZGV5dm5vQXdyZ0tYbjJXZllVa0luUEdjbWdidHNrWm5RR0Y2N3lSTDIz?=
 =?utf-8?B?cm9BUDV0aVRicE8rS2htMWtqWW4wWnZDZUdDemgyZUFBRGhFeEtST3lVNTZ0?=
 =?utf-8?B?QjE3c1QrajYrRldRTFFxQVNrUWNJbWVhT2plbW5TUTFBWU9hVEk3SkcrSndN?=
 =?utf-8?B?cGxnRTN1MjVQbG83aktRSklSYnU0Q1c2MkJuczB5a2JsblluUUd6TUNMMzhp?=
 =?utf-8?B?RG1BMFQxMzVXSFE1dThtRVN3ZVVNbktidkUwSzFrRUsrWHJRdEJ2ektJaGpM?=
 =?utf-8?B?VGEyZjBKTkdhdFBFSDRQMmptcFUrOC8yWkVUTk1zdzZYL3QxMXFpUUJpenpw?=
 =?utf-8?B?MlhocnVtbGU3RU1VUWlFcnNLTFV2TlUrQytBUW9GajA5a0RUMlVzYXRPZ05D?=
 =?utf-8?B?eWlqMUtGcGpmWldJdS9oN2lTRXN2ZFVZYmV3dG5OdDFsem0zR2FaU0NiQUVJ?=
 =?utf-8?B?dXh6Q1lwUC9TU3dDYmlobW9ya1lmTmp1WW0wU005K09mcTFGRTJqZ2tLTHZU?=
 =?utf-8?B?VTg2K0s3WW9JdHF0b2JIUXo1NTlXMnNYK3hDVjBuRXJZTUREWkJRcEhyclQy?=
 =?utf-8?B?ellNRnNRdmQwUnBtcVlJbk8wRkJlYml3eXg1cXVlNm4zbWkyZnZpbmpNcWZD?=
 =?utf-8?B?Y092d25IRU40bmZyYm0vUnViWXpTNTNXS2l0UnRuL0xSRWphTGdUSzRlVUs0?=
 =?utf-8?B?b1FGbzZHeTBPWGR4aWNML3JnTnowaktpUnpLT1F3V0cvZkVHMGhUaFhBYW12?=
 =?utf-8?B?QXJ3Mk5qQ1lHR0NGMldQZzltODZpeEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 244dbe9c-6cdd-474f-54f6-08dc442e8b60
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 13:56:27.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8720

RnJvbTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3
YW15QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+ID4+PiBAQCAtODg2LDYgKzkwMSw4IEBAIGludCB2
bWJ1c190ZWFyZG93bl9ncGFkbChzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCwgc3RydWN0
IHZtYnVzX2dwYWRsICpncGFkDQo+ID4+PiAgCWlmIChyZXQpDQo+ID4+PiAgCQlwcl93YXJuKCJG
YWlsIHRvIHNldCBtZW0gaG9zdCB2aXNpYmlsaXR5IGluIEdQQURMIHRlYXJkb3duICVkLlxuIiwg
cmV0KTsNCj4gPj4NCj4gPj4gV2lsbCB0aGlzIGJlIGNhbGxlZCBvbmx5IGlmIHZtYnVzX2VzdGFi
bGlzaF9ncGFkKCkgaXMgc3VjY2Vzc2Z1bD8gSWYgbm90LCB5b3UNCj4gPj4gbWlnaHQgd2FudCB0
byBza2lwIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgY2FsbCBmb3IgZGVjcnlwdGVkID0gZmFsc2Ug
Y2FzZS4NCj4gPg0KPiA+IEl0J3Mgb25seSBjYWxsZWQgaWYgdm1idXNfZXN0YWJsaXNoX2dwYWRs
KCkgaXMgc3VjY2Vzc2Z1bC4gIEkgYWdyZWUNCj4gPiB3ZSBkb24ndCB3YW50IHRvIGNhbGwgc2V0
X21lbW9yeV9lbmNyeXB0ZWQoKSBpZiB0aGUNCj4gPiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHdh
c24ndCBleGVjdXRlZCBvciBpdCBmYWlsZWQuICBCdXQNCj4gPiB2bWJ1c190ZWFyZG93bl9ncGFk
bCgpIGlzIG5ldmVyIGNhbGxlZCB3aXRoIGRlY3J5cHRlZCA9IGZhbHNlLg0KPiANCj4gU2luY2Ug
eW91IHJlbHkgb27CoCB2bWJ1c190ZWFyZG93bl9ncGFkbCgpIGNhbGxlcnMsIHBlcnNvbmFsbHkg
SSB0aGluayBpdA0KPiBpcyBiZXR0ZXIgdG8gYWRkIHRoYXQgY2hlY2suIEl0IGlzIHVwIHRvIHlv
dS4NCj4gDQoNCkluIG15IGp1ZGdtZW50LCBhIGNoZWNrIGlzbid0IHJlYWxseSBuZWNlc3Nhcnku
ICBUaGUgc3RydWN0dXJlIG9mIHRoZSBHUEFETA0KY29kZSBoYXMgYmVlbiBzdGFibGUgZm9yIGEg
bG9uZyB0aW1lLCBhbmQgSSdtIG5vdCBhd2FyZSBvZiBhbnl0aGluZw0KcGVuZGluZyB0aGF0IHdv
dWxkIG1vdGl2YXRlIGEgY2hhbmdlLiAgQW5kIGlmIHNvbWV0aGluZyBkaWQgY2hhbmdlDQp0byBj
YWxsIHZtYnVzX3RlYXJkb3duX2dwYWRsKCkgd2l0aCB0aGUgbWVtb3J5IHN0aWxsIGVuY3J5cHRl
ZCwNCnRoZSBjYWxsIHRvIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgd2lsbCBjYXVzZSBhbiBpbW1l
ZGlhdGUgZXJyb3IgYW5kDQphIFdBUk5fT05DRSBmcm9tIFJpY2sncyBwYXRjaCB0byBfX3NldF9t
ZW1vcnlfZW5jX3BndGFibGUoKS4NClRoZSBwcm9ibGVtIHdvbid0IGdvIHVubm90aWNlZC4NCg0K
TWljaGFlbA0KDQoNCg0K

