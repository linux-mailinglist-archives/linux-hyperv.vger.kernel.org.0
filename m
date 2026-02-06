Return-Path: <linux-hyperv+bounces-8756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qua5Kv6MhWmrDQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8756-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 07:41:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB39BFAB6A
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 07:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8383014C26
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Feb 2026 06:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3530CD81;
	Fri,  6 Feb 2026 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="edilGTgg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFFA2E1C6B;
	Fri,  6 Feb 2026 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360058; cv=fail; b=lS/baYsVC2GfbEhdRKSf2Em+OeG48feuiSgJf0eYwEVY37ZDx1D8S9vY/gwniKO3D3kn62cTgiD55Na+jWdi4ZBXmKSL1aGK0HHzKoLsLTRnpbLpwqGEuowqXgSBLABn7uDoBqhBX2ImZDYO9SiV5Ica7X0AsoJb2/S1OfJlQ/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360058; c=relaxed/simple;
	bh=k77uDeHHI1baPoTDE2mzH5xlX3vTAqXI0fh3Y1FRNzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mDtfAwCtYHwnkWPGqWCLVIwDnxlHWXoEAL4PGGMtZ1Zct9NqltXwV4WRKyR42JmzdD2M/RXAaEepUQ2ik5E9Ofe9MmB0ZvzlOh5GTXnWMeiAyAZ5ZHxT4QAfMuyPLVCzd2zr2J6or4mgWvBWwivqPljA0xnsHzp3QVlreuKy+QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=edilGTgg; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPeMFuZ5B135sI88WVLrz5kPjmbdXjQN793GIOUHNepalukZ6sBVHFC8ZB8hZoMlvOK4RFN2XsLX4h4duhnAlGZacKHm9hJoktToAsY25vG3v9Ia0G2KiDBFpaIc7NnB5+n8uD/1kYnUnNe/0qENVXkV1mz7YoABU7rTFYOIBW+Z6ug2hMgQXbky8j9KkoiJpCuAP2UUhpRp2jhX4gfVPXBNa5bRCRNpzs7Pgm9hhoLhazswqyc3Xss/RyuZm4VR5c9GgBGh8E8NaD62CW/W+UTKWUx3hiZEV1WwVYREqMTWXFDbRheT+qfULzvGEFgGQBs9nzGbi2AR5paFxFkp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u3xAVqiUKlR1jrTPADMaaYnCCl4vs50xj3QBjyn74Q=;
 b=WQy/ina798rI9a9EFrOdUOJWl8OtOgHPNGMXBuDUntpQFJQUSbErWLV4D1k8spS69cYfftuMMGQt7yVbKR3xinzEggmIcXOhhThYlHlqWh0xpkMDtDBfZ56q9sjR8lstlv6xE02xQyRW3zg7qfZzM99JJRy6OEQO2QaTr1Ojr5mRE6gbKIUMDORUINbhwahNmSypmdUIA9r3SEbcyQPmX7QeT1+AFxLbk+Oo22pEGqHgPIuYaVaLK7IIJgLKO4kE9WrWA55L4wE2bowIirJuW1TwzHNFWDGK5TdpYIlip49leNTnGCsqRXRj70SEyAgwYFmA+IPSmZf8P+vdDeslUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u3xAVqiUKlR1jrTPADMaaYnCCl4vs50xj3QBjyn74Q=;
 b=edilGTggVvWq8UzGKpx8+IaFiP70TVzN+RgWQu8NM1GmabI7oHSm7JHIHGsf6PC6a97yKI7jeLxZ1K3P3EkVnGriKbBnoqqUF+9Fq7g1uhaEx2287Zk7CN7/f9C3bLmkZn7AB3IaZf/ju2FHjeFMGLu3+0ewLg/tSPI5BAOY8qCPLe7rnkFspiBLowatJr0TejqUixRv+Msiu2jMbpJpYA9LbQY/FRiEwfDXRAeY/sMR9+x1HEWRufz7RO6iByaqvnit0Sst0QF2KlbnHOzhYfRE2/zczgSWD51bZ1/+VCgX+moJfKRiRF7Vv2YK5Iji7BuD1SU8IVXknOG7D6ftyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB6206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 06:40:54 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Fri, 6 Feb 2026
 06:40:54 +0000
