Return-Path: <linux-hyperv+bounces-1176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2E0801201
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A46281258
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F04E614;
	Fri,  1 Dec 2023 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Yuf4U0y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02DEAD
	for <linux-hyperv@vger.kernel.org>; Fri,  1 Dec 2023 09:47:17 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca61d84dc3so41003657b3.0
        for <linux-hyperv@vger.kernel.org>; Fri, 01 Dec 2023 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701452837; x=1702057637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekY0qH1P2v7sxet+FFzSNmfvdCHeSDMjAlh064D7O84=;
        b=2Yuf4U0y/otd79jj1rlpstx914BdJ+x9EcIqpsRmKvrq9Y07Bb/mM+8dAKhOhy9G+T
         s94snDmQuAmGp8uovCeVwZU1orBfArvFzOHGfCJOhiit3CZYaQJdOKkcYxFO6Basfbeb
         5/siLSTEoTu2ovxOBzkm2qxvwmKq75uPvi/y7R0Jek40T+U9a2lWq/USiT6lsp3VBGJg
         cX5Ua8fvyaczOhAGtaGuOLtkNnH54EHO5PsMW7D9L7Vi7At6MdATt/KW6Y3QwzN5TepV
         Rf35ObflW5Y2qybNwhlggO3tQMYhjAlrVT0SEzYofJ2qXwLNeX95g8MHRLJb9Bo3Uny9
         9pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452837; x=1702057637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekY0qH1P2v7sxet+FFzSNmfvdCHeSDMjAlh064D7O84=;
        b=vEt+Huj+xBYsHmVPETeKUsjepio/IZmn1xFrGkGIjbxS267UpWwWEQ88e8KAdRlc21
         mXUmAGlga3nW6z4CZkcMtOUxy8dwKPXZ+CApscIUhipQoIXhBlnHh0ppTOaW5NU+T3aY
         qEr5EA2KKkZFkU4lhJYkayr5khZxq23H8M0UQ9ksWIRlRveTPVXwO8e7LYDcj/RtZk6N
         vqOHgAr4rJbyG3ZB/IRRGxRnsN7Dlc9bvc9XDozVmOSjuwp7KPh3+Erm0KPGp7XOmdKU
         8WXjra0FY9d4V1h3cnCv3P71B/LGcinnClWzll4aZCuSJ8An01nq2Q+sURuLLi0e0D73
         PoWw==
X-Gm-Message-State: AOJu0Yyk1CsRv5OUesC8Ak1DUkLx6c9DeDMRfnWjEz56sFOiaNglR8d+
	mBYIGpjFU1k+UajJ5f7ilScGpE+l4eM=
X-Google-Smtp-Source: AGHT+IGhYfPZ1olbigqH98QigIcNR2O3rDqntLBQK660WHy3YcxXWqy8DOzYQjXtgojo0EBei7sSFc5etMo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:98d:b0:5d6:cb62:4793 with SMTP id
 ce13-20020a05690c098d00b005d6cb624793mr36113ywb.0.1701452837094; Fri, 01 Dec
 2023 09:47:17 -0800 (PST)
Date: Fri, 1 Dec 2023 09:47:15 -0800
In-Reply-To: <CXD5HJ5LQMTE.11XP9UB9IL8LY@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-6-nsaenz@amazon.com>
 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
 <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com> <ZWoKlJUKJGGhRRgM@google.com> <CXD5HJ5LQMTE.11XP9UB9IL8LY@amazon.com>
Message-ID: <ZWocI-2ajwudA-S5@google.com>
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
> On Fri Dec 1, 2023 at 4:32 PM UTC, Sean Christopherson wrote:
> > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > To support this I think that we can add a userspace msr filter on the HV_X64_MSR_HYPERCALL,
> > > > although I am not 100% sure if a userspace msr filter overrides the in-kernel msr handling.
> > >
> > > I thought about it at the time. It's not that simple though, we should
> > > still let KVM set the hypercall bytecode, and other quirks like the Xen
> > > one.
> >
> > Yeah, that Xen quirk is quite the killer.
> >
> > Can you provide pseudo-assembly for what the final page is supposed to look like?
> > I'm struggling mightily to understand what this is actually trying to do.
> 
> I'll make it as simple as possible (diregard 32bit support and that xen
> exists):
> 
> vmcall	     <-  Offset 0, regular Hyper-V hypercalls enter here
> ret
> mov rax,rcx  <-  VTL call hypercall enters here

I'm missing who/what defines "here" though.  What generates the CALL that points
at this exact offset?  If the exact offset is dictated in the TLFS, then aren't
we screwed with the whole Xen quirk, which inserts 5 bytes before that first VMCALL?

