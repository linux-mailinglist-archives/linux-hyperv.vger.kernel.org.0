Return-Path: <linux-hyperv+bounces-2319-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C38FBCA2
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A74EB20CF1
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4814B07A;
	Tue,  4 Jun 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpVFz5mm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BA1494C2
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Jun 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529696; cv=none; b=ktYQ6mvfwIYfEipKYvQZEvrcj7dCUw7Ymif6dMLwVAO871xVm+ZaHuAf2yb+KGeHyXDFKUK/SpKx5AlgtuG1G6ft8oTWAmYrYbc9Nx/ialJTN3hJc+T0HFGwTZFrwZR327BFSCwcxB6q+edPPeEuh9QiJlTAp/aP8/IHuzAm1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529696; c=relaxed/simple;
	bh=qN2MBRKzxzwXAL03Xzsa1ojxsfhLcPfAHIaUXpEXeZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=frGfvzdvKK7zo/qiin5kPMLJNre2Yj9LqMFaV9C9vIe9VRCq2KLKwLSGCb665dR43ChG9+DBoMzhSi9OapsPzGFYTunTYfV0WJeHYltIVinR15Z0PWJqdqTeEWF82S57eImniDnKHD0YOFQUxtm9y2LK1UPecc9pBu3anSO3Wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpVFz5mm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c1e797cafcso142204a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Jun 2024 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717529694; x=1718134494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ct1xfjgBlDiO/rOwDK4wzZ15YJPUMxnDGM/Y6I9JkHI=;
        b=vpVFz5mmg1SJX+EbQQGyzWT+foIKJE+oDLFN6zCACcHIdkvr51G38udM/AvfrEnAuy
         quYnizEuU9AYt+GoIvRlzWaZp+1kSxO95fYYt05JTHToxD/q4qByxudLp5xe4s9KdLb/
         e7t6uQlRmrCUfkPU/Ta602d9Gxq9eZKRX3zEyigaNWL06Ce9xE3uUBH0vJ+mJFX3GJ25
         R8MUEZxn85kjTOAlTfRD0SbZLBhcpRhh2b2A539hzuPkezsKA/GwYmaeQwgaVtc/yC5G
         HS6neKmB7q+Yso4mctT7DLP0bYf1zVVrZnNAg4XY+VcdqKkPn8WMe/Qf2lyh9fxC+/n/
         Bl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529694; x=1718134494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ct1xfjgBlDiO/rOwDK4wzZ15YJPUMxnDGM/Y6I9JkHI=;
        b=qc8jZRineR6MR3Ds3bTWVKLXuNfo7Xz+KUDsaAfOy2mS7v8SVrMNgAws+i/7xuO4eh
         BiorDHIXIjG6PEp+hLWueWg7uGU91ioySVRS+ChxmCA/sMTR26xq+J17GDtjyy4vtEgK
         nlrNhfHiihA3Up426cd0Klq4zjJpCn6Mz1E0FxxzFLQL1IpIoLTiq99KhbYjIpYMmm/g
         Yy8WRpOF/PCver2T8P79X/ABvu8EpjUZse5bCBYe5uh1u0JKh9DZGSgIj6TPV3LxzNca
         vo2eOqm5AEpmiFikYClguw3LNsq/TkNCOQxkY62jJwfbhN2YYh2hzJ0D1kOdOs4NpCn/
         fPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVW8HT3goRCF1pXfOK6wMyoOA/IaMM+VdDfCHidPwox7aNvB8uBAnxbw82wwZ6ZrlN7BjPv/cG7GTJOFlU45TX6b/81xI8PLRHZ/Cy
X-Gm-Message-State: AOJu0YyGScbddJnoQl+q3IvPi9UVEPwjeQErqjuZvdpPpCOtzMgxGWFo
	tUG/G+7Goat0lLWyz7eguoFQwhBoSFe+ycC+6CFTe+TRSKQjkqnnT10Or87mWPuOUPcx9PJxZ18
	l6A==
X-Google-Smtp-Source: AGHT+IGQdHaNTRmKVtUlJ0+GgSID3GaK0JE3JGKduXiODJNepMkjBlKKe38/pjK+JgMlkVHdCO8o9CVqSXM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2309:b0:2b4:32df:9b7b with SMTP id
 98e67ed59e1d1-2c25300652fmr44706a91.1.1717529693749; Tue, 04 Jun 2024
 12:34:53 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:34:52 -0700
