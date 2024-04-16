Return-Path: <linux-hyperv+bounces-1977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613D08A7885
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 01:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF091F2209D
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 23:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BC113A404;
	Tue, 16 Apr 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="exNPBgR2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2038.outbound.protection.outlook.com [40.92.20.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B12375B;
	Tue, 16 Apr 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309639; cv=fail; b=i5aXJyCchYgByq8HfCXaEEoXX4147MCeShYirUNezLWx9XBEc7bbfMrVMHw2ZWR1aeuM+WUVrdYwYo+crY23S2OK+LyIPewugzYanHnwUsJyWzgNhE8YzUWRcpKfKFghSWPSyOeu/MNaO5iztQfDc+htWMZXAVC3Of+aYOx0j0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309639; c=relaxed/simple;
	bh=FDThxza/2uA4rj8PYhJ90G48tXnEl7zG0Y4lUR4NoUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j/4TFZvLpg00EljY6ZpZxnZNsU2CNIQnmHhxpLaupCgV/5GLDBlpgfztOmPqhvqM67IIF/VIP8fClm5TBWqttETLsqw83lNRUqgfMSoxmtk/DZQAH31pIts3ax3r7o1xbK+DW+2pXb7vsi2NXq5/qdxu79OU32ikfurIa02onps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=exNPBgR2; arc=fail smtp.client-ip=40.92.20.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V23BcnTtRiqIbNK7CKN7dkZhbsHAfU5RVYEsIdt+UpjNbtfQuFXrbqZZrbsA8YVJJp3LRKozaHnb0zStc39gZzjQEZEfQvjyJyJyaBj+GrEseRlhv4FTYSmS5BDP4IFRTefJgXbYO06fPXzKCAn4p+oodcNgMj+yh8GscPb68H9LnxZ2eilcG4yHH5ggNdz13MTtGH55V4l6iONdeuHqLU26FjpeQ/9ZryQ69iU8i4HVeiNdhg//GchbzQUykPWy7PqGAjh2YlXTbGMWOEraHO15scvCHR+7L6me3uI3bCMaaxjHnUNmR2p4xYyyYTqXMib+bXzFXcc0D2ubqegv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDThxza/2uA4rj8PYhJ90G48tXnEl7zG0Y4lUR4NoUo=;
 b=DVGy3t110elxwW7GYj7J6yo5NdnPP5N4yM8DmuKgzdalw5ZvjLCf/aZn/rkgZ5Z1/N8TMEdfWKzwv13Si6q/UrqhXs1kvikmkGm02s2ZH2MlpaO+4IO8RePlAfd6NGWAiwPX27LrJD4O+kJAGW/z+nlb+/BwjD2eZATmF4GFHe9t4Qzu70fKm5Lhu6s7b++X8EsYwJNXgwex10twSA1n3Z9JiF7G7yuaI3x5PUsZl2XFpWGSW3oogR0yUuu62Oh/OpMCliEtvvIQVZYADy7rKhxfaqeMwhL461cp2IPewFDyOjyGwWy5x4CFHj0+/mi3il0QkS7DhGV35yczmShnUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDThxza/2uA4rj8PYhJ90G48tXnEl7zG0Y4lUR4NoUo=;
 b=exNPBgR2eygnwcWwIJ4TBLRR6047G/XVRUh775ZBcG2qwl+XFnpg6zsF8XmW1YEFBwerFWLTcOLJq6hK4Pz4gtxf33l3EMHSymq4ffc8QV2gEYIoodPT1Ww1CHJFBn7Q5zKCJbaHL+lHiSDMlpTwj3YI1ofsXVAxQNpP9Z1ar4MocofINi4ou3biMGOYhhgQbUYX8lQew1drEtEVRGO1NuRK835Z0J+bHhk9gDwup6xGl3Rt0twMfS9W5xaOZAxHkUSq1MX/VTac24oq+ALnxQVSe46DjncpGAHc3TynH3N+m1F1NhJqbhx6vSFTn3vvRSBs80lJFIy5t0fivpzxvw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB9306.namprd02.prod.outlook.com (2603:10b6:510:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 23:20:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 23:20:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Schierl <schierlm@gmx.de>, Jean Delvare <jdelvare@suse.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Topic: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Index: AQHajaNnaKjzbQWkCEqfKgwSAQ9VW7FopBnAgAExRwCAACYysIABcguAgAAcUjA=
Date: Tue, 16 Apr 2024 23:20:32 +0000
Message-ID:
 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
In-Reply-To: <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Cm3iDdwVHxK25GycxnNMbGrdCaOLpTg+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB9306:EE_
x-ms-office365-filtering-correlation-id: 8370c0d2-412e-4a59-2ef2-08dc5e6bd004
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /OE6pho7LQdbB/HnL6yVm/r0ISpQY493eRzJOOQepWOTiGFMukIzk4Utgj6+TKYbt+zMQw0V/zvlKLhT5U3GlcQhxjD8OhOwk9sd7vTgCKuqETOGW8WKGCLzab2jk59sO6uflcOjAPVKj+V333htx5EaOXsGdrAdA08ivFz72QNNTgngrykZDH3JqnA2oLCcojeQxUQsjEBPN07HQVtY6T7fwAaoV2FBikmB3otLR9giAj7rWP63tQOb4f9R4dahVhaw6v5efL2QBPz3aExA5Xq4WWNe1zdENSxC4lbjuS9WSRclcq18BN4upIDy0p8Vb03Bfz5IJOZ2KdCH2ifBp8GgFYKN5WXDbNrWWm9ROOv45Uy90rjixSxc//n1Bmp2V2UQYzYLo2iJtcaECJNtNas3nrLlHLD5s2R7et4RhNxNqUYi5s2xHGGvuZ6NFNZI/Y/pCgCTJJtEB8YjxHOGFokCC08/RQfEeQxgAEChZ1CrwS2227r16SP04j/PRQKB8yyCC3StjU4gVe76HqdZb2KROkql5VlBgx1evRpJ2jajF9bW2F/RHUeIeRT4C04l
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmJlV3c2NWZ4TkpmdjN5cnR5RERTcThjdGxkY1ppNnFxSmZndDJMMEgzMCtp?=
 =?utf-8?B?N3BFUTdvaFdyV1lHM3hUK2d1NVFTQUhoY1k3WW51eGdsMzJRMm1NMGcrUXdy?=
 =?utf-8?B?UWViV3I0TDlTdktBR09hZDIyTUJmbXZkUVR4eU9ieUxUdGhrOUp6b2lhS1p0?=
 =?utf-8?B?dFdUVm9INHMxT2FGalllT1phRnF6aTMxZDBzSmFtcWdkRUE0NlJwU3JPL295?=
 =?utf-8?B?UFdieGVRaS9scUluTGRhanB2Vk1pNkUycVRmQ0xLUlQzVnRrRWwxUGVuZlNF?=
 =?utf-8?B?ZEVCT3hwWHMxSncvM29ibkl1MDVMcTAzZzBTaWNRam5OOXVOQkJYcUdNc2Vi?=
 =?utf-8?B?VjM5a01LVUpaTkpaSHI3K3ZDY05sTS9XRW85c1phOXBLZXBmeU5CVWk0T2ZM?=
 =?utf-8?B?cmdkaC81M2h5UE04STBGd0RIbmtod2FrQXRNR0pndVljNzNHckpRajR2bUlX?=
 =?utf-8?B?YXRmbEFqYjl1NmFCYk9ScW5NSlcyS3FxWnZuMGIySEl6b0JzT2M1Z1huczZY?=
 =?utf-8?B?aEZZamw1d1dQVXM5M0RXZXBhOUxLM3V4REhlbzBqcWlCTWk1QzZYcUovOWNL?=
 =?utf-8?B?bXVTRFpyMms2ek16SEd1U3oydlloWFQrcW85ZnArajNBVEc3djJqYXFreEZs?=
 =?utf-8?B?Tmp1N01CNSswakVsUzNIYnlraHV4UlFOTDllZVpxc0h5WUF2ZmtpT012OExq?=
 =?utf-8?B?UktDemRQMlRLOHFmcThDeDNsYTMxZEFOcWFDOTF1YVV3NERobWZwRDZvb1Fi?=
 =?utf-8?B?UzlTUkdsVHQySDZJSGk2WmVFUkJ2UWovTWVZQVhKK0lTbUl5R0pRRUdiRjF3?=
 =?utf-8?B?NVREZXM2SXZXcmkxdmFMR0h2eDJYS0Z0OFJQQVRCc0FGa1ZldXdLWUNQYlRO?=
 =?utf-8?B?VUt3U0w5THF2Y0d1eUVwR055UDdHd25GVHlYaEhPdUFSeDZZb1gwRGMxdWND?=
 =?utf-8?B?ZHdRdm94NVdBQ2tZWW5VblVNb2lQVm56UkNyNURWanFZY0VSUjlPUXlVaDNG?=
 =?utf-8?B?YURBeVpLT2tVZjA3c1hWMUFrT1pDV3BvNm8zVFVKVXp6ak43bkRwQkpYRlJ1?=
 =?utf-8?B?VTRyd1FLS1FvVk1uV29uanAvZHlQRHpySVY3cHNwU2pPYmtDT2xPUzBBYitC?=
 =?utf-8?B?dmJMVW5qNUNoTUlDekZGS2g2SDhlRGNYL05CanEwYnNQQjE1TzJBajRHR0kz?=
 =?utf-8?B?M1A0cUplNGplcklFcHdQczNKK1Zya0ZsZFRCa2JJS01aM3JhQVdPZ2wvazVV?=
 =?utf-8?B?Q2ZZcTZMc1pzMTZNSzc3emg4alhnaVJubEwvWFlwZXVNVjRaYWNwRHpOeHRm?=
 =?utf-8?B?WUtTSGJwQThrQUdnNVJKWG5rWFlZcTAzNmZNK0lhRHBYU2JRUG1DRUV6ZnRp?=
 =?utf-8?B?Tlc5QU5vb0Exd3AwSk1INWhPMlBtTGl0Q3oza0pPQlZXK1JHM1BYajhPTlZK?=
 =?utf-8?B?RWZmd1o3bnl0YTBFdUorQkJuYkVTU3NPQnZkY0toV2dWbldCSlB3QWlIa1V0?=
 =?utf-8?B?Uk9COEdoaEhHSDFSK3dkdUVEaEQ1NVo1Ylk1dHVuR1FObytvMXBXZ3dQdG9Q?=
 =?utf-8?B?NUNZNnZWemVHT20xR0U1T1A4ZSt3cVhCLzYxcVRUbDQyVGVRUjBjY09KeHhY?=
 =?utf-8?Q?9Nn1ij0iOg6OdFcRmphU2XQz2DGz1zm6q00oy5EY3ScA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8370c0d2-412e-4a59-2ef2-08dc5e6bd004
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:20:32.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9306

RnJvbTogTWljaGFlbCBTY2hpZXJsIDxzY2hpZXJsbUBnbXguZGU+IFNlbnQ6IFR1ZXNkYXksIEFw
cmlsIDE2LCAyMDI0IDI6MjQgUE0NCj4gDQo+IEFtIDE2LjA0LjIwMjQgdW0gMDE6MzEgc2Nocmll
YiBNaWNoYWVsIEtlbGxleToNCj4gDQo+ID4gQ2FuIHlvdSBnaXZlIG1lIGRldGFpbHMgb2YgdGhl
IEh5cGVyLVYgVk0gY29uZmlndXJhdGlvbj8gIE1heWJlDQo+ID4gYSBzY3JlZW5zaG90IG9mIHRo
ZSBIeXBlci1WIE1hbmFnZXIgIlNldHRpbmdzIiBmb3IgdGhlIFZNIHdvdWxkDQo+ID4gYmUgYSBn
b29kIHN0YXJ0aW5nIHBvaW50LCB0aG91Z2ggc29tZSBvZiB0aGUgZGV0YWlscyBhcmUgb24NCj4g
PiBzdWItcGFuZWxzIGluIHRoZSBVSS4NCj4gDQo+IEl0IHVzZWQgdG8gYmUgcG9zc2libGUgdG8g
ZXhwb3J0IEh5cGVyLVYgVk0gc2V0dGluZ3MgYXMgWE1MLCBidXQNCj4gYXBwYXJlbnRseSB0aGF0
IG9wdGlvbiBoYXMgYmVlbiByZW1vdmVkIGluIFdpbjIwMTYvV2luMTAsIGluIGZhdm9yIG9mDQo+
IHRoZWlyIG93biBwcm9wcmlldGFyeSBiaW5hcnkgLnZtY3ggZm9ybWF0Li4uDQo+IA0KPiBBbHNv
LCBtYXliZSBpdCBtYXR0ZXJzIHdoYXQgZWxzZSBIeXBlci1WIGlzIGRvaW5nLiBJJ3ZlIGluc3Rh
bGxlZCBib3RoDQo+IFdTTCBhbmQgV1NBLCBhbmQgV2luZG93cyBEZWZlbmRlciBpcyB1c2luZyBD
b3JlIElzb2xhdGlvbiBNZW1vcnkNCj4gSW50ZWdyaXR5LiBJIGhhdmUgYWxzbyBlbmFibGVkIHN1
cHBvcnQgZm9yIG5lc3RlZCB2aXJ0dWFsaXNhdGlvbiBpbiB0aGUNCj4gSG9zdC9OZXR3b3JrIFN3
aXRjaCwgYnV0IG5vdCBpbiB0aGF0IFZNLg0KPiANCj4gQW55d2F5LCBJIGp1c3QgY3JlYXRlZCB0
d28gbmV3IFZNcyAob25lIG9mIGVhY2ggZ2VuZXJhdGlvbikgd2l0aCBubyBoYXJkDQo+IGRpc2sg
YW5kIGV2ZXJ5dGhpbmcgZWxzZSBkZWZhdWx0LCBhZGRlZCBhIERWRCBkcml2ZSB0byB0aGUgU0NT
SQ0KPiBjb250cm9sbGVyIG9mIEdlbjIgKHdoaWNoIEdlbjEgYWxyZWFkeSBoYWQgb24gaXRzIElE
RSBjb250cm9sbGVyKSwNCj4gZGlzYWJsZWQgU2VjdXJlIEJvb3Qgb24gR2VuMiBhbmQgYWRkZWQg
YSBzZWNvbmQgdkNQVSB0byBHZW4xICh3aGljaCBHZW4yDQo+IGFscmVhZHkgaGFkKS4NCj4gDQo+
IEFmdGVyd2FyZHMsIEdlbjIncyBkbWlkZWNvZGUgbG9va3MgbGlrZSB0aGUgc3VtbWFyeSB5b3Ug
cG9zdGVkLCBhbmQgR2VuMQ0KPiByZXByb2R1Y2VzIHRoZSBpc3N1ZS4NCj4gDQo+ID4gSSdtIGd1
ZXNzaW5nIHlvdXIgMzItYml0IExpbnV4IFZNIGlzDQo+ID4gYSBHZW5lcmF0aW9uIDEgVk0uICAg
RldJVywgbXkgZXhhbXBsZSB3YXMgYSBHZW5lcmF0aW9uIDIgVk0uDQo+IA0KPiBWZXJ5IGludGVy
ZXN0aW5nIHRoYXQgR2VuMiBib290cyAzMi1iaXQgTGludXggYmV0dGVyIHRoYW4gR2VuMSAodGhl
cmUgaXMNCj4gYSBkZWxheSBkdXJpbmcgaGFyZHdhcmUgYXV0b2NvbmZpZ3J1YXRpb24gKHN5c3Rl
bWQtdWRldmQpIGZvciBhYm91dCAzMA0KPiBzZWNvbmRzIHdoZW4gYm9vdGluZyBHZW4yIHdoaWNo
IEkgZGlkIG5vdCBpbnZlc3RpZ2F0ZSB5ZXQpLCBkZXNwaXRlIHRoZQ0KPiBkb2N1bWVudGF0aW9u
IGNsYWltaW5nIG5vdCB0byB1c2UgR2VuMiBmb3IgYW55IDMyLWJpdCBIb3N0IE9TZXMuDQo+IA0K
PiBTbyBJIGFzc3VtZSB0aGlzIG9ubHkgYXBwbGllcyB0byBjcmFwcHkgT1NlcyB0aGF0IGRpcmVj
dGx5IGNvdXBsZSB0aGVpcg0KPiBiaXRuZXNzIHRvIHRoZSBiaXRuZXNzIG9mIHRoZSBVRUZJIGZp
cm13YXJlLg0KPiANCj4gVG8gYmUgZmFpciwgdGhlIGxpdmUgbWVkaWEgSSdtIHVzaW5nIHVzZXMg
R3J1YidzICJub24tY29tcGxpYW50IiBMaW51eA0KPiBsb2FkZXIgdGhhdCBieXBhc3NlcyB0aGUg
a2VybmVsJ3MgRUZJIHN0dWIuIFdoZW4gdHJ5aW5nIHdpdGggR3J1YidzDQo+ICJsaW51eGVmaSIg
bG9hZGVyLCBMaW51eCBkb2VzIG5vdCBib290IGVpdGhlciwgYXMgZXhwZWN0ZWQuIChPbiB0aGUg
R2VuMQ0KPiBWTSwgdGhlIHBhbmljIGhhcHBlbnMgcmVnYXJkbGVzcyB3aGV0aGVyIEkgdXNlIGdy
dWIncyBsaW51eDE2IG9yIGxpbnV4DQo+IGxvYWRlciwgYW5kIGFsc28gd2l0aCBTWVNMSU5VWC9J
U09MSU5VWCBsb2FkZXIpLg0KPiANCj4gPiBXaGVuIHlvdSByYW4gYSA2NC1iaXQgTGludXggYW5k
IGRpZCBub3QgaGF2ZSB0aGUgcHJvYmxlbSwgd2FzDQo+ID4gdGhhdCB3aXRoIGV4YWN0bHkgdGhl
IHNhbWUgSHlwZXItViBWTSBjb25maWd1cmF0aW9uLCBvciBhIGRpZmZlcmVudA0KPiA+IGNvbmZp
Zz8NCj4gDQo+IEFsbCBteSB0ZXN0cyB3ZXJlIHBlcmZvcm1lZCB3aXRoIGEgc2luZ2xlIChHZW4x
KSBWTSwgYW5kIHRoZSBvbmx5DQo+IHNldHRpbmcgSSBjaGFuZ2VkIHdhcyB0aGUgbnVtYmVyIG9m
IHZDUFVzLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uICBJIG5vdyBoYXZlIGEg
cmVwcm8gb2YgImRtaWRlY29kZSINCmluIHVzZXIgc3BhY2UgY29tcGxhaW5pbmcgYWJvdXQgYSB6
ZXJvIGxlbmd0aCBlbnRyeSwgd2hlbiBydW5uaW5nDQppbiBhIEdlbiAxIFZNIHdpdGggYSA2NC1i
aXQgTGludXggZ3Vlc3QuICBMb29raW5nIGF0DQovc3lzL2Zpcm13YXJlL2RtaS90YWJsZXMvRE1J
LCB0aGF0IHNlY3Rpb24gb2YgdGhlIERNSSBibG9iIGRlZmluaXRlbHkNCnNlZW1zIG1lc3NlZCB1
cC4gIFRoZSBoYW5kbGUgaXMgMHgwMDA1LCB3aGljaCBpcyB0aGUgbmV4dCBoYW5kbGUgaW4NCnNl
cXVlbmNlLCBidXQgdGhlIGxlbmd0aCBhbmQgdHlwZSBvZiB0aGUgZW50cnkgYXJlIHplcm8uICBU
aGlzIGlzIGEgYml0DQpkaWZmZXJlbnQgZnJvbSB0aGUgdHlwZSAxMCBlbnRyeSB0aGF0IHlvdSBz
YXcgdGhlIDMyLWJpdCBrZXJuZWwNCmNob2tpbmcgb24sIGFuZCBJIGRvbid0IGhhdmUgYW4gZXhw
bGFuYXRpb24gZm9yIHRoYXQuICBBZnRlciB0aGlzDQpib2d1cyBlbnRyeSwgdGhlcmUgYXJlIGEg
ZmV3IGJ5dGVzIEkgZG9uJ3QgcmVjb2duaXplLCB0aGVuIGFib3V0DQoxMDAgYnl0ZXMgb2YgemVy
b3MsIHdoaWNoIGFsc28gc2VlbXMgd2VpcmQuDQoNCkJ1dCBhdCB0aGlzIHBvaW50LCBpdCdzIGdv
b2QgdGhhdCBJIGhhdmUgYSByZXByby4gSXQgaGFzIGJlZW4gYSB3aGlsZSBzaW5jZQ0KSSd2ZSBi
dWlsdCBhbmQgcnVuIGEgMzItYml0IGtlcm5lbCwgYnV0IEkgdGhpbmsgSSBjYW4gZ2V0IHRoYXQg
c2V0IHVwIHdpdGgNCnRoZSBhYmlsaXR5IHRvIGdldCBvdXRwdXQgZHVyaW5nIGVhcmx5IGJvb3Qu
IEknbGwgZG8gc29tZSBmdXJ0aGVyDQpkZWJ1Z2dpbmcgd2l0aCBkbWlkZWNvZGUgYW5kIHdpdGgg
dGhlIDMyLWJpdCBrZXJuZWwgdG8gZmlndXJlIG91dA0Kd2hhdCdzIGdvaW5nIG9uLiAgVGhlcmUg
YXJlIHNldmVyYWwgbXlzdGVyaWVzIGhlcmU6ICAxKSBJcyBIeXBlci1WDQpyZWFsbHkgYnVpbGRp
bmcgYSBiYWQgRE1JIGJsb2IsIG9yIGlzIHNvbWV0aGluZyBlbHNlIHRyYXNoaW5nIGl0Pw0KMikg
V2h5IGRvZXMgYSA2NC1iaXQga2VybmVsIHN1Y2NlZWQgb24gdGhlIHB1dGF0aXZlIGJhZCBETUkg
YmxvYiwNCndoaWxlIGEgMzItYml0IGtlcm5lbCBmYWlscz8gIDMpIElzIGRtaWRlY29kZSBzZWVp
bmcgc29tZXRoaW5nDQpkaWZmZXJlbnQgZnJvbSB0aGUgTGludXgga2VybmVsPw0KDQpHaXZlIG1l
IGEgZmV3IGRheXMgdG8gc29ydCBhbGwgdGhpcyBvdXQuICBBbmQgaWYgTGludXggY2FuIGJlIG1h
ZGUNCm1vcmUgcm9idXN0IGluIHRoZSBmYWNlIG9mIGEgYmFkIERNSSB0YWJsZSBlbnRyeSwgSSds
bCBzdWJtaXQgYQ0KTGludXgga2VybmVsIHBhdGNoIGZvciB0aGF0Lg0KDQpNaWNoYWVsIEtlbGxl
eQ0K

