Return-Path: <linux-hyperv+bounces-9524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJqbBmeXumnSXgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9524-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 13:15:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B22BB4FC
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 13:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D4831837F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0543D523B;
	Wed, 18 Mar 2026 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KpcfNGIW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8E3D646D;
	Wed, 18 Mar 2026 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835929; cv=fail; b=mAkeF2BfQrpowl4Uu2LGNwqjYH3r2O7LFH8JsFAXDFLhRnObtU0B8c9ZPQVILkVGuIvGMJTekeDk+J8MGTaRq114/+GCHhNiY59yF/0UchPHOcL7RDdtMrXk6t33V46qoSmvKczZWIIqaQrlWyVFL1SFbvla7gWtuERfKBlRcvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835929; c=relaxed/simple;
	bh=gXmwfjOEme8UCKwCnTzaQYRsh0xMgkDPxg91MgFxTIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oPvOrxM2bcrMiEUgtGmrhl+fgnav5/VLBUt+DhWNOJoBV/HOzCaUzKm51QUUc6/KMGlrbkPjQyAwBEVI+rLVlrh0UCeA71h39jcB6A36Pmcx4iJPkUuIMy/cHHW5XCqv3xm3xP7yvw2XnKWHoF8ZeS7bVIyyf6xoZgx1T5aUKRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KpcfNGIW; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU7y9X2IbFUk6jZqXappTLiU9VPeD139jFC59wfjAfvJOKGKangCaNyHrxCRZxHbbsMU0EWeOub6uc1QfpQ1fWpVpnd22uQAehnDOqX0MoMvBHeVoYPB9C6az8/mftVYAgm6G4g3GccaepGCpgJHg6ye8azdcky63ibtveix1vHgsUXsm46LYB4jKTLe94V2bybQSpgSmgdMLw0GLhMMy8TuO+NjE4gGUNnuM6ajXAmD74cMXHNq5ZiESYOnu8L5iciwp4LMNlW9UCtVShYbFvUko+x9Rt/ELreuo857s5z4Lr9VvUr8xAZFAHVlgkNE5YumCJJYDufxgf0JDb6+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlvjlqWpE/Co2gUCb75FYFQTspVUIWSBV2xhC2Fmmh4=;
 b=alT3jmr1h350p6bN/Ywe73JAOuVuHOc2FbHDIij+FunCI2JnIXfKKiWOT/swNoISvkEa0Ex5cFTm6esP1QECRqW5Z8xTD4HdZlV2ie66LWgMTZf6QhZNLVHX4mzAw83cPEZLahIqLw9OT+VdLFB8LQm/ZwQZ95I0anILsbrZokZonm9y29tNUJ0FEDtuNByHwWH48bC/Hc3Zm94I2vdT1QZNTgW3Wr5CjhJpfJwSsg8wznJCLrAFmLVGWA/yW2Pm0vb3VomflrvsASqB8zMAFgZrqFM8DX/NqqLlwvvFdnRHRu2rmi2R2drrJPmml7Lk4/oYfxhNYHwOAZK2xke6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlvjlqWpE/Co2gUCb75FYFQTspVUIWSBV2xhC2Fmmh4=;
 b=KpcfNGIW6IULYDxz3zze2+hk88D058Iu5+N7gLZS7gMqZwI96mvo/3D0kYwWdGIUbcQd+2SKhOznbtUT43kxo4C7PFew0wU4NvFTtKamQtw6UHrCDq7TmjvXlrmB/cBUc/4qZJ16JvTkzH18tRsKeeqBjUcwtT9LfCd7zwOJQYfovrgUJtwQHr74NW4pESPmpi1ptoGRdM2bMmKsnicyS9H34rBbW29gwk2GzESH/aizSODQ/Kx6+qUM/pCEIQOyfmrNClNQ2lIjPsMvRyO97x0rG6s3KmzbK67NBVIcJQJHLdQb1SE8k/No1he6aQzXPtpbXA1adP2yf+FCv31uLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 12:12:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:12:04 +0000
