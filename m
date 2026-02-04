Return-Path: <linux-hyperv+bounces-8706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FTpGTTzgmmWfQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8706-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:20:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B8E2A30
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E1C4300EBE5
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF438BF61;
	Wed,  4 Feb 2026 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Gc5IIMjC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6038B7DB;
	Wed,  4 Feb 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189607; cv=fail; b=cZ6OKUcbc7u2H6G8thPcVHDOLs7NWMmo4IBatBp382vgyYnTNQuCwOadUGnXlXnPBIE8sj21n6wkcL9jUyMP64hftP/9JBwOWQHI1108psSHKfWdMGnhqSZ/RXMtUFGyCrTs/TjuEmsUoKZTNL4g7T6B0PG7G5hX3LFmSFOT7wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189607; c=relaxed/simple;
	bh=mLpcSLErque8B7ekAtCRI/TOtQQMCrTzD8u+WTpc36w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OyDvGW1+smSuZArvDbzl3G7e9l/OSrWnUNqivkD96YF5xFMP6GOP6y7zDcY3okHPf2838muw/68DBEkFVocqyB+4MJxlnp3MddsUzZYnYfIFHUvjhSSPZYo1QEz8QuhdQyknSnsS4edmPtOmEBxSux3zyQO9PihRK9xxE5XB7zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Gc5IIMjC; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbEf0V8IH8m4T+78IfuFKakQY8na6I988HslGbDTGdsXhIafisbmvbTcmn142npDPuP6sQtuVTH0Jo9vIVaKwI9CTsP+ww6yg3V3NHMGsdoZPz38vNpHRGLGCoYxJkLep8lk0wI7vHstdENTcwpv1MFxZv5G58ZdZMsfGK2ULxOzWUHI9T+aZCbLo1qG8XIkZZQG5Nuhp85H7DPVaLyF0L9SmYWx+bd8vjjeU/bJ5Qg2MLovAfgpIEo/nMCsLpAEYR3SeT20x8laPrOJLsZxThplrjYRmlqkG1N87u92UrU6gqHFM2TeWE46Al2sVsmww9tiCS0J4IgxPzibPs+i+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Hz0dztTcmYr0zXXsq/ji/gafOLiSnqoTbObjj6xyU=;
 b=j5w5I9sDuisk0GYYjDOVHqM4uccrvWh/Jpl2gIuOLc9+X0kIN0E0/Jwl99bZkeoNGLQ9Y0KGeOAZNvTUM+fL0WHtXCNzBIfcJKJyu8McaPIHdOi5zlYGFk2gChpJmqx5leGJutg7bXgLwwTN1Am1VIh480AXTO9TCXGVgNYBNDBCl3t59fwdm+abG7gqQPw38dET0UQuHQBRIqHnHz9jPR1JSxQjjUa+isrPQyL1dbXf5fE44jUgvigDFuFyixteWgdMMtxFAjELPry2jKD2i5qVHsRDrpnLGrOlnrBl1WWy3JFJUr5etB5hPiEHOV5xlqRcA15KHXWvTrNK3Q5swQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1Hz0dztTcmYr0zXXsq/ji/gafOLiSnqoTbObjj6xyU=;
 b=Gc5IIMjCfOcmBpgEj1hIyYR+CTd14QKRXJ3cRq1ScOGFmq2mtOd3mjWUyjTc9RhbEKAqEoi9CYF9igp9mcS/fCbyPIMFr2R2YgATPZcGrs+FUCF21CG9VEaZbJBegimt0uSBqzalYM9iRT8/0FIpM10uOpH+7lM0O8m8IO5uSkhEdB1pSo5mCY85xyyxNfES+7W7RyxV/u5becXvJ54h4RGWes5pmTKHLdA/bkLh9CAyaQggTDwSL52EUDfIsueD3QdDNAvGPNZRsHYCyoQ+GpGOaNDOZ5Xhwk8R1fMT2pVqaMB0wcrOfcnApdMSqFc8iZWs2KdB0IK1e35B2bYEhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8773.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Wed, 4 Feb
 2026 07:20:02 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Wed, 4 Feb 2026
 07:20:02 +0000
