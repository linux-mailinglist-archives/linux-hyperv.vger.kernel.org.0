Return-Path: <linux-hyperv+bounces-6882-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60400B5968E
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 14:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1772116CB29
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53B18BBB9;
	Tue, 16 Sep 2025 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDlAz0Jt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818BBA3D
	for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026932; cv=none; b=Ro4gHKqvLSYmS9PgvLGXcnVM63ocCS/N6XG5iKZlXWSnA7qRfRrKCYSCE3zMbGHylTL7ljTqLFkxWxB5yQIr9ECOmoIlpvRmTcD6P4ko5hN8zCBdqnfpRWUIABV292X1i9yWDI2ySW+/Xg2SSRZPIVx0p515WqY5qhHuBxvuRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026932; c=relaxed/simple;
	bh=CN26iiin0/fnXGYNibY5VmnIAtnkq/wAIosGTDBqUUc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WDgpVVRDv8rvxm4UbrIsGOfIOA+hZDWQYvqVI++viReAwuYYYnfiA38UmRz2sK0JgnCQnKMRusXjJWhlElu1c4o0yA1o7mckOGciH1Yo3xl0TyOtX0cPwysYyCT749BocCo1s0jFjmbTgbMwvpY70uaJHsyXMLMfjBfrhlSyWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDlAz0Jt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758026929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=minFNHAoYMN/vEixFLL6UURg3xxSvsV9Ti4P2EO88Zc=;
	b=IDlAz0JtIwnXAk4UeK7cb9khPlk5ddO/kE55/e2sTwtSny+qMEgLmEUYKTC4O+0887Y3P1
	FlrhGSXXSRJ+Q7uo7Jt93rH6HLcLRcPlYCVJLgD+NeFplwGX1tVFM68FlvVAP/uo43cGy7
	1pZOXY/Mixz71o7zs6uu2j+HxZwQAoI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-geBRgt94OA6xbIzlXYqoJw-1; Tue, 16 Sep 2025 08:48:48 -0400
X-MC-Unique: geBRgt94OA6xbIzlXYqoJw-1
X-Mimecast-MFC-AGG-ID: geBRgt94OA6xbIzlXYqoJw_1758026927
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb8215978aso1401187f8f.1
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 05:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758026927; x=1758631727;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=minFNHAoYMN/vEixFLL6UURg3xxSvsV9Ti4P2EO88Zc=;
        b=CUg7fZR3jkpIWgfSoo8rwQlkUNzuyJR58q8KatOf4YTVvFf2gflQEY/vqDGVICIx8W
         zWmaBcW4t6yiexUu0TWMIKlGrSXC4HyngeWpErI1D5VJSrtOD0cX4HVL79LdoWzk/R89
         tpm4HMs2h5dAzDcOUIk3D9XAA0dchK62I7IxPCE0KZpY5zIil5109Y5dGi/M0hwWgK/n
         zp3TcPtOPruBTqg4CQuwzDoxdeY+3MQV980hMwokfF6tmIlnBSziMEw54VuXl+f40PpH
         QJ3gZNheu/hIUfPsnXkhtjxRw6G7feOCCM46CojIOy+G4wGbRXVmgE3f0CQWDcGAncqb
         zhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX74nMzNDlkUPilytOemHcYOmsiBvTvCz4x7vhCOSdEtE7i30tuOKzbEm7VHoKRLXYSN8zxXBLM5lhVJrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cpwK5NeChezgLp/GZcPwmGW50RlANtiX5d6di1c8VEBf2gEK
	5Iz2Zkw91JzKtA5Ggrz0xU6h3del/KRIgymSVfg2LU6F0javYozsBNmLf+oVZ7Ew8XNrnpmZ3F9
	PTmaETtDRMegdbwVT44mZQ7+j6lHvS4hwDk+VTS711XBZlzwyL41hXLVNoOmLCul8Nw==