In-Reply-To: <crv2ak76xudopm7xnbg6zp2ntw4t2gni3vlowm7otl7xyu72oz@rt2ncbmodsth>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240602115444.1863364-1-kirill.shutemov@linux.intel.com>
 <8992921e-7343-4279-9953-0c042d8baf90@intel.com> <crv2ak76xudopm7xnbg6zp2ntw4t2gni3vlowm7otl7xyu72oz@rt2ncbmodsth>
Message-ID: <Zl9sXGj890yerBPJ@google.com>
Subject: Re: [PATCH] x86/tdx: Enhance code generation for TDCALL and SEAMCALL wrappers
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 04, 2024, Kirill A. Shutemov wrote:
> On Mon, Jun 03, 2024 at 06:37:45AM -0700, Dave Hansen wrote:
> > On 6/2/24 04:54, Kirill A. Shutemov wrote:
> > > Sean observed that the compiler is generating inefficient code to clear
> > > the tdx_module_args struct for TDCALL and SEAMCALL wrappers. The
> > > compiler is generating numerous instructions at each call site to clear
> > > the unused fields of the structure.
> > > 
> > > To address this issue, avoid using C99-initializer and instead
> > > explicitly use string instructions to clear the struct.
> > > 
> > > With Clang, this change results in a savings of approximately 3K with my
> > > configuration:
> > > 
> > > add/remove: 0/0 grow/shrink: 0/21 up/down: 0/-3187 (-3187)
> > > 
> > > With GCC, the savings are less significant at around 300 bytes:
> > > 
> > > add/remove: 0/0 grow/shrink: 3/22 up/down: 17/-313 (-296)
> > > 
> > > GCC tends to generate string instructions more frequently to clear the
> > > struct.
> > 
> > <shrug>
> > 
> > I don't think moving away from perfectly normal C struct initialization
> > is worth it for 300 bytes of text in couple of slow paths.
> > 
> > If someone out there is using clang, is confident that it is doing the
> > right thing and not just being silly, _and_ is horribly bothered by its
> > code generation, then please speak up.
> 
> Conceptually, I like my previous attempt more. But it is much more
> intrusive and I am not sure it is worth the risk.
> 
> This patch feels like hack around compiler.
> 
> Sean, do you have any comments?

Yes :-)

