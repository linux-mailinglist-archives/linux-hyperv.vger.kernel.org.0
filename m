Return-Path: <linux-hyperv+bounces-2873-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ABE95FDF8
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 02:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380A2283361
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507A2107;
	Tue, 27 Aug 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HHqijN2o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012052.outbound.protection.outlook.com [52.103.2.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D61FB4;
	Tue, 27 Aug 2024 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724718401; cv=fail; b=WVBGaXzqX5UXKVFcLPCehCuDGqLHKockw2LrS4aADZQkTq5i7HIgCZcvfll2jcXKegiIR3DcqYaT0KlBFqYC+BLBNwk8LoaWQIeHlUPLP3679Z0gjvMz5R7RY0Btx3K2T2+o2yInAwymCrzAFPSb2JPuJY1lRRXLanWN1SIrBmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724718401; c=relaxed/simple;
	bh=ub7Byc1VzFS8HQ607NlgVIyHahM+6X9eZycsgcMRquo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ORUteR7KQwCjtGSCpiJOr9ZT3CteVixdk3vja4YbC4Dz96VCzm8EyQ+ObNgJVjd6mKpI6VXMw2oz3tozCMxNaLNJuto3939ELLre2aa/CSq5/SgT7m416Vh8tSOpyCn3qmnD773qswG0hxLVl+2Hhblj1iO4x1p54DHkGfhkEzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HHqijN2o; arc=fail smtp.client-ip=52.103.2.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEnpLlKMLj8A5WffzOwOdcjU9//P9x6knUx8tK0wFGifk5H1DheQ2+6Yr3BjYgYXmCz6SK1UW3onijptUkGmJ/nPpJQsAirEPOtypfDZ3fFeKb0C45z+d9Fl6qt1cUteGovZPu2IdAVJZCb5gsprWGp0OH3VUuhw5zsrXDNOT/5Wp0XdGVICX66j0BxH260BON1paARiJDlkeOk8gDB/ZgZr4nGH2u+S3cU1nzNDcfcpQWPf2jdsClCcqaOaGFkELLcTsuV2dpzH45yk6l4LOVqin6+hl1euaIEVA2QD5OsG4IGtygBfIrQMlabx0DhIHrrvHriybX8q+GcdcQTQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub7Byc1VzFS8HQ607NlgVIyHahM+6X9eZycsgcMRquo=;
 b=H8br4tHpNaEycVhdHKz3RskMDzLuevpe5CStps81aOp+EVT5kaG5uDmNXkr8V9c151SCgf9LQSr9OccW6wN8Sc81S6dxdfdsrfsdSp1EsY/D2bwUaJdH85LeIXiRWvVToQmdJI5g+0+p21PX0ltR/7vatY+wIh5BJCQ1k2jPaWBX9Y0+kdFYixwfT52dEYFcb3IbowCGdf6VKUEsHTgmHWNLrVxm8pgyCzyRYP3H6h+M8MBLP1loMZpkzZ6eVrXooAzv1G7UUSMJdzSVy+BogRerq2aPQgRxbHE2YMg/5SRC/TN+9ThdXocDZvksB/AvWMJN2YN2gfZxcJCQl8mvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub7Byc1VzFS8HQ607NlgVIyHahM+6X9eZycsgcMRquo=;
 b=HHqijN2oJPCTnLcHKxpPyhjiXW1A3F+6FH/fQAGC1OSycfYhcWd7RqXIc13Hhz04W3P7qw0mBKGbXCddRXW7qy35tY4Ju/gAvM2ZJ/T4wLfhZW2F1rqWdv7QxPIQG+yTibrORDUqqSjlHIL/PCuiHg7ShrFnUqrwZvm3yoJ+djzame4c9SXqGE1bcDt0Xpr76JU4o6KjguGhfvBvwKJARebCxP0TIPLXpu/NPMpethW9ORNbC7C+iSrMDRWdzyw1rUIyaRS/qIM8PdDgy0sqBZ5RzpOMc/LofvPqKMZBXJT92IYJ9w3l3ugqJyh6P38SvMMlPHL/u2tp1+hhp10MiA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10545.namprd02.prod.outlook.com (2603:10b6:303:286::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 00:26:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Tue, 27 Aug 2024
 00:26:36 +0000
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
Thread-Index:
 AQHa9MJuV8zHlUlbFEOu4P5Y/AqjALI0ZmsAgADTyNCAAZ5XAIAC5aKggAA0coCAAFAMMA==
Date: Tue, 27 Aug 2024 00:26:36 +0000
Message-ID:
 <SN6PR02MB41571FA9E40ECA5954001A57D4942@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240823084458.4394b401@meshulam.tesarici.cz>
	<SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240824220556.0e2587d5@meshulam.tesarici.cz>
	<SN6PR02MB41577933B499309EA3CE4DDBD48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240826212803.3e11d2f9@meshulam.tesarici.cz>
In-Reply-To: <20240826212803.3e11d2f9@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [oAYZMij+3xwzM/nt7tM8DiSkkA9SLuSu]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10545:EE_
x-ms-office365-filtering-correlation-id: d1a9d2cb-90fb-41c0-bf24-08dcc62ee975
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|15080799006|19110799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 /TzZf04Lw5WjAwFUOJnFeUvLMwbC3PjZ3gyRs56NYUadhEg+wK/RYYBCeKuZL4M+uEw61OqgApbBMaQCQun5OccCKcTKcCD/lELpRMIskvZ7dWa6Ox4NWuEcDeZ4mTq1U1TsWNTqNUyI0LxAbEGlCys+pTMQ2+kXqbgOF9g91UWSy/ijoWe5BG2bm+md9havyCvaOasJacehyryV4BY6glA+iGtqFtNBqzwWa+QpcXnlMGtVof5gAmf3whFjdGvwkqdBdsHqnj1UcXlokTDz4D5XlaYjWu7sPSXY0Knpv4Xg9DYGqXmscHo57rbOaVFBOf6+6Ky+k5RSO7FfdtI6a+5xgsB/4MoYbEHfOV+3oLL26fobPSzNcRuySai/OTASBUhWZt8E4jQqig/55FHbHO0/FBqsA8Mpt1WRs3sL3E+yYvQACI28t5bUJRGUMmZnNIVxXelMrjZytt3a9Q5cB1tvRnfhdBp1btlasGXNUlVDo8jWRKhD5FdAEkpnKO4uEaBmZqCXt1CGNPAgVAm9Abjp3byuDkIqCrxIio+/TCO9eFfA7bDtr/WTQEBxMTcuw20NEkgAeHzaAohBOvkIzE6t3xWTk330CcB4x+g89eChOVfn38OqAdvFEYrB5oa7wbqOgJnjERR4E4DiwkmveNrmfcRobb1TsoGqKZ+SxvFnYku57SL7N0jWBRstLQUV
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTVlbVluY0c2SEhVbGhUd1orZDVkUmdxaUc3ZW5tVVJHSENRM0hnbTVmMEJa?=
 =?utf-8?B?bnI3SzVYMWhUajFKVlhoaTFpZXJSdFRzcnZTbENnelFJZGsrbTNBMkxqc1VX?=
 =?utf-8?B?RGRuNDR5ckRjQUNqT1UwVy95dld5LzB2WGVZa3lZQ0R6UlVna2FjUHcyZmYy?=
 =?utf-8?B?WVRKODJuRjFzSFdpSjB0L2t3eHh5b1pIWm95RkY3RjUzSHZEcTgyL0szT1RN?=
 =?utf-8?B?UFB6S09IYnk4dmNRWjZ6Y0lXcGtSeDF2bGNLaGVRM1Y4b1lDWVlPQnF6bGUx?=
 =?utf-8?B?SVNuQWtEeFR6Q05MbEJoWnVaNkllQ01jMGpENWs5K2FqQzJBV1phMEV5V0xI?=
 =?utf-8?B?cEZUeHI2TTYxMjk1WkN3S29Scy9WOFhRV0d3WDl6QVltRmRtdjZRbmdsUUxZ?=
 =?utf-8?B?c2dBUjE0ZXRXS0dTSDhtSUpXazY5ZnZJZFU4NHFpcE14aWxjc1BYVWJpSUxL?=
 =?utf-8?B?eXNHeXQ5U0JnT0JVcS9sZEIxL0RyMG9xQ0YrTjgrTzU4eldPdEdqaHRMY2s4?=
 =?utf-8?B?cXhtUDJBUkxmN00wMExOTE4xaVhkWlZtWVdYbVZWOVpjUEtWdjhsYjFUTys3?=
 =?utf-8?B?Q2dJM2U1emYrZUlwck9ndlpyNXNnU0VNMDhTN21NaGpwVUVybml4N21HOVdn?=
 =?utf-8?B?UEw5dm9xS0ZrQnR2S2tWcm4rVityTExyaG5WWG1vTUQ3QWdXMFprUWlSNVBW?=
 =?utf-8?B?TjJOSDdkWWhHemdBcEtUL0oxMlZPa0FIQk9DTm1rMVREalZTekR4Vk50S2h1?=
 =?utf-8?B?VTJPWGNsMUNEZWo2Q1g0RCttSkpmWERwTHp1TDZvdTN4SVVXb0NiZlc2L2Nn?=
 =?utf-8?B?ekc5T0JzdVZFalZ3V2E4RkZ1Y2lGWDVxQytaWEtsR1BJTHpkblFPUFdBcHlN?=
 =?utf-8?B?dzl5cFA3MVE4Z2FFL3AxYTM5ZTU2amVxTlQ3bmFqM21icVBqTlY2NjBwREd0?=
 =?utf-8?B?NFdJTEl3eDhxdlBZdzIvMzZETnZpcFZ1UmRLSGFPWFExY3lTRVpIeGtNRlF1?=
 =?utf-8?B?K216YTc2dFhDd25aUmsxcHVKRU5CclhmeFJCaGdiZHpCQTkyenBZYUpYZXpP?=
 =?utf-8?B?TVozMWlKL1J3THF0UW5QZjVvdk9NbkZBUjkwNStubUIveTQrc2lqSVd6d3VQ?=
 =?utf-8?B?RjIvMzYwWDFkYUFiU2lzUkRrYjVib3RMU1k3cDFHMUJzdHNZS3dBWkhqaGZH?=
 =?utf-8?B?ajJNZE0rc1RRdDZMS1BEengreXEvdkVmS3NMczBkVG0vY1dwVVNHM09nTnRK?=
 =?utf-8?B?VkFmam1UTEdJZGszeVN3VmE4ODlTNElSSDdPaGtrT1RtNlhSZXlOYnNUUzB5?=
 =?utf-8?B?L1J6Ti9PaFFxRUNwZSt2Umt5YzFoYzJjUGx5d29BOE1wZzRBU1hvOCtCNFhq?=
 =?utf-8?B?aDdsUTJpTUNTOWNpcHpmbVhKK1VYcXVhQjBFUnJvUGJnbjhERW5XVDMrcU1k?=
 =?utf-8?B?T0pmOVlTNndKbmdkQmNaTVZ0WlJxTWpnNXBCTkxTLzR3c3dFZFh6aFBJMHZK?=
 =?utf-8?B?aDNxVzlzcUdDZWJJOU5odEpxbEhSNGtZUUUwZmxSb20rUDNpNUdreTFtM1Iw?=
 =?utf-8?B?L212S2tKc1VqT0hpT0RFV0JIaG9RQkxXQ0VHWlMzTU9OemlYVElONHp5WE1D?=
 =?utf-8?Q?FN0eGEV1n/YfUOLm/tuOLDzOg368yX3wtoABPrTURtAQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9d2cb-90fb-41c0-bf24-08dcc62ee975
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 00:26:36.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10545

RnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+IFNlbnQ6IE1vbmRheSwgQXVn
dXN0IDI2LCAyMDI0IDEyOjI4IFBNDQo+IA0KPiBPbiBNb24sIDI2IEF1ZyAyMDI0IDE2OjI0OjUz
ICswMDAwDQo+IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4gd3JvdGU6DQo+
IA0KPiA+IEZyb206IFBldHIgVGVzYcWZw61rIDxwZXRyQHRlc2FyaWNpLmN6PiBTZW50OiBTYXR1
cmRheSwgQXVndXN0IDI0LCAyMDI0IDE6MDYgUE0NCj4gPiA+DQo+ID4gPiBPbiBGcmksIDIzIEF1
ZyAyMDI0IDIwOjQwOjE2ICswMDAwDQo+ID4gPiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0
bG9vay5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRnJvbTogUGV0ciBUZXNhxZnDrWsgPHBl
dHJAdGVzYXJpY2kuY3o+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjIsIDIwMjQgMTE6NDUgUE0N
Cj4gPiA+ID5bLi4uXQ0KPiA+ID4gPiA+ID4gRGlzY3Vzc2lvbg0KPiA+ID4gPiA+ID4gPT09PT09
PT09PQ0KPiA+ID4gPiA+ID4gKiBTaW5jZSBzd2lvdGxiIGlzbid0IHZpc2libGUgdG8gZGV2aWNl
IGRyaXZlcnMsIEkndmUgc3BlY2lmaWNhbGx5DQo+ID4gPiA+ID4gPiBuYW1lZCB0aGUgRE1BIGF0
dHJpYnV0ZSBhcyBNQVlfQkxPQ0sgaW5zdGVhZCBvZiBNQVlfVEhST1RUTEUgb3INCj4gPiA+ID4g
PiA+IHNvbWV0aGluZyBzd2lvdGxiIHNwZWNpZmljLiBXaGlsZSB0aGlzIHBhdGNoIHNldCBjb25z
dW1lcyBNQVlfQkxPQ0sNCj4gPiA+ID4gPiA+IG9ubHkgb24gdGhlIERNQSBkaXJlY3QgcGF0aCB0
byBkbyB0aHJvdHRsaW5nIGluIHRoZSBzd2lvdGxiIGNvZGUsDQo+ID4gPiA+ID4gPiB0aGVyZSBt
aWdodCBiZSBvdGhlciB1c2VzIGluIHRoZSBmdXR1cmUgb3V0c2lkZSBvZiBDb0NvIFZNcywgb3IN
Cj4gPiA+ID4gPiA+IHBlcmhhcHMgb24gdGhlIElPTU1VIHBhdGguDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJIG9uY2UgaW50cm9kdWNlZCBhIHNpbWlsYXIgZmxhZyBhbmQgY2FsbGVkIGl0IE1BWV9T
TEVFUC4gSSBjaG9zZQ0KPiA+ID4gPiA+IE1BWV9TTEVFUCwgYmVjYXVzZSB0aGVyZSBpcyBhbHJl
YWR5IGEgbWlnaHRfc2xlZXAoKSBhbm5vdGF0aW9uLCBidXQgSQ0KPiA+ID4gPiA+IGRvbid0IGhh
dmUgYSBzdHJvbmcgb3BpbmlvbiB1bmxlc3MgeW91ciBzZW1hbnRpY3MgaXMgc3VwcG9zZWQgdG8g
YmUNCj4gPiA+ID4gPiBkaWZmZXJlbnQgZnJvbSBtaWdodF9zbGVlcCgpLiBJZiBpdCBpcywgdGhl
biBJIHN0cm9uZ2x5IHByZWZlcg0KPiA+ID4gPiA+IE1BWV9CTE9DSyB0byBwcmV2ZW50IGNvbmZ1
c2luZyB0aGUgdHdvLg0KPiA+ID4gPg0KPiA+ID4gPiBNeSBpbnRlbnQgaXMgdGhhdCB0aGUgc2Vt
YW50aWNzIGFyZSB0aGUgc2FtZSBhcyBtaWdodF9zbGVlcCgpLiBJDQo+ID4gPiA+IHZhY2lsbGF0
ZWQgYmV0d2VlbiBNQVlfU0xFRVAgYW5kIE1BWV9CTE9DSy4gVGhlIGtlcm5lbCBzZWVtcw0KPiA+
ID4gPiB0byB0cmVhdCAic2xlZXAiIGFuZCAiYmxvY2siIGFzIGVxdWl2YWxlbnQsIGJlY2F1c2Ug
YmxrLW1xIGhhcw0KPiA+ID4gPiB0aGUgQkxLX01RX0ZfQkxPQ0tJTkcgZmxhZywgYW5kIFNDU0kg
aGFzIHRoZQ0KPiA+ID4gPiBxdWV1ZWNvbW1hbmRfbWF5X2Jsb2NrIGZsYWcgdGhhdCBpcyB0cmFu
c2xhdGVkIHRvDQo+ID4gPiA+IEJMS19NUV9GX0JMT0NLSU5HLiBTbyBJIHNldHRsZWQgb24gTUFZ
X0JMT0NLLCBidXQgYXMgeW91DQo+ID4gPiA+IHBvaW50IG91dCwgdGhhdCdzIGluY29uc2lzdGVu
dCB3aXRoIG1pZ2h0X3NsZWVwKCkuIEVpdGhlciB3YXkgd2lsbA0KPiA+ID4gPiBiZSBpbmNvbnNp
c3RlbnQgc29tZXdoZXJlLCBhbmQgSSBkb24ndCBoYXZlIGEgcHJlZmVyZW5jZS4NCj4gPiA+DQo+
ID4gPiBGYWlyIGVub3VnaC4gTGV0J3Mgc3RheSB3aXRoIE1BWV9CTE9DSyB0aGVuLCBzbyB5b3Ug
ZG9uJ3QgaGF2ZSB0bw0KPiA+ID4gY2hhbmdlIGl0IGV2ZXJ5d2hlcmUuDQo+ID4gPg0KPiA+ID4g
PlsuLi5dDQo+ID4gPiA+ID4gPiBPcGVuIFRvcGljcw0KPiA+ID4gPiA+ID4gPT09PT09PT09PT0N
Cj4gPiA+ID4gPiA+IDEuIHN3aW90bGIgYWxsb2NhdGlvbnMgZnJvbSBYZW4gYW5kIHRoZSBJT01N
VSBjb2RlIGRvbid0IG1ha2UgdXNlDQo+ID4gPiA+ID4gPiBvZiB0aHJvdHRsaW5nLiBUaGlzIGNv
dWxkIGJlIGFkZGVkIGlmIGJlbmVmaWNpYWwuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gMi4g
VGhlIHRocm90dGxpbmcgdmFsdWVzIGFyZSBjdXJyZW50bHkgZXhwb3NlZCBhbmQgYWRqdXN0YWJs
ZSBpbg0KPiA+ID4gPiA+ID4gL3N5cy9rZXJuZWwvZGVidWcvc3dpb3RsYi4gU2hvdWxkIGFueSBv
ZiB0aGlzIGJlIG1vdmVkIHNvIGl0IGlzDQo+ID4gPiA+ID4gPiB2aXNpYmxlIGV2ZW4gd2l0aG91
dCBDT05GSUdfREVCVUdfRlM/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZZXMuIEl0IHNob3VsZCBi
ZSBwb3NzaWJsZSB0byBjb250cm9sIHRoZSB0aHJlc2hvbGRzIHRocm91Z2gNCj4gPiA+ID4gPiBz
eXNjdGwuDQo+ID4gPiA+DQo+ID4gPiA+IEdvb2QgcG9pbnQuICBJIHdhcyB0aGlua2luZyBhYm91
dCBjcmVhdGluZyAvc3lzL2tlcm5lbC9zd2lvdGxiLCBidXQNCj4gPiA+ID4gc3lzY3RsIGlzIGJl
dHRlci4NCj4gPiA+DQo+ID4gPiBUaGF0IHN0aWxsIGxlYXZlcyB0aGUgcXVlc3Rpb24gd2hlcmUg
aXQgc2hvdWxkIGdvLg0KPiA+ID4NCj4gPiA+IFVuZGVyIC9wcm9jL3N5cy9rZXJuZWw/IE9yIHNo
b3VsZCB3ZSBtYWtlIGEgL3Byb2Mvc3lzL2tlcm5lbC9kbWENCj4gPiA+IHN1YmRpcmVjdG9yeSB0
byBtYWtlIHJvb20gZm9yIG1vcmUgZG1hLXJlbGF0ZWQgY29udHJvbHM/DQo+ID4NCj4gPiBJIHdv
dWxkIGJlIGdvb2Qgd2l0aCAvcHJvYy9zeXMva2VybmVsL3N3aW90bGIgKG9yICJkbWEiKS4gVGhl
cmUNCj4gPiBhcmUgb25seSB0d28gZW50cmllcyAoaGlnaF90aHJvdHRsZSBhbmQgbG93X3Rocm90
dGxlKSwgYnV0IGp1c3QNCj4gPiBkdW1waW5nIGV2ZXJ5dGhpbmcgZGlyZWN0bHkgaW4gL3Byb2Mv
c3lzL2tlcm5lbCBkb2Vzbid0IHNlZW0gbGlrZQ0KPiA+IGEgZ29vZCBsb25nLXRlcm0gYXBwcm9h
Y2guICBFdmVuIHRob3VnaCB0aGVyZSBhcmUgY3VycmVudGx5IGEgbG90DQo+ID4gb2YgZGlyZWN0
IGVudHJpZXMgaW4gL3Byb2Mvc3lzL2tlcm5lbCwgdGhhdCBtYXkgYmUgaGlzdG9yaWNhbCwgYW5k
IG5vdA0KPiA+IGNoYW5nZWFibGUgZHVlIHRvIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHJlcXVp
cmVtZW50cy4NCj4gDQo+IEkgdGhpbmsgU1dJT1RMQiBpcyBhIGJpdCB0b28gbmFycm93LiBIb3cg
bWFueSBjb250cm9scyB3b3VsZCB3ZSBhZGQNCj4gdW5kZXIgL3Byb2Mvc3lzL2tlcm5lbC9zd2lv
dGxiPyBUaGUgY2hhbmNlcyBzZWVtIGhpZ2hlciBpZiB3ZSBjYWxsIGl0DQo+IC9wcm9jL3N5cy9r
ZXJuZWwvZG1hL3N3aW90bGJfe2xvdyxoaWdofV90aHJvdHRsZSwgYW5kIGl0IGZvbGxvd3MgdGhl
DQo+IHBhdGhzIGluIHNvdXJjZSBjb2RlICh3aGljaCBhcmUgc3ViamVjdCB0byBjaGFuZ2UgYW55
IHRpbWUsIGhvd2V2ZXIpLg0KPiBBbnl3YXksIEkgZG9uJ3Qgd2FudCB0byBnZXQgaW50byBiaWtl
c2hlZGRpbmc7IEknbSBmaW5lIHdpdGggd2hhdGV2ZXINCj4geW91IHNlbmQgaW4gdGhlIGVuZC4g
Oi0pDQo+IA0KPiBCVFcgdGhvc2UgZW50cmllcyBkaXJlY3RseSB1bmRlciAvcHJvYy9zeXMva2Vy
bmVsIGFyZSBub3QgYWxsDQo+IGhpc3RvcmljYWwuIFRoZSBpb191cmluZ18qIGNvbnRyb2xzIHdl
cmUgYWRkZWQganVzdCBsYXN0IHllYXIsIHNlZQ0KPiBjb21taXQgNzZkM2NjZWNmYTE4Lg0KPiAN
Cg0KTm90ZSB0aGF0IHRoZXJlIGNvdWxkIGJlIG11bHRpcGxlIGluc3RhbmNlcyBvZiB0aGUgdGhy
b3R0bGUgdmFsdWVzLCBzaW5jZQ0KYSBETUEgcmVzdHJpY3RlZCBwb29sIGhhcyBpdHMgb3duIHN0
cnVjdCBpb190bGJfbWVtIHRoYXQgaXMgc2VwYXJhdGUNCmZyb20gdGhlIGRlZmF1bHQuIEkgd3Jv
dGUgdGhlIGNvZGUgc28gdGhhdCB0aHJvdHRsaW5nIGlzIGluZGVwZW5kZW50bHkNCmFwcGxpZWQg
dG8gYSByZXN0cmljdGVkIHBvb2wgYXMgd2VsbCwgdGhvdWdoIEkgaGF2ZW4ndCB0ZXN0ZWQgaXQu
DQoNClNvIHRoZSB0eXBpY2FsIGNhc2UgaXMgdGhhdCB3ZSdsbCBoYXZlIGhpZ2ggYW5kIGxvdyB0
aHJvdHRsZSB2YWx1ZXMgZm9yIHRoZQ0KZGVmYXVsdCBzd2lvdGxiIHBvb2wsIGJ1dCB3ZSBjb3Vs
ZCBhbHNvIGhhdmUgaGlnaCBhbmQgbG93IHRocm90dGxlDQp2YWx1ZXMgZm9yIGFueSByZXN0cmlj
dGVkIHBvb2xzLg0KDQpNYXliZSB0aGUgL3Byb2MgcGF0aG5hbWVzIHdvdWxkIG5lZWQgdG8gYmU6
DQoNCiAgIC9wcm9jL3N5cy9rZXJuZWwvZG1hL3N3aW90bGJfZGVmYXVsdC9oaWdoX3Rocm90dGxl
DQogICAvcHJvYy9zeXMva2VybmVsL2RtYS9zd2lvdGxiX2RlZmF1bHQvbG93X3Rocm90dGxlDQog
ICAvcHJvYy9zeXMva2VybmVsL2RtYS9zd2lvdGxiXzxycG9vbG5hbWU+L2hpZ2hfdGhyb3R0bGUN
CiAgIC9wcm9jL3N5cy9rZXJuZWwvZG1hL3N3aW90bGJfPHJwb29sbmFtZT4vbG93X3Rocm90dGxl
DQoNCk9yIHdlIGNvdWxkIHRocm93IGFsbCB0aGUgdGhyb3R0bGVzIGRpcmVjdGx5IGludG8gdGhl
ICJkbWEiIGRpcmVjdG9yeSwNCnRob3VnaCB0aGF0IG1ha2VzIGZvciBmYWlybHkgbG9uZyBuYW1l
cyBpbiBsaWV1IG9mIGEgZGVlcGVyIGRpcmVjdG9yeQ0Kc3RydWN0dXJlOg0KDQogICAvcHJvYy9z
eXMva2VybmVsL2RtYS9kZWZhdWx0X3N3aW90bGJfaGlnaF90aHJvdHRsZQ0KICAgL3Byb2Mvc3lz
L2tlcm5lbC9kbWEvZGVmYXVsdF9zd2lvdGxiX2xvd190aHJvdHRsZQ0KICAgL3Byb2Mvc3lzL2tl
cm5lbC9kbWEvPHJwb29sbmFtZT5fc3dpb3RsYl9oaWdoX3Rocm90dGxlDQogICAvcHJvYy9zeXMv
a2VybmVsL2RtYS88cnBvb2xuYW1lXz5zd2lvdGxiX2xvd190aHJvdHRsZQ0KDQpUaG91Z2h0cz8N
Cg0KTWljaGFlbA0K

