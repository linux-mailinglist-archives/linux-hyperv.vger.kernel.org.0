Return-Path: <linux-hyperv+bounces-9492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CX+CjFBuWmB9QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9492-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 12:55:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E4D2A94DA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 12:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5404303A6EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FD3B5311;
	Tue, 17 Mar 2026 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H0GTyl1B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC253B4E82;
	Tue, 17 Mar 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748526; cv=fail; b=r9TQQw+WOrg0SG948hyiP3rxKG+A3JewLCjxDrWvA5z3OHKeEwacw7uouxFqALaVUhgKHajg7/a9OLKhuoHUmx5w25B7AN9gL+hHWsv6b4NRdWF00szrvTph5q+/Y21jilSWNfWMxyMODpJbRcGFgfZrPSK/pwhvwi4mvAABY4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748526; c=relaxed/simple;
	bh=iktLqjJxr1oBkOPYlfpcIc+4S6RE2kmWsyipfXthUxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpE5JNs3GscsI4VN5xfex1z1O4/xDY1LhqwIs4tHpW6qarkWWFsDf4R7g9he6wDAOv4dV5lwLmyqqrPz6GqNW/owkqEJ44/Aeme5HdFvJ77OHMryO/iBoTGAa8c5VpHgrnYVkKRbv5hSZjlzjWlsbIWja5hlaObzgF7wYwRG97Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=H0GTyl1B; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2TbEkIrjn4XZACbIBxAtWwKFPVaoBRturttFdgubrWyIFUnlNz4FWMIgmIQ+7qBYf4aE0GTNcMbXDS2HVzqJjZbcRWyFjaWJJYGD4pzINtdAYydaRL1tNHLAWpVxHTl/1glyFlchTPA8GaJibkz3U51Sr7L52jPgyLDCmD5TbBnJGmdjqzFU+6cbu8819ZQXhjV+eOAvBILpRLF77pSq+PmGua257p09f34YS/WBU9RblvLItH5xL95VIH+7VqNN0LPpwNlwKk0nI1r691+Xxn091Y7rxIhsFvECBGxXkh2T/cGTDI4rsjL9SCws6vxma8bviIN5bv65ERYtvUXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3Y3gBz33jVKbx0mahv2GoUGm054qp//T1huENLLZXY=;
 b=WlWGX+TGAJyTvr/sn1ArqbHb9xq+Fshb3Kqg6ixJGl0qUTlS0hX8L7ERkGsBvzToJQJuZ1VLS6AKGjBr/ceGEt+yM29+wzKz/SSdHCzcfpWuuTq5S4STCdRewHIgb35D8aWhr7u6pLY/u8zbKHMY9PztuEufm/PNHsktYxTdHrekHksA8YXqr+hzbtv6g0E+ViZdoN02lz6GPXdMUE7NKk9KwxkION5FVjBr78vTX+s8tTLIy6qn+9zFDTAl/FwEX217LgldeGhs3FakVWjxTy/GweFzh3rLR3YYTouLp6XgkxGvtVBj6973h6y5proJ7Z/ZJf95LYd+t1xzUq8qMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3Y3gBz33jVKbx0mahv2GoUGm054qp//T1huENLLZXY=;
 b=H0GTyl1Bzmh3Jy/9/0CPO83N9/4O7LfYpcjR2Z8ExRiL7Tp5giBukK+qW2Ixc1ADNjruKdforF7TPk5Jt1n+UC12AMLCJDjFsLWE+5ZyjQ7CcniHdT75SUHLsAQRR59nAnRvSLDFNr3UGzZ1SbhUDlAgzUcB7PjS8DUx3JuFONNXr4GQMIMFPiH1CIKxieIayKLu/CbmqNgcNFVpSw7apz32mR7nZlDfY+ZFlI341FTIw21WClYzRcAnyWCEr2xS6nPwQrbVsahbKEX4L0oYODkacUDvXVk8HO9YWsduF2FUy5PuplISSM7hN2pR3yUIOoOmFps5K46gVfXy7P3nSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:55:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 11:55:17 +0000