X-Gm-Gg: ASbGnctA8lCOwBYZPhgtLOUNqUTwLh55xoPy4lRjRUlEjw2h4YwCNzqy8YH/aGMOVgP
	UKJECvVvH58Q+kKdNa5uG9r1Z7rnqjQpdNJLiEUeub/Sm9C74CWGXv+/8V1OoIcyx0odCqcfk2b
	PLHy3JnDpm4BCNaPwrWA4vRQhrpwQeDea9Qu40RvZHFItLRQXYFsKDgCRr8QH++ibu0Tfg6t1AA
	JxVq+QQ+1URiA2Casjuq7ugFsCpysH5rkXL3a/BfhHDMsvZ15aJre5Kikk2+CYCRlTCXXDUsVt+
	CAS0BzwU/SafRJhrn2fsSupxIRjW1mM8tD4+CNDJI95LmPmZgVZacaywUysnbYT0WuQLBE+NtHv
	qwtDaznF/8u4y7hDTc/hLs7r6MGVEcn8u+7T1tpgJgrI=
X-Received: by 2002:a05:6000:2410:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3e765790821mr16615402f8f.13.1758026927061;
        Tue, 16 Sep 2025 05:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqixrgj2YUVcGECTmPArStF+gH+FXp6Ad6OfXg10q6FiPjMuiRSRwB8jTiBEfKTA8OouCloA==
X-Received: by 2002:a05:6000:2410:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3e765790821mr16615354f8f.13.1758026926565;
        Tue, 16 Sep 2025 05:48:46 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.56.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e9a591a41csm11405746f8f.7.2025.09.16.05.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 05:48:45 -0700 (PDT)
Message-ID: <27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com>
Date: Tue, 16 Sep 2025 14:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
To: Roman Kisel <romank@linux.microsoft.com>,
 Peter Zijlstra <peterz@infradead.org>,
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
 <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 01:04, Roman Kisel wrote:
> On 8/26/2025 5:07 AM, Peter Zijlstra wrote:
>> I do not know what OpenHCL is. Nor is it clear from the code what NMIs
>> can't happen. Anyway, same can be achieved with breakpoints / kprobes.
>> You can get a trap after setting CR2 and scribble it.
>>
>> You simply cannot use CR2 this way.
> 
> The code in question runs with interrupts disabled, and the kernel runs
> without the memory swapping when using that module - the kernel is
> a firmware to host a vTPM for virtual machines. Somewhat similar to SMM.
> That should've been reflected somewhere in the comments and in Kconfig,
> we could do better. All in all, the page fault cannot happen in that
> path thus CR2 won't be trashed.
> 
> Nor this kind of code can be stepped through in a self-hosted
> kernel debugger like kgdb. There are other examples of such code iiuc:

As Sean mentioned, you do have to make sure that this is annotated as 
noinstr (not instrumentable).  And also just use assembly - KVM started 
with a similar asm block, though without the sketchy "register asm", and 
I was initially skeptical but using a dedicated .S file was absolutely 
the right thing to do.

This will reduce mshv_vtl_return to a much nicer

	hvp = hv_vp_assist_page[smp_processor_id()];
	if (mshv_vsm_capabilities.return_action_available) {
		...
	}
	kernel_fpu_begin_mask(0);
	fxrstor(&vtl0->fx_state);
	__mshv_vtl_return(vtl0, hvp);
	fxsave(&vtl0->fx_state);
	kernel_fpu_end();

and your assembly function __mshv_vtl_return() will look like

.section .noinstr.text, "ax"
SYM_FUNC_START(__mshv_vtl_return)
	push %rbp
         mov %rsp, %rbp
	/* push other callee-save registers r12-r15, rbx */
	...

	/* register switch clobbers all registers except rax/rcx */
	mov %_ASM_ARG1, %rax
	mov %_ASM_ARG2, %rcx

	/* grab rbx/rbp/rsi/rdi/r8-r15 */
	mov MSHV_VTL_CPU_CONTEXT_rbx(%rax), %rbx
	mov MSHV_VTL_CPU_CONTEXT_rbp(%rax), %rbp
	...

	/* these are special... */
	mov MSHV_VTL_CPU_CONTEXT_rax(%rax), %rdx
	mov %rdx, HV_VP_ASSIST_PAGE_vtl_ret_x64rax(%rcx)
	mov MSHV_VTL_CPU_CONTEXT_rcx(%rax), %rdx
	mov %rdx, HV_VP_ASSIST_PAGE_vtl_ret_x64rcx(%rcx)
	mov MSHV_VTL_CPU_CONTEXT_cr2(%rax), %rdx
	mov %rdx, %cr2
	mov MSHV_VTL_CPU_CONTEXT_rdx(%rax), %rdx

	/* stash host registers on stack */
	pushq %rax
	pushq %rcx

	xor %ecx, %ecx
	(call here, see below)

	/* stash guest registers on stack, restore saved host copies */
	pushq %rax
	pushq %rcx
	mov 16(%rsp), %rcx
	mov 24(%rsp), %rax

	/* these are special... */
	mov %rdx, MSHV_VTL_CPU_CONTEXT_rdx(%rax)
	mov %cr2, %rdx
	mov %rdx, MSHV_VTL_CPU_CONTEXT_cr2(%rax)
	pop MSHV_VTL_CPU_CONTEXT_rcx(%rax)
	pop MSHV_VTL_CPU_CONTEXT_rax(%rax)
	add $16, %%rsp

	/* save rbx/rbp/rsi/rdi/r8-r15 */
	mov %rbx, MSHV_VTL_CPU_CONTEXT_rbx(%rax)
	mov %rbp, MSHV_VTL_CPU_CONTEXT_rbp(%rax)
	...

	/* pop callee-save registers r12-r15, rbx */
	...
	pop %rbp
	RET
