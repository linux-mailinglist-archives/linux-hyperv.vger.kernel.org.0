Return-Path: <linux-hyperv+bounces-9516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VNJFJZs9umlbTQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9516-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 06:52:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFA2B6027
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 06:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626C6301993C
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 05:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBB313E2B;
	Wed, 18 Mar 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gAdFW3c5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B99277CA4;
	Wed, 18 Mar 2026 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813143; cv=fail; b=GcZ7GuZWjKoan6M77AExIZABNUvkeQQGR01/z/UCisD0nYwmo91RhL7PZj4XI7uMVhYb8A5y4aeYCcy7y0mkvXk5z/E9vSvAD4pYa+gqoOhyA7GN+KerdyDshVRZsvd+Lw4m0tqlH8ewo6oWCkWZpOmt+mk7ogxdiRcVBtLG12g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813143; c=relaxed/simple;
	bh=xvVwJ4q4t71Jxseb8cJbDuT5Rm/ib9X6g2Y5x1pdoi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0/ku9PO0fPvlcDMVaWO9DeBdYLbUgTrt8/P7ipI+YU3fIL1QnkzRM+k7mWQ70i4w/tHRH2+nl1NhkNy2hmIIN2xKS2qoomxpZyNUzBsGSEGBfDVxzlNNgdw3ylqxcFwGEpPo1RV3odzrUJANQMTRu4C2L2LzgQ/uoFWX/s1+SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gAdFW3c5; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vG2Q5vZeAOW7YwhN6Q/+UVKst5MP0GHXOfSW6ZPFVdU5xbiFu9BOlj2rx5yCU5P9iQNLS0HF0rBaof3T19pkMikKE7dvWTaRf8C6gdCyNO44XF3emZC6im8izyJlq0a0oPXii6bJIvnn61+rRvXsoAud4n2SAh+Dw9btme46GLV4j2BiOn3Hgbr2oWdGHfSwUmwCJjYeOiTROkWStpCZdFSpqKS6IeaHI9+O+gON3WA2nLO5+aijX6hOyD79r8cgb9DUx7VL4KmgTufNnN/k+/JAjbtImqOzAZeLDfkXrq6UNBVUqg9EBy6R2sXUlZWIAcGLH0TGSKKIODpa7ITHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN9wkkcgmiJeKQx7eVjjafIiIj3P/fA2s4tn5LTdYKQ=;
 b=ctzVVN6zFcqvBN/XVEOZ+4uZE8yhSbhO/D2RpjHYwrhGNvIyYYll92MfzFvTSRbFDfE5snt8v+nEnoUI1hNAO8AyQtkDLolxnpgeYbdKSahIe4ntXIQ30XpDTsb8tWg92dZ/QenxfZuwI2YKA+0fi6Cmzc02iAuZikiUAq9EsR4mmz3JxWPAFH3yI2tzipad409fMretvh7c+S9VQ2190FiUOvK70KZBN3pM2U/P8i46ubB2PWEFngOASB0P5BMUC04ZhsBmjTMDk+1q1tPmvbRsj04RpvS1Sk7/lJfmdMnFERMkJBY9Fl8yFKM+glHgCOsGpgjfiY+QgErlh1790g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN9wkkcgmiJeKQx7eVjjafIiIj3P/fA2s4tn5LTdYKQ=;
 b=gAdFW3c5Hm6jcmk+/3rsQI3AeDqnPZTm+NFtDhMLxNDTklOUq0mmIXyiyhhiHouNpMqhAwmOe1QU9BH5eMK3xacoO7cySilA0GKHdb4+lcHCpA5Gccq6cVdKLoCf8GEfV2mj5uAaO2rJMYyDzFuQ0QDcgTsxNCAPjiLpQVwh4v/ML3dMgM21yDTm+3vMy/eNDMYceQVweCbMp50QFeiihiFFsiJPzndtwuv96Aj8ex995iixSDXOnFMk1ns2Mv2TBMT+xP9OVyAAbLiFPOZRgQsy2t+diM6pEqcS3dx+tSqkspzadr70IpG3JwF5s5H4SlEKgZj35aoFlq9jO4XT/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 05:52:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:52:16 +0000
