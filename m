Return-Path: <linux-hyperv+bounces-9058-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NMYmD8tiommk2gQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9058-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 04:36:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2B51C024A
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 04:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99C7B3063629
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 03:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771E2BEC2B;
	Sat, 28 Feb 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pAT1gw9h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F752C3244;
	Sat, 28 Feb 2026 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772249800; cv=none; b=UJ1Zeyb3iuQqA7ZKgQyoI9kAyL57JvI73AFI/c2jF0L6dodLBxy24PxDfYTW5xDbDBvmVU2Pl4wTANgGxstkmCFP3L08CPG6WuWjY5uVNVVCbdyiAeD3T7C3lL4FiJKTcNl1QVAp9A+vCmxAxI2wCkghEXWryKBH0795DvMcrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772249800; c=relaxed/simple;
	bh=wwptzavZJWx1DXwOGQ5FJHjszEqEkv6DvgAauYOCJ2Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aaGDPQREc/vIlaedaKfxkVET1Kocc20WhPe9Dd7uOjjNbbjtycbHdW48lp3jGXfbFajSkbDbIAt2KryerKzAFqm8IldkAJln0nprdBNzsOXpj1u+Dxi3OcNTVi5tjxy79onD/OOfhSoa6px0cpbEeUW9Rj788FfXB99+u5Yt4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pAT1gw9h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 488A220B6F02;
	Fri, 27 Feb 2026 19:36:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 488A220B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772249797;
	bh=6YjsEJ5H7xy4c47iT4MHkZheIcBgy/N0DbxwzSF8/3Q=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pAT1gw9huZ/u1B/vuSvoWimzQ2NByKfEZ0cHGP0if+y8PNHoK+rWpdkdvzPURixZ+
	 NY9vFWdXtNcZe4tGdRLJEVq9Sbu2MEslIxkfadyaoS+AIZDZDnMs5VsJqaSaCTOLD1
	 PFM5dEijXcIMDJLeToFO50DjWyTbee8fRQCx8sWY=
Message-ID: <0b508e16-6461-24d8-8f34-55e9add5d29c@linux.microsoft.com>
Date: Fri, 27 Feb 2026 19:36:36 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C
 function
Content-Language: en-US
From: Mukesh R <mrathor@linux.microsoft.com>
To: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Wei Liu <wei.liu@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 linux-hyperv@vger.kernel.org
References: <20260227224030.299993-2-ardb@kernel.org>
 <3cd719bb-334a-d05a-d44a-f68982a76a9d@linux.microsoft.com>
In-Reply-To: <3cd719bb-334a-d05a-d44a-f68982a76a9d@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,citrix.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9058-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hv_crash_ctxt.gs:url,hv_crash_ctxt.es:url,hv_crash_ctxt.ss:url,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 5C2B51C024A
X-Rspamd-Action: no action

On 2/27/26 15:03, Mukesh R wrote:
> On 2/27/26 14:40, Ard Biesheuvel wrote:
>> hv_crash_c_entry() is a C function that is entered without a stack,
>> and this is only allowed for functions that have the __naked attribute,
>> which informs the compiler that it must not emit the usual prologue and
>> epilogue or emit any other kind of instrumentation that relies on a
>> stack frame.
>>
>> So split up the function, and set the __naked attribute on the initial
>> part that sets up the stack, GDT, IDT and other pieces that are needed
>> for ordinary C execution. Given that function calls are not permitted
>> either, use the existing long return coded in an asm() block to call the
>> second part of the function, which is an ordinary function that is
>> permitted to call other functions as usual.
> 
> Thank you for the patch. I'll start a build on the side and test it
> out and let you know.

Well, never that simple. I am able to generate cores, both before and
after the patch, but the crash command hangs on the vmcore (with correct
vmlinux). But, since the kexec happened, I think it is fair to say that
the patch works. With that:

Reviewed-by: Mukesh R <mrathor@linux.microsoft.com>

However, I did notice a pre-exising cut-n-paste oopsie:

   asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr4)); <== cr2, not cr4


So, if you happen to do another churn, feel free to fix it. Otherwise,
no worries, I'll submit another patch.

Thanks for all your help.
-Mukesh


