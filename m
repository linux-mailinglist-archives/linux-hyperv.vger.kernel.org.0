Return-Path: <linux-hyperv+bounces-3618-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9639A0652D
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECCD3A6787
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CC51AA1E4;
	Wed,  8 Jan 2025 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VTQS1N17"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80C86333;
	Wed,  8 Jan 2025 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363832; cv=none; b=ESMAL/p7FE/qL334IyzXJLZTsRlUq92r2BLzEtv+QHT/nYF6DZs5q/KWea+8JgMYLLpafwzG3mmoGvOqI+AtNXqvH7ySKXAE9vg7+tizB4RLUJhxtLS0euRpR0YRoiRyfJvs8XIFXq7zZFqAkbEONKWyw73u+qLTqpkORLhjGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363832; c=relaxed/simple;
	bh=UCMxhQrb8LyxwmfBY69p6d9Ip/MkSK2afFUTi3tEabw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzsE1dJ+umwJoSXaCX/nKR2Ua+YZnoYCFu3bEkcBmctChgfD4pGyUOeckbAMlnPE+44SX+oDg78Zf/HIUsMux/RuSIz26rGKJu8jNTNytA5NRAm8mTUnFyBzHwsGlO2BLKyxNhsLBF/CVWAzMFfzZw7P0V8BhjJX3aa5lNRu0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VTQS1N17; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8EADC203E3A8;
	Wed,  8 Jan 2025 11:17:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EADC203E3A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736363830;
	bh=oe6OdxudYks4LimCDKVpbUlJsYXW1xpE2YbsJPFqa7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTQS1N17lFRBHU2xCpRtjUdsVTwQ+BypxS08BokziB3xBiJXciWd0X78smaZfv7MP
	 sllBxPU6TqDZc2Lqa55oBfE43QXmyuqH0e6oOD5GcYwWUsyD9IqKzAu5+qjT0vBqH+
	 mIdbv6XXOX7Ke7FPKdK3HcZtklxd3KcQGOA79Cxk=
Date: Wed, 8 Jan 2025 11:17:07 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Message-ID: <20250108191707.GA120@skinsburskii.>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
 <20250106171114.GA18270@skinsburskii.>
 <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>
 <20250106193248.GB18346@skinsburskii.>
 <3c90bc0f-be28-4f10-8057-be5e780c5a24@linux.microsoft.com>
 <20250107191848.GA24369@skinsburskii.>
 <17dfb71a-119c-4906-bc22-4f65fb28676b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dfb71a-119c-4906-bc22-4f65fb28676b@linux.microsoft.com>

On Tue, Jan 07, 2025 at 03:11:15PM -0800, Roman Kisel wrote:
> 
> 
> On 1/7/2025 11:18 AM, Stanislav Kinsburskii wrote:
> > On Mon, Jan 06, 2025 at 01:07:25PM -0800, Roman Kisel wrote:
> > 
> 
> [...]
> 
> > My point is that the proposed fix looks more like an Underhill-tailored
> > bandage and doesn't take the needs of other stake holders into
> > consideration.
> The patch takes as much into consideration as present in the hyperv-next
> tree. Working on the open-source project seems to be harder otherwise.
> A bandage, or not, that's a matter of opinion. There's a been a break,
> here's the bandage.
> 
> > 
> > What is the urgency in merging of this particular change?
> 
> The get_vtl function is broken thus blocking any further work on
> upstreaming VTL mode patches, ARM64 and more. That's not an urgent
> urgency where customers are in pain, more like the urgency of needing
> to take the trash out, and until that happens, continuing inhaling the
> fumes.
> 
> The urgency of unblocking is to continue work on proposing VTL mode
> patches not to carry lots of out-of-tree code in the fork.
> 
> There might be a future where the Hyper-V code offers an API surface
> covering needs of consumers like dom0 and VTLs whereby they maybe can
> be built as an out-of-tree modules so the opinions wouldn't clash as
> much.
> 
> Avoiding using the output hypercall page leads to something like[1]
> and it looks quite complicated although that's the bare bones, lots
> of notes.
> 

