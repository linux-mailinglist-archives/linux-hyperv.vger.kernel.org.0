Return-Path: <linux-hyperv+bounces-7959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F296CA2442
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Dec 2025 04:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F20303C999
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Dec 2025 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C462DEA9E;
	Thu,  4 Dec 2025 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GQPYLjYd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012049.outbound.protection.outlook.com [52.103.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA72D6E55;
	Thu,  4 Dec 2025 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764819351; cv=fail; b=MilXChVsOui5XgmpcYX42ZlzvR6Gtjc5jNglS8arQrTZAypSDFU2Mz0iQxZ3WdAMNSf3uLfNhM1iUnJfx8lpnb1+bRNUK0kHn6jNn+WyXpBo0zDSqgKv3qyJVfbfwIQScjBv4979n4iNS234Mgwu1vBOSCu02VKABcOTfE31eM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764819351; c=relaxed/simple;
	bh=vVcSGF+wHPHGVvJ2u1NNRpydfeWdVS3PL10dGeQO/D4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YP8Y2KvQIjkTOOtE8jPOhXuus2amunuSAgSZeK39VacTHbVsFUAIIfG+npx0EPbWZ8n+SL7HyKPufbhp6FCc99Beado/h79RcXOwXqR+IVP2qhW9Hb3+gedyVSsaJK9aLsVt0AYLIXOeqLXW9NeJxz43IYnvOXDDMcGw4/0OZeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GQPYLjYd; arc=fail smtp.client-ip=52.103.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYUjNfyXvWBCw66iLwzK8txPNtp9WZy9cbCUN21up6SO+elIZIodI6MJHZP20T9KWJE/1xvqSbAFzD2RU7vnWn+ytL4Ov8K188nvMtsoN8l/SnJ+wzRmNezTp7p0qtYRVlHIIvHTNaDskS0Fjf8j9PHgip6K0A7SheN5nfVpO9vSTD5RIrQmwnXgP8yxkqpqaogI7FDrqab03aJvi/Jx1J1m+lg2OoXpCapAlaWIYQtf0yYpfTUXUSX6Nj6woKreqwQ55Gxup+/qZz2GGEDKB8j8ZE1yN4USYKIEzxtltoVYjzpMSL45/wYO2gIpZzUpwqIifLmmuj7H9W46g446mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVcSGF+wHPHGVvJ2u1NNRpydfeWdVS3PL10dGeQO/D4=;
 b=DFqKKzdcm0ZpSPUahuK3eMusNoxZvrV2U2JlnJFd+FTWGWayqrOO6uaEbNNrtNvIeCxJlSdc1hkg2JKo/M5dlQb4aLEUZb6sVWX/l78UZw4qksY5X4lcM3vxa8wjHUcMoQDcAyipFajpReQGibEOBi6+X8PTNMgEX4hKYOZZxySQ4rvWnviejAwTqsuXzWCl3qEYgX7uZWEpeLVW0WI/NGPtn4SQh+TPegwfr1TAKEhKfUJOSlRq0MvshnyvmFhfZe+6Q7ElkxLq0UQRQTBMLVej5/kGbhY9jkKL3R7WcgQFR+1IPNvUrkT4mFoxDhtzZdVATF4U0xGjhPTa8GvxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVcSGF+wHPHGVvJ2u1NNRpydfeWdVS3PL10dGeQO/D4=;
 b=GQPYLjYdcPKzLkxtwawKkKl/pK8H3iUjuxiKU4AhqTyVo+p3mXBT9VrQreIl/ctvuZQZIZz591rsEgkknRo4eW9V3Ab+tzF5k3IcHg5MzaPqEITFPDMFrE12wm2Aa1BFMT8NSvNZXNA0RpfXrwwctEJ306Sna3hU39aoNU8Na5LDHUv+P6zgyrWvfLGhfR6ODD6YFk8EuhJRq1mdSkV5ugQPhiADBswft1Zd8/BkHG1bkeeTHR6KRl0Edoojp58BT93+SG9U1TwXzjitGVdQTYnuRdrv6wOJzznVDmnLuhw6AgROel6VWK2AyN0gZqqeOG9Kgeoeux47gSUi7IXaTA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9554.namprd02.prod.outlook.com (2603:10b6:610:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 03:35:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 03:35:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>, Tianyu Lan
	<tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory
 support
Thread-Topic: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory
 support
Thread-Index: AQHcXXBK+tjOpvoLpkujwICroliGzLUIRIrAgAfAwwCAAM8f8A==
Date: Thu, 4 Dec 2025 03:35:44 +0000
Message-ID:
 <SN6PR02MB4157FB57619785BAA50B3586D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251124182920.9365-1-tiala@microsoft.com>
 <SN6PR02MB4157DAE6D8CC6BA11CA87298D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMvTesCbNYHjiwaZC4EJopErZhW+vM0d87zJ54RT_AKXb-2yjw@mail.gmail.com>
In-Reply-To:
 <CAMvTesCbNYHjiwaZC4EJopErZhW+vM0d87zJ54RT_AKXb-2yjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9554:EE_
x-ms-office365-filtering-correlation-id: a009fffa-4186-4dce-7e87-08de32e63541
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|461199028|8062599012|8060799015|15080799012|41001999006|13091999003|19110799012|31061999003|52005399003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXpRR1FQVnh5SVJWT2xDcnVtTUs1WlRUOWt1WThKWVlKQWkwVmtOZnlFVWtG?=
 =?utf-8?B?a3p3Ty9MYVBuZnFPMGxJcnN1eWkyWnpXRjNSNWRWcGZYSXBMOWV1MkdWaGZ5?=
 =?utf-8?B?NGYxNjZKQk1oZlVzWUV2R2E2eGpSa0s2c1RJdnFQNjlHY0lNQ2J5djMvMjN5?=
 =?utf-8?B?UUN4QWlCcGRuMFJmYUo1ZlYxV1dVcnd0ZGZkUVpGQVgrQ0FscEw0a0k3VjU2?=
 =?utf-8?B?cmh4c0ZObVd2bUJ1SHFaWlNiVkhtUk1PeFc5U0VxcFMwMnlaS2EzelZ4dDla?=
 =?utf-8?B?QUFoUVRwMGx3czNEc2dxcHRzNWwvUURsQnFVZHJmMUYvNDRtQ08yMzYvVUtO?=
 =?utf-8?B?dDJkb1JUaEpFYm91MWRkS2NUUUg0MDRPT1Zld01nSXBKWHhMVEM5eUorM2xP?=
 =?utf-8?B?Q1Q1cWM5Y3NLeG5tZzU3enBkZkU3VXdiempqRGptc2lJdUV4UlVlWUlzMVBI?=
 =?utf-8?B?R0QvL251Tk9EK0p4N3dCQURlUUFKQm9YcncyNWtnaW90TWd6Mm5DcDRjYm1k?=
 =?utf-8?B?T0Y3cUFrM2JQaE0xanFMOWQrWm84RyticjRHdzdHc3lJRmZoT01zbVBQajdW?=
 =?utf-8?B?MWZIZUs0ak5QR3pyV1ptWll6NWcvQnpsVkR5cGhXbXdoK3VhQm5aVklsb0pE?=
 =?utf-8?B?NkxOVlFQWU11RmZLZ2JLTGRTL2RjYjlKZ1NXcDJCY2NtOEQ1bTNDYU5taTRr?=
 =?utf-8?B?QmN3dWplMHZVYXN6V2lob1RXQUNnOXhESlAxZXdpSnUyQ2VVKzdpTnlhaXhk?=
 =?utf-8?B?M2R4bVBqcEVyQTlGNE5hQ0FmK0wvWFNxbkxsdE9IQ25TVGtwTjlrU08yQzY2?=
 =?utf-8?B?Uk01dEJ1VnhQU0JraGJiVnhvOHVJQjVEWi9UcGZEaUM0RjRRWXpxRW9HYVhB?=
 =?utf-8?B?aysxL1E4NldsUDE2MGRmU0FGYUJDQWljS1RZTFhzZXo1V0ZBQjVnRmNYUFBV?=
 =?utf-8?B?ZGZpMG9NSVhoODFCL01WS3BBR3JWenlaeVdLcHNOZTBqMTBDT25Ca1J0Tkh6?=
 =?utf-8?B?T3RNV212bTdOOVhnNmpjT2s1LzNLd3gzTUhQRXpuL3pnc1Fpdk1TU0JJMDBk?=
 =?utf-8?B?RktlempJUEhiUHlGcitQR3l3eldxN3dLOEFYUThNaTFsa0lwTkJYUzZ1Ykxi?=
 =?utf-8?B?ZWFqUWF5S3dDQWlTVDZ5Q3hPN1V4OU81NWZWVmlRdmJFNzBZMjdVNW5Kd2dr?=
 =?utf-8?B?eExLSHU5Vk5Pb0ttVzREaklUejMzZG1ZNGFmaVF2bTAzd3JrcFJydHE1dmNU?=
 =?utf-8?B?b28yM1EvU282UUZwM08xRmZnOHZiazN5OG5YTSszclQveUxlQnpVei9ObVZo?=
 =?utf-8?B?czdGeVd4MHViYXNMbGc0V09rR2dlU3c1RE02R25KUTJhSmtOZ1FsY3NSL3pm?=
 =?utf-8?B?Y2VHa3lkRkw1RGtSZWFDb296VWs4dDJqbVdEWTcxQUkydmU1MmtoQlNhVDYw?=
 =?utf-8?B?UnlLSzE5cm5uMCtnbldaRE9vSzI0cG9KdFRGV291dnB2aHk1a01IZ1BGYWFH?=
 =?utf-8?B?dERFczJCNlVhRFQ5Z1JQRW81TSs1b3FneFNxR2s0QWRtSExWcld2THloMzVu?=
 =?utf-8?B?ZlMxQVVoYWFKRzJYUnc3VzJENnhGZXdxOVVWa0xXRzhudXRoSk84SnEvS25q?=
 =?utf-8?B?ZGMxNnVUcnVhQXlzL0FrOEtNR2t5RmorT0ROZmxUNjhHUWdFbzhsS0d1RFVP?=
 =?utf-8?B?cXk0OERya1VYdlpmWk5JdlIzTzBXMjJtRGxUUUM1SUkyMzhZRHNRdnZRPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE9EZmRDdGV2WGtRbWZSckhOdHI3TDVWOUJVY0xlcGxNeEZpd3lrclozYU9Z?=
 =?utf-8?B?aFU0Qm9vUkJWNUwwYTVzalZDMm9tV2RQTmxWeDRxSVZLNi95YlFIZ0ZaWmpQ?=
 =?utf-8?B?N2ZjZUxBSGFjV1NCMS9ZKzJqN0dSNndyM1RRdUgzb0ovMU5KaEhCaTlWR1NE?=
 =?utf-8?B?VkFJRmpKb0RDeG9aVjd2OEVhOUhlNGN2eUFRN0RNOG4wcktoSForMEdkZWt2?=
 =?utf-8?B?bDdtTmhZMUJucEtTL2RBY0QwV2drdzVMVGswRkJLZVdpa2FBUVcvSjZEWHM3?=
 =?utf-8?B?UUNlTEMvL0NaM0VaRXZGczZ2NzY1dGJrSkp4aWMzRGdSZTJaajVTM2hYckVC?=
 =?utf-8?B?RjFXVk9yU2xGVE9SNEY5ZE5sTzcxUkhodXRTTyt5MExKckl1Wm5vMkVza3BV?=
 =?utf-8?B?ODYvek1wNWpsQys4RXdVRXo5UDNkaFVIakw3bHBwRmhWdy9kSHF6aTU0M250?=
 =?utf-8?B?Yk5nSERLbGF1SVY3U3orOFlaaDFwdTZDdUZIUWhvUk5wMytGdnFGMVRablpn?=
 =?utf-8?B?UCtHdGM1T0hiV0N3M0tUZnpEOXNWbDBqcXpHMmtuMFovQzdLTmZRRkR2a0dN?=
 =?utf-8?B?SnlEdVFMWGxkT1ZnbnhpTTBTalZxQlQza2d1RUNuMUhQNlBCUHpmZmVEL0k1?=
 =?utf-8?B?QkJvL0JPMVNuTHE2T20vOXlmYjBxenFjdlhrRTRraTFJaDhXOWpSdU9naGQ4?=
 =?utf-8?B?Um55UFhGc2w2Y1ZaTVJNa0VPQ0JoQVJDMzJqd25scjBBalY2bUlib3RtYSsv?=
 =?utf-8?B?TmE1UHRzMzNqVWpZK0VJdFgwQ3hYcC9pbHhlaVg5eUxOYnoyRkN0REFYeWFh?=
 =?utf-8?B?cFdDUmtVeXQxSlBwcGdPU1FCOHF4Qkptb2V0VGkzcjl2cEl0dDZjNzNUTTFY?=
 =?utf-8?B?WkQ2eFQ1Nnkzb1U5MjhKNVlEM3F2MGo0QmFSRHljQjZPeldPblFkb3JONXA4?=
 =?utf-8?B?VHB0VTJESGQyYVE0Y3NFZmpmRGlPUnhQVTVRRWlGNUhzdUhYeW9DdHArbnFN?=
 =?utf-8?B?VEZUQmFIYzVUeEJxcFNhenFiSlh4cXZHc0JzWWMvUjkveDROSlQ0UWlMRW5J?=
 =?utf-8?B?eEZ0emZERkROOW1OcW9PQjUvNnhrMURBSDAwdnN0ODlOVXM5QzFkNnVKRFUz?=
 =?utf-8?B?OU9YNit1dmg3aXNxU1JxZlA4SE1EYTlGeFhhdWtmcnd1Rm9YamV5Vk8reXN0?=
 =?utf-8?B?Z1djZEhMd2tzaUxuZDRoVzVNUGhiVkJqRkIrQWY0T01lWGorWm92SjdwbmdQ?=
 =?utf-8?B?c1lWek5GVjBpcHNaZVh5SlU5TUZMMzVvYjZKdU9Nc0hxMllOSXNlY2hiQ1Jm?=
 =?utf-8?B?R0c0WlpNczdSN2ZrTy9BQWhzeEhxVE9tTHF6OWhCY0FCRjhzUkZqZkVrdGtF?=
 =?utf-8?B?T3dLUE5YbDhWVm14R2NzYy9sMmhEaWNFYzNydVJGTENrelhBMThmSDJzWnp3?=
 =?utf-8?B?ODhXTlVmd3oya3hJeUswMVdqaFdOUjQ1S1RsU0lKRkZJdEhPUXV1Z0daUkJF?=
 =?utf-8?B?K21sUVNGTmxEdHYyeTc4SHhzdGljZHQxMW9OWGJRK0NaT0hDdUZtNjFuWkw0?=
 =?utf-8?B?MGVscXArbSs5TkFVMkkzbm1PbVNBWkZJR2kzWmFSc3cyenhZRWw2aXlaWVFs?=
 =?utf-8?Q?+mk998N5EU2JmsVdDhIvRExmCI4AabZbxRI6BaO/FEFY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a009fffa-4186-4dce-7e87-08de32e63541
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 03:35:45.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9554

RnJvbTogVGlhbnl1IExhbiA8bHR5a2VybmVsQGdtYWlsLmNvbT4gU2VudDogV2VkbmVzZGF5LCBE
ZWNlbWJlciAzLCAyMDI1IDY6MjEgQU0NCj4gDQo+IE9uIFNhdCwgTm92IDI5LCAyMDI1IGF0IDE6
NDfigK9BTSBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gRnJvbTogVGlhbnl1IExhbiA8bHR5a2VybmVsQGdtYWlsLmNvbT4gU2VudDogTW9uZGF5
LCBOb3ZlbWJlciAyNCwgMjAyNSAxMDoyOSBBTQ0KDQpbc25pcF0NCg0KPiA+DQo+ID4gSGVyZSdz
IG15IGlkZWEgZm9yIGFuIGFsdGVybmF0ZSBhcHByb2FjaC4gIFRoZSBnb2FsIGlzIHRvIGFsbG93
IHVzZSBvZiB0aGUNCj4gPiBzd2lvdGxiIHRvIGJlIGRpc2FibGVkIG9uIGEgcGVyLWRldmljZSBi
YXNpcy4gQSBkZXZpY2UgaXMgaW5pdGlhbGl6ZWQgZm9yIHN3aW90bGINCj4gPiB1c2FnZSBieSBz
d2lvdGxiX2Rldl9pbml0KCksIHdoaWNoIHNldHMgZGV2LT5kbWFfaW9fdGxiX21lbSB0byBwb2lu
dCB0byB0aGUNCj4gPiBkZWZhdWx0IHN3aW90bGIgbWVtb3J5LiAgRm9yIFZNQnVzIGRldmljZXMs
IHRoZSBjYWxsaW5nIHNlcXVlbmNlIGlzDQo+ID4gdm1idXNfZGV2aWNlX3JlZ2lzdGVyKCkgLT4g
ZGV2aWNlX3JlZ2lzdGVyKCkgLT4gZGV2aWNlX2luaXRpYWxpemUoKSAtPg0KPiA+IHN3aW90bGJf
ZGV2X2luaXQoKS4gQnV0IGlmIHZtYnVzX2RldmljZV9yZWdpc3RlcigpIGNvdWxkIG92ZXJyaWRl
IHRoZQ0KPiA+IGRldi0+ZG1hX2lvX3RsYl9tZW0gdmFsdWUgYW5kIHB1dCBpdCBiYWNrIHRvIE5V
TEwsIHN3aW90bGIgb3BlcmF0aW9ucw0KPiA+IHdvdWxkIGJlIGRpc2FibGVkIG9uIHRoZSBkZXZp
Y2UuIEZ1cnRoZXJtb3JlLCBpc19zd2lvdGxiX2ZvcmNlX2JvdW5jZSgpDQo+ID4gd291bGQgcmV0
dXJuICJmYWxzZSIsIGFuZCB0aGUgbm9ybWFsIERNQSBmdW5jdGlvbnMgd291bGQgbm90IGZvcmNl
IHRoZQ0KPiA+IHVzZSBvZiBib3VuY2UgYnVmZmVycy4gVGhlIGVudGlyZSBjb2RlIGNoYW5nZSBs
b29rcyBsaWtlIHRoaXM6DQo+ID4NCj4gPiAtLS0gYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+
ID4gKysrIGIvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiA+IEBAIC0yMTMzLDExICsyMTMzLDE1
IEBAIGludCB2bWJ1c19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGh2X2RldmljZSAqY2hpbGRfZGV2
aWNlX29iaikNCj4gPiAgICAgICAgIGNoaWxkX2RldmljZV9vYmotPmRldmljZS5kbWFfbWFzayA9
ICZjaGlsZF9kZXZpY2Vfb2JqLT5kbWFfbWFzazsNCj4gPiAgICAgICAgIGRtYV9zZXRfbWFzaygm
Y2hpbGRfZGV2aWNlX29iai0+ZGV2aWNlLCBETUFfQklUX01BU0soNjQpKTsNCj4gPg0KPiA+ICsg
ICAgICAgZGV2aWNlX2luaXRpYWxpemUoJmNoaWxkX2RldmljZV9vYmotPmRldmljZSk7DQo+ID4g
KyAgICAgICBpZiAoY2hpbGRfZGV2aWNlX29iai0+Y2hhbm5lbC0+Y29fZXh0ZXJuYWxfbWVtb3J5
KQ0KPiA+ICsgICAgICAgICAgICAgICBjaGlsZF9kZXZpY2Vfb2JqLT5kZXZpY2UuZG1hX2lvX3Rs
Yl9tZW0gPSBOVUxMOw0KPiA+ICsNCj4gPiAgICAgICAgIC8qDQo+ID4gICAgICAgICAgKiBSZWdp
c3RlciB3aXRoIHRoZSBMRE0uIFRoaXMgd2lsbCBraWNrIG9mZiB0aGUgZHJpdmVyL2RldmljZQ0K
PiA+ICAgICAgICAgICogYmluZGluZy4uLndoaWNoIHdpbGwgZXZlbnR1YWxseSBjYWxsIHZtYnVz
X21hdGNoKCkgYW5kIHZtYnVzX3Byb2JlKCkNCj4gPiAgICAgICAgICAqLw0KPiA+IC0gICAgICAg
cmV0ID0gZGV2aWNlX3JlZ2lzdGVyKCZjaGlsZF9kZXZpY2Vfb2JqLT5kZXZpY2UpOw0KPiA+ICsg
ICAgICAgcmV0ID0gZGV2aWNlX2FkZCgmY2hpbGRfZGV2aWNlX29iai0+ZGV2aWNlKTsNCj4gPiAg
ICAgICAgIGlmIChyZXQpIHsNCj4gPiAgICAgICAgICAgICAgICAgcHJfZXJyKCJVbmFibGUgdG8g
cmVnaXN0ZXIgY2hpbGQgZGV2aWNlXG4iKTsNCj4gPiAgICAgICAgICAgICAgICAgcHV0X2Rldmlj
ZSgmY2hpbGRfZGV2aWNlX29iai0+ZGV2aWNlKTsNCj4gPg0KPiA+IEkndmUgb25seSBjb21waWxl
IHRlc3RlZCB0aGUgYWJvdmUgc2luY2UgSSBkb24ndCBoYXZlIGFuIGVudmlyb25tZW50IHdoZXJl
DQo+ID4gSSBjYW4gdGVzdCBDb25maWRlbnRpYWwgVk1CdXMuIFlvdSB3b3VsZCBuZWVkIHRvIHZl
cmlmeSB3aGV0aGVyIG15IHRoaW5raW5nDQo+ID4gaXMgY29ycmVjdCBhbmQgdGhpcyBwcm9kdWNl
cyB0aGUgaW50ZW5kZWQgcmVzdWx0Lg0KPiANCj4gVGhhbmtzIE1pY2hhZWwuIEkgdGVzdGVkIGl0
IGFuZCBpdCBzZWVtcyB0byBoaXQgYW4gaXNzdWUuIFdpbGwgZG91YmxlIGNoZWNrLndpdGgNCj4g
SENML3BhcmF2aXNvciB0ZWFtLg0KPiANCj4gIFdlIGNvbnNpZGVyZWQgc3VjaCBhIGNoYW5nZSBi
ZWZvcmUuIEZyb20gUm9tYW4ncyBwcmV2aW91cyBwYXRjaCwgaXQgc2VlbXMgdG8NCj4gbmVlZCB0
byBjaGFuZ2UgcGh5c190b19kbWEoKSBhbmQgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKCkuDQoNCklu
IGEgSHlwZXItViBTRVYtU05QIFZNIHdpdGggYSBwYXJhdmlzb3IsIEkgYXNzZXJ0IHRoYXQgcGh5
c190b19kbWEoKSBhbmQNCl9fcGh5c190b19kbWEoKSBkbyB0aGUgc2FtZSB0aGluZy4gIHBoeXNf
dG9fZG1hKCkgY2FsbHMgZG1hX2FkZHJfZW5jcnlwdGVkKCksDQp3aGljaCBkb2VzIF9fc21lX3Nl
dCgpLiAgQnV0IGluIGEgSHlwZXItViBWTSB1c2luZyB2VE9NLCBzbWVfbWVfbWFzayBpcw0KYWx3
YXlzIDAsIHNvIGRtYV9hZGRyX2VuY3J5cHRlZCgpIGlzIGEgbm8tb3AuICBkbWFfYWRkcl91bmVu
Y3J5cHRlZCgpIGFuZA0KZG1hX2FkZHJfY2Fub25pY2FsKCkgYXJlIGFsc28gbm8tb3BzLiBTZWUg
aW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5oLiBTbw0KaW4gYSBIeXBlci1WIFNFVi1TTlAgVk0s
IHRoZSBETUEgbGF5ZXIgZG9lc24ndCBjaGFuZ2UgYW55dGhpbmcgcmVsYXRlZCB0bw0KZW5jcnlw
dGlvbiB3aGVuIHRyYW5zbGF0aW5nIGJldHdlZW4gYSBwaHlzaWNhbCBhZGRyZXNzIGFuZCBhIERN
QSBhZGRyZXNzLg0KU2FtZSB0aGluZyBpcyB0cnVlIGZvciBhIEh5cGVyLVYgVERYIFZNIHdpdGgg
cGFyYXZpc29yLg0KDQpmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoKSB3aWxsIGluZGVlZCByZXR1cm4g
InRydWUiLCBhbmQgaXQgaXMgdXNlZCBpbg0KcGh5c190b19kbWFfZGlyZWN0KCkuIEJ1dCBib3Ro
IHJldHVybiBwYXRocyBpbiBwaHlzX3RvX2RtYV9kaXJlY3QoKSByZXR1cm4gdGhlDQpzYW1lIHJl
c3VsdCBiZWNhdXNlIG9mIGRtYV9hZGRyX3VuZW5jcnlwdGVkKCkgYW5kIGRtYV9hZGRyX2VuY3J5
cHRlZCgpDQpiZWluZyBuby1vcHMuIE90aGVyIHVzZXMgb2YgZm9yY2VfZG1hX3VuZW5jcnlwdGVk
KCkgYXJlIG9ubHkgaW4gdGhlDQpkbWFfYWxsb2NfKigpIHBhdGhzLCBidXQgZG1hX2FsbG9jXyoo
KSBpc24ndCB1c2VkIGJ5IFZNQnVzIGRldmljZXMgYmVjYXVzZQ0KdGhlIGRldmljZSBjb250cm9s
IHN0cnVjdHVyZXMgYXJlIGluIHRoZSByaW5nIGJ1ZmZlciwgd2hpY2ggYXMgeW91IGhhdmUgbm90
ZWQsIGlzDQphbHJlYWR5IGhhbmRsZWQgc2VwYXJhdGVseS4gU28gZm9yIHRoZSBtb21lbnQsIEkg
ZG9uJ3QgdGhpbmsgdGhlIHJldHVybiB2YWx1ZQ0KZnJvbSBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQo
KSBtYXR0ZXJzLg0KDQpTbyBJJ20gZ3Vlc3Npbmcgc29tZXRoaW5nIGVsc2UgdW5leHBlY3RlZCBp
cyBoYXBwZW5pbmcgc3VjaCB0aGF0IGp1c3QgZGlzYWJsaW5nDQp0aGUgc3dpb3RsYiBvbiBhIHBl
ci1kZXZpY2UgYmFzaXMgZG9lc24ndCB3b3JrLiBBc3N1bWluZyB0aGF0IFJvbWFuJ3Mgb3JpZ2lu
YWwNCnBhdGNoIGFjdHVhbGx5IHdvcmtlZCwgSSdtIHRyeWluZyB0byBmaWd1cmUgb3V0IGhvdyBt
eSBpZGVhIGlzIGRpZmZlcmVudCBpbiBhIHdheQ0KdGhhdCBoYXMgYSBtYXRlcmlhbCBlZmZlY3Qg
b24gdGhpbmdzLiBBbmQgaWYgeW91ciBwYXRjaCB3b3JrcyBieSBnb2luZyBkaXJlY3RseSB0bw0K
X19waHlzX3RvX2RtYSgpLCBpdCBzaG91bGQgYWxzbyB3b3JrIHdoZW4gdXNpbmcgcGh5c190b19k
bWEoKSBpbnN0ZWFkLg0KDQpJIHdpbGwgdHJ5IGEgZmV3IGV4cGVyaW1lbnRzIG9uIGEgbm9ybWFs
IENvbmZpZGVudGlhbCBWTSAoaS5lLiwgd2l0aG91dCBDb25maWRlbnRpYWwNClZNQnVzKSB0byBj
b25maXJtIHRoYXQgbXkgY29uY2x1c2lvbnMgZnJvbSByZWFkaW5nIHRoZSBjb2RlIHJlYWxseSBh
cmUgY29ycmVjdC4NCkZXSVcsIEknbSBsb29raW5nIGF0IHRoZSBsaW51eC1uZXh0MjAyNTExMTkg
Y29kZSBiYXNlLg0KDQpNaWNoYWVsDQoNCj4gDQo+ID4NCj4gPiBEaXJlY3RseSBzZXR0aW5nIGRt
YV9pb190bGJfbWVtIHRvIE5VTEwgaXNuJ3QgZ3JlYXQuIEl0IHdvdWxkIGJlIGJldHRlcg0KPiA+
IHRvIGFkZCBhbiBleHBvcnRlZCBmdW5jdGlvbiBzd2lvdGxiX2Rldl9kaXNhYmxlKCkgdG8gc3dp
b3RsYiBjb2RlIHRoYXQgc2V0cw0KPiA+IGRtYV9pb190bGJfbWVtIHRvIE5VTEwsIGJ1dCB5b3Ug
Z2V0IHRoZSBpZGVhLg0KPiA+DQo+ID4gT3RoZXIgcmV2aWV3ZXJzIG1heSBzdGlsbCBzZWUgdGhp
cyBhcHByb2FjaCBhcyBhIGJpdCBvZiBhIGhhY2ssIGJ1dCBpdCdzIGEgbG90DQo+ID4gbGVzcyBv
ZiBhIGhhY2sgdGhhbiBpbnRyb2R1Y2luZyBIeXBlci1WIHNwZWNpZmljIERNQSBmdW5jdGlvbnMu
DQo+ID4gc3dpb3RsYl9kZXZfZGlzYWJsZSgpIGlzIGNvbmNlcHR1YWxseSBuZWVkZWQgZm9yIFRE
SVNQIGRldmljZXMsIGFzIFRESVNQDQo+ID4gZGV2aWNlcyBtdXN0IHNpbWlsYXJseSBwcm90ZWN0
IGNvbmZpZGVudGlhbGl0eSBieSBub3QgYWxsb3dpbmcgdXNlIG9mIHRoZSBzd2lvdGxiLg0KPiA+
IFNvIGFkZGluZyBzd2lvdGxiX2Rldl9kaXNhYmxlKCkgaXMgYSBzdGVwIGluIHRoZSByaWdodCBk
aXJlY3Rpb24sIGV2ZW4gaWYgdGhlDQo+ID4gZXZlbnR1YWwgVERJU1AgY29kZSBkb2VzIGl0IHNs
aWdodGx5IGRpZmZlcmVudGx5LiBEb2luZyB0aGUgZGlzYWJsZSBvbiBhDQo+ID4gcGVyLWRldmlj
ZSBiYXNpcyBpcyBhbHNvIHRoZSByaWdodCB0aGluZyBpbiB0aGUgbG9uZyBydW4uDQo+ID4NCg==