Message-ID: <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
Date: Fri, 6 Feb 2026 07:40:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
To: Michael Kelley <mhklinux@outlook.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
 "schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3f9f43-39c8-476a-eae2-08de654aad50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm4zQkphbnc0a09VVzNEdStvTnFaaGFyQnp5N0NhcThUeXRLQ1NmTnlQNFhh?=
 =?utf-8?B?WHNDbG1YTXdOamh5dCtEM2hnUFBkemlBbCthRTlMc2NIaXk4U0pSVHdNTk1R?=
 =?utf-8?B?WXQ2ZUdVaFovRXVlVEZzcEJ3dklYcDY1NVU5YUxRT21sZk10STNSNTZEaG5i?=
 =?utf-8?B?SkdrOS9Hb1RtNXFjdUxEMTBLeTc2K0VNRER5elU0VTE3MXBmeHgxUGFFb0N1?=
 =?utf-8?B?TmtqcDIwRXJBV2ljbkJ5SHBvK2V4M05VS21KbnRKM3N6TlJ3SmJnUFRzaStZ?=
 =?utf-8?B?Q1QrMEpYNjUvWUU0RnRzQ0N2cHJMaCtHYmlBbnZlbittQzlFWkszQ1dMQXZn?=
 =?utf-8?B?SGhkYTlucE1VWHR0MVNhdlQ4QzJzZGx2cERxakZrWCtFelNHN0UreHdDSFd2?=
 =?utf-8?B?VHpaL2hiQ3gzMjR6ZDdqNGQySEp0UGtnZmlFS2tQbWFSeTFNNG1ndXkzMnpY?=
 =?utf-8?B?VkowZEt3UEg1Q1lLZWJEM2RqVXBIZ0ZYWmNmQUFGSWc3cW5kMERBVlQrMHRq?=
 =?utf-8?B?OEtUTUgzYmlhNGVMc245dHphdHgyN3lNWDM1cnUxaVd4aW9BMzRNYUdIWlRZ?=
 =?utf-8?B?dmpBQ0FpbWN3a0lFVlIzKzdGejBxMVdPUWxxZ2FoY1EwZTdQenk4SndMVVZq?=
 =?utf-8?B?bTRFdktnZTZXS210RDYwZkp1NHNuSFppYTZ4bFg4MEM1THRqZzE2NytSTmky?=
 =?utf-8?B?TDlLT0hudlRPNUZBVHl0RVZtSjVpRjlmdWJqR3BKWXNvUVJTbU1MeWhZSUtU?=
 =?utf-8?B?NEkyZUg3MEdtRytxVWZ1SDlQWGdGQ2s0blhsNEpaeXFWTzlvNHVjUjdkRWdP?=
 =?utf-8?B?bFhMdGUvaHhpNU5jU09JSkFMSXVjallIemxqQmZncnR0eWxmZlkrWVphZmRC?=
 =?utf-8?B?NDh4UDRpTnBzUmoxRWxEQUp5TzVQQ2o1Tk9iVGVaVktWTklvbkg0OXFTdXZr?=
 =?utf-8?B?dUZuOENPcmZSVW1STFZIUkNBR1AxWXdpKzRkemttWXZZLytUYlB3bTk3UTZP?=
 =?utf-8?B?eVlpV0hGYXNlSEFDVmJQeCtrbFRpNFM2c1V6dXRzSTBBWThJdFJWNVEyUnYy?=
 =?utf-8?B?N2JCeUZaemFRVS9ZZjVjUGYxcWxQK0QyQU40WmpFMklqak14dFFJWkllOGQr?=
 =?utf-8?B?dmhqQ0owS3dWMU9zMlQvbDdYeVRna2xRZDE2bkpiNDhhYUxHSXZmOUJqc25U?=
 =?utf-8?B?empiNFJFR2RQcDU2UGc3RHpDS0xKOXRwRVEveHh4VDJMQWllZXV4MFJuTndR?=
 =?utf-8?B?QUtWSGh4dkh0Sm9ob2ZxMFAvaG01eEduY2MvK1FOVDFFOGExdzJ5N3lyeVNo?=
 =?utf-8?B?Z1UyaVJTVmVVZ29VTnJYQkxzRi9IR3J3ZStnQ2tJSzBkeEVxZTh3Sll3UmZh?=
 =?utf-8?B?bG1pOFNOdk5HZ0dvWS90ZC9XNDZCTlRqcnUwSHI5Z3hKUXdFWnJRQWFiRGF1?=
 =?utf-8?B?S2NkWjRQNzB5TUlhMldUdjc2VFNrVlBwM2lTUjd3K1FZNW1FUjY1THBIZSt2?=
 =?utf-8?B?eElRL3NXMUYrbTQ1NEFSMEJEcjcxTTJvZUlxYWxDRVdMWnRrd3U0Zkd4VmhP?=
 =?utf-8?B?aU5SNEM0OUltQjVZQVN0MitUcFFtUWtTWjduMzI2T093OEpSaGZsTHlKKzVY?=
 =?utf-8?B?TlZma3o4NURhbGVOVW9vekNrTFVYNklGSmtkcGZpbmZPamQrRmkxS2ZNZmJv?=
 =?utf-8?B?YUdBNGprYWVjaCtnajg2MmpsUVVTNEFwZm4yT21zS3Zna281bDRBbVBsaVEx?=
 =?utf-8?B?RG5veGtDU2VFcW9UNFV3emlQUGxWQi9BUWFHRFJjZm5YN2hjYTR2NVNyVDB4?=
 =?utf-8?B?MjhPRzQ5SGVHRkRkZURXVFhhclpIMXZaUUlhOG1tbmt5VktDNnFOWkx5RVdP?=
 =?utf-8?B?dCs5ZVJRZVlPQS8rU0F5dzBBei9DWTVrQWVQa3pYZEZwN09kVXEvcEY3K2FT?=
 =?utf-8?B?Qzl5NEkxN3hCK3pQYUVZVDM3cHVka0VpalZXSmxia1FlVUViV2ZhS0NMVlJJ?=
 =?utf-8?B?SDlleUxEWkk2VWxsaE9IdzAxd1IzeDlZbnlOR2I4Y2FTOHdqQ1U3Znp2aXN1?=
 =?utf-8?B?MVIyaXROOW81bnZhanJBaXJaRGw4aXpBS1RDMHZUd0tFdlZaZHVUM0R4VFBq?=
 =?utf-8?B?ZjRBYlpPdHJpT0lzRnRHa3JYVGlOUmhQVVF6clpCNzdnNFBpemdBak1RMTBt?=
 =?utf-8?Q?S7JkoAmHvyPvU8XHMguYZYI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFQxRlJhaE82cHd2dGdnYTQ1ZkZLRXR4cCtrSnJSMzB1azF6S01HWXZjeW5V?=
 =?utf-8?B?Z3V4Ymg5Wjdid21nbUZ1dGxxZXdzY2R6N2I1TE04eXRBamR5QXVSaGxvbHRB?=
 =?utf-8?B?VVgrRlhuS3puSENjNW45ZU43dHl3MTRaSWtxdVpCdEJZUmhMNVEyVm1VWnFq?=
 =?utf-8?B?SU00V3R4aDJWYXR3cjRxV1lUNGM1dStQbmEybysxZjZONEtYVHpUQ0RnZFNu?=
 =?utf-8?B?aEpUaEh5RDZaNFZJRCsxUCt6MnNpeW9ualQzeUlkNklpK2FacGN0c0R5Y2xa?=
 =?utf-8?B?bFI0ZURMNVhoRFZCQjJ1WEpNeFJFeDFVY3NQYzUrZ3l0dEYycTdqTjZaNTFn?=
 =?utf-8?B?V0IvdDFFNllpOU9zRXhDejl5M3pZc1VZNTlXd21JMUZrVEZ0WFBpZDVXRWY0?=
 =?utf-8?B?ZFl5a3JpWGVZMUI3VlFOR1VNQ2xpcy9xbTRjZGdNMlJrd2VsZWFucW9yRUVU?=
 =?utf-8?B?a3A2eTRlVUhGbmVQUkV4TVU1cUNNbEM1ZUFGU2JuVkNHMmZQOXZsK3FwcXA5?=
 =?utf-8?B?b3ptNFVNeTI2Tko3K0N0M0Rsa243UXpWcnFqeFFaSWkxTnRYWXl1NmFGMGRl?=
 =?utf-8?B?V3J3K1plRk9aSDZvR252WDVyeXExSmMxRGFTMDdjU3RRZTlsU3d1N002bkhH?=
 =?utf-8?B?c09YV0diVkJONUtFSkxVVDhIYXNIZmllTEtwaXYzOS9LdVlBQ1JlTlVFbk9u?=
 =?utf-8?B?NmtMWnAzWEVybHMwZWFOSDAybnFPNllibm1SMFo1Z2hkV2ZETGdOUC9XclhG?=
 =?utf-8?B?aFZmcDZ6clNqYnhlMVNDRDZFcVhzbVBoOEd2QmJqQmdLNUFhcWhxTWNQUXhB?=
 =?utf-8?B?enpmdC9jdjRZd3lWZEUxd0RkaFdGK1NwQ1lmQkNscGtVRURRN0U1NVo2UEVR?=
 =?utf-8?B?ejE2MFhZbnBncWdRT0llYzhqQ1h3aUlCc2NQY1ZVd0JOczNsdnV0YSt4RWQ1?=
 =?utf-8?B?ZTA1ZHJiSlJuRW5MbUlDVFBZaEZnMmZWMXVJYkNWelFHa21wL1I4OHlyeWhK?=
 =?utf-8?B?WXJLak1SUlRYM2ZoaldxbVNaM3d4MHMyakJJSDNLbGFrNzIyd2VhS1NwQlkz?=
 =?utf-8?B?S1p4eXNHYXdGV1ZFODB0UStkOWNBNEdWa3pLMm1QNkh1NGdRRm5SYlBUY3FR?=
 =?utf-8?B?UzU3c3RPNDZJa0hjdU44L3hqVXNOSDROY1VkSE1vSjIrbFRtWDNmQjM4QVVm?=
 =?utf-8?B?bTZYR1pwaUdlVGFJTjhoQTlKZTd3MzllT2RvUFlYRm03dUptZjVRc051ZHNX?=
 =?utf-8?B?WHlqOXZKV0lSYW82aVpIRmx1MEhoZEdSa1BnaVZtSmMydGVROXZPaFZ0OTds?=
 =?utf-8?B?dkJyUFpWNkNObnFPYVA1MkwrN1JaL3d6OHEwdW9mNkxrYk84TUE5KzM5dkV6?=
 =?utf-8?B?eXBhdTFHNlBUd04xN3lxd0MrZW5kN05hQTlvK0dPVVZwd1UrM3VVcjdyQ01o?=
 =?utf-8?B?VEVSK1ExdzRoMmR6VmdDU2sxN0gyMUM0emVxQkQrWjBDQ1ZzSXZId0RlVE1I?=
 =?utf-8?B?M2pvWlY5dU8raTdKQStFWmNGMDFBV1dSWXB1cWRZMm5HKzYzbmQybytTWnhm?=
 =?utf-8?B?d3ZYdnB6TVpYWHErQ0RYQzFDZlNlWFNkYU96ZVg0ZEpMUUhadGlzV2ZueHJY?=
 =?utf-8?B?SEt0cFV3TG5sa2pyRE5VUStWcmFsb2JyVmFnbnY1eVhYTmptaEUrREJEUURO?=
 =?utf-8?B?QSt0RkRCUSsvTzI2MmIrSWZ4L1JkOWhyd3NuTVc2VXovQ1VGamh4dGpRdVVD?=
 =?utf-8?B?SmNvZ25rdmpvL2lzR0RZSmZ3dEQ1RnJzcUpSQ1pydnErdS84WllXeEo2cVgr?=
 =?utf-8?B?QzhQdWVzNWJLWUZRLzQyTnMra3VzVXRoczBhN2Q2WnpOWlg2cjBscit2SCtO?=
 =?utf-8?B?Tmx4dS9tR1FNa2FaQTNkUkEzZmRhZ1JJTzZSR1J2Qm9YSDZod2xjOVpDSkp2?=
 =?utf-8?B?V1cvOHZrL3ZJNU13c2xJd0ptVTRwSm8zRFloakIxNnlvWkZhOG54WkVCU3l0?=
 =?utf-8?B?a1VwOWdjMkRvaHJneWNseVMyOWhaU3RkbmdpLzZFK0V5eDR2a2RpVTRMcUVT?=
 =?utf-8?B?RDRsTVRLblBXbi9xUTJiWjFzTy9PWnd4aVk4bkFsUS9zTERqaW9hWTI0MFNL?=
 =?utf-8?B?elNNbXZ5RHVFdUlxVFVyZU44Y1lBcUtQRG0raTBVdWtOd3hFSTRUbzVIQ2xh?=
 =?utf-8?B?ZDkwMlpPSHhnN1dqUFMrdzFNaDQ4M3hEMWNOMkRpQW5nemtvS2NQUWtKVmJu?=
 =?utf-8?B?bm1JeFFFbTl2UkxZcXcwSDY4ODJEcVJEZUM1LzV6aWtaYUI4V2RoWmh6SzVo?=
 =?utf-8?B?Q0d0eGxxV3FnVm9HcEVqcDREL1ZRa01heW9KZHRZVTlxOVZYL1g3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3f9f43-39c8-476a-eae2-08de654aad50
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:40:54.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwCyrYCoTA7Ba21OXrYeTZmAEgspBxDX/hQ+UcfhWW41ayqtoFkaWA88en8AzeL8xjB8caenPsw6SvH1CU6uDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8756-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com,linux.microsoft.com,anirudhrb.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,siemens.com:dkim,siemens.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB39BFAB6A
X-Rspamd-Action: no action

