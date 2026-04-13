Return-Path: <linux-hyperv+bounces-10137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK26ANMf3WnYaAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10137-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 18:54:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 931263F0311
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 18:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAFCE3044ED3
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0993195E4;
	Mon, 13 Apr 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BQ7kiNkZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D6318B96;
	Mon, 13 Apr 2026 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099168; cv=none; b=PGJs2zh5gtQd+xssBPKzd66xwS3c0uW/WQHZxbxB+KK3j9IiCEWczyQjtIbTHN7EPYOQMSk4Yif3phvA7npO9NgUop0uexJKHfegMwzSSnB86yp47Gz38yHa3sy/3Jgpekw7+mb6sbk/1eu30O9POPt/mLNmBisKfTLKFvr9D4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099168; c=relaxed/simple;
	bh=kBCODNhwDsAiQnIld7Shp4/5zOkis0XnuioiUYzL+gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxC1ciOYuTNTfp1SfyhZyrX7dn6sAH3DOLhbKNydAx6nacpIbNDqlVYyCmhlocfljBrd3lswsX3ojlR/DmkU2wF3bXOhZQL8Z2kjT9ZC4g4WRBQ2whJXBE6nmkhMptP6vmIAzBsxdBqMulg0awgHHPU6gMULsoER+Ew8rgrPS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BQ7kiNkZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.106] (unknown [49.205.253.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id E3EA220B6F01;
	Mon, 13 Apr 2026 09:52:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3EA220B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776099166;
	bh=rEWHzLuJu4zX+Y0HjonY8SyN6SoByDg0tpQoTVpx6X0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BQ7kiNkZOj9VWO9d91KpQVM2qP+HGmECvTedlMX7D+JxReubmmeIHpiy5c1qFL4zk
	 H9O1BOFtbYJp2VdUAxKWSNfeOwcvPcqOA02iYlp6uyoE1GJ7VOxym4OkG1XlTfiYqP
	 JPqNDGX28wy6sItqWGsGV7XLlO+OGY8vH5GYXcno=
Message-ID: <90d8b888-e801-4751-8e7a-79d1ec9ed59b@linux.microsoft.com>
Date: Mon, 13 Apr 2026 22:22:35 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] arch: arm64: Add support for mshv_vtl_return_call
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-8-namjain@linux.microsoft.com>
 <SN6PR02MB4157D3C4F6F376C8D6C3D234D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D3C4F6F376C8D6C3D234D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10137-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 931263F0311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:27 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
> 
> Nit: For historical consistency, use "arm64: hyperv:" as the prefix in the patch Subject.

Acked.

> 
>> Add support for arm64 specific variant of mshv_vtl_return_call function
>> to be able to add support for arm64 in MSHV_VTL driver. This would
>> help enable the transition between Virtual Trust Levels (VTL) in
>> MSHV_VTL when the kernel acts as a paravisor.
> 
> This commit message has a fair number of "filler" words. Suggest simplifying to:
> 
> Add the arm64 variant of mshv_vtl_return_call() to support the MSHV_VTL
> driver on arm64.  This function enables the transition between Virtual Trust
> Levels (VTLs) in MSHV_VTL when the kernel acts as a paravisor.
> 

I can see the difference clearly :-) Will use this in commit message.

