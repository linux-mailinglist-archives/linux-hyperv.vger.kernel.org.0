Return-Path: <linux-hyperv+bounces-9545-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJRvOloIvGkArgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9545-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:29:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF602CCD43
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D745A329AFD8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B034A34FF47;
	Thu, 19 Mar 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TADMOmo0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010016.outbound.protection.outlook.com [52.103.2.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6A3563CD;
	Thu, 19 Mar 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929954; cv=fail; b=JXbUr0Si83DLEa5tGYcF/XWNnAxFRC/hpdjLDRaRmS6AKGlaekHLdarF8OrJ2pckb19/prmzcNBiyQmP/uBZS52JpOaXwdKM9qY8muL9YV/g0dfxL2fihFHBUaFK5z20C6DahvAtGxot3x3XqryGCQfobcIe3WKXhjV4M3SZ/8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929954; c=relaxed/simple;
	bh=WfwZ0QxgDIUkI31a6iDRPqtArYJ5al9gg1QpLbm3G84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4yyI+d7V3nNKkKyt/S1PeErdV+qV5GfiJTFX7JnJTAQ/txfqJqr7Cvs7k1qiAyLE5C2TGTkkMrZouJDsge+/veOI6uGAbCP3TX9C5G9uX9lcqIrFuo2SZgG98/v+nIpLes5joJbOG/bNS7v84QiSdgWovZJBlXIeJISvK5ZK0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TADMOmo0; arc=fail smtp.client-ip=52.103.2.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjjlIX2s/enCfCTFVDmi0Gx/P/hbTPzmcJMNB6dKGqtyuhBD90rxrvQmYuJCoT2hUdXmRsI+FfrnPdsjGXP2z0RlPsjDxrt50LnyWbHIv372txKU2+kY3YcXLeRYWiJsqcbg65HMgh0h2sfmZQP54lnEr0uRj9tbQWT54mRy0wPtiYR/6zbK38Ik3fekKOek1HWwN8zXrb4jsGbrpTCHJB/Xh9oQVIFaxJqjomnSHGNjS1zquQelJMh2i/ARBCU6jkjcXtE/jy/A2Kvz1JbwHuCJ9a96lZocVGwTWp4VhxFD1AL0qAr8unjvIMQ66b+rNzgqUxYmfw9LbVD0irUkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfwZ0QxgDIUkI31a6iDRPqtArYJ5al9gg1QpLbm3G84=;
 b=nBSXb4BReYnUV1Y7atOFQ5Fmn3UzbxSOjcwigYnku4ISRbcbUohJ3yKO5SaAB9kMQBz6QM2onrdS/IhciSALaeaBSVf963VSDtPt5az7DzNGJt2aPXYDTflD+LL/Q0fZQgpG+bwAvP4x4c4ocMq4p86F2SFnWDmn+BOich7SW1akPnBM9V9uE1ANQbJcppuGNlCL0Lb74Ompqr2cWjnxJHi48HeUPknYEF0Cpo6GqQ7jXP8TbJfDVD3UOWr9XBaYvZF+2hFW/tjF55tePedrhtOVKSiIRD8WMw1Pl93ivOb4uFFrw9XIFvNynAWNYAWfYKTzsi3x+jDXOvj0SOA5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfwZ0QxgDIUkI31a6iDRPqtArYJ5al9gg1QpLbm3G84=;
 b=TADMOmo0ulU6H2s/yPJRu5LaYVCcWkne4nw8OluyW/S9JgV7fNq/lCB3h2GgJGdrzOlsqLAuO7FZMYbkMTIYiJvMSTdysiEZpchv5hD9XMgyJeZSqQl4/nTKp/07VzELMQoNYPu+FhICTwJTI4oaBLnfdWqR69ju8nvyIbkuaDN3n9JnIgOC8RxYdyqRPhNAts4HXEDy5YIiPdyVFd7smBmKzFRcXyga7SHZL2aiH4T+d70EHDn1HHCtirxcwDkKCH2etQPRh0SPo+OQ8HYUuhf8d/O9gr6PjxlJc102ClP1L745Vg2OnIpZV6H/6oz9UGxqoF0uaN1nq20/AoFa9Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6478.namprd02.prod.outlook.com (2603:10b6:5:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:19:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:19:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michael Kelley
	<mhklinux@outlook.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: RE: RE: RE: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness
 back to real interrupt
Thread-Topic: RE: RE: [PATCH] Drivers: hv: vmbus: Move
 add_interrupt_randomness back to real interrupt
Thread-Index:
 AQKoHsdWm1sf+zqRuZikYGt2JgzA3AGnYzL4AVfxRpG0A+1pNoAAQNBggAEYiQCAASTw0IAAaaeAgABJJ6A=
Date: Thu, 19 Mar 2026 14:19:10 +0000
Message-ID:
 <SN6PR02MB4157176E6B59A2DEEE946991D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
 <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
 <20260317132252.AJlwEyMh@linutronix.de>
 <5262eafa-7f94-41c8-85d7-a2b8d7f27c5a@siemens.com>
 <SN6PR02MB41573332BF202DAE0AF79ED1D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318101042.-QHDXjlS@linutronix.de>
 <SN6PR02MB4157392A02838453BAFBA807D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260319095719.7cPrV_6A@linutronix.de>
In-Reply-To: <20260319095719.7cPrV_6A@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6478:EE_
x-ms-office365-filtering-correlation-id: 558be3dd-5721-4a40-8695-08de85c27d96
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|51005399006|15080799012|31061999003|13091999003|461199028|37011999003|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXhaaE82S0twMENxdENBVElJVTNTbkV1b2JnREpTQkxHd2x5WWtXSGgvdEJP?=
 =?utf-8?B?VnNpQUFxUVRWUk5zcm9iNXkvMmxzdW51bk5URE9oQ0pKL00xS2puOW9tbnFL?=
 =?utf-8?B?dUZ0QkZaN1ArLytGSnRPWHdOR3lVdlRET2V6NXhhRWZsSkJQdjhCRXNwK0Fw?=
 =?utf-8?B?SXJXOGFmMzdYYVhsVXFiaGRGYXEzOE9jNEJ5NXpibC9DMFlvd1dpNnBKSW5M?=
 =?utf-8?B?T3RvcldSRHh4dm10NURDam1ROS83SGI1ZE5wZlNOOGdpaS8wTlZ4VHlBVHh2?=
 =?utf-8?B?M1dmcXJxZkdNdlhxdmtIY0tDRFZLUXVXYVhISm0wT0JVQ204WUxaRWlma0hG?=
 =?utf-8?B?V1g2YVFyd3ZDbngvTGp4YjZxMlBoZEJFWUNKZTczUlV6dm1YS3lvZkszbEgy?=
 =?utf-8?B?QzNqMVZKQ3ltN2ZMY1hJdytkNytBSWRISWFIMmdSQlplUG9QM1pNQjB1N1Iy?=
 =?utf-8?B?S1dzZ0RWWUd6ZlhLSHZudDFsbFZBYXN1LzBwdGtEVWFlYlkyMjJMUkRNc3pB?=
 =?utf-8?B?elNsUlh6OXcybFdTck9TeGVVeWIxNjFVaEpGdEx3Q3RucU1ZRHd2Q1g2VlZp?=
 =?utf-8?B?TU5oUHd5Rzl2L3dLQUpZYUIzbFcxYmFPd2I5M1VKNzcvN0d3bmM2cmtjOTI3?=
 =?utf-8?B?UjltMWpiRmxQZ2laNnFmUEF3U0lua0h5bjFmbUVTTFp4UjExZmxQcERLOXRh?=
 =?utf-8?B?Tnd5OXlQS2xtdXhCaXVIUlVqMHcxZXFVZzVGU3Bvd0YvSEdFLy8vQit4RmRl?=
 =?utf-8?B?anVYRktRZFZiTWZJckFCRStCNHZHdVh1VGJ5ZDI1SE5YajE0c2NLck9iUnow?=
 =?utf-8?B?aklxT1g0b1ZKOUJ0TitTOUV6Nmd5OGs0VE9EQ1NuUDNEOERRWE5CeE44akZR?=
 =?utf-8?B?b1hGcU94TjNHSk1uQXN0QWRPQ2VmUmRNa1NKQ2tLeGttTk0yN0RNblZVRjNx?=
 =?utf-8?B?WEc1eGF5Q1hxakQrR040K2VDR0tqU0UrNE4xeGRVSEIzZXRsVGxJVEd0QzV1?=
 =?utf-8?B?SVAvb1NEazVCMVRmSzZ5S0l6TUtkc2F1dDlwbC9jUjUyNEg5Uk5XOFBlbUxH?=
 =?utf-8?B?Sm9peE12QkR2R1RVV3dSOVdBcGtja1JTbE9xcndFR0dQOEhNYU5vSTdOQ0dm?=
 =?utf-8?B?dEZsYzhHUGJCaFFLUlJnRStQQ2Z2VFNoclp0ZkJHaVRReEhDamkza2J3d0JP?=
 =?utf-8?B?SG1VczRURXh2OW9mRStFUTVweUF4di9jUGV2eFo0THZWbDc5YW03MVdyMWc4?=
 =?utf-8?B?WTBTcGNhZkJHVGxpVnp1VEREdEFRVm1Udk5vQUJhdDZJSDBrekZmNW1QM3dK?=
 =?utf-8?Q?/DItJ9MCW7jvHhyHgmlvxOI3L3gNaF4eFY?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzViNWxFeUU1L0hUTElaeFlRVXZZajhSblJNN3F4NnAzdys4UmpYWkJhZGhh?=
 =?utf-8?B?bWc4YzZPaHFISTZndVNVQllkTnlBVmhSbXByNFl6TDZuelVNaVFRRkJxWmRJ?=
 =?utf-8?B?bEVKOUdoMkRGcmMybHRoQTM4MWJzRFNXODhNa1dxaGxGOEh4d0ROYnFFcUw3?=
 =?utf-8?B?VUJvYUdXS0wwYmVlTytuVFVSWVJkR2ZsTGNidFo1dDhiVFZndlZCZmNlOUFS?=
 =?utf-8?B?Tlc3MGVrTldnSVh4UEdKZHFmbllrYjJlK0t3ZG1IQ256WWFwalJaZGx2eGxE?=
 =?utf-8?B?VmJkTGFJN3ZFbm9SUDRFcm5yUS9IMk1hS2dZaE9BaVZERjFNRkZRK2p0azNV?=
 =?utf-8?B?QTlSZ1Z0ZHhhRFBCbmE2M2FHbkxrdmNJTVBmb241RjBqNXhDZHpXUlZqd2do?=
 =?utf-8?B?VzYvdkw0OXFBbGgxZzNZMTJKSVZWNFpzL2VaR09yQXp6ekFnRjZRUkNBK1VC?=
 =?utf-8?B?K1EvSXlRczhUU24rT0tYUUJVNm4xdUI5ODl2a0xWS1g2ckhNcTlsaEJZZ2t2?=
 =?utf-8?B?eWFibi9BWmRHMDRGY1pVbUNFQnNWMU9tLzdXM2hnQnFQSG1uc1ZWNDZoYXE1?=
 =?utf-8?B?RkJnVm1MeFdNb0RqQVU0d1dVUERHU1VwWm5BeVh4eG1lVUMya3J1aVNMdG0z?=
 =?utf-8?B?ME1QWDBIa1IyTkdZUUFaZlpMK0tqZHlTcTVoVWJYQWVGaXVzK2sra0tqOVJ4?=
 =?utf-8?B?RmpyNy9WeGRVcTNURnhkTVRsNzI4enJjSVcvMCsrN3hLVTllbTM5S3ZoM0ty?=
 =?utf-8?B?UVVyOFd1UFA3ZkEzUXVHTGR6bCtMRldneFA0NXVLTS8wTExWL2JLSmlqYlNp?=
 =?utf-8?B?UUxzRTNhNi9Ma1J2VHZvNFlRSWNFUDZVS2dVakJCZmF3ME55Q1ZmUTJqd1pj?=
 =?utf-8?B?UmM1Yy9vdlJpMGMvSnpJOHJJak1HZHphZ1V1SGtITDd2VzYrL05yWG5iK2dt?=
 =?utf-8?B?NXFnd1BINmYzbHl3VEszRWV1QzU1NjU0eVJzTThYamIxUHo3TzNVUzJ6dmVG?=
 =?utf-8?B?RmZydmNBcEZ2SmxjQllzQjh1QWJGZVpFSTh2WVZGaUY1VHpDT0Q5M2wvOTJP?=
 =?utf-8?B?S1FFM01FMjVtNGJIUE93Yyt5YmpjMGxxeDBrWmowNzB3L2d1RWd6VlJEVCth?=
 =?utf-8?B?Y3dqNHd2MEJ5MmliM0hCOWszcmFRVnJKMG1IdnpMSzVhQXR1YXNCVTJTUzBz?=
 =?utf-8?B?ak5lWjNzdkl6aUhDNU5vMHpOR2FTcjJEQjdCQm1ya2t4bURFcXA2bkJqa25D?=
 =?utf-8?B?NWJSdDVOZHdVZ3Q5R0YvRklxMnNnVlRBQVF0UW03ZmtXcHBtYnRyaTA5QjFo?=
 =?utf-8?B?dE1ENWdhVEo5Rkl1ZURMM282STFtQ2RpRmpRT2ZoVGd4TGU5djlOY3pBSFNW?=
 =?utf-8?B?TnFCeXptdGl1WDFMc1hoM1U3a1hLMkovT0d6aVE0blg3cElzcjlpU0hFUUhP?=
 =?utf-8?B?NkVoRmd6OU0rdjBZWno4UExGTDZYdFlhNzlDR0tRbXpXdUxpVWkwTlkrZUlG?=
 =?utf-8?B?ZEJZV0UvL083YkZEb3I4dDU2WWx5WEFZREhsdXI5YUU0eFRRbGRWdlFHTnhX?=
 =?utf-8?B?N1NFU3lwSlBKL3BNb2xmK2V4NDJka0lBaUNZV2NQRnJHMG9mR0drMUpXVUpZ?=
 =?utf-8?B?QS81Y3JNSi9PaW8vUFZOUXl5cldRUHBtSlU4N3c2WXJ5TThjV2FKUnhIamhl?=
 =?utf-8?B?TFNTZFhPUklSTlZ2d1R3dGVyd1AxVWtiL2pNU3gxYnhEeGtoTWJ5TzZaM1Rk?=
 =?utf-8?B?RG9ZcmxGS3FSMFIxK3pQYjZvSmZGYlFGTVVzeUtoZzZrZWFlc1hBTzdRWGRm?=
 =?utf-8?Q?UrdWVrgvTnZQrqT+R41X+t5H672qMLhXMZSNk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 558be3dd-5721-4a40-8695-08de85c27d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 14:19:10.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6478
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9545-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4FF602CCD43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggMTksIDIwMjYgMjo1NyBBTQ0KPiANCj4gT24gMjAyNi0wMy0x
OSAwMzozOToxMiBbKzAwMDBdLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBJJ2xsIHJhaXNl
IHRoZSB0b3BpYyB3aXRoIEFSTSBtYWludGFpbmVycyBhbmQgSVJRIHN1YnN5c3RlbSBtYWludGFp
bmVycw0KPiA+IHRvIHNlZSBpZiB0aGVyZSdzIGFueSByZWFzb24gb25lIHdheSBvciB0aGUgb3Ro
ZXIuIEkgd291bGQgbm90IGJlIHN1cnByaXNlZA0KPiANCj4gVGhhbmsgeW91Lg0KPiANCj4gPiBp
ZiBhZGRpbmcgaW50ZXJydXB0IHJhbmRvbW5lc3MgaXMgaW50ZW50aW9uYWxseSBleGNsdWRlZCBi
ZWNhdXNlIHRoZXNlDQo+ID4gcGVyLUNQVSBpbnRlcnJ1cHRzIHdlcmUgaGlzdG9yaWNhbGx5IHVz
ZWQgZm9yIElQSXMgYW5kIHRpbWVycyBvbmx5LiBXaGF0J3MNCj4gPiBjaGFuZ2VkIGlzIHRoYXQg
QVJNNjQgaXMgbm93IHVzZWQgc2lnbmlmaWNhbnRseSBpbiBkYXRhIGNlbnRlcnMsIGFuZA0KPiA+
IHN1cHBvcnQgZm9yIFZNcyBpcyBzdXBlciBpbXBvcnRhbnQuIFRoZSBwZXItQ1BVIGludGVycnVw
dHMgYXJlIG5vdyB1c2VkDQo+ID4gZm9yIG1vcmUgdGhhdCBJUElzIGFuZCB0aW1lcnMsIHN1Y2gg
YXMgaW4gdGhlIEh5cGVyLVYgY2FzZSwgYW5kDQo+ID4gaGFuZGxlX3BlcmNwdV9kZXZpZF9pcnEo
KSB3YXMgbmV2ZXIgcmVjb25zaWRlcmVkIGluIHRoYXQgbGlnaHQuIEkgd291bGQNCj4gPiBleHBl
Y3QgYSByZWx1Y3RhbmNlIHRvIGJ1cmRlbiB0aGUgSVBJIGFuZCB0aW1lciBpbnRlcnJ1cHQgcGF0
aHMgd2l0aCB0aGUNCj4gPiBvdmVyaGVhZCBvZiBhZGRfaW50ZXJydXB0X3JhbmRvbW5lc3MoKS4g
QnV0IHRoZSBIeXBlci1WIFZNQnVzIGNhc2UNCj4gPiBzdGlsbCBuZWVkcyBpdCBiZWNhdXNlIHRo
YXQncyB0aGUgcHJpbWFyeSBzb3VyY2Ugb2YgaW50ZXJydXB0IGVudHJvcHkgaW4gdGhlDQo+ID4g
Vk0uIFRoZXJlIGFyZW4ndCBuZWNlc3NhcmlseSBvdGhlciBkZXZpY2VzIGdlbmVyYXRpbmcgbm9u
LXBlci1DUFUgaW50ZXJydXB0cw0KPiA+IGxpa2UgaW4gYSBwaHlzaWNhbCBtYWNoaW5lLiBUbyBt
ZSwgaXQgaXMgcGVyZmVjdGx5IHZhbGlkIGZvciB0aGUgSVBJICYgdGltZXINCj4gPiBpbnRlcnJ1
cHQgcGF0aHMgdG8gd2FudCB0byBza2lwIGludGVycnVwdCByYW5kb21uZXNzLCB3aGlsZSB0aGUN
Cj4gPiBIeXBlci1WIFZNQnVzIGludGVycnVwdCBwYXRoIG5lZWRzIGl0LCBhbmQgd2Ugd2lsbCBi
ZSBiYWNrIHdoZXJlIHdlDQo+ID4gYXJlIG5vdy4NCj4gDQo+IEJ1dCBpZiB0aGF0IGlzIHlvdXIg
Y29uY2VybiwgZG9uJ3QgeW91IGhhdmUgb3Igc2hvdWxkIGhhdmUgc29tZXRoaW5nDQo+IHNpbWls
YXIgdG8gdmlydGlvLXJuZyB3aGVyZSB5b3UgY2FuIGZlZWQgaGlnaCBxdWFsaXR5IHJhbmRvbSBk
YXRhIHRvIHRoZQ0KPiBndWVzdD8NCg0KSHlwZXItViBwcm92aWRlcyBhIG1vZGVzdCBwb29sIG9m
IGVudHJvcHkgYXQgVk0gYm9vdCB0aW1lLCBpbiB0aGUgZm9ybQ0Kb2YgYSB2ZW5kb3Itc3BlY2lm
aWMgQUNQSSB0YWJsZS4gSXQgaXMgY29uc3VtZWQgYnkgdGhlIGd1ZXN0IGluIHRoZSBmdW5jdGlv
bg0KbXNfaHlwZXJ2X2xhdGVfaW5pdCgpIGZvciB0aGUgcHVycG9zZSBvZiBzZWVkaW5nIHRoZSBM
aW51eCByYW5kb20NCm51bWJlciBnZW5lcmF0b3IsIGFuZCB3b3JrcyBvbiBib3RoIHg4Ni94NjQg
YW5kIGFybTY0Lg0KDQpCdXQgdGhpcyBpcyBhIG9uZS1zaG90IG9wZXJhdGlvbiBhdCBib290IHRp
bWUuIEh5cGVyLVYgZG9lcyBub3QgcHJvdmlkZQ0KZ3Vlc3RzIHdpdGggYW4gb25nb2luZyBzb3Vy
Y2Ugb2YgZW50cm9weSBsaWtlIHZpcnRpby1ybmcsIHNvIHRoZSBndWVzdA0KbXVzdCBnZW5lcmF0
ZSBpdHMgb3duLiBBbmQgaWYgdGhlIGd1ZXN0IGRvZXMgYSBrZXhlYygpLCB0aGUgbmV3IGtlcm5l
bA0KZG9lc24ndCBldmVuIGdldCB0byBzdGFydCB3aXRoIHRoYXQgQUNQSSB0YWJsZSBlbnRyb3B5
Lg0KDQpNaWNoYWVsDQoNCj4gDQo+ID4gUmVsYXRlZCwgKm5vdCogZG9pbmcgYWRkX2ludGVycnVw
dF9yYW5kb21uZXNzKCkgb24gdGhlIEFSTTY0IEh5cGVyLVYNCj4gPiBzeW50aGV0aWMgdGltZXIg
cGF0aCBpcyBjb25zaXN0ZW50IHdpdGggdGhlIEFSTTY0IGFyY2hpdGVjdHVyYWwgdGltZXIsIHNp
bmNlDQo+ID4gaXQgYWxzbyB1c2VzIGhhbmRsZV9wZXJjcHVfZGV2aWRfaXJxKCkuIEkgZGlkIHRo
ZSBvcmlnaW5hbCB3b3JrIHRvIGdldCB0aGUNCj4gPiBIeXBlci1WIHN5bnRoZXRpYyB0aW1lcnMg
d29ya2luZyBvbiBBUk02NCBiYWNrIGluIDIwMTkgKD8pLCBidXQgSSBkb24ndA0KPiA+IHJlY2Fs
bCBpZiB0aGF0IGNvbnNpc3RlbmN5IHdpdGggdGhlIEFSTTY0IGFyY2hpdGVjdHVyYWwgdGltZXIg
d2FzDQo+ID4gaW50ZW50aW9uYWwgb3IgYWNjaWRlbnRhbC4NCj4gPg0KPiA+IEFnYWluLCBJJ2xs
IHJhaXNlIHRoaXMgd2l0aCB0aGUgYXBwcm9wcmlhdGUgbWFpbnRhaW5lcnMgYW5kIHNlZSB3aGF0
IHRoZQ0KPiA+IGZlZWRiYWNrIGlzLg0KPiANCj4gQWdhaW4sIHRoYW5rIHlvdS4NCj4gDQo+ID4g
TWljaGFlbA0KPiANCj4gU2ViYXN0aWFuDQoNCg==

