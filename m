Return-Path: <linux-hyperv+bounces-8709-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F1zIgz2gmn6fgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8709-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:32:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58FE2B69
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D918301A717
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13E38E13B;
	Wed,  4 Feb 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UdH2WbwQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7513389E02;
	Wed,  4 Feb 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190333; cv=fail; b=B+xIN81vS8fnmreJnY940pC65fBFEHWHEU1cPQfi6LcC/s6Sn1sogjKjcvHvvVqt+ZTfrGbNeJ+V4K7h9MdntXuO09PaFS/b8o1fUX3qbkW7aeTOlVhpCvwXf+CYJfJ+LwTbXQg5k0wRhS7Wrs9fwl4aMiICW8Suo0JrgROGIqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190333; c=relaxed/simple;
	bh=oC6KUQdKUbW/0FpXdzuOs+fz+uUsmsaRF2xV1OcyNBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+Kt8uAfP+NBayl8nkn9roffwC3Ha9R3hiPjQQddgF1GXdwc6nAUEnuo5eN/u+8OvEd5KQ7y5ejVT65L55U3hVO/YUfOZKm6ZI4tN+RSyzAUa/CaIOSyMaCL6fSE2nR9BsupgLzOTtkjThnZUn3+bZc3ZA+CJH0p5RjhBfb3cRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UdH2WbwQ; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXOgF5s19UuYL+JRJaXsNzngrIGlVauV3SKST/Xg/SKEE7HrnChLKnXbObgP/N8NE51O+l35rJj39HWvd3Rqs2hF+dl5rNa8rxux/3PKPqY32DR3ZKKtFdhK7BBg0WVDYElafC/VMH6gPnWUDZqGO9P3FuNKd34iIqKk9Dmujllmo7mPwImYhyBLuT8kUZTLx67jSpZzz1lxN3TOojbzPkw2zlFIkLOzKxsI+6SUSddMthhkSxXZzUFXiAxFr2s6TScXXi/sURrtjtXdKHC7Ps0XF9jdJa9uInhje1xN3BtfW5C4HT7vD96xha/qb58xjmCDx5qxDKu1fdSexoV+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEbAcp/n+bKmi5ILWnIdIX85uSrqFHfyEiQA0rDgJXo=;
 b=LJZXZHx68w3+4UL9yjxZSaB1cPqR3BHxldDwz5GCe0w4BEVreM/YgC3zw68GfRMig69nLEydiECFv+/FDMBB96uU5lALjIGb3eceWeOA3jX3aLUiFJrkSVamslHFVHo9DbGOI4z11rbkc1iVmyBoaoYXrBoYt0OBkIw9bKTVwFUTQf8OvaZWroYhMcmIptQbNaScmojIY3RQRVIWhZxC+PZHiTHjB9fs27jvILV1vB/xxMENM8o4uq+aKopMG4aF3HBH/ClugDuAKw2QAuHBYzMfP7IXkrIjro4eftFEEQr25HVbjYFEXO8dGyCvB99NkZna7x+vHTYaPjH7gUOHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEbAcp/n+bKmi5ILWnIdIX85uSrqFHfyEiQA0rDgJXo=;
 b=UdH2WbwQ7LqXI+IWxpVxoytxFBFtWCFsfN7VI8RjJT8q0Kny5AEh6AxkPhYOYQKkBw2OQPBvNgQWx6LqxmuQz4LEaLtyElajU16eLrRiIWCfCSmPMzzIbkEbiShlg/vN2CIdHFCVP3KjHgFM283O29E3LGbcvLmj/VhymCJrz7pAPVlAnOwNraUSKWGwBVHFowO5etBgFWbOYQxo/bSAZRnSf5MteYSrHHQhj3L8kBqf0xL5Rpp41gR+WLQhoRJU9GODfK97OP3iNFAgNb/NJl1kt1XriNVyG1arf/QpJKiAzJ5IjIOrEKPCfqFxrGEihqKneUM04cYq/LlynXqAUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB6364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 07:32:07 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Wed, 4 Feb 2026
 07:32:06 +0000
