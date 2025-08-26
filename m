Return-Path: <linux-hyperv+bounces-6604-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4ADB35CC6
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Aug 2025 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876191BA501D
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Aug 2025 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2653C34165E;
	Tue, 26 Aug 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RvhGtXQT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B709334364;
	Tue, 26 Aug 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207839; cv=none; b=lC9Bt4caAT09cFjF8+nBcYimwFd31oZzcWSqXlQSksI3WJIVR/BHHKr6szv0p+OxM0l3WG0q/ynly/t/8lfcVCnZHyPQishSRyG3M9OROeT0vVLuC7fQlZ9/cQUnqCaqp62sym+vZG6mO7ksBDNjH1IZ8nY/qLWF3zeHlMyRYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207839; c=relaxed/simple;
	bh=r6ox4Jn6kW4nCH6fHXghDhTroOjZS0wrw+s0Okal+0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX7S1Cr1/SvI5erN0QFD34W4ickb+Gf4MsI5iu04ATOZr6jFqcNwUpW0+/gSMgt4qATwxndFSin0ZaVOWRvgMuwXQmDbArBmswRTF6sM1E4yV+cPNi5qObTZqBktezMr7Zs4e32rfCMDrjbSyf4hhgHx5zPLULjVecTS+/m4ZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RvhGtXQT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.0.121] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2A7B2119CAA;
	Tue, 26 Aug 2025 04:30:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2A7B2119CAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756207836;
	bh=YlDeJj5CldQNxVzjbLlPM30KV6d0P3MGUab/Q9BjJBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RvhGtXQTmJDD63d2e2bK7wJcH/O6pqaYBHX5DsGIZygy1bgBTpXWap3UUli+qD/fx
	 JF4JwzF4CXDxl4fOkZ7rn4Y4gcwa73saIYN5hs71vBwDJqApeCx51SsQL6q9k9abwd
	 AWiBgoj819SjGEcQwYSGFYw/aWRtgz7zALgBRIpc=
Message-ID: <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>
Date: Tue, 26 Aug 2025 17:00:31 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
To: Peter Zijlstra <peterz@infradead.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhklinux@outlook.com
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/2025 3:12 PM, Peter Zijlstra wrote:
> On Mon, Aug 25, 2025 at 11:22:08AM +0530, Naman Jain wrote:
>> With commit 0e20f1f4c2cb ("x86/hyperv: Clean up hv_do_hypercall()"),
>> config checks were added to conditionally restrict export
>> of hv_hypercall_pg symbol at the same time when a usage of that symbol
>> was added in mshv_vtl_main.c driver. This results in missing symbol
>> warning when mshv_vtl_main is compiled. Change the logic to
>> export it unconditionally.
>>
>> Fixes: 96a1d2495c2f ("Drivers: hv: Introduce mshv_vtl driver")
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> 
> Oh gawd, that commit is terrible and adds yet another hypercall
> interface.
> 
> I would argue the proper fix is moving the whole of mshv_vtl_return()
> into the kernel proper and doing it like hv_std_hypercall() on x86_64.

Thanks for the review comments.

This is doable, I can move the hypercall part of it to 
arch/x86/hyperv/hv_init.c if I understand correctly.

> 
> Additionally, how is that function not utterly broken? What happens if
> an interrupt or NMI comes in after native_write_cr2() and before the
> actual hypercall does VMEXIT and trips a #PF?

mshv_vtl driver is used for OpenHCL paravisor. The interrupts are
disabled, and NMIs aren't sent to the paravisor by the virt stack.

> 
> And an rax:rcx return, I though the canonical pair was AX,DX !?!?

Here, the code uses rax and rcx not as a means to return one 128 bit
value. The code uses them in that way as an ABI.

> 
> Also, that STACK_FRAME_NON_STANDARD() annotation is broken, this must
> not be used for anything that can end up in vmlinux.o -- that is, the
> moment you built-in this driver (=y) this comes unstuck.
> 
> The reason you're getting warnings is because you're violating the
> normal calling convention and scribbling BP, we yelled at the TDX guys
> for doing this, now you're getting yelled at. WTF !?!
> 
> Please explain how just shutting up objtool makes the unwind work when
> the NMI hits your BP scribble?
>

Returning to a lower VTL treats the base pointer register as a general
purpose one and this VTL transition function makes sure to preserve the
bp register due to which the objtool trips over on the assembly touching
the bp register. We considered this warning harmless and thus we are
using this macro. Moreover NMIs are not an issue here as they won't be 
coming as mentioned other. If there are alternate approaches that I 
should be using, please suggest.

I now understand that as part of your effort to enable IBT config on
x64, you changed the indirect calls to direct calls in Hyper-V. As of 
today, there is no requirement to enable IBT in OpenHCL kernel as this
runs as a paravisor in VTL2 and it does not effect the guest VMs running
in VTL0.
I can disable CONFIG_X86_KERNEL_IBT when CONFIG_MSHV_VTL is enabled in
Kconfig in next version.


> All in all, I would suggest fixing this by reverting that patch and
> trying again after fixing the calling convention of that hypercall.
> 
> 
> Yours grumpy..

Regards,
Naman

