Return-Path: <linux-hyperv+bounces-2098-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74D8C29C7
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21881F235C4
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2BA39FFB;
	Fri, 10 May 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QhK+yB3h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19011002.outbound.protection.outlook.com [52.103.2.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1F1BDD3;
	Fri, 10 May 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365269; cv=fail; b=X3rHcRmqpYb6oPP7LvaxgsmAoQMjN9Ih6IXsLQVny4cljvd6p89gjqqcpJ4su3rmtuboD5T9syUS0xh8oTNaSBmoOl3eEZRSq1H5adZGfgfPad6Aw7JwTqEWtpxIMIZwqEQHwV0n5GvM9USgeXSAr4TnITA9FzJojpDn7MaZXIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365269; c=relaxed/simple;
	bh=izQ+3SHSAvEkkQ6kmETc3BbyN8ULfSsS8KABZkcGmiI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAnKH5poBRwt3FXC2cW1O8P7Y6s6DANYzlr9ZWTnE4+tJAAJ+dME/LtMk79t7My5J3uiczdxRK2a9cEcI12KOYHhEm+eYPpHDMJYg6PF28NoPauG/gNLZ0pQOwSUVZPiW7Ig2+mRABoibX+IhDDvRp01ylxX8n3k/4A/P76pYHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QhK+yB3h; arc=fail smtp.client-ip=52.103.2.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l23sIO48vnuz9qwJf7PB1jpvCQIKaMlpA1gLf4A188ySmJXs1Vou5j0NACXRzQoPO6kcEYLbSYqp7x990JdTquMqrcCMIIhNX1z7CLuCytQIKvhCc7CTFvXf7kQCCTCwupjMFtAqd9G0UC6JM0pstxlaAOrmOAAXhWtjmYHiwRESGxmANNSCmKnXTEcs6bbAxME23DTviJbMfO7zW4AcQxTLKGLYFGdj8mVen1B2eU30OWxC0hHYJCvtYdlXK9JdpCayyfdYFmwvKWrnzPpsHCv6oLSC7UlwcIFdJGKafpz+WvIjtltU3Ncea/1tx0svaU86HGS2/EECJfGxqxRkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izQ+3SHSAvEkkQ6kmETc3BbyN8ULfSsS8KABZkcGmiI=;
 b=MiSiqzKOsOZFF6k3D0po1bnTKrapmrDO9+gkyXrl5DexmD656rbHpfKOouT6bbmCcoS4AJXOJEzVx4FWjVeuyJkB1QgkusMRV4WfKAYicAopqV/8HKU/F5HeoFi2woNjPJwQ+miBmDgLRa5IyTF/4ZOnkSG6wUKuWzlwQzhOKx8PkYfXCpIk3ZcvKcchXfuvY6QRwHu7Ulu48NOyM0VeiqyoLgaVav2gOe1x0oJ1vl64Jak7iRtEXIogL80zsgj4nKkwY1RRremPwgC/k5ardjLQOyw69nuUQRY9BuoiSgWw14SPLWCZdeHpw0DYp6EE1i8OSmT8yCMgt3utbCY4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izQ+3SHSAvEkkQ6kmETc3BbyN8ULfSsS8KABZkcGmiI=;
 b=QhK+yB3hbF48Ps1LjAWTOk8gn/FLwEOQWxTDFptqGAof4d6hWWrgkjF/t7sXGn+s2hTCDfV8wknzCRkJ4NyCsw2xFAEkWaZINW8JWajwdMpzggwioVy+iijKWpJ1yyD7Fx/lY9AXNXN5Fz6e1A88oUhONhQzvVlJNxVgj98PHa2UWB6jh7q9dxAz6Us5yfCkb7fZz5wf7kJoGXMtLKEx5Odtt6jzg5b9/i/C8DwYkDl315CwKh5POjsH2V7QgmuKY/aI2MsLPIp/lyPJMNoQTxuOEwNc+oPFCms2ZwsehAPa9AbpU7ZoOmJX0ZFpeSXTza5oHjxfWNAIPlFZE3TAWA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9211.namprd02.prod.outlook.com (2603:10b6:610:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 18:21:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 18:21:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 2/2] Documentation: hyperv: Improve synic and interrupt
 handling description
Thread-Topic: [PATCH 2/2] Documentation: hyperv: Improve synic and interrupt
 handling description
Thread-Index: AQHaoIDgY9GGmMH6V0OmZTWGQSxNcLGQxUuAgAAF9KA=
Date: Fri, 10 May 2024 18:21:00 +0000
Message-ID:
 <SN6PR02MB415748967556A7BD7FD59738D4E72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240507131607.367571-1-mhklinux@outlook.com>
 <20240507131607.367571-2-mhklinux@outlook.com>
 <807443f4-2442-4925-becc-6eb20887acf6@linux.microsoft.com>
In-Reply-To: <807443f4-2442-4925-becc-6eb20887acf6@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [pl0YN+2DQLsPQPSefU7fv1JSW7aUMiKt]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9211:EE_
x-ms-office365-filtering-correlation-id: 6c163e5f-eef8-4aaa-7b05-08dc711df1dc
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016|56899024;
x-microsoft-antispam-message-info:
 PtuZsNV/d+TkFM9BDhMLJI4g+WetZ0dI/W/HJpJR8fI9IjmPkyZLeGrVZORNbFxnoXqWrRTwq50SWOi5x4kdFDUvPHrtiyOXghJ2KGPpDMLKFnrkUeDqRjfaSreH2/JB0HuZDnOY+nccbpFkdrT/LlNX8Yw5Yv4qhddaouvGjeBgkT23qjUxI4Gcjyf7/8Gi7uJ9OwHjuJDoPJ5laCZubo63Bv4TQhKxRJ7TUo67siuH4ZuT7iZvXvURTQIBRjc+DtUEIXLcq0HUmk831ai8/ihxTymszHFGLih7ib4ZFWNZnFLKbgND+eoooOnOy1wwH2kyHutoIdWLGtP/9pyNfJYfd9KrjCaqZVVOAUMLDcnhbKwQA0eS/iUpmmflRjp4g45VqgjQ5slU/5JQ3mHom1tibwkUI9LLrkIScXVzfIhXQcF0F5MrQBSOPPRll3ZwCFKM38EAr+oh4QvMpP9miPqVY7WwaqC4+tNyBqxh+eg6wxnqxQM9Wv55Umozgpg68NZcNt++zaLsow7jBV/u3naOomR4YpxgPv+yC319Lwrld+VvRW4ks903pbqZk2Ea
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3l4Kyt4Mzk2N0VnN0QvY1liRnhPOWtreVA1c2lqUFNIZmpTenhnVFEzOERI?=
 =?utf-8?B?K2hwZjRKWW8ydUdFSEdYYjBYdHNGeVorOVZmcFVCL1FoWXZiTjVVWG05S2d3?=
 =?utf-8?B?cG44YVF5VTlHczF2bDdyMXZsdnFFYjR0ZSsxWmZLNjhsWmU1bzRSSlFIM2VK?=
 =?utf-8?B?TTRxK1dvbU4xWXN0VDQ3UGxEekhkbWNJOEE2bUY4QmlDVHdZbC96QVhEQlkz?=
 =?utf-8?B?a3k4SklYUXJ6T1VXbzlQVzU4dkVPZlY0ZnM1eVB3RzBtZExrR1Z5MXM4SGMy?=
 =?utf-8?B?TUM4T0RtV3gzYXg1eEtJNmFNdDMwRzB2L2RzL1RYQXJ3NlZQOXp6QmY2Zjkw?=
 =?utf-8?B?QUVac3p5aTNiZjYrSHFPdGRQelpWZGp1YlV1Q2hYaC9mZVVvNTVHc1lLTWc5?=
 =?utf-8?B?REpWVjFvZUJsbFNGcytjVTB2cFRIdk82R2prbU03UHQrU09MUmlPby8xMTNX?=
 =?utf-8?B?aHpNdjF3MzEwWGZuRTVlSmdKQnY2WUVkdWdjZ2VLTXdjcUtDNXczYU0yMHBn?=
 =?utf-8?B?Mm9wTU9HWWRjeUNLN2Q1YVlyV3ViM2J3KzMrN1JMMzZKY09aVTdVcFJhSlNW?=
 =?utf-8?B?WkI4dkcxZk1haXFtR3MwZHIyN3dlTE1ZMXYvUlV3WENXTEJmdFpGK0lPOXVx?=
 =?utf-8?B?SUJoS3o1MVN2V0NuUi9LQk9SNGpnMlFJZnFnZEZuWGtBZXlyR21rS2NxakZ3?=
 =?utf-8?B?UVI5THdhZXJHRFhGQkNCMCs1YjMyT21ZSXlHdHZseGpHYyt0bTZMbnZNanZ2?=
 =?utf-8?B?RHVtc01EeFdJbFVuVFQrTUM1cmd4TGV6dXVRZW9vdG5xY0VnUVdSQnhSdDBL?=
 =?utf-8?B?NE1Xc2lJWEUwS3p0QmZSa1NtMitCdnQxU1ROT0dmVklGSWxCRUk3c0czSXRl?=
 =?utf-8?B?ZnpzZ2lEYlFqejQzU0h6SGdJRU5SSTRYUC9IUFNLRnpWQTN4NjBmWW1EVEV0?=
 =?utf-8?B?aHNBS3Y1Y3E2VCtFbEduRVlqQ0E0V2xlZk96Sjcycm56WEVMbTZpcU4zdE4x?=
 =?utf-8?B?WDBzWG92dkVIQlJNcmM2K0I1TUM1c2F3TkduK0E3YVJaeElTalp2UFpscTBh?=
 =?utf-8?B?S1BteW42UVQrajkvUGsxcE5PdEpLbnZsNGpTOFJGWUdZc0dSOWsxeWJja2tM?=
 =?utf-8?B?YURPcjJiRThpblk1aiszbUNkNDEwQWQ5TzJRSVlCK0FXMk1KdkxDdFQzcERO?=
 =?utf-8?B?ZGlSUGgxOEVJL3V2MVVCaW5jbTd6S2ZKeXA4OHlBS3N5RWtBcjVtY1E1LzNW?=
 =?utf-8?B?ajI0ZTA5aWdWaFZMWVR3dkZhWmhsSlM5NVY5YWF5QzVpMkJ3U1RGQ2dBTWs2?=
 =?utf-8?B?alBqd2lvSEUyczFFRTJEOU00ZHVMNGhPOEQwVlNncHN2cmxmWDJGRmQyRkJz?=
 =?utf-8?B?emZaTTBWQis3T2pzODNqRWY4Sk8rejAyTzBCWkNGU3JnOVIyL2pyWEJ3Vlgy?=
 =?utf-8?B?V2J0SXpLOUVDU0ZJVi8vU3ZjRnpwR2lKOElrdWVuTVNUdFNIUjVlSnNBWXEx?=
 =?utf-8?B?dGQ5ZnJpQWY5WEtBOU1Zb2s2alZZb0Q4akJzQm5XQksxdTJZbDA3bDU3T24v?=
 =?utf-8?B?NFNEVWtPWXI1cm50WmlUNG43U2Q0TlpKelFyWDNzS3crU2dqOUVTajhOWHcz?=
 =?utf-8?Q?61mG9X03oJVxnb6ndqIBV8iqHHy6xxS1XA+UrikZSaKg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c163e5f-eef8-4aaa-7b05-08dc711df1dc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 18:21:00.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9211

RnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFoYXJpaGFAbGludXgubWljcm9zb2Z0LmNvbT4gU2Vu
dDogRnJpZGF5LCBNYXkgMTAsIDIwMjQgMTA6NTUgQU0NCj4gDQo+IE9uIDUvNy8yMDI0IDY6MTYg
QU0sIG1oa2VsbGV5NThAZ21haWwuY29tIHdyb3RlOg0KPiA+IEZyb206IE1pY2hhZWwgS2VsbGV5
IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gPg0KPiA+IEN1cnJlbnQgZG9jdW1lbnRhdGlvbiBk
b2VzIG5vdCBkZXNjcmliZSBob3cgTGludXggaGFuZGxlcyB0aGUgc3ludGhldGljDQo+ID4gaW50
ZXJydXB0IGNvbnRyb2xsZXIgKHN5bmljKSB0aGF0IEh5cGVyLVYgcHJvdmlkZXMgdG8gZ3Vlc3Qg
Vk1zLCBub3IgaG93DQo+ID4gVk1CdXMgb3IgdGltZXIgaW50ZXJydXB0cyBhcmUgaGFuZGxlZC4g
QWRkIHRleHQgZGVzY3JpYmluZyB0aGUgc3luaWMgYW5kDQo+ID4gcmVvcmdhbml6ZSBleGlzdGlu
ZyB0ZXh0IHRvIG1ha2UgdGhpcyBtb3JlIGNsZWFyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1
bWVudGF0aW9uL3ZpcnQvaHlwZXJ2L2Nsb2Nrcy5yc3QgfCAyMSArKysrKy0tLQ0KPiA+ICBEb2N1
bWVudGF0aW9uL3ZpcnQvaHlwZXJ2L3ZtYnVzLnJzdCAgfCA3OSArKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMzQgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2h5cGVy
di9jbG9ja3MucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0L2h5cGVydi9jbG9ja3MucnN0DQo+ID4g
aW5kZXggYTU2ZjQ4MzdkNDQzLi45MTliYjkyZDZkOWQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi92aXJ0L2h5cGVydi9jbG9ja3MucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi92
aXJ0L2h5cGVydi9jbG9ja3MucnN0DQo+ID4gQEAgLTYyLDEyICs2MiwyMSBAQCBzaGFyZWQgcGFn
ZSB3aXRoIHNjYWxlIGFuZCBvZmZzZXQgdmFsdWVzIGludG8gdXNlciBzcGFjZS4gVXNlcg0KPiA+
ICBzcGFjZSBjb2RlIHBlcmZvcm1zIHRoZSBzYW1lIGFsZ29yaXRobSBvZiByZWFkaW5nIHRoZSBU
U0MgYW5kDQo+ID4gIGFwcGx5aW5nIHRoZSBzY2FsZSBhbmQgb2Zmc2V0IHRvIGdldCB0aGUgY29u
c3RhbnQgMTAgTUh6IGNsb2NrLg0KPiA+DQo+ID4gLUxpbnV4IGNsb2NrZXZlbnRzIGFyZSBiYXNl
ZCBvbiBIeXBlci1WIHN5bnRoZXRpYyB0aW1lciAwLiBXaGlsZQ0KPiA+IC1IeXBlci1WIG9mZmVy
cyA0IHN5bnRoZXRpYyB0aW1lcnMgZm9yIGVhY2ggQ1BVLCBMaW51eCBvbmx5IHVzZXMNCj4gPiAt
dGltZXIgMC4gSW50ZXJydXB0cyBmcm9tIHN0aW1lcjAgYXJlIHJlY29yZGVkIG9uIHRoZSAiSFZT
IiBsaW5lIGluDQo+ID4gLS9wcm9jL2ludGVycnVwdHMuICBDbG9ja2V2ZW50cyBiYXNlZCBvbiB0
aGUgdmlydHVhbGl6ZWQgUElUIGFuZA0KPiA+IC1sb2NhbCBBUElDIHRpbWVyIGFsc28gd29yaywg
YnV0IHRoZSBIeXBlci1WIHN5bnRoZXRpYyB0aW1lciBpcw0KPiA+IC1wcmVmZXJyZWQuDQo+ID4g
K0xpbnV4IGNsb2NrZXZlbnRzIGFyZSBiYXNlZCBvbiBIeXBlci1WIHN5bnRoZXRpYyB0aW1lciAw
IChzdGltZXIwKS4NCj4gPiArV2hpbGUgSHlwZXItViBvZmZlcnMgNCBzeW50aGV0aWMgdGltZXJz
IGZvciBlYWNoIENQVSwgTGludXggb25seSB1c2VzDQo+ID4gK3RpbWVyIDAuIEluIG9sZGVyIHZl
cnNpb25zIG9mIEh5cGVyLVYsIGFuIGludGVycnVwdCBmcm9tIHN0aW1lcjANCj4gPiArcmVzdWx0
cyBpbiBhIFZNQnVzIGNvbnRyb2wgbWVzc2FnZSB0aGF0IGlzIGRlbXVsdGlwbGV4ZWQgYnkNCj4g
PiArdm1idXNfaXNyKCkgYXMgZGVzY3JpYmVkIGluIHRoZSBWTUJ1cyBkb2N1bWVudGF0aW9uLg0K
PiANCj4gSXMgVk1CdXMgZG9jdW1lbnRhdGlvbiBoZXJlIHJlZmVycmluZyB0byBEb2N1bWVudGF0
aW9uL3ZpcnQvaHlwZXJ2L3ZtYnVzLnJzdD8NCj4gSWYgc28sIGNvdWxkIHlvdSBwbGVhc2UgYWRk
IGludGVybmFsIGxpbmtzIHdpdGggOnJlZjo/IFNlZSBmb3IgZXhhbXBsZSBpbg0KPiBEb2N1bWVu
dGF0aW9uL3Byb2Nlc3MvMS5JbnRyby5yc3QuIA0KDQpZb3UgYXJlIHJpZ2h0LiAgVGhlIHJlZmVy
ZW5jZSBpcyB0byB2bWJ1cy5yc3QuICBJJ2xsIG1ha2UgaXQgYSBsaW5rLCB0aG91Z2ggdGhlDQpn
dWlkZWxpbmVzIHVuZGVyICJDcm9zcy1yZWZlcmVuY2luZyIgaW4gIlVzaW5nIFNwaGlueCBmb3Ig
a2VybmVsIGRvY3VtZW50YXRpb24iDQpwcmVmZXIganVzdCB1c2luZyB0aGUgcGF0aCB0byB0aGUg
ZG9jdW1lbnRhdGlvbiBmaWxlIHdpdGggbm8gc3BlY2lhbCBhbm5vdGF0aW9uDQpsaWtlIDpkb2M6
IG9yIDpyZWY6LiAgU28gaXQgd291bGQganVzdCBiZSAiRG9jdW1lbnRhdGlvbi92aXJ0L2h5cGVy
di92bWJ1cy5yc3QiLg0KSSdsbCB0cnkgdGhpcyBhbmQgbWFrZSBzdXJlIGl0IGNvbWVzIG91dCBy
aWdodC4NCg0KTWljaGFlbA0KDQo+IElmIHJlZmVycmluZyB0byBNaWNyb3NvZnQgZG9jdW1lbnRh
dGlvbiwgcGxlYXNlDQo+IHByb3ZpZGUgYSBwZXJtYWxpbmsuIFBsZWFzZSBkbyBhbHNvIGxvb2sg
Zm9yIG90aGVyIG9wcG9ydHVuaXRpZXMgdG8gY3Jvc3MtbGluayB3aXRoaW4NCj4gRG9jdW1lbnRh
dGlvbiBvciB0byBleHRlcm5hbCByZXNvdXJjZXMuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBpbXBy
b3ZlbWVudHMhDQo+IA0KPiBFYXN3YXINCg0K

