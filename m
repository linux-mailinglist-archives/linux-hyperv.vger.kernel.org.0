Return-Path: <linux-hyperv+bounces-1409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE2E829E51
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED04A1F22BCC
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAD4CB52;
	Wed, 10 Jan 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uQfNYZDU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2091.outbound.protection.outlook.com [40.92.21.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698644CB3D;
	Wed, 10 Jan 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUFUw315exNGq78w12tZCpFqONJJ6tL0kRe7dxFztlZc0tajP9zHgrnSDbbdxnsViOyFiFglUwkl9cNcPSnYDucX8eNE9UJmZ0wHSJe7ql1ZV5AkIESQp0WqMHRsatQVhMp/ZDI2eSpaQfsY+YEhhMj/2V3dsXBH1sTLOs29RZLMnvjlBpji8KOBDXeSAv1IDKwzPETK5Yn+5//lGAFcz9NkYxuq2HNYMncAL8+rJtbrDTqlX/huIGFPgrNBR7kSn7qPxVHJkG0LA9rGv63Jq0nt5KC7w49LtXHrpFcniXh/AHADrSW8Pcs2kGFGP1BT/yOC/JU9Zf3LpHJXcrWNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP6a+xpVQw6fyStOMUd122OR6vNWQaJTlxCLGJez4h4=;
 b=C92xhBeSfjSjZyS8dcaqErD/MOwIT9Y9bZhYcsbF4Fte6dNOtVnkgb8jAYyaX/r7QNgSSHnn99AmH5YAKWdZmgwbprgmJYWoeDFHFyOyCY4djKzTFdh+XyAf/pU3763dZR2Yon+y/tiVLtPu59iVvEwQulEsSF/cv4FQC7L/CwgMyADc9CbD9Y7GFMvZ2H61pQvlLbTOfCZsbsYrB/A4goWfd8V961Jels5hrYl+rHLFueQqPSeUqEsSqsoMRA65ZnhxTNqZBLhomESgE9t+P/8gaaa+7yf44WvfmHA5W27C1allRUBA53mF5zrj0VjmcbiiMqu9yD4slPuGFBLe1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP6a+xpVQw6fyStOMUd122OR6vNWQaJTlxCLGJez4h4=;
 b=uQfNYZDU82FzMz39eNIfeOFvtHICFNK9JW2LAttCabHp00DjYgZQD/YP8IKZALUI/+G1oDtx/JD8M+s2KOdsm5TTJLxw/3vYm8kRSCVtetk4TunIOVXHIDe8WtHvBEubbV7gAvvk+ffwXjQmL9Ouz8fSpmCqEbq4p0nS2K/U3p1+b4oFqKQjNozjppk0Jl0m+bex/pUMl3P5c4fgZa6nvi8Jsv2UPE2xUy+PXATU/vuDov72YNhiZzTXrnpeSN34OK3wUnpZhL6idmCK045wOrFxhxAQM3IPtE+DQqirsVZHoxO1XWRXPd8UPz2mV1uFdLqEGrJUKNWj80nYiEubAg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7736.namprd02.prod.outlook.com (2603:10b6:510:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 16:15:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 16:15:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Topic: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Index: AQHaQ7PyvvrIb8tUYUye7rRKlkvVrLDTNj6g
Date: Wed, 10 Jan 2024 16:15:42 +0000
Message-ID:
 <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
In-Reply-To: <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ul+7Mzryzylt4SiypKoCcXlODSGWHi6q]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7736:EE_
x-ms-office365-filtering-correlation-id: 811d6e7f-47bd-40ba-7fdf-08dc11f764d3
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /NqB4rrd8EB+eqo2zhPtRzMA1GBho8ro+IM7mgSgkXQMniJAkBg+sOAhNY55ayxMRFRvC2Yzz8Ph91oprQYL6NgZtwPILjnXW6g0tNr7w2DMIEryQIraWUlu9DPq7ovkgwHOr1yamu5NVPNsqUZcxmdNwTlZAnddOw3bIpmFSZfXQQfhCHlEu+30HeucHwiYkc+7vOjQq1qQCs/YqhsqZEq13bLFacjy1YDlzS57z6nXL/S8HZvQhqSbENBx/Xo5RdZ+JuES1osKCePJmrFAIEWiZ8liKCcYoCPLYDL4xKTGYqazT8UqnA5CBs2v2NReNW1BHsn71wuxodaFI/SPWgizy265Vm+PFvDDR3uNnGr0sDRe54paK4ShrrwfuS3IcQJ0sAkncX1P8aOmPPZp0M6v5cVlmO+tT1w6aNYH0o+bMzyrrhUk0EpP2M8yODVhv6vwdyrQ+vE1PqREK3jKXsTCEVPqEjStdfS6zL777RO0QpC9pNDijocaXYpCRBFQokDdu64sbVSKvLN8E7xSZMakDd/S0sAZU3XV04D1TJMzV6GhbcH29o17kKS9ntQtXMBrRP78OCUB3H0HV6UlUGT8lPWHq9z209INvvwB9/8=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk1MK0RObUVZV0tRWDVxTk1ZdE1wSkN4RnI5WkpzVkY2RytDL05VQ0poRVV3?=
 =?utf-8?B?K2xHTGFITlk4QTRTTFJCVjlqRUpFNjFMRld5RDNoeGNZZFdFbU9HTVk3aWtW?=
 =?utf-8?B?NmxvUVZkUUVIVGJHZUxQUXZIbE5XWWVZODBneUFQejhMb3FPNFZGZzFRczND?=
 =?utf-8?B?YVBJSGdrT2xhaUpmNjVYSHgvZms4VHhqSE8zbDFBUWcvT2I4dVQ3K2JxWFBR?=
 =?utf-8?B?SEJSV3lLNFY2b1JIb0UvaXJ5TnpIQUx3SjY3RitTSUtOdXB6azdnYXM5WEd3?=
 =?utf-8?B?R2dpZXhqdHlBMUtmRjlpK281RmRPRjhreWVKS3lubHI4M05hQW5wVmR1ZzhY?=
 =?utf-8?B?aWc0TGUydVVIQVRlbm9SdVpFQTY3L3NHemNPZk1OczR2dEIyb21zSEpSSmFa?=
 =?utf-8?B?ZmQvcm9mY1FpdmZ4c2hHM29LZ0F0S1JKdDYyTW1wN1UzaStZSWtGQzB6YUUv?=
 =?utf-8?B?TzNmUHNwWTVxd1JLcG80NjZlN1lxNXZiak5FaSsybVp1ZVI0VWkvblVmNE0v?=
 =?utf-8?B?WmY4SFRNQjNQQTFaZS9vWE05cC9HVjZxekJpaGFLdjBMWU4wVUtOV2hzNENN?=
 =?utf-8?B?aHM0WnRORFczQUViaVUvVThuWHI4QVdTVkYyN052N2FQOEtnNi93bGN5Mmcr?=
 =?utf-8?B?R1ZLeHIrUXdPMTNYM004NVl2bFErNjlrcGFWUUd3YUJOUDByZCtnWDB2Ym9P?=
 =?utf-8?B?N0lsTWJrWHQrckFTdUpMWHkvcTRPdVJwMjI3VG5nKzhRbkVwaFUvUEI2Y2Ra?=
 =?utf-8?B?S2NJT0pIaWRNem5hZ016OHJSMnhFbXBtQXArRDFZQW1aQWJqTFkrUUZleVRZ?=
 =?utf-8?B?OTJJSCt0S1A2YVZvVHlraGx0b2ZNSlhDUUpNL2R3SGo5WVVOMmQyS1pkNkth?=
 =?utf-8?B?L0dqTEdUVWpReHBJZnczeEQyK0NXT1VBZWVlcXhjWTVTLzlleUZrQi9GdWVE?=
 =?utf-8?B?ODFNUHptdXJRSnNiOTZSMjFDei8yajdzTjQ3SWY3ZElBWlRuMmt1SG1vOFMr?=
 =?utf-8?B?SUJ3WmQ4VHR6bUYvWktUWkxDWndBd2w0TDR0VHdUeWk4Z3k3VGdseWZOVjRh?=
 =?utf-8?B?LzQ1K0NMRkx5WS92YnFTWEpIVnRwOW1ucEJNZVRvYTZ0dU92TWtKVEg0TEc1?=
 =?utf-8?B?T1B0VEljYVRNMDVla2g5VlJaTzhyTVZDN0o3MjhXSWFUUGxLWHlVeEV3TFZ0?=
 =?utf-8?B?WnBHMWhQb21rVFVEd3FiVEZMbGFVNWpTekhYWXc3dFZpZ3lqQ3QycnNHZG4y?=
 =?utf-8?B?eVdJa3VIclFRV0lDNjdoV2VIUS83T2RzWXIzL2VUbUJ1UEZGZkZ5ZVpheTVF?=
 =?utf-8?B?bzlQYVdoem1IL2trQjhIdXlyTnFaNUVocmxlTUlGWUJMSi93MGNZMVloa1o3?=
 =?utf-8?B?N05xUTFWeElPcmU4OEFRZStqWkgyOVdqMFNoSlkxZCtOcXA2TUt5b0VwZGtR?=
 =?utf-8?B?SGhlTHRFTmthTUVSTXFqald4SmtJb3hUcEF1QlBnTHRnT1BJeERueE9Qcnll?=
 =?utf-8?B?MmIzZHkrMlBBSVVzZVRUeG44bFlyMWo5Ni9GT3JBblBXaVk0M0lEaSthNE93?=
 =?utf-8?B?TlJ6MGFsb3RreGFaS2M5S3dleU5YTjUwU0tKYloxamd0cUdTSXBkbmlDaW9H?=
 =?utf-8?B?NUppd2F0Zkk4dWI4UVNHMXlhWmZOSEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 811d6e7f-47bd-40ba-7fdf-08dc11f764d3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 16:15:42.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7736

RnJvbTogTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gU2VudDogV2VkbmVz
ZGF5LCBKYW51YXJ5IDEwLCAyMDI0IDI6NTggQU0NCj4gDQo+ID4+IFRoZSBrZnJlZSgpIGZ1bmN0
aW9uIHdhcyBjYWxsZWQgaW4gdHdvIGNhc2VzIGJ5DQo+ID4+IHRoZSBjcmVhdGVfZ3BhZGxfaGVh
ZGVyKCkgZnVuY3Rpb24gZHVyaW5nIGVycm9yIGhhbmRsaW5nDQo+ID4+IGV2ZW4gaWYgdGhlIHBh
c3NlZCB2YXJpYWJsZSBjb250YWluZWQgYSBudWxsIHBvaW50ZXIuDQo+ID4+IFRoaXMgaXNzdWUg
d2FzIGRldGVjdGVkIGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLg0KPiA+Pg0KPiA+
PiBUaHVzIHVzZSBhbm90aGVyIGxhYmVsLg0KPiA+DQo+ID4gSW50ZXJlc3RpbmdseSwgdGhlcmUn
cyBhIHRoaXJkIGNhc2UgaW4gdGhpcyBmdW5jdGlvbiB3aGVyZQ0KPiA+ICJnb3RvIG5vbWVtIiBp
cyBkb25lLCBhbmQgaW4gdGhpcyBjYXNlLCBtc2dib2R5IGlzIE5VTEwuDQo+ID4gRG9lcyBDb2Nj
aW5lbGxlIG5vdCBjb21wbGFpbiBhYm91dCB0aGF0IGNhc2UgYXMgd2VsbD8NCj4gPg0KPiA+IEFz
IEknbSBzdXJlIHlvdSBrbm93LCB0aGUgY29kZSBpcyBjb3JyZWN0IGFzIGlzLCBiZWNhdXNlIGtm
cmVlKCkNCj4gPiBjaGVja3MgZm9yIGEgTlVMTCBhcmd1bWVudC4gIFNvIHRoaXMgaXMgcmVhbGx5
IGFuIGV4ZXJjaXNlIGluDQo+ID4gbWFraW5nIENvY2NpbmVsbGUgaGFwcHkuICBUbyBtZSwgdGhl
IGFkZGl0aW9uYWwgbGFiZWwgaXMNCj4gPiBpbmNyZW1lbnRhbCBjb21wbGV4aXR5IGZvciBzb21l
b25lIHRvIGRlYWwgd2l0aCB3aGVuDQo+ID4gcmVhZGluZyB0aGUgY29kZSBhdCBzb21lIHRpbWUg
aW4gdGhlIGZ1dHVyZS4gIFNvIEknZCB2b3RlIGZvcg0KPiA+IGxlYXZpbmcgdGhlIGNvZGUgYXMg
aXMuICBCdXQgaXQncyBub3QgYSBiaWcgZGVhbCBlaXRoZXIgd2F5LiAgSQ0KPiA+IGNhbiBzZWUg
eW91J3ZlIGJlZW4gY2xlYW5pbmcgdXAgYSBsb3Qgb2YgQ29jY2luZWxsZS1yZXBvcnRlZA0KPiA+
IGlzc3VlcyBhY3Jvc3MgdGhlIGtlcm5lbCwgbW9zdCBvZiB3aGljaCByZXN1bHQgaW4gY29kZQ0K
PiA+IHNpbXBsaWZpY2F0aW9ucy4gIElmIGxlYXZpbmcgdGhpcyB1bmNoYW5nZWQgY2F1c2VzIHlv
dSBwcm9ibGVtcywNCj4gPiB0aGVuIEkgd29uJ3Qgb2JqZWN0ICh0aG91Z2ggcGVyaGFwcyB0aGF0
IDNyZCAiZ290byBub21lbSINCj4gPiBzaG91bGQgYmUgZGVhbHQgd2l0aCBhcyB3ZWxsIGZvciBj
b25zaXN0ZW5jeSkuDQo+IA0KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRoZSBjbGFyaWZpY2F0
aW9uIGFwcHJvYWNoDQo+IOKAnFJlY29uc2lkZXJpbmcga2ZyZWUoKSBjYWxscyBmb3IgbnVsbCBw
b2ludGVycyAod2l0aCBTbVBMKeKAnT8NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvY29jY2kv
NmNiY2Y2NDAtNTVlNS0yZjExLTRhMDktNzE2ZmU2ODFjMGQyQHdlYi5kZS8NCj4gaHR0cHM6Ly9z
eW1wYS5pbnJpYS5mci9zeW1wYS9hcmMvY29jY2kvMjAyMy0wMy9tc2cwMDA5Ni5odG1sDQo+IA0K
DQpJdCBvY2N1cnJlZCB0byBtZSBvdmVybmlnaHQgdGhhdCB0aGUgZXhpc3RpbmcgZXJyb3IgaGFu
ZGxpbmcNCmluIGNyZWF0ZV9ncGFkbF9oZWFkZXIoKSBpcyB1bm5lY2Vzc2FyaWx5IGNvbXBsaWNh
dGVkLiAgSGVyZSdzDQphbiBhcHByb2FjaCB0aGF0IEkgdGhpbmsgd291bGQgZml4IHdoYXQgeW91
IGhhdmUgZmxhZ2dlZCwgYW5kDQp3b3VsZCByZWR1Y2UgY29tcGxleGl0eSBpbnN0ZWFkIG9mIGlu
Y3JlYXNpbmcgaXQuICBUaG91Z2h0cz8NCg0KTWljaGFlbA0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9odi9jaGFubmVsLmMgYi9kcml2ZXJzL2h2L2NoYW5uZWwuYw0KaW5kZXggNTZmN2UwNmM2NzNl
Li40NGIxZDVjOGRmZWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2h2L2NoYW5uZWwuYw0KKysrIGIv
ZHJpdmVycy9odi9jaGFubmVsLmMNCkBAIC0zMzYsNyArMzM2LDcgQEAgc3RhdGljIGludCBjcmVh
dGVfZ3BhZGxfaGVhZGVyKGVudW0gaHZfZ3BhZGxfdHlwZSB0eXBlLCB2b2lkICprYnVmZmVyLA0K
IAkJCSAgc2l6ZW9mKHN0cnVjdCBncGFfcmFuZ2UpICsgcGZuY291bnQgKiBzaXplb2YodTY0KTsN
CiAJCW1zZ2hlYWRlciA9ICBremFsbG9jKG1zZ3NpemUsIEdGUF9LRVJORUwpOw0KIAkJaWYgKCFt
c2doZWFkZXIpDQotCQkJZ290byBub21lbTsNCisJCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJCUlO
SVRfTElTVF9IRUFEKCZtc2doZWFkZXItPnN1Ym1zZ2xpc3QpOw0KIAkJbXNnaGVhZGVyLT5tc2dz
aXplID0gbXNnc2l6ZTsNCkBAIC0zODYsOCArMzg2LDggQEAgc3RhdGljIGludCBjcmVhdGVfZ3Bh
ZGxfaGVhZGVyKGVudW0gaHZfZ3BhZGxfdHlwZSB0eXBlLCB2b2lkICprYnVmZmVyLA0KIAkJCQkJ
bGlzdF9kZWwoJnBvcy0+bXNnbGlzdGVudHJ5KTsNCiAJCQkJCWtmcmVlKHBvcyk7DQogCQkJCX0N
Ci0NCi0JCQkJZ290byBub21lbTsNCisJCQkJa2ZyZWUobXNnaGVhZGVyKTsNCisJCQkJcmV0dXJu
IC1FTk9NRU07DQogCQkJfQ0KIA0KIAkJCW1zZ2JvZHktPm1zZ3NpemUgPSBtc2dzaXplOw0KQEAg
LTQxNiw4ICs0MTYsOCBAQCBzdGF0aWMgaW50IGNyZWF0ZV9ncGFkbF9oZWFkZXIoZW51bSBodl9n
cGFkbF90eXBlIHR5cGUsIHZvaWQgKmtidWZmZXIsDQogCQkJICBzaXplb2Yoc3RydWN0IHZtYnVz
X2NoYW5uZWxfZ3BhZGxfaGVhZGVyKSArDQogCQkJICBzaXplb2Yoc3RydWN0IGdwYV9yYW5nZSkg
KyBwYWdlY291bnQgKiBzaXplb2YodTY0KTsNCiAJCW1zZ2hlYWRlciA9IGt6YWxsb2MobXNnc2l6
ZSwgR0ZQX0tFUk5FTCk7DQotCQlpZiAobXNnaGVhZGVyID09IE5VTEwpDQotCQkJZ290byBub21l
bTsNCisJCWlmICghbXNnaGVhZGVyKQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KIA0KIAkJSU5JVF9M
SVNUX0hFQUQoJm1zZ2hlYWRlci0+c3VibXNnbGlzdCk7DQogCQltc2doZWFkZXItPm1zZ3NpemUg
PSBtc2dzaXplOw0KQEAgLTQzNywxMCArNDM3LDYgQEAgc3RhdGljIGludCBjcmVhdGVfZ3BhZGxf
aGVhZGVyKGVudW0gaHZfZ3BhZGxfdHlwZSB0eXBlLCB2b2lkICprYnVmZmVyLA0KIAl9DQogDQog
CXJldHVybiAwOw0KLW5vbWVtOg0KLQlrZnJlZShtc2doZWFkZXIpOw0KLQlrZnJlZShtc2dib2R5
KTsNCi0JcmV0dXJuIC1FTk9NRU07DQogfQ0KIA0KIC8qDQoNCg0KDQoNCg0K

