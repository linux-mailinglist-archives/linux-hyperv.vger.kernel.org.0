Return-Path: <linux-hyperv+bounces-1244-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A74805E84
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4E1F21627
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B96D1DA;
	Tue,  5 Dec 2023 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ev8Hh1P0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5D183
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Dec 2023 11:21:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db5404fdfb2so112821276.1
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Dec 2023 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701804113; x=1702408913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PHueKnu6twn/8T3xEnp+ZFlbZ1HcVdnlRPtBHugQhw=;
        b=Ev8Hh1P0Lkn6rpwHqo6XRBJORC5pIsg8zENzrjNDjrI56SN7yuJz1Rr68Pqz7l7lMx
         k4WwCo2Tj7AurXyzwDuPABQKnj+HotokvhE+iZcsEaH0FqEVPtb8sm1k6FBkjiEEBeWV
         BwwvoWxBDymDs1cTorQpvI7Drb04zj/BLheY9skbS05hzIuVUiesuLgv6IPO9wo7WwUz
         BUJB/dnP/ln0HCkbQsh+xbBzASDLJc4XFAAis88NOyLWNZrAfl/ZGixx5n5kYLvTp3bw
         RvuS6tSavP181mlYlLba8Upo+d2S2tzTyla9rR1tQopXZFG2fb15oy6QgDE82cAhBSym
         xXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701804113; x=1702408913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PHueKnu6twn/8T3xEnp+ZFlbZ1HcVdnlRPtBHugQhw=;
        b=dWdUmhSw06fVyn6kSPL8Bu1J+0J0/wzrLQcptIKFFEhjWdMMnzsp+TIiEXIcLvbvNK
         vFaPSX5DioV/EKx0vv9sX/uD/QWMmnJTgpqbd7SiT3mS4dilcajxTggKGVN3uWHEp1tD
         yymvFL6S9cavkceDtpamsp3J1rylok+oEw/OZqR4xhq1dYjHJ3F4+dMBGs9Tx+WjYvYa
         U4+FhD7SkycADSr1nvrFW/4wSIgbJAQHnXb+coxlMm5lrTPThC3w9Ah9UBSv5iBTAHhg
         J273Fz+dgqeyiNoo4b4zt0/vK5AhtXNLzhJpOAN3hWxuTg7fcZOybJ5H9J20Hw0h43GO
         vjSQ==
X-Gm-Message-State: AOJu0YyuQDDWkCYjBFXJCcE3R7UABX0CxaEwDRIiIHu8VMEafL9JgsyG
	AowHfzMA05slsY4+PgpFSk0IHhyji94=
X-Google-Smtp-Source: AGHT+IEDojI9r2jUP7SnFhGrIGalU4Ij3ADFSMH3T+bKNraCDRbJqd/r79BOcS/tAV9dHezzcWCAi9z33D0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bccd:0:b0:d9a:ca20:1911 with SMTP id
 l13-20020a25bccd000000b00d9aca201911mr63207ybm.4.1701804113124; Tue, 05 Dec
 2023 11:21:53 -0800 (PST)
Date: Tue, 5 Dec 2023 11:21:51 -0800
In-Reply-To: <CXD7AW5T9R7G.2REFR2IRSVRVZ@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-6-nsaenz@amazon.com>
 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
 <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com> <ZWoKlJUKJGGhRRgM@google.com>
 <CXD5HJ5LQMTE.11XP9UB9IL8LY@amazon.com> <ZWocI-2ajwudA-S5@google.com> <CXD7AW5T9R7G.2REFR2IRSVRVZ@amazon.com>
Message-ID: <ZW94T8Fx2eJpwKQS@google.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> On Fri Dec 1, 2023 at 5:47 PM UTC, Sean Christopherson wrote:
> > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > On Fri Dec 1, 2023 at 4:32 PM UTC, Sean Christopherson wrote:
> > > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > > > To support this I think that we can add a userspace msr filter on the HV_X64_MSR_HYPERCALL,
> > > > > > although I am not 100% sure if a userspace msr filter overrides the in-kernel msr handling.
> > > > >
> > > > > I thought about it at the time. It's not that simple though, we should
> > > > > still let KVM set the hypercall bytecode, and other quirks like the Xen
> > > > > one.
> > > >
> > > > Yeah, that Xen quirk is quite the killer.
> > > >
> > > > Can you provide pseudo-assembly for what the final page is supposed to look like?
> > > > I'm struggling mightily to understand what this is actually trying to do.
> > >
> > > I'll make it as simple as possible (diregard 32bit support and that xen
> > > exists):
> > >
> > > vmcall             <-  Offset 0, regular Hyper-V hypercalls enter here
> > > ret
> > > mov rax,rcx  <-  VTL call hypercall enters here
> >
> > I'm missing who/what defines "here" though.  What generates the CALL that points
> > at this exact offset?  If the exact offset is dictated in the TLFS, then aren't
> > we screwed with the whole Xen quirk, which inserts 5 bytes before that first VMCALL?
> 
> Yes, sorry, I should've included some more context.
> 
> Here's a rundown (from memory) of how the first VTL call happens:
>  - CPU0 start running at VTL0.
>  - Hyper-V enables VTL1 on the partition.
>  - Hyper-V enabled VTL1 on CPU0, but doesn't yet switch to it. It passes
>    the initial VTL1 CPU state alongside the enablement hypercall
>    arguments.
>  - Hyper-V sets the Hypercall page overlay address through
>    HV_X64_MSR_HYPERCALL. KVM fills it.
>  - Hyper-V gets the VTL-call and VTL-return offset into the hypercall
>    page using the VP Register HvRegisterVsmCodePageOffsets (VP register
>    handling is in user-space).

Ah, so the guest sets the offsets by "writing" HvRegisterVsmCodePageOffsets via
a HvSetVpRegisters() hypercall.

I don't see a sane way to handle this in KVM if userspace handles HvSetVpRegisters().
E.g. if the guest requests offsets that don't leave enough room for KVM to shove
in its data, then presumably userspace needs to reject HvSetVpRegisters().  But
that requires userspace to know exactly how many bytes KVM is going to write at
each offsets.

My vote is to have userspace do all the patching.  IIUC, all of this is going to
be mutually exclusive with kvm_xen_hypercall_enabled(), i.e. userspace doesn't
need to worry about setting RAX[31].  At that point, it's just VMCALL versus
VMMCALL, and userspace is more than capable of identifying whether its running
on Intel or AMD.

>  - Hyper-V performs the first VTL-call, and has all it needs to move
>    between VTL0/1.
> 
> Nicolas

