Return-Path: <linux-hyperv+bounces-6607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3072B37525
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 01:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B1877A6462
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Aug 2025 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0B51F5825;
	Tue, 26 Aug 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JJ0FqdLL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331C36D;
	Tue, 26 Aug 2025 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249459; cv=none; b=f588+kziYTuAncOUANqCIOCpbBu7ZzIvW3z97U++FhHok8Cf8RkoXW7cgeaXOyTDXJId0NMI4f57+Wf4XWuLEvui0qJ3uqcZx4KYAdYuf3ZvPDOSSZmZmnG68gty2FEoYEom+TCJNMloWVosCZvgsWqmtMBuHWQod3QyfXEGAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249459; c=relaxed/simple;
	bh=f4DFVYcAxdLhkeEGQ/Cw6H7Yt15mnu0+l2YL2kh2N5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKRdiaaDcXi1fHxydkgDTWlviFS8J4ULpyvZTYmBW6aBlypTrKcZZdvmxFmnCqGKN30TiD0VgaUCk+VQpmDGu0Ny0Yjm2HbpwnBcRrdkOLIn5GRW49Nd6Ko6hVXp9q3aAjluX9I6mPCvjfhfB+PZpgpS4ZVxXEbUNf856LmDB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JJ0FqdLL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEB562019D43;
	Tue, 26 Aug 2025 16:04:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEB562019D43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756249452;
	bh=8V4Mv65CO8o3WeyNJbdkS5oLwcOoRxGW9k+qEYHM5ug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJ0FqdLLZluk24TS2lHjn/uAl8gcDgBFfANRVBzqfRYP76f37SJeWNunkMDWRcM0I
	 KhFdAGGSm3EACSO7TVs43jkSomeGM3KbIpbmRHfzqHSeR20jARDHNi0kGFndPqCPY3
	 VdXjqfMJmEKBTrWftorscEr2r/f0V8a7nDk2bF6A=
Message-ID: <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com>
Date: Tue, 26 Aug 2025 16:04:11 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
To: Peter Zijlstra <peterz@infradead.org>,
 Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhklinux@outlook.com
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
 <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>
 <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/26/2025 5:07 AM, Peter Zijlstra wrote:
> On Tue, Aug 26, 2025 at 05:00:31PM +0530, Naman Jain wrote:

Peter,

Naman is OOF; genuinely hoping it's not presumptuous of me to reply
to the thread - seems time sensitive.

[...]

> 
> I do not know what OpenHCL is. Nor is it clear from the code what NMIs
> can't happen. Anyway, same can be achieved with breakpoints / kprobes.
> You can get a trap after setting CR2 and scribble it.
> 
> You simply cannot use CR2 this way.
> 

The code in question runs with interrupts disabled, and the kernel runs
without the memory swapping when using that module - the kernel is
a firmware to host a vTPM for virtual machines. Somewhat similar to SMM.
That should've been reflected somewhere in the comments and in Kconfig,
we could do better. All in all, the page fault cannot happen in that
path thus CR2 won't be trashed.

Nor this kind of code can be stepped through in a self-hosted
kernel debugger like kgdb. There are other examples of such code iiuc:
the asm glue code in the interrupt exception entries where the trap
frames are handled, likely return from the kernel to the user land.
The thread context-swap code hardly can be stepped through with
convenience if at all in the self-hosted debugger, too.

>>> And an rax:rcx return, I though the canonical pair was AX,DX !?!?
>>
>> Here, the code uses rax and rcx not as a means to return one 128 bit
>> value. The code uses them in that way as an ABI.
> 
> Still daft. Creating an ABI that goes against pre-existing conventions
> is weird.
> 

It is weird. It really sucks to have to conform to ABIs introduced a
decade+ ago when Hyper-V just appeared in the kernel and just for x86.
As weird as the pair ax:cx looks for anyone who takes joy and pride in
writing x86 asm code, it still works for the customers, we have to care
about the backward compat.

 From the discussion, it doesn't appear we can ask for much as you're
right: the asm chunk looks abominable due to being essentially a
context-swap with an entity foreign to the Linux/System-V ABI. Same
must be true for the calls into the UEFI runtime services to a certain
extent due to different calling conventions.

We have a much cleaner story on ARM64 due to no legacy and using
their calling conventions aka AAPCS64 and other standards everywhere
(not only in Linux Hyper-V code) to the best of my knowledge.

If nothing of that saves the patches from the death row, maybe it'd be 
possible to give the patches the experimental status or get some time
extension to learn what can be improved? I am asking to save the
time spent by folks reviewing the parts that you don't see as being
prohibitively bad.

>>> Also, that STACK_FRAME_NON_STANDARD() annotation is broken, this must
>>> not be used for anything that can end up in vmlinux.o -- that is, the
>>> moment you built-in this driver (=y) this comes unstuck.
>>>
>>> The reason you're getting warnings is because you're violating the
>>> normal calling convention and scribbling BP, we yelled at the TDX guys
>>> for doing this, now you're getting yelled at. WTF !?!
>>>
>>> Please explain how just shutting up objtool makes the unwind work when
>>> the NMI hits your BP scribble?
>>
>> Returning to a lower VTL treats the base pointer register as a general
>> purpose one and this VTL transition function makes sure to preserve the
>> bp register due to which the objtool trips over on the assembly touching
>> the bp register. We considered this warning harmless and thus we are
>> using this macro. Moreover NMIs are not an issue here as they won't be
>> coming as mentioned other. If there are alternate approaches that I should
>> be using, please suggest.
> 
> Using BP in an ABI like that is ridiculous and broken. We told the same
> to the TDX folks when they tried, IIRC TDX was fixed.
> 
> It is simply not acceptable to break the regular calling convention with
> a new ABI.
> 
> Again, I can put a breakpoint or kprobe in the region where BP is
> scribbled.
> 
> Basically the argument is really simple: you run in Linux, you play by
> the Linux rules. Using BP as argument is simply not possible. If your
> ABI requires that, your ABI is broken and will not be supported. Rev the
> ABI and try again. Same for CR2, that is not an available register in
> any way.
> 
>> I now understand that as part of your effort to enable IBT config on
>> x64, you changed the indirect calls to direct calls in Hyper-V.
> 
> Yeah, I was cleaning up indirect calls, and this really didn't need to
> be one.
> 
>> As of today, there is no requirement to enable IBT in OpenHCL kernel
>> as this runs as a paravisor in VTL2 and it does not effect the guest
>> VMs running
>> in VTL0.
> 
> I do not know what OpenHCL or VTLn means and as such pretty much the
> whole of your statement makes no sense.
> 
> Anyway, AFAICT the whole idea of a hypercall page is to 'abtract' out
> the VMCALL vs VMMCALL nonsense Intel/AMD inflicted on us. Surely you
> don't actually need that. HyperV already knows about all the gazillion
> of ways to do hypercalls.
> 
>> I can disable CONFIG_X86_KERNEL_IBT when CONFIG_MSHV_VTL is enabled in
>> Kconfig in next version.
> 
> Or you can just straight up say: "We at microsoft don't care about
> security." :-/
> 
> Doing that will ensure no distro will build your module, most build bots
> will not build your module, nobody cares about your module.
> 
> And no, the problems with BP and CR2 are not related to IBT, that is
> separate and no less broken. They violate the basic rules of x86_64.

-- 
Thank you,
Roman


