Return-Path: <linux-hyperv+bounces-10134-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCZrKaQK3WngZAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10134-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 17:24:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA033EDE50
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A61303A8D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312123B95E7;
	Mon, 13 Apr 2026 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QYn3zUjd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012081.outbound.protection.outlook.com [52.103.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792871E9919;
	Mon, 13 Apr 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093586; cv=fail; b=XUlgWNsoHPjF7EbY2oT489Sw3Bf5ShX+UpoYaFCPyUdQM4bi3ELTUCAeGUUcAH4Y7vUcC9NDLBFZL/JpM928mp4CHsgdTCKDPVaPOt+GGRq3mQSgeqKoB0JmzKw9JlISI7K5UsSkA6GkcfzKNiBsYGRLRTbq2yRLb1osmAtQz3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093586; c=relaxed/simple;
	bh=eRpirEY2yKRuJlLfufoaGq3kMQ3qyc2dQDQhL3MlpoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjWR6x8pNLcCnN3u0GQg8bbo6aYbQJCJK3x9vnux5v67WBhsVkuJ2Io6Jv4KnU0aICSPVm7qdCVU7s3PNlj+b3hKVJ8XnBUutUz0ymmh/gMiORdql1aGObZpcs6YTEjuZeAPVeG+yzvIn8va2S7VZdrc3r4FvmwL9EIRtevawmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QYn3zUjd; arc=fail smtp.client-ip=52.103.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdqG5U7qnnO8a5X0IGRqb8umHy0rO7RuJXa84ysjsik9q4zKj5Y/mfkF1qgaOjh1IaIBJRgQAnRTcdDWtJidVyfFKxEirrDfGCIpeeFBMTe+gSeOsRa0DnKkECYINwERrb53ArKuN6SmE3kxR7WMageQZL0r7BHCIWrVt9L2kJcTr47q811cdF3bO0bS6edcDdM4jbyZj6XZedR3rfHavElR74+hiRZrKsLNLE4CGzIoFDbsg4KD3fUvHjQ+fUzAi8MAmWl6fupsvvQE/iwrbcuxSADw2oVBxcBFfkz0ySZ2eMkoI1SgtjFm5KFMIz+OlLa9j3criFbvg+ReS3oLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRpirEY2yKRuJlLfufoaGq3kMQ3qyc2dQDQhL3MlpoA=;
 b=pGIDTDew+SYPBbM/UfjZvNKYE2+ABWSTXD6l9nA9wPmkGKittEVQT4elG5ONooBRldL+rGvXm2OJLNTQYOaKuaOjdzYpkv77yIVlQB5swrsn0ssoSUBf3GOQWLzMTl+zVgrWeGzcCiqaKaVu2YtiSvIhBaSuVRLltjk9Kv8R4xPYqLlVzYuV58n24WcNVCfzWzD52v6AtQdus4MPMO3uB29YaSL+bZR9yhHv+wkVQnymqQ3BGWntf7Ui9jYXH/iukycdeniGobiBzYqb8fyjmz+iFnv6cc0u8PX5F6+9EqczqLnv2ShIMMKDjrx5uc4BTCDZj4LxRl/8vBwEkNUhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRpirEY2yKRuJlLfufoaGq3kMQ3qyc2dQDQhL3MlpoA=;
 b=QYn3zUjdQii/tOELUVZfOPvvpz5PCxIAIa0kMbAq78HKEai6qnp3T80bfuWaRnL0UrW/QJAdcnJq8SFyGM9/ae2nqOpL1lbpJfVtCq1Y1xA+ALZJNiFcJK7JY6aK4N+CK28e4Q+qoyIBSLILu54hR3PuNVWrpxdt7M5PbpOpZp8o/tqw6aUYpUDEX38EoQue0XoyqP7FdyFZr+2fjDal4df6bnU417fE4lgi1W1u4EYcTTPqU5IgEnb130KTqth76w+lPmGwXJX3SmQPSNIEvQ+bkgW2berkrL3pLCNbSjtvVeMa0kIcYokMWNzyB3iC/ZfCzM+MwnHL6/ci2qKoow==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV2PR02MB11107.namprd02.prod.outlook.com (2603:10b6:408:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 15:19:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 15:19:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 04/11] Drivers: hv: Refactor mshv_vtl for ARM64 support to
 be added
Thread-Topic: [PATCH 04/11] Drivers: hv: Refactor mshv_vtl for ARM64 support
 to be added
Thread-Index: AQHctT5V2BuRVBWyKkCpWfaIbANGJbXKhn/ggBKFRwCAADucwA==
Date: Mon, 13 Apr 2026 15:19:40 +0000
Message-ID:
 <SN6PR02MB4157BD69EBAA3890F326ABEFD4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-5-namjain@linux.microsoft.com>
 <SN6PR02MB41573C4A21BA96A534E5429CD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fe4c0663-4ece-439c-bcb6-cd5780c15ed9@linux.microsoft.com>
In-Reply-To: <fe4c0663-4ece-439c-bcb6-cd5780c15ed9@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV2PR02MB11107:EE_
x-ms-office365-filtering-correlation-id: 2134bcb0-63ec-46bd-916d-08de9970156e
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|37011999003|51005399006|13091999003|461199028|19110799012|8062599012|15080799012|8060799015|41001999006|40105399003|3412199025|440099028|102099032|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1dUektkbVdjL3pUR3hxYlludUtyL1NYN3cvNi9qZjFZTGNRSlg1LzBUUDk5?=
 =?utf-8?B?NXpPWldxV1Y1ZzkrR1o5Um1YVXpGUjd1aTVEU2tHc0lhQ2pvM1FsaVRMVkYy?=
 =?utf-8?B?OWRoR1lKMFpCWTI4WVpSSVVnVytLZjZaSTdxUXY0MzRmdWp3T1RZRkpWMVkr?=
 =?utf-8?B?VjRxcjZHTVgvdy9vYjR6dlVGY3ZrZ1lGZ3dsSm90bkNlK2NhZzA5dDFkMzJD?=
 =?utf-8?B?QWNFSzFqV2lNVVdVUlZKVXJ2QW12MElEK2lMZDVvRDYzakV6THk3SCtKQ0ZL?=
 =?utf-8?B?N2RFZGlLb29uMnM0TFl2Q1BaWmVVdnp0L21oODA1NnIzNkE4dE1DM01vWVZi?=
 =?utf-8?B?QkUzTkhicFgxeDJoUWQvL1dtR3JMWUx3cFdiNnJ4Y0xIRW9vNjl0bU1FWkZJ?=
 =?utf-8?B?OG5NZXM1OVdkOU9UZTNJb0ZibXRqSlp0eUFnTmpBSmhjSG1yWGxsMVlyVGZU?=
 =?utf-8?B?OUkwZW9qU0V3NDljMHE4cHJpcnlwdkZ2UnNVTDJ2NmZFYk5KVWVqa3EyeFJq?=
 =?utf-8?B?TVpWYUF5dGsxdmxPcDMwcDlsQWxxUERHRU0zMXpabGd3VXFvcUR6ZG9JaEx0?=
 =?utf-8?B?Tk5YRzNiSkNrVVVmdDZGVXlxN09EOWtJUzlQUnNVOTJNL0JPMU1uVFJ6cDFr?=
 =?utf-8?B?QlVoa0tvSmZId2pYZEl5MkdhOVFrMjRnRFo4aEZPOGhzcW9pYzdGTEwzUzk2?=
 =?utf-8?B?cXBDT2dPUU1tQThLYjI4eEEwQjZSUERHS1h1Z095K0gvdzhqeWs0Q2R5ZHBU?=
 =?utf-8?B?c2VJc0RZaDl5RFhGMmhKVUIxMEtOcFVxMGtSbXE1NEFPSzRNUk5pdkhzTy9Z?=
 =?utf-8?B?YzJzSHhHb2VnczJwTUhmelpHdzZnQVBQY1lqZ2J6ajN2aGlyaUh6UG55WjRx?=
 =?utf-8?B?ZjNhN0dLQzNNNlhtNmxYV25ZK0c4R2dzYWtSeXJUSXBrbHJlR3l3OFNYOVA5?=
 =?utf-8?B?SjVsdUlLRVdBYndxOVlyRldxbjV4bStrZzdySmJlaytPdDBTaThkUFBwNlFU?=
 =?utf-8?B?M0cwYUVkRGJQLy9rMnBXMUZ4eUcvRkRiditqV2xhUC9sbDBzZlNFUWE2M1hQ?=
 =?utf-8?B?WUhMWFNZQ3hlV1lCaElFa2x0bmxzWFdhV0V3Y2pNRWVkaEhwVnBEeFdSVUJa?=
 =?utf-8?B?V3RGY0kyZEhqekM2aXJ0dktjNDBydlJUTzJ6dDhmUklpaUhTb3BpSHpnUHU4?=
 =?utf-8?B?NTFNd2tTTEhiWW5OTVhNME1HRjl1Q3JSTWZ0NmswQmVJL2RNK2JEU3BCb2Mz?=
 =?utf-8?B?MTJCQjRKSmpERkRaZHdZcnhLYms2aVA1aGVzbjZBWmVxeE02ZVlvL29QTml5?=
 =?utf-8?B?MXZFdzlHRDltZXZMMkI0dWZHVkhlRDlNRU1oeVZrM0srbFZkQ2p2b2RYT1h5?=
 =?utf-8?B?WjQ1Q0FWRzZ0SWprdDIwVG0vSnIzakpZUGF3RUcySHVjQmZzS2FJRkFzZ1dF?=
 =?utf-8?Q?/WHs99ca?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LysyQTJndVRoSnJzb1BNYTZGa0lEWmJhR2k1SjZ4bFpsWkhLTnkwZUN1TVBL?=
 =?utf-8?B?WmJEclVNS3ExV2V0QjdmUWFNaU40UnFiSlNoSlNUM3JKMTZLYmF5S05WS3RY?=
 =?utf-8?B?L3crV0ZUS2FFaFByMG9aQy8zQ3BXNXdYZEJ5L3BvT1pzMXhRaXpGemg3OUpU?=
 =?utf-8?B?K0FWVnh3S2prRkZLbmY5Uk9tTXhlYXEvL3ltMGdJYnJaM1VpcjJVRjNMLytT?=
 =?utf-8?B?YjdWZFdQdXlpZzJzY2llc01yWmpDckQ2SEk2bi82d2crcVJUTlpHOUNKWUtL?=
 =?utf-8?B?YTJrWk1VRGpKSHNMTXZYWHVrS2xhV05aV29VbjFVTjhXMWJnQ2o1cDl3cE8v?=
 =?utf-8?B?K3hFR0w0N1RKdGRQZTYyMXhwMmh5aitqVGlHbDNRWVg0TEs4RHhzOUxiK2gx?=
 =?utf-8?B?dWJLVmp2OFZvZzlMRGlHd1FDWDVvVkJSbExuYjJtd0VUQzBXK3ZVVDdtYmtF?=
 =?utf-8?B?S245akZ0aWpoWkxHNWoyWjc2QlJxZnJwNkJWdFJYSzJFZVdzR0pMM0VXU1Rl?=
 =?utf-8?B?Y0gwZFZieDBqeHE2QVloWWx4UDNlMVVsM04rUjRHclRYMjJpL0ZnQ1FWSm41?=
 =?utf-8?B?ZHAzeSs1WjAySG1UZU5CbTh1c0pLcEI3TTFUZk82Y1l5Z2ZhOXRvVmFZUjly?=
 =?utf-8?B?OXBUNTJlNG82NWVuNHF4TDEray8yVm1raGFPS0lITEptVnRpWndMRkxYajR4?=
 =?utf-8?B?NlNZZzZQNEpScnIrMFVyUCswbnRla0NBelNGRjVNRGhENU5SY0lMMVVLMW15?=
 =?utf-8?B?L2luQ3dEbTJBd3pZbWpCUFZkV2t3Z29kRTc0ZXpxeHdtNVNvMWd1c3JDaEZx?=
 =?utf-8?B?dnUwUG1VQlFYQUFreVVLd3BwYm10eUtFeERBdE44RUJXVmhCQnlWdklUcnN3?=
 =?utf-8?B?SWRHK2NCMG9kem5TL2JicXYxSEZaUisxKzNvQzVtQ0pYTkdOUXVWTlFpQ3Yx?=
 =?utf-8?B?T0s1WVZlZy9jQ1JIYWUzc21jVURQNVVycnhXajhKQlV3ZUk2Mmd2QU1jZ1JB?=
 =?utf-8?B?K2QyS05UOW00Q1lWWktacUhxNmdla3JPazV2K1I2N09YdGNwMHFvYlUwT1dt?=
 =?utf-8?B?Tm8yWHBNTTlja0dmREVUanF4YUxOZHNTUnhFVmNZeFpIdUsyZHRxelFjVmlq?=
 =?utf-8?B?SnltREZaenZBV1ZyN1I5NEJqZUNxYkxtR1hGVUttMnFrV3dFdllxaDBpVTVs?=
 =?utf-8?B?WWhIMStOOFpyN1dYK0F5L3dzU2RKMzhFSzZZV3BaVmx2UGQxYms4OVBZNzBy?=
 =?utf-8?B?TWdxV0x5SnhrTGxFcFZNT2JxbnhkTEJWT2prM20yQXJhVEpCMm1KV1UzRTU0?=
 =?utf-8?B?RjRQY2ZkZ3M1bk5kQURoV2JoZ1E3dnF4YW51dDFoZmh2cVJIVjNrTnZPVTVC?=
 =?utf-8?B?c1FKSEVYbnRHZVNkcytCaWtVcFZQMVFOTldMdlBQMStRYTB4cDJ6bXZCU2ZV?=
 =?utf-8?B?WDF1OGlXWkxxbzYvVnREYVlSa2hha2ZPbCtJeDJmK2RBYm1YeDhxbWNPcW5V?=
 =?utf-8?B?OE5jbXBoWm1EMWlBRDZrODZuT0w3QjBzcGZ2NStsa05SdHVvNDhFVnhvK3c0?=
 =?utf-8?B?cXpqd3FSRWd4bWNSWlFCYUFNanBKNVd5akJaRklZOERySWEzbWdSMUdDYWM0?=
 =?utf-8?B?VlNHSHBrTHRqOWtjYWhyTmRIWlFtaTB6Y1BnZGRaMzdaOEJGY3ZReXUvQm5W?=
 =?utf-8?B?NEFqZ3MrcUphR0lZakZkYms2MVNRU3V3aGxZR1lnaTVSYW9Dck5hSEJyaHFN?=
 =?utf-8?B?WThRWjNSV2QzbzVqR2JYRnliMGZ4bFlXWGNmSWdReXJMWkRsMXdkeXljajRT?=
 =?utf-8?Q?WGSUZ//KMdgAKVAEJ4i+0UQNxeMTMxmar9S7E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2134bcb0-63ec-46bd-916d-08de9970156e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 15:19:40.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11107
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10134-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4DA033EDE50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEFwcmlsIDEzLCAyMDI2IDQ6NDYgQU0NCj4gDQo+IE9uIDQvMS8yMDI2IDEwOjI2IFBNLCBN
aWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4
Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTYsIDIwMjYNCj4gNToxMyBBTQ0K
PiA+Pg0KPiA+PiBSZWZhY3RvciBNU0hWX1ZUTCBkcml2ZXIgdG8gbW92ZSBzb21lIG9mIHRoZSB4
ODYgc3BlY2lmaWMgY29kZSB0byBhcmNoDQo+ID4+IHNwZWNpZmljIGZpbGVzLCBhbmQgYWRkIGNv
cnJlc3BvbmRpbmcgZnVuY3Rpb25zIGZvciBhcm02NC4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1i
eTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiAgIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCB8ICAxMCArKysNCj4g
Pj4gICBhcmNoL3g4Ni9oeXBlcnYvaHZfdnRsLmMgICAgICAgICAgfCAgOTggKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2Lmgg
ICB8ICAgMSArDQo+ID4+ICAgZHJpdmVycy9odi9tc2h2X3Z0bF9tYWluLmMgICAgICAgIHwgMTAy
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAgIDQgZmlsZXMgY2hhbmdlZCwg
MTExIGluc2VydGlvbnMoKyksIDEwMCBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNoeXBlcnYuaA0KPiA+PiBiL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20vbXNoeXBlcnYuaA0KPiA+PiBpbmRleCBiNzIxZDMxMzRhYjYuLjgwNDA2OGUw
OTQxYiAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tc2h5cGVydi5o
DQo+ID4+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNoeXBlcnYuaA0KPiA+PiBAQCAt
NjAsNiArNjAsMTYgQEAgc3RhdGljIGlubGluZSB1NjQgaHZfZ2V0X25vbl9uZXN0ZWRfbXNyKHVu
c2lnbmVkIGludCByZWcpDQo+ID4+ICAgCQkJCUFSTV9TTUNDQ19TTUNfNjQsCQlcDQo+ID4+ICAg
CQkJCUFSTV9TTUNDQ19PV05FUl9WRU5ET1JfSFlQLAlcDQo+ID4+ICAgCQkJCUhWX1NNQ0NDX0ZV
TkNfTlVNQkVSKQ0KPiA+PiArI2lmZGVmIENPTkZJR19IWVBFUlZfVlRMX01PREUNCj4gPj4gKy8q
DQo+ID4+ICsgKiBHZXQvU2V0IHRoZSByZWdpc3Rlci4gSWYgdGhlIGZ1bmN0aW9uIHJldHVybnMg
YDFgLCB0aGF0IG11c3QgYmUgZG9uZSB2aWENCj4gPj4gKyAqIGEgaHlwZXJjYWxsLiBSZXR1cm5p
bmcgYDBgIG1lYW5zIHN1Y2Nlc3MuDQo+ID4+ICsgKi8NCj4gPj4gK3N0YXRpYyBpbmxpbmUgaW50
IGh2X3Z0bF9nZXRfc2V0X3JlZyhzdHJ1Y3QgaHZfcmVnaXN0ZXJfYXNzb2MgKnJlZ3MsIGJvb2wg
c2V0LCB1NjQgc2hhcmVkKQ0KPiA+PiArew0KPiA+PiArCXJldHVybiAxOw0KPiA+PiArfQ0KPiA+
PiArI2VuZGlmDQo+ID4+DQo+ID4+ICAgI2luY2x1ZGUgPGFzbS1nZW5lcmljL21zaHlwZXJ2Lmg+
DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9oeXBlcnYvaHZfdnRsLmMgYi9hcmNo
L3g4Ni9oeXBlcnYvaHZfdnRsLmMNCj4gPj4gaW5kZXggOWI2YTliYzRhYjc2Li43MmEwYmI0YWUw
YzcgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gveDg2L2h5cGVydi9odl92dGwuYw0KPiA+PiArKysg
Yi9hcmNoL3g4Ni9oeXBlcnYvaHZfdnRsLmMNCj4gPj4gQEAgLTE3LDYgKzE3LDggQEANCj4gPj4g
ICAjaW5jbHVkZSA8YXNtL3JlYWxtb2RlLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGFzbS9yZWJvb3Qu
aD4NCj4gPj4gICAjaW5jbHVkZSA8YXNtL3NtYXAuaD4NCj4gPj4gKyNpbmNsdWRlIDx1YXBpL2Fz
bS9tdHJyLmg+DQo+ID4+ICsjaW5jbHVkZSA8YXNtL2RlYnVncmVnLmg+DQo+ID4+ICAgI2luY2x1
ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPiA+PiAgICNpbmNsdWRlIDwuLi9rZXJuZWwvc21wYm9vdC5o
Pg0KPiA+PiAgICNpbmNsdWRlICIuLi8uLi9rZXJuZWwvZnB1L2xlZ2FjeS5oIg0KPiA+PiBAQCAt
MjgxLDMgKzI4Myw5OSBAQCB2b2lkIG1zaHZfdnRsX3JldHVybl9jYWxsKHN0cnVjdCBtc2h2X3Z0
bF9jcHVfY29udGV4dCAqdnRsMCkNCj4gPj4gICAJa2VybmVsX2ZwdV9lbmQoKTsNCj4gPj4gICB9
DQo+ID4+ICAgRVhQT1JUX1NZTUJPTChtc2h2X3Z0bF9yZXR1cm5fY2FsbCk7DQo+ID4+ICsNCj4g
Pj4gKy8qIFN0YXRpYyB0YWJsZSBtYXBwaW5nIHJlZ2lzdGVyIG5hbWVzIHRvIHRoZWlyIGNvcnJl
c3BvbmRpbmcgYWN0aW9ucyAqLw0KPiA+PiArc3RhdGljIGNvbnN0IHN0cnVjdCB7DQo+ID4+ICsJ
ZW51bSBodl9yZWdpc3Rlcl9uYW1lIHJlZ19uYW1lOw0KPiA+PiArCWludCBkZWJ1Z19yZWdfbnVt
OyAgLyogLTEgaWYgbm90IGEgZGVidWcgcmVnaXN0ZXIgKi8NCj4gPj4gKwl1MzIgbXNyX2FkZHI7
ICAgICAgIC8qIDAgaWYgbm90IGFuIE1TUiAqLw0KPiA+PiArfSByZWdfdGFibGVbXSA9IHsNCj4g
Pj4gKwkvKiBEZWJ1ZyByZWdpc3RlcnMgKi8NCj4gPj4gKwl7SFZfWDY0X1JFR0lTVEVSX0RSMCwg
MCwgMH0sDQo+ID4+ICsJe0hWX1g2NF9SRUdJU1RFUl9EUjEsIDEsIDB9LA0KPiA+PiArCXtIVl9Y
NjRfUkVHSVNURVJfRFIyLCAyLCAwfSwNCj4gPj4gKwl7SFZfWDY0X1JFR0lTVEVSX0RSMywgMywg
MH0sDQo+ID4+ICsJe0hWX1g2NF9SRUdJU1RFUl9EUjYsIDYsIDB9LA0KPiA+PiArCS8qIE1UUlIg
TVNScyAqLw0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfQ0FQLCAtMSwgTVNSX01U
UlJjYXB9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfREVGX1RZUEUsIC0xLCBN
U1JfTVRSUmRlZlR5cGV9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19C
QVNFMCwgLTEsIE1UUlJwaHlzQmFzZV9NU1IoMCl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJf
TVNSX01UUlJfUEhZU19CQVNFMSwgLTEsIE1UUlJwaHlzQmFzZV9NU1IoMSl9LA0KPiA+PiArCXtI
Vl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19CQVNFMiwgLTEsIE1UUlJwaHlzQmFzZV9NU1Io
Mil9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19CQVNFMywgLTEsIE1U
UlJwaHlzQmFzZV9NU1IoMyl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZ
U19CQVNFNCwgLTEsIE1UUlJwaHlzQmFzZV9NU1IoNCl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNU
RVJfTVNSX01UUlJfUEhZU19CQVNFNSwgLTEsIE1UUlJwaHlzQmFzZV9NU1IoNSl9LA0KPiA+PiAr
CXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19CQVNFNiwgLTEsIE1UUlJwaHlzQmFzZV9N
U1IoNil9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19CQVNFNywgLTEs
IE1UUlJwaHlzQmFzZV9NU1IoNyl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJf
UEhZU19CQVNFOCwgLTEsIE1UUlJwaHlzQmFzZV9NU1IoOCl9LA0KPiA+PiArCXtIVl9YNjRfUkVH
SVNURVJfTVNSX01UUlJfUEhZU19CQVNFOSwgLTEsIE1UUlJwaHlzQmFzZV9NU1IoOSl9LA0KPiA+
PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19CQVNFQSwgLTEsIE1UUlJwaHlzQmFz
ZV9NU1IoMHhhKX0sDQo+ID4+ICsJe0hWX1g2NF9SRUdJU1RFUl9NU1JfTVRSUl9QSFlTX0JBU0VC
LCAtMSwgTVRSUnBoeXNCYXNlX01TUigweGIpfSwNCj4gPj4gKwl7SFZfWDY0X1JFR0lTVEVSX01T
Ul9NVFJSX1BIWVNfQkFTRUMsIC0xLCBNVFJScGh5c0Jhc2VfTVNSKDB4Yyl9LA0KPiA+PiArCXtI
Vl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19CQVNFRCwgLTEsIE1UUlJwaHlzQmFzZV9NU1Io
MHhkKX0sDQo+ID4+ICsJe0hWX1g2NF9SRUdJU1RFUl9NU1JfTVRSUl9QSFlTX0JBU0VFLCAtMSwg
TVRSUnBoeXNCYXNlX01TUigweGUpfSwNCj4gPj4gKwl7SFZfWDY0X1JFR0lTVEVSX01TUl9NVFJS
X1BIWVNfQkFTRUYsIC0xLCBNVFJScGh5c0Jhc2VfTVNSKDB4Zil9LA0KPiA+PiArCXtIVl9YNjRf
UkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNLMCwgLTEsIE1UUlJwaHlzTWFza19NU1IoMCl9LA0K
PiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNLMSwgLTEsIE1UUlJwaHlz
TWFza19NU1IoMSl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNL
MiwgLTEsIE1UUlJwaHlzTWFza19NU1IoMil9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNS
X01UUlJfUEhZU19NQVNLMywgLTEsIE1UUlJwaHlzTWFza19NU1IoMyl9LA0KPiA+PiArCXtIVl9Y
NjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNLNCwgLTEsIE1UUlJwaHlzTWFza19NU1IoNCl9
LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNLNSwgLTEsIE1UUlJw
aHlzTWFza19NU1IoNSl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19N
QVNLNiwgLTEsIE1UUlJwaHlzTWFza19NU1IoNil9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJf
TVNSX01UUlJfUEhZU19NQVNLNywgLTEsIE1UUlJwaHlzTWFza19NU1IoNyl9LA0KPiA+PiArCXtI
Vl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNLOCwgLTEsIE1UUlJwaHlzTWFza19NU1Io
OCl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNLOSwgLTEsIE1U
UlJwaHlzTWFza19NU1IoOSl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZ
U19NQVNLQSwgLTEsIE1UUlJwaHlzTWFza19NU1IoMHhhKX0sDQo+ID4+ICsJe0hWX1g2NF9SRUdJ
U1RFUl9NU1JfTVRSUl9QSFlTX01BU0tCLCAtMSwgTVRSUnBoeXNNYXNrX01TUigweGIpfSwNCj4g
Pj4gKwl7SFZfWDY0X1JFR0lTVEVSX01TUl9NVFJSX1BIWVNfTUFTS0MsIC0xLCBNVFJScGh5c01h
c2tfTVNSKDB4Yyl9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfUEhZU19NQVNL
RCwgLTEsIE1UUlJwaHlzTWFza19NU1IoMHhkKX0sDQo+ID4+ICsJe0hWX1g2NF9SRUdJU1RFUl9N
U1JfTVRSUl9QSFlTX01BU0tFLCAtMSwgTVRSUnBoeXNNYXNrX01TUigweGUpfSwNCj4gPj4gKwl7
SFZfWDY0X1JFR0lTVEVSX01TUl9NVFJSX1BIWVNfTUFTS0YsIC0xLCBNVFJScGh5c01hc2tfTVNS
KDB4Zil9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfRklYNjRLMDAwMDAsIC0x
LCBNU1JfTVRSUmZpeDY0S18wMDAwMH0sDQo+ID4+ICsJe0hWX1g2NF9SRUdJU1RFUl9NU1JfTVRS
Ul9GSVgxNks4MDAwMCwgLTEsIE1TUl9NVFJSZml4MTZLXzgwMDAwfSwNCj4gPj4gKwl7SFZfWDY0
X1JFR0lTVEVSX01TUl9NVFJSX0ZJWDE2S0EwMDAwLCAtMSwgTVNSX01UUlJmaXgxNktfQTAwMDB9
LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfRklYNEtDMDAwMCwgLTEsIE1TUl9N
VFJSZml4NEtfQzAwMDB9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfRklYNEtD
ODAwMCwgLTEsIE1TUl9NVFJSZml4NEtfQzgwMDB9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJf
TVNSX01UUlJfRklYNEtEMDAwMCwgLTEsIE1TUl9NVFJSZml4NEtfRDAwMDB9LA0KPiA+PiArCXtI
Vl9YNjRfUkVHSVNURVJfTVNSX01UUlJfRklYNEtEODAwMCwgLTEsIE1TUl9NVFJSZml4NEtfRDgw
MDB9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfRklYNEtFMDAwMCwgLTEsIE1T
Ul9NVFJSZml4NEtfRTAwMDB9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfRklY
NEtFODAwMCwgLTEsIE1TUl9NVFJSZml4NEtfRTgwMDB9LA0KPiA+PiArCXtIVl9YNjRfUkVHSVNU
RVJfTVNSX01UUlJfRklYNEtGMDAwMCwgLTEsIE1TUl9NVFJSZml4NEtfRjAwMDB9LA0KPiA+PiAr
CXtIVl9YNjRfUkVHSVNURVJfTVNSX01UUlJfRklYNEtGODAwMCwgLTEsIE1TUl9NVFJSZml4NEtf
RjgwMDB9LA0KPiA+PiArfTsNCj4gPj4gKw0KPiA+PiAraW50IGh2X3Z0bF9nZXRfc2V0X3JlZyhz
dHJ1Y3QgaHZfcmVnaXN0ZXJfYXNzb2MgKnJlZ3MsIGJvb2wgc2V0LCB1NjQgc2hhcmVkKQ0KPiA+
PiArew0KPiA+PiArCXU2NCAqcmVnNjQ7DQo+ID4+ICsJZW51bSBodl9yZWdpc3Rlcl9uYW1lIGdw
cl9uYW1lOw0KPiA+PiArCWludCBpOw0KPiA+PiArDQo+ID4+ICsJZ3ByX25hbWUgPSByZWdzLT5u
YW1lOw0KPiA+PiArCXJlZzY0ID0gJnJlZ3MtPnZhbHVlLnJlZzY0Ow0KPiA+PiArDQo+ID4+ICsJ
LyogU2VhcmNoIGZvciB0aGUgcmVnaXN0ZXIgaW4gdGhlIHRhYmxlICovDQo+ID4+ICsJZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUocmVnX3RhYmxlKTsgaSsrKSB7DQo+ID4+ICsJCWlmIChyZWdf
dGFibGVbaV0ucmVnX25hbWUgIT0gZ3ByX25hbWUpDQo+ID4+ICsJCQljb250aW51ZTsNCj4gPj4g
KwkJaWYgKHJlZ190YWJsZVtpXS5kZWJ1Z19yZWdfbnVtICE9IC0xKSB7DQo+ID4+ICsJCQkvKiBI
YW5kbGUgZGVidWcgcmVnaXN0ZXJzICovDQo+ID4+ICsJCQlpZiAoZ3ByX25hbWUgPT0gSFZfWDY0
X1JFR0lTVEVSX0RSNiAmJiAhc2hhcmVkKQ0KPiA+PiArCQkJCWdvdG8gaHlwZXJjYWxsOw0KPiA+
PiArCQkJaWYgKHNldCkNCj4gPj4gKwkJCQluYXRpdmVfc2V0X2RlYnVncmVnKHJlZ190YWJsZVtp
XS5kZWJ1Z19yZWdfbnVtLCAqcmVnNjQpOw0KPiA+PiArCQkJZWxzZQ0KPiA+PiArCQkJCSpyZWc2
NCA9IG5hdGl2ZV9nZXRfZGVidWdyZWcocmVnX3RhYmxlW2ldLmRlYnVnX3JlZ19udW0pOw0KPiA+
PiArCQl9IGVsc2Ugew0KPiA+PiArCQkJLyogSGFuZGxlIE1TUnMgKi8NCj4gPj4gKwkJCWlmIChz
ZXQpDQo+ID4+ICsJCQkJd3Jtc3JsKHJlZ190YWJsZVtpXS5tc3JfYWRkciwgKnJlZzY0KTsNCj4g
Pj4gKwkJCWVsc2UNCj4gPj4gKwkJCQlyZG1zcmwocmVnX3RhYmxlW2ldLm1zcl9hZGRyLCAqcmVn
NjQpOw0KPiA+PiArCQl9DQo+ID4+ICsJCXJldHVybiAwOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+
PiAraHlwZXJjYWxsOg0KPiA+PiArCXJldHVybiAxOw0KPiA+PiArfQ0KPiA+PiArRVhQT1JUX1NZ
TUJPTChodl92dGxfZ2V0X3NldF9yZWcpOw0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vbXNoeXBlcnYuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCj4g
Pj4gaW5kZXggZjY0MzkzZTg1M2VlLi5kNTM1NWE1Yjc1MTcgMTAwNjQ0DQo+ID4+IC0tLSBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCj4gPj4gKysrIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbXNoeXBlcnYuaA0KPiA+PiBAQCAtMzA0LDYgKzMwNCw3IEBAIHZvaWQgbXNodl92dGxf
cmV0dXJuX2NhbGwoc3RydWN0IG1zaHZfdnRsX2NwdV9jb250ZXh0DQo+ICp2dGwwKTsNCj4gPj4g
ICB2b2lkIG1zaHZfdnRsX3JldHVybl9jYWxsX2luaXQodTY0IHZ0bF9yZXR1cm5fb2Zmc2V0KTsN
Cj4gPj4gICB2b2lkIG1zaHZfdnRsX3JldHVybl9oeXBlcmNhbGwodm9pZCk7DQo+ID4+ICAgdm9p
ZCBfX21zaHZfdnRsX3JldHVybl9jYWxsKHN0cnVjdCBtc2h2X3Z0bF9jcHVfY29udGV4dCAqdnRs
MCk7DQo+ID4+ICtpbnQgaHZfdnRsX2dldF9zZXRfcmVnKHN0cnVjdCBodl9yZWdpc3Rlcl9hc3Nv
YyAqcmVncywgYm9vbCBzZXQsIHU2NCBzaGFyZWQpOw0KPiA+DQo+ID4gQ2FuIHRoaXMgbW92ZSB0
byBhc20tZ2VuZXJpYy9tc2h5cGVydi5oPyAgVGhlIGZ1bmN0aW9uIGlzIG5vIGxvbmdlciBzcGVj
aWZpYw0KPiA+IHRvIHg4Ni94NjQsIHNvIG9uZSB3b3VsZCB3YW50IHRvIG5vdCBkZWNsYXJlIGl0
IGluIHRoZSBhcmNoL3g4NiB2ZXJzaW9uDQo+ID4gb2YgbXNoeXBlcnYuaC4gQnV0IG1heWJlIG1v
dmluZyBpdCB0byBhc20tZ2VuZXJpYy9tc2h5cGVydi5oIGJyZWFrcw0KPiA+IGNvbXBpbGF0aW9u
IG9uIGFybTY0IGJlY2F1c2UgdGhlcmUncyBhbHNvIHRoZSBzdGF0aWMgaW5saW5lIHN0dWIgdGhl
cmUuDQo+IA0KPiBUaGlzIGlzIHN0aWxsIGFyY2ggc3BlY2lmaWMgKHg4NiB0byBiZSBwcmVjaXNl
KS4gRm9yIEFSTTY0LCB3ZSBhbHdheXMNCj4gd2FudCB0byByZXR1cm4gMSwgd2hpY2ggaXMgdG8g
dGVsbCB0aGUgY2xpZW50IHRvIHVzZSBoeXBlcmNhbGwgYXMgYQ0KPiBmYWxsYmFjayBvcHRpb24u
IE1vdmluZyB0aGlzIHg4NiBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiAoWDY0IHJlZ2lzdGVycywN
Cj4gTVRSUiBldGMpIHRvIGEgY29tbW9uIGNvZGUsIHdvdWxkIG5vdCBiZSByaWdodC4gT25lIHRo
aW5nIHRoYXQgY291bGQgYmUNCj4gZG9uZSBoZXJlIHdhcyB0byBtb3ZlIHRoZSAicmV0dXJuIDEi
IHN0dWIgY29kZSBmcm9tIGFybTY0IHRvIGFzbS1nZW5lcmljDQo+IG1zaHlwZXJ2LmgsIGJ1dCB0
aGF0IHdvdWxkIG5vdCBwcm92aWRlIG11Y2ggYmVuZWZpdC4NCj4gDQo+IEkgYW0gY3VycmVudGx5
IG5vdCBwbGFubmluZyB0byBtYWtlIGFueSBjaGFuZ2VzIGhlcmUuIElmIEkgbWlzdW5kZXJzdG9v
ZA0KPiB5b3VyIGNvbW1lbnQsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQoNClllcywgdGhlIGlt
cGxlbWVudGF0aW9uIG9mIGh2X3Z0bF9nZXRfc2V0X3JlZygpIGlzIGFyY2gtc3BlY2lmaWMuIEJ1
dCB0aGUNCm9uZS1saW5lIGRlY2xhcmF0aW9uIGlzIG5vdC4gSWYgdGhlcmUgd2FzIGEgZnVsbCBp
bXBsZW1lbnRhdGlvbiBvbiBhcm02NA0KbGlrZSB3aXRoIHg4NiwgdGhlbiB0aGUgZGVjbGFyYXRp
b24gY291bGQgbW92ZSB0byBhc20tZ2VuZXJpYy9tc2h5cGVydi5oLg0KQnV0IHRoZSBhcm02NCBz
aWRlIGlzIGEgInN0YXRpYyBpbmxpbmUiIGZ1bmN0aW9uLCBhbmQgSSdtIHByZXR0eSBzdXJlIHRo
ZQ0KYWJvdmUgZGVjbGFyYXRpb24gd291bGQgY2F1c2UgYSBjb21waWxlciBjb25mbGljdC4gIFNv
IG5vdCBtYWtpbmcgYW55DQpjaGFuZ2VzIGlzIGFwcHJvcHJpYXRlLiBJZiB0aGUgYXJtNjQgc2lk
ZSBzaG91bGQgZXZlciBjaGFuZ2UgdG8gYSBmdWxsDQppbXBsZW1lbnRhdGlvbiB0aGF0IGlzbid0
IHN0YXRpYyBpbmxpbmUsIHRoZW4gdGhlIG9uZS1saW5lIGRlY2xhcmF0aW9uDQpzaG91bGQgbW92
ZSB0byBhc20tZ2VuZXJpYy9tc2h5cGVydi5oLg0KDQpJIHByb2JhYmx5IHNob3VsZCBoYXZlIG9t
aXR0ZWQgbXkgY29tbWVudCBlbnRpcmVseSBhcyBpdCB3YXMganVzdA0KbXVzaW5nIGFib3V0IGEg
c2l0dWF0aW9uIHRoYXQgZG9lc24ndCBhY3R1YWxseSBleGlzdCBhdCB0aGUgbW9tZW50LiA6LSgN
Cg0KTWljaGFlbA0K

