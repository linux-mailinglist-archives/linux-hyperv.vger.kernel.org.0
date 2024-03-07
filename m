Return-Path: <linux-hyperv+bounces-1682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8462A875842
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 21:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C5C1C22B7D
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1E1386AA;
	Thu,  7 Mar 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FZMBn0Ka"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2088.outbound.protection.outlook.com [40.92.23.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687FA1386B3;
	Thu,  7 Mar 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843133; cv=fail; b=utoMK4WjyL8NOYK/f2zeQ6am+yy87ecFJUSz5hboH6ridBph46vCJuafHzKR0B4rX/zGwtbpVw9kbfsb4olhTD2XMP2PYuKui7NMVybvzCCIdZTt0YaM8rCWAt/jLyXpV5l1DjKWycP8sA5azGr/Xjm6k1Hy/bz6cgcJVriwb8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843133; c=relaxed/simple;
	bh=QTZxk4eQhR/JLyIptnOmjVSqT8xoMlY95TnEQQ7vZk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VuXreEPemaBcR4IAD7yybUhzXRjjPoajjRu9zR/oiMk4lei6jKDbee03QQUiJaOM6Tm7WLALa173T3rRTuRoWDwl/WeQuxM+6HjYs9TVOUYxiZN8RbnHR3btv774tDx3D5QFAp9tRG3RyaFpOJ6B6dIpgIAaeSTIjDqR8OLdUsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FZMBn0Ka; arc=fail smtp.client-ip=40.92.23.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMiFo2ABHlZc9zmtUH5eSif1XHOZv4rXuRHRUvVdGFsie7M/DRJ1AhMWDo6ew0+/u7zSXdynefgJb1yemrxOobrRXTxspoDm91OdmzT1q5b1yY0fk9h5/eYYIh7gDyc9RWgeA0LOqPVVS9E66xwmXmX6wyYytTg/nompXif9Vbu0+vXNKuJb95u0sOi/nRcBeshXrcx6wFxtF2FxZBQb7fcXVE4gXLX3+Uk/GDy8oUeVSSdG2wLksQsWpd7eTV0XTHFAHW84ew5ZYh0075b4DzLMlyIe3xCRJBgkDtFNfAC6VHOjXL79gXfG0lUuqoWpagSnmpxDLdh472qsCYW5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTZxk4eQhR/JLyIptnOmjVSqT8xoMlY95TnEQQ7vZk4=;
 b=ZqaJZmmYJWLQQv/6IqbT6HsCm64gi9391NpTQW6S+rtN5wAVBd+XGw0aEx0YmMU8zvlqH3l7GbtHaTG4GuMmbbaW9rW9ARjg3Cb1ZFdpy1X0wxYsjYx9rESPquJFp4Gkl/cPVeH2YB4lTMjBEpebo1r70KkEfLLocxHL8BAixzJkiMm9NkIMBR/REuAw39w+4muvTyombXMFKq+8PDnZd3h5V0DJeSd+DgdcmtHC9cp2Qnzbrsv62i5bBK1xwj+hmvjXXHQd6e6DtuQS2d3oGFkoAXNEgnPGh6XdWxYd4lrW07TUIGdtX1bzy5BCfB6FYyhd3Wh5+lIkgSrSG4Innw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTZxk4eQhR/JLyIptnOmjVSqT8xoMlY95TnEQQ7vZk4=;
 b=FZMBn0Kat90TnX4Xxqr4BKR6rq1PV+UyUHNoSo9jb5RlrE0pqbrFzVbauVYVQ9x85aij0E2Zf7uXg3Ndv2SvYMq0GT441BhT7BOdKRlCt/bENaEjuVnUnzm5vM3ZbLH+4SeLqh6UJkSJt/aIQjBQpcTch5emQO3DDc9eOuX1b6zY+WE+z6YFcG+YZWsde9jQt3tnNqzDTiea8NtJJ1PY45zLSZ7YFXTwREalKzrzittBw6E0JBEGxXsebSFB37RFgW/RkBCguypJKxeq7QzeWOE5bDzdz3qCSNB1gFK9NXddilSKbFnpToq+kSCGwsKQnQt3KFCT5ccrlJzOC72DGQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB9038.namprd02.prod.outlook.com (2603:10b6:930:32::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 20:25:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 20:25:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Topic: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Index: AQHaZTRXjdPXYbhP4karQ0dDTiSBNbEjNf9QgAlhAACAACVYgIAAFEVA
Date: Thu, 7 Mar 2024 20:25:28 +0000
Message-ID:
 <SN6PR02MB415722AEC8C7BD3F7423A1B8D4202@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
	 <SN6PR02MB41575BD90488B63426A5CAB4D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <SN6PR02MB4157AFF080839DB55294F5E9D4202@SN6PR02MB4157.namprd02.prod.outlook.com>
 <9e12c7139ab5b9b39c73a4069493d8d826b21702.camel@intel.com>
In-Reply-To: <9e12c7139ab5b9b39c73a4069493d8d826b21702.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [McUEOodZswrn6bd4DZ3+95w+tr2ZiFKF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB9038:EE_
x-ms-office365-filtering-correlation-id: 60cac0d2-8118-45e5-5e92-08dc3ee4bade
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j0JTCEhkwLqFBMCj+1p2ttC/eZ4Xyb4bf+bPP5m99zSclBO/ZEjUoIKdCv5jYFH0rq1moJZYoy9Y0j6IYWkcTJp0YYE+9itIcCfoDo8RqFS4R2cW2nSLVf8N7ErMPBwbZEN2SgtULseDNTrjbDeBYM0pwYCzLntwt1my8tDpyPFoF4DW6UNq/YwDmLm82MJS4wCyWms0mWvjZPhfnSKUPijAQyOUNjidt2zPJHOkyFL+BZKWSQJfjlQTwtKOFXnZPFqc9fCxgBgTRuB/aD4HzB9QFBgtsJSGIuHeMrgsUzC8DLBebxs7//lyeJr586rPEGY/VT3X0yHrfv8R0QcoDanVRoJCms89IFPzJiav4cUZA6ru9inbzCR9S12V69E7G2YT/gqlUBAbNnZRAPW4K0gqiAAelotnqSBPSm9V2+jzR9ARHlpfCXrAov24y/IZt1AjqZT9yVJiE/4B3YwI2FnSkz2ya1Xy5ZPT7g6dBR1Sr7hElCS4WTrzrAl+zBQnQrnQ5CnHdb9pyBrS4aZs+srj57bpF0zn8mkuVwqeUn53ULrqHFyzJLtmMXLQR8mz
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWg5bmxOYTZ6YmI2a3VmcHFIbGFxMWhUZ0wvZ0xJM3kzb2pMVDJEOFU0ZEdV?=
 =?utf-8?B?cldIeEZwQ25LR0hoM1VLME82UVRtRzFVblRCLzZEQkVFOVM5UWpvR2pOZ3BI?=
 =?utf-8?B?b1k3aFZXZzZKZTJxVkJ1SHFreWZtQjBoU0oxd0ZvWUVYTUNMdVRjcm8rL2NP?=
 =?utf-8?B?cjByV2tHZHZQemlUZ2pGSmJtV2x3UjlPZGxmWVBRU2ZTbWF2ZlhleFZWMk4w?=
 =?utf-8?B?d0RiN3JjeENPaTExazl4VUNOVEthZ2lRN1NRN21wWW9XNjJBRHZpWEFWN1hH?=
 =?utf-8?B?YjQzSTZEODVYUXlPR2FLU3djWmxad2dVMzBOQlhibFBKanU0N3hDdHZIdTlu?=
 =?utf-8?B?U1dDSjNxYU1PT2hmeDJ2T2t0Z1VsS0pKTWNyWlprS0Nod2hjYndERHhkOUlN?=
 =?utf-8?B?U3RXVzArL2JlRmp3Vm9mUnlBNjhtcEU2cTQ4SC9LZTROeG95ZDl4Y0NuMXlM?=
 =?utf-8?B?U0lOWGV3RnlIZWduQW1wTTJzUmJPWGZndS9VOSt4a0NadkJHVXBSTEUzcHZn?=
 =?utf-8?B?QTM5dmc4Z0pndHRDc0xPUUQySTNYOVQvb1huUlA2L20wcmFOU00rL0JaQjMz?=
 =?utf-8?B?cmtoa1hvWnVnUEMxWG93cTZ6a25TOHRnWmpXWU5ReHFqdDEwUXdJcW1VbUEw?=
 =?utf-8?B?WHY1MWUvRjM3NGJjcUsxbnhFek4xR0JGd04wWk5FWStVbWxlMk52MytYTjl3?=
 =?utf-8?B?eEVtcno1NEV4RnF6VCt3ZWtyUHBnRjlBNU5DUGplNlpZWmIva3VaSk1CUUEx?=
 =?utf-8?B?aG5jY01JRDhGV3lMMlVQZXBvYngweXIwWTZWQzJtRW9SWnhDTFowV1ZUR1Ir?=
 =?utf-8?B?ZGhNVjc3M08vYzJtOWVvV1p6TUo1akFvK0xsbmQzMGZlYjNjRzc0WXdFN1l3?=
 =?utf-8?B?RmtvUDdXbmw3bDJLUXhwemlueExBMFdwZmVHVStmZ2lidlVSczRleFcyYkt5?=
 =?utf-8?B?bjBEcFZDcWxra3l1RW1Wd0ZaK3JBWXNPRTRDd05CL2J5ZGhQS0NvNjFPa0RL?=
 =?utf-8?B?V1NQd0FHbEV5NGNQOE1jTFJQU09kdGlBQVAxUURDUFJpTTh2d0o1R1lKUWJJ?=
 =?utf-8?B?M2Qxc3p6bkdLRk1hT01jdGIzcDV3Rk1LQTZmdmgrR2FxQ1dHWHRuVUVvVis3?=
 =?utf-8?B?WTVXLzh1eUFMKzFkR0hsK3F6TXVodm9ydUVodDRpVUZDMk5nTFQyNENaUUVk?=
 =?utf-8?B?Q3Z3N2QxRGN4eW84OVRRTG9SSWF6OUR3VWNKOU0rUStsQ01GTlNQNUh1Rzc5?=
 =?utf-8?B?NXVxQWdHdHZZUzZEV1RxRnRqenpPYlFjSkx6RU9NanNCYSt4WkJuT3UrVzVp?=
 =?utf-8?B?aXp5UktMUG5rOURmeWlrYWVrUEVTNGdManM4OTN5SFIreFU4OG5oSDJBWGpa?=
 =?utf-8?B?SFpCM09SMDlyZVhWM1hXK3hJci9wbzgzMkgySmhOcGtGdmlJL2hCUklHeDVv?=
 =?utf-8?B?elFHV3ZMU25rOGtIUGtoaC9rbU0vQ1laVWc2WXRTb1hrbS9xSXlYOXFBdXRm?=
 =?utf-8?B?Z1RyejFWcVpaT3lPbzdYWTJmTTdhQkpBb0k2cVBvc1ZIaFZaQmg2MWtlWkp3?=
 =?utf-8?B?QURNd0FSOVJBbjZGWDkyTjRVMTN6SDh5bC9EeU9uNnlLMHJPS2xnc0hrOWdq?=
 =?utf-8?B?OEZBUmhzNHMvdWJYLzFkQXdxaXFrd3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cac0d2-8118-45e5-5e92-08dc3ee4bade
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 20:25:28.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9038

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBUaHVyc2RheSwgTWFyY2ggNywgMjAyNCAxMToxMiBBTQ0KPiANCj4gT24gVGh1LCAyMDI0LTAz
LTA3IGF0IDE3OjExICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBVc2luZyB5b3Vy
IHBhdGNoZXMgcGx1cyB0aGUgY2hhbmdlcyBpbiBteSBjb21tZW50cywgSSd2ZQ0KPiA+IGRvbmUg
bW9zdCBvZiB0aGUgdGVzdGluZyBkZXNjcmliZWQgYWJvdmUuIFRoZSBub3JtYWwNCj4gPiBwYXRo
cyB3b3JrLCBhbmQgd2hlbiBJIGhhY2sgc2V0X21lbW9yeV9lbmNyeXB0ZWQoKQ0KPiA+IHRvIGZh
aWwsIHRoZSBlcnJvciBwYXRocyBjb3JyZWN0bHkgZGlkIG5vdCBmcmVlIHRoZSBtZW1vcnkuDQo+
ID4gSSBjaGVja2VkIGJvdGggdGhlIHJpbmcgYnVmZmVyIG1lbW9yeSBhbmQgdGhlIGFkZGl0aW9u
YWwNCj4gPiB2bWFsbG9jIG1lbW9yeSBhbGxvY2F0ZWQgYnkgdGhlIG5ldHZzYyBkcml2ZXIgYW5k
IHRoZSB1aW8NCj4gPiBkcml2ZXIuwqAgVGhlIG1lbW9yeSBzdGF0dXMgY2FuIGJlIGNoZWNrZWQg
YWZ0ZXItdGhlLWZhY3QNCj4gPiB2aWEgL3Byb2Mvdm1tYWxsb2NpbmZvIGFuZCAvcHJvYy9idWRk
eWluZm8gc2luY2UgdGhlc2UNCj4gPiBhcmUgbW9zdGx5IGxhcmdlIGFsbG9jYXRpb25zLiBBcyBl
eHBlY3RlZCwgdGhlIGRyaXZlcnMNCj4gPiBvdXRwdXQgdGhlaXIgb3duIGVycm9yIG1lc3NhZ2Vz
IGFmdGVyIHRoZSBmYWlsdXJlcyB0bw0KPiA+IHRlYXJkb3duIHRoZSBHUEFETHMuDQo+ID4NCj4g
PiBJIGRpZCBub3QgdGVzdCB0aGUgdm1idXNfZGlzY29ubmVjdCgpIHBhdGggc2luY2UgdGhhdA0K
PiA+IGVmZmVjdGl2ZWx5IGtpbGxzIHRoZSBWTS4NCj4gPg0KPiA+IEkgdGVzdGVkIGluIGEgbm9y
bWFsIFZNLCBhbmQgaW4gYW4gU0VWLVNOUCBWTS7CoCBJIGRpZG4ndA0KPiA+IHNwZWNpZmljYWxs
eSB0ZXN0IGluIGEgVERYIFZNLCBidXQgZ2l2ZW4gdGhhdCBIeXBlci1WIENvQ28NCj4gPiBndWVz
dHMgcnVuIHdpdGggYSBwYXJhdmlzb3IsIHRoZSBndWVzdCBzZWVzIHRoZSBzYW1lIHRoaW5nDQo+
ID4gZWl0aGVyIHdheS4NCj4gDQo+IFRoYW5rcyBNaWNoYWVsISBIb3cgd291bGQgeW91IGZlZWwg
YWJvdXQgcmVwb3N0aW5nIHRoZSBwYXRjaGVzIHdpdGgNCj4geW91ciBjaGFuZ2VzIGFkZGVkPyBJ
IHRoaW5rIHlvdSBoYXZlIGEgdmVyeSBnb29kIGhhbmRsZSBvbiB0aGUgcGFydCBvZg0KPiB0aGUg
cHJvYmxlbSBJIHVuZGVyc3RhbmQsIGFuZCBhZGRpdGlvbmFsbHkgbXVjaCBtb3JlIGZhbWlsaWFy
aXR5IHdpdGgNCj4gdGhlc2UgZHJpdmVycy4NCg0KWWVzLCBJIGNhbiBzdWJtaXQgYSBuZXcgdmVy
c2lvbi4NCg0KTWljaGFlbA0K