1. Y'all *really* need to actually look at the generated code, because this is
   amusingly broken.

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 0519dd7cbb92..575cc54670ef 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -91,7 +91,7 @@ struct tdx_module_args {
 
 static __always_inline void tdx_arg_init(struct tdx_module_args *args)
 {
-       asm ("rep stosb"
+       asm volatile ("rep stosb"
             : "+D" (args)
             : "c" (sizeof(*args)), "a" (0)
             : "memory");

2. Look at *all* the code generation, because the code generation for TDX-as-a-guest
   as a whole is bad/confusing.  E.g. switching on ve->exit_reason in ve_instr_len()
   after doing the same in virt_exception_kernel() _could_ be optimized away, but
   in part because tdx_module_args generates so much code, gcc-13 at least tends
   to not inline the individual handlers, which in turn means ve_instr_len() doesn't
   get inlined because the compiler doesn't know that e.g. handle_cpuid() will
   only ever call ve_instr_len() with ve->exit_reason == EXIT_REASON_CPUID.

3. As Paolo pointed out[*], passing arguments vs. explicitly filling operands
   have different tradeoffs.  Explicitly filling operands is *visually* pleasing,
   but it's also prone to typos, and as evidenced by a data leak in mmio_read(),
   being able to easily audit the code doesn't mean squat unless someone actually
   does the audit (usually in response to a bug).

   static bool mmio_read(int size, unsigned long addr, unsigned long *val)
   {
	struct tdx_module_args args = {
		.r10 = TDX_HYPERCALL_STANDARD,
		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
		.r12 = size,
		.r13 = EPT_READ,
		.r14 = addr,
		.r15 = *val,    <==== data leak
	};

	if (__tdx_hypercall(&args))
		return false;

	*val = args.r11;
	return true;
   }

   [*] https://lore.kernel.org/all/611a387b-ba7e-46d7-b6bf-84dc6c037d33@redhat.com

3. Pick _one_ approach for the majority of TDVMCALLs.  The existing code is a mix
   of passing arguments (e.g. mmio_write()) and explicit operands (e.g. mmio_read()).
   There will inevitably be special snowflakes, e.g. for some asinine reason, CPUID
   skips r11 as an output.  But AFAICT, most TDVMCALLs conform to a standard
   pattern.

4. Using a trampoline probably isn't worth the marginal reduction in *written*
   code.  The generated code is almost as weird as the tdx_module_args code.
   E.g. each callsite generates a pile of MOV instructions to registers that
   *don't* match the GHCI, and so I doubt the end result would be any easier to
   debug for unsuspecting users.

If we're willing to suffer a few gnarly macros, I think we get a satisfactory mix
of standardized arguments and explicit operands, and generate vastly better code.

The macros are beyond ugly and are also error prone to some extent, but having to
add new macros should be quite rare, and much of the boilerplate could be stripped
away with even more macros.

And while the macros are ugly, the advantage of having to specify the number of
input and output operands reduces the probability of a data leak, e.g. the mmio_read()
bug wouldn't escape compilation because TDVMCALL_4_1() would be unhappy, and
TDVMCALL_5_1() doesn't need to exist.

Dump of assembler code for function tdx_handle_virt_exception:
   0xffffffff81003220 <+0>:	call   0xffffffff810577d0 <__fentry__>
   0xffffffff81003225 <+5>:	push   %r13
   0xffffffff81003227 <+7>:	push   %r12
   0xffffffff81003229 <+9>:	push   %rbp
   0xffffffff8100322a <+10>:	push   %rbx
   0xffffffff8100322b <+11>:	mov    %rdi,%rbx
   0xffffffff8100322e <+14>:	sub    $0x8,%rsp
   0xffffffff81003232 <+18>:	testb  $0x3,0x88(%rdi)
   0xffffffff81003239 <+25>:	mov    (%rsi),%rax
   0xffffffff8100323c <+28>:	je     0xffffffff81003269 <tdx_handle_virt_exception+73>
   0xffffffff8100323e <+30>:	cmp    $0xa,%rax
   0xffffffff81003242 <+34>:	jne    0xffffffff8100327a <tdx_handle_virt_exception+90>
   0xffffffff81003244 <+36>:	mov    %rbx,%rdi
   0xffffffff81003247 <+39>:	call   0xffffffff81002820 <handle_cpuid>
   0xffffffff8100324c <+44>:	test   %eax,%eax
   0xffffffff8100324e <+46>:	js     0xffffffff81003289 <tdx_handle_virt_exception+105>
   0xffffffff81003250 <+48>:	cltq
   0xffffffff81003252 <+50>:	add    %rax,0x80(%rbx)
   0xffffffff81003259 <+57>:	mov    $0x1,%eax
   0xffffffff8100325e <+62>:	add    $0x8,%rsp
   0xffffffff81003262 <+66>:	pop    %rbx
   0xffffffff81003263 <+67>:	pop    %rbp
   0xffffffff81003264 <+68>:	pop    %r12
   0xffffffff81003266 <+70>:	pop    %r13
   0xffffffff81003268 <+72>:	ret
   0xffffffff81003269 <+73>:	lea    -0xa(%rax),%rdx
   0xffffffff8100326d <+77>:	cmp    $0x26,%rdx
   0xffffffff81003271 <+81>:	ja     0xffffffff8100327a <tdx_handle_virt_exception+90>
   0xffffffff81003273 <+83>:	jmp    *-0x7e3ffd88(,%rdx,8)
   0xffffffff8100327a <+90>:	mov    %rax,%rsi
   0xffffffff8100327d <+93>:	mov    $0xffffffff81e6b0b6,%rdi
   0xffffffff81003284 <+100>:	call   0xffffffff810eb170 <_printk>
   0xffffffff81003289 <+105>:	xor    %eax,%eax
   0xffffffff8100328b <+107>:	jmp    0xffffffff8100325e <tdx_handle_virt_exception+62>
   0xffffffff8100328d <+109>:	mov    0x18(%rsi),%rbp
   0xffffffff81003291 <+113>:	mov    %rsi,(%rsp)
   0xffffffff81003295 <+117>:	mov    %rbp,%rdi
   0xffffffff81003298 <+120>:	call   0xffffffff81002700 <cc_mkenc>
   0xffffffff8100329d <+125>:	mov    (%rsp),%rsi
   0xffffffff810032a1 <+129>:	cmp    %rax,%rbp
   0xffffffff810032a4 <+132>:	je     0xffffffff81003376 <tdx_handle_virt_exception+342>
   0xffffffff810032aa <+138>:	mov    %rbx,%rdi
   0xffffffff810032ad <+141>:	call   0xffffffff81002e20 <handle_mmio>
   0xffffffff810032b2 <+146>:	jmp    0xffffffff8100324c <tdx_handle_virt_exception+44>
   0xffffffff810032b4 <+148>:	mov    0x60(%rdi),%rdx
   0xffffffff810032b8 <+152>:	xor    %eax,%eax
   0xffffffff810032ba <+154>:	mov    $0x3c00,%ecx
   0xffffffff810032bf <+159>:	shl    $0x20,%rdx
   0xffffffff810032c3 <+163>:	or     0x50(%rdi),%rdx
   0xffffffff810032c7 <+167>:	mov    $0x20,%r11
   0xffffffff810032ce <+174>:	mov    0x58(%rdi),%r12
   0xffffffff810032d2 <+178>:	mov    %rdx,%r13
   0xffffffff810032d5 <+181>:	xor    %r10d,%r10d
   0xffffffff810032d8 <+184>:	tdcall
   0xffffffff810032dc <+188>:	mov    %r10,%rcx
   0xffffffff810032df <+191>:	test   %rax,%rax
   0xffffffff810032e2 <+194>:	jne    0xffffffff81003371 <tdx_handle_virt_exception+337>
   0xffffffff810032e8 <+200>:	test   %rcx,%rcx
   0xffffffff810032eb <+203>:	jne    0xffffffff81003289 <tdx_handle_virt_exception+105>
   0xffffffff810032ed <+205>:	mov    0x20(%rsi),%eax
   0xffffffff810032f0 <+208>:	jmp    0xffffffff8100324c <tdx_handle_virt_exception+44>
   0xffffffff810032f5 <+213>:	xor    %eax,%eax
   0xffffffff810032f7 <+215>:	mov    $0x1c00,%ecx
   0xffffffff810032fc <+220>:	mov    $0x1f,%r11
   0xffffffff81003303 <+227>:	mov    0x58(%rdi),%r12
   0xffffffff81003307 <+231>:	xor    %r10d,%r10d
   0xffffffff8100330a <+234>:	tdcall
   0xffffffff8100330e <+238>:	mov    %r10,%rcx
   0xffffffff81003311 <+241>:	mov    %r11,%rdx
   0xffffffff81003314 <+244>:	test   %rax,%rax
   0xffffffff81003317 <+247>:	jne    0xffffffff81003371 <tdx_handle_virt_exception+337>
   0xffffffff81003319 <+249>:	test   %rcx,%rcx
   0xffffffff8100331c <+252>:	jne    0xffffffff81003289 <tdx_handle_virt_exception+105>
   0xffffffff81003322 <+258>:	movq   $0x0,0x50(%rdi)
   0xffffffff8100332a <+266>:	movq   $0x0,0x60(%rdi)
   0xffffffff81003332 <+274>:	cmpq   $0x1f,(%rsi)
   0xffffffff81003336 <+278>:	je     0xffffffff810032ed <tdx_handle_virt_exception+205>
   0xffffffff81003338 <+280>:	ud2
   0xffffffff8100333a <+282>:	jmp    0xffffffff810032ed <tdx_handle_virt_exception+205>
   0xffffffff8100333c <+284>:	mov    %rsi,(%rsp)
   0xffffffff81003340 <+288>:	pushf
   0xffffffff81003341 <+289>:	pop    %rdi
   0xffffffff81003342 <+290>:	shr    $0x9,%rdi
   0xffffffff81003346 <+294>:	xor    $0x1,%rdi
   0xffffffff8100334a <+298>:	and    $0x1,%edi
   0xffffffff8100334d <+301>:	call   0xffffffff81949c00 <__halt>
   0xffffffff81003352 <+306>:	test   %rax,%rax
   0xffffffff81003355 <+309>:	jne    0xffffffff81003289 <tdx_handle_virt_exception+105>
   0xffffffff8100335b <+315>:	mov    (%rsp),%rsi
   0xffffffff8100335f <+319>:	cmpq   $0xc,(%rsi)
   0xffffffff81003363 <+323>:	je     0xffffffff810032ed <tdx_handle_virt_exception+205>
   0xffffffff81003365 <+325>:	jmp    0xffffffff81003338 <tdx_handle_virt_exception+280>
   0xffffffff81003367 <+327>:	call   0xffffffff81002d20 <handle_io>
   0xffffffff8100336c <+332>:	jmp    0xffffffff8100324c <tdx_handle_virt_exception+44>
   0xffffffff81003371 <+337>:	call   0xffffffff81944440 <__tdx_hypercall_failed>
   0xffffffff81003376 <+342>:	mov    $0xffffffff81eab098,%rdi
   0xffffffff8100337d <+349>:	call   0xffffffff81080cf0 <panic>
End of assembler dump.

---
 arch/x86/boot/compressed/tdx.c    |  31 ++---
 arch/x86/coco/tdx/tdx.c           | 136 +++++++++-----------
 arch/x86/hyperv/ivm.c             |  26 +---
 arch/x86/include/asm/shared/tdx.h | 204 +++++++++++++++++++++++++++---
 4 files changed, 262 insertions(+), 135 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 8451d6a1030c..5a94cab412ed 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -18,32 +18,25 @@ void __tdx_hypercall_failed(void)
 
 static inline unsigned int tdx_io_in(int size, u16 port)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = 0,
-		.r14 = port,
-	};
+	unsigned int val;
 
-	if (__tdx_hypercall(&args))
+	if (TDVMCALL_4_1(r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+			     r12 = size,
+			     r13 = 0,
+			     r14 = port,
+			     TDX_ON_SUCCESS(val = out_r11)))
 		return UINT_MAX;
 
-	return args.r11;
+	return val;
 }
 
 static inline void tdx_io_out(int size, u16 port, u32 value)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = 1,
-		.r14 = port,
-		.r15 = value,
-	};
-
-	__tdx_hypercall(&args);
+	TDVMCALL_5_0(r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+		     r12 = size,
+		     r13 = 1,
+		     r14 = port,
+		     r15 = value);
 }
 
 static inline u8 tdx_inb(u16 port)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c1cb90369915..b9f76445419c 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -124,7 +124,10 @@ EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 {
 	/* Since buf is a shared memory, set the shared (decrypted) bits */
-	return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
+	return TDVMCALL_3_0(r11 = TDVMCALL_GET_QUOTE,
+			    r12 = cc_mkdec(virt_to_phys(buf)),
+			    r13 = size);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
@@ -226,9 +229,11 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
  * information if #VE occurred due to instruction execution, but not for EPT
  * violations.
  */
-static int ve_instr_len(struct ve_info *ve)
+static int ve_instr_len(u32 exit_reason, struct ve_info *ve)
 {
-	switch (ve->exit_reason) {
+	WARN_ON_ONCE(ve->exit_reason != exit_reason);
+
+	switch (exit_reason) {
 	case EXIT_REASON_HLT:
 	case EXIT_REASON_MSR_READ:
 	case EXIT_REASON_MSR_WRITE:
@@ -252,12 +257,6 @@ static int ve_instr_len(struct ve_info *ve)
 
 static u64 __cpuidle __halt(const bool irq_disabled)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_HLT),
-		.r12 = irq_disabled,
-	};
-
 	/*
 	 * Emulate HLT operation via hypercall. More info about ABI
 	 * can be found in TDX Guest-Host-Communication Interface
@@ -270,7 +269,8 @@ static u64 __cpuidle __halt(const bool irq_disabled)
 	 * can keep the vCPU in virtual HLT, even if an IRQ is
 	 * pending, without hanging/breaking the guest.
 	 */
-	return __tdx_hypercall(&args);
+	return TDVMCALL_2_0(r11 = hcall_func(EXIT_REASON_HLT),
+			    r12 = irq_disabled);
 }
 
 static int handle_halt(struct ve_info *ve)
@@ -280,7 +280,7 @@ static int handle_halt(struct ve_info *ve)
 	if (__halt(irq_disabled))
 		return -EIO;
 
-	return ve_instr_len(ve);
+	return ve_instr_len(EXIT_REASON_HLT, ve);
 }
 
 void __cpuidle tdx_safe_halt(void)