SYM_FUNC_END(__mshv_vtl_return)

(You can use a custom mshv-asm-offsets.c similar to 
arch/x86/kvm/asm-offsets.c, with corresponding Makefile rules).  It's a 
tiny bit longer, but not even that much given all the register and asm 
constraints boilerplate.  And you get more freedom in return.

The indirect call is potentially problematic, but one possibility is to 
use a static call.  I haven't looked too deeply into it, but I *think* 
it's mostly a matter of making mshv "depends on HAVE_STATIC_CALL" and 
making it possible to include include/linux/static_call_types.h from 
assembly, so that you can just write

DEFINE_STATIC_CALL_NULL(hv_vtl_return_hypercall, void (*)(void));
...
static_call_update(hv_vtl_return_hypercall,
		   (u64)((u8 *)hv_hypercall_pg +
			 mshv_vsm_page_offsets.vtl_return_offset));

and in the assembly file:

	call	STATIC_CALL_TRAMP(hv_vtl_return_hypercall)

> We have a much cleaner story on ARM64 due to no legacy and using
> their calling conventions aka AAPCS64 and other standards everywhere
> (not only in Linux Hyper-V code) to the best of my knowledge.

It's fine.  The RAX/RCX pair is weird, but more in the sense that you 
don't even need to do that for two registers (RAX and RSP, or RCX and 
RSP, would be enough).  It makes sense though that they just used the 
first two in the x86 encoding order.

And anyhow, you can't fix it just like 
drivers/gpu/drm/vmwgfx/vmwgfx_msg.c cannot be fixed.  It's just that 
STACK_FRAME_NON_STANDARD is pretty rough instrument, and in your case 
the whole register + asm + STACK_FRAME_NON_STANDARD is a lot more 
complex than just putting together a .S file for the noinstr parts.

>>> Returning to a lower VTL treats the base pointer register as a general
>>> purpose one and this VTL transition function makes sure to preserve the
>>> bp register due to which the objtool trips over on the assembly touching
>>> the bp register. We considered this warning harmless and thus we are
>>> using this macro. Moreover NMIs are not an issue here as they won't be
>>> coming as mentioned other. If there are alternate approaches that I 
>>> should be using, please suggest.
>>
>> Using BP in an ABI like that is ridiculous and broken. We told the same
>> to the TDX folks when they tried, IIRC TDX was fixed.

I agree it's not great, but it's doable, after all VMX also uses RBP as 
an "argument" (in the sense that it's both an input and an output 
register to VMLAUNCH and VMRESUME).

>> Basically the argument is really simple: you run in Linux, you play by
>> the Linux rules. Using BP as argument is simply not possible. If your
>> ABI requires that, your ABI is broken and will not be supported. Rev the
>> ABI and try again. Same for CR2, that is not an available register in
>> any way.

Aside for Peter: please tone down the rhetoric, or just turn it off 
completely.  It helps no one and this hardly makes sense for this kind 
of code (which should not be C, but that's easily fixed isn't it?).

Yes, it would be easier if the register switch was done in the 
hypervisor and not in Linux, with a nice 16*8-byte block passed in RAX 
or something like that, but so is life.

Paolo


