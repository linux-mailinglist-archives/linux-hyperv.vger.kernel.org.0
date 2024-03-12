Return-Path: <linux-hyperv+bounces-1727-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D6878E74
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 07:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583DFB21476
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4C4DA0F;
	Tue, 12 Mar 2024 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fuYo0GsZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2083.outbound.protection.outlook.com [40.92.18.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C7405FC;
	Tue, 12 Mar 2024 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223674; cv=fail; b=QbwhvhK35tlzxdBDAzY/ZTjh1lprl9uzFcPIlP9a8s8yPZoM92fSHyK3WmdSAmDuxVBU9QV+2naY/Y3eeVYdS4wq2qigq7whGn2ThPj1haYMple2OCd7C33ooBrWO1bk/uA5e+R2OK6tVUlNMZLnF8nulrCSv2GS21kGpTVVLyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223674; c=relaxed/simple;
	bh=3IQxA2FH38Q3RWY1YVpF7Ty8Wb9kUPshlRT0TpnF75I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r47S79xs5voK00twRXCkHJFgmoctx+2R+F79wmRO1RCZnBNoWpuTad1rJJFaaQkvNGpz49Zry7Zza6klC0bhaEtoyoRZtjh3ELSxr53Eeb7Uj9eJcCW9SF5VxMTQuyBHwhk4UP1g/oSTSzujHB6TDYcEXzV11LmntQnQbXsJiNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fuYo0GsZ; arc=fail smtp.client-ip=40.92.18.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlNzCMmeJGH20WhnWJK9fe55hdKmEJMZo6u5EJARReuXiahghrT6Vv1xrt/3lK+qNKiW65FpF1jiHXm4SN66fdMqGUGuQYk1IKU4AHkbfhQXsai9qrnChX9uNC7uMftIF4msxw1ybiW+F4aKyomPTXZyOLbGySroWrNBPuElShRtWwoUPkiEo0wk5oqlHsiJgoobP0OAa7JUvRBxXvWLUdg/nNuR4IvatIcTNXF1fC7qBSgSVoiGNEkI5qmw+oU2LnRcR03TNJ+GjAFS6JAft3P8Tn0CtCQlL8iwsoapiyYu/24ZYF4U099eyuYeSlv394apVzqtqHRrK7T0DaLC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IQxA2FH38Q3RWY1YVpF7Ty8Wb9kUPshlRT0TpnF75I=;
 b=bL/9/4bsuLvqesfJ3iXJTPIwlLQ61EYzTlko3U7v1sQUlU2fENq1E+4ESlyAUTc/KGQBoNPr/HWesd8g2dMv70jTwRNZzFaJ/x8v0buSSU9bxQSdJ8nJKLUHQ7dulqBvxPz2iPJeIvvlT7ixfmmDIPT4xiohB73KC7pOSdAmq83RRasAjQydhdxtt7h3w+o3qnqTB2LRiCsqtd3FGqfXsKRKcLpWjoigF+/96G0wiM0cJdGonhcyX2wRJrQNid9p1+0C5p6L2vJr00lL58hv4F6+ygNgLrbfoDlXXEWMwo/2LIFeEllS+35+N6V3vung4EtRgYOv0IK83Gyt5qxrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IQxA2FH38Q3RWY1YVpF7Ty8Wb9kUPshlRT0TpnF75I=;
 b=fuYo0GsZfyTt3B1aEKJXoKjBZjG86TxqDZH0ODkvXa9A3W3E+rJvF9xurfRiHcAORLzw1xwTKlRYLc2yAYX3U/n9A5P4DYP9oT238Gs273WLBnx/1ZQXzfO/+H9lpB2uWPsNkhzPbBB0srjiWAQe8iB3TcFkw+51MIvPfpottk045XQQ4OR9x8coQD3bhXJsyNcXNQEWTRuSD+zKl4atC6UGOxqBEbjX+MOzSguSKLyna0oDVHeZRmGkAtLWXx4PRF064XaCakB/F9NqwHcdUMdEWYo0pNt1XkeNz2hjbsgmGMN5iubQeAwGAIwkP5G+F/lFFbAZchwOqLP4KApY9w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9461.namprd02.prod.outlook.com (2603:10b6:208:401::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 06:07:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 06:07:48 +0000
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
Thread-Index: AQHac8+ebtKw/xenqkGKdXOMVR+SlLEzjW4AgAAMTZA=
Date: Tue, 12 Mar 2024 06:07:46 +0000
Message-ID:
 <SN6PR02MB415742AEEE7F1389D80B6E51D42B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240311161558.1310-1-mhklinux@outlook.com>
 <20240311161558.1310-3-mhklinux@outlook.com>
 <13581af9-e5f0-41ca-939f-33948b2133e7@linux.intel.com>
In-Reply-To: <13581af9-e5f0-41ca-939f-33948b2133e7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [FSNduf+QrrP0ZygE4QZfICyBr7jX1Ld7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9461:EE_
x-ms-office365-filtering-correlation-id: 9823d31b-0c30-4171-9c19-08dc425abd14
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aCpLklwdMGu21HqQyOdbhp72bVtEWd+ZZQIe+fNg+S1x2NCXg0HaQauu+qa6IkoYV8HvWLWBPqj6f7MP2o6FKzZzv4hIQkV/k3niJQaA1U5dlPbzmQBGlIPq9BTChhVzy4Siw2lnByzU2zb85DGu9OGfTT9Gyi7HE/pe+JOzOlpjvIcJ4RJ/Tbn1mc8VPQVbM0I4C8lSQB1G9o3zt0aNeI6sXr1VP+wcrKEEQ/D+qfB6k4ei8a8rgl5nGCu07r4ohU7UhDGUGyuZl7lql9bCNobO+wLeRBp4U/5PIIGWFge3MdWKvpoyc1p2cNivfDE4y+M+Iaybz4j+oSbzQH/l9lQZaE1PcdAP9a/hJ4MT0ePmkyNnGBBxcWadh0Wg1sVFob8vL94/d5JEIC6+y3fpMF4qvm7G2jqoprejOQhUHWzlExr9PVpFth9owmfyn4Y5ofvvIvLyGDUvIWMEvpVp9E/IqugSYgbA6Wxq5HfHVOmAmDZI+bLNJTbvHxuIlfXj4ou/YZJFsdDj3eIFmCmeXJnMMmxiL5vIXoG5hCVgNBDRRY76xd6l4QSJoa1jzD3x
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VCtSZk83MTU5R3NJY3BpREZPbDhXRWlBNG9IbmJIamxyVTNvaFVUa1hCbk1x?=
 =?utf-8?B?bU9kQlFiN2NZZ3lrS0NpSkhZQVUrSDRwb0oxUHVJTDhaVTRJQWVuK1I4OERo?=
 =?utf-8?B?NmlDL3UvaFpKS0VnTTBHU080cnRCRDRTclJSVVNVemx5Z2t4dEZCcDdBb1Ny?=
 =?utf-8?B?dktyVk1neTh5Q0k5WC9mNE80bmhMUHpBL3ZCZm15djdRczY5Uy8xTHVScW4x?=
 =?utf-8?B?blh1OGtQUXgxTXV2NXhzSTQwWnBzYjMzSWhqVkUwOER1Ri9CRDBzSldyeHY1?=
 =?utf-8?B?azVnenV4b01WU3VzSzJUWXZwcDlzU1FDQW1WNEFiVEJoeGlqVFNZblZYSXZF?=
 =?utf-8?B?RUwranpqQkpkZVJSMENBem9PeVpBNk5EbnJIU2VUMUR6dTBtUlB6NUo2QmFw?=
 =?utf-8?B?T0Y3WldkNkMxNnJpU1JmVmR3bHZKL1lwdy8vcXlrWXRZZHVsblRzWFlFQ29n?=
 =?utf-8?B?QUNJMmZUekpQRlhxYVo5UlpTS0N2akMzY3NlRGNyRTRxVVBmKzVQU1RNbFRr?=
 =?utf-8?B?VHVyVlZQblV1L3lMWGs3N1hVZ3NjTUJGVmx2cUZEUmE2c0ljRCt6SGVIa2gw?=
 =?utf-8?B?Zy9NTTdsQ29qOUNhSkQ1OXVWdHRFbW1yTW5aRE1qYk1zV002Wk5XclhsUU9j?=
 =?utf-8?B?NTAxV1U2RzVwcFl3OTJGWDhMdEIwWnE1cDlBMng4M2VZbW1KTmRPbXM2UzhI?=
 =?utf-8?B?VmFCWGl6ZHNpbmllMzd3enVad1BvQjZocjE2K1JVcThXVUJmUmtTdU5JMlJ5?=
 =?utf-8?B?aGxRdEJmOUw5R2RIL1YvVzc2a3RrcEQ2dzhVZzhrVGxrY21UMnQxNm9OdCsy?=
 =?utf-8?B?cmpjTlpnbnJxbGMzNmZQdDVCMzduNVFYYnFRQldtWFR5MWNLZmNMVTdCY2Vr?=
 =?utf-8?B?YXB1SVdDb1NUNVpnUGQxZTQ1cnk3dGk0S0dLUUZ5MWFRcWpIaVBReW96ajFB?=
 =?utf-8?B?TzZYR1YxVVFsWVBPdVZrencybkd2TVl1Q0R4SVZDTGpZTGpLdWR6SmszK3ND?=
 =?utf-8?B?bC9UUm1JLzJuTER4cXNRQWtVMzFOSHB3dUlheFZNTnR6bk1GbnJVUkJmM2h0?=
 =?utf-8?B?Z0laQVNxcm5kNFg0QXdxY3QyYlk2d0l0UGw4dHgzUUFVaWZIVXNJemo1Ymov?=
 =?utf-8?B?TG5ISW9lVlF0N0pIUlFiYm5HbnZ0OVpFclVYbjczT2t1S3YrSnl1Y0locnM2?=
 =?utf-8?B?OEdsYllNQlhNaE55bWs5aDJhek94bGJGK201Y0lPWVJBUmlVOGNrNnlGcUhk?=
 =?utf-8?B?WG9BY0h4ai90bklDVmU2VzRjUWs4cWluS2FuV1lLRVloMFI5cG5ucWJybUZm?=
 =?utf-8?B?ZHdkNkJWVWtjcEJuK2dQTEJEbEFpcWcxSTdQdU9UaTFEZk41anBZL1JEVURT?=
 =?utf-8?B?VTdSb0xKODNFQ3Ezb3BiZmQxMzkyOFVYNlYwQnFEcTc2TXZLY25WZmR0N2du?=
 =?utf-8?B?M1VwN0FmQVRTWVZYWXJoRFNUSUpKZjVhMVJKSncwWVZmM0tGYjJyMjN2MWFj?=
 =?utf-8?B?TlhGM3pic0lZTGhZRm05a3FkZDN4ZkVELzcyR0Nyd1pCOU1McWlzbGVHUjUz?=
 =?utf-8?B?SXFLOWZWa0FvUDhrdC8vb2IrTnczSjB0dTkrRzc0MnAwSlZEN1V2TENsUUhI?=
 =?utf-8?B?Tmd4V2p4RTFpMk93R1lvUUdWcmdvK3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9823d31b-0c30-4171-9c19-08dc425abd14
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 06:07:46.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9461

RnJvbTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3
YW15QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IE9uIDMvMTEvMjQgOToxNSBBTSwgbWhrZWxsZXk1
OEBnbWFpbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdl
Y29tYmVAaW50ZWwuY29tPg0KPiA+DQo+ID4gSW4gQ29DbyBWTXMgaXQgaXMgcG9zc2libGUgZm9y
IHRoZSB1bnRydXN0ZWQgaG9zdCB0byBjYXVzZQ0KPiA+IHNldF9tZW1vcnlfZW5jcnlwdGVkKCkg
b3Igc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSB0byBmYWlsIHN1Y2ggdGhhdCBhbg0KPiA+IGVycm9y
IGlzIHJldHVybmVkIGFuZCB0aGUgcmVzdWx0aW5nIG1lbW9yeSBpcyBzaGFyZWQuIENhbGxlcnMg
bmVlZCB0bw0KPiA+IHRha2UgY2FyZSB0byBoYW5kbGUgdGhlc2UgZXJyb3JzIHRvIGF2b2lkIHJl
dHVybmluZyBkZWNyeXB0ZWQgKHNoYXJlZCkNCj4gPiBtZW1vcnkgdG8gdGhlIHBhZ2UgYWxsb2Nh
dG9yLCB3aGljaCBjb3VsZCBsZWFkIHRvIGZ1bmN0aW9uYWwgb3Igc2VjdXJpdHkNCj4gPiBpc3N1
ZXMuDQo+ID4NCj4gPiBJbiBvcmRlciB0byBtYWtlIHN1cmUgY2FsbGVycyBvZiB2bWJ1c19lc3Rh
Ymxpc2hfZ3BhZGwoKSBhbmQNCj4gPiB2bWJ1c190ZWFyZG93bl9ncGFkbCgpIGRvbid0IHJldHVy
biBkZWNyeXB0ZWQvc2hhcmVkIHBhZ2VzIHRvDQo+ID4gYWxsb2NhdG9ycywgYWRkIGEgZmllbGQg
aW4gc3RydWN0IHZtYnVzX2dwYWRsIHRvIGtlZXAgdHJhY2sgb2YgdGhlDQo+ID4gZGVjcnlwdGlv
biBzdGF0dXMgb2YgdGhlIGJ1ZmZlcnMuIFRoaXMgd2lsbCBhbGxvdyB0aGUgY2FsbGVycyB0bw0K
PiA+IGtub3cgaWYgdGhleSBzaG91bGQgZnJlZSBvciBsZWFrIHRoZSBwYWdlcy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaHYvY2hhbm5lbC5jICAgfCAyNSArKysrKysrKysr
KysrKysrKysrKystLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaHlwZXJ2LmggfCAgMSArDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L2NoYW5uZWwuYyBiL2RyaXZlcnMvaHYvY2hhbm5l
bC5jDQo+ID4gaW5kZXggNTZmN2UwNmM2NzNlLi5iYjVhYmRjZGExOGYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9odi9jaGFubmVsLmMNCj4gPiArKysgYi9kcml2ZXJzL2h2L2NoYW5uZWwuYw0K
PiA+IEBAIC00NzIsOSArNDcyLDE4IEBAIHN0YXRpYyBpbnQgX192bWJ1c19lc3RhYmxpc2hfZ3Bh
ZGwoc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwsDQo+ID4gIAkJKGF0b21pY19pbmNfcmV0
dXJuKCZ2bWJ1c19jb25uZWN0aW9uLm5leHRfZ3BhZGxfaGFuZGxlKSAtIDEpOw0KPiA+DQo+ID4g
IAlyZXQgPSBjcmVhdGVfZ3BhZGxfaGVhZGVyKHR5cGUsIGtidWZmZXIsIHNpemUsIHNlbmRfb2Zm
c2V0LCAmbXNnaW5mbyk7DQo+ID4gLQlpZiAocmV0KQ0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJ
CWdwYWRsLT5kZWNyeXB0ZWQgPSBmYWxzZTsNCj4gDQo+IFdoeSBub3Qgc2V0IGl0IGJ5IGRlZmF1
bHQgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZnVuY3Rpb24/DQoNCkkgY29uc2lkZXJlZCBkb2lu
ZyB0aGF0LiAgQnV0IGl0J3MgYW4gZXh0cmEgc3RlcCB0byBleGVjdXRlIGluIHRoZSBub3JtYWwN
CnBhdGgsIGJlY2F1c2UgYSBjb3VwbGUgb2YgbGluZXMgYmVsb3cgaXQgaXMgYWx3YXlzIHNldCB0
byAidHJ1ZSIuICBCdXQNCkkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBwcmVmZXJlbmNlIGVpdGhlciB3
YXkuDQoNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+DQo+ID4gKwkvKg0KPiA+ICsJ
ICogU2V0IHRoZSAiZGVjcnlwdGVkIiBmbGFnIHRvIHRydWUgZm9yIHRoZSBzZXRfbWVtb3J5X2Rl
Y3J5cHRlZCgpDQo+ID4gKwkgKiBzdWNjZXNzIGNhc2UuIEluIHRoZSBmYWlsdXJlIGNhc2UsIHRo
ZSBlbmNyeXB0aW9uIHN0YXRlIG9mIHRoZQ0KPiA+ICsJICogbWVtb3J5IGlzIHVua25vd24uIExl
YXZlICJkZWNyeXB0ZWQiIGFzIHRydWUgdG8gZW5zdXJlIHRoZQ0KPiA+ICsJICogbWVtb3J5IHdp
bGwgYmUgbGVha2VkIGluc3RlYWQgb2YgZ29pbmcgYmFjayBvbiB0aGUgZnJlZSBsaXN0Lg0KPiA+
ICsJICovDQo+ID4gKwlncGFkbC0+ZGVjcnlwdGVkID0gdHJ1ZTsNCj4gPiAgCXJldCA9IHNldF9t
ZW1vcnlfZGVjcnlwdGVkKCh1bnNpZ25lZCBsb25nKWtidWZmZXIsDQo+ID4gIAkJCQkgICBQRk5f
VVAoc2l6ZSkpOw0KPiA+ICAJaWYgKHJldCkgew0KPiA+IEBAIC01NjMsOSArNTcyLDE1IEBAIHN0
YXRpYyBpbnQgX192bWJ1c19lc3RhYmxpc2hfZ3BhZGwoc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNo
YW5uZWwsDQo+ID4NCj4gPiAgCWtmcmVlKG1zZ2luZm8pOw0KPiA+DQo+ID4gLQlpZiAocmV0KQ0K
PiA+IC0JCXNldF9tZW1vcnlfZW5jcnlwdGVkKCh1bnNpZ25lZCBsb25nKWtidWZmZXIsDQo+ID4g
LQkJCQkgICAgIFBGTl9VUChzaXplKSk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJLyoNCj4g
PiArCQkgKiBJZiBzZXRfbWVtb3J5X2VuY3J5cHRlZCgpIGZhaWxzLCB0aGUgZGVjcnlwdGVkIGZs
YWcgaXMNCj4gPiArCQkgKiBsZWZ0IGFzIHRydWUgc28gdGhlIG1lbW9yeSBpcyBsZWFrZWQgaW5z
dGVhZCBvZiBiZWluZw0KPiA+ICsJCSAqIHB1dCBiYWNrIG9uIHRoZSBmcmVlIGxpc3QuDQo+ID4g
KwkJICovDQo+ID4gKwkJaWYgKCFzZXRfbWVtb3J5X2VuY3J5cHRlZCgodW5zaWduZWQgbG9uZylr
YnVmZmVyLCBQRk5fVVAoc2l6ZSkpKQ0KPiA+ICsJCQlncGFkbC0+ZGVjcnlwdGVkID0gZmFsc2U7
DQo+ID4gKwl9DQo+ID4NCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiBAQCAtODg2LDYg
KzkwMSw4IEBAIGludCB2bWJ1c190ZWFyZG93bl9ncGFkbChzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAq
Y2hhbm5lbCwgc3RydWN0IHZtYnVzX2dwYWRsICpncGFkDQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJ
CXByX3dhcm4oIkZhaWwgdG8gc2V0IG1lbSBob3N0IHZpc2liaWxpdHkgaW4gR1BBREwgdGVhcmRv
d24gJWQuXG4iLCByZXQpOw0KPiANCj4gV2lsbCB0aGlzIGJlIGNhbGxlZCBvbmx5IGlmIHZtYnVz
X2VzdGFibGlzaF9ncGFkKCkgaXMgc3VjY2Vzc2Z1bD8gSWYgbm90LCB5b3UNCj4gbWlnaHQgd2Fu
dCB0byBza2lwIHNldF9tZW1vcnlfZW5jcnlwdGVkKCkgY2FsbCBmb3IgZGVjcnlwdGVkID0gZmFs
c2UgY2FzZS4NCg0KSXQncyBvbmx5IGNhbGxlZCBpZiB2bWJ1c19lc3RhYmxpc2hfZ3BhZGwoKSBp
cyBzdWNjZXNzZnVsLiAgSSBhZ3JlZQ0Kd2UgZG9uJ3Qgd2FudCB0byBjYWxsIHNldF9tZW1vcnlf
ZW5jcnlwdGVkKCkgaWYgdGhlDQpzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHdhc24ndCBleGVjdXRl
ZCBvciBpdCBmYWlsZWQuICBCdXQgDQp2bWJ1c190ZWFyZG93bl9ncGFkbCgpIGlzIG5ldmVyIGNh
bGxlZCB3aXRoIGRlY3J5cHRlZCA9IGZhbHNlLg0KDQo+IA0KPiA+DQo+ID4gKwlncGFkbC0+ZGVj
cnlwdGVkID0gcmV0Ow0KPiA+ICsNCj4gDQo+IElNTywgeW91IGNhbiBzZXQgaXQgdG8gZmFsc2Ug
YnkgZGVmYXVsdC4gQW55IHdheSB3aXRoIG5vbiB6ZXJvIHJldHVybiwgdXNlcg0KPiBrbm93IGFi
b3V0IHRoZSBkZWNyeXB0aW9uIGZhaWx1cmUuDQoNCkkgZG9u4oCZdCBhZ3JlZSwgYnV0IGZlZWwg
ZnJlZSB0byBleHBsYWluIGZ1cnRoZXIgaWYgbXkgdGhpbmtpbmcgaXMNCmZsYXdlZC4NCg0KSWYg
c2V0X21lbW9yeV9lbmNyeXB0ZWQoKSBmYWlscywgd2Ugd2FudCBncGFkbC0+ZGVjcnlwdGVkID0g
dHJ1ZS4NClllcywgdGhlIGNhbGxlciBjYW4gc2VlIHRoYXQgdm1idXNfdGVhcmRvd25fZ3BhZGwo
KSBmYWlsZWQsDQpidXQgdGhlcmUncyBhbHNvIGEgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZSwg
c28gdGhlIGNhbGxlcg0Kd291bGQgaGF2ZSB0byBkaXN0aW5ndWlzaCBlcnJvciBjb2Rlcy4gIEFu
ZCB0aGUgY2FsbGVyIGlzbid0DQpuZWNlc3NhcmlseSB3aGVyZSB0aGUgbWVtb3J5IGlzIGZyZWVk
IChvciBsZWFrZWQpLiAgV2UNCndhbnQgdGhlIGRlY3J5cHRlZCBmbGFnIHRvIGJlIGNvcnJlY3Qg
c28gdGhlIGNvZGUgdGhhdA0KZXZlbnR1YWxseSBmcmVlcyB0aGUgbWVtb3J5IGNhbiBkZWNpZGUg
dG8gbGVhayBpbnN0ZWFkIG9mDQpmcmVlaW5nLg0KDQpNaWNoYWVsDQoNCj4gDQo+ID4gIAlyZXR1
cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHZtYnVzX3RlYXJkb3duX2dw
YWRsKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9oeXBlcnYuaCBiL2luY2x1ZGUv
bGludXgvaHlwZXJ2LmgNCj4gPiBpbmRleCAyYjAwZmFmOTgwMTcuLjViYWMxMzZjMjY4YyAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2h5cGVydi5oDQo+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC9oeXBlcnYuaA0KPiA+IEBAIC04MTIsNiArODEyLDcgQEAgc3RydWN0IHZtYnVzX2dwYWRs
IHsNCj4gPiAgCXUzMiBncGFkbF9oYW5kbGU7DQo+ID4gIAl1MzIgc2l6ZTsNCj4gPiAgCXZvaWQg
KmJ1ZmZlcjsNCj4gPiArCWJvb2wgZGVjcnlwdGVkOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVj
dCB2bWJ1c19jaGFubmVsIHsNCj4gDQo+IC0tDQo+IFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15
DQo+IExpbnV4IEtlcm5lbCBEZXZlbG9wZXINCg0K