> Thanks,
> -Mukesh
> 
> 
> 
>> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Cc: Wei Liu <wei.liu@kernel.org>
>> Cc: Uros Bizjak <ubizjak@gmail.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: linux-hyperv@vger.kernel.org
>> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> v2: apply some asm tweaks suggested by Uros and Andrew
>>
>>   arch/x86/hyperv/hv_crash.c | 79 ++++++++++----------
>>   1 file changed, 41 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
>> index 92da1b4f2e73..1c0965eb346e 100644
>> --- a/arch/x86/hyperv/hv_crash.c
>> +++ b/arch/x86/hyperv/hv_crash.c
>> @@ -107,14 +107,12 @@ static void __noreturn hv_panic_timeout_reboot(void)
>>           cpu_relax();
>>   }
>> -/* This cannot be inlined as it needs stack */
>> -static noinline __noclone void hv_crash_restore_tss(void)
>> +static void hv_crash_restore_tss(void)
>>   {
>>       load_TR_desc();
>>   }
>> -/* This cannot be inlined as it needs stack */
>> -static noinline void hv_crash_clear_kernpt(void)
>> +static void hv_crash_clear_kernpt(void)
>>   {
>>       pgd_t *pgd;
>>       p4d_t *p4d;
>> @@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
>>       native_p4d_clear(p4d);
>>   }
>> +
>> +static void __noreturn hv_crash_handle(void)
>> +{
>> +    hv_crash_restore_tss();
>> +    hv_crash_clear_kernpt();
>> +
>> +    /* we are now fully in devirtualized normal kernel mode */
>> +    __crash_kexec(NULL);
>> +
>> +    hv_panic_timeout_reboot();
>> +}
>> +
>> +/*
>> + * __naked functions do not permit function calls, not even to __always_inline
>> + * functions that only contain asm() blocks themselves. So use a macro instead.
>> + */
>> +#define hv_wrmsr(msr, val) \
>> +    asm("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) : "memory")
>> +
>>   /*
>>    * This is the C entry point from the asm glue code after the disable hypercall.
>>    * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
>> @@ -133,49 +150,35 @@ static noinline void hv_crash_clear_kernpt(void)
>>    * available. We restore kernel GDT, and rest of the context, and continue
>>    * to kexec.
>>    */
>> -static asmlinkage void __noreturn hv_crash_c_entry(void)
>> +static void __naked hv_crash_c_entry(void)
>>   {
>> -    struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
>> -
>>       /* first thing, restore kernel gdt */
>> -    native_load_gdt(&ctxt->gdtr);
>> +    asm volatile("lgdt %0" : : "m" (hv_crash_ctxt.gdtr));
>> -    asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
>> -    asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
>> +    asm volatile("movw %0, %%ss" : : "m"(hv_crash_ctxt.ss));
>> +    asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
>> -    asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
>> -    asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
>> -    asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
>> -    asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
>> +    asm volatile("movw %0, %%ds" : : "m"(hv_crash_ctxt.ds));
>> +    asm volatile("movw %0, %%es" : : "m"(hv_crash_ctxt.es));
>> +    asm volatile("movw %0, %%fs" : : "m"(hv_crash_ctxt.fs));
>> +    asm volatile("movw %0, %%gs" : : "m"(hv_crash_ctxt.gs));
>> -    native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
>> -    asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
>> +    hv_wrmsr(MSR_IA32_CR_PAT, hv_crash_ctxt.pat);
>> +    asm volatile("movq %0, %%cr0" : : "r"(hv_crash_ctxt.cr0));
>> -    asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
>> -    asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
>> -    asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
>> +    asm volatile("movq %0, %%cr8" : : "r"(hv_crash_ctxt.cr8));
>> +    asm volatile("movq %0, %%cr4" : : "r"(hv_crash_ctxt.cr4));
>> +    asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr4));
>> -    native_load_idt(&ctxt->idtr);
>> -    native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
>> -    native_wrmsrq(MSR_EFER, ctxt->efer);
>> +    asm volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr));
>> +    hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase);
>> +    hv_wrmsr(MSR_EFER, hv_crash_ctxt.efer);
>>       /* restore the original kernel CS now via far return */
>> -    asm volatile("movzwq %0, %%rax\n\t"
>> -             "pushq %%rax\n\t"
>> -             "pushq $1f\n\t"
>> -             "lretq\n\t"
>> -             "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
>> -
>> -    /* We are in asmlinkage without stack frame, hence make C function
>> -     * calls which will buy stack frames.
>> -     */
>> -    hv_crash_restore_tss();
>> -    hv_crash_clear_kernpt();
>> -
>> -    /* we are now fully in devirtualized normal kernel mode */
>> -    __crash_kexec(NULL);
>> -
>> -    hv_panic_timeout_reboot();
>> +    asm volatile("pushq %q0\n\t"
>> +             "pushq %q1\n\t"
>> +             "lretq"
>> +             :: "r"(hv_crash_ctxt.cs), "r"(hv_crash_handle));
>>   }
>>   /* Tell gcc we are using lretq long jump in the above function intentionally */
>>   STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
> 