Message-ID: <1e15ac0d-9835-487c-9a16-c55203f01a3d@siemens.com>
Date: Tue, 17 Mar 2026 12:55:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <b0359046-3c58-47a6-b503-8a2b52cb1448@siemens.com>
 <20260317110128.k59TflVp@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260317110128.k59TflVp@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: e0645f0c-d424-472b-863b-08de841c0e5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TunyYDYbzyo8P9TKFnYBUEVIlD/V7sJ+a8WPKGe+ygSAzOgKnlZsQskaKh+oRCsGt5swzaxdAbn2eUCEYzjKJL+azpQUAnA3sRvtI0evgvRRdrjW9pQZUXdZ2ce3yZRuayie3eD47xtNGBq4KaGqFrYinbK4MWGWDw5jfMfh/PNGrwldAI9S8Lvm9GN/t9Ph2oKxBOIVK7peA2VQ1kTqfhpGd5BBJxLOTzo6rG6tRW0oFy1mtIFC6VwE3FhJ0T8h2tV/Q1VhQAETHzQ8zXsVzhsgGm4bBGVUia68E5usj1IJ5Ic3i5pftMp8NHXZRvAkegAyuC981bME7mpM7n7SUFA8VGxiyHSMab8JuM0MlOlFrZl4BOAzGOHkKlLlLUAzrAphaoWlrOTzYy4G0/yx1jKiIxKKlKfL+K2CAND6zppi2QWWuJ/8OhoCKBE0ksUkocw1DZ1z7EtAMAbkYAVR66HYoq5v0FRZ9MMoB1XiMjUlN3FHoRHNk7jAJVeiLb7pRlAniaKAtoFZBpoCE7HYDh5Z84OzouKHFN44YMSeI0rGvtxGMBhC33V0xPVWSddaMHyKS09xOtgbTzU/FxkHyuxxuMoNHOZ13TRtAW84eNvpMEygtsTyeBDSQi2oX5pQiRlj6kEouFlutJs9mzxZTGGHo957pQV26+AxTX8jd6vGLa5k6s8ou0zDX6F+8H2F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRta0RWRnY0MWdISXpKdC9Pb3FQbjgyaEhaV25idDNBc3QzbTBrQWhyVEVD?=
 =?utf-8?B?QTc3b2hiZWx6d2FvSTI4T24vQllRWGJybnBZWFkwMG41Ti9zV0NMZ1Q5QVFp?=
 =?utf-8?B?cWg5M1NCZjhwTjdSYll3Vk9rYmJLQXZyK2wrK1BrVWpHdkhieFRseHoyamVy?=
 =?utf-8?B?ZlZVWDVFdURocjZZYzBVNE9scUMvb2JveVVvcEZVbkE4WFlEQlJVaFVNWFd4?=
 =?utf-8?B?UHVqVXR3T0h4YjJUUHMvN1p5K2dPelpibDh5MlJPOGhycEFtYllYK3dPK1gv?=
 =?utf-8?B?VFRxZWE2L2FpVmowc3VVKzVMVXZBU2lCeVFuQ09YZmhFKy8vd3l1NE5saXZ6?=
 =?utf-8?B?MHRYODZVc0NKdTFxOUtHYzVObWRIV0N2REdoY0cvbGIwK0Fsem5PWXk0aytv?=
 =?utf-8?B?MGt6d2tGZHJhOWdEOUZWeSswbjdEU3ZDWERKQTR3MUFHOExFTDJOM2xOWno2?=
 =?utf-8?B?K1lEbFI0MWxiWjlYNWplUHJpdnBJLzk1REhHWDRwUmlJczRLemhvVFkyNk1W?=
 =?utf-8?B?ZzRKWXVhQkpNR0lmRU9GS0FCRFhaTmJEM0NoNTkwbmJrNVBYUnQ3V1hkUmFJ?=
 =?utf-8?B?NS9Nancra3lab285aVljVzF5bWNORjRhU0cySUNhdWN5eFd0bEk0QkwrcTMz?=
 =?utf-8?B?aXlFOWhhNURFVmpVQnhENFhJS0wrVk5FckZwMU9VaHhPZGhiLzFWN0hkcjFk?=
 =?utf-8?B?b01pc3E1TmRCaVI2WnpRZVNsRHA3WWFPY1JjWUN3WWlLcFhtL2RIc2E2Y2NF?=
 =?utf-8?B?L2k1T1Y0YVhqaG9rRk5tTVZuRUhEb2VuRUxPeGZQdjA3aDN3VTU4Z0paMXhv?=
 =?utf-8?B?eG5NRWpndlp6Yk1zbzFvWGJySjg4bXlROXRLUEs3SGZMNjdyOUxsT1czT3BX?=
 =?utf-8?B?T0lPNStEdzhFR1ZOTzBtTWx4QjZtZjdzNDhEWXZsQmpYOWh3cGlmZWZMZ0pT?=
 =?utf-8?B?dk1lcDFLdkx5aGNNbHdqWkRjY2l0VUI5S2VsMmd3MFZJY3h4ekxNQ1JXSThU?=
 =?utf-8?B?WlJnOGFaMWFxN3N0Y3Vnb013VU9IMXNOcFpPbEJ2RDA5bm9GSUFaVzRMTWhY?=
 =?utf-8?B?bzRwUlhPVmxhMlBQWU5UcmhrV2lWVVpvOG1NdGlhWjFMcGJTWXFwWEk2UG14?=
 =?utf-8?B?cU1Mc0ZsaUJoRlZiUlhZUzViQm42blR5L1IwYmMzR3lTVGtxdXZjbHJaaXZK?=
 =?utf-8?B?MFBCS1FSQko1Qm9uU0NSSGl6NEpYV3p6dkllRnh0VnYrRmxkNDF3bWFhMUpo?=
 =?utf-8?B?T1BpY2hMMTJBamxqSVo0c0M1V3JoRnBRQXlYQ3NsY3ZpVFhiRDNhV2gwTWhH?=
 =?utf-8?B?YVpVb1o1WGkwWmVpbm1XTDRxRVAwSXBMVk5kYkNxYWYxTll5bC8yazd3STEr?=
 =?utf-8?B?YTBYSGFmM3pVVklvOGtFQnErS3lnU1hLak80bVhGZkNOQnRyYllzL3ZkTjRY?=
 =?utf-8?B?NXB3QXNQYm5mb0RXVEhuK1AxYm1RVlZzVGUyMVUzcjM4ZzdRWHloMVBBV2hX?=
 =?utf-8?B?UTZ3SnBEYjM0QURMeTZ1OUpSK3RVU25sUC8yUGFhdFdYdlI2THVqbGwwbVVB?=
 =?utf-8?B?Z1JJeGd4d2c0OVliTStSNUdsK0IwWDhpTDhDV2tTQ3BPaExhZWRBK2tHZGFJ?=
 =?utf-8?B?OUlTUXBmUmJHZnkvYXZ6Y1J3UHN0NUs1ek1FbFVKcUtZVDZRQ2xIYStJRU50?=
 =?utf-8?B?enlCQkpEUjhDN2VaU3ZGVXpPbXppUEJOVTZraUtwcDVzeTRxZFQrSGRNT1dS?=
 =?utf-8?B?b2RvRTBxZFVIb0JKSXR1MGhKOEVFTjNxYlBHMG5aSUM3Tm9UT2VnZmhHQVJO?=
 =?utf-8?B?NG9Ba015dUNzWFpybWx1MVFHVG82b1MxckFaN2NYMXloelJINEhFWDVxOEZB?=
 =?utf-8?B?cU5qVmhOc1NuWE16Y1ZPVlBNdlN1QnVmYXBKTTh0aWZRMUJmYnhuYm5Sc0kz?=
 =?utf-8?B?K1JJdHkzVDlsanJJWWFMcFhxc2Q2MXZJYWNTNnBibDlES2NCM29TOGFzSGhS?=
 =?utf-8?B?TDNrTDZFN0d1N2w0b0hHMVFFV3hKQkRvbjZ1dHRWcXJIdmJNQ3JKa2RYcFJU?=
 =?utf-8?B?M2pCUEo3RXpLeHJNTWk4RXk1RG9hUHdjNVVDME5GRGNHYXRNa1pia3dqS25G?=
 =?utf-8?B?a3VtWXlhVC93WWlnQ1N4UXVYd05wUXkrYm5xQXJMaE15MU8rK01kLzlTT3BZ?=
 =?utf-8?B?ejhrVmJmZkJJNXJ5SE0rb2hpZkVFc2F0TUd6ODMzeW5CbUJxUGJoMkEydVFW?=
 =?utf-8?B?WjViQ21BVVJkS2E3NGtQUjdUK200NHdjc1JIcDFCaThEOWFJblFUaXJpTkdF?=
 =?utf-8?B?eVo3WGxVZzgvTlZzUTBWbGNtdkNSbnhSNmxDVVFIQWNGeUJxSnk1YTVFTTJD?=
 =?utf-8?Q?E6e37WgMspgKX10M=3D?=
