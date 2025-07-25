Return-Path: <linux-hyperv+bounces-6403-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40387B124F9
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 21:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561D81CE27B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2482522B1;
	Fri, 25 Jul 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5mjOzRz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103F24E4BD
	for <linux-hyperv@vger.kernel.org>; Fri, 25 Jul 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473408; cv=none; b=X+YYsw0EhvGVaCBlXHkM0rg9aGXz5mNbxfKmbfAfdjDI8VmtMUmmQL1dyCZLSVhx76roNoXWVfoRDqp/lg2veryIhszhwKR/eCc7kQjnEayZfvn1UFcENesrUIIf14B14HNL1dv/GYXFKty6fTFU41pZCjJXau5WZ86B4qB/J/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473408; c=relaxed/simple;
	bh=kMe0ue3soy3FIW1/fW7FKunjVHoomXH+3YQEEOAZOJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJQHeRw95NbFAouVyA+WX9RRaBQ7tLLIqQo+fNksOYr+fRgSTI4q2zkAsly5Ud4h7cFFwhGMX8OwEM1WnhJX9scUYOul5uqBp0b5n9jxzSDrWznvSIqEZEi+AUMynCfX6hjhcWqu/GkISDhKR/RvSfqSE/9oKiBToHrvPKoIqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5mjOzRz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d670ad35so2294542a91.3
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Jul 2025 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753473406; x=1754078206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii/J/YHUTK4YRW5OzHg9e1xV7PaXyv7CpmlDeDzp5rg=;
        b=o5mjOzRzO+NlnC6K8tmSMSeTqTEgdFNxwfLjXhv18RBMmOYhM49lZ6gHA8+bXNjNJA
         5GgwTsNjBwspc9PsAI0myITXoqzBzDiShgi3Eio4l8jKX47ZzyY9CWzpguFVotRwY6Rw
         XT/Von50p0Zh4Vh7ZQtX8V4xjLDn3l1/6YVK1CDKrjxVqsQ2GCeY/O8y97xot9wzuoz3
         C7bntlMaTR94Fc7CodE8tW63Fli0efQTjop2rQuZchvHD8foVTBQ3erXnx/qoGgLiuWh
         uZXB5xn8MaJRL7Vu4HVoAYsazwnz6LLIbUsPcY5ZIOaI3i1MmeDjITI2zMChgZrmY+U/
         gLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753473406; x=1754078206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii/J/YHUTK4YRW5OzHg9e1xV7PaXyv7CpmlDeDzp5rg=;
        b=SJmkw7EesSMuBh/jt92xSjrONvEe7IoaWLaYzE3xeabA6WXYenGCJx7rZsbCGl7VsY
         8n3y7tYUiVgEfzDr1N/Nt+MTdQN9Dq6lyFFasEAu91yJdqtMNo/GedaewtH53sG6Yk3t
         MnpuzH7Ov3B9XFaO4palZXpPHsLKGZVQfWxjjW8DnWchhDjieTJx837XWjVbs4+S5luA
         54Zsif4R9c27gKW53D1ni1GiK1T723xahurmYiPBCFCCy9TXPGtYACDbtqoMpwgFE7Py
         3I2voaOl/J4/lmzR62s4tpTmLP/aEBPU3X783ZUY1fz/jAuZpT00GGqQveuZl85d9+LY
         xKcg==
X-Forwarded-Encrypted: i=1; AJvYcCUvB/1TFcDLCz1tvpaMYerRkYH0CVjn7GINokPgswGgvK6x93mUOmynt4K2qqzq1M5g2tdNOrQ6h3TIyrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSC4cynw/OQ7fAobT73Lisk+eMwwjhkKlR3zXc2/fh6QTARgmJ
	ZbPLuhsI/IPCuZQsfgKeTWnKqATWZ/F0+rwSwDlBbfHUT9fUNu32afrGS+fXgkbdkHd2T02yKXN
	YVmFBxw==
X-Google-Smtp-Source: AGHT+IHu7FDFnNcTabtdewi4bY3hb/3jyWNKkxkjd+oq4fY81m/OoMs8YEN7TZ8oihNIY3LRn/TzU34UmaY=
X-Received: from pjuu7.prod.google.com ([2002:a17:90b:5867:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d446:b0:311:ba32:164f
 with SMTP id 98e67ed59e1d1-31e77863e01mr4894272a91.8.1753473405737; Fri, 25
 Jul 2025 12:56:45 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:56:44 -0700
In-Reply-To: <1584052d-4d8c-4b4e-b65b-318296d47636@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714102011.758008629@infradead.org> <20250714103441.496787279@infradead.org>
 <aIKZnSuTXn9thrf7@google.com> <1584052d-4d8c-4b4e-b65b-318296d47636@zytor.com>
Message-ID: <aIPhfNxjTL4LiG6Z@google.com>
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 25, 2025, Xin Li wrote:
> On 7/24/2025 1:37 PM, Sean Christopherson wrote:
> > On Mon, Jul 14, 2025, Peter Zijlstra wrote:
> > > --- a/arch/x86/kvm/vmx/vmenter.S
> > > +++ b/arch/x86/kvm/vmx/vmenter.S
> > > @@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
> > >   .section .text, "ax"
> > > +#ifndef CONFIG_X86_FRED
> > > +
> > >   SYM_FUNC_START(vmx_do_interrupt_irqoff)
> > >   	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
> > >   SYM_FUNC_END(vmx_do_interrupt_irqoff)
> > > +
> > > +#endif
> > 
> > This can go in the previous patch, "x86/fred: KVM: VMX: Always use FRED for IRQs
> > when CONFIG_X86_FRED=y".
> > 
> 
> I'm going to test patch 13~15, plus this change in patch 16.
> 
> BTW, there is a declaration for vmx_do_interrupt_irqoff() in
> arch/x86/kvm/vmx/vmx.c, so we'd better also do:
> 
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6945,7 +6945,9 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64
> *eoi_exit_bitmap)
>         vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
>  }
> 
> +#ifndef CONFIG_X86_FRED
>  void vmx_do_interrupt_irqoff(unsigned long entry);
> +#endif

No, we want to keep the declaration.  Unconditionally decaring the symbol allows
KVM to use IS_ENABLED():

	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);

Hiding the declaration would require that to be a "proper" #ifdef, which would
be a net negative for readability.  The extra declaration won't hurt anything for
CONFIG_X86_FRED=n, as "bad" usage will still fail at link time.

>  void vmx_do_nmi_irqoff(void);
> 
>  static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)