Message-ID: <c377fab9-54f1-4eb9-8810-013a8bfb340e@siemens.com>
Date: Wed, 4 Feb 2026 08:19:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
To: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
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
In-Reply-To: <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 62886f80-3ce2-4f38-b8d7-08de63bdcfcd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTErS25iMFB4TzMwVlVuVHZKTmFic2w5YmwyY1g5amNCZWVaaHRucmplRmNa?=
 =?utf-8?B?QVRaTjdBa3oxRzlGWGp1Rm9SRG9sNlIxdHd1Y2NGVG15U3I1Q1lCQjN3SktZ?=
 =?utf-8?B?dG91bnhES0hKZjdDd0NLUnA4MVJNNjcwUE9VZG5rT0RuZnZXY2dFeXlucHBM?=
 =?utf-8?B?SDNpL1JUSjBLaG9rSnBzRWtYV0ZRanNEbXBhYnczRVk3Z1ZHS3hacFpiMnRv?=
 =?utf-8?B?R1JaUVJ2aytTTExGLzVDcEZDbnpHaVFuRXhXM0xDS2dCbmVaVXJYbjZlZnBC?=
 =?utf-8?B?NC84M0xMdGVrYVM5VXRQSitFZncxbDJDdWNXS09EZm5rcllyYUsrSU9CSHgx?=
 =?utf-8?B?Nk9jSktkMUt6b05NSWpaM21mMTRrUEFGUmRzYWRoblE0NHEwNEtpbmJPNDJZ?=
 =?utf-8?B?UjRmbVJjSjVRVGllSnJKNUFCTTlLV0JyVHQ4eHNGV0lmWWpoeS9mSWpzcWhY?=
 =?utf-8?B?UDRZcU8xQWZPZGs4KzN3V0xFa2p1a29lY2xGRXg1cFlpRG85ZWJyQjVTTk51?=
 =?utf-8?B?ZkRodjZxNkFHdkJzN0RuWGE3ZWUyRUd0Q3hIN1lUSDQ5ZE40eithZzJtTWhv?=
 =?utf-8?B?RlBhTDFlRWFFZDRjd2I3ZzlyRzFSQ2VHS3NZV1A4T1czMFVVWHB5eGwybk9v?=
 =?utf-8?B?bm05dlJKYTVFeS9EWDRtcXczTE9BS3Zlc0ZlYldzcnNRYTIxQjdjK0hrMTBv?=
 =?utf-8?B?U1RUSG1Oa3l4endrYkNFeFNVZzVQZWxuRElveDAxcitDM1lUbFlrN21NeXZu?=
 =?utf-8?B?eHJlQ3VEL1IvWU9JTDQxSEJNYnpUNHZpUWJSUjRqbTM4ZjRuVWdvVzNhZ2Ft?=
 =?utf-8?B?alpnc21XZStSU1puNCtFR3QrdXA2SjV6YnR3RnFYUTZnbHNBQnlZWEVkRko2?=
 =?utf-8?B?UG1ZNktNcEovS2ZtaitURHZJSFo1QTRhNkg0OGNuaEVPa2FjaFRhb1NUYWY3?=
 =?utf-8?B?SnF0R0czMTBwb28yR3l5b1dtMFdOQ21qYXdhZkNqQ3NnOFdjQmU3SXh1dXJ5?=
 =?utf-8?B?Y1l2Lzl5WkJ3S2d3WUVweER5ZlhBallrSXZxRWlXWEJCYmNoSlBtRzNUNnl1?=
 =?utf-8?B?NjgyVndTSCtwa0NlbXE3eE9SeGQ3eWo4KzQvNng5a0dKK09SM0drRFc0RTRK?=
 =?utf-8?B?akd2dFNJMnhxMU9UNWlNTVhRU09WaGZqbXFlb094Yit5Y0tGTTV6RlEzSC9K?=
 =?utf-8?B?NkpsNTZmQnlXN2ZRanJUbTRRSGhNTEc3eXVIb1NqQUd6dTVuSHJpOUhMa1FV?=
 =?utf-8?B?WWxOODAwRTA2VVUxYjdDNkxSNmFXOHl5dTM5RFJyTWQvMk9va3dzZVROclps?=
 =?utf-8?B?d2tiWEJkTVhSOW0xTzJ0ME95ZkNRT25PSXU4d3VabXJVK2VTZjhjTHowQld1?=
 =?utf-8?B?TklOWGNIQVdFcExjcFdKY3lJMlNuLzMzQ0llcWtERnFsSHF0OXQrUkV1T3Vx?=
 =?utf-8?B?VjB3WUFBV0UxV29HOGsvcU95V0ErNzN3UkU4Lytoejcvb3hmT3BZQmt4QWZ2?=
 =?utf-8?B?SzVkQ2JHMGYxbW9HbFpzTmJuSEdjMW1QelhncytyNUt2TGxlUU5Vd0k0MWJQ?=
 =?utf-8?B?N1NnYVBya3ptUXV1N0hjT05pWXpvL1RxQUhEWDQvRDlWcVNyUzgxU21vcG9K?=
 =?utf-8?B?Skticy8wb1pxSkkxek52YUl5c2c3dE5ncW5UeFFjSnVyNHRYK3RVUzkzcFdS?=
 =?utf-8?B?ZnYxYlpWMmo5Vmw1cWI1Z0Zib0xGMmlCRGRTTjdSa0NsVzJLdXU4eGJ4SXJS?=
 =?utf-8?B?SytpbXlUWkk0NW9HdkkvcVdKOHFlbFhMNzVvU3FYd2FxNU91NTJUZ3lCUlpm?=
 =?utf-8?B?VXRpeGllS2k2NEU0NXk3YXk3QWtQajJsVmtPL052T0lEekVFbWhrUE1aWUdP?=
 =?utf-8?B?Z3NIZ0VZTkFKS1Bab2lKN1E2OHd0VDJsL25rdlU2YjJ1by9ySm1jS3JKNS9k?=
 =?utf-8?B?eG9hbUU2VWlRNVZvV1hZK2FQTjlkcVYxQldWd1dtem5mQitoZUEvUktvcmJ0?=
 =?utf-8?B?bDB4MVF2di9YSHZkSnVmYjlYUFV2UnRxRitpcElJY1FLSG5UQmNlTEk1N05z?=
 =?utf-8?B?K2V1MEdXeUpWZTlmeW5HOHJQSEVTSHErRFdQZEFSQWhmZWZaS0VkWVVJdld6?=
 =?utf-8?Q?og1U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3JGa2wvTkpvdlBxMXd4bTk5U1JQYjVxY2FGNTRabjQxaEI2b1Z3a3ZHZ01u?=
 =?utf-8?B?MldsNVRneHdFNVJzNjM4NWs2R21jSThvT1pUc0g4RE9IMFI1Z3dLVk1iTTBZ?=
 =?utf-8?B?NWNsZXpiWmtTdmJzRXJjVkxJd1E0S3ZFQ0ZKd211bEVqalovdm5wdDFzQ0x2?=
 =?utf-8?B?YjFCZlJvUEFldno4YnY4WHVNOFVzZW5qcXRXeWJScnFuY2pmcFpNWXhYT0tM?=
 =?utf-8?B?RDFRLzVraHZQSXp2YlBSWmR6L3ovNUZkcVJPSWdYcmlUbzZEQVJYN3RZSFZ6?=
 =?utf-8?B?OW10VGl0alk1UU5WWllPS2JGdWVpZFJGSU1EWVIwb3RuVjltRXpuQ1F3TWVn?=
 =?utf-8?B?bGd6VDNVTGkycDhJQmNhVitReVRJS21wN3h4WE5zUzkyY1UvQVJYVU51YVF5?=
 =?utf-8?B?NTJ5OHkveE9CQld3TmF1RXB4RVFvSVIweW14eWRpQVpQY0ZMVmd3emlrdm5r?=
 =?utf-8?B?MGlJTXJ5SVdHQXFMZnY1eWFuemFvbG0zSzNCbTR2TWtHaWNnZnkrYVdHajRj?=
 =?utf-8?B?MEZ2eXpNWkVhLzJxT01xWU54MzNaZFlmc2k1OTN0TzAzS2lIL2RTS25nRTky?=
 =?utf-8?B?MXhQU2NxV3E2cjZXYnVjd3l5Z05kUW9jcmJOWUVMbGVOeVdQTzFQNTVtOHdl?=
 =?utf-8?B?ZXY2VXZoZU9nd3hoVlJiWUNvYlh3cGpUY1gxek16WU5xSEpsdUJHYTBvTTE2?=
 =?utf-8?B?eHg1cyszVWo5NDJJVTRlbnlMOS9sTVZtNnJLUGF1dHZ1c3RnUkJhTXdLSTFD?=
 =?utf-8?B?NHBZMzI5eTQvVVhtenJ1N0tBOVY3VzAwK0Z1N3dvb0ZZaFJMTTR6NXV1ZStw?=
 =?utf-8?B?dnh2aURHQzQ0ZUhTYjluYkY1QmdPQ0RVU3ZMdzZ2TlpYWHVEZzlyUk9BYm1V?=
 =?utf-8?B?TE9UTzFVZ2E3UnVySFpxQ2I4OWZMdkZqYnJWc1BMTXZiM01TOW56bXlQZXhq?=
 =?utf-8?B?dUpacnFUWll1Zk5MbXpuVUVsNlJaZ2pxY3hDRmhmU1hZUXVwWnpmRWhuYXVH?=
 =?utf-8?B?K0gwZzVBWFliS1ZyK1M1OVRoV3MwNFVVNjJ5UWw1enFLUy8wMEhCWHBvYWU0?=
 =?utf-8?B?dUtrRDVsS3dqRkE5R2d6MTJjU0wvR0JtMEkwU0VGMzRJWGhJLzYrMDJTa2JX?=
 =?utf-8?B?bUVNT1FQU3RFOURRZ2hraWVkRnV6N0hHeHhPc1pjTTZjTzVLaGxHSmkvSFFt?=
 =?utf-8?B?ODMySGR0NGlqYlpkdWEvTStndFFYQ1dNZEZYTWs5aUtjVmdOU2tpeWg1TVBp?=
 =?utf-8?B?d0U2MWkwYUMvVWxzelRicWV4OHBaTkh4a1ZwZHV2WWFvYlFuS0dYT1YzQjBr?=
 =?utf-8?B?Y29aK2huQ1NJZUgzN3ZraVliakRXVFhHc3ppT3J1VzgwcDYzTXdLWTNQN2NW?=
 =?utf-8?B?SmJtSXVzUEplTi9ZUXVMRGdzNHJmdVdhS24wMTdVS09OUWpKRHJmYlQyUDJj?=
 =?utf-8?B?YzAyYkNYbzNuc3hYMGRLaHVQWkM5dklXS0N1ZkZqQSswb1lLYXV5ekNtYlRT?=
 =?utf-8?B?QWFRS2FkMjFzV3JaYjRkL2RyS2lwZVJ3OWhsYmdScjhUc1ZmQ3dIdXEzRmE5?=
 =?utf-8?B?U2NVZG05elN3OENRR3VzQjR5eldYK0hYSWJnbUcyZ2pJY3BPN0UvM004R3Iz?=
 =?utf-8?B?VEJQWUM2Ulc0YWRiVWtOY2dqUWxwTWFxdHRuYkdTemQ0OXU0VytDQm9GT3Na?=
 =?utf-8?B?dW1JUnFMV2VPVk56RHVONmxWbXh0VFhuZG5pa1o3b2trc0Fod3Q0dGRkN2li?=
 =?utf-8?B?ZTV4c2E0cUZYNUZQVk5WTXk4NzVNY0RSRWo4a01zWEtLYTlIZFRydzFzcEdh?=
 =?utf-8?B?UUZJK1VxcHVCL0g5cTIyc2l5azBkRFVlVlFxSzAwNzZlU3RwcXR3cFhkdE1y?=
 =?utf-8?B?RitlMlgyRjlOeXhrN3gvcW8vNll5ZVRCY3l4ZVNXRUt2SllwcWROdCs2SlVG?=
 =?utf-8?B?elczbVNIU0JHQklqUjVlWFVCTXJZSFFNVXFJOHkrTDU1WEM5bVNyYjVBMjhH?=
 =?utf-8?B?M0VETHFoL1J4MmRZbUxZOFFoL1hTY0hJR1RUbm83cTBYNXBlNXUxSFdKQnpU?=
 =?utf-8?B?a2YrV3kycVhvaWRhaEk3a0dETFQyN0pNb0pTaWVxOG9KK2kwKzFiV2ROZDhU?=
 =?utf-8?B?WGc5ek00Z2ZvZ2Vkbkc2RCswbGJZRUhadFJ5WERMOUlwaTdpS2thR0cvZzFz?=
 =?utf-8?B?bmJqOVVPNWZvUkVnZGVlQUkxVmliaHNNQW1nemtBWnFmeFZhaHppWVhqVVFr?=
 =?utf-8?B?ekgzWUdzaEFCSU1JQnA5YytlelBDQ0s0TGxaQkF5dllCeGRYRkFJSGpJNWFq?=
 =?utf-8?B?ZGVpYjk4N01DNEFmREpDM2crS3N5aHYyOVVEek1DK1N5ZFpKMitBZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62886f80-3ce2-4f38-b8d7-08de63bdcfcd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:20:02.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Twh7LkJe2oHriLyKWZ4RqN3PYxFsw1L8EHmu2cQqH6+iipMLNYADjHt8H3oOyNmzvvKJ2ToqKlQ+xrOfUCZDkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8706-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,siemens.com:email,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: 8E9B8E2A30