Message-ID: <baa1222f-af44-49f7-99bf-c8c48eb093fd@siemens.com>
Date: Wed, 18 Mar 2026 13:12:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
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
 <20260318100138.GimjldpV@linutronix.de>
 <7f248f1f-a4ad-442d-bd85-23e57e58eeba@siemens.com>
 <20260318112113.JDm06Hr-@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260318112113.JDm06Hr-@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8fb760-b12e-4e8e-b0d0-08de84e7915b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iDy8JyMPEsVKA1R9C5ulfclDPehW9gVHHZIgCiAS7piBt8oPaH0V4I5Qb2+b7YlK/i/WCeAcd85BTO+1heBVGNBn3PrqkVnGbkaNiiD5FV2NWpyYbhsmaRONWY0HCwF6Jd+Opum0Xz5dPJa/uwb4fBNmSFUxyU/ib51IKj+ZRRc6hdEJBj22gvocCLNuVxpbGoRPvjqTyDqkP2C6tVTNQWI1P55g6oesSGClvnBrcgLbhyNq8/xkyxzadu8WYmjSuqAIMa+xdbS9QggvYUYW8oDthqVS1h2bWLIP9LvzgD2LUmGi7wyGYG2FEF0P5KDcvYH2oLQ1HT2qSb6saPrDdAMMp6XXf1kisiNc1LSMbhoHve1t5ZbavH9a+DMJxbG6FOL92O+kGL1zRTQqAbfTTHvtRz4jlirTMJ+8tKpmzzyOHFW/QCH4JiQTKkmZAq5B4Jb61ljjcNXqC+2l/+EQb5OI4ViFSF5KWayuL33kd8VFhFWVjoNenotRhjnbZB6rhv0h2KaohYrGCPCEh7+QwXUuJD1NTcEniceGECvHxuSBBkN4eFjqmch22Qwjp6reF8rtMRRyQPTNiC3oq95s0lyuwVtlruX+LQGLjHz0UyYgcnyiGtcGXT0DMUWGWIlX8zHd6vVI6HUpijVqQ+984LwtLQFzR/NGvv2Ky/b3pYJSu/lt8RfenaLFXGKRzovSV+OxHZq6N1WP6+MXD9b813I0nmnvYmZlHRDg0KYRzRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFRPdTk5S1hXelQvUHhkdUxVaHA0RzVpaXhrcUprc3REa3VRU3Y2T2NvVXRE?=
 =?utf-8?B?SXJUY1paQXBNR0RUbHdtTGdUdXVuOFNZVkg0UGlCclhtN2dabHNCNTZOaGx3?=
 =?utf-8?B?c0sySVBzNEtwc0pGZ2FuUjFXOWZkOHRpSU8yTk5jcGFZN3pDMjlIby9aOEVh?=
 =?utf-8?B?aEpVWnpWTkNVd1UzeENVUjZBbkVUK2VEcFFpNmZ3ZFJpVzVYYy90RlNJbmJq?=
 =?utf-8?B?SWtEUS9QN2NERWlZT05mL1F4aURRUG84ZGlCV21ZUzRGdDNaUE9XditWbzZS?=
 =?utf-8?B?Sk9IdFNoRnFlVE41UHp6VU1KZTk3bTJQOVpZTVZJcWE0OUM4ZGdhb0wyRHVK?=
 =?utf-8?B?N2orVW91UEVSK3QzNWFjT0l5b1NkeXV6anorSEM1VTExWG1KaHZVdWI5bmJV?=
 =?utf-8?B?M05Ob0FFN21mN0FEYmZKL3JTVnBzMFpUUm12Mm42VkEzVTBMZWpFdEVVQXlT?=
 =?utf-8?B?Yk05dHk4djg4VlFLenlWR1ZyNEk4WkczOEl2RnlHWE04V3Jmc1o3clBjVEtB?=
 =?utf-8?B?UkZqa3pUaC90cWNGSm9IbksvdDZaeFFxdHNGU0tBQ093OG8zbm5GeXp5Z2da?=
 =?utf-8?B?NmhRMkdQOGk1eE43Q0tsUGczVndXUHZtM3BBZ3hyMENtK0FxUkxBTno1ZHE0?=
 =?utf-8?B?T0pEVjVFWTJDcG5vcTk1WkZTYTNVc3NjbkZ6aDRTUnQvTEQ4L0Z4MHFTZ05s?=
 =?utf-8?B?UE00K01mQUhneGpPbkxzNkdtaDdOWmduODhHeE1XejhKUVQ3YWJST1hOemEy?=
 =?utf-8?B?dTdEUDJ2NWRuRFNGaWk3c0d6S1IvVmNGSXJqSnZPTHhVZkVIbDM5SmFaZXRX?=
 =?utf-8?B?OExMVHNCQnpGeWFhQnpaMHNuUVpmMk91UkdjeFdSa3BUR1R6akVjcVJpOFd1?=
 =?utf-8?B?V29WcHB4Q05hdzJuQUs0NVh1UnFZZWJjS2RuZmhEaDZqSEhCSTVnNUF2RmM0?=
 =?utf-8?B?SU85RFpYL1R3NFI0eW1sbnZaVTRBdGJxK2crNnM3NGZBTlpLS2sxRld5OFR5?=
 =?utf-8?B?Z29XcTBHRGxWU29aNnBYS3BNNXh2dE05MkF5WFhjWWZTcGZ3SWZLRmRyZS9q?=
 =?utf-8?B?d0dDNkNkdEovRERJWmh4aHNGeDQycy9IcEVLM3E0aitrRURXaHE4Vk5oZlhS?=
 =?utf-8?B?Q1BhaHA1ekYvWDFCejIwazFUcHlnWVdQd3BWTjJBQkVlUjJ1OHdGbjdjdnFq?=
 =?utf-8?B?ZUNIVGJ3eThBcnhBRnpiUnhvVDd2WFlqeWlqQzNIU0JGWUxVYU01cnEvZnRp?=
 =?utf-8?B?eXdvZkNETkNYRVc4a0U0SVg3VFptUWtuOThkMlhzSDFOMFZHb0IwQWNlbXA5?=
 =?utf-8?B?bGVuemhQWjRkWkthaW9Sa2t3VFpqYmgrcEtXTlNDWStOZC9sVDNXa0hRaWpQ?=
 =?utf-8?B?NGtxdkx4VWpkTlNXdjBwM2VNTURhUkZkeVVCYUpnWGJqY1pxMG52Qi9vekY3?=
 =?utf-8?B?dW5lZkJwS0xobVAyWVp1ZmFQblhxU1ppY2plYVJnSmVzZGRFV1JGbUNBNjF4?=
 =?utf-8?B?d3ljOEJLQyt4L1RYVC9rUXAzNENnVm1YUG1rVXIwVlpzQzBJUmo4dEZxaTBJ?=
 =?utf-8?B?OWdQK2hEOHNGbUVHZm45aW9VaHhqRng3dlczRGxFdElSc0JEUDNuK3FTbDBL?=
 =?utf-8?B?MC9PVUR4bFNCMVQ0ajJYa3NHT1VZR3JlUitPd1dROG5HQ01zanZZM2Nsd0JR?=
 =?utf-8?B?bWEvcWs3Q1FFVGJMRXNTRFQ0dTl0RXFVQmdSZlNRMzMwaFBOV2xHUThjWm0r?=
 =?utf-8?B?azZzUmVCWXVFZVhTWFptR3NRNXMwdmFuNC85TS80UWxnN1gvSmMxQURiVnVZ?=
 =?utf-8?B?OXZDSlVSQWRsOS90WVBUMUpMc0hCVHJ0U09SU0xjd1NhL0lHN2svNXU2QVVG?=
 =?utf-8?B?MEtSckFaVmRpMWVpZ1YwbFBhanorTkxzdXJBUk9IRzR3MkVKL0xGZXE3bnZP?=
 =?utf-8?B?OWVPWkRtZzlkaEV3UDFpVFZ0dTAzYlhRa1RXS1ZQR1BjbXZmaGswR1dza2Qr?=
 =?utf-8?B?c3VtZUxWdmRNV09pTnkyTkhUTmN6TTA4eDFoanMybnVtOEozSTZLUzlZQ2VM?=
 =?utf-8?B?RWxpcDhKbUNhS0Z2eXM0bTd2dWdQRnFYYVNrRit1QzBIVThMaXpqTElYMXpm?=
 =?utf-8?B?M0Z0VlJ0VzNtRDhDMzhWaG4xcjlySitVL3N2OHUyV3psTjZFQzVSaW0yd2Q4?=
 =?utf-8?B?N1BZdWEyUEc2RlFFVEtRWVMzSTBML0xYNzJpb0oyczNHVDgzdnlOTEJpOEtT?=
 =?utf-8?B?RTQ2bE53Vk1tYkFtTXU2YmJ6M2ErUVlQbHBSTUZCYXRMM21oUjBDTFZIS2pV?=
 =?utf-8?B?OHcwWkg1VWVhMmpjTFZxOXJWSkdUY1k0L09lYmw4VkVWVTZJVVYvYno3VXVK?=
 =?utf-8?Q?+iPBlvd0P0BGASVU=3D?=
