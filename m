Return-Path: <linux-hyperv+bounces-7100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43133BBDCF2
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAEDF34BD63
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33372580F3;
	Mon,  6 Oct 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Byp0InzZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E12571C7;
	Mon,  6 Oct 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748165; cv=none; b=BGfsB7jnGqd4Fzjmw51yMA2Y3kq6Zcox6e02n8KuIN6wXBMuE+RDvRKojX6xX8AHbcghFPAfQ3+Cjp2BFc3MHc6QnPNDL7pLERRE4arVZs90RVZG2oxnmk8/ekKHe5y1A/G+ohi+RpA4eymf7n/RaGwJkTTe8pRF6bXMBDYW4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748165; c=relaxed/simple;
	bh=uZj6nnc67ejErRPVqVuTTmwaRBkE4sAg+qXujzJAX8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IygJQmM1k4eQzGikcz9/VxXJqZ/M5uKDhxNTLD95DbUtKooVz4LhOFkpxayiT86DM+l0sEzI0ggSB7WEx20KGnX2/cgB6cyxPRASjUIF1h6rPF5uNVqlPmVrlHFoUyy+hyAeGtZWwiTX/fL5U8pOcpmJ3qzJAt8IEetFbZYcwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Byp0InzZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.224.63] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8D8E211AF2D;
	Mon,  6 Oct 2025 03:50:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8D8E211AF2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759747810;
	bh=LR17D6Rmwf9VuGXnrvTUGl6HskpgJleD5utlQiBrxoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Byp0InzZ3peboWdyE/N5Z7G/hj6C95sM09ty+bDhhVYm70p8kdSmsh6/DnKpQwQqh
	 M8Y33kpK/7uiu2cvpr4MKSC7t5Lk3UQV/FXvnUXekuxY/lV3S+a1ZSVPoF+FkMzaoo
	 GaIy5heInBqiVypje0iOEJ061ITY64NC4WnIcbMg=
Message-ID: <9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com>
Date: Mon, 6 Oct 2025 16:20:03 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Kisel
 <romank@linux.microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250918064713.GW3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/2025 12:17 PM, Peter Zijlstra wrote:
> On Thu, Sep 18, 2025 at 11:33:18AM +0530, Naman Jain wrote:
> 
>> Thank you so much Sean and Paolo for your valuable inputs. I will try
>> out these things. Summarizing the suggestions here:
>> * Use noinstr (no instrumentation)
>> * Have separate .S file
>> * Don't use "register asm".
>> * Use static calls for solving IBT problems
>> * RAX:RCX is probably ok to be used, considering ABI. Whether we would still
>> need to use STACK_FRAME_NON_STANDARD, I am not sure, but I will see based on
>> how it goes.
>>
>> I hope this addresses the concerns Peter raised. If there's anything I might
>> have missed, I'm happy to make further adjustments if needed.
> 
> It would be a definite improvement. I'm just *really* sad people still
> create interfaces like this, even though we've known for years how bad
> they are.
> 
> At some point we've really have to push back and say enough is enough.

Hi Peter, Paolo, Sean,
I am facing issues in this approach, after moving the assembly code to a 
separate file, using static calls, and making it noinstr.

We need to make a call to STATIC_CALL_TRAMP_STR(hv_hypercall_pg + 
offset) in the assembly code. This offset is populated at run time in 
the driver, so I have to pass this offset to the assembly function via 
function parameters or a shared variable. This leaves noinstr section 
and results in below warning:

[1]: vmlinux.o: warning: objtool: __mshv_vtl_return_call+0x4f: call to 
mshv_vtl_call_addr() leaves .noinstr.text section


To fix this, one of the ways was to avoid making indirect calls. So I 
used EXPORT_STATIC_CALL to export the static call *trampoline and key* 
for the static call we created in C driver. Then I figured, we could 
simply call __SCT__<static_callname> in assembly code and it should work 
fine. But then it leads to this error in objtool.

[2]: arch/x86/hyperv/mshv_vtl_asm.o: error: objtool: static_call: can't 
find static_call_key symbol: __SCK__mshv_vtl_return_hypercall

This gets hidden/fixed with X86_KERNEL_IBT config enablement.

If I comment out the objtool check that leads to this warning, I can see 
the same symbols for __SCT__, __SCK__ in final vmlinux with and without 
IBT, and it even works fine on the VM. So it seems to be a matter of 
timing when objtool is checking for this symbol.
My theory is IBT enablement is helping here as it adds ENDBR 
instructions to various static/indirect/direct calls, which may be 
adding the missing symbol to the section before objtool checks for it.

Other ways I tried to fix the initial problem of noinstr was to make the 
exported shared pointer variable as noinstr, but it does not work since 
noinstr can only be applied to functions and not data types. KVM code 
had similar noisntr calls from assembly, but they have actual functions 
which are marked noinstr, not just some address stored in a variable.

I also tried of introducing wrapper functions marked as noinstr, to 
initialize static calls but it does not help.

Adding compilation dependencies in Makefile also does not help.
$(obj)/mshv_vtl_asm.o: $(obj)/hv_vtl.o

This left me with no option, but to enable IBT and add the dependency.

But yes, this is controversial and if there are alternate ways to handle 
this or make it work, I would be more than happy to hear your 
suggestions on it and implement them.

Regards,
Naman

