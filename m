Return-Path: <linux-hyperv+bounces-3900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE2A312DB
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7986168450
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7BD262D09;
	Tue, 11 Feb 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4h6VTmq5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C97A1F940A
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294751; cv=none; b=ZnnS1qcdJT4yFyMMFtKppAh4oE4WNeQRaYyiKGjjCNy0+ierAvvGOGKXcYM2912B8Xk5sotrwWrgq9geyk7u9wgALdW1ETEr1nNVQyR7Icd8lPaB4SXWlN+uat5PncM4+xGZ1i1Nkz0kOj1LJ4PVMBuIZFDQXfa97zIHb2fOcac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294751; c=relaxed/simple;
	bh=yIyg4O5yYiMN7oIJCMQaW69afuHiK1Kltro4y0FMxoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WtLZf4W5KkjZZzLdRh3MoS8sasbF1TQ9SclesBYk7EKvOrl6+SoFNIkqL8KrPEcbyQYRQPLZs5F+P29nnCljDXP2ma6Pq4a99fDM0kReYhSG8Kt1yGYSTk63x/jJKxdKuol+9zRJmgHEDb4v7yqsJAiDvOlzysZGgVHnwR4A13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4h6VTmq5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa34df4995so12344900a91.0
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739294748; x=1739899548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fehn8/FKPdzBZiJ7SaATTiqPDXAlgIYGKuuyWYqseyE=;
        b=4h6VTmq5YsASoFycDSK8sm3fFCJfqspqCGsBcpvc+KhpNyBFRQJgj+JC4canHcJ2nU
         o1B6uRMedbeP+teFkRkYRlHIRahMiPhUc1qVXJMfRh0l/Tioav37v9pSpbDKjwlfCwS9
         myi0XYJrguCke3qGCoJJOPocswp1Zpf+d/hH+EASs6Sr/mb8RJj6zYwo7lCW3s2D6MQp
         3wRnAQAufckzdkCQbzjvElKcZqP2Cpe3MzAhkew46ktDi+TTAaUFrPILpPh1SgE7/dVX
         JjN1ns1RXL9HHwvkCl7Bx8UlGnTCTpbAG8mnusbD27ZvUqucCSmOFvey98Q6iNkk2Ivx
         bwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739294748; x=1739899548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fehn8/FKPdzBZiJ7SaATTiqPDXAlgIYGKuuyWYqseyE=;
        b=o62VbqA6ioy/aF+wCyefbj5XTuggmllFOATZuAYBkbEQzY3vtilXCUjmhms/PxTgsd
         UddAI+AiHMHuI9zEkiFvQY8EGoVVpmRnlSR5PAWfVXnKq4N4/lEWL+gIM1/G6tMqnWrX
         /2jfvwwX8I2XvhEtqXO1Y7Sy7ks3Wq3KZk7HYLrc+NDx1CmRcrsZDYrfY5LGcEh4+xIT
         xdgW9Xv+EDuh1Cg/2FA10lhVix+/Mwo+zTZm0ldkv8otC4cesjSC3sZNxo0qzB8ngJM9
         JMl8zkg+4+alCyUwppoohrQxE9sYg/FO25CId7ev3OU15SfMG7L4dQTO89KGSzCRIuWo
         j1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB0Ki2AVokWs4aTc61aJN9ntR7qL0C6oE+/2SybiyAkTpUemixKEiDZz53GAV/yzat5u/QeeuLp9OffTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1S+NnHG1zDAn3BDziO7MBtPGj9s8pe3fg2ZCOmsd+IOMhC4xo
	F88WyIIoUTt8vAjGPyRwLzO2VMNkvzNBWfx8AkrQuHCTkMJk/BspYwnZwsSUPP1yVgXki6MUeqJ
	8uA==
X-Google-Smtp-Source: AGHT+IFueIXltnSm3F29jVZndsq5T+j40lmj4UcIsQhmLdRSEShGqUPy9fjOgqE9JAinoOmES588AgdHP5k=
X-Received: from pjyf5.prod.google.com ([2002:a17:90a:ec85:b0:2fa:1481:81f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184d:b0:2ea:4c8d:c7a2
 with SMTP id 98e67ed59e1d1-2fa243db893mr28913562a91.24.1739294748442; Tue, 11
 Feb 2025 09:25:48 -0800 (PST)
Date: Tue, 11 Feb 2025 09:25:47 -0800
In-Reply-To: <20250211150114.GCZ6tmOqV4rI04HVuY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-2-seanjc@google.com>
 <20250211150114.GCZ6tmOqV4rI04HVuY@fat_crate.local>
Message-ID: <Z6uIGwxx9HzZQ-N7@google.com>
Subject: Re: [PATCH 01/16] x86/tsc: Add a standalone helpers for getting TSC
 info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, jailhouse-dev@googlegroups.com, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Borislav Petkov wrote:
> On Fri, Jan 31, 2025 at 06:17:03PM -0800, Sean Christopherson wrote:
> > Extract retrieval of TSC frequency information from CPUID into standalone
> > helpers so that TDX guest support and kvmlock can reuse the logic.  Provide
> > a version that includes the multiplier math as TDX in particular does NOT
> > want to use native_calibrate_tsc()'s fallback logic that derives the TSC
> > frequency based on CPUID.0x16 when the core crystal frequency isn't known.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/tsc.h | 41 ++++++++++++++++++++++++++++++++++++++
> >  arch/x86/kernel/tsc.c      | 14 ++-----------
> >  2 files changed, 43 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
> > index 94408a784c8e..14a81a66b37c 100644
> > --- a/arch/x86/include/asm/tsc.h
> > +++ b/arch/x86/include/asm/tsc.h
> 
> Bah, why in the header as inlines?

Because obviously optimizing code that's called once during boot is super
critical?

> Just leave them in tsc.c and call them...
> 
> > @@ -28,6 +28,47 @@ static inline cycles_t get_cycles(void)
> >  }
> >  #define get_cycles get_cycles
> >  
> > +static inline int cpuid_get_tsc_info(unsigned int *crystal_khz,
> > +				     unsigned int *denominator,
> > +				     unsigned int *numerator)
> 
> Can we pls do a
> 
> struct cpuid_tsc_info {
> 	unsigned int denominator;
> 	unsigned int numerator;
> 	unsigned int crystal_khz;
> 	unsigned int tsc_khz;
> }
> 
> and hand that around instead of those I/O pointers?

Ah, yeah, that's way better.