How is this related to the original discussion?
My concern was about the piece allocating of the output page guarded by
the VTL config option.

Thanks,
Stas

> [1]
> 
> /*
>  * Fast extended hypercall with 20 bytes of input and 16 bytes of
>  * output for getting a VP register.
>  *
>  * NOTES:
>  *  1. The function is __init only atm, so the XMM context isn't
>  *     used by the user mode.
>  *  2. X86_64 only.
>  *  3. Fast extended hypercalls may use XMM0..XMM6, and XMM is
>  *     architerctural on X86_64 yet the support should be enabled
>  *     in the CR's. Here, need RDX, R8 and XMM0 for input and RDX,
>  *     R8 for output
>  *  4. No provisions for TDX and SEV-SNP for the sake of simplicity
>  *     (the hypervisor cannot see the guest registers in the
>  *     confidential VM), would need to fallback.
>  *  5. The robust implementation would need to check if fast extended
>  *     hypercalls are available by checking the synthehtic CPUID leaves.
>  *     A separate leaf indicates fast output support.
>  *     It _almost_ certainly has to be, unless somehow disabled, hard
>  *     to see why that would be needed.
>  */
> struct hv_u128 {
> 	u64 low_part;
> 	u64 high_part;
> } __packed;
> 
> static __init u64 hv_vp_get_register_xfast(u32 reg_name,
> 		struct hv_u128 *value)
> {
> 	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS |
> 					HV_HYPERCALL_FAST_BIT;
> 	unsigned long flags;
> 	u64 hv_status;
> 
> 	union {
> 		struct hv_get_vp_registers_input input;
> 		struct {
> 			u64 lo;
> 			u64 hi;
> 		} __packed as_u128;
> 	} hv_input;
> 	register u64 rdx asm("rdx");
> 	register u64 r8 asm("r8");
> 	register u64 r12 asm("r12");
> 
> 	local_irq_save(flags);
> 
> 	hv_input.as_u128.lo = hv_input.as_u128.hi = 0;
> 	hv_input.input.header.partitionid = HV_PARTITION_ID_SELF;
> 	hv_input.input.header.vpindex = HV_VP_INDEX_SELF;
> 	hv_input.input.header.inputvtl = 0;
> 
> 	rdx = hv_input.as_u128.lo;
> 	r8 = hv_input.as_u128.hi;
> 	r12 = reg_name;
> 
> 	__asm__ __volatile__(
> 			"subq		$16, %%rsp\n"
> 			"movups		%%xmm0, 16(%%rsp)\n"
> 			"movd		%%r12, %%xmm0\n"
> 			CALL_NOSPEC
> 			"movups		16(%%rsp), %%xmm0\n"
> 			"addq		$16, %%rsp\n"
> 			: "=a" (hv_status), ASM_CALL_CONSTRAINT,
> 			"+c" (control), "+r" (rdx), "+r" (r8)
> 			: THUNK_TARGET(hv_hypercall_pg), "r"(r12)
> 			: "cc", "memory", "r9", "r10", "r11");
> 
> 	if (hv_result_success(hv_status)) {
> 		value->low_part = rdx;
> 		value->high_part = r8;
> 	}
> 
> 	local_irq_restore(flags);
> 	return hv_status;
> }
> 
> #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> u8 __init get_vtl(void)
> {
> 	struct hv_u128 reg_value;
> 	u64 ret = hv_vp_get_register_xfast(HV_REGISTER_VSM_VP_STATUS, &reg_value);
> 
> 	if (hv_result_success(ret)) {
> 		ret = reg_value.low_part & HV_VTL_MASK;
> 	} else {
> 		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> 		BUG();
> 	}
> 
> 	return ret;
> }
> #endif
> 
> > 
> > Thanks,
> > Stas
> 
> -- 
> Thank you,
> Roman
> 