@@ -296,43 +296,37 @@ void __cpuidle tdx_safe_halt(void)
 
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_MSR_READ),
-		.r12 = regs->cx,
-	};
+	u64 val = 0;
 
 	/*
 	 * Emulate the MSR read via hypercall. More info about ABI
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
-	if (__tdx_hypercall(&args))
+	if (TDVMCALL_2_1(r11 = hcall_func(EXIT_REASON_MSR_READ),
+			 r12 = regs->cx,
+			 TDX_ON_SUCCESS(val = out_r11)))
 		return -EIO;
 
-	regs->ax = lower_32_bits(args.r11);
-	regs->dx = upper_32_bits(args.r11);
-	return ve_instr_len(ve);
+	regs->ax = lower_32_bits(val);
+	regs->dx = upper_32_bits(val);
+
+	return ve_instr_len(EXIT_REASON_MSR_READ, ve);
 }
 
 static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
-		.r12 = regs->cx,
-		.r13 = (u64)regs->dx << 32 | regs->ax,
-	};
-
 	/*
 	 * Emulate the MSR write via hypercall. More info about ABI
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	if (__tdx_hypercall(&args))
+	if (TDVMCALL_3_0(r11 = hcall_func(EXIT_REASON_MSR_WRITE),
+			 r12 = regs->cx,
+			 r13 = (u64)regs->dx << 32 | regs->ax))
 		return -EIO;
 
-	return ve_instr_len(ve);
+	return ve_instr_len(EXIT_REASON_MSR_WRITE, ve);
 }
 
 static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
@@ -353,7 +347,7 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	 */
 	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
 		regs->ax = regs->bx = regs->cx = regs->dx = 0;
