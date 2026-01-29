Return-Path: <linux-hyperv+bounces-8584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDIaL79ve2mMEgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8584-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 15:33:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36340B0FEF
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A71253055D7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CAD1E98EF;
	Thu, 29 Jan 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Mq4SmCX9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BB322A;
	Thu, 29 Jan 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697049; cv=fail; b=RgonGC75K7bYwt3QktrNml6tB5RylD/AXXKEntp9mHK/Scqt3NN6wBTmNgFZEfflMhR+eO6pqHDCP1UHHXHVEK894WyoEh9PKhUJutHqTJz6LFO9D/ejXA+WymeyUOXRbbDsUPVgtZn99/DbBEWEYV/5/gDr8pXzMWeA66/TTZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697049; c=relaxed/simple;
	bh=frkehSztCqXhPuLonc2NGWHmijr0z/UNSs+B0KTX+fA=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=jdaGIYBKej5DJBEJjPiMq16WyJ6kkS3up3HMOskpSli+BptEm5l0R4lO19ThzYKmLAjyNNZW+kOzV9s1L8OwvdliuRX2hRsolMzKVEUB+9xpsV1/ZpHQqfqL647FXLLWH+hTIKvraNkZB7boOMaptgj+DZC+9cIaoyVT5XQcQ1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Mq4SmCX9; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdjM200QZNZuMFaLX9JuA440U2R94N0rgqNAu4jbIIHImmkk4sfLMqePvM95XJiU2B5MK8Dr4NTQaVDi4hCKxmYHbiARdB4cmtfMa2ipRWsc31n7biW9UyqNEjb3osDeOP+6iAtfYaCVPO71hTCkCfQUJg25xM1Xc/bKEBik2/fyy6XUXbe3F2Zc+ZVvJyKtkGuJPe74jGolzRaiHbTkiJM+97AzxKfaIePGYYZAiqUhymYxjRWaaLR/XlCbnx1LL29fjq/qB9SxMH5Ra/efghYY/aQxPJdXgytBQz++Ib+oEWZRF52r5zociwrq0iDvYL9ngc4oE8eDeKILasLeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU7qXwdOYKiXlWJIbHmvSqPY2zCZ1ezhj4cXgbmpE9A=;
 b=M3BYXOeTTDgJuC3lzYGqDyd0Mn/VFSetUg6+GOB+QvUDseNbsLN/X10yV8y680w34XabhdYOiHCLRzxLLkPKDWn/K/xxEzgDF7w3NUqgQ/JKJpxL03CKmpnOUP0pWcBlfbcS3+HGfqlRz0qOpZAJFBouhathS0JZ+HGv7whbKh9igU8ZWtW3yjl9MMmrVlCVc1y/sPL45CuMPAC6WrRl1jQvrXn4OysVkszZ0EM68+uP1PKAiEvtd4BDSrh87NJCTjHuHFUQSFzGlUdgl4BqPaRAfnsui18MSRUAey4LlB6jWhCdcLW2gZ6D+Fs/geOMJMsH+gERj0eLHMjGGsYC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU7qXwdOYKiXlWJIbHmvSqPY2zCZ1ezhj4cXgbmpE9A=;
 b=Mq4SmCX94x2ut93yFq2uipFLawL7CyemI2qM600BwHNcf6sdIG9EX4gUZIPcq9gu+9YuC08CpBZkuxWXUpF4h1g7X4kABw8/fkf35yfF+nbXrQbUAZPoYaBtFq41EeIJqcRfiTjGOaISpfHas2byRLBh9OBBvyvYUXwmLXW58YVhdAgwVjZER+HlhHr6NzDRuYlo9eHg5vK3nRVPvYVAaufsoXy8KtmutIy9fJRNk+/SBXaJk7F7ggAj0E5Zc0W6bmeaP6sVCPfiqkEpOGT9pD7glMO4oYWP0F7irtzIBbqyNmLv78lEsfBDHPzHl+LIsvc5s4nmO8uHSoJct5oKLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 14:30:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 14:30:43 +0000
