Return-Path: <linux-hyperv+bounces-1533-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797284F89F
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Feb 2024 16:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AAE280DC9
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Feb 2024 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79528745D2;
	Fri,  9 Feb 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Bm0Uk1g4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2100.outbound.protection.outlook.com [40.92.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F186F06C;
	Fri,  9 Feb 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492809; cv=fail; b=rktIhq3YaoQ+mtmaqN5zyZg934lnBC/UPnD1qJ+cj5Q5hjfqd0Wdde8sVIuICaWNrezSE0Loql8UAIeBxoQyxsv91Yb/E6oFqEzMACMBfvokbmMjZ3m9wo80H2AI5rsfYwxpPmmg4pGY6SoxHFfFYvcvngI00gJkYxt43cYl/gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492809; c=relaxed/simple;
	bh=GoHwm58jGAdbaXhT6Ntnu7V5ieYE4SEshwlLTHUyRs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PkpXdeTMEb5GFU67pDBfiNBo/1emBNBDeIAo0kegyTpX4f9+AMw8o6Z8xPVFSOMx/t73sVILAscTEIGIIvjwaPu1MhqIEd5poJ8OQDsWUL0oyJwoA3yAO3wu1MAxCDZ2KMldf2ak2RqrP6CkwouAh4n1q2RBJMfFBC2AnWvkAxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Bm0Uk1g4; arc=fail smtp.client-ip=40.92.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MODej/SHlckZp/6mpcgMktlCVTeCkcW8rZ6onJEnnFA6CHRcnhu8A0jqrAausPIzGNFoAnPXYdSe175AYGG3QMzLQfWBldwbSOlUbEagTxlny5xuzMXKxA++XOZ9Mn2BxOqq7wL/HKYZi4fi77B4xnZ8Qlz9EcT30L+N3fftLowaHaddZ3zzjWizD/Ks1l8f9RHNDjZUr+1K/+pzs2xHrQgh2lqxjI2Rzl+nskBvH+ZheOhBKj18VZ/m/MMbUQ7z5mIiyPbO0dloUYO99hsJgtEv+LPPqK86pEng1o59smlyHa08idy151zPpuR7XuRO6psWjecaAhCszbr7QvDc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoHwm58jGAdbaXhT6Ntnu7V5ieYE4SEshwlLTHUyRs4=;
 b=hXaRWacJ+iww/e/Mcv42a0EpVfCwF97lBGMZ9B0qY7iYM8RVE4DszDM715vMeGalvOJ36g/fJPY+8+KdUxXHudenzXdDMuEcWNredr3ZX4/E1FvxlWSIKSJey0DkWWI4OYp3VD7Ypu09zw3QqgFZ0zFiIda1ztxgIa6qw3bdTDr0PXg1py7LOYMjda0dgwGd7Rc3G7uXfE38VhddAP42zKUXXq2WKRLJszHxoDidhYYPo8yzx8ZX9x+VOn6uXd9hO8GbMATgFt0MxKPPl000iy+ILE3B9w3bcJSRGNyXs7CQ2BCDzdujZLuJham1y11hLW7R/YnozQka+oXnRGlqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoHwm58jGAdbaXhT6Ntnu7V5ieYE4SEshwlLTHUyRs4=;
 b=Bm0Uk1g4oUNK+iFymIOzqopBeCHl+M6vTpNVrWaZzcLM7RoIswqBxI719gLCZg3WgKzBksTedOCh7rxeXaC6ntjok46UG41d5N1k0NCXdgc8rB6BmWauiV87gwDuCjgarstOaiXWQm0kz8KtmnUbSmM0Q5axXz3Keu19MLrxBEG15hwsa8KT+W9NT/M6+OaAfQPJF/4O5PUHYlq6FmbpDBomArCBwvzjbbW71hfWAjQhNXAkkDoDoLqt02G70SZKUhU8gvT8BcqEQI5NDsdTdfLWwcLz25MWvgkppiEmPFh0vTZ8R1MBWKsh9R6oFWs4mXt7RIXJoo4GXyqUr4DUWg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10102.namprd02.prod.outlook.com (2603:10b6:408:19c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 15:33:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.027; Fri, 9 Feb 2024
 15:33:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Markus Elfring <Markus.Elfring@web.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Remove duplication and cleanup
 code in create_gpadl_header()
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Remove duplication and cleanup
 code in create_gpadl_header()
Thread-Index: AQHaRK8CIUgdftXbBEW892p4qa59RLDV0xuAgACHZeCAK/YJYA==
Date: Fri, 9 Feb 2024 15:33:24 +0000
Message-ID:
 <SN6PR02MB4157D586E6523E5747690FB0D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240111165451.269418-1-mhklinux@outlook.com>
 <de6c23b2-aa27-494a-a0ec-fe14a4289b38@web.de>
 <SN6PR02MB4157A7AC71EF769E5B88202CD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157A7AC71EF769E5B88202CD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [4smyaC2m42CdGQS6sCXSRg7xopSvXXK6]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10102:EE_
x-ms-office365-filtering-correlation-id: 5a21f7c7-598e-4d9d-178e-08dc2984746a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ELrjOPdnQ4FI0HXH3VWrkiy5GlY6SFNf1EIFdBbd0zbDkLeubwuqBIfHnpsgmeCof+TSScv4+s3OEplRXTJ3UJA+0IVS0RmrysEPMutcVfAtmCmM++XJyiOUI0j/LGM6f1byWwLTnKfIt7Tqw41c8lrBtgWqkgoVCYSSg+8pmYRFN9rLbR7/jigtJrKz2ogz0SOBIkwWc80+RUrqnIhxgCvH5e5fd49KXLz6cMJQaIhDc5CQ3G5N3eXRtzWFcvzSQ4V5chOBWO8/uD2lpM1aUm9CexoQETfl0hP4Qd3crk2mwjHb94dopxSVJnRlMmhjowd15SeXftb4WDPC5pJWlN3sZEgrVvDpT6Cb7dPGhnVTtZxW8nDGmestQ61cst5UbtE5Zdg0PwkSPDwMKGVJFBCHqXkb6HYF3AOwr+wRfnZyD21dV6+4GOLMo24wRtrRx1g7uGUkch6E4jPpq2s8bEAt/OVUPmbGDDy+5VcYnH7uuFzwAlzxBOmthzRKJEjJ6jCbp/0k4UW7CsWeD+B0ryFePIPAoHCameeRGYnUNx8iNaveIf6rmcQBsDsb8ngXuFxeN+Y3MdG93SkIGyf/EA/RutZw4ZnIkycSnlwC0LCmf5gEd/Bovg1wk7gaqIiYQg4Bsf8XwU8ZOP3Y8tJEbR9nYnMZyn2PXr6I87c6TqU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkUrODUvNXRJblBkSjlqSzNCVTJrNFpxM2RjNmt6ZkViNGVnVVZkMU5PdjE1?=
 =?utf-8?B?M1VaUDdkU25ZSEkycnVxY283QTRRVUFkRDRxbWYrQXF1Nm1XTnpHcHpqcVdw?=
 =?utf-8?B?Z0JzS21LckdrMUZyTTBodzVIOG5vMEQ5SGVtS1BnSUV3WEtGYnpOVUNlcXNH?=
 =?utf-8?B?WWt6dTdvY05PbU9RVkhxUE5abVJYUzBvR2p0endjNUkwWitZUDF3SkpRaHNt?=
 =?utf-8?B?ZXFiSFphQTdUUUYwQkdzUzdKMERDb1B0c2RlYWVWU3cxdzBCV0s5cnZmYTg3?=
 =?utf-8?B?dU1QUksxK25SOXBZK2hGajZ3cEZhQlUyalBqRDg5bEpIWmxPbmQ3dnROMjVS?=
 =?utf-8?B?cWVXS3gvMlNzOTRoVGVGRWxDVGxhcUcwaFVOQkhncE9GMks1dG91RXdtcGNY?=
 =?utf-8?B?L2FzQWFJUm1XNFBwY0FBT0JYRVJ1cUhSSmZOWXVzajR1Z0NFTkJGTm8waGlL?=
 =?utf-8?B?MW1mOHBtYysxUUZxVjdNYk81M2pxeHNQaUNIQW4rcnV3SEdxV3k1NE8rcS9J?=
 =?utf-8?B?UzFmNWYvUllhMFRmUVFCNzd5aVZ0UGdvMC8wQzdtcldjMFI4dVduVzZ4cjUv?=
 =?utf-8?B?anAzYVNYRFdDTlY0aG1TdkNlblpiV0V5SjJRV1h2a05QU0l0c09oZ0MyMUkv?=
 =?utf-8?B?WGJlaG52Y00vQXFhWE5pVDY3S09hU2pDeUl3Z3JvbjN3eFExeGVtRCs3c0ZK?=
 =?utf-8?B?SHYzdzY0QS9VWHVtMUpaUS8xYzQzWEdDamh5SzdnZWMyRElsY3M2RnVsUFRs?=
 =?utf-8?B?WUI5VWEzdTVRaG1CZDFjRUVzR2lmSzk5UUt4M3VsdUZCUGVBckxnM2NZeEhy?=
 =?utf-8?B?VVZCL0ROTC9heVRlUU9adys2YmF5MVNkdmFEb1RaV0sySmZQOTQ2U3Q3T1ZE?=
 =?utf-8?B?Sk5PcW9Uc1EvSXhOZTlYb2JXVDVsQkRZUmVLQmlwU29WeXBEQXBJcGQyMUNx?=
 =?utf-8?B?c1VITlpkaUtvbGN5RmhSQ0xaTUVmZUlWdXUzVldrTWNWeTFjYWlia294WFpF?=
 =?utf-8?B?WTFtd2o5Nm9PenBBSk5PRnN2U2RwQkYrQ1p4OXZYVzF2SUJSbjZlbnBaejdy?=
 =?utf-8?B?K2t2R2JUdGFXYU45Sm1aYWlEdXFJelJJeXFqWk5GKzkwSHBpWldVdjRPLzQv?=
 =?utf-8?B?Q2xhdGx0RmN2NEdNcW16dGxMbzdYZFdUc01jTm5OUVFUOTJUNEJGbnpHWmZm?=
 =?utf-8?B?YTVuZDc2MXFUclFZS3ZkMkZsU2E3dDdKd3gyWmR6b1prYlAxYU01UDJsa00x?=
 =?utf-8?B?VHFzTkNNendkT2tNN1NwM2hVR1lvN3oyZkJrNTRZVUdkdGNBbHQ3RUppNmFq?=
 =?utf-8?B?a3ZMWXFwbjFxYUtGSytzNGkydVNBUGV1RGRYVHRDeHAzSE9mazIrVjQvb2hv?=
 =?utf-8?B?SHhqNTVqRTY0aUROUlNWdGR2UTRZaGQzUHpsMmhXL20xZFVzbG5LWHJjWHVK?=
 =?utf-8?B?WXhpemhXS1p0Z2lORTVzTmFMZ01yREFoeEVyclhzYUZudGNNZUhwNU1JYUdm?=
 =?utf-8?B?WnRJWncrR3lDT2NvUjBxa3F3M2N0WktmWFBoNTNqU3NqeHVpSGJIS2F6QzJ0?=
 =?utf-8?B?Vk1XR2dOTVJ3eUdKZldPVjhIQlJTaGs5SkVpQjU1ajAyQ3B3RThVODc1SE1Q?=
 =?utf-8?Q?V10vAj3myCoLoTqZUbr+49WYwNjM1mqT0ke9MBdmJSPc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a21f7c7-598e-4d9d-178e-08dc2984746a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:33:24.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10102

RnJvbTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPiBTZW50OiBGcmlkYXks
IEphbnVhcnkgMTIsIDIwMjQgODoxOSBBTQ0KPiANCj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPE1h
cmt1cy5FbGZyaW5nQHdlYi5kZT4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLA0KPiAyMDI0IDEy
OjA2IEFNDQo+ID4NCj4gPiDigKYNCj4gPiA+IEVsaW1pbmF0ZSB0aGUgZHVwbGljYXRpb24gYnkg
bWFraW5nIG1pbm9yIHR3ZWFrcyB0byB0aGUgbG9naWMgYW5kDQo+ID4gPiBhc3NvY2lhdGVkIGNv
bW1lbnRzLiBXaGlsZSBoZXJlLCBzaW1wbGlmeSB0aGUgaGFuZGxpbmcgb2YgbWVtb3J5DQo+ID4g
PiBhbGxvY2F0aW9uIGVycm9ycywgYW5kIHVzZSB1bWluKCkgaW5zdGVhZCBvZiBvcGVuIGNvZGlu
ZyBpdC4NCj4gPiDigKYNCj4gPg0KPiA+IEkgZ290IHRoZSBpbXByZXNzaW9uIHRoYXQgdGhlIGFk
anVzdG1lbnQgZm9yIHRoZSBtZW50aW9uZWQgbWFjcm8NCj4gPiBzaG91bGQgYmUgcGVyZm9ybWVk
IGluIGEgc2VwYXJhdGUgdXBkYXRlIHN0ZXAgb2YgdGhlIHByZXNlbnRlZCBwYXRjaCBzZXJpZXMu
DQo+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNy9zb3VyY2UvaW5jbHVk
ZS9saW51eC9taW5tYXguaCNMOTUNCj4gPg0KPiA+IFNlZSBhbHNvOg0KPiA+IGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90
cmVlL0RvY3UNCj4gPiBtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2g9
djYuNyNuODENCj4gPg0KPiANCj4gVG8gbWUsIHRoaXMgaXMgYSBqdWRnbWVudCBjYWxsLiAgQnJl
YWtpbmcgb3V0IHRoZSB1bWluKCkgY2hhbmdlIGludG8NCj4gYSBzZXBhcmF0ZSBwYXRjaCBpcyBP
SywgYnV0IGZvciBjb25zaXN0ZW5jeSB0aGVuIEkgc2hvdWxkIHByb2JhYmx5DQo+IGJyZWFrIG91
dCB0aGUgY2hhbmdlIHRvIG1lbW9yeSBhbGxvY2F0aW9uIGVycm9ycyBpbiB0aGUgc2FtZQ0KPiB3
YXkuICAgVGhlbiB3ZSB3b3VsZCBoYXZlIHRocmVlIHBhdGNoZXMsIHBsdXMgdGhlIHBhdGNoIHRv
DQo+IHNlcGFyYXRlbHkgaGFuZGxlIHRoZSBpbmRlbnRhdGlvbiBzbyB0aGUgY2hhbmdlcyBhcmUg
cmV2aWV3YWJsZS4NCj4gVG8gbWUsIHRoYXQncyBvdmVya2lsbCBmb3IgdXBkYXRlcyB0byBhIHNp
bmdsZSBmdW5jdGlvbiB0aGF0IGhhdmUNCj4gbm8gZnVuY3Rpb25hbGl0eSBjaGFuZ2UuICBUaGUg
aW50ZW50IG9mIHRoZSBwYXRjaCBpcyB0byBjbGVhbnVwDQo+IGFuZCBzaW1wbGlmeSBhIHNpbmds
ZSAxMy15ZWFyIG9sZCBmdW5jdGlvbiwgYW5kIGl0J3MgT0sgdG8gZG8NCj4gdGhhdCBpbiBhIHNp
bmdsZSBwYXRjaCAocGx1cyB0aGUgaW5kZW50YXRpb24gcGF0Y2gpLg0KPiANCj4gV2VpIExpdSBp
cyB0aGUgbWFpbnRhaW5lciBmb3IgdGhlIEh5cGVyLVYgY29kZS4gIFdlaSAtLSBhbnkNCj4gb2Jq
ZWN0aW9ucyB0byBrZWVwaW5nIGEgc2luZ2xlIHBhdGNoIChwbHVzIHRoZSBpbmRlbnRhdGlvbiBw
YXRjaCk/DQo+IEJ1dCBJJ2xsIGJyZWFrIGl0IG91dCBpZiB0aGF0J3MgeW91ciBwcmVmZXJlbmNl
Lg0KPiANCg0KV2VpIExpdSAtLSBhbnkgaW5wdXQgb24gdGhpcz8gIFRoaXMgaXMganVzdCBhIGNs
ZWFudXAvc2ltcGxpZmljYXRpb24NCnBhdGNoLCBzbyBpdCdzIG5vdCB1cmdlbnQuDQoNCk1pY2hh
ZWwNCg==