Message-ID: <d1dded05-a47f-4be2-94c4-913104c758e2@siemens.com>
Date: Wed, 4 Feb 2026 08:32:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
To: Wei Liu <wei.liu@kernel.org>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
 <c377fab9-54f1-4eb9-8810-013a8bfb340e@siemens.com>
 <10ec70f2-27a5-477f-b6e9-164f7b7545d9@siemens.com>
 <20260204072930.GO79272@liuwe-devbox-debian-v2.local>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260204072930.GO79272@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de6f91f-b0cc-49c7-e1b0-08de63bf7fbb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlFqdlRjSmhISFIyQStOMDNubkU2WGlCTUFJcnVoUisrYzdsMGloK1NRSVEy?=
 =?utf-8?B?MStuU0k3ZHNtYmxpK295YWM3aFJabElJVW9pZGwxZitiY3cxNXRKRnpZeUNC?=
 =?utf-8?B?V1IwTXF6OGhBOE5aZTRMM0l5UCt0bTJ2YzlxTG9VWW1VL0FJK1Q0aVgzMHUy?=
 =?utf-8?B?NjBJclBFUlJpNmpiVXJ6UFpiZVVPMjY3eGtmR1A3ZFVDUi9HQmcwQjhmb3FT?=
 =?utf-8?B?RWNBR0ZWdXMwNHFpWVFibDZZNXErS2tMMWhIRUFOQXNYTWd1dW53MFRIRU5n?=
 =?utf-8?B?VmsxUHp4VGlqQjFhcC9ia24ra3ZINHZiRGhNTG9wRTJHL01CUUFQb1JkaWNG?=
 =?utf-8?B?V1dsdHJHcElXYlo5b2tYSUNZb255Y1R0ZnUra3poVDg1U1FXQjhkT2xYeldp?=
 =?utf-8?B?cFIySHhvYnUzME84bDJYalY4RTFEU1hhK2x6UGhBM1V0REJwNi9XL1F5U2ZC?=
 =?utf-8?B?U3gxK25RYkZ6ZG9qcytjcmxoNDZ2UVllaDJxRll5Q3dNbHUxeVVsUkFMN293?=
 =?utf-8?B?bVdjTExkV1FZVHdNUitEL2JzU00wcjNvVnZidmFGNy92SFhrMWxJRW44UzFv?=
 =?utf-8?B?MlA1Szc5Y1FwQlQvSklSbTdJZTY1MlpFbmttd29xZituSjMrYlhGdFNaVUll?=
 =?utf-8?B?M01nWTY5MUFTMmQvd09EcTNxQmtHUllNQ0ROV05VQ0ExSHFxVG5DMnhBQmRG?=
 =?utf-8?B?QmxaN0h1czB4eVRGcmk1VVNMRnczNXU0bnpTNEVTWkY1MXAySlMxd3h5VXE1?=
 =?utf-8?B?R2JObWpBZHBXbzB6Q2NCNExjc1hxajllSW5tVnY5L2Z3ZmNvc1RrSnMrV2Rm?=
 =?utf-8?B?aFM4empwRWMyREV1RjZuT0tDVnV3bG1wenFWWTVJU0hjWXdvbWpFRkpQT1A0?=
 =?utf-8?B?alpUWHcxbG1DMWtCZWYwMzJOVTRrWWFPRm8vVGNuK1RQWjlIZTdIOEV3SGlH?=
 =?utf-8?B?NmQ5Qm1OVlpRTExjWGt1MCtETm9nYzNjVGlpTU1jOC9QbllMTE5vZlkvc0tm?=
 =?utf-8?B?VUhsdkdHR3dzZEZNRlZVQ2ZxYk9INERJdmRxaFVreEdkUW0yeHd5bHhJWWp1?=
 =?utf-8?B?MkVRWVBvYUFxSDFGb1lTTUJCcmZUYlZSQ0NUUDZOUUFFZENUSysxS0w4U0ZO?=
 =?utf-8?B?UlJldmdtQklheDBPSUdNcVkvSHY0RFNKRUUzVVRBMVFNQm5ycktTTHg1YjFR?=
 =?utf-8?B?SzJVV1U0blYycXpQaHQvY2RZQ28zbzFiSW44QlJBU1hsT24wZkNIM3FBTVFG?=
 =?utf-8?B?TjM0c0VsY05oT202VmtzblFGeGdMMWUrTWtIM0hoekVHSTEvdStvVVQvdTIx?=
 =?utf-8?B?aVkxSjFWTFB1RkpTQk9TcTFiZTNHMklxbmg1eVJrcGZGbUZBT1N0Q0pGWE91?=
 =?utf-8?B?YlVXMkRzSm9oeTlWZkM0N3VIV2p4b0EvckFEbE4ySjhMd0RjQUJIcEZmWkMr?=
 =?utf-8?B?aXhnbFJ4Rk4rd2NGTmg1Vld3TkR1VCtscnluYkxoblZkbExJRGZEYTFLRGRH?=
 =?utf-8?B?bStzRmU5Y2ljUzZmRW5jeGJsdVMyQ01mWjIrVVF2dnpyWDFPMW14Nk5lR0Nn?=
 =?utf-8?B?NE9GZmlpcG1iMFBmL0xUN2FBMWVJQkRZc0NPY2pHMUUxbm1nejgvTjFlc1Z5?=
 =?utf-8?B?YmdjSjlHSVdPMWtvN3U0Y3V5UDUrblJkVmpVY2kvRDhaZ3dBVHNEWjdZZjdW?=
 =?utf-8?B?cWhoMklnRm85YTUvNHBvVUtVaGdZQ0VRd0I3MC9NMit3dUN5Z3Nmb3F6UHFy?=
 =?utf-8?B?SE5YTkpYcWtoK1J0VjN0Qk5nTWVTcVpSYkFRMmxvQmplQ3p1RUFKd1ZhSVdM?=
 =?utf-8?B?dFlBeEtadkRNOFhiSEhrckxBNlIvRjY4VFVKNGVFdUltSFY3Z2g2aVM1UnRs?=
 =?utf-8?B?bkxYZDZVZW9zSllpSDdJKzlmOGtSbkZ0c05NYWFseGRONWQrS1YvV1dJYUox?=
 =?utf-8?B?YjkvaFdzMEREVEVZRmZSUmpqb3lzSzREYWgwQmZDaXBCOWcvNXVqN3BoZU9i?=
 =?utf-8?B?eHVIRlkwaGM3QktHNjV0UXo4SERLZ2NMQmF2eHFpN1ZBc01GZEtiSEhsdUQw?=
 =?utf-8?B?dTlWMmxhK09yVVlqRnpyb2RhS0wvUzhvanE4L3ZEM3cxYXppWkdLcEhZQng1?=
 =?utf-8?Q?bO7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGdhZE0yNEI5M1UyelZYa21JbXFZUjRHa1lHVmJJV1BYMU91OXIxbURleVdP?=
 =?utf-8?B?OGRRVEpIZ1ZadUdsM2RPS2s5WlN2bVg1SjI4Y0xNa2NuWVEzWk9XYXlMSlVR?=
 =?utf-8?B?UDMwU25aSmZ3ajBpRnZrNk1wK3pscGFXU01DZHJkL21MTWhwTFpBWk82TG51?=
 =?utf-8?B?M0NDOVZJUHNNdCswOXNqd3NwTS8rSHd1V0ZYU2ZubXNLL01pTWlpODhMM2hF?=
 =?utf-8?B?SlAzaDZQTjYvMElRN1ZOTDdBenpReE5Yck1oOUk2MUwwaFMzaElrNjhGbUZq?=
 =?utf-8?B?SEdNcWJFNCtCWHBVRFNUbjJCZSs4Z1h0UkZBbkZmYzA4aUdhVUdNSkVMc1N1?=
 =?utf-8?B?Z2s1WDZBWE9CQ1NKd0VkV0xVcDRnY0RzRHhHak9uZndUWUpldGxCNnNaTnFi?=
 =?utf-8?B?U2l4clJnUFZkSndjQ3grSnNOSVhCb0tCZGVGL0xEYnBCMDRtRjNNWEo2cThH?=
 =?utf-8?B?bGlObTBEOFRpYjYyQW1uOHc1ZEs4aHVZVXZGQ29ZUmo3SkVndWVOQ3k1RXcx?=
 =?utf-8?B?M3hNMEpYM0VhQWtETEdTN1Z6Y2Y0R2g0RFNuYmZQUjFaRmNpeDVPUXpSbjl6?=
 =?utf-8?B?dXNaWVVsU0tzYlhmT3JUY2FHb3RuOS9HaThabTA4V1o2L3R5MEFzRitzV1Yz?=
 =?utf-8?B?RGk5WWJyRldXclVVdHM2TVV5MTFtTW1vbXBSVlcrTGxPREpySmVtL2tFeS9s?=
 =?utf-8?B?NmZ1VC9CYjRuK0l5SzFuNHVDc3ZpcUQ0VEppcy95OHhlZ0ppQjNwckpjekg2?=
 =?utf-8?B?eW1tSU50NUNpVzJIQ0dPbnliZ0hmUnc3b2JHWkRrQkdwZ01kY0ZRbHBhNFYz?=
 =?utf-8?B?aVFlL3BOaFYwV250blE0by9La1U1Y0VtY0ptQUxUdXl5cUlkNCttdFNtY2Zk?=
 =?utf-8?B?YVBCcXoyYllNckl2c1lxZTZCR1ArTGt6WXZ1SERVTisvcUxyTXNka21kcm5Y?=
 =?utf-8?B?dkYvc09pRjhNdzU5SzRNd0loN2M5anBSOFNGNm4vbGdPdVdpRVFnOHNQdlF6?=
 =?utf-8?B?eGdpUmIwbXB5OG1EK2VrMW1kdEliT0dFVFpkVVVNNE43ZGFlRCsybkNmQ3Mr?=
 =?utf-8?B?Y0RHcUxMWHZnc1VyNDZvV25tYTNPL3A1R3FHWWNjZytkbSt4bmEzQmw1ZXcw?=
 =?utf-8?B?UitITTJ0Q2NNdWhxNE1WZW4yaGNSUjY0NzNmZzdHUHlUcy9tV3ZRVk4vNkd6?=
 =?utf-8?B?MU9LcjdwUU9KdDNHZFBRYnhOeGphdlkwcUZNakVEUVhFQit1eGNVR1JrTVo4?=
 =?utf-8?B?dDBubUEyZWg5UUkwU2V3Z2pOcTl5M0c1WklsUm1TKzRwQVoyR0xWMnoxK1gw?=
 =?utf-8?B?TkdjSDJpUWdONVlSSEtSZ0wxYWVXckxoVHh2NXZ0NjRnYjh5QTdBM3U0Q1dZ?=
 =?utf-8?B?cStaMVE0YVhFT1c2OWNWUW9OVDljclVrbnFXVklPR2dPbDlwUFArVWtLMllm?=
 =?utf-8?B?WWNpa0tYcE51allxNjFMSXAxNS9UVUVrU2xsdnBmaGc5OURiMFlGTHZ0bWRC?=
 =?utf-8?B?bXZSUmpDL0trNkxtNjZRNDY2d2lmc3JMSk0zRTZqTUxubnNmTlZrb3RVd1Nj?=
 =?utf-8?B?L2tXa1Z0TlBuTWJENUVzMGEzWWVNT0dXTzhsSWt4WW1xYlRZd2pCQ2ZvNEpl?=
 =?utf-8?B?dURjREIxdnI1NzNWZGRPSUc0N2hkNjlkMzRoMUZZUXdXV3JxWGoxb3lyd3kx?=
 =?utf-8?B?WEtJbTllczVUQ0pNdmRUMk9xK1RIOVYxc1ZINzZWVTFwMFpkSnpGdDgwVEo0?=
 =?utf-8?B?UnJKRWw1UnFtd2xyT0JORGE1azFOaC9vdWhMYkxuOU56dVBlR0k3M3QvN0dK?=
 =?utf-8?B?ZlRndWs5MXA1Wkl3Zk5MT0lDb3RJWlJsUzRPTkE3bzdvdVVJRU5GMm43WllF?=
 =?utf-8?B?aVM0OFlNRlZqTGN6VnRkTHIyWm55VVJ0N1RSSm1ZTHJMejUyNElqYXBLTTdW?=
 =?utf-8?B?WVdFQUlPbHowdVQyb1JaV1lxVWpwTVNyTk05VUV2RDBnZGo4WHhSZFlPeEp3?=
 =?utf-8?B?bmdva0lQb285SDI4Z3ZkQzcxOS9GWXdJdGpCMU5wajhJTGpqMmJobTBINFVm?=
 =?utf-8?B?WlVRUFBaM0hMd0ozZ3ptcytlUkZ5KzdZVU5sbnROSVlqckJmMHcrc3VJNm9q?=
 =?utf-8?B?djZIdDNDbG9lQ3JqT09lS2o5dzVKMDV2NU9jc0N3VThYL3FycFdDQWlSaVFO?=
 =?utf-8?B?anUyMVNXNGpkVE1BVHVVeXlhQTZGdzVTZEw5NGRFQitncDVYS3VhaVZOM2F4?=
 =?utf-8?B?Z0k2eU02YW1qdURsY0tKU3lpTDJ3Yjl0VGRFUGRkUzNRN3BFU2RYaG9VVWRk?=
 =?utf-8?B?dGVpWWZ5ZXNnQ1lneWZreEVzU3V1WmhRMjJKNkJGL1lqWUNSVktNZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de6f91f-b0cc-49c7-e1b0-08de63bf7fbb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:32:06.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zh1oWXNcvhEqb/t17l2OGznvEZDk6nljqyHIktPdC00CkCrxqTqS0MFlUveUj0w4Y8godDhTBsD94LT2JjE5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6364
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8709-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,siemens.com:dkim,siemens.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D58FE2B69
X-Rspamd-Action: no action

