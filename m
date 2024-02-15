Return-Path: <linux-hyperv+bounces-1542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC5F855B9F
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 08:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031151F2356D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E379476;
	Thu, 15 Feb 2024 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aGRfddQW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2011.outbound.protection.outlook.com [40.92.19.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB2D53F;
	Thu, 15 Feb 2024 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982002; cv=fail; b=f5HvSVf6wmrZdGTKgMxzgr867ENqG7w6bhUCGzs6XqFuIfmBXvYxJTmPSBR+73Hq0bDKuIvEs21HY4AKoxlMiOKfd4fA0BGGCfmk7qK74ERihE8oAMw+LZjczEsEyiOIOFrLCQD8NUWL2Em8iAlYlPe2/ME9/h8sfbbTbLUrG/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982002; c=relaxed/simple;
	bh=NVnuZMdVI7fzI+r1dfmBqpdNO/r50aCt5cvbXhrON2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WQejZdTcl3tGdrOA2fMdHk2oyj031EZmmljAd+TtV3nCF4uPRY5MjrlpUNG9rZg6b2dNx/NCnh6kTHd2wBd4Q5dfYm2eE0wYWNjklYs/lW6Epm0/Bht4pnULqEIzS/18rJ2kPUWKH49GAy1ZuSTmSYz21n0eKssXhccy2jlgUA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aGRfddQW; arc=fail smtp.client-ip=40.92.19.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzDZ1zLVMAuSIiGNYvydsDYc4xPj4Gh3tSIhpgWALXmWNMXZLoWT9RA47nisCPMQqWS6XWbM9bGLi8/ftbJqTEIx0XklAA2vyO+D53YpbWIUe/b74y8AHUo2rAcgF+38BtpSMB7XWkUUw5bclCLZp7xvH1RlxdtT/CUB5xrJB6aprgp3AwwQPqyU3IafU9Uxe2H57P5uLHKe1WakIp5eNb5Y9eW2WJLwY+xZK4rCydjPf1mDB17C7reMuLMa3mrXCzkvhmbonouVJs2oHqF4srnZ3wXBFWTdDUKoAcYs1Hl6EjUiw45EtsO95W/9JOvKCGmfOCzu/25sp5ac7XgrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVnuZMdVI7fzI+r1dfmBqpdNO/r50aCt5cvbXhrON2o=;
 b=gzpC4Bsabnes1Bbw4j8XyAdRVWQ6uSdPPsV6SzUAoIACfDRjqSwTh5KQLlTzI/YF4QNYqGNq6cUxIP6VBOp4x3/T6YCxy8AAFIAkXp5LgoW9T8MFmrlsW2Z6tg/cxOprb+DGyX+URVgl03bn6A9aAK/preRCqcT8FyH9F5jnEFwjZAwABzwjXBOtQwzQMmQfuMwRay8G4U4DZrSku5yFjSoRVvEfB6VDRXnTSYCXuwwQ/Y7NuvqxXBbrasYAGFuY2uwdC2apFS9aGBVvdjM3RSNZy6qC0pDd6RRYz3zB2eVMt7HIdnFO0NoDrud0Yzn3kWYbSe9MW4a7HwqbsVnJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVnuZMdVI7fzI+r1dfmBqpdNO/r50aCt5cvbXhrON2o=;
 b=aGRfddQWacDXuOkcKQMExW0qkx/y7vJ0/MH6hTUO5mRDF8UrIm81KfGo9w9GaBAdHOwfe3+DaPnP3GesLi/AXJ7jp7QdmEAw8Y+WDrScQuwOCLWAgqTLTryp7DN2/EZO88e+l3Iyd85uu+8c2XgPrFzhdCxgkk7d+Z+v0E3NPer1GoY4qf5VwXHl+Sq6aOK9mxHKXoqA6i18J5tLtXBCRTpE1xkmXlmD4yquq5WpKM1PidLJIUndY8eB+gaZNkvDPKpnm4BVBtsQxAtWbM2Rl3GsKpMxnPgzqzScs1N+oOSibigRagtTdqpof73QyCh+VXZT9CprHvTjypKcWofrIw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6538.namprd02.prod.outlook.com (2603:10b6:610:61::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 07:26:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7270.033; Thu, 15 Feb 2024
 07:26:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] PCI: hv: Fix ring buffer size calculation
Thread-Topic: [PATCH 1/1] PCI: hv: Fix ring buffer size calculation
Thread-Index: AQHaXkSvfpXGuIokukeQNIcM2o6BfrEH1mqAgAMs3BA=
Date: Thu, 15 Feb 2024 07:26:38 +0000
Message-ID:
 <SN6PR02MB415746AAB8228DD1E10B5D41D44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240213061910.782060-1-mhklinux@outlook.com>
 <12efa165-b4bb-40ae-ac38-deedceba7b27@linux.intel.com>
In-Reply-To: <12efa165-b4bb-40ae-ac38-deedceba7b27@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [I6cNffqgDjso1IaAv7OE/1ADjudGhrQe]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6538:EE_
x-ms-office365-filtering-correlation-id: a69dcaa1-1820-4a6b-a854-08dc2df77282
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wuC+eVdqlCmS/q1k2lOxWKqwfnuj3yQPIj/vq/BSWccl6NWkPnLU+H8dD7OaAYxUu+AWwzhdnn3OIejA/9/Dq1Z1OlmnYD18Jafgo6XyPXKYF7xKQVqi5CKX6PvfSukpYfsGBfyqpb42EA6o2QApo8MuNOSBLkJ5blQKqCr7JiC/lMypbJzmMAWegCrIWnyADvHu/kvgfJ7vftWomCNXT2mN+1x5xhOkQnacLe3inxjVIX0p5zgRfX12lmqEtxbXZPCBbRGCJPb7Uo0hHF/biJRKl1k35Be7iyEnjHuLLfjCfqBWCZ4Ijx6iVUGLmJbyWhB2Ul8gP6n9yjTgxYIdjTNEBRkd+aLG4cMTM0qF0QA3vELn4+C0+8WCsW9h5TtWr3tLM+DOMA2BSR4EZBayMziYzj23BzEbi1vvjUJO+gWt7Qdbc0VqodwVH61gwZeuJGTK8NAd/wRayhE2I1hA6ojt7NdAZNH/dF1vCak1whJE1c2W9gpQJzMpds/6oToGttOYdvcxGeGy1APgKkpuNCyZclmHzhEyTIOX5ZH0B+wAO9frc3SQt6GRVYpYTEoB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjJNeEFQSUZac08xRStZa0ZiZXRLQmEzcjBJZFVxZi9YSjlTL3BINUNScXlS?=
 =?utf-8?B?djVXOFE4QWdYNlJEaUo1b0NkVTBlUHRhaG1rWS9OZDJ5aWRmSWIwSU5JTG1O?=
 =?utf-8?B?WlI5OFRzUHZmUFJpU3pwK2EycnRPLzRlc2RKS0k4T3hQMTM3dGw4MDBTcU44?=
 =?utf-8?B?QkttR0duaUE5b3dXM1lGeituV05vVmdkSktPQ0JQZ2pJV0ttcnVIek5aRlg4?=
 =?utf-8?B?VHVtaXNadFN0MnZXdG4wTU9iMXBKeWhEdmtISFRHenBMTWxha0lFa1JvaG1Q?=
 =?utf-8?B?ampydHV3MllKNUF3T0Rsdk9xYWhENzNJeWtzbTRyYVF1OU8wZ1FWWElKUjF2?=
 =?utf-8?B?UUNmS1lhYThuejFlTmFuLzBmT1NCOEc2K0g3OVdCd25qRStqNy8zMCtaeVpP?=
 =?utf-8?B?UnJ4Sm9UNURnOTRQNGJVdDFkYTVyTmhldHM4bHNib0hFUVVKQ3llZWIzTlJ1?=
 =?utf-8?B?T3owRG5oRGp1NFp6N21TUktVaC9DYThmVm9nVm1QMjFOamNmZXhRY2R0Y21L?=
 =?utf-8?B?bTMzVzFqRTlFSk1sckkwc3hCMWlEQVpPWFFGeldVRlBoU1NJbGxRclZKWm40?=
 =?utf-8?B?V2V4aGd5aTNwVUdTV2ExSlRXSU1WckQxQlhkcnB2c0dsVmhsYzAza2wrNURx?=
 =?utf-8?B?cVYxclkxQkl0U0cwL2M4QVlYYmpOcGovdjQ4UXp0MzhLOVhoTnBhQjl5ZlV5?=
 =?utf-8?B?K3dFZ0ZCOUx5VnFhNHRablkwZVZhc3crRDA1dnZJS2JhZG1SU2ZmQnVjR3V1?=
 =?utf-8?B?REt5L0RZNHpKa1Q2TDJqMGs3a2ZpaTR5d21vOWVpYUhldDdZNytkdURhVkVj?=
 =?utf-8?B?a28xc2hTSXdtV2hSRTNHZjNVWXBValJYUTlUSkNNSUZPajhsajRZc2hEU0R2?=
 =?utf-8?B?TENKSnhBUC9PcXdXOSt3akt4SFBIZzRKcXMzdWx4cUgzNVNyWm9reVZFVWpo?=
 =?utf-8?B?S2gyTzZwUDlNZnJWRjBCK2FHK2ZYTklHRnhOZ1JMNitRYkZqanRwbUZZVzJZ?=
 =?utf-8?B?Wi85SHhEWXFoTnZjdXhERmxDZzBWMncwK1NKMmozZzZRekJRL0gwMWdndVNP?=
 =?utf-8?B?WFo0Rjd0SmlBdUpUb3A4TkhRSTFyV2VZTE94ZE9IVFpZY3FSMXJ3RlJmNWFN?=
 =?utf-8?B?R1Z3NFFoNG1xODNteTk2YnJlRTdaYXN2NmdMWjIxeDhzV29PTWJCYVQ4WHla?=
 =?utf-8?B?ckpJeVV2OWp5UngyTzJ2QXlZMUxHRHMrT01iSDVSL29Uc0lTbkZOWjRZNk1K?=
 =?utf-8?B?dUlkZDIwODIwQmZhc29xZHF6V1JyWlJ2VWpDL21PMHg5Q1dTRG9abWJ0ajE3?=
 =?utf-8?B?WWlmOTM0R3dHRWc1TWdFbE1aalhvOUo4b1ZTWmsyT3BINTU5d2hrRWNIQnJq?=
 =?utf-8?B?ajh2cHMxRmxZOXhWTVVjREplcU5LbkM0blI3cGdEL2F0WXcydFQ2UE1pZ0tY?=
 =?utf-8?B?OU0wR0xSMElmYm9PZnh4cGp0Z0s1Y3JteUp0K0ZhMXM4eElWcUJBNU5SVGdl?=
 =?utf-8?B?dnErZ2FET2plSUZtb05RM2pZdUNLYkJxV3BDNCtBUS9mcEdNYmdaaHpIZ1JP?=
 =?utf-8?B?MGpwRk9hRGpscVpTSGtkbkxGRnA0S2RFUHk0TU9EVWdpZ2hYL0VTYk5hbkNO?=
 =?utf-8?Q?kBprnW1vwc32vGEbFKozcqIVMX6xAjfA0rJBlTJJGAMU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a69dcaa1-1820-4a6b-a854-08dc2df77282
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 07:26:38.0558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6538

RnJvbTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3
YW15QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IE9uIDIvMTIvMjQgMTA6MTkgUE0sIG1oa2VsbGV5
NThAZ21haWwuY29tIHdyb3RlOg0KPiA+IEZyb206IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBv
dXRsb29rLmNvbT4NCj4gPg0KPiA+IEZvciBhIHBoeXNpY2FsIFBDSSBkZXZpY2UgdGhhdCBpcyBw
YXNzZWQgdGhyb3VnaCB0byBhIEh5cGVyLVYgZ3Vlc3QgVk0sDQo+ID4gY3VycmVudCBjb2RlIHNw
ZWNpZmllcyB0aGUgVk1CdXMgcmluZyBidWZmZXIgc2l6ZSBhcyA0IHBhZ2VzLiAgQnV0IHRoaXMN
Cj4gPiBpcyBhbiBpbmFwcHJvcHJpYXRlIGRlcGVuZGVuY3ksIHNpbmNlIHRoZSBhbW91bnQgb2Yg
cmluZyBidWZmZXIgc3BhY2UNCj4gPiBuZWVkZWQgaXMgdW5yZWxhdGVkIHRvIFBBR0VfU0laRS4g
Rm9yIGV4YW1wbGUsIG9uIHg4NiB0aGUgcmluZyBidWZmZXINCj4gPiBzaXplIGVuZHMgdXAgYXMg
MTYgS2J5dGVzLCB3aGlsZSBvbiBBUk02NCB3aXRoIDY0IEtieXRlIHBhZ2VzLCB0aGUgcmluZw0K
PiA+IHNpemUgYmxvYXRzIHRvIDI1NiBLYnl0ZXMuIFRoZSByaW5nIGJ1ZmZlciBmb3IgUENJIHBh
c3MtdGhydSBkZXZpY2VzDQo+ID4gaXMgdXNlZCBmb3Igb25seSBhIGZldyBtZXNzYWdlcyBkdXJp
bmcgZGV2aWNlIHNldHVwIGFuZCByZW1vdmFsLCBzbyBhbnkNCj4gPiBzcGFjZSBhYm92ZSBhIGZl
dyBLYnl0ZXMgaXMgd2FzdGVkLg0KPiA+DQo+ID4gRml4IHRoaXMgYnkgZGVjbGFyaW5nIHRoZSBy
aW5nIGJ1ZmZlciBzaXplIHRvIGJlIGEgZml4ZWQgMTYgS2J5dGVzLg0KPiA+IEZ1cnRoZXJtb3Jl
LCB1c2UgdGhlIFZNQlVTX1JJTkdfU0laRSgpIG1hY3JvIHNvIHRoYXQgdGhlIHJpbmcgYnVmZmVy
DQo+ID4gaGVhZGVyIGlzIHByb3Blcmx5IGFjY291bnRlZCBmb3IsIGFuZCBzbyB0aGUgc2l6ZSBp
cyByb3VuZGVkIHVwIHRvIGENCj4gPiBwYWdlIGJvdW5kYXJ5LCB1c2luZyB0aGUgcGFnZSBzaXpl
IGZvciB3aGljaCB0aGUga2VybmVsIGlzIGJ1aWx0LiBXaGlsZQ0KPiA+IHcvNjQgS2J5dGUgcGFn
ZXMgdGhpcyByZXN1bHRzIGluIGEgNjQgS2J5dGUgcmluZyBidWZmZXIgaGVhZGVyIHBsdXMgYQ0K
PiA+IDY0IEtieXRlIHJpbmcgYnVmZmVyLCB0aGF0J3MgdGhlIHNtYWxsZXN0IHBvc3NpYmxlIHdp
dGggdGhhdCBwYWdlIHNpemUuDQo+ID4gSXQncyBzdGlsbCAxMjggS2J5dGVzIGJldHRlciB0aGFu
IHRoZSBjdXJyZW50IGNvZGUuDQo+ID4NCj4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
ICMgNS4xNS54DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91
dGxvb2suY29tPg0KPiA+IC0tLQ0KPiBMb29rcyBnb29kIHRvIG1lLg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2Ft
eUBsaW51eC5pbnRlbC5jb20+DQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVy
di5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1o
eXBlcnYuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jDQo+ID4gaW5kZXgg
MWVhZmZmZjQwYjhkLi41ZjIyYWQzOGJiOTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaS1oeXBlcnYuYw0KPiA+IEBAIC00NjUsNyArNDY1LDcgQEAgc3RydWN0IHBjaV9lamVjdF9y
ZXNwb25zZSB7DQo+ID4gIAl1MzIgc3RhdHVzOw0KPiA+ICB9IF9fcGFja2VkOw0KPiA+DQo+ID4g
LXN0YXRpYyBpbnQgcGNpX3Jpbmdfc2l6ZSA9ICg0ICogUEFHRV9TSVpFKTsNCj4gPiArc3RhdGlj
IGludCBwY2lfcmluZ19zaXplID0gVk1CVVNfUklOR19TSVpFKDE2ICogMTAyNCk7DQo+ID4NCj4g
Tml0OiBJIHRoaW5rIHlvdSBjYW4gdXNlIFNaXzE2SyB0byBtYWtlIGl0IG1vcmUgcmVhZGFibGUu
DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gIEknbGwgc2VuZCBhIHYyIHRoYXQgdXNlcyBTWl8x
NksgcGVyIHlvdXINCmFuZCBJbHBvIErDpHJ2aW5lbidzIGNvbW1lbnQuDQoNCk1pY2hhZWwgDQo=

