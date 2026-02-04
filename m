Return-Path: <linux-hyperv+bounces-8714-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH6UC2dFg2nqkgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8714-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 14:11:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BBE638F
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5DB7305DEC8
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E0407586;
	Wed,  4 Feb 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SCVifje0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766D19B5A3;
	Wed,  4 Feb 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210306; cv=fail; b=linh9s5j/VSUV6s4zdgAxkv4sYRahjfXkTCxoonH7hrqJksnXReS636V/MSOv/gTMbGqdzP5pbXWvQZ4NDRYj99IdLJco9rV2G/ETVX7jDY/6GDRifwU/Y7blGkKVdDYoava2R748dbOmuoXP1Op/Qtpqy7xGsXmpnFzeeifMxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210306; c=relaxed/simple;
	bh=By5cOFdXv6S3VhJHGETX/z8jSom1l8lUEufSN6PnKgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=niC5hD2SX2gVWl+RlWgr02nsNQbYfZGEnrLTQsZey/de6vCeClISq/PGbyskotbEEauGAkZZvCpThGAbkx5vdNQzezY8HNcz1kKqBP2UTSL0Jd/NW8mCuLKnBj448oyqMNDPBUeWCB0cB/1bZiMipLs6d3XJJnU5DywFpYaYPTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SCVifje0; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whwXSbYg12YPJhvboxQlt5aMSfzKYYE1iCj4h6NZlT9DBee5aVfXWD9LH0BTOdXyxIN9kAwjUnX7UYy+hRLfcUzhm7FQTFEpYsp1jNxxlYUmIeecnyyICNrneUdjMTs65qIqpnD27p9HuaHNgxXLEfjjrjWYasKDKYAnDpqQvF+6NF9vutO/LieKNe36EGJL4zf4Q/vwM9Z93F6cXdDQP2ytFChuFSTaT2zfq5d57ItmkUz1qdJiPSj68NH0zt7kZ5Uk9vSXa4eT5oF3NfWroR1GyUd3PIQutKxDsZhuNqt+B7oajVpJrs/F1y6rOjfMPcGH95Q4KQKgSGbtianT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prwnX/pq3vTOCYaH6D5w//5ACqa0OruYD3SJsYGJj7g=;
 b=ofRDz1OU0knpsDQuBDgrShkCk8D7ErXrd3LowBgVO6hFusGLMLrlm5TU8BR6zpoqq9+g8qkD2EYPS5uJU9mJUcZ4aFyBRiwbTUDzbs6TytWdm/tTaTGIvC8RzcqCfOOdHU6oVXtP6W+TqntKdNPm7cfwHjdW8PflYTwVml9BBlgatAPv75SMIjCK/cPkvqc7m/Y1iLNSLmYqR9mMuFae1R3x+0I1tGu7QwOs0yBRfM9PcGqmdc3BTjkej++/T8FFo0GvR4OOP2R8jXueSw5zn1v77hcTdOjHIJAIbxswgQqk8xU7qp2s5A/frEiUIczKWjakdOYwaRaxzaEmCiRJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prwnX/pq3vTOCYaH6D5w//5ACqa0OruYD3SJsYGJj7g=;
 b=SCVifje0VDfL6IY+ZvEwxLDI0osqg7fwmErCHM0BCCuMjvuFqkJlYXM6zPTUTBMiiAewkrF/MCnZjmF+yE9Xv/A+FmNvWoW2xIL1QtGahXJd4bB1WmVf0eYBUlpP9E6EMF3z7pgzbfI7Fhwymveq9Pf95oUhTzNGcVN1AtcVL+EWfAg39KIZO+xt1yQKsrdenwtnPnuo3OqEvrDXLU53uvDbvYJ1KewOzaTvMIaG1HMGHNmOhg0DRe3tw9KqTQXEo1ShblkW9Lcynb4+wwLuJ0CXdJRmOipYGgn2JoncBkZuNEYTlRDgyNDg1AnLIrk6hcYObujgK5ufs7hbrLjqRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA1PR10MB8432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:440::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 13:05:02 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Wed, 4 Feb 2026
 13:05:02 +0000
