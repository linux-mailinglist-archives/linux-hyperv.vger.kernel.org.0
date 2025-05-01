Return-Path: <linux-hyperv+bounces-5292-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385D2AA635D
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D92D4C192F
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276F224AE8;
	Thu,  1 May 2025 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mLrGCz9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB51223DF4
	for <linux-hyperv@vger.kernel.org>; Thu,  1 May 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126003; cv=none; b=uJt+Myy40WGiKQW/Nb0Or/X/ZDwGfDBeN+KapWPSy7i7XbaTFMqhrqZbZ4wOk8e0Y0W7siPp4CjxWfPOIaRksWpiZxoHslwELxCnnOEn26FiGMZYW+LE/kT6iybS6RYFnVi5u0bw0hMV3YYD0zuVp4KgAP5SirolTsRf86L4a6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126003; c=relaxed/simple;
	bh=5MiUovNKUxYtrJS79oFnBsB9cOlpVIk+mk2oKba0ZTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9nd6yiGUXE9bv5z2bebhycZRfxP/OHS8um8EFQhXPwim0QolTFkTVL0dxWezlo6ZXkwHDw8opJTk/3w1XxpNgS9Up+O5Q6XCs99QBNzgGqW0FX+LDiZa6ywmiwkM8d/22bHh+/twDCq69/L+sOC3NOC3x2FUmnnvKp0SV9I4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mLrGCz9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e500a73so8801255ad.0
        for <linux-hyperv@vger.kernel.org>; Thu, 01 May 2025 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746126001; x=1746730801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhI86EioQSEbgpJce+lctNIEqTzid9MIbsNPxLfGtK4=;
        b=3mLrGCz9zpOW2GbN8KBaD8+DlchrL2GcyLOA2WQ0YAcLbmMxYU84eahEvCJ8HCV+u3
         b51jwagZtHbE6n6QuWDuSxyPDz3RzwI7XMB7HZZhvwKqpQqdvw6M34I2mEjnsFRbhUIy
         rkJZEBewqFwxxTvUoM5ucgzjRjmErKqU5bwAOM5pGvW+gZP+2fv/6xo5m3C1Ar269b1A
         ykfuIFzt7SbMRjHE6p8nEyN4oNr+ruOr6C6genxAsE5Q8QA9DSy66/Qa02raV9enDANK
         MR4XZU7m9CDquNow7HexmXZ2tEFLIL7rV8sNXKSJM33LIQwtNlL5Php7g/V9SQqOW23X
         vd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746126001; x=1746730801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhI86EioQSEbgpJce+lctNIEqTzid9MIbsNPxLfGtK4=;
        b=C8FzUTIfTRFS6PaKK7HOwxwEe4E69t+R9a6cGuQDSwq3SAXcflC/3iNtstivQAqCOw
         B1z1+oFubkIg+YKaFxdM+zU36Li8pI4xMcUtNWWPl9hP9vrh0QlIb60cb36sBa+9atHW
         KGJhDWGt7s4EAlliBR2M9IHgNwYWgel9OSg/tr7ZhuB7RJ0pnmkJJIJHeft/sTXPC142
         jxUP29+y+0hxp4RjEcbkfuai7VF45d9lT8y85KC9McoVU8OTVKSUVMJYWIDWpjUKoR20
         CLIFxu3udVMzHCJ4K/mNrtLZBz9WxWMY6Tw/CR42w/YLlRp+niHOE8ZbMW7C/zyolnE+
         9jww==
X-Forwarded-Encrypted: i=1; AJvYcCXQqHQIOe1anG8HJQeLhhlYr9UW/GA03p7FnKlsbZMa6hziDtvCe/CgnylHD5f3vR8ijI03Lht8JH59R/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPvMh0u3LoViJvnZ9bD3eFHpEx8RXQ2dkVPD25ZDEKkSaQust
	/r82kDqjQrBL/suMHxx/59EL2/NjYD658kEvb3i3NM5U7l9lzYE0fvlhcZha4b7Ocz0SMeb0ihG
	kqg==