On 04.02.26 08:29, Wei Liu wrote:
> On Wed, Feb 04, 2026 at 08:26:48AM +0100, Jan Kiszka wrote:
>> On 04.02.26 08:19, Jan Kiszka wrote:
>>> On 04.02.26 08:00, Wei Liu wrote:
>>>> On Tue, Feb 03, 2026 at 05:01:30PM +0100, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
>>>>> with related guest support enabled:
>>>>
>>>> So all it takes to reproduce this is to enabled PREEMPT_RT?
>>>>
>>>
>>> ...and enable CONFIG_PROVE_LOCKING so that you do not have to wait for
>>> your system to actually run into the bug. Lockdep already triggers
>>> during bootup.
>>>
>>>> Asking because ...
>>>>
>>>>>  	struct pt_regs *old_regs = set_irq_regs(regs);
>>>>> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>>>>>  	if (mshv_handler)
>>>>>  		mshv_handler();
>>>>
>>>> ... to err on the safe side we should probably do the same for
>>>> mshv_handler as well.
>>>>
>>>
>>> Valid question. We so far worked based on lockdep reports, and the
>>> mshv_handler didn't trigger yet. Either it is not run in our setup, or
>>> it is actually already fine. But I have a code review on my agenda
>>> regarding potential remaining issues in mshv.
>>>
>>> Is there something needed to trigger the mshv_handler so that we can
>>> test it?
>>>
>>
>> Ah, that depends on CONFIG_MSHV_ROOT. Is that related to the accelerator
>> mode that Magnus presented in [1]? We briefly chatted about it and also
>> my problems with the drivers after his talk on Saturday.
> 
> Yes. That is the driver. If PROVE_LOCKING triggers the warning without
> running the code, perhaps turning on MSHV_ROOT is enough.
> 

But if my VM is not a root partition, I wouldn't use that driver, would I?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

