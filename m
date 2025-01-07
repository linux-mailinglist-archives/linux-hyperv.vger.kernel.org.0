Return-Path: <linux-hyperv+bounces-3600-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7839AA04D36
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 00:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71687166FFF
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF01E4106;
	Tue,  7 Jan 2025 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HXRD7w6a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A61A83E1;
	Tue,  7 Jan 2025 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291478; cv=none; b=r6wYYHqX3eKzEb/xHuXOC2Ycj+RJLudzhAT9nfE4ZG48XRBtgFS2M5S/nOj7aFvHERq9l+XyOSM0KSkUjc22atdG/yv/ApxHWtQTbOxcATMtX6tqc8ERxn08j+l3taDAbVa3BN6/eEbKB1pO2eOUjQqEaqME7/7XuEjsqKjBLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291478; c=relaxed/simple;
	bh=8OnrM4kRw4Y/ZLArSUQlMXG3Qba2BxeBhoRZ6VOMj3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3heO+OPUAiyI8p/8J3lX5N7ZurURTjB3kUlIgwIldSAyXnbyqGmK3Z2gQ7IOXGGRw0YTPM2R9Qc5br4EhZafCiCxghxafN64ih6UE4Xp0FnmpyQUo30KKHKohZvs6gsgMSKtXTf/StwUZXTDUUQGHTSgY8kcdEJ9sCsuB5owmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HXRD7w6a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B7C4212D510;
	Tue,  7 Jan 2025 15:11:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B7C4212D510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736291476;
	bh=jMBUhb4VXBSYbi9jWqWYCUzGAWjBw+OSrYYEqegkCwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HXRD7w6aePBRmAprK/JGcws+a8lWyp3TfSrrXauFFoR4ByIsbs1XWTmbGVJpixaeW
	 eJ0i4JjJ63MGK8LofI1e90nuLRn9QiK+rWPiAjSUb0D0Quv/FweBZtJZ1MvcH8RFKS
	 Krr3DhP0bLgR5T7E+4bUpZTlMxChqx3d13IdJKsg=
Message-ID: <17dfb71a-119c-4906-bc22-4f65fb28676b@linux.microsoft.com>
Date: Tue, 7 Jan 2025 15:11:15 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, nunodasneves@linux.microsoft.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
 <20250106171114.GA18270@skinsburskii.>
 <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>
 <20250106193248.GB18346@skinsburskii.>
 <3c90bc0f-be28-4f10-8057-be5e780c5a24@linux.microsoft.com>
 <20250107191848.GA24369@skinsburskii.>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250107191848.GA24369@skinsburskii.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/7/2025 11:18 AM, Stanislav Kinsburskii wrote:
> On Mon, Jan 06, 2025 at 01:07:25PM -0800, Roman Kisel wrote:
> 

[...]

> My point is that the proposed fix looks more like an Underhill-tailored
> bandage and doesn't take the needs of other stake holders into
> consideration.
The patch takes as much into consideration as present in the hyperv-next
tree. Working on the open-source project seems to be harder otherwise.
A bandage, or not, that's a matter of opinion. There's a been a break,
here's the bandage.

> 
> What is the urgency in merging of this particular change?

The get_vtl function is broken thus blocking any further work on
upstreaming VTL mode patches, ARM64 and more. That's not an urgent
urgency where customers are in pain, more like the urgency of needing
to take the trash out, and until that happens, continuing inhaling the
fumes.

The urgency of unblocking is to continue work on proposing VTL mode
patches not to carry lots of out-of-tree code in the fork.

There might be a future where the Hyper-V code offers an API surface
covering needs of consumers like dom0 and VTLs whereby they maybe can
be built as an out-of-tree modules so the opinions wouldn't clash as
much.

Avoiding using the output hypercall page leads to something like[1]
and it looks quite complicated although that's the bare bones, lots
of notes.

[1]

/*
  * Fast extended hypercall with 20 bytes of input and 16 bytes of
  * output for getting a VP register.
  *
  * NOTES:
  *  1. The function is __init only atm, so the XMM context isn't
  *     used by the user mode.
  *  2. X86_64 only.
  *  3. Fast extended hypercalls may use XMM0..XMM6, and XMM is
  *     architerctural on X86_64 yet the support should be enabled
  *     in the CR's. Here, need RDX, R8 and XMM0 for input and RDX,
  *     R8 for output
  *  4. No provisions for TDX and SEV-SNP for the sake of simplicity
  *     (the hypervisor cannot see the guest registers in the
  *     confidential VM), would need to fallback.
  *  5. The robust implementation would need to check if fast extended
  *     hypercalls are available by checking the synthehtic CPUID leaves.
  *     A separate leaf indicates fast output support.
  *     It _almost_ certainly has to be, unless somehow disabled, hard
  *     to see why that would be needed.
  */
struct hv_u128 {
	u64 low_part;
	u64 high_part;
} __packed;

static __init u64 hv_vp_get_register_xfast(u32 reg_name,
		struct hv_u128 *value)
{
	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS |
					HV_HYPERCALL_FAST_BIT;
	unsigned long flags;
	u64 hv_status;

	union {
		struct hv_get_vp_registers_input input;
		struct {
			u64 lo;
			u64 hi;
		} __packed as_u128;
	} hv_input;
	register u64 rdx asm("rdx");
	register u64 r8 asm("r8");
	register u64 r12 asm("r12");

	local_irq_save(flags);

	hv_input.as_u128.lo = hv_input.as_u128.hi = 0;
	hv_input.input.header.partitionid = HV_PARTITION_ID_SELF;
	hv_input.input.header.vpindex = HV_VP_INDEX_SELF;
	hv_input.input.header.inputvtl = 0;

	rdx = hv_input.as_u128.lo;
	r8 = hv_input.as_u128.hi;
	r12 = reg_name;

	__asm__ __volatile__(
			"subq		$16, %%rsp\n"
			"movups		%%xmm0, 16(%%rsp)\n"
			"movd		%%r12, %%xmm0\n"
			CALL_NOSPEC
			"movups		16(%%rsp), %%xmm0\n"
			"addq		$16, %%rsp\n"
			: "=a" (hv_status), ASM_CALL_CONSTRAINT,
			"+c" (control), "+r" (rdx), "+r" (r8)
			: THUNK_TARGET(hv_hypercall_pg), "r"(r12)
			: "cc", "memory", "r9", "r10", "r11");

	if (hv_result_success(hv_status)) {
		value->low_part = rdx;
		value->high_part = r8;
	}

	local_irq_restore(flags);
	return hv_status;
}

#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
u8 __init get_vtl(void)
{
	struct hv_u128 reg_value;
	u64 ret = hv_vp_get_register_xfast(HV_REGISTER_VSM_VP_STATUS, &reg_value);

	if (hv_result_success(ret)) {
		ret = reg_value.low_part & HV_VTL_MASK;
	} else {
		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
		BUG();
	}

	return ret;
}
#endif

> 
> Thanks,
> Stas

-- 
Thank you,
Roman