Message-ID: <26a1df78-cde7-450f-979d-3425e5574ba5@siemens.com>
Date: Wed, 18 Mar 2026 06:52:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
To: Michael Kelley <mhklinux@outlook.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, Saurabh Singh Sengar
 <ssengar@linux.microsoft.com>, Naman Jain <namjain@linux.microsoft.com>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: c00179b0-8374-4765-b99b-08de84b282b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R3S+D83MGw3MYBwywXJRUDy/W9cYduB3KiFzE5K4DcO+vBKAaiTQLQLm+T9PZ5l/kX4mdpGbdOgtWEsecNXk18V0qqFlsE2nhymlePAz6U+p2Vgy0PznJF3deSCdgzimatZkphh/gg7gS/SIuw1zfIbMsNVRSyOVgDu9XhftrC1eQSnQlnuOHKZQ/C+Ngi0sceIajS+5U9dI3L2CVsv+X/CZmb9+1aQiOCLtiocELD7k8qsnUiixXpBfNkoXXBBbcCtQZ/f7lJJYGJQPOgSJdwdq5+aLtFq4UcXtoA7JCIifmxmFH+hy8Ft4Tama9/WX5poZ0WyIA/h0VrfzvS12bVGajLlh94ZgAdd7VqP0uDSOa6bAmWkJNIu9hnWUCyBoZp+8QbSlat5ifvhfZtRIsMDnh165Ir//tP3BjhKHjkqG4OdG8YdMrbORf0kYBDtw9Jw0FDFpyA75OOBq20AjcG7D2hV4T1fEv3s8oCz84pm6LKk9Z7X1hKvi9BR3d5mTbV7i+YvCLukWR7O8qjR14Ke0zanOYaQW1RYt5B5hZ6u2x/NkbE9S+BqoSZFYY8xMfMaICLtE/Fpq5uvAHHKhgMudMXhmWIwVln2oTUAyDF9FFenhj6SML7w8SH0rzrXvIDir/y7+7eAn/CSmgVU/Ggie1GDisvG6nzLJLUjXdlnzRq7ZEytYJt7GsNEWxLN2f8r9GtvhMLGqrEVJ9eJockQ/kNnFDGJjhA8fwuHhdNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(55112099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDkrY0JxbTlrV3paTko1a1lHWS9KVEJVRFNBVHdGODdUTXlvc3RMWDlsTU5C?=
 =?utf-8?B?aEJBT0lNMVJEbEVGTSt5VFVVbUFYYWFGai9aM2YxYW5pbVV3OXFTYk9qbGtU?=
 =?utf-8?B?N0tzREJrZmFVWkxUQThab2k0ODlHQjQ4Q0RpM2dqaEhFbW90VnJUb2tPNXhh?=
 =?utf-8?B?My9aZEs4T2FQNTdYazg3QWo2aVdybDdpcFhuRklEbVRNcDJibDBPejBLYlhh?=
 =?utf-8?B?cFpRaVVaempzV3RkSGI2Mnlac0N4Wmg3TEQ4T2VwSlcyNkkzc3ljaGxyUkxY?=
 =?utf-8?B?Y2VXdmt1VXpwVk5Wb05welYzY1NiSzNMTzBKbFQzMWNVdlpUNUo2cmkwM094?=
 =?utf-8?B?Y3hySVAzQ1psdk5VY3FCcjVEQ1BJc2ZNcXRONUlObmF0ZFJDdXBqaU1PdkdY?=
 =?utf-8?B?bHlwOXRsc1Z2ZG4yK1FHWDIzcGVHVW00UHZhcmUxMFN1NTRiYlNOa1B5OWg5?=
 =?utf-8?B?cGpqZG43Sk82U3MxYjRxcWVBSUFYY1VmV3NBUEoyZWJhZmExaWZ4UEZuTWVx?=
 =?utf-8?B?MlZobXhsalZkR0M2Zmt4cEI0MXROVWljN0dKZDRYbHdRQ2FmWXFkKzV0VlFo?=
 =?utf-8?B?ODNnNFFkUzFUNlBCc0FYaDdWWG9HSjNNM3ZoZE9CKzNtTHc2eHlZd0ZaV0RP?=
 =?utf-8?B?eUp4dEZ6bWFjTTlCd3hFdjNqVTdjeUlIcXNSNGhlSzRZTi9iWHlXTk01WWtP?=
 =?utf-8?B?aWZYWWdZcHBZSHdXSUNNaElGditqUldjeThpN29zWDMyVVQ0NmlzcEZEZHQ3?=
 =?utf-8?B?RTNjWkFKVVZIbXZiVTdxU3FyOTI5RWVPeXdMT2VIOENOTFd5bnV3Vzdld0pX?=
 =?utf-8?B?K3NITEI5ZDR4dW5PNW5aMlZ6WUFuWHIwM2ZEZDhwOW5Xb1RqRFBrLzJaYmMv?=
 =?utf-8?B?UWpLVFBhYVJRM2pQcElPdmhLakV4ZEdKYTZBWm0wZFdxWE1nUzZaTUp0WVdk?=
 =?utf-8?B?MXVkbThwcUJ0V3dBbWhPZFhTL0t2aVRUejVZcmhkTEFnZDFIMFB5dmZnUTgv?=
 =?utf-8?B?d01vTDhaY24xTTZ1amJRR0hVcmZwalp1blB3RXF1THJuY2tpNys1aW5YQkNZ?=
 =?utf-8?B?ck9mZVozQ05QZEZlWWFQRE1tK3luQXJtUVFPQmZ3cVYxN2wrSW01MWFBc2pR?=
 =?utf-8?B?RHhzREdsbnNSMlZwSDAyUEl3QzhHdklVeW5tV1NUWEZ0V3htNVZoTGgya0x4?=
 =?utf-8?B?Vm1uWGlVS3p4RFFnaFZjZFI3OFYrZDZGdExta3p4RE1HVWQyVnl3cis0SW9X?=
 =?utf-8?B?V3FKUnRPMTdJbDFBemc4dkVpOXpWTFdOZmp2SHlWR0tsU01JWEVMaysyMzN0?=
 =?utf-8?B?SnVXZDhtK0laUU5CSGdFU2ZjQ0hpMm1iQjhHWE5qYVNNY0h6R0lVRXhDaDJi?=
 =?utf-8?B?TCtadTZ6UCthL0dFYzdFQVFTTTByWjlwTUl4QVNTbXYyQ0ZFNXVDamNBc1Vp?=
 =?utf-8?B?cUhMTHgvWHJFZWgzRnUvSTFpRlBTbldxYUxtWUtxMndXU2RSTDNiRHJSRUEw?=
 =?utf-8?B?eTdoclVROXQwMFROS3lvcWdwTzlSUEVTaitZbVAwdHFmZFR2bWExT0x5MTJZ?=
 =?utf-8?B?Q2NUREYrSGlTZGlaTlFwaG53dHJSdFRoQ1BlWk1JYUFEZzVod20yaG1rcjQ3?=
 =?utf-8?B?NjlMNFg2T05Ld3gxSFJZT2F4cVE2NG5pYllvWHI1MUlUa2FkVmJwZGl2b2V4?=
 =?utf-8?B?QlYyVnpPQ3AxcFpDbzRkS3FqaER4ZE82UTB0RzBwbENzRTlRUlRkYkdnTGRX?=
 =?utf-8?B?SFNxS0VtQldzODBIK0NCUDUzY0NRRW1IMmxwR1JtQ0huZjMxSnhFQmxYdWtU?=
 =?utf-8?B?RnRDZnh1MWwxZFhZMVlHclhhaXV2b2RjcmsvL2RTYk4yYzJZQVo1b1JZekYr?=
 =?utf-8?B?NUtSdDFVdHE2VVVIcXFyQWFpMzRNK3FGdk92cU96UGVLSGhZUE83QkM0ZjNo?=
 =?utf-8?B?S2x3VVZ1d0h6RGVaVmYzT29aMEExN0VRM25VVzUyOG1xa1VWQ0syZENteS9u?=
 =?utf-8?B?SXNQNExqWklQSmFySGZJNVFrNHhxaEUvUWlVcm1BbnhMeFNNYTBxcnRUKzZi?=
 =?utf-8?B?VnFsandJbWRWMDBQV3Ixb0pWVG8rTjQ2OXhKS1FMeWZtQVVZaU1PK0s4UWlU?=
 =?utf-8?B?U3dQVnh0dldwOWRMTld0ZGM1Ty9QWWJwZXhWNURiTUpNeXlLQlNKSkJwYnJ4?=
 =?utf-8?B?RWYwQkprTzlZcUxBT01WVTFwTDUyRHFER2dYa1N2eGxkWHhQaHBDOGYzeWl6?=
 =?utf-8?B?NjJVTE5mVmhtZlpQdjJ0RnNLeSsxc1h5K3pZbFpPUy9NaWsvS3Jvc2RIbUJv?=
 =?utf-8?B?M0N1R29sbjYxVkRDdTM2bkx1R21BcjdGZXZkOXpkT3lqSkRPKzZ6dz09?=
