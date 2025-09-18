Return-Path: <linux-hyperv+bounces-6933-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EC5B83136
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 08:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2623A9188
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 06:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297526A0C6;
	Thu, 18 Sep 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UHuJ7pa/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75526AE4;
	Thu, 18 Sep 2025 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175412; cv=none; b=M4RQxk1TS+MHDb1yAIw7lysleTE1wjDPDkfuRDsyfqcNW/ExE3rjZIOGaCI3JyvknvFkbFXl2y8h1lTAsuBecaJRVPhjZNrsXdpUYm8SC0g+b79/iWeWHqnXq0+W9BBJRMPGZk+VAtwaXypncFiwfo/KWoBv2tOUkUSDMPiUlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175412; c=relaxed/simple;
	bh=wGJEeS2GeCshoqVmO0dCDV1+CiiU7MEEF71+EG28rHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V22VOYBgkKqflwuw7cP0f/BkmDJbjI8fbPvVQSNBBLUkbFBKMxdlfIvP3CjwJgxli8RHcMNVTcjcw3Rim1RrRUGZ9mSpQ5QRaOiYIkGoOhf2yJ2PDXY4XEhk8GkDi7vov5Hg8Mq14yU9xVeTxAJhkpZ2aRQsxWCWvX2QyCaUJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UHuJ7pa/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.64.75] (unknown [167.220.238.11])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6FDA420143F4;
	Wed, 17 Sep 2025 23:03:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FDA420143F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758175404;
	bh=9us+CFCoIEM0GQ3nTg0abfcW+LRdO8lwFtdsjngMssk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UHuJ7pa/+/iRQnSV6XUrVILtQIIRqWcr0GezXdd7jQBIXIv7hHg4Fv53K6DUruJF2
	 7QAGF1vvRtyUJoSdQXZQqJqTXaOVWwkz3OmRE3U8ZrhSx79dwpg13H+4iVGA/JPXLY
	 3RR6h2j9MX0uLYU4X6tIdopPTft0Eyl4QuWuwUFQ=
Message-ID: <56521d85-1da5-4d25-b100-7dbe62e34d1d@linux.microsoft.com>
Date: Thu, 18 Sep 2025 11:33:18 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
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
 <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com>
 <27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com>
 <aMl5ulY1K7cKcMfo@google.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aMl5ulY1K7cKcMfo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/2025 8:22 PM, Sean Christopherson wrote:
> On Tue, Sep 16, 2025, Paolo Bonzini wrote:
>> On 8/27/25 01:04, Roman Kisel wrote:
>>> On 8/26/2025 5:07 AM, Peter Zijlstra wrote:
>>>> I do not know what OpenHCL is. Nor is it clear from the code what NMIs
>>>> can't happen. Anyway, same can be achieved with breakpoints / kprobes.
>>>> You can get a trap after setting CR2 and scribble it.
>>>>
>>>> You simply cannot use CR2 this way.
>>>
>>> The code in question runs with interrupts disabled, and the kernel runs
>>> without the memory swapping when using that module - the kernel is
>>> a firmware to host a vTPM for virtual machines. Somewhat similar to SMM.
>>> That should've been reflected somewhere in the comments and in Kconfig,
>>> we could do better. All in all, the page fault cannot happen in that
>>> path thus CR2 won't be trashed.
>>>
>>> Nor this kind of code can be stepped through in a self-hosted
>>> kernel debugger like kgdb. There are other examples of such code iiuc:
>>
>> As Sean mentioned, you do have to make sure that this is annotated as
>> noinstr (not instrumentable).  And also just use assembly - KVM started with
>> a similar asm block, though without the sketchy "register asm",
> 
> Ooh, yeah, don't use "register asm".  I missed that when I peeked at the code.
> Using "register asm" will most definitely cause problems, because the compiler
> doesn't track usage in C code, i.e. will happily use the GPR and clobber your
> asm value in the process.  That inevitably leads to very confusing and somewhat
> transient errors.  E.g. if someone inserts a printk for debugging, the call to
> printk can clobber the very state it's trying to print.
> 
>> and I was initially skeptical but using a dedicated .S file was absolutely
>> the right thing to do.
> 
> +1000 to putting the assembly in a .S file.  I too was a bit skeptical about
> moving the entire sequence into proper assembly; thankfully, some non-KVM folks
> talked us into it :-)

Thank you so much Sean and Paolo for your valuable inputs. I will try
out these things. Summarizing the suggestions here:
* Use noinstr (no instrumentation)
* Have separate .S file
* Don't use "register asm".
* Use static calls for solving IBT problems
* RAX:RCX is probably ok to be used, considering ABI. Whether we would 
still need to use STACK_FRAME_NON_STANDARD, I am not sure, but I will 
see based on how it goes.

I hope this addresses the concerns Peter raised. If there's anything I 
might have missed, I'm happy to make further adjustments if needed.

Regards,
Naman