Message-ID: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
Date: Thu, 29 Jan 2026 15:30:39 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
Content-Language: en-US
To: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-hyperv@vger.kernel.org
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: e49cb285-1428-4ecd-c63c-08de5f42faf8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmJKcUpWZGZnaFQvLzN3a2daQmpRVkRzS0dyd25VeklDem9MR0VCTkhmWVFo?=
 =?utf-8?B?TlNpUitsNFJsZVExL2EzMXovQ0lwRTBPOGVzZU1UdTZycnZLWFk1ZW5uOVpG?=
 =?utf-8?B?c3NTNXAxTGNSbHNkYzhNRVY2c0RTMjlwWVU1OVFTWDNhZ0dsZllmNjlLNlB0?=
 =?utf-8?B?K0tDc0o0cGdXUjFodFk4Sk42V1NJSFBRZmRuN2xNOTZTR043MkNUdmUvZTZ6?=
 =?utf-8?B?Ry9SUStPS3RIQ3c2eCtNSldhNkEzTTV2dHFleGFJQXZGUFUrYmpPQmtkTE00?=
 =?utf-8?B?YUNjOHM5VStiM2c2YzlvOVNkRkZGbEk4TWlFQ3NNMnJkMlZLQ2RoeG1qRzVv?=
 =?utf-8?B?RDk4Yy84cEhZOFd6djZjMngyQmI2dDhZODg2NVlUaG80bWFaSmFkMWcxMzg5?=
 =?utf-8?B?bVJqcVpQK0oyUEd5TEdZTHpWazhDdWpaYlN6elQ5MlJLd1JUQzRmeFU3aFMw?=
 =?utf-8?B?dEZqdFBmTkl4YzRLc3pPYjI1Wmh0OGUxN0txLzdGS1FPYUh0R3FSeFA3dCtq?=
 =?utf-8?B?ZFlRc3drYVZYNWNXSGtBcEpBWG1YUHNBb2E1eURsK1NiYW8wdW96OUw4cEJo?=
 =?utf-8?B?WnRpOFkwemQrUGhlaWdWMThZUEdROHB0NmVmNnZjSkxoT2xxYmRva2cwcmpv?=
 =?utf-8?B?VTBCSzk5YmtiMDVPdFJxZnpjMGhsaTR0cUo1RHV4bGE2a3daNVFtR1lMRmtn?=
 =?utf-8?B?NEhxTS9sZDVUR3pUM2dTWTdsdkxOOVY3UVpWay9lWk1VNFFDTkovWVNIWkxV?=
 =?utf-8?B?UnpDcFdSNU50dE5FdzJ2RkJTNDV1VjFKaE5IQmtXTzVVZklERktUKzFiNUVG?=
 =?utf-8?B?cWVobTIveXMyN0ZWUGdhZTJMZ2xKYmNmMkt1a05SNVZ1bWRBeVhBR2VmcmVq?=
 =?utf-8?B?T1grQjB2SEFnTjRrZHdnOXZ3UUJpckxVU2gvMkdmeTdDK0U3TndwUjVxa2tH?=
 =?utf-8?B?Qnp1T3BOTzYvUE1WalAvNzQzMWJvQy9FcDdvNEc4UnhUTDhoS25STzNDYWt2?=
 =?utf-8?B?SC9SdmZQQkRYOUxMTW9RQVMwbHhFU0l3MGhYZnVBc3RGS0l0K21VWVdwaEZw?=
 =?utf-8?B?Mk5HTGN1TlNpTE8zUXVVYThLbzQyRmVpaE04Z0dSdjhtY1p5bUV5YmV6WFU1?=
 =?utf-8?B?NHhrd2pVVkRTRHhRMFV1U0RBVWJMczBvMG1zTHk3NFVIelRCQTBsaVlqQjdC?=
 =?utf-8?B?bkpxNGhoSkhTNlRJZWhWS3hNU2VlQnBLNTdtOWtUcWNsNHMrcmRhU1p1SWZC?=
 =?utf-8?B?WFlDcTFJM3Y4dHkreDljMEZEMlJYam0xUSs5aWhTZEZXRmtxaysxelZLcVRx?=
 =?utf-8?B?MGpFRHRBckZMSE11SVBJOFlLRG9WUEFPTGhmL1NBMUozQ3JuMHIxdTBSSjBu?=
 =?utf-8?B?NlZjN1RoeVJuZXJiUFpBa0ovMXZnc3RUL2JIZ1NVQVpIQWMwSTV3aDlJZVVt?=
 =?utf-8?B?MHRLbWlUcmFkVnk0Yk1JYkI0OFhCNVpYWlMxRTJMTFd1V2tmQmRpeGhmaEp4?=
 =?utf-8?B?OE93OWZockVyT0lKb0FqNGg0dW9RblExU29ldUE1TmQ4eFpVRDFhV3RaT0xi?=
 =?utf-8?B?U1hGeHZHVWZIb1lNSjBQNGVwOWlYSDhSSHkrcFlIWnJESS9PTS90M0prSUR5?=
 =?utf-8?B?TzZMVWhTSTFmV1FvaXFEVlYxVEg4aDlXM3ZYOHBFczdPSmx2TmI0OHJFM1dF?=
 =?utf-8?B?MGhla3BjdFEvb3ZEN1J5bWJTaHoxam1Ed0V6c3FNS3BYNlp4VDJwMnk2ZnI3?=
 =?utf-8?B?N1hHK0hGM1RzNFo3T0YwWTlQVGxxajFXdVByUXpyZlY1bWFveGdxOGhzN0Zv?=
 =?utf-8?B?UlplazV1K3k3b0RqN0xISjN2TUpNS05tb3BlV2E3MTVJTTc4THVoK01LMlE2?=
 =?utf-8?B?d3FuQ0lRMW5EbW92SHh5TkxuakFQVDBmR3E0UzEyRG42REIzd1l2UUttVUpj?=
 =?utf-8?B?elZnbThvNUlLTWwzSDZ5RlFLSlFDN3I0cmpkQ3ZCY1FsTlFlbWRwcUxXN3o5?=
 =?utf-8?B?RUxJM3VnZzl2UE9SNitCVCt3Vm1qaXJqT0taSjY2eGxCSE1FNDFEWkJ2dTNH?=
 =?utf-8?B?YlN3V2M5b21JZEZuOUpVWjB6Z3JML1Zkak1KOWxhSjc5Z2VaTzBBd0h5YXQ3?=
 =?utf-8?Q?q1Rrj76G57rHxMHd7d6cZ/kYH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVZLZCttZGFncytCR2JodmFFcU1yYTY4VGVGZDNxRzh0ZEl5Z1F0cThlY1Bh?=
 =?utf-8?B?anNwNVQxbGtnY3JldjJQZWs1Z3ZvaTRKOXRDdWJ6Q3lFRXJIbThXQno1Ykp1?=
 =?utf-8?B?bmxybEs0U0ZUUWN2Q3FDaGp0S2dPbHladWZXZEZOc0xFUnJmMTlxakNscUhu?=
 =?utf-8?B?QzlJNUJiN1hwR0lXdWQ5YzJWNnc1VktYWFNUUEp4dWdaNHVuTjMvMlRFT3JT?=
 =?utf-8?B?TEs5TXk5K1RucVJ0Q1Y1YUFKaGlRQ2NiYndLNnc5VkswMUY4b2gzRWRJdFZu?=
 =?utf-8?B?cEhpUXYrY0lSdlB0Tm1JT0pET0lPaXFIMFJ0Ymt3UmFJWFRJbFJna3NXUFVx?=
 =?utf-8?B?TnZRS2dWV3lpZUFJZVllVEUvYThOMndxRUJzZVpTWkRoKzdZNjV4SXR3Tldm?=
 =?utf-8?B?dEp6VmRiVjNQUEJGNVl1Q3FPdUZQZzF2dHBsdnNpRlhDWkNIVnpDajdVdk92?=
 =?utf-8?B?aEUzSUd0U3lRS3NPejUrbDgyY1BPQysrWTRTeVdBSVJJMVpUaUZCNTBFR0Uv?=
 =?utf-8?B?RUhZbWlteDRRVnV4elFhWVlQeTI0S1ErcU9COFcyVDJpbEtYSGZYeVBqaGh3?=
 =?utf-8?B?VXErV2s3UkVmUHdNOTcrQU9MVWpubk94Qk9zbkdMeGpFZUU3QUU0aGpuKzZx?=
 =?utf-8?B?Z3pQcjR0bjIydHRnek1wUTI2dVo1THRBMnNPOVYvQ3BJWUNwM0dEbU4vOU5W?=
 =?utf-8?B?U2E0SXhETGI1TXVWSU04eTZjYWlaWmdxc0hFd1RhUXFWZndlT1ROVEJXRlhi?=
 =?utf-8?B?TSsybE1uN2hmYUVhbndLWEdaZUdjU0lzRURJTXp5Lzk4RnFpSDFab0FzN3d4?=
 =?utf-8?B?VXBaVFVQT3VnZURwajlyYStrQll3VFh6M1o0d0RXdWVWc0Y2RmpQK3lySFZv?=
 =?utf-8?B?TDJwWnI3SGI0S1Y2VVZNN2g2QUNKajRZN3NCWHJCaEFLR09XdFJUQ3p1dk1u?=
 =?utf-8?B?TEVHeHhwREczaENSWkRpaHkxNjlnQXNESVJBVUhpbUpIOFhkNFJtV2NSOVQ5?=
 =?utf-8?B?eXIrTklYSFp0aGpSWDdFQTN6Q21ndkxFSUZ6VS9sRktzdmdONU1OZ3lKTklx?=
 =?utf-8?B?aTJleE5LTytaRDhHTkpIYjdyMDNxN2Exa2xTK0I3Z09qZVdOYzJMcUxiNEJ6?=
 =?utf-8?B?Z0VpQ0hOL0l1Q2RVMXprd014ZitoVnozalRUQkZlbFhlT3hybnNHZlA5Ui9a?=
 =?utf-8?B?OHg1amwvRi95ZVVnUE16bkxKY2pucTRNUmxMOTFmRkRDS1N6cDdBOWZyQlZp?=
 =?utf-8?B?TGRoSEVjekdyVkR1aXdpaEIvQ2lqaCt2U3NFNVhBRkhUeUZhY0NkZm1nQXNj?=
 =?utf-8?B?Zjh2MFRsRlJoR3VFOTl6eC9wMGNzVm90SFEvVTNBbnBtczhGYmQ0V29xWHpD?=
 =?utf-8?B?UmdZM2xyVmNpK3Q2bVR6T2MxeHhFOW0xK3lFNmZyLzVXVVNPWjRYWnU3TG5T?=
 =?utf-8?B?UjhPSkdVTmszYm9vR0Y0VnBpSzZxN25BWFowYlEyTk5FbGUyZlVYeHNsM1Zn?=
 =?utf-8?B?RmdrWU01d2w2TWI3ZFp3d0U1UWhkTnljcGFqUDlIVXlrcHR0bGdjaENxeXJX?=
 =?utf-8?B?SldPZlJtU2JaUFhwaVpBMGlGZWsvNStsMUlGMCtLWWRDL2d3QTlSUTJ4UWQx?=
 =?utf-8?B?b3RPRVl0dWRab3h3c0VRVHJ5bnFZK1AwVm85cUdiNzBoTXpEeTN2b0FhQndt?=
 =?utf-8?B?VXBkTkNLNXJFT1NyNEJCVitNeVZqSW5hRTNkU0x0dEQ5bkFYdjhxalhYQmZT?=
 =?utf-8?B?emZtQUdnMW13UmhYc2ZHNXFyN2F2TUtCakdxT3FnRDZ4MWppSXY4SUg2dFor?=
 =?utf-8?B?Ny9wdUd1ZC90SHlhOXhjS1didVRvT1RwbnVmWmo0YkRZU1hnbjBsK3VPaXV5?=
 =?utf-8?B?TUVBSzJEL3pjSTk0Qm9LazVuTmY4OE9kVm5mUkVyKzhJL0hvVDJUNFVOZGY4?=
 =?utf-8?B?STZsNDZUY2tXcFBDVytBZ20zYlNPREtpVHZIRHlUaU83RFkwM05LLzJXY21H?=
 =?utf-8?B?dFN1OWlpckYrU3VtOHZoanJXSmU2ckxKeVZuUVJlQ1JDNmRUVTVwSTUyTHBP?=
 =?utf-8?B?RDBzMjBaNXhsMkprdVR0QzZ0Z3ZSc1d0aDBwUDVHaGg3L1BPQzVKb01pTmFF?=
 =?utf-8?B?Q2xRb3Q1RThNUlFTQnNuN2twUE5HZ21KWVU4MmNnWkNKU2tIMzFMZTV1VG1V?=
 =?utf-8?B?U1lXcW9hOEpKa3ZKVkxUREpnamtSSnFjSThWVUNTL3BlOHFpOHpKWGhIa3ZI?=
 =?utf-8?B?aWNZR0F0bElEZndpbkVNcnFXYjhKMXF2eWd0U1B4VTBTT2NWMGdGLzJLbm95?=
 =?utf-8?B?THJFTTIrbzVuWkdxSkF1SEM5NUQrTkkwbkN3SVhCSGpld2RId2t2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49cb285-1428-4ecd-c63c-08de5f42faf8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 14:30:43.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OnXlBN2PyMw7HObwWiF30zpuQFpHMsu2jjgvWSAX4jVwaC82af+KgF1uSm5zLi180Pk5q39LpSOQa9uyeNnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8584-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: 36340B0FEF
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

