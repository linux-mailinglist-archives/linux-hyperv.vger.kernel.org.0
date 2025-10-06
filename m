Return-Path: <linux-hyperv+bounces-7103-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD918BBE54D
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 16:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985EE3B3E44
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969062D5437;
	Mon,  6 Oct 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FJIyrLP0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2D6ADD;
	Mon,  6 Oct 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760838; cv=none; b=ff/L9VdcS1sn8eYrZVCUTOG/yV4K4sevAKxnD1dUnvbjPWqwa/02m9IILEFClhzSJZHRFStotzTVCI2pVJ1yz83Tyj+txE1iy3ShaAl7RAeXK0C3KqOZaKARM/MD5CBVS9ewTIF/aw7bdxcaCtbwB7bBqGlDip+/2ve0uzcDdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760838; c=relaxed/simple;
	bh=kCtH3vMewNuSBSsH4NokNQDU9pUiJEtjUtOUpV4rizQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNZFe1GAy9D9nkRD4AHdw8xTVfDBdN727GbGKdr21oihe2tFoIGNiGyjahOp9c8vDZ/tY/V22FxFArzGcGnUqUfMQ5RFCxHX0Jy1cOJ8oefS0AGcgEiwAReREKMM3HUhzoM6J+tUnXFcR5k+JuoA5jI2aCP70pts3Pw5hFYmyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FJIyrLP0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.224.63] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 935B3201C966;
	Mon,  6 Oct 2025 07:27:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 935B3201C966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759760835;
	bh=oZvNqVt/UnW4mUa+6djNmV+pqFnh7Du6W3gyJM8T90I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FJIyrLP0tYLiRaYJoaKiJ2nbI5q+GJvF8eCb/uB8hU/FIvqv/78NmJdPsOPC7ooSn
	 lCuPHDkSutVDmFVN8AAkbyDA5koviiJBiycGvVIrXZz9WBJ+ppirQ9yVgEckVeEEeY
	 qaP3Yj75CnRzhIY6YXvEBzlEYfZHuoZjqex0knUY=
Message-ID: <9a816666-9d5b-46a4-b35f-2f18c4587ab5@linux.microsoft.com>
Date: Mon, 6 Oct 2025 19:57:09 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Roman Kisel <romank@linux.microsoft.com>,
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
 <56521d85-1da5-4d25-b100-7dbe62e34d1d@linux.microsoft.com>
 <20250918064713.GW3419281@noisy.programming.kicks-ass.net>
 <9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com>
 <20251006111030.GU3245006@noisy.programming.kicks-ass.net>
 <CABgObfZFgHY_ybfSnyzEF1dFr5c1s=_r+tAnHa6Q7rzFUUdt3g@mail.gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <CABgObfZFgHY_ybfSnyzEF1dFr5c1s=_r+tAnHa6Q7rzFUUdt3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/6/2025 4:49 PM, Paolo Bonzini wrote:
> On Mon, Oct 6, 2025 at 1:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Oct 06, 2025 at 04:20:03PM +0530, Naman Jain wrote:
>>
>>> I am facing issues in this approach, after moving the assembly code to a
>>> separate file, using static calls, and making it noinstr.
>>>
>>> We need to make a call to STATIC_CALL_TRAMP_STR(hv_hypercall_pg + offset) in
>>> the assembly code. This offset is populated at run time in the driver, so I
>>> have to pass this offset to the assembly function via function parameters or
>>> a shared variable. This leaves noinstr section and results in below warning:
>>>
>>> [1]: vmlinux.o: warning: objtool: __mshv_vtl_return_call+0x4f: call to
>>> mshv_vtl_call_addr() leaves .noinstr.text section
>>>
>>>
>>> To fix this, one of the ways was to avoid making indirect calls. So I used
>>> EXPORT_STATIC_CALL to export the static call *trampoline and key* for the
>>> static call we created in C driver. Then I figured, we could simply call
>>> __SCT__<static_callname> in assembly code and it should work fine. But then
>>> it leads to this error in objtool.
>>
>> Easiest solution is to create a second static_call and have
>> hv_set_hypercall_pg() set that to +offset.
> 
> Yes, my idea was to add +offset directly in the static_call_update, as
> you sketched below. Sorry if that wasn't too clear. I didn't think of
> using a static call also for the base of the page, since that's not
> what the assembly code needs.
> 
> And I think we agree that you absolutely don't want indirect calls, as
> that makes register usage much simpler. This way static calls end up
> killing multiple birds with a stone.
> 

Actually I was implementing it in the same way by introducing a new 
static call using hypercall_pg+offset. The problem was using it in asm 
file. When I tried introducing a wrapper static call earlier, I did not 
use ASM_CALL_CONSTRAINT, so objtool was asking me to save/restore 
registers again. Since this was not possible, I thought it may not work.

With something similar to how its done in 
arch/x86/include/asm/preempt.h, I was able to make it work, and remove 
dependency on IBT config.

Thanks a lot Peter and Paolo for helping on this.

Regards,
Naman

>> Also, what's actually in that hypercall page that is so magical and
>> can't just be an ALTERNATIVE() ?
> 
> Do you mean an alternative for VMCALL vs. VMMCALL? If so, that's just
> not guaranteed to work: "An attempt to invoke a hypercall by any other
> means (for example, copying the code from the hypercall code page to
> an alternate location and executing it from there) might result in an
> undefined operation (#UD) exception" (or it might not).
> 
> Paolo
> 