-		return ve_instr_len(ve);
+		return ve_instr_len(EXIT_REASON_CPUID, ve);
 	}
 
 	/*
@@ -374,31 +368,26 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	regs->cx = args.r14;
 	regs->dx = args.r15;
 
-	return ve_instr_len(ve);
+	return ve_instr_len(EXIT_REASON_CPUID, ve);
 }
 
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
-		.r12 = size,
-		.r13 = EPT_READ,
-		.r14 = addr,
-		.r15 = *val,
-	};
-
-	if (__tdx_hypercall(&args))
-		return false;
-
-	*val = args.r11;
-	return true;
+	return !TDVMCALL_4_1(r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
+			     r12 = size,
+			     r13 = EPT_READ,
+			     r14 = addr,
+			     TDX_ON_SUCCESS(*val = out_r11));
+	return false;
 }
 
 static bool mmio_write(int size, unsigned long addr, unsigned long val)
 {
-	return !_tdx_hypercall(hcall_func(EXIT_REASON_EPT_VIOLATION), size,
-			       EPT_WRITE, addr, val);
+	return !TDVMCALL_5_0(r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
+			     r12 = size,
+			     r13 = EPT_WRITE,
+			     r14 = addr,
+			     r15 = val);
 }
 
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
@@ -508,42 +497,37 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = PORT_READ,
-		.r14 = port,
-	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
-	bool success;
-
-	/*
-	 * Emulate the I/O read via hypercall. More info about ABI can be found
-	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
-	 * "TDG.VP.VMCALL<Instruction.IO>".
-	 */
-	success = !__tdx_hypercall(&args);
+	const u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
 
 	/* Update part of the register affected by the emulated instruction */
 	regs->ax &= ~mask;