X-Exchange-RoutingPolicyChecked:
	GcpnGdBEH5SpUeUAtKqKLQSqo4+iuk0AqLh0Qpfw5lOakXUMKAjjtfpS6wsHUE9b2VbH1/Q1yUlMpRVR0i3sYCdRsyVnF/5c1/kd4tal0APXxEe1kemTfpNFoyCsLGbgzqI3eVvt6zFnDWWadrIfyedD6U3bCsRRdPLMN3C7C603fJHViC4Y05swU4NeXvjgHbx9S7pzLonWkvwyOdBpyYoPttQKllt7PmEum7v0zjdGx2P8cTNw64H+1KhF+OYg6BF99rqbx5qlAqN+0QIH/QTCkP3enPJEi/xmsKdFvIAFksmCL1DgSEMG30HZsViU9K1+ppp3PT3SBe9q6zsxDA==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00179b0-8374-4765-b99b-08de84b282b1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 05:52:16.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FptxVpT/VhuLNknBlxUIIMFaLACJRN+hKIHZReqQSgVrM6afZQP9j/Ndvgn5VOS9AkgPaT4qnHJVE4bO4HAKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6089
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-9516-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,linutronix.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:mid,linutronix.de:email]
X-Rspamd-Queue-Id: E6DFA2B6027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.03.26 18:25, Michael Kelley wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> Sent: Thursday, March 12, 2026 10:07 AM
>>
> 
> Let me try to address the range of questions here and in the follow-up
> discussion. As background, an overview of VMBus interrupt handling is in:
> 
> Documentation/virt/hyperv/vmbus.rst
> 
> in the section entitled "Synthetic Interrupt Controller (synic)". The
> relevant text is:
> 
>    The SINT is mapped to a single per-CPU architectural interrupt (i.e,
>    an 8-bit x86/x64 interrupt vector, or an arm64 PPI INTID). Because
>    each CPU in the guest has a synic and may receive VMBus interrupts,
>    they are best modeled in Linux as per-CPU interrupts. This model works
>    well on arm64 where a single per-CPU Linux IRQ is allocated for
>    VMBUS_MESSAGE_SINT. This IRQ appears in /proc/interrupts as an IRQ labelled
>    "Hyper-V VMbus". Since x86/x64 lacks support for per-CPU IRQs, an x86
>    interrupt vector is statically allocated (HYPERVISOR_CALLBACK_VECTOR)
>    across all CPUs and explicitly coded to call vmbus_isr(). In this case,
>    there's no Linux IRQ, and the interrupts are visible in aggregate in
>    /proc/interrupts on the "HYP" line.
> 
> The use of a statically allocated sysvec pre-dates my involvement in this
> code starting in 2017, but I believe it was modelled after what Xen does,
> and for the same reason -- to effectively create a per-CPU interrupt on
> x86/x64. Acorn is also using HYPERVISOR_CALLBACK_VECTOR, but I
> don't know if that is also to create a per-CPU interrupt.