This resolves the follow splat and lock-up when running with PREEMPT_RT
enabled on Hyper-V:

[  415.140818] BUG: scheduling while atomic: stress-ng-iomix/1048/0x00000002
[  415.140822] INFO: lockdep is turned off.
[  415.140823] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec ghash_clmulni_intel aesni_intel rapl binfmt_misc nls_ascii nls_cp437 vfat fat snd_pcm hyperv_drm snd_timer drm_client_lib drm_shmem_helper snd sg soundcore drm_kms_helper pcspkr hv_balloon hv_utils evdev joydev drm configfs efi_pstore nfnetlink vsock_loopback vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport vsock vmw_vmci efivarfs autofs4 ext4 crc16 mbcache jbd2 sr_mod sd_mod cdrom hv_storvsc serio_raw hid_generic scsi_transport_fc hid_hyperv scsi_mod hid hv_netvsc hyperv_keyboard scsi_common
[  415.140846] Preemption disabled at:
[  415.140847] [<ffffffffc0656171>] storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
[  415.140854] CPU: 8 UID: 0 PID: 1048 Comm: stress-ng-iomix Not tainted 6.19.0-rc7 #30 PREEMPT_{RT,(full)}
[  415.140856] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
[  415.140857] Call Trace:
[  415.140861]  <TASK>
[  415.140861]  ? storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
[  415.140863]  dump_stack_lvl+0x91/0xb0
[  415.140870]  __schedule_bug+0x9c/0xc0
[  415.140875]  __schedule+0xdf6/0x1300
[  415.140877]  ? rtlock_slowlock_locked+0x56c/0x1980
[  415.140879]  ? rcu_is_watching+0x12/0x60
[  415.140883]  schedule_rtlock+0x21/0x40
[  415.140885]  rtlock_slowlock_locked+0x502/0x1980
[  415.140891]  rt_spin_lock+0x89/0x1e0
[  415.140893]  hv_ringbuffer_write+0x87/0x2a0
[  415.140899]  vmbus_sendpacket_mpb_desc+0xb6/0xe0
[  415.140900]  ? rcu_is_watching+0x12/0x60
[  415.140902]  storvsc_queuecommand+0x669/0xbe0 [hv_storvsc]
[  415.140904]  ? HARDIRQ_verbose+0x10/0x10
[  415.140908]  ? __rq_qos_issue+0x28/0x40
[  415.140911]  scsi_queue_rq+0x760/0xd80 [scsi_mod]
[  415.140926]  __blk_mq_issue_directly+0x4a/0xc0
[  415.140928]  blk_mq_issue_direct+0x87/0x2b0
[  415.140931]  blk_mq_dispatch_queue_requests+0x120/0x440
[  415.140933]  blk_mq_flush_plug_list+0x7a/0x1a0
[  415.140935]  __blk_flush_plug+0xf4/0x150
[  415.140940]  __submit_bio+0x2b2/0x5c0
[  415.140944]  ? submit_bio_noacct_nocheck+0x272/0x360
[  415.140946]  submit_bio_noacct_nocheck+0x272/0x360
[  415.140951]  ext4_read_bh_lock+0x3e/0x60 [ext4]
[  415.140995]  ext4_block_write_begin+0x396/0x650 [ext4]
[  415.141018]  ? __pfx_ext4_da_get_block_prep+0x10/0x10 [ext4]
[  415.141038]  ext4_da_write_begin+0x1c4/0x350 [ext4]
[  415.141060]  generic_perform_write+0x14e/0x2c0
[  415.141065]  ext4_buffered_write_iter+0x6b/0x120 [ext4]
[  415.141083]  vfs_write+0x2ca/0x570
[  415.141087]  ksys_write+0x76/0xf0
[  415.141089]  do_syscall_64+0x99/0x1490
[  415.141093]  ? rcu_is_watching+0x12/0x60
[  415.141095]  ? finish_task_switch.isra.0+0xdf/0x3d0
[  415.141097]  ? rcu_is_watching+0x12/0x60
[  415.141098]  ? lock_release+0x1f0/0x2a0
[  415.141100]  ? rcu_is_watching+0x12/0x60
[  415.141101]  ? finish_task_switch.isra.0+0xe4/0x3d0
[  415.141103]  ? rcu_is_watching+0x12/0x60
[  415.141104]  ? __schedule+0xb34/0x1300
[  415.141106]  ? hrtimer_try_to_cancel+0x1d/0x170
[  415.141109]  ? do_nanosleep+0x8b/0x160
[  415.141111]  ? hrtimer_nanosleep+0x89/0x100
[  415.141114]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  415.141116]  ? xfd_validate_state+0x26/0x90
[  415.141118]  ? rcu_is_watching+0x12/0x60
[  415.141120]  ? do_syscall_64+0x1e0/0x1490
[  415.141121]  ? do_syscall_64+0x1e0/0x1490
[  415.141123]  ? rcu_is_watching+0x12/0x60
[  415.141124]  ? do_syscall_64+0x1e0/0x1490
[  415.141125]  ? do_syscall_64+0x1e0/0x1490
[  415.141127]  ? irqentry_exit+0x140/0x7e0
[  415.141129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

get_cpu() disables preemption while the spinlock hv_ringbuffer_write is
using is converted to an rt-mutex under PREEMPT_RT.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is likely just the tip of an iceberg, see specifically [1], but if 
you never start addressing it, it will continue to crash ships, even if 
those are only on test cruises (we are fully aware that Hyper-V provides 
no RT guarantees for guests). A pragmatic alternative to that would be a 
simple

config HYPERV
    depends on !PREEMPT_RT

Please share your thoughts if this fix is worth it, or if we should 
better stop looking at the next splats that show up after it. We are 
currently considering to thread some of the hv platform IRQs under
PREEMPT_RT as potential next step.

TIA!

[1] https://lore.kernel.org/all/20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com/

 drivers/scsi/storvsc_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index b43d876747b7..68c837146b9e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1855,8 +1855,9 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	cmd_request->payload_sz = payload_sz;
 
 	/* Invokes the vsc to start an IO */
-	ret = storvsc_do_io(dev, cmd_request, get_cpu());
-	put_cpu();
+	migrate_disable();
+	ret = storvsc_do_io(dev, cmd_request, smp_processor_id());
+	migrate_enable();
 
 	if (ret)
 		scsi_dma_unmap(scmnd);
-- 
2.51.0