-	if (success)
-		regs->ax |= args.r11 & mask;
 
-	return success;
+	/*
+	 * Emulate the I/O read via hypercall. More info about ABI can be found
+	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
+	 * "TDG.VP.VMCALL<Instruction.IO>".
+	 */
+	return !TDVMCALL_4_1(r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+			     r12 = size,
+			     r13 = PORT_READ,
+			     r14 = port,
+			     TDX_ON_SUCCESS(regs->ax |= out_r11 & mask));
 }
 
 static bool handle_out(struct pt_regs *regs, int size, int port)
 {
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	const u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
 
 	/*
 	 * Emulate the I/O write via hypercall. More info about ABI can be found
 	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
-	return !_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), size,
-			       PORT_WRITE, port, regs->ax & mask);
+	return !TDVMCALL_5_0(r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+			     r12 = size,
+			     r13 = PORT_WRITE,
+			     r14 = port,
+			     r15 = regs->ax & mask);
 }
 
 /*
@@ -575,7 +559,7 @@ static int handle_io(struct pt_regs *regs, struct ve_info *ve)
 	if (!ret)
 		return -EIO;
 
-	return ve_instr_len(ve);
+	return ve_instr_len(EXIT_REASON_IO_INSTRUCTION, ve);
 }
 
 /*
@@ -745,14 +729,11 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	}
 
 	while (retry_count < max_retries_per_page) {
-		struct tdx_module_args args = {
-			.r10 = TDX_HYPERCALL_STANDARD,
-			.r11 = TDVMCALL_MAP_GPA,
-			.r12 = start,
-			.r13 = end - start };
-
 		u64 map_fail_paddr;
-		u64 ret = __tdx_hypercall(&args);
+		u64 ret = TDVMCALL_3_1(r11 = TDVMCALL_MAP_GPA,
+				       r12 = start,
+				       r13 = end - start,
+				       map_fail_paddr = out_r11);
 
 		if (ret != TDVMCALL_STATUS_RETRY)
 			return !ret;
@@ -761,7 +742,6 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 		 * region starting at the GPA specified in R11. R11 comes
 		 * from the untrusted VMM. Sanity check it.
 		 */
-		map_fail_paddr = args.r11;
 		if (map_fail_paddr < start || map_fail_paddr >= end)
 			return false;
 
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 768d73de0d09..4d51b8fde6b1 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -385,32 +385,20 @@ static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 #ifdef CONFIG_INTEL_TDX_GUEST
 static void hv_tdx_msr_write(u64 msr, u64 val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_MSR_WRITE,
-		.r12 = msr,
-		.r13 = val,
-	};
-
-	u64 ret = __tdx_hypercall(&args);
+	u64 ret = TDVMCALL_3_0(r11 = EXIT_REASON_MSR_WRITE,
+			       r12 = msr,
+			       r13 = val);
 
 	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
 }
 
 static void hv_tdx_msr_read(u64 msr, u64 *val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_MSR_READ,
-		.r12 = msr,
-	};
+	u64 ret = TDVMCALL_2_1(r11 = hcall_func(EXIT_REASON_MSR_READ),
+			       r12 = msr,
+			       *val = out_r11);
 