X-Rspamd-Action: no action

On 04.02.26 08:00, Wei Liu wrote:
> On Tue, Feb 03, 2026 at 05:01:30PM +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
>> with related guest support enabled:
> 
> So all it takes to reproduce this is to enabled PREEMPT_RT?
> 

...and enable CONFIG_PROVE_LOCKING so that you do not have to wait for
your system to actually run into the bug. Lockdep already triggers
during bootup.

> Asking because ...
> 
>>  	struct pt_regs *old_regs = set_irq_regs(regs);
>> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>>  	if (mshv_handler)
>>  		mshv_handler();
> 
> ... to err on the safe side we should probably do the same for
> mshv_handler as well.
> 

Valid question. We so far worked based on lockdep reports, and the
mshv_handler didn't trigger yet. Either it is not run in our setup, or
it is actually already fine. But I have a code review on my agenda
regarding potential remaining issues in mshv.

Is there something needed to trigger the mshv_handler so that we can
test it?

> Note we don't support RT yet, but if issues are found we might as well
> just fix them up.

This is actually not about RT itself but about supporting all
configurable locking semantics of the. And the mshv drivers fail here.

> 
> How urgent do you want this patch to get applied?

If I asked my folks: yesterday (we shipped it...).

We would also need in upstream stable and stable-rt, though it may not
reach the current production kernel anymore (6.1-rt from bookworm)
because it reaching EOL in a few months.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