>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/Makefile        |   1 +
>>   arch/arm64/hyperv/hv_vtl.c        | 144 ++++++++++++++++++++++++++++++
>>   arch/arm64/include/asm/mshyperv.h |  13 +++
>>   3 files changed, 158 insertions(+)
>>   create mode 100644 arch/arm64/hyperv/hv_vtl.c
>>
>> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
>> index 87c31c001da9..9701a837a6e1 100644
>> --- a/arch/arm64/hyperv/Makefile
>> +++ b/arch/arm64/hyperv/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-y		:= hv_core.o mshyperv.o
>> +obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
>> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
>> new file mode 100644
>> index 000000000000..66318672c242
>> --- /dev/null
>> +++ b/arch/arm64/hyperv/hv_vtl.c
>> @@ -0,0 +1,144 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2026, Microsoft, Inc.
>> + *
>> + * Authors:
>> + *     Roman Kisel <romank@linux.microsoft.com>
>> + *     Naman Jain <namjain@linux.microsoft.com>
>> + */
>> +
>> +#include <asm/boot.h>
>> +#include <asm/mshyperv.h>
>> +#include <asm/cpu_ops.h>
>> +
>> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
>> +{
>> +	u64 base_ptr = (u64)vtl0->x;
>> +
>> +	/*
>> +	 * VTL switch for ARM64 platform - managing VTL0's CPU context.
>> +	 * We explicitly use the stack to save the base pointer, and use x16
>> +	 * as our working register for accessing the context structure.
>> +	 *
>> +	 * Register Handling:
>> +	 * - X0-X17: Saved/restored (general-purpose, shared for VTL communication)
>> +	 * - X18: NOT touched - hypervisor-managed per-VTL (platform register)
>> +	 * - X19-X30: Saved/restored (part of VTL0's execution context)
>> +	 * - Q0-Q31: Saved/restored (128-bit NEON/floating-point registers, shared)
>> +	 * - SP: Not in structure, hypervisor-managed per-VTL
>> +	 *
>> +	 * Note: X29 (FP) and X30 (LR) are in the structure and must be saved/restored
>> +	 * as part of VTL0's complete execution state.
> 
> Could drop "Note:".  That's what comments are. :-)

Acked.

> 
> 
>> +	 */
>> +	asm __volatile__ (
>> +		/* Save base pointer to stack explicitly, then load into x16 */
>> +		"str %0, [sp, #-16]!\n\t"     /* Push base pointer onto stack */
>> +		"mov x16, %0\n\t"             /* Load base pointer into x16 */
>> +		/* Volatile registers (Windows ARM64 ABI: x0-x15) */
>> +		"ldp x0, x1, [x16]\n\t"
>> +		"ldp x2, x3, [x16, #(2*8)]\n\t"
> 
> On the x86 side, there's machinery to generate a series of constants that are
> the offsets of the individual fields in struct mshv_vtl_cpu_context. The x86
> asm code then uses these constants. Here on the arm64 side, you've calculated
> the offsets directly in the asm code. Any reason for the difference? I can see
> it's fairly easy to eyeball the offsets here and compare against the registers
> that are being loaded, where it's not so easy the way registers are named
> on x86. So maybe the additional machinery that's helpful on the x86 side
> is less necessary here. Just wondering ....

There were complexities around static call etc. in x86 which led to that 
redesign. Here things are much simpler and the offsets we see are 1-1 
mapped to registers. But I still tried to prototype it, and it looked 
more complex than it has to be. I think we can keep it in current form.

> 
>> +		"ldp x4, x5, [x16, #(4*8)]\n\t"
>> +		"ldp x6, x7, [x16, #(6*8)]\n\t"
>> +		"ldp x8, x9, [x16, #(8*8)]\n\t"
>> +		"ldp x10, x11, [x16, #(10*8)]\n\t"
>> +		"ldp x12, x13, [x16, #(12*8)]\n\t"
>> +		"ldp x14, x15, [x16, #(14*8)]\n\t"
>> +		/* x16 will be loaded last, after saving base pointer */
>> +		"ldr x17, [x16, #(17*8)]\n\t"
>> +		/* x18 is hypervisor-managed per-VTL - DO NOT LOAD */
>> +
>> +		/* General-purpose registers: x19-x30 */
>> +		"ldp x19, x20, [x16, #(19*8)]\n\t"
>> +		"ldp x21, x22, [x16, #(21*8)]\n\t"
>> +		"ldp x23, x24, [x16, #(23*8)]\n\t"
>> +		"ldp x25, x26, [x16, #(25*8)]\n\t"
>> +		"ldp x27, x28, [x16, #(27*8)]\n\t"
>> +
>> +		/* Frame pointer and link register */
>> +		"ldp x29, x30, [x16, #(29*8)]\n\t"
>> +
>> +		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
>> +		"ldp q0, q1, [x16, #(32*8)]\n\t"
>> +		"ldp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
>> +		"ldp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
>> +		"ldp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
>> +		"ldp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
>> +		"ldp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
>> +		"ldp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
>> +		"ldp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
>> +		"ldp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
>> +		"ldp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
>> +		"ldp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
>> +		"ldp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
>> +		"ldp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
>> +		"ldp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
>> +		"ldp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
>> +		"ldp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
>> +
>> +		/* Now load x16 itself */
>> +		"ldr x16, [x16, #(16*8)]\n\t"
>> +
>> +		/* Return to the lower VTL */
>> +		"hvc #3\n\t"
>> +
>> +		/* Save context after return - reload base pointer from stack */
>> +		"stp x16, x17, [sp, #-16]!\n\t" /* Save x16, x17 temporarily */
>> +		"ldr x16, [sp, #16]\n\t"        /* Reload base pointer (skip saved x16,x17) */
>> +
>> +		/* Volatile registers */
>> +		"stp x0, x1, [x16]\n\t"
>> +		"stp x2, x3, [x16, #(2*8)]\n\t"
>> +		"stp x4, x5, [x16, #(4*8)]\n\t"
>> +		"stp x6, x7, [x16, #(6*8)]\n\t"
>> +		"stp x8, x9, [x16, #(8*8)]\n\t"
>> +		"stp x10, x11, [x16, #(10*8)]\n\t"
>> +		"stp x12, x13, [x16, #(12*8)]\n\t"
>> +		"stp x14, x15, [x16, #(14*8)]\n\t"
>> +		"ldp x0, x1, [sp], #16\n\t"      /* Recover saved x16, x17 */
>> +		"stp x0, x1, [x16, #(16*8)]\n\t"
>> +		/* x18 is hypervisor-managed - DO NOT SAVE */
>> +
>> +		/* General-purpose registers: x19-x30 */
>> +		"stp x19, x20, [x16, #(19*8)]\n\t"
>> +		"stp x21, x22, [x16, #(21*8)]\n\t"
>> +		"stp x23, x24, [x16, #(23*8)]\n\t"
>> +		"stp x25, x26, [x16, #(25*8)]\n\t"
>> +		"stp x27, x28, [x16, #(27*8)]\n\t"
>> +		"stp x29, x30, [x16, #(29*8)]\n\t"  /* Frame pointer and link register */
>> +
>> +		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
>> +		"stp q0, q1, [x16, #(32*8)]\n\t"
>> +		"stp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
>> +		"stp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
>> +		"stp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
>> +		"stp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
>> +		"stp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
>> +		"stp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
>> +		"stp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
>> +		"stp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
>> +		"stp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
>> +		"stp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
>> +		"stp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
>> +		"stp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
>> +		"stp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
>> +		"stp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
>> +		"stp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
>> +
>> +		/* Clean up stack - pop base pointer */
>> +		"add sp, sp, #16\n\t"
>> +
>> +		: /* No outputs */
>> +		: /* Input */ "r"(base_ptr)
>> +		: /* Clobber list - x16 used as base, x18 is hypervisor-managed (not touched) */
>> +		"memory", "cc",
>> +		"x0", "x1", "x2", "x3", "x4", "x5",
>> +		"x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",
>> +		"x14", "x15", "x16", "x17", "x19", "x20", "x21",
>> +		"x22", "x23", "x24", "x25", "x26", "x27", "x28",
>> +		"x29", "x30",
>> +		"v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
>> +		"v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
>> +		"v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
>> +		"v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
>> +}
>> +EXPORT_SYMBOL(mshv_vtl_return_call);
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index 804068e0941b..de7f3a41a8ea 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -60,6 +60,17 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>   				ARM_SMCCC_SMC_64,		\
>>   				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>>   				HV_SMCCC_FUNC_NUMBER)
>> +
>> +struct mshv_vtl_cpu_context {
>> +/*
>> + * NOTE: x18 is managed by the hypervisor. It won't be reloaded from this array.
>> + * It is included here for convenience in the common case.
> 
> I'm not getting your point in this last sentence. What is the "common case"?
> 

This was really odd :-) I should have spotted it. I'll change it to:
It is included here for convenience in array indexing.

> You could also drop the "NOTE: " prefix.

Acked.

> 
>> + */
>> +	__u64 x[31];
>> +	__u64 rsvd;
>> +	__uint128_t q[32];
>> +};
> 
> struct mshv_vtl_run reserves 1024 bytes for cpu_context. It would be nice to
> have a compile-time check that the size of struct mshv_vtl_cpu_context fits in
> that 1024 bytes. That check might be better added where struct mshv_vtl_run
> is defined so that it works for both x86 and arm64.

Acked, will add it.

> 
>> +
>>   #ifdef CONFIG_HYPERV_VTL_MODE
>>   /*
>>    * Get/Set the register. If the function returns `1`, that must be done via
>> @@ -69,6 +80,8 @@ static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, u
>>   {
>>   	return 1;
>>   }
>> +
>> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
> 
> This declaration now duplicated in mshyperv.h under arch/arm64 and under
> arch/x86.  Instead, it should be added to asm-generic/mshyperv.h, and
> removed from the arch/x86 mshyperv.h, so that there's only a single
> instance of the declaration.

Acked.

> 
>>   #endif
>>
>>   #include <asm-generic/mshyperv.h>
>> --
>> 2.43.0
>>

Regards,
Naman

