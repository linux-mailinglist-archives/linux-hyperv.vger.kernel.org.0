Return-Path: <linux-hyperv+bounces-8993-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKpMH8x3n2nScAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8993-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 23:29:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E419E474
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 23:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A3BE30479E9
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3D33066F;
	Wed, 25 Feb 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E//yCjqu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11694330642;
	Wed, 25 Feb 2026 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058482; cv=none; b=msc1Y/g1qRHYNhnEBhnJHxLsylkrvXe16wZ8yTrE4v0MWVmNJkm+cHA6mnG3+p0Ve5rDix1YwO6+5kmOqdcgJLRWdQyDE8+0F9MFvjlxclWgzy8AfEDraGbP5U9KjsvpHRrJldn7Y6vTdBJBGcrtDaOlin9cStnKcW8x+z+mNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058482; c=relaxed/simple;
	bh=uZMGg6Sbk52Mepkr+C/FTt7KiuFYuuw9qSDXF9S7sv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MemM4JV2oAc4Uri6oN/Hd2oHwoOto0FnP53k8g2Q+a1b4MYPEWx6mtoD43Hsl7Kv56Rw+6hZhztqvBlXTjmtjEa4HWJBkrohI5YbXTY6o9QO+JhXknOGjcIGiePTNMVmKhFNshx8CgPfvZ/D8VhgBvOuRsbXMh8ZsD6urF+KjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E//yCjqu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 142F820B6F02;
	Wed, 25 Feb 2026 14:28:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 142F820B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772058480;
	bh=jKs9O/kn+8kDs6GYjOO7oHC0D3maA5sh2FYyEo9tbuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E//yCjquSSKRYaxs70pr05IUqIzcVhavx9HeWgQesoC9FXfwr8rlvDNHlYlFqWj1N
	 VkyMyCX8x/6TPOWRz5UbuQN8NWDOV2dBYGveWZxKz49G8zB/kqBrkMKxdUG42ot1bC
	 T+O50wnZD4klTq8wvuhODQneKEq1IfYJlhFHR7Gg=
Message-ID: <f8199494-0c42-5eb0-f99e-cc6f6e304d40@linux.microsoft.com>
Date: Wed, 25 Feb 2026 14:27:59 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 dave.hansen@linux.intel.com, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <38cdec03-889e-43dd-9dad-e621aba9dc8d@app.fastmail.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <38cdec03-889e-43dd-9dad-e621aba9dc8d@app.fastmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8993-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: D61E419E474
X-Rspamd-Action: no action

On 2/21/26 08:43, Ard Biesheuvel wrote:
> Just spotted this code in v7.0-rc
> 
> On Wed, 10 Sep 2025, at 02:10, Mukesh Rathor wrote:
> ...
> 
>> +static asmlinkage void __noreturn hv_crash_c_entry(void)
> 
> 'asmlinkage' means that the function may be called from another compilation unit written in assembler, but it doesn't actually evaluate to anything in most cases. Combining it with 'static' makes no sense whatsoever.

'static' means scope is limited to the file. Common in cases where function
pointers are used, like here in this file way below.

Like the comment says:
     "This is the C entry point from the asm glue code after...."

IOW, called from assembly function (asm == assembly).

> 
>> +{
>> +	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
>> +
>> +	/* first thing, restore kernel gdt */
>> +	native_load_gdt(&ctxt->gdtr);
>> +
>> +	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
>> +	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
>> +
> 
> This code is truly very broken. You cannot enter a C function without a stack, and assign RSP half way down the function. Especially after allocating local variables and/or calling other functions - it may happen to work in most cases, but it is very fragile. (Other architectures have the concept of 'naked' functions for this purpose but x86 does not)

Local variable refers to static bss struct. IOW,

       asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));

same as:
       asm volatile("movq %0, %%rsp" : : "m"(&hv_crash_ctxt.rsp));


> IOW, this whole function should be written in asm.
>> +	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
>> +	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
>> +	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
>> +	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
>> +
>> +	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
>> +	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
>> +
>> +	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
>> +	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
>> +	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
>> +
>> +	native_load_idt(&ctxt->idtr);
>> +	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
>> +	native_wrmsrq(MSR_EFER, ctxt->efer);
>> +
>> +	/* restore the original kernel CS now via far return */
>> +	asm volatile("movzwq %0, %%rax\n\t"
>> +		     "pushq %%rax\n\t"
>> +		     "pushq $1f\n\t"
>> +		     "lretq\n\t"
>> +		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
>> +
>> +	/* We are in asmlinkage without stack frame,
> 
> You just switched to __KERNEL_CS via the stack.

compiler doesn't know that.

>> hence make a C function
>> +	 * call which will buy stack frame to restore the tss or clear PT
>> entry.
>> +	 */
> 
> Where does one buy a stack frame?

A stack market :).  Callee will create stack frame now that rsp is
setup.

>> +	hv_crash_restore_tss();
>> +	hv_crash_clear_kernpt();
>> +
>> +	/* we are now fully in devirtualized normal kernel mode */
>> +	__crash_kexec(NULL);
>> +
>> +	for (;;)
>> +		cpu_relax();
>> +}
>> +/* Tell gcc we are using lretq long jump in the above function
>> intentionally */
>> +STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
>> +