X-Google-Smtp-Source: AGHT+IGyvMaXwl8AWpHhKbhCNLsowpIBdryOMvwnzBzhTNzXBvilZ4B9xHoSwT7czOpr1qOamFGilGA9sm8=
X-Received: from pjbtb7.prod.google.com ([2002:a17:90b:53c7:b0:301:2679:9d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5785:b0:30a:3dde:6af4
 with SMTP id 98e67ed59e1d1-30a4e6925dbmr311333a91.31.1746126000722; Thu, 01
 May 2025 12:00:00 -0700 (PDT)
Date: Thu, 1 May 2025 11:59:59 -0700
In-Reply-To: <EB1786D7-C7FE-4517-A207-C5F63AC0F911@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430110734.392235199@infradead.org> <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net> <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net> <aBO9uoLnxCSD0UwT@google.com>
 <EB1786D7-C7FE-4517-A207-C5F63AC0F911@zytor.com>
Message-ID: <aBPEr3DF4w9sbUdc@google.com>
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls in
 __nocfi functions
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org, 
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, 
	jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 01, 2025, H. Peter Anvin wrote:
> On May 1, 2025 11:30:18 AM PDT, Sean Christopherson <seanjc@google.com> wrote:
> >On Thu, May 01, 2025, Peter Zijlstra wrote:
> >> On Thu, May 01, 2025 at 12:30:38PM +0200, Peter Zijlstra wrote:
> >> > On Wed, Apr 30, 2025 at 09:06:00PM +0200, Peter Zijlstra wrote:
> >> > > On Wed, Apr 30, 2025 at 07:24:15AM -0700, H. Peter Anvin wrote:
> >> > > 
> >> > > > >KVM has another; the VMX interrupt injection stuff calls the IDT handler
> >> > > > >directly.  Is there an alternative? Can we keep a table of Linux functions
> >> > > > >slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?
> >> > > 
> >> > > > We do have a table of handlers higher up in the stack in the form of
> >> > > > the dispatch tables for FRED. They don't in general even need the
> >> > > > assembly entry stubs, either.
> >> > > 
> >> > > Oh, right. I'll go have a look at those.
> >> > 
> >> > Right, so perhaps the easiest way around this is to setup the FRED entry
> >> > tables unconditionally, have VMX mandate CONFIG_FRED and then have it
> >> > always use the FRED entry points.
> >> > 
> >> > Let me see how ugly that gets.
> >> 
> >> Something like so... except this is broken. Its reporting spurious
> >> interrupts on vector 0x00, so something is buggered passing that vector
> >> along.
> >
> >Uh, aren't you making this way more complex than it needs to be?  IIUC, KVM never
> >uses the FRED hardware entry points, i.e. the FRED entry tables don't need to be
> >in place because they'll never be used.  The only bits of code KVM needs is the
> >__fred_entry_from_kvm() glue.
> >
> >Lightly tested, but this combo works for IRQs and NMIs on non-FRED hardware.

Hrm, and now I see that fred_extint() relies on fred_install_sysvec(), which makes
me quite curious as to why IRQs didn't go sideways.  Oh, because sysvec_table[]
is statically defined at compile time except for PV crud.

So yeah, I think my the patches are correct, they just the need a small bit of
prep work to support dynamic setup of sysvec_table.

> >--
> >From 664468143109ab7c525c0babeba62195fa4c657e Mon Sep 17 00:00:00 2001
> >From: Sean Christopherson <seanjc@google.com>
> >Date: Thu, 1 May 2025 11:20:29 -0700
> >Subject: [PATCH 1/2] x86/fred: Play nice with invoking
> > asm_fred_entry_from_kvm() on non-FRED hardware
> >
> >Modify asm_fred_entry_from_kvm() to allow it to be invoked by KVM even
> >when FRED isn't fully enabled, e.g. when running with CONFIG_X86_FRED=y
> >on non-FRED hardware.  This will allow forcing KVM to always use the FRED
> >entry points for 64-bit kernels, which in turn will eliminate a rather
> >gross non-CFI indirect call that KVM uses to trampoline IRQs by doing IDT
> >lookups.
> >
> >When FRED isn't enabled, simply skip ERETS and restore RBP and RSP from
> >the stack frame prior to doing a "regular" RET back to KVM (in quotes
> >because of all the RET mitigation horrors).
> >
> >Signed-off-by: Sean Christopherson <seanjc@google.com>
> >---
> > arch/x86/entry/entry_64_fred.S | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> >index 29c5c32c16c3..7aff2f0a285f 100644
> >--- a/arch/x86/entry/entry_64_fred.S
> >+++ b/arch/x86/entry/entry_64_fred.S
> >@@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> > 	movq %rsp, %rdi				/* %rdi -> pt_regs */
> > 	call __fred_entry_from_kvm		/* Call the C entry point */
> > 	POP_REGS
> >-	ERETS
> >+
> >+	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED
> > 1:
> > 	/*
> > 	 * Objtool doesn't understand what ERETS does, this hint tells it that
> >@@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> > 	 * isn't strictly needed, but it's the simplest form.
> > 	 */
> > 	UNWIND_HINT_RESTORE
> >-	pop %rbp
> >+	leave
> > 	RET
> > 
> > SYM_FUNC_END(asm_fred_entry_from_kvm)
> >
> >base-commit: 45eb29140e68ffe8e93a5471006858a018480a45
> 
> Ok maybe I'm being dense, but what is left other than simply calling
> __fred_entry_from_kvm() as a normal C function? 
> 
> I'm on the go so there might be something in the code I'm missing, but on the
> surface...?

I'm sure it's doable, though I'd be more than a little nervous about diverging
from what FRED=y does, e.g. in case code somewhere expects the stack to look
exactly like a real FRED event.

And since we'd still need the assembly to support FRED=y, I don't see any point
in adding more code when it's trivially easy to have asm_fred_entry_from_kvm()
skip ERETS.

