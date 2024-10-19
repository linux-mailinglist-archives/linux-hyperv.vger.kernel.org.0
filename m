Return-Path: <linux-hyperv+bounces-3160-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DF9A4B38
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Oct 2024 06:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C261C21231
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Oct 2024 04:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11A61D3588;
	Sat, 19 Oct 2024 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hx+2/38J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010011.outbound.protection.outlook.com [52.103.20.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A6EEB9;
	Sat, 19 Oct 2024 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729313971; cv=fail; b=D0Q76eXrBn44zp6qmX7kit8DZTQXxlAoYgM+ntqhpxkakO+Zm2hCM7h55Eaw8xMrFgPjpVMA/uIuyin+cNe8jSVHksqyNEZoVqeXSantNC9r9h/ntQtaecsjdyHdHzoJKoKeEJMjQF7MtjpIoezkG27eS3BYiWMqhw1RITn2f/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729313971; c=relaxed/simple;
	bh=cBut0+SbXMpeQ4QVHfbwvE4aEr4nb+ABcweiDWGNmog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OdRaRqapqNYmeU0Ac7jmWXNlyksJfIXqnBjUOM7lukSNOGJ9SA/fkzFMBRoKXdIJfNGrQd6BXsajFnyJRh0+jK4AEBafB2kPyYRBzYNA/0QlLQhdgjsS53eZhDuUYZNZepn3+NgAjgXBE7W0gw15WJLlIMLdLcjMuOnROm92YmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hx+2/38J; arc=fail smtp.client-ip=52.103.20.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srMOBKXOYHWXzF3ya+0HM51wkotlQtrMrCLtBfU0Blbp8asy0R/UFzZHLWGFWpF2RpAGeb9/YFP/RuEk9yQav2iCHuCQ03AoKxGeCyYv5ijIkgqgLbD+/HkkjYH9RtRmgG/y9O3Q5m3YAEsBvuSHYlUpD3Nk++03SSemP+2B5QYbT+OHghI/Pjy9mdI+KnxSr7fykme7sXnRB6+h06IRFfZWSP1fVC/q7v4/7b1EoAb5/ael5fUU9Wy7G7gaxwBvZMph7bnQg0s4Mm+48rS7ngYNKU3RosMZblCfD8WyS/5VokHyBX8Coi324iZCrqDwye1aaY83ToqOY+VV1yZrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBut0+SbXMpeQ4QVHfbwvE4aEr4nb+ABcweiDWGNmog=;
 b=UisLVkFYzhqtIa0ssuco/6z8DPisQdmv4IXcflwR8tehfSVlxjJNr4u8PS4LEJxduIw8OGS1kFduyD8QCC4ZI1xfPV4bQ17RrhXBStajPC0G+hZCIiRuonOEbgJURoa0Un9+Useh0aVPHatgfoZrxaH3mttNyIXRE5JcqDuRmFutJCFpi55HLndGgupeIxHAWkXeMUrz6ZzW0UaW+1GfnJsuegsEriDorBEHZKL7wkHlraKEWbeqgiYjYxM1Gc1ljjCUL0uJyhsiNtPMXw1nGhCwpZdf2rdoxpW5Ify2ofFUEG31XrnUiXWs6WDiMWOE6j2qECYF5YoJN1lp6cPdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBut0+SbXMpeQ4QVHfbwvE4aEr4nb+ABcweiDWGNmog=;
 b=hx+2/38JoPCLio9SpesDdFoQl6/qN8YhEEu3jxQacxlI4Yx/2UgaK/O+5Wp4z8KRFldjHxqwKFYbRp/xD6Zy9T2fX2dfl/Sw1gSVTGQrpSv6eO8vf+ZZVX8kZMKXii9KbgBwsuPPoIqiBVntMELYxzy7FcZFBTFKprIHEe827/LfQwhwlMYIEvW62NheKBLSimo+x1eNHRwy0i8QLuD+vVQ9I0CipThYjuLuJxtTjEzkBwizuFt/pq1gYWBd47qTmXynw0kT45exCZFeqw2boq1m8I0J7lPuQxfYf030yZN4xS8afz1bBmFxTyMtww4DGvtxEvTomtBfRS4dcQPwEg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6897.namprd02.prod.outlook.com (2603:10b6:a03:23a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Sat, 19 Oct
 2024 04:59:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Sat, 19 Oct 2024
 04:59:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, Praveen Kumar
	<kumarpraveen@linux.microsoft.com>, "lkp@intel.com" <lkp@intel.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
CC: Naman Jain <namjain@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>
Subject: RE: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
Thread-Topic: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
Thread-Index: AQHbIBwJBzG14C8G4EaRSRcLJGD+C7KMJdaAgAD6CgCAAGB34A==
Date: Sat, 19 Oct 2024 04:59:25 +0000
Message-ID:
 <SN6PR02MB41573004E0B25DA75F38F0AED4412@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241016223730.531861-1-eahariha@linux.microsoft.com>
 <9f4baf14-8182-451d-9849-4326a783d5c1@linux.microsoft.com>
 <2dff61bd-55d8-430f-9d92-6cbfe1bf6326@linux.microsoft.com>
In-Reply-To: <2dff61bd-55d8-430f-9d92-6cbfe1bf6326@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6897:EE_
x-ms-office365-filtering-correlation-id: 590e41f3-beab-4001-dbbe-08dcefface0a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|8062599003|19110799003|15080799006|6040799012|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 /+JZl+MnfZFzWnaUgMyTxKnwU/cJiKKtYoLJcdHKpGEz4lkob+1J4iO7zw5vCYVjci9V78m55lOGimjnbB/Nsj7JRv6YeNqsG+ssJ2G3rhphC5mlNNmwGalsIKP1/Wk3MNvVcqE1fFrYh5wKd0rcA4D5HMQdiCwa8TyxlEKnyRKLw77KiZxAc7adOImln9xkyReV186c7RVh7GYHnkH4/gHxG6Jugqjxc2vP4dBICjQM9JAWovCpTvdqZFNirXAHxejn20y7vLdO7tcOBWq8cLg2Wrypz9AxwDssgb+iw3JUX3esBOQo0h9zX0dG4OPdxT5blVVEMJRgnPvSdIXMk2fqEG9ndOstdYZYu+OLLNTgEn+iYfEpVjH83NCwtdSbxMbC4ZEfczklwIR0wkk8fqz+pbE6bXhHSlnqZok7gLXyW4pZ786UoEWMU+l4FAsA/qPuPsS0/CmAY5ykHb0dOC5gc6dtk7lFR/EJprmedERVjJ8t4VSdtHRy1VXL1VGZB8rZn5k2geqpEAuowmxYqkWjEY9OXJXQVHa8PNhmQB1KzC1SoOst9aGtba8EgQn7T8XFpjwGAAktY3uOmzQ+TzOUoIyJzJTmEKX61JOuVF7GIORRYIk1Y6fVWJv1zA9wvFQsVna2iymcSHHV46Ic19ED7FeLHLYCFpM1GhTV4LCfOY73tdrSjIXV1hkGU4IxVuUtzjeuoVlt0gcZDtYDGATyWt/y4fnMecb7oCCK/jY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enNZdDhveGJBNE9RMmFmb1dPSXZaZHJzaUovVmJ5aWlOSnN5VjViaXo5UjhK?=
 =?utf-8?B?U0ttS3dOMVlNRTJkb1A4ZE01cWRTK3dvdTVEbGYzQUNZS1FjYmxiKyttWWVm?=
 =?utf-8?B?SnlMZGlMR0lZR2RNZlpDdi9YRFVBa3oxRitzeWlqK214aW1xemplOVN3YWtV?=
 =?utf-8?B?ZzFGZklZVmozWW9vUi9lVG9xOW53NUR0Rm9PK0J0dWpqUE1JaGZsSm1ZVVM5?=
 =?utf-8?B?VGUyS3ZWUVowK2NXMGxOSnQvM0ZRdVdTSWswcWFGOVVuM2tVK3NPR2FlWENn?=
 =?utf-8?B?SnZyUWhQUUJWQWxpajBJb3dQdjg5QWpkejhubzZzNHpKM3NPTUNPY0ZnZzlI?=
 =?utf-8?B?eWZhR3dLZHJzUVMxMlpxWUlhZ3dONFROUk1zcnQzMUNSTm83TDJtdzdKc0cr?=
 =?utf-8?B?L1BrUFBUZ3VXdkVodDdHRTdpYyswMFd5Y1d1TjZCMHNrM3dneUZIVFpmZVhY?=
 =?utf-8?B?YVg5eUttVUdleDdaSFdic1RQeFdUalM5Z1ZMZVNqMEtRdHBpQnErYjBQblBa?=
 =?utf-8?B?azNQVkJNU0lLbUpOcjZoMWcwQXptL3QySkJDNnhvMkpxK0J4Q0R2NTNBYlRB?=
 =?utf-8?B?MHVRNmJLQnNyU2FjVkdBL2JQSVRvR2hVNXh1OVZjN2F0V0VpMUlwclVJSTNG?=
 =?utf-8?B?ak1WY1FzWEtuN3lvL1YzSUE4RnppVXhqU2ZDQjQ0dFhBYzdCMUpKNElkeitV?=
 =?utf-8?B?QWs0UWJpZDdNcEhvbmJhQjQva3hDTnR0SFNZR2tqNGtmV0xQOWlmRmphcEEw?=
 =?utf-8?B?T3BKNnVYTEc2ejNLdE40dU5lRkxCN05hTHNJWWRoL2JmdDRCNDRuaENDa0Jk?=
 =?utf-8?B?NllYaXdKVUhUclBpRVFCQXhhSGFvQnM1NkFJZDJCZStBa2VQbmFaYlk2ZkpN?=
 =?utf-8?B?dmJvS0JacVRYYkl1dHgvclFEVXVWeFJzRmtWMUxUZU91MnBzaC9zL1lHM1Vm?=
 =?utf-8?B?L3pnSTVnNWJ2UGRLRVNZZCtDMWtOZ3VmUTZ1aVFlRG5pNEwySmRFVFVNRXB3?=
 =?utf-8?B?TUN4RzlVYllhZ0RhYkVvZGloWWlpV0phVms3bk1wdm12TGI2cUt6NWg5bHRM?=
 =?utf-8?B?cVhIeXN5Rk1COFFOcU00UlRnWFhlZGw0OUtCYytCYWN6R0o0eEVkOU1OTmhU?=
 =?utf-8?B?dnY4VFZDdkxwUXZhb1Z5Z3VTMVJPSlU2bFRtU3lSNkZuK3laNzB1WTZHQ2Zj?=
 =?utf-8?B?ZGt4RUhlMWNkK3IwdDdFQ2pnbHdoZnF4L1NSQ2wvTXcrZGQ3YS8zVEpubEpy?=
 =?utf-8?B?dVNkaytzcGVTZ2k5Q05KZnRZa2xKeFVBMjRQWmpIdDFkMXNSWUFXTlFCRWtm?=
 =?utf-8?B?V1pkU2hiM2d5bEVCdXppWU80a3h5SVU0STN6NEdESHJER2Z3RS93Q1hOK2Rx?=
 =?utf-8?B?SWlpUjBkQWtyb0J5Zk0remlOUmlmRGIrb3djaXJoY0F6bitxZkhJTytwZEwy?=
 =?utf-8?B?K0NBWCtWZlJMYVNPdVVzdFYvWXBZVEh5b2NXRkNtbTBnelFWU3dUU2p1MGxi?=
 =?utf-8?B?MXZMdDJFVHFVd0F4WDdsMVRndGl2Z3dtcW9wMkRSNFpLRjdOQXFPeWxtNWgr?=
 =?utf-8?B?SHpPVHpjMGpCVGw1aG8zTFpCVzYvREJuNzMweFBzbkdEckhvTHRMNVdCSzdw?=
 =?utf-8?Q?1WKC4xaWUPlmackOLh2Q/CH8h/zApTfQEkLRvp8sQmoQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 590e41f3-beab-4001-dbbe-08dcefface0a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 04:59:25.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6897

RnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFoYXJpaGFAbGludXgubWljcm9zb2Z0LmNvbT4gU2Vu
dDogRnJpZGF5LCBPY3RvYmVyIDE4LCAyMDI0IDM6NTAgUE0NCj4gDQo+IE9uIDEwLzE4LzIwMjQg
MTI6NTQgQU0sIFByYXZlZW4gS3VtYXIgd3JvdGU6DQo+ID4gT24gMTctMTAtMjAyNCAwNDowNywg
RWFzd2FyIEhhcmloYXJhbiB3cm90ZToNCj4gPj4gV2UgaGF2ZSBzZXZlcmFsIHBsYWNlcyB3aGVy
ZSB0aW1lb3V0cyBhcmUgb3Blbi1jb2RlZCBhcyBOIChzZWNvbmRzKSAqIEhaLA0KPiA+PiBidXQg
YmVzdCBwcmFjdGljZSBpcyB0byB1c2UgbXNlY3NfdG9famlmZmllcygpLiBDb252ZXJ0IHRoZSB0
aW1lb3V0cyB0bw0KPiA+PiBtYWtlIHRoZW0gSFogaW52YXJpYW50Lg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogRWFzd2FyIEhhcmloYXJhbiA8ZWFoYXJpaGFAbGludXgubWljcm9zb2Z0LmNvbT4NCj4g
Pj4gLS0tDQo+ID4+ICBkcml2ZXJzL2h2L2h2X2JhbGxvb24uYyAgfCA5ICsrKysrLS0tLQ0KPiA+
PiAgZHJpdmVycy9odi9odl9rdnAuYyAgICAgIHwgNCArKy0tDQo+ID4+ICBkcml2ZXJzL2h2L2h2
X3NuYXBzaG90LmMgfCA2ICsrKystLQ0KPiA+PiAgZHJpdmVycy9odi92bWJ1c19kcnYuYyAgIHwg
MiArLQ0KPiA+PiAgNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9odl9iYWxsb29uLmMgYi9k
cml2ZXJzL2h2L2h2X2JhbGxvb24uYw0KPiA+PiBpbmRleCBjMzhkY2RmY2I5MTRkLi4zMDE3ZDQx
ZjEyNjgxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2h2L2h2X2JhbGxvb24uYw0KPiA+PiAr
KysgYi9kcml2ZXJzL2h2L2h2X2JhbGxvb24uYw0KPiA+PiBAQCAtNzU2LDcgKzc1Niw3IEBAIHN0
YXRpYyB2b2lkIGh2X21lbV9ob3RfYWRkKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxv
bmcgc2l6ZSwNCj4gPj4gIAkJICogYWRkaW5nIHN1Y2NlZWRlZCwgaXQgaXMgb2sgdG8gcHJvY2Vl
ZCBldmVuIGlmIHRoZSBtZW1vcnkgd2FzDQo+ID4+ICAJCSAqIG5vdCBvbmxpbmVkIGluIHRpbWUu
DQo+ID4+ICAJCSAqLw0KPiA+PiAtCQl3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmRtX2Rl
dmljZS5vbF93YWl0ZXZlbnQsIDUgKiBIWik7DQo+ID4+ICsJCXdhaXRfZm9yX2NvbXBsZXRpb25f
dGltZW91dCgmZG1fZGV2aWNlLm9sX3dhaXRldmVudCwgbXNlY3NfdG9famlmZmllcyg1ICogMTAw
MCkpOw0KPiA+DQo+ID4gSXMgaXQgY29ycmVjdCB0byBjb252ZXJ0IEhaIHRvIDEwMDAgPw0KPiA+
IEFsc28sIGhvdyBhcmUgeW91IHRlc3RpbmcgdGhlc2UgY2hhbmdlcyA/DQo+ID4NCj4gDQo+IEl0
J3MgYSBjb252ZXJzaW9uIG9mIG1pbGxpc2Vjb25kcyB0byBzZWNvbmRzLCByYXRoZXIgdGhhbiBI
WiB0byAxMDAwLiA6KQ0KPiBtc2Vjc190b19qaWZmaWVzKCkgaGFuZGxlcyB0aGUgY29udmVyc2lv
biB0byBqaWZmaWVzIHdpdGggSFouIEFzIE5hbWFuDQo+IG1lbnRpb25lZCwgdGhpcyBjb3VsZCBi
ZSBlcXVpdmFsZW50bHkgd3JpdHRlbiBhcyA1ICogTVNFQ1NfUEVSX1NFQywgYW5kDQo+IHdvdWxk
IHByb2JhYmx5IGJlIG1vcmUgcmVhZGFibGUuIE9uIHRlc3RpbmcsIHRoaXMgaXMgb25seQ0KPiBj
b21waWxlLXRlc3RlZCwgYW5kIHRoYXQncyBwYXJ0IG9mIHRoZSByZWFzb24gd2h5IGl0J3MgYW4g
UkZDLCBzaW5jZSBJJ20NCj4gbm90IDEwMCUgc3VyZSBldmVyeSBvbmUgb2YgdGhlc2UgdGltZW91
dHMgaXMgbWVhc3VyZWQgaW4gc2Vjb25kcy4gSG9waW5nDQo+IGZvciBmb2xrcyBtb3JlIGZhbWls
aWFyIHdpdGggdGhlIGNvZGUgdG8gdGFrZSBhIGxvb2suDQo+IA0KDQpJIGJlbGlldmUgdGhlIGN1
cnJlbnQgY29kZSBpcyBjb3JyZWN0LiAgVHdvIHRoaW5nczoNCg0KMSkgVGhlIHZhbHVlcyBtdWx0
aXBsaWVkIGJ5IEhaIGFyZSBpbmRlZWQgaW4gc2Vjb25kcy4gVGhlIG51bWJlciBvZg0Kc2Vjb25k
cyBhcmUgc29tZXdoYXQgYXJiaXRyYXJ5IGluIHNvbWUgb2YgdGhlIGNhc2VzLCBzbyB5b3UgbWln
aHQNCmFyZ3VlIGZvciBhIGRpZmZlcmVudCBudW1iZXIgb2Ygc2Vjb25kcy4gQnV0IGFzIGNvZGVk
LCB0aGUgdmFsdWVzDQphcmUgaW4gc2Vjb25kcy4NCg0KMikgVW5sZXNzIEknbSBtaXNzaW5nIHNv
bWV0aGluZywgdGhlIGN1cnJlbnQgY29kZSB1c2VzIHRoZSBjb3JyZWN0DQp0aW1lb3V0IHJlZ2Fy
ZGxlc3Mgb2YgdGhlIHZhbHVlIG9mIEhaIGJlY2F1c2UgdGhlIG51bWJlciBvZiBqaWZmaWVzDQpw
ZXIgc2Vjb25kICppcyogSFouDQoNCkFzIHN1Y2gsIGl0IG1pZ2h0IGhlbHAgdG8gYmUgZXhwbGlj
aXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHRoYXQgdGhpcw0KcGF0Y2ggaXNuJ3QgZml4aW5nIGFu
eSBidWdzLiAgQXMgdGhlIGNvbW1pdCBtZXNzYWdlIHNheXMsIHRoZSBwYXRjaCBpcw0KdG8gYnJp
bmcgdGhlIGNvZGUgaW50byBjb25mb3JtYW5jZSB3aXRoIGJlc3QgcHJhY3RpY2VzLiBJIHByZXN1
bWUNCnRoZSBiZXN0IHByYWN0aWNlIHlvdSByZWZlcmVuY2UgaXMgZGVzY3JpYmVkIGluDQpEb2N1
bWVudGF0aW9uL3NjaGVkdWxlci9jb21wbGV0aW9uLnJzdC4NCg0KSSBkb24ndCB1bmRlcnN0YW5k
IHRoZSBzdGF0ZW1lbnQgYWJvdXQgbWFraW5nIHRoZSBjb2RlICJIWiBpbnZhcmlhbnQiLA0Kd2hp
Y2ggSSB0aGluayBjYW1lIGZyb20gdGhlIGFmb3JlbWVudGlvbmVkIGRvY3VtZW50YXRpb24uICBQ
ZXINCm15ICMyIGFib3ZlLCBJIHRoaW5rIHRoZSBleGlzdGluZyBjb2RlIGlzIGFscmVhZHkgIkha
IGludmFyaWFudCIsIGF0DQpsZWFzdCBmb3IgaG93IEkgd291bGQgaW50ZXJwcmV0ICJIWiBpbnZh
cmlhbnQiLg0KDQpSZWdhcmRsZXNzIG9mIHRoZSBtZWFuaW5nIG9mICJIWiBpbnZhcmlhbnQiLCBJ
IGFncmVlIHdpdGggdGhlIGlkZWEgb2YNCmVsaW1pbmF0aW5nIHRoZSB1c2Ugb2YgSFogaW4gY2Fz
ZXMgbGlrZSB0aGlzLCBhbmQgbGV0dGluZyBtc2Vjc190b19qaWZmaWVzKCkNCmhhbmRsZSBpdC4g
VW5mb3J0dW5hdGVseSwgY29udmVydGluZyBmcm9tICI1ICogSFoiIHRvIA0KIm1zZWNzX3RvX2pp
ZmZpZXMoNSAqIDEwMDApIiBtYWtlcyB0aGUgY29kZSByZWFsbHkgY2x1bmt5LiBJIHdvdWxkDQph
ZHZvY2F0ZSBmb3IgYWRkaW5nIHNvbWV0aGluZyBsaWtlIHRoaXMgdG8gaW5jbHVkZS9saW51eC9q
aWZmaWVzLmg6DQoNCiNkZWZpbmUgc2Vjc190b19qaWZmaWVzKHNlY3MpICAgIG1zZWNzX3RvX2pp
ZmZpZXMoKHNlY3MpICogMTAwMCkNCg0KYW5kIHRoZW4gdXNpbmcgc2Vjc190b19qaWZmaWVzKCkg
Zm9yIGFsbCB0aGUgY2FzZXMgaW4gdGhpcyBwYXRjaC4gVGhhdA0KcmVkdWNlcyB0aGUgY2x1bmtp
bmVzcy4gQnV0IG1heWJlIHNvbWVib2R5IGluIHRoZSBwYXN0IHRyaWVkIHRvDQphZGQgc2Vjc190
b19qaWZmaWVzKCkgYW5kIGdvdCBzaG90IGRvd24gLS0gSSBkb24ndCBrbm93LiBJdCBzZWVtcyBs
aWtlDQphbiBvYnZpb3VzIHRoaW5nIHRvIGFkZCAuLi4uDQoNCk1pY2hhZWwNCg==