Message-ID: <09c72960-dbc1-4ca8-a0f8-aed686de4f19@siemens.com>
Date: Wed, 4 Feb 2026 14:04:57 +0100
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
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, skinsburskii@linux.microsoft.com,
 mrathor@linux.microsoft.com, anirudh@anirudhrb.com,
 schakrabarti@linux.microsoft.com, ssengar@linux.microsoft.com
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
 <c377fab9-54f1-4eb9-8810-013a8bfb340e@siemens.com>
 <10ec70f2-27a5-477f-b6e9-164f7b7545d9@siemens.com>
 <20260204072930.GO79272@liuwe-devbox-debian-v2.local>
 <d1dded05-a47f-4be2-94c4-913104c758e2@siemens.com>
 <20260204073629.GP79272@liuwe-devbox-debian-v2.local>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <20260204073629.GP79272@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA1PR10MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2c7359-16db-4b47-a17d-08de63ee01eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUlQT29OTFo5ZUl5VnFOQ1dBZTYyRkgxcEJPOHJNKzBwaEh2S3VuMk9yYnc5?=
 =?utf-8?B?cGVUNHk2NG5kR3k3SElnNDlFeTl3bHRIaUs1MkpPUWNBclphc3dDL2h5VG9m?=
 =?utf-8?B?OUplekVIZWhHc0Uxck9sU1JqK2Ivd1U2T3NtNnl2WDZLSkxLSzlZTlZGaDFC?=
 =?utf-8?B?UXE4SlhONStwUTM3UGsyTXVkUUUzMnhXZzZpdUYyTzJ6OVc2UUtyMFcyckVq?=
 =?utf-8?B?NkhKWnhheXgzdElNbXdKY05pbllVVE80clpScERGWE9rMXVpLzdEb3ZpVzli?=
 =?utf-8?B?VW81bDJ2L0JmbnJLVDZ5Mzg2NWt1RGpwalZNTGxZU0I3cFB0N3pHclRCT090?=
 =?utf-8?B?SWRHMnIxM0hSYUZpZ2tCQ3RrZ296Ujl2aG51VDdidC9aOVVINnFiUE1BOHhR?=
 =?utf-8?B?UnZKYkZ3aGRoVVRXNWRkcFhjbGlUN2pZejdQQjBQVkNxQndLS2ZDa0FOelRI?=
 =?utf-8?B?OVBFdDZ1dXNQTEFrTEJJYVYwdDVjTjNoQWo4dmF3Kzc3ck9pbDNuWWZJVC9o?=
 =?utf-8?B?SnExZElibS83N0E3WlhsaFgxUzZkNWpZMHNvNUpNZzMvdldiTjRXYTQvK1VW?=
 =?utf-8?B?bUpTc2s3RE1saXpXTGlXTHBjVDJYSnBiTklYQUxZaWJrWitCdzg4bVJySUk3?=
 =?utf-8?B?M2JSUHZhNE1ZWkVLU3V1aXJZVWJHRDZpM0l2Ly80aGpHcGlLdU1leHgvSktR?=
 =?utf-8?B?cklOdXBUSFJXdUhUemJUaG4yMk5sVGQxeXRiTGVqeXcxb01WV3FDVHJEQ0Vk?=
 =?utf-8?B?elRYcWtSZmFGSkVKZEJoVlZZOGZidEdpN3hXYXZ3NXRuYnBTRVdzaHdjaFR3?=
 =?utf-8?B?VHhqb2VmYks0bnhCeXVVdXZOVVpOV3VnSVFNVTlHSW5QTTREMjlqczN6alRK?=
 =?utf-8?B?OWh5ZVl1djFreHZ0UnJWR3BqZWdLOWdDUGpOdU9OMy93ZU1VaHlkV2NOWFJl?=
 =?utf-8?B?bnJSZC81R25aM1pjUFk3MEpSdUxKdkNEamc3QWx1bS9zOGFPK2FnRTR4SVEr?=
 =?utf-8?B?ajh5aFFiSVZhRm1ROEU4MURoTk5HTnRiOVJWNTBEb2IzeXlRYWQ0MUxkQ210?=
 =?utf-8?B?WUVzcUIrTWJPK1JPbi9IZUhSR0doaWpBMDlqNWVEV1duQVJXcXM3TTZpZWI3?=
 =?utf-8?B?VFpQNWtSSFlmUm9ZcS9BL0t6UkszN25wcVkya3k0cGdNUGNyL1pzeWZzV1Va?=
 =?utf-8?B?RDZXRzhQSU9DL3JuRTkzVHZEN1pJcU9odjltOVNBOGNyb0JOcDF0U3RJSWNI?=
 =?utf-8?B?b2thTllMTUxTQ3JIbFVWTk1QSFpkTVIrU3d5Q3JRREphNTNCWklveHROa1M0?=
 =?utf-8?B?R3UxODY0ckkzeFlIL2NjQ1RUM21nSTE0blV2NEtnSE0zQ2RLU014ZGxUTmkv?=
 =?utf-8?B?VkdEb2tvaWduNGpxS1pkR2gySjJKWFFaR1pydTFjUnNxa0ZEaU0xUDU1aTR4?=
 =?utf-8?B?bWRtUmtUKy9PN2gySVp2eS9rbHYwbE9EQ2NnbWFKVGVzV29KY0c5aXN6TFd1?=
 =?utf-8?B?VTZjbzdaTGpsSVluK290eHZSVHdKT28wQXdSR1FRMmR4RnNMUyt4MEZkWHhI?=
 =?utf-8?B?OWpDSGNpS0ZzVDBGS2NFaUNNSENEVXhxYStuSC9ua25hbEIvd2VPYUU1ZzBx?=
 =?utf-8?B?Z1JxNXVFdkduM1FLdXhYRDlrZUhqY0NwOENxK0NidHRZM0lUaDBab0toaUhP?=
 =?utf-8?B?Vm8xbFRBQXFMVmozWE01b2pYdzQvbU5vSi9pYWkydU82VGZ6WHk2OTFEbFVX?=
 =?utf-8?B?Z3Q3T1Zrckh6c294cnpLcE82V01tZmNxV3VvR0xkNW9LRVRodWxrUkRyOEph?=
 =?utf-8?B?OW9pbHhGcEFqc2RmWWl2cDNIM0UrK0w5S1pTQndGUVo4YkJndjAybzNnMHNU?=
 =?utf-8?B?Y0JMa0ZqSTExV1hYQXRiM1hDbDZyRXdKNXdEcWVvYk1KUXh6WGtyUDBnRlow?=
 =?utf-8?B?Si9wT3BaQklpWFRkY0ZwREg4TTUwNGRhNDdXVEZPV3RadTRXTXlSSmZwMkhG?=
 =?utf-8?B?azVwRDhVMkd0SHhTY3JjYWl0dDI5UnBwa3RsYkRTYi9kbHMyMnhidlZJME44?=
 =?utf-8?B?d1B2Q2gwcnNJbjZ1dWJNSW9LQ2FmR0djaFV6WVpQMkRrOUtJY2xGVzBodmhU?=
 =?utf-8?Q?TxDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3JERTJrUjlnajFzd2w3cUlZdTdjRFRZRHFGVS8va2tFckRNTWdtZC9OVnIv?=
 =?utf-8?B?dmtBOUhFUmtFWG80aFFraTN4QzRWVUROQU9BazN1THNZTWVpUXpPWnp0RlBM?=
 =?utf-8?B?YTBDQ09NVFRhRVkxOCtFZGQzb09Jb0IxaFdDU1NZa3dybFBCOWZoY2tBYVJJ?=
 =?utf-8?B?aEY0MVFGVGJFRWtvNGxOL1FUTFNMOUJTQVZLMGVsM3dZMlJlWFRwSU05VkRv?=
 =?utf-8?B?SUlObHR2d2U4Q29VSEpNL0pETitwMzdjVzI0TzA4U2dtc3BKdVFWQktremxp?=
 =?utf-8?B?Vnlud3h2ZERUc3JQYXhjSEpNQ3JrMWxSSG92T3dRV1BITmVyRkpWK2NPY2Fq?=
 =?utf-8?B?a3ljMHRtTmlZUlFUTHo5dVkycmpwZ1pjeUl2MW5GQWNwSE9tVFhJaXliNy9o?=
 =?utf-8?B?RVkzZWplZURKY0tSNlN0Z3laUHl6MjQyR2VFNEVYdGIxL056ZlorNzR0YU5k?=
 =?utf-8?B?RXgwTmRUZ1ArNHRnaDZpU1NlZ0lkTjJDaUMzZERDSUNTU1ZmQnJsTGJLOGd5?=
 =?utf-8?B?TEpRZW56YmJBekJRdXNBbjdOcVNRK2lFa1JYNWs1K3VDUVFxS2MrdWgrSnZz?=
 =?utf-8?B?d2pxWHBSdTRyeStXeFNCemk4QTRTVlkrMHpSVFEycktaNndBVXRoVFNPb2dE?=
 =?utf-8?B?VDJETUFrSXFLSUdkeDRLWmpVd3Z4dHlBYnFxS0hKL2ZyWmRabnArS2NaSFZ5?=
 =?utf-8?B?R1BWZitNaDY5QW5aMDNOcjRDRVJac0x2Qmlta0VjckJLRlZkdEZwclFCQ2N3?=
 =?utf-8?B?eHZFVHdrN3lUTE5ocXRMMmN4SUlTQnRmOXppMHBCaFJhZUJ6TTNHZmdwaHJL?=
 =?utf-8?B?M2JhNTM2eThLVkFmNnZSQkRReFdVV1JNbVFjaXdsbi92MW4ybUN2NzZseDlK?=
 =?utf-8?B?RTNIS1RiNXNhTGlabDNvMWlUeFcwMXpzZ1l4cS9jYTMyYko4Umd2U25VSERq?=
 =?utf-8?B?YmNmWlVCenA2UW9oUU5Ib1lwb1FLOXZOOWUrY0FNUHNLaS8vNnZOUXJGZ2li?=
 =?utf-8?B?dnJyTFdWd1MrMnBiMnlGeU1mYmNzdVNTeXpubTdZSjZtSFN5ZG1CUitHcjhu?=
 =?utf-8?B?bW1aVHRBcGQ3WExhSDQ0ZDlKZ0ZadFl5SnRPK1VZSnExbHRVQWFCQytHeFB3?=
 =?utf-8?B?VWo3L0wzQ2tIKzhKY2V0UkpIS1hNQkNFbmZVaHhiYkV3YjVlamhXREVOUU14?=
 =?utf-8?B?QXF4R3d3VGdRQUlXYzE4Q0VaT0NmUFc3SUxyR0NTL051SU8xZVRMNC9MRThI?=
 =?utf-8?B?OHBFYzRFY3RuUHpMMlJtR1N0d0hpUGkvNVc1Zm1ZZVZiR3lGbkkvR0VkSUJI?=
 =?utf-8?B?NGUvWjBHR3U1VlM0YTZJaGlWUjFyZHBHdThWTWVuWWcrbzhzNVVrNE5FUmov?=
 =?utf-8?B?V2Rra1dya1U1M0FTYzQyRDFZWjEwVmFKSUpuUTJkUXlJd3ZERFhiQWFQbm8w?=
 =?utf-8?B?U0tSM2FZMGVGTDJSRWhveTdrZ3Q2MFhvZmZrbkJMS3BBNnR5WDF3S1E5R3p3?=
 =?utf-8?B?TVRDa0FhSEdWd1lMMDZQcVNQbjBaditkZTdXeWk1Q01pZXRiMXpLTFBaMC9a?=
 =?utf-8?B?NEpTbHo5M1pPQVlzdkhsc1llSXBHR1hwNnI0UG5DRHVEbmZPbDliQ0hJK3ZE?=
 =?utf-8?B?cXpMZ1Z3bDBRNWloalpWYzlEeTZCVmtCc3RMRW1yb2RMallSeUQvQWY3SlRX?=
 =?utf-8?B?QzdGQlgxTG9rVUZJU3o0TmpvWDdMZi9xdktmYkhrZnhsbGFTTlRnYjVXNTlr?=
 =?utf-8?B?cUtmQ1BBSmdTNkNyakhMa1RyWDVVWk1uRjc2TnBXQ1E1elBDNkFGSHNqL0RI?=
 =?utf-8?B?QmFFdWUvQXkvaUxjQ0JOVVpiTkJyVWwyblpmVHpTcEEyZ0ZjanQ5Uk1vRFNJ?=
 =?utf-8?B?Wmp1OUE0TDBHTXR2SURyb1gxZDJLaGI5OEVQM0pPVlJMYllSelZhazluODFM?=
 =?utf-8?B?aXhxK05rOTN0MXRIRmRVT2tYaWFpcXp3QjVHOXBDUnZUTGRTekVlNXdaVmdD?=
 =?utf-8?B?Y0M4RUZsaDg4RHVDc05lZVIvVFRha3k2UVliNWhoNDhSMzNUSlY4L1BBZE9p?=
 =?utf-8?B?aE5oK25KV0RCWndEUS8zZThxYS9ONzlRRXRtc1cra3NZc0FEeFN0K0lEYVM0?=
 =?utf-8?B?S29uL0pBT3JodnBlVVNLd2doWnhUNCs2QWhoZUdoelRnckw4NkxoQnNid3Ji?=
 =?utf-8?B?TXh5YURJRCtaaHFiT3pnMXdOOWt3eG85bDViek9pYWtrYzNpcURhQ2JQV0Qw?=
 =?utf-8?B?ZVNVQlVWY0xNMHhzK1gvZHZzeXZCMDJ0K1hjQWJVMmNpbzA4bTNzQmVKQ0pF?=
 =?utf-8?B?VG4vanhwMW03NFpzTkVqS3BrWVpWaFNMbEpnYzFKNmFiQ1VpcHRkQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2c7359-16db-4b47-a17d-08de63ee01eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:05:02.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD7R9Ry2Jo3gaQl4U5MsJDpTXa6WqTZurvBUSQIrYbDcdCjRROGajyyPv9CSh5zsvHR/lMV0u788lO8VKrWXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8432
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8714-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B5BBE638F
X-Rspamd-Action: no action