Long ago, we demonstrated via Jailhouse that you do not necessarily gain
complexity on the hypervisor side by providing a minimal PCI host and
attaching all your virtual devices to that instead. Even longer ago in
the absence of proper IRQ controller virtualization on the various
archs, there was a bit of performance to gain doing "special"
interrupts. All these design decisions made sense at a certain time but
you would likely no longer repeat them today.

> 
> More below ....
> 
>> On 2026-02-16 17:24:56 [+0100], Jan Kiszka wrote:
>>> --- a/drivers/hv/vmbus_drv.c
>>> +++ b/drivers/hv/vmbus_drv.c
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/cpu.h>
>>>  #include <linux/sched/isolation.h>
>>>  #include <linux/sched/task_stack.h>
>>> +#include <linux/smpboot.h>
>>>
>>>  #include <linux/delay.h>
>>>  #include <linux/panic_notifier.h>
>>> @@ -1350,7 +1351,7 @@ static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message
>>>  	}
>>>  }
>>>
>>> -void vmbus_isr(void)
>>> +static void __vmbus_isr(void)
>>>  {
>>>  	struct hv_per_cpu_context *hv_cpu
>>>  		= this_cpu_ptr(hv_context.cpu_context);
>>> @@ -1363,6 +1364,53 @@ void vmbus_isr(void)
>>>
>>>  	add_interrupt_randomness(vmbus_interrupt);
>>
>> This is feeding entropy and would like to see interrupt registers. But
>> since this is invoked from a thread it won't.
> 
> I'll respond to this topic on the new thread for the new patch
> where Jan has moved the call to add_interrupt_randomness().
> 
>>
>>>  }
>>> +
>> …
>>> +void vmbus_isr(void)
>>> +{
>>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>>> +		vmbus_irqd_wake();
>>> +	} else {
>>> +		lockdep_hardirq_threaded();
>>
>> What clears this? This is wrongly placed. This should go to
>> sysvec_hyperv_callback() instead with its matching canceling part. The
>> add_interrupt_randomness() should also be there and not here.
>> sysvec_hyperv_stimer0() managed to do so.
> 
> I don't have any knowledge to bring regarding the use of
> lockdep_hardirq_threaded().
> 
>>
>> Different question: What guarantees that there won't be another
>> interrupt before this one is done? The handshake appears to be
>> deprecated. The interrupt itself returns ACKing (or not) but the actual
>> handler is delayed to this thread. Depending on the userland it could
>> take some time and I don't know how impatient the host is.
> 
> In more recent versions of Hyper-V, what's deprecated is Hyper-V implicitly
> and automatically doing the EOI. So in sysvec_hyperv_callback(), apic_eoi()
> is usually explicitly called to ack the interrupt.
> 
> There's no guarantee, in either the existing case or the new PREEMPT_RT
> case, that another VMBus interrupt won't come in on the same CPU
> before the tasklets scheduled by vmbus_message_sched() or
> vmbus_chan_sched() have run. From a functional standpoint, the Linux
> code and interaction with Hyper-V handles another interrupt correctly.
> 
> From a delay standpoint, there's not a problem for the normal (i.e., not
> PREEMPT_RT) case because the tasklets run as the interrupt exits -- they
> don't end up in ksoftirqd. For the PREEMPT_RT case, I can see your point
> about delays since the tasklets are scheduled from the new per-CPU thread.
> But my understanding is that Jan's motivation for these changes is not to
> achieve true RT behavior, since Hyper-V doesn't provide that anyway.
> The goal is simply to make PREEMPT_RT builds functional, though Jan may
> have further comments on the goal.
> 