-	u64 ret = __tdx_hypercall(&args);
-
-	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
-		*val = 0;
-	else
-		*val = args.r11;
+	WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret);
 }
 
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fdfd41511b02..c1354054f144 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -65,6 +65,191 @@
 
 #include <linux/compiler_attributes.h>
 
+#define TDVMCALL_BUG_ON(ret)							\
+do {										\
+	if (unlikely(ret))							\
+		__tdx_hypercall_failed();					\
+} while (0)
+
+#define TDX_ON_SUCCESS(x) if (__ret) (x)
+
+#define TDVMCALL_2_0(__in_r11, __in_r12)					\
+({										\
+	u64 vmcall_ret = TDG_VP_VMCALL;						\
+	u64 __in_r11, __in_r12;							\
+	u64 __ret;								\
+										\
+	asm volatile (								\
+		"movq	%[r11_in], %%r11\n\t"					\
+		"movq	%[r12_in], %%r12\n\t"					\
+		"xor    %%r10d, %%r10d\n\t"					\
+		".byte 0x66,0x0f,0x01,0xcc\n\t"					\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		: "+a"(vmcall_ret),						\
+		  [r10_out] "=rm" (__ret)					\
+		: "c" (TDX_R10 | TDX_R11 | TDX_R12),				\
+		  [r11_in] "irm" (r11),						\
+		  [r12_in] "irm" (r12)						\
+		: "r10", "r11", "r12"						\
+	);									\
+										\
+	TDVMCALL_BUG_ON(vmcall_ret);						\
+										\
+	__ret;									\
+})
+
+#define TDVMCALL_2_1(__in_r11, __in_r12, __out_r11)				\
+({										\
+	u64 vmcall_ret = TDG_VP_VMCALL;						\
+	u64 __in_r11, __in_r12;							\
+	u64 out_r11;								\
+	u64 __ret;								\
+										\
+	asm volatile (								\
+		"movq	%[r11_in], %%r11\n\t"					\
+		"movq	%[r12_in], %%r12\n\t"					\
+		"xor    %%r10d, %%r10d\n\t"					\
+		".byte 0x66,0x0f,0x01,0xcc\n\t"					\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		"movq	%%r11, %[r11_out]\n\t"					\
+		: "+a"(vmcall_ret),						\
+		  [r10_out] "=rm" (__ret),					\
+		  [r11_out] "=rm" (out_r11)					\
+		: "c" (TDX_R10 | TDX_R11 | TDX_R12),				\
+		  [r11_in] "irm" (r11),						\
+		  [r12_in] "irm" (r12)						\
+		: "r10", "r11", "r12"						\
+	);									\
+										\
+	TDVMCALL_BUG_ON(vmcall_ret);						\
+										\
+	__out_r11;								\
+	__ret;									\
+})
+
+#define TDVMCALL_3_0(__in_r11, __in_r12, __in_r13)				\
+({										\
+	u64 vmcall_ret = TDG_VP_VMCALL;						\
+	u64 __in_r11, __in_r12, __in_r13;					\
+	u64 __ret;								\
+										\
+	asm volatile (								\
+		"movq	%[r11_in], %%r11\n\t"					\
+		"movq	%[r12_in], %%r12\n\t"					\
+		"movq	%[r13_in], %%r13\n\t"					\
+		"xor    %%r10d, %%r10d\n\t"					\
+		".byte 0x66,0x0f,0x01,0xcc\n\t"					\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		: "+a"(vmcall_ret),						\
+		  [r10_out] "=rm" (__ret)					\
+		: "c" (TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13),			\
+		  [r11_in] "irm" (r11),						\
+		  [r12_in] "irm" (r12),						\
+		  [r13_in] "irm" (r13)						\
+		: "r10", "r11", "r12", "r13"					\
+	);									\
+										\
+	TDVMCALL_BUG_ON(vmcall_ret);						\
+										\
+	__ret;									\
+})
+
+#define TDVMCALL_3_1(__in_r11, __in_r12, __in_r13, __out_r11)			\
+({										\
+	u64 vmcall_ret = TDG_VP_VMCALL;						\
+	u64 __in_r11, __in_r12, __in_r13;					\
+	u64 out_r11;								\
+	u64 __ret;								\
+										\
+	asm volatile (								\
+		"movq	%[r11_in], %%r11\n\t"					\
+		"movq	%[r12_in], %%r12\n\t"					\
+		"movq	%[r13_in], %%r13\n\t"					\
+		"xor    %%r10d, %%r10d\n\t"					\
+		".byte 0x66,0x0f,0x01,0xcc\n\t"					\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		"movq	%%r11, %[r11_out]\n\t"					\
+		: "+a"(vmcall_ret),						\
+		  [r10_out] "=rm" (__ret),					\
+		  [r11_out] "=rm" (out_r11)					\
+		: "c" (TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13),			\
+		  [r11_in] "irm" (r11),						\
+		  [r12_in] "irm" (r12),						\
+		  [r13_in] "irm" (r13)						\
+		: "r10", "r11", "r12", "r13"					\
+	);									\
+										\
+	TDVMCALL_BUG_ON(vmcall_ret);						\
+										\
+	__out_r11;								\
+	__ret;									\
+})
+
+#define TDVMCALL_4_1(__in_r11, __in_r12, __in_r13, __in_r14, __out_r11)		\
+({										\
+	u64 vmcall_ret = TDG_VP_VMCALL;						\
+	u64 __in_r11, __in_r12, __in_r13, __in_r14;				\
+	u64 out_r11;								\
+	u64 __ret;								\
+										\
+	asm volatile (								\
+		"movq	%[r11_in], %%r11\n\t"					\
+		"movq	%[r12_in], %%r12\n\t"					\
+		"movq	%[r13_in], %%r13\n\t"					\
+		"movq	%[r14_in], %%r14\n\t"					\
+		"xor    %%r10d, %%r10d\n\t"					\
+		".byte 0x66,0x0f,0x01,0xcc\n\t"					\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		"movq	%%r11, %[r11_out]\n\t"					\
+		: "+a"(vmcall_ret),						\
+		  [r10_out] "=rm" (__ret),					\
+		  [r11_out] "=rm" (out_r11)					\
+		: "c" (TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14),	\
+		  [r11_in] "irm" (r11),						\
+		  [r12_in] "irm" (r12),						\
+		  [r13_in] "irm" (r13),						\
+		  [r14_in] "irm" (r14)						\
+		: "r10", "r11", "r12", "r13", "r14"				\
+	);									\
+										\
+	TDVMCALL_BUG_ON(vmcall_ret);						\
+										\
+	__out_r11;								\
+	__ret;									\
+})
+
+
+#define TDVMCALL_5_0(__in_r11, __in_r12, __in_r13, __in_r14, __in_r15)		\
+({										\
+	u64 vmcall_ret = TDG_VP_VMCALL;						\
+	u64 __in_r11, __in_r12, __in_r13, __in_r14, __in_r15;			\
+	u64 __ret;								\
+										\
+	asm volatile (								\
+		"movq	%[r11_in], %%r11\n\t"					\
+		"movq	%[r12_in], %%r12\n\t"					\
+		"movq	%[r13_in], %%r13\n\t"					\
+		"movq	%[r14_in], %%r14\n\t"					\
+		"movq	%[r15_in], %%r15\n\t"					\
+		"xor    %%r10d, %%r10d\n\t"					\
+		".byte 0x66,0x0f,0x01,0xcc\n\t"					\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		: "+a"(vmcall_ret),						\
+		  [r10_out] "=rm" (__ret)					\
+		: "c" (TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15),\
+		  [r11_in] "irm" (r11),						\
+		  [r12_in] "irm" (r12),						\
+		  [r13_in] "irm" (r13),						\
+		  [r14_in] "irm" (r14),						\
+		  [r15_in] "irm" (r15)						\
+		: "r10", "r11", "r12", "r13", "r14", "r15"			\
+	);									\
+										\
+	TDVMCALL_BUG_ON(vmcall_ret);						\
+										\
+	__ret;									\
+})
+
 /*
  * Used in __tdcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
@@ -97,25 +282,6 @@ u64 __tdcall_saved_ret(u64 fn, struct tdx_module_args *args);
 /* Used to request services from the VMM */
 u64 __tdx_hypercall(struct tdx_module_args *args);
 
-/*
- * Wrapper for standard use of __tdx_hypercall with no output aside from
- * return code.
- */
-static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
-{
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = fn,
-		.r12 = r12,
-		.r13 = r13,
-		.r14 = r14,
-		.r15 = r15,
-	};
-
-	return __tdx_hypercall(&args);
-}
-
-
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __noreturn __tdx_hypercall_failed(void);
 

base-commit: 2ab79514109578fc4b6df90633d500cf281eb689
-- 


