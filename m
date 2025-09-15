Return-Path: <linux-hyperv+bounces-6871-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE0B586E7
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Sep 2025 23:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381BB3B7E32
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Sep 2025 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117721F5825;
	Mon, 15 Sep 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeYtQ14T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A34502A
	for <linux-hyperv@vger.kernel.org>; Mon, 15 Sep 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972779; cv=none; b=cZq+/rvkbXYDd2tFWtgYoTFNn0Y+a3GXoJ69HHWM9Hqnn5w6LNEgUkFvxyiFfRrc1Kie85MQcDP2p90HnMKQcZ0WO+uGLvFw4I0k6siA+vZx6ouT3gs+EdseRKQ9FjnOqD7VEf55g2KUaZ5vtkUQSD9l+IrHVZszZXAoLGES0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972779; c=relaxed/simple;
	bh=v/Wgj/3dHCXjASFjMDfD6XUSixDRap8sAOjZrhtx0xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BxUEpeOljOVo0986HgyMqh5Vjmy4HHRWeoJsd8/pGp7X+G92x08vN0BQTqb/X5eczcUS28zqe4K/gLmazHMvCRU7YMRBNC0zrYH5Q2+LvYc75YviIkvUStPlys2YS9qOzGjVJ2WAgd+mIrufOlGnp0+NnxoVzBX55QfcDv4KmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeYtQ14T; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24ced7cfa07so49507135ad.1
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Sep 2025 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757972777; x=1758577577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay2rsvNT5QrQxRba6c+m2a1G+QSUzGLsp0IocgOHOa8=;
        b=eeYtQ14T5Sm3i1iga7mQLhTZDMRQo6YXKFktZAMS6Jmq53c2ltKmEu8pkVYYE1x/9i
         EKAkuRy+Co08nW/uc2olCq3+iHQ8A0+EXmz36l6zCfzFPDDSwKGvcpssFNLlSE+RkE7J
         oKMhTDcpaO5xl+XAGaSHHpu1yQpdE8L6F8UyVAJEP8gaOgTJ/BQCdE2Fi/+YWtSNuDEH
         qUZgsGZ7q7GdZHLelQhBzPOx1nSwuWUu1sL7owmDmX+oxBOTyzI//p5RkLDtvBTCOUjt
         BsJUZdnuWDKRp6RWoM+6bd6u9jFBdyx+il+MykQx8Kf/uu1IckaJ3J83zEwoSrzgPBrt
         J8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757972777; x=1758577577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay2rsvNT5QrQxRba6c+m2a1G+QSUzGLsp0IocgOHOa8=;
        b=ZbAC7oaOaxQP7HFUHS5e3OQv8KOQETMeKcMzH6CtV33HrfxhFAS/ZYWdYA3L3ZtdOA
         Dk+bPSK6Yn4M6j4SYBp97LJzbO1bdY0RxYIzWBg+uR/mzrp7USjLz8YNaXD7yALOdBKn
         s/Rjslo1RQYFJyq93Cc9o3StXTKWr/ga4qpBKHBWQ7IjgEjRBr9DD6PjdKD4XhDQY+aE
         iQJRKBPDf1ntJylOccq+dLTEoILRNcJjSf5r2bbm14wMGJPffIEaVaXyEUXIjZvXbrxH
         sJ7fC537OBLKUcDLejJY5plxP7ivnlDfeoj47Wr1Ujeeo4uoCMddWUfPSzfGyipmQjam
         bmQA==
X-Forwarded-Encrypted: i=1; AJvYcCWHloh98ccllTsbeplRMTYcMTZMt71v88Hzc5rXfN/S/PO+FkhVRuBF6Z/dvdijrDSMDg5F1gBe2MG46ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YypDezgHi6WoAiS6HTl2gcM/WKpIZimJ3GgU2STwWyoTG8XFvN0
	ngv+h3shXAycVuDz+edtzZae+9yfKStccNHDfJ2gWfrf4HaC4HBBtqC/kSUl5sP4ESAyYfwjpw+
	EjGBY7A==
X-Google-Smtp-Source: AGHT+IHp+KuJpoCKRHr16jloNB8lvdxZSgcocNEZBn5+DI2Q+2zHnirpmHzX2lZrc02HnXfiHIn4JxXTaXg=
X-Received: from pjbsi16.prod.google.com ([2002:a17:90b:5290:b0:32e:8ff7:495])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164f:b0:327:c0c6:8829
 with SMTP id 98e67ed59e1d1-32de4f96e63mr19196432a91.24.1757972776812; Mon, 15
 Sep 2025 14:46:16 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:46:15 -0700
In-Reply-To: <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
 <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com> <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
Message-ID: <aMiJJyiIbxq6tM63@google.com>
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhklinux@outlook.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Peter Zijlstra wrote:
> On Tue, Aug 26, 2025 at 05:00:31PM +0530, Naman Jain wrote:
> > 
> > 
> > On 8/25/2025 3:12 PM, Peter Zijlstra wrote:
> > > On Mon, Aug 25, 2025 at 11:22:08AM +0530, Naman Jain wrote:
> > > > With commit 0e20f1f4c2cb ("x86/hyperv: Clean up hv_do_hypercall()"),
> > > > config checks were added to conditionally restrict export
> > > > of hv_hypercall_pg symbol at the same time when a usage of that symbol
> > > > was added in mshv_vtl_main.c driver. This results in missing symbol
> > > > warning when mshv_vtl_main is compiled. Change the logic to
> > > > export it unconditionally.
> > > > 
> > > > Fixes: 96a1d2495c2f ("Drivers: hv: Introduce mshv_vtl driver")
> > > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > 
> > > Oh gawd, that commit is terrible and adds yet another hypercall
> > > interface.
> > > 
> > > I would argue the proper fix is moving the whole of mshv_vtl_return()
> > > into the kernel proper and doing it like hv_std_hypercall() on x86_64.
> > 
> > Thanks for the review comments.
> > 
> > This is doable, I can move the hypercall part of it to
> > arch/x86/hyperv/hv_init.c if I understand correctly.
> > 
> > > 
> > > Additionally, how is that function not utterly broken? What happens if
> > > an interrupt or NMI comes in after native_write_cr2() and before the
> > > actual hypercall does VMEXIT and trips a #PF?
> > 
> > mshv_vtl driver is used for OpenHCL paravisor. The interrupts are
> > disabled, and NMIs aren't sent to the paravisor by the virt stack.
> 
> I do not know what OpenHCL is. Nor is it clear from the code what NMIs
> can't happen.

FWIW, NMIs likely aren't a problem because the NMI handler saves/restores CR2
specifically to guard against #PFs in NMI context clobbering guest state.  AMD
CPUs can block NMIs via GIF=0, but blocking NMIs on Intel for the VM-Entry =>
VM-Exit would require worse hacks than saving/restoring CR2 in the NMI handler.

:-(

> Anyway, same can be achieved with breakpoints / kprobes.  You can get a trap
> after setting CR2 and scribble it.

Ya, KVM marks everything for vmx_vcpu_enter_exit() to/from VM-Enter/VM-Exit as
noinstr (no instrumentation) to prevent breakpoints/kprobes from clobbering CR2
and other state (and DR7 is zero for good measure).