X-Exchange-RoutingPolicyChecked:
	YezxTlP3wP7IULdfBGcqb6sN0kBfabnn4+LhMga3htqEoFWXA6ktKkCCyDnWBDbXnSxLG2CYw2jo7k0aRK2MuV5gZk8SvuZlfTNz5FNuLIcAOzIySTOBR5SrNgp4w0eQ8y5YrJt2aeA6UV/gES+C28n2qZzNs/HYarnkv5sNwytbx1C/U1huHdxB3mAC+ddtaEZ/uK2to5HfFXM/ymdw+WEWcoli/wtbOcOCEJJ9DUdygLEf7RiDwBQ+8Dx3lLtT1RVNLF0k0Nv+h23m++cOr4beyJNvYRhGay1sG/1CQ6tUnRaVzESOLj+KX8Q2reG2zToDGIcTPNfnVvntpWzmSg==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0645f0c-d424-472b-863b-08de841c0e5c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:55:16.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDQjc12rDlzQ8KML+c+7ldFZ7LMHNaD3ksUYww70CCygPVLx1W3i2aFQtqj5qv2A1H0FFM0Clog63DuY797qRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5340
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-9492-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75E4D2A94DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.03.26 12:01, Sebastian Andrzej Siewior wrote:
> On 2026-03-17 08:49:38 [+0100], Jan Kiszka wrote:
>>>> +void vmbus_isr(void)
>>>> +{
>>>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>>>> +		vmbus_irqd_wake();
>>>> +	} else {
>>>> +		lockdep_hardirq_threaded();
>>>
>>> What clears this? This is wrongly placed. This should go to
>>> sysvec_hyperv_callback() instead with its matching canceling part. The
>>> add_interrupt_randomness() should also be there and not here.
>>> sysvec_hyperv_stimer0() managed to do so.
>>
>> First of all, we need to keep all this in generic code to avoid missing
>> arm64.
> 
> This kind of belongs to the IRQ core code so I would prefer to see it on
> IRQ entry, not in a random driver.

I have no idea why hv is so special, starting with having its own
vectors. But if you have an idea how to address those needs via core
APIs or to create new ones for it, I guess that is welcome.

> 
>> But the question about lockdep_hardirq_threaded() is valid - and that
>> not only for this new code: I tried hard to understand from the code how
>> hardirq_threaded is managed, but I simply couldn't find the spot where
>> it is reset after lockdep_hardirq_threaded() but before returning from
>> the interrupt to the task that now has hardirq_threaded=1. I failed, and
>> so I started a debugger. That confirms for the existing code path
>> (__handle_irq_event_percpu) that we are indeed returning to the
>> interrupted task with hardirq_threaded set. I'm not sure if that is
>> intended that only the next irq_enter_rcu->lockdep_hardirq_enter of the
>> next IRQ over this same task will reset the flag again.
> 
> While looking into it again, it assumes that you enter an IRQ and due to
> the implementation if one is threaded, all of them are. So if you switch
> from IRQ handling to TIMER then this does not happen "as-is" but exit
> from one and then entry another at which point it is set to zero again.

Point is that a task that was interrupted by a potentially threaded
interrupt keeps this flag longer that it needs it. And that is
apparently harmless, but fairly confusing.

> 
>> With that in mind, the new logic here is no different from the one the
>> kernel used before. If both are not doing what they should, we likely
>> want to add a generic reset of hardirq_threaded to the IRQ exit path(s).
> 
> The difference is that you expect that _everyone_ calling this driver
> has everything else threaded. This might not be the case. That is why
> this should be in core knowing what is called if threaded, use in driver
> after explicit killing that flag afterwards since you don't know what
> can follow or add a generic threaded infrastructure here. 

This driver is different, unfortunately. I'm not sure if we can / want
to thread everything that the platform interrupt does on x86. So far,
only the last part of it - vmbus handling - is threaded. On arm64, the
irq is exclusive (see vmbus_percpu_isr), thus everything can be and is
threaded.

> 
> A different option which I would prefer in the drivere, would be an
> explicit lockdep override for the locking class without using
> lockdep_hardirq_threaded()

Happy to learn how to do that.

> 
>>> Different question: What guarantees that there won't be another
>>> interrupt before this one is done? The handshake appears to be
>>> deprecated. The interrupt itself returns ACKing (or not) but the actual
>>> handler is delayed to this thread. Depending on the userland it could
>>> take some time and I don't know how impatient the host is.
>>>
>>
>> Good question. I guess people familiar with the hv interface need to
>> comment on that.
>>
>>>> +		__vmbus_isr();
>>> Moving on. This (trying very hard here) even schedules tasklets. Why?
>>> You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
>>> You don't want that.
>>>
>>
>> You are referring to the re-existing logic now, aren't you?
> 
> Yes.
> 

Then someone else needs to answer this.

>>> Couldn't the whole logic be integrated into the IRQ code? Then we could
>>> have mask/ unmask if supported/ provided and threaded interrupts. Then
>>> sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
>>> instead apic_eoi() + schedule_delayed_work(). 
>>>
>>
>> Again, you are thinking x86-only. We need a portable solution.
> 
> well, ARM could use a threaded interrupt, too.

For a reason we didn't explore in details, per-CPU interrupts aren't
threaded. See older version of this patch
(https://lore.kernel.org/lkml/005a01dc9d30$a40515e0$ec0f41a0$@zohomail.com/)
where I thought I only had to fix x86, but arm64 was needing care as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