On 05.02.26 19:55, Michael Kelley wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Tuesday, February 3, 2026 8:02 AM
>>
>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
>> with related guest support enabled:
>>
>> [    1.127941] hv_vmbus: registering driver hyperv_drm
>>
>> [    1.132518] =============================
>> [    1.132519] [ BUG: Invalid wait context ]
>> [    1.132521] 6.19.0-rc8+ #9 Not tainted
>> [    1.132524] -----------------------------
>> [    1.132525] swapper/0/0 is trying to lock:
>> [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
>> [    1.132543] other info that might help us debug this:
>> [    1.132544] context-{2:2}
>> [    1.132545] 1 lock held by swapper/0/0:
>> [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
>> [    1.132557] stack backtrace:
>> [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
>> [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
>> [    1.132567] Call Trace:
>> [    1.132570]  <IRQ>
>> [    1.132573]  dump_stack_lvl+0x6e/0xa0
>> [    1.132581]  __lock_acquire+0xee0/0x21b0
>> [    1.132592]  lock_acquire+0xd5/0x2d0
>> [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
>> [    1.132606]  ? lock_acquire+0xd5/0x2d0
>> [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
>> [    1.132619]  rt_spin_lock+0x3f/0x1f0
>> [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
>> [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
>> [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
>> [    1.132641]  vmbus_isr+0x2c/0x150
>> [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
>> [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
>> [    1.132658]  </IRQ>
>> [    1.132659]  <TASK>
>> [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
>>
>> As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
>> the complete vmbus_handler execution needs to be moved into thread
>> context. Open-coding this allows to skip the IPI that irq_work would
>> additionally bring and which we do not need, being an IRQ, never an NMI.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This should resolve what was once brought forward via [1]. If it
>> actually resolves all remaining compatibility issues of the hyperv
>> support with RT is not yet clear, though. So far, lockdep is happy when
>> using this plus [2].
>>
>> [1] https://lore.kernel.org/all/20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com/
>> [2] https://lore.kernel.org/lkml/0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com/
>>
>>  arch/x86/kernel/cpu/mshyperv.c | 52 ++++++++++++++++++++++++++++++++--	
> 
> You've added this code under arch/x86. But isn't it architecture independent? I
> think it should also work on arm64. If that's the case, the code should probably
> be added to drivers/hv/vmbus_drv.c instead.
> 

I checked that before: arm64 uses normal IRQs, not over-optimized APIC
vectors. And those IRQs are auto-threaded.

That said, someone with an arm64 Hyper-V deployment should still try to
run things there once (PREEMPT_RT + PROVE_LOCKING). I don't have such a
setup.

>>  1 file changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 579fb2c64cfd..1194ca452c52 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/irq.h>
>>  #include <linux/kexec.h>
>>  #include <linux/random.h>
>> +#include <linux/smpboot.h>
>>  #include <asm/processor.h>
>>  #include <asm/hypervisor.h>
>>  #include <hyperv/hvhdk.h>
>> @@ -150,6 +151,43 @@ static void (*hv_stimer0_handler)(void);
>>  static void (*hv_kexec_handler)(void);
>>  static void (*hv_crash_handler)(struct pt_regs *regs);
>>
>> +static DEFINE_PER_CPU(bool, vmbus_irq_pending);
>> +static DEFINE_PER_CPU(struct task_struct *, vmbus_irqd);
>> +
>> +static void vmbus_irqd_wake(void)
>> +{
>> +	struct task_struct *tsk = __this_cpu_read(vmbus_irqd);
>> +
>> +	__this_cpu_write(vmbus_irq_pending, true);
>> +	wake_up_process(tsk);
>> +}
>> +
>> +static void vmbus_irqd_setup(unsigned int cpu)
>> +{
>> +	sched_set_fifo(current);
>> +}
>> +
>> +static int vmbus_irqd_should_run(unsigned int cpu)
>> +{
>> +	return __this_cpu_read(vmbus_irq_pending);
>> +}
>> +
>> +static void run_vmbus_irqd(unsigned int cpu)
>> +{
>> +	vmbus_handler();
>> +	__this_cpu_write(vmbus_irq_pending, false);
>> +}
> 
> The two statements in this function should be swapped. This function
> runs with pre-emption enabled and interrupts enabled. If a VMBus
> interrupt comes in as vmbus_handler() is finishing, vmbus_irqd_wake()
> will run and set vmbus_irq_pending to "true". This function will then set
> vmbus_irq_pending to 'false", wiping out the "true" setting. The hotplug
> thread will decide it doesn't need to run again, and whatever generated
> the new interrupt doesn't get processed (at least until another interrupt
> comes in).

You are absolutely right. The reordered pattern is the same as in
irq_work - for the very same reason. I'll send v2.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