X-Exchange-RoutingPolicyChecked:
	FAfz5pD78IyEE+DaRLcpQBiozW56W/QEttE+I849FGlzK2rHwS7j/WhTiJ/gSWcgVeaCrsF6RGj2Ldk0Kh+9CtYXqg/XGoOiLGYzHIG6IIzaG+V53VTJYTFinQrbpBHVgdx/g+X5FpWKE97iX1HsHEVFEX884eFkqssJ31V4fugxRI3nXRx1eKTqO8WGwHettVe4wE/geTlM3nTlGtcwBFjUPPYJMCAmuJBtwHDETeopwtF24snNuBoBh9gSYxp1ict2afmAJ+0Tbpa+9ckoohVYYN556qnBLzjhUNupNE1HHJqx5IuQBexSIdnrRZCUTqFegWD6oM4Z9t+oPbgoUQ==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8fb760-b12e-4e8e-b0d0-08de84e7915b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:12:04.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAWNQL8vvdJ2osAsfw9PXd4uSONTgyRbCKhi9LI5XlYWVHZ7G2EB1xYEIZ17KhisIAMUEs0X+EoE6/GTK5KMng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9228
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-9524-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: 744B22BB4FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18.03.26 12:21, Sebastian Andrzej Siewior wrote:
> On 2026-03-18 12:03:03 [+0100], Jan Kiszka wrote:
>>> Either way, that add_interrupt_randomness() should be moved to
>>> sysvec_hyperv_callback() like it has been done for
>>> sysvec_hyperv_stimer0(). It should be invoked twice now if gets there
>>> via vmbus_percpu_isr().
>>
>> No, this would degrade arm64.
> 
> Okay. So why does this needs to be done for _this_ per-CPU IRQ on ARM64
> but not for the others? What does it make so special.
> 

See the other thread:
https://lore.kernel.org/lkml/SN6PR02MB41573332BF202DAE0AF79ED1D441A@SN6PR02MB4157.namprd02.prod.outlook.com/

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

