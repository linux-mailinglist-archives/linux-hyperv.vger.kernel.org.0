Return-Path: <linux-hyperv+bounces-10342-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ViuwMsUm6mnkvQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10342-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 16:03:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA94536DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF4883001A45
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C242E3AF1;
	Thu, 23 Apr 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na8CI7bw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5F275AFB;
	Thu, 23 Apr 2026 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952838; cv=none; b=B/bFiHklRIlY7s6+hNaB3uOjO382qvZJ5A170VhekDZcIcqHNLTMxY0Cgi2HQzOJAnfyKdnh2x1B9GjD4Ci+QD0zmL1rEYbR5RrivX8Z5bAUda/LA+bnir5YHyU0mKLVk6TSz5aItJv4VpjKN0WOOzm+8Cj0b31cDz46r6rVkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952838; c=relaxed/simple;
	bh=mVrK0zXCEdJ6a40kh14ulfHCdH3uQpXGB2DGyceVQ9M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXSrJRhf/9aKl3v2Oh+9s5Y+7m44dk/3Vt+hZmJ3TNudbJ0dFa+0kKJnlNIeJ0xwIuRkNKr1Kw6TRe7SQ4AvGDvhSl7hhqENNlY4mZwnHmBPT8IB2RddyMZGR/exAFiNiTETouyAaZWNIrRm8RiP0tUD7bQTYCd06VlzPeSUL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na8CI7bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C102C2BCB3;
	Thu, 23 Apr 2026 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776952837;
	bh=mVrK0zXCEdJ6a40kh14ulfHCdH3uQpXGB2DGyceVQ9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Na8CI7bwOFFciWF152SK6VpvgW/0uJ9C/ab85EokcYjuHus/X7p5kdg3sgcvfaoT8
	 qHtp6cimBCaiagvbYXjw2BModFBlKGaR7PB9ARWc01gap3WEdVSBIm+os8k2xnkOPu
	 xlBzNX8FRqwIEDKREsGsUViWZfjeYfjGIMrkbuvIEutscXEFDBVc4YlhdVFs9SfT8B
	 WrL3lV26hSmkoRSlYMtK1MQpod6CFooqGC4+WUs8b+cH8X9CS2SdUqsOGlbKAd/AAs
	 SM789kC1D0hTDtVBhRTd6CAMJHrAPGcFthq786V4/J2nP4PQLEQE+epCfoxx3mKPcr
	 Vco1wbe+h2pvQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wFuba-0000000E4rW-3VD2;
	Thu, 23 Apr 2026 14:00:34 +0000
Date: Thu, 23 Apr 2026 15:00:34 +0100
Message-ID: <864il122v1.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: Re: [PATCH v2 07/15] arm64: hyperv: Add support for mshv_vtl_return_call
In-Reply-To: <20260423124206.2410879-8-namjain@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
	<20260423124206.2410879-8-namjain@linux.microsoft.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: namjain@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, mhklinux@outlook.com, timothy.hayes@arm.com, lpieralisi@kernel.org, sascha.bischoff@arm.com, mrigendra.chaubey@gmail.com, linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, vdso@mailbox.org, ssengar@linux.microsoft.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10342-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mailbox.org:email]