That is exactly the goal: A Linux guest happening to use a PREEMPT_RT
kernel should correctly run on Hyper-V, and that without losing relevant
performance. However, we do not expect any deterministic timing behavior
from such a setup.

>>
>>> +		__vmbus_isr();
>> Moving on. This (trying very hard here) even schedules tasklets. Why?
>> You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
>> You don't want that.
> 
> Again, Jan can comment on the impact of delays due to ending up
> in ksoftirqd.
> 
>>
>> Couldn't the whole logic be integrated into the IRQ code? Then we could
>> have mask/ unmask if supported/ provided and threaded interrupts. Then
>> sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
>> instead apic_eoi() + schedule_delayed_work().
> 
> As I described above, Hyper-V needs a per-CPU interrupt. It's faked up
> on x86/x64 with the hardcoded HYPERVISOR_CALLBACK_VECTOR sysvec
> entry, but on arm64 a normal Linux per-CPU IRQ is used. Once the execution
> path gets to vmbus_isr(), the two architectures share the same code. Same
> thing is done with the Hyper-V STIMER0 interrupt as a per-CPU interrupt.
> If there's a better way to fake up a per-CPU interrupt on x86/x64, I'm open
> to looking at it.
> 
> As I recently discovered in discussion with Jan, standard Linux IRQ handling
> will *not* thread per-CPU interrupts. So even on arm64 with a standard
> Linux per-CPU IRQ is used for VMBus and STIMER0 interrupts, we can't
> request threading.
> 
> I need to refresh my memory on sysvec_hyperv_reenlightenment(). If
> I recall correctly, it's not a per-CPU interrupt, so it probably doesn't
> need to have a hardcoded vector. Overall, the Hyper-V reenlightenment
> functionality is a bit of a fossil that isn't needed on modern x86/x64
> processors that support TSC scaling. And it doesn't exist for arm64.
> It might be worth seeing if it could be dropped entirely ...
> 

I suppose that all depends on how long Linux needs to support the
underlying hypervisor versions and interfaces, no? It's a bit like
supporting old hardware...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