On 04.02.26 08:36, Wei Liu wrote:
> On Wed, Feb 04, 2026 at 08:32:04AM +0100, Jan Kiszka wrote:
>> On 04.02.26 08:29, Wei Liu wrote:
>>> On Wed, Feb 04, 2026 at 08:26:48AM +0100, Jan Kiszka wrote:
>>>> On 04.02.26 08:19, Jan Kiszka wrote:
>>>>> On 04.02.26 08:00, Wei Liu wrote:
>>>>>> On Tue, Feb 03, 2026 at 05:01:30PM +0100, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
>>>>>>> with related guest support enabled:
>>>>>>
>>>>>> So all it takes to reproduce this is to enabled PREEMPT_RT?
>>>>>>
>>>>>
>>>>> ...and enable CONFIG_PROVE_LOCKING so that you do not have to wait for
>>>>> your system to actually run into the bug. Lockdep already triggers
>>>>> during bootup.
>>>>>
>>>>>> Asking because ...
>>>>>>
>>>>>>>  	struct pt_regs *old_regs = set_irq_regs(regs);
>>>>>>> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>>>>>>>  	if (mshv_handler)
>>>>>>>  		mshv_handler();
>>>>>>
>>>>>> ... to err on the safe side we should probably do the same for
>>>>>> mshv_handler as well.
>>>>>>
>>>>>
>>>>> Valid question. We so far worked based on lockdep reports, and the
>>>>> mshv_handler didn't trigger yet. Either it is not run in our setup, or
>>>>> it is actually already fine. But I have a code review on my agenda
>>>>> regarding potential remaining issues in mshv.
>>>>>
>>>>> Is there something needed to trigger the mshv_handler so that we can
>>>>> test it?
>>>>>
>>>>
>>>> Ah, that depends on CONFIG_MSHV_ROOT. Is that related to the accelerator
>>>> mode that Magnus presented in [1]? We briefly chatted about it and also
>>>> my problems with the drivers after his talk on Saturday.
>>>
>>> Yes. That is the driver. If PROVE_LOCKING triggers the warning without
>>> running the code, perhaps turning on MSHV_ROOT is enough.
>>>
>>
>> But if my VM is not a root partition, I wouldn't use that driver, would I?
> 
> No, you wouldn't.  You cannot do that until later this year. If you
> cannot test that, so be it. I'm fine with applying your patch and then
> move the mshv_handler logic later ourselves.

Based on my review, I bet you have to lift the mshv_handler to a thread
as well, e.g. sysvec_hyperv_callback ... -> kick_vp -> wake_up.

OTOH, the probability that someone tries to use PREEMPT_RT as root Linux
is likely even lower than someone trying it as a normal guest. IMHO, you
could also consider to rule out that combination at Kconfig level.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