X-Rspamd-Queue-Id: CABA94536DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 13:41:57 +0100,
Naman Jain <namjain@linux.microsoft.com> wrote:
> 
> Add the arm64 variant of mshv_vtl_return_call() to support the MSHV_VTL
> driver on arm64. This function enables the transition between Virtual
> Trust Levels (VTLs) in MSHV_VTL when the kernel acts as a paravisor.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Roman Kisel <vdso@mailbox.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile        |   1 +
>  arch/arm64/hyperv/hv_vtl.c        | 158 ++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h |  13 +++
>  arch/x86/include/asm/mshyperv.h   |   2 -
>  drivers/hv/mshv_vtl.h             |   3 +
>  include/asm-generic/mshyperv.h    |   2 +
>  6 files changed, 177 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
> 
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> index 87c31c001da9..9701a837a6e1 100644
> --- a/arch/arm64/hyperv/Makefile
> +++ b/arch/arm64/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y		:= hv_core.o mshyperv.o
> +obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
> new file mode 100644
> index 000000000000..59cbeb74e7b9
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_vtl.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Microsoft, Inc.
> + *
> + * Authors:
> + *     Roman Kisel <romank@linux.microsoft.com>
> + *     Naman Jain <namjain@linux.microsoft.com>
> + */
> +
> +#include <asm/mshyperv.h>
> +#include <asm/neon.h>
> +#include <linux/export.h>
> +
> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
> +{
> +	struct user_fpsimd_state fpsimd_state;
> +	u64 base_ptr = (u64)vtl0->x;
> +
> +	/*
> +	 * Obtain the CPU FPSIMD registers for VTL context switch.
> +	 * This saves the current task's FP/NEON state and allows us to
> +	 * safely load VTL0's FP/NEON context for the hypercall.
> +	 */
> +	kernel_neon_begin(&fpsimd_state);
> +
> +	/*
> +	 * VTL switch for ARM64 platform - managing VTL0's CPU context.
> +	 * We explicitly use the stack to save the base pointer, and use x16
> +	 * as our working register for accessing the context structure.
> +	 *
> +	 * Register Handling:
> +	 * - X0-X17: Saved/restored (general-purpose, shared for VTL communication)
> +	 * - X18: NOT touched - hypervisor-managed per-VTL (platform register)
> +	 * - X19-X30: Saved/restored (part of VTL0's execution context)
> +	 * - Q0-Q31: Saved/restored (128-bit NEON/floating-point registers, shared)
> +	 * - SP: Not in structure, hypervisor-managed per-VTL
> +	 *
> +	 * X29 (FP) and X30 (LR) are in the structure and must be saved/restored
> +	 * as part of VTL0's complete execution state.
> +	 */
> +	asm __volatile__ (
> +		/* Save base pointer to stack explicitly, then load into x16 */
> +		"str %0, [sp, #-16]!\n\t"     /* Push base pointer onto stack */
> +		"mov x16, %0\n\t"             /* Load base pointer into x16 */
> +		/* Volatile registers (Windows ARM64 ABI: x0-x17) */
> +		"ldp x0, x1, [x16]\n\t"
> +		"ldp x2, x3, [x16, #(2*8)]\n\t"
> +		"ldp x4, x5, [x16, #(4*8)]\n\t"
> +		"ldp x6, x7, [x16, #(6*8)]\n\t"
> +		"ldp x8, x9, [x16, #(8*8)]\n\t"
> +		"ldp x10, x11, [x16, #(10*8)]\n\t"
> +		"ldp x12, x13, [x16, #(12*8)]\n\t"
> +		"ldp x14, x15, [x16, #(14*8)]\n\t"
> +		/* x16 will be loaded last, after saving base pointer */
> +		"ldr x17, [x16, #(17*8)]\n\t"
> +		/* x18 is hypervisor-managed per-VTL - DO NOT LOAD */

Wut? Does it mean the kernel is not free to use x18?

> +		/* General-purpose registers: x19-x30 */
> +		"ldp x19, x20, [x16, #(19*8)]\n\t"
> +		"ldp x21, x22, [x16, #(21*8)]\n\t"
> +		"ldp x23, x24, [x16, #(23*8)]\n\t"
> +		"ldp x25, x26, [x16, #(25*8)]\n\t"
> +		"ldp x27, x28, [x16, #(27*8)]\n\t"
> +
> +		/* Frame pointer and link register */
> +		"ldp x29, x30, [x16, #(29*8)]\n\t"
> +
> +		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
> +		"ldp q0, q1, [x16, #(32*8)]\n\t"
> +		"ldp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
> +		"ldp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
> +		"ldp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
> +		"ldp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
> +		"ldp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
> +		"ldp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
> +		"ldp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
> +		"ldp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
> +		"ldp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
> +		"ldp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
> +		"ldp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
> +		"ldp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
> +		"ldp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
> +		"ldp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
> +		"ldp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
> +
> +		/* Now load x16 itself */
> +		"ldr x16, [x16, #(16*8)]\n\t"
> +
> +		/* Return to the lower VTL */
> +		"hvc #3\n\t"

No. Absolutely not. If you need to do context switching, do it in the
hypervisor. Entirely in the hypervisor. You don't even handle SVE, let
alone SME. How is that going to work?

And please use the SMCCC. Only that. Which mandates that the HVC
immediate is 0, 0 or zero.

	M.

-- 
Without deviation from the norm, progress is not possible.

