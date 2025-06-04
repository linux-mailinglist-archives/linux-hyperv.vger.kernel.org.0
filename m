Return-Path: <linux-hyperv+bounces-5779-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53AACE655
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 23:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A90E1893E89
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A468221DB6;
	Wed,  4 Jun 2025 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aPOEKUh9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012055.outbound.protection.outlook.com [52.103.2.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830EA1EB5DB;
	Wed,  4 Jun 2025 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749074331; cv=fail; b=sCDpXKtKtOOEw+Y3Q8XbEoHKmg1dfw5AMYleXXRxVUhcU3ehB8J/LDXAb1D84nt4XgxMKh6gpA2vqNkZ42Ce9Q67TvJ89ebDLJUiz/9rvjiCVJMrR3I9+IY7xOBf0nrT4g6FNoMnMRnDZCwlqkUoIoV90MnfuFFIUy2oRL479o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749074331; c=relaxed/simple;
	bh=SqpbO4RuESyFPPvZdG0vs5S/DuNbJsI/FtvWqdlETlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H0Bdxi7WY5RPOon9C0SunQ/AbZ/C0ViTsttuFNzzuQ5S6W6TEGAqNuJqMzVJXsGHv/0CTUlFZKJgS3bsDr7a6zpkGIhK5d+E8GmMVr/1O8+xDTGpKcyeAjRI/dWt+gQpFb/Hmdc+wHhcWKDnhbvdZfSziQ5M3WPx71IzY5n8qdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aPOEKUh9; arc=fail smtp.client-ip=52.103.2.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgKxaozTB0B7cNqygMkbia9e3HfF73V8mF0SzL+LtKoiysX7smdf4ghxvhbH1PBckxqx1P/fqyXPWFYzvhf/NQ5LPryFcIX/OPAsPiAT3cNSoAUmTUTqPQnIqMqCRGlIChWVtoU3vCnAos+yC4R7mFCO44ZKnDtXoog8UfehzJqweH13IB+FI5wpD0SQ6smbYYzZpWjLUppwQrEDW2k2uUtE3lp/6Qga71sxwHjA81DE8igGYWyAPCKbTB1mfgiiBQT1cQU+mX9bcA66pN/JMOZFDoIt23TAtZJW7y05NR4kqXBbL2UQkAqolDHsxn34E42RzwDveM2ula2SwWDCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqpbO4RuESyFPPvZdG0vs5S/DuNbJsI/FtvWqdlETlA=;
 b=lifiOq9Z4eJyhRCZVaRjQHGNpzXKyl7SeR1EMe7y1cuvIgTjedd68pXAefL7WjGi2+7U+labNA3NkMt4OfKwzQO1h6ofY8lIR6cSXwwCHsa3JHgTHkGW45dS3COv6L2tSJKDwuSdgtQihD2W3LcOXhhyI2oA9dMgKZw0IWMLVUCYOEskdpYECHj/vt1PyUZXL3lidIb2aldFQ3Rp7HPof/dNQTbk7biheZTkAZlPfaNsF08SkQlOGyTPIUKLg/NS55rNPjhPH9jWG+osxcY6LxBUtuypJGdl0G/gJxv74tP7YZ9QAFh+h2AQ6zyOBevlTqADd98UP5mk1MDkIKWhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqpbO4RuESyFPPvZdG0vs5S/DuNbJsI/FtvWqdlETlA=;
 b=aPOEKUh9+sd199mk1v4gI8BW7ikgHopTKPuJ9E9yr3irHphbBfTr8R5dJucle3pH+DGinI+jkh4ap9pFLWsaMB+ys6U7w/A6WchSNstQpvg6wQIyN2PPo/Lbkgesqs7WZ89I3KXV7i20I8JHGMeLQ8lncNOdXz4y7l+xg+pPxiMyYZtEjpGM3Sxxeek7Z177WOb6tcVsQMZEWtHNlOJ8Hh/qtLJfnSPHB79PEJalVisjPkGSHVripXvwfReZOPrN98xdaTig8BEPX+32L/SV6KlhjtXdfs7o5mYlcusUVfQyGw6KhiWykIL+/8vn9sfEDXZIfH1nFBBNjnHNroF3Xg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7319.namprd02.prod.outlook.com (2603:10b6:510:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 21:58:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8813.016; Wed, 4 Jun 2025
 21:58:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, David Hildenbrand
	<david@redhat.com>, "simona@ffwll.ch" <simona@ffwll.ch>, "deller@gmx.de"
	<deller@gmx.de>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "weh@microsoft.com" <weh@microsoft.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "hch@lst.de" <hch@lst.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel
 memory framebuffers
Thread-Topic: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel
 memory framebuffers
Thread-Index: AQHby/4dA8oNLnhKakm3U+ZOuvHFDrPvrtEAgAEJQeCAAGmQAIAAnClQgAHgR2A=
Date: Wed, 4 Jun 2025 21:58:46 +0000
Message-ID:
 <SN6PR02MB41574078A6785C3E2E1A6391D46CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250523161522.409504-1-mhklinux@outlook.com>
 <20250523161522.409504-4-mhklinux@outlook.com>
 <de0f2cb8-aed6-436f-b55e-d3f7b3fe6d81@redhat.com>
 <SN6PR02MB41573C075152ECD8428CAF5ED46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e069436f-764d-464d-98ac-36a086297632@redhat.com>
 <SN6PR02MB4157A3F9E646C060553E5D90D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157A3F9E646C060553E5D90D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7319:EE_
x-ms-office365-filtering-correlation-id: 1a9f3856-69ac-4186-616b-08dda3b2fadd
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599006|461199028|19110799006|15080799009|8060799009|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mkt4LzE1R3BWKy93a29NUDVMMkRZbVVRbFpWdGpGdkQ2U0k0UTRvUVMrQitm?=
 =?utf-8?B?MER6YWhyQnNQZzlYaFZEWlREaWM2RFZJS29oUXZXR3NpNXBQRG9qWjFJRS9x?=
 =?utf-8?B?UU0wbXhwUUFmUGYybzdoek5GZTR1TjZjczNOSDduMFFDSnc4RmhjQkNBMzdO?=
 =?utf-8?B?ZDZFb1M0aDZwdUJ1RXNPWG5TbDZPaXM2WEJMckFhSkhaOEFLMExLK0E3alcy?=
 =?utf-8?B?bklxSVE2eDRyR2ZuWXJ1Q0NKU2R0YmxDRkNpbUxUWHBpdkRocEx1VGhwcE1J?=
 =?utf-8?B?dzkrbUxoMGVTNDl5NERxclAvSmRDNEVySGNZaUYySk1PN0w4REpsTk4rY2hp?=
 =?utf-8?B?NVcyRzZ1czN1THYycDVkbFhkeE5hU3ltZHp6TnlqbUVmczR4UUVZS0dMSHQ4?=
 =?utf-8?B?dERiaG1Sb0ZZYmFiL21JenY2TWh5dlo3N1B3ajNXSFR5QmFOa2VmNTAwajRw?=
 =?utf-8?B?aENQejVWVHd1NHVmREROWEVudWViNmZTdTF3Y0g1aUhZdjBtbXNTWnVnbkpl?=
 =?utf-8?B?SldGN3FGZG1JMnBzeVY1VUEwYTFwR2I3dFkxSjk5UElRTWVxWVNNNm95VCs0?=
 =?utf-8?B?YzRQbkYzNWxPVmJHUXB0eHFoNldDOEtZOTlkaVMzQy9OYVdjTVkzUzdMeXY4?=
 =?utf-8?B?aDR4WnpTWExpaUl6TkNqaDlIMjEyWHFBQ3JaSUtLMXAzaXBVem9wV2VrRWs1?=
 =?utf-8?B?UnVFYXBZbk9VeU9kYm1EbjFkVUF6TUR3Q3NMUGF0U2hocTJPYTZsTVJ1U0or?=
 =?utf-8?B?amR6SlZEK1BvRnFBT3prRDBvc2VoZFhiUHhzVXRLdytsRVZjQVpOZFplY1pR?=
 =?utf-8?B?RlpuUVRGQ05mS2NnaDBqUWF4V1I1Nm5iRnlKRTVSb1FXOUxFeUlGQmMxY2s0?=
 =?utf-8?B?OXRUZXRuTEhjTTFhYmcrcmtRcnZrYlhCc1g0MXVrL1RwNzJCZ1U1MndJczBG?=
 =?utf-8?B?MUJlSk9tdFA0VFNIMFk5R2VIYUhjVC9lTHVhb0pFSGRxVFdmeDFFKzZBZlla?=
 =?utf-8?B?OGV2VlFoTjVtUW05NU80Q0dVdDNwMjVlTXpRL0RqRllRYy9BWlNkYXFUZXQw?=
 =?utf-8?B?d1FnWkMvRjZ5dCsxQkVkcHBOTkw1S296ZlI4c2JyNndEYjBDL01kTlZPT0Rv?=
 =?utf-8?B?c0tzN0NtWGNpd3ZmZkU4K2xEUHFBbnhxWC9mMzViZ21PQUIrVk8rNHJkcCt4?=
 =?utf-8?B?anlYc1gwUFhpcDdCNnVLYzJPK3psbzZ5MTBQTlJBZm12YUxsOEhFQXhKNWk2?=
 =?utf-8?B?Mzlya0N5NVNzZDc3d1dXWjYwZjhzNk5Nc1NVaEk4NFlaMy9XVDhEWnRPZllw?=
 =?utf-8?B?ai9GVmFlNUpLS1NvZDNyWHgvL3hIR2NYTmIrQnh0eDNocDdmQUFuRDBOUEJ0?=
 =?utf-8?B?V1ZGQkVqUGtGR1l6OXhVNUtrOGZNSUxwSWpQeEVXYzROS2xjeFVTT0NWOUZJ?=
 =?utf-8?B?N3BCbHdCVlA4QW12MlBZWjlmN2xtb3ZzT01zbTZ5Z0ZIRkQzMTNzRytpRFhV?=
 =?utf-8?B?VXhRaEJGS09WTEQ2Q1BaanZQWWRQMlpuUTY3RDV6ODVabzF2a2JJM0F4Ukk2?=
 =?utf-8?B?bnE4UT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODZZL1lkRzNieHVPaXViaDlCUnlkLzZ0cnhxbkhGOUxvdWFkc2tHTzRJekpR?=
 =?utf-8?B?Z0cwUWZiS3pYUjM5TTd6eG9jekRrMUpzbnByMDI4R0w4S2I1ZDVYMVhUOEtI?=
 =?utf-8?B?YXV0NGJIQ1N4bWZQZUNzeHcybnNvd1kxbmNRdXB6M3lGNmN4dlNyQjlMeUE2?=
 =?utf-8?B?bGtwRnBIbkN1OVV2VmFFTGxWTm1WdXhUQTVMaEdhcUJYam5pV0U2UGV1Zkwr?=
 =?utf-8?B?a0tveGNFM1VvR1RZRWVwUE1SWWhzU3FaZ2xaUnRRNW9xR0M3MWowMzdidHhJ?=
 =?utf-8?B?WVo1UThpenZnUDdHb3hoWHRMOGxlTG05cUdabE1XejlzSm1EL2pEYVQzZHVU?=
 =?utf-8?B?d3F2cDQ4WEFlSnZoUVRyZDdIRFI0a1FsVW1EdENxOGpLS1BoWkl4S0RFY3B3?=
 =?utf-8?B?YlBKQjFKZzRhUzVpZlVQOEcvdUhBNVlRSWNxbXJkSWRyVmdUUENBRnExSEhs?=
 =?utf-8?B?OGlWc2IzNTkvYzhSNkZZOEZUYlo4YWtKemhJdnZzdERkSWs4VFZmejRxYTl5?=
 =?utf-8?B?MGFQV0ZqZjNjS1hFQnpsVFJIMnAwUkU4eDJDODlxTGZmK04rQnUyQ096L2dw?=
 =?utf-8?B?dUhpaUEzUWVrYWJHRjN6UmJsVC9rU1B3bHhmVXdEdlcvTzM0M2FVK2d6MFVK?=
 =?utf-8?B?M2Y2cUU5bVFRdzFtRkJPNVZQRDdudS96MXBzSnNUSlpxTDVpVUc0aHJ4RVR2?=
 =?utf-8?B?RlpqZVRNZHQxZzJJOUdDczFYRnB6S3hyYlZqMmVGMGVBY3lGTS91dVl1TTJP?=
 =?utf-8?B?WjNtczkySHhjWTFxVzVvKzgrTHZiUnh6VjJpSm1zcHo1TXYvVXVlZXE2REc3?=
 =?utf-8?B?SHdyY1YzS3JjclQ0b1ZUS3Z1T0dpbWJOK3JVaU1VcS9WR2FJclRPY0NTQmNC?=
 =?utf-8?B?SGZ6R0FqQ2hzeW9wMzdsUERwdHdnRnlxS01CWkRZdmlqNEdFU3V5U2F1Vmtw?=
 =?utf-8?B?VERGemtIbE9jdEJmWU55KzdhSDh5ZnA1WmcwR1FkZHBoZ0dOR2JMMEVqUW5N?=
 =?utf-8?B?OUVGU1Z0Nk9Td0lEME9VOFl2cXBvZ0Nxd2V6MVIxWXRSQzBESll0OUE3OFhL?=
 =?utf-8?B?TCtLL1I4SzlMR21jY3ZpZEQ3RWc1VC9HNW11WjQ2ZG1sRWo4WlBXbkt2WUpK?=
 =?utf-8?B?VU44bEp3ejVseUJpWW15bW5YNWE0TDFNalAvZTBldzIxeUlFM2FzQ1pMK0hk?=
 =?utf-8?B?TEpHa3VrbnRkdDFtbGd3YTl5ZG9hN1VwTFZoSlVSK1MrN2g4WElFZDU5WW1S?=
 =?utf-8?B?M0picHNwRFAweENxeWRUdG9XMjl6UnNmTkUxdEo5WWx0OS9zZE16Z1hobmxX?=
 =?utf-8?B?MUhhNjJnM3M1UndabWhqTjlxaUtYRWd3eUdUbm9wdlNGVVRmaEtIbjJXS1RH?=
 =?utf-8?B?TkxqZXRwYWtxVTRPVWh4ZGZhbW5MVlBJVkdSNFZ3OU8xSFFjODBNYkZGYVhQ?=
 =?utf-8?B?ZGFTWlN3QmNIRm5uNzFOa1JWVEhqeFpBV0xmL3FzT3IreHRPM2YwZkFteFhB?=
 =?utf-8?B?alFBUVJ0SE5oY3ZkRmZJSFFxQklWc1ZuMHMwN0pYa1E2WVBucGZjd29pWjFE?=
 =?utf-8?B?T0JlUTJPVHJac1VqSmdEazNZaEo0TVhnRnNSc1pEMm85NHZZTVlpL3hyWktz?=
 =?utf-8?Q?vmzy1VScs02+qrwOTtO707T18dx9x2qXUvyB61ZfQVR8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9f3856-69ac-4186-616b-08dda3b2fadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 21:58:46.4661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7319

RnJvbTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPiBTZW50OiBUdWVzZGF5
LCBKdW5lIDMsIDIwMjUgMTA6MjUgQU0NCj4gDQo+IEZyb206IERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPiBTZW50OiBUdWVzZGF5LCBKdW5lIDMsIDIwMjUgMTI6NTUgQU0NCj4g
Pg0KPiA+IE9uIDAzLjA2LjI1IDAzOjQ5LCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiA+IEZy
b206IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiBTZW50OiBNb25kYXksIEp1
bmUgMiwgMjAyNSAyOjQ4IEFNDQo+ID4gPj4NCg0KW3NuaXBdDQoNCj4gPiA+Pj4gQEAgLTE4Miwy
MCArMjIxLDM0IEBAIHN0YXRpYyB2bV9mYXVsdF90IGZiX2RlZmVycmVkX2lvX3RyYWNrX3BhZ2Uo
c3RydWN0IGZiX2luZm8gKmluZm8sIHVuc2lnbmVkIGxvbmcNCj4gPiA+Pj4gICAgCX0NCj4gPiA+
Pj4NCj4gPiA+Pj4gICAgCS8qDQo+ID4gPj4+IC0JICogV2Ugd2FudCB0aGUgcGFnZSB0byByZW1h
aW4gbG9ja2VkIGZyb20gLT5wYWdlX21rd3JpdGUgdW50aWwNCj4gPiA+Pj4gLQkgKiB0aGUgUFRF
IGlzIG1hcmtlZCBkaXJ0eSB0byBhdm9pZCBtYXBwaW5nX3dycHJvdGVjdF9yYW5nZSgpDQo+ID4g
Pj4+IC0JICogYmVpbmcgY2FsbGVkIGJlZm9yZSB0aGUgUFRFIGlzIHVwZGF0ZWQsIHdoaWNoIHdv
dWxkIGxlYXZlDQo+ID4gPj4+IC0JICogdGhlIHBhZ2UgaWdub3JlZCBieSBkZWZpby4NCj4gPiA+
Pj4gLQkgKiBEbyB0aGlzIGJ5IGxvY2tpbmcgdGhlIHBhZ2UgaGVyZSBhbmQgaW5mb3JtaW5nIHRo
ZSBjYWxsZXINCj4gPiA+Pj4gLQkgKiBhYm91dCBpdCB3aXRoIFZNX0ZBVUxUX0xPQ0tFRC4NCj4g
PiA+Pj4gKwkgKiBUaGUgUFRFIG11c3QgYmUgbWFya2VkIHdyaXRhYmxlIGJlZm9yZSB0aGUgZGVm
aW8gZGVmZXJyZWQgd29yayBydW5zDQo+ID4gPj4+ICsJICogYWdhaW4gYW5kIHBvdGVudGlhbGx5
IG1hcmtzIHRoZSBQVEUgd3JpdGUtcHJvdGVjdGVkLiBJZiB0aGUgb3JkZXINCj4gPiA+Pj4gKwkg
KiBzaG91bGQgYmUgc3dpdGNoZWQsIHRoZSBQVEUgd291bGQgYmVjb21lIHdyaXRhYmxlIHdpdGhv
dXQgZGVmaW8NCj4gPiA+Pj4gKwkgKiB0cmFja2luZyB0aGUgcGFnZSwgbGVhdmluZyB0aGUgcGFn
ZSBmb3JldmVyIGlnbm9yZWQgYnkgZGVmaW8uDQo+ID4gPj4+ICsJICoNCj4gPiA+Pj4gKwkgKiBG
b3Igdm1hbGxvYygpIGZyYW1lYnVmZmVycywgdGhlIGFzc29jaWF0ZWQgc3RydWN0IHBhZ2UgaXMg
bG9ja2VkDQo+ID4gPj4+ICsJICogYmVmb3JlIHJlbGVhc2luZyB0aGUgZGVmaW8gbG9jay4gbW0g
d2lsbCBsYXRlciBtYXJrIHRoZSBQVEUgd3JpdGFhYmxlDQo+ID4gPj4+ICsJICogYW5kIHJlbGVh
c2UgdGhlIHN0cnVjdCBwYWdlIGxvY2suIFRoZSBzdHJ1Y3QgcGFnZSBsb2NrIHByZXZlbnRzDQo+
ID4gPj4+ICsJICogdGhlIHBhZ2UgZnJvbSBiZWluZyBwcmVtYXR1cmVseSBiZWluZyBtYXJrZWQg
d3JpdGUtcHJvdGVjdGVkLg0KPiA+ID4+PiArCSAqDQo+ID4gPj4+ICsJICogRm9yIEZCSU5GT19L
TUVNRkIgZnJhbWVidWZmZXJzLCBtbSBhc3N1bWVzIHRoZXJlIGlzIG5vIHN0cnVjdCBwYWdlLA0K
PiA+ID4+PiArCSAqIHNvIHRoZSBQVEUgbXVzdCBiZSBtYXJrZWQgd3JpdGFibGUgd2hpbGUgdGhl
IGRlZmlvIGxvY2sgaXMgaGVsZC4NCj4gPiA+Pj4gICAgCSAqLw0KPiA+ID4+PiAtCWxvY2tfcGFn
ZShwYWdlcmVmLT5wYWdlKTsNCj4gPiA+Pj4gKwlpZiAoaW5mby0+ZmxhZ3MgJiBGQklORk9fS01F
TUZCKSB7DQo+ID4gPj4+ICsJCXVuc2lnbmVkIGxvbmcgcGZuID0gcGFnZV90b19wZm4ocGFnZXJl
Zi0+cGFnZSk7DQo+ID4gPj4+ICsNCj4gPiA+Pj4gKwkJcmV0ID0gdm1mX2luc2VydF9taXhlZF9t
a3dyaXRlKHZtZi0+dm1hLCB2bWYtPmFkZHJlc3MsDQo+ID4gPj4+ICsJCQkJCSAgICAgICBfX3Bm
bl90b19wZm5fdChwZm4sIFBGTl9TUEVDSUFMKSk7DQo+ID4gPj4NCj4gPiA+PiBXaWxsIHRoZSBW
TUEgaGF2ZSBWTV9QRk5NQVAgb3IgVk1fTUlYRURNQVAgc2V0PyBQRk5fU1BFQ0lBTCBpcyBhDQo+
ID4gPj4gaG9ycmlibGUgaGFjay4NCj4gPiA+Pg0KPiA+ID4+IEluIGFub3RoZXIgdGhyZWFkLCB5
b3UgbWVudGlvbiB0aGF0IHlvdSB1c2UgUEZOX1NQRUNJQUwgdG8gYnlwYXNzIHRoZQ0KPiA+ID4+
IGNoZWNrIGluIHZtX21peGVkX29rKCksIHNvIFZNX01JWEVETUFQIGlzIGxpa2VseSBub3Qgc2V0
Pw0KPiA+ID4NCj4gPiA+IFRoZSBWTUEgaGFzIFZNX1BGTk1BUCBzZXQsIG5vdCBWTV9NSVhFRE1B
UC4gIEl0IHNlZW1lZCBsaWtlDQo+ID4gPiBWTV9NSVhFRE1BUCBpcyBzb21ld2hhdCBvZiBhIHN1
cGVyc2V0IG9mIFZNX1BGTk1BUCwgYnV0IG1heWJlIHRoYXQncw0KPiA+ID4gYSB3cm9uZyBpbXBy
ZXNzaW9uLg0KPiA+DQo+ID4gVk1fUEZOTUFQOiBub3RoaW5nIGlzIHJlZmNvdW50ZWQgZXhjZXB0
IGFub24gcGFnZXMNCj4gPg0KPiA+IFZNX01JWEVETUFQOiBhbnl0aGluZyB3aXRoIGEgInN0cnVj
dCBwYWdlIiAocGZuX3ZhbGlkKCkpIGlzIHJlZmNvdW50ZWQNCj4gPg0KPiA+IHB0ZV9zcGVjaWFs
KCkgaXMgYSB3YXkgZm9yIEdVUC1mYXN0IHRvIGRpc3Rpbmd1aXNoIHRoZXNlIHJlZmNvdW50ZWQg
KGNhbg0KPiA+IEdVUCkgZnJvbSBub24tcmVmY291bnRlZCAoY2Ftbm5vdCBHVVApIHBhZ2VzIG1h
cHBlZCBieSBQVEVzIHdpdGhvdXQgYW55DQo+ID4gbG9ja3Mgb3IgdGhlIFZNQSBiZWluZyBhdmFp
bGFibGUuDQo+ID4NCj4gPiBTZXR0aW5nIHB0ZV9zcGVjaWFsKCkgaW4gVk1fTUlYRURNQVAgb24g
cHRlcyB0aGF0IGhhdmUgYSAic3RydWN0IHBhZ2UiDQo+ID4gKHBmbl92YWxpZCgpKSBpcyBsaWtl
bHkgdmVyeSBib2d1cy4NCj4gDQo+IE9LLCBnb29kIHRvIGtub3cuDQo+IA0KPiA+DQo+ID4gPiB2
bV9taXhlZF9vaygpIGRvZXMgYSB0aG9yb3VnaCBqb2Igb2YgdmFsaWRhdGluZyB0aGUNCj4gPiA+
IHVzZSBvZiBfX3ZtX2luc2VydF9taXhlZCgpLCBhbmQgc2luY2Ugd2hhdCBJIGRpZCB3YXMgYWxs
b3dlZCwgSSB0aG91Z2h0DQo+ID4gPiBwZXJoYXBzIGl0IHdhcyBPSy4gWW91ciBmZWVkYmFjayBo
YXMgc2V0IG1lIHN0cmFpZ2h0LCBhbmQgdGhhdCdzIHdoYXQgSQ0KPiA+ID4gbmVlZGVkLiA6LSkN
Cj4gPg0KPiA+IFdoYXQgZXhhY3RseSBhcmUgeW91IHRyeWluZyB0byBhY2hpZXZlPyA6KQ0KPiA+
DQo+ID4gSWYgaXQncyBtYXBwaW5nIGEgcGFnZSB3aXRoIGEgInN0cnVjdCBwYWdlIiBhbmQgKm5v
dCogcmVmY291bnRpbmcgaXQsDQo+ID4gdGhlbiB2bWZfaW5zZXJ0X3BmbigpIGlzIHRoZSBjdXJy
ZW50IHdheSB0byBhY2hpZXZlIHRoYXQgaW4gYSBWTV9QRk5NQVANCj4gPiBtYXBwaW5nLiBJdCB3
aWxsIHNldCBwdGVfc3BlY2lhbCgpIGF1dG9tYXRpY2FsbHkgZm9yIHlvdS4NCj4gPg0KPiANCj4g
WWVzLCB0aGF0J3Mgd2hhdCBJJ20gdXNpbmcgdG8gaW5pdGlhbGx5IGNyZWF0ZSB0aGUgc3BlY2lh
bCBQVEUgaW4gdGhlDQo+IC5mYXVsdCBjYWxsYmFjay4NCj4gDQo+ID4gPg0KPiA+ID4gQnV0IHRo
ZSB3aG9sZSBhcHByb2FjaCBpcyBtb290IHdpdGggQWxpc3RhaXIgUG9wcGxlJ3MgcGF0Y2ggc2V0
IHRoYXQNCj4gPiA+IGVsaW1pbmF0ZXMgcGZuX3QuIElzIHRoZXJlIGFuIGV4aXN0aW5nIG1tIEFQ
SSB0aGF0IHdpbGwgZG8gbWt3cml0ZSBvbiBhDQo+ID4gPiBzcGVjaWFsIFBURSBpbiBhIFZNX1BG
Tk1BUCBWTUE/IEkgZGlkbid0IHNlZSBvbmUsIGJ1dCBtYXliZSBJIG1pc3NlZA0KPiA+ID4gaXQu
IElmIHRoZXJlJ3Mgbm90IG9uZSwgSSdsbCB0YWtlIGEgY3JhY2sgYXQgYWRkaW5nIGl0IGluIHRo
ZSBuZXh0IHZlcnNpb24gb2YgbXkNCj4gPiA+IHBhdGNoIHNldC4NCj4gPg0KPiA+IEkgYXNzdW1l
IHlvdSdkIHdhbnQgdm1mX2luc2VydF9wZm5fbWt3cml0ZSgpLCBjb3JyZWN0PyBQcm9iYWJseQ0K
PiA+IHZtZl9pbnNlcnRfcGZuX3Byb3QoKSBjYW4gYmUgdXNlZCBieSBhZGRpbmcgUEFHRV9XUklU
RSB0byBwZ3Byb3QuIChtYXliZQ0KPiA+IDopICkNCj4gDQo+IE9rLCBJJ2xsIGxvb2sgYXQgdGhh
dCBtb3JlIGNsb3NlbHkuIFRoZSBzZXF1ZW5jZSBpcyB0aGF0IHRoZSBzcGVjaWFsDQo+IFBURSBn
ZXRzIGNyZWF0ZWQgd2l0aCB2bWZfaW5zZXJ0X3BmbigpLiBUaGVuIHdoZW4gdGhlIHBhZ2UgaXMg
Zmlyc3QNCj4gd3JpdHRlbiB0bywgdGhlIC5wZm5fbWt3cml0ZSBjYWxsYmFjayBpcyBpbnZva2Vk
IGJ5IG1tLiBUaGUgcXVlc3Rpb24NCj4gaXMgdGhlIGJlc3Qgd2F5IGZvciB0aGF0IGNhbGxiYWNr
IHRvIG1hcmsgdGhlIGV4aXN0aW5nIFBURSBhcyB3cml0YWJsZS4NCj4gDQoNCkZXSVcsIHZtZl9p
bnNlcnRfcGZuX3Byb3QoKSB3b24ndCB3b3JrLiBJdCBjYWxscyBpbnNlcnRfcGZuKCkgd2l0aA0K
dGhlICJta3dyaXRlIiBwYXJhbWV0ZXIgc2V0IHRvICdmYWxzZScsIGluIHdoaWNoIGNhc2UgaW5z
ZXJ0X3BmbigpDQpkb2VzIG5vdGhpbmcgaWYgdGhlIFBURSBhbHJlYWR5IGV4aXN0cy4NCg0KU28g
SSB3b3VsZCBuZWVkIHRvIGNyZWF0ZSBhIG5ldyBBUEkgdGhhdCBkb2VzIGFwcHJvcHJpYXRlIHZh
bGlkYXRpb24NCmZvciBhIFZNX1BGTk1BUCBWTUEsIGFuZCB0aGVuIGNhbGxzIGluc2VydF9wZm4o
KSB3aXRoIHRoZSAibWt3cml0ZSINCnBhcmFtZXRlciBzZXQgdG8gJ3RydWUnLg0KDQpNaWNoYWVs
DQo=

