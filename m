Return-Path: <linux-hyperv+bounces-1174-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B217801028
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117E8B2147E
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5CF4D59B;
	Fri,  1 Dec 2023 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sb81ttRM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1A10DE
	for <linux-hyperv@vger.kernel.org>; Fri,  1 Dec 2023 08:32:22 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c62c98f682so724048a12.2
        for <linux-hyperv@vger.kernel.org>; Fri, 01 Dec 2023 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701448342; x=1702053142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/K7HE0EB9COwZnWNHAn0RCBpw/EJerDEKjS1XCTH01o=;
        b=sb81ttRMy+4zDNQ3pBlsxtaovroVp6bOprAEQjGOKZqjl1VlY+AH9qes2XuFym/dfG
         6CuzeVxgDSh9s0x9SwuRY13U5jo+e2pb6iECKRbtETREHex7+URnpkgizRdvBlz1HXTW
         76EyyQiNlpCB4mzeGDYPdrwL5DaneL/LhpWQpBczUPRDmyQYZnrX0syjuG/4EQ01t97R
         SHPpnoajTXJ6aBkl5urglMFAJ/1iIU0lNpMN6zmXGl8X4HZUCkhXPPnT8hMRI4NbKcYl
         JtcD83MLhirCDMETTLLZJEN7n5PAUn/i8+b4fZp2csdMq4EL0J4/GdFNWwm6osa5slxq
         p/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448342; x=1702053142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/K7HE0EB9COwZnWNHAn0RCBpw/EJerDEKjS1XCTH01o=;
        b=BVUwWg9yqNdiOdNC/Qx7bc8SK2foY1TfecaMMD+GLQXM9e/zSPzYd7j2jOGJ8d1wNX
         nTWBC/TaZVuqEMNWrmQR+G7ohg1Lx3Jsv5+q+LFTXefmqSbAIevanRYNzeoAK2wX/NAf
         06QPRSk3k9aR8wjLVIvT/4QfCdcAySG/M2jF8WI7B0gQm8eSWYeHdQ63gkW3EabYB9O7
         2nj9nURGqX58Ms6ktmrXYHX3o7v4z3EPC3vcfKz+crmbmkhJCrFHtIeuSAaeTDWDR4v4
         A2IUHiY7dj5EOt3M6lXE9L0Fj4tLjd9kA85GV5bRZVI8CERii5uAArgCco4LbYbzmuBo
         Q/og==
X-Gm-Message-State: AOJu0Yx6SK0iMTqCZqKlkhWhSKHuPge7WQADUQXgXwOoIWZaPaUiegCL
	jy9LaQ2b8Eb3tHCipBg2jkg2MOoYyz8=
X-Google-Smtp-Source: AGHT+IH1lYPeVLhg1fK/372dKtjjpuPIbf/djPz/KyZw6BQ3OgmjhAtwIR2bi7SaI0dtlhyObZ26zc2sufk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:211f:0:b0:5bd:bbb4:5275 with SMTP id
 h31-20020a63211f000000b005bdbbb45275mr3949230pgh.10.1701448342043; Fri, 01
 Dec 2023 08:32:22 -0800 (PST)
Date: Fri, 1 Dec 2023 08:32:20 -0800
In-Reply-To: <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-6-nsaenz@amazon.com>
 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com> <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com>
Message-ID: <ZWoKlJUKJGGhRRgM@google.com>
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
> > To support this I think that we can add a userspace msr filter on the HV_X64_MSR_HYPERCALL,
> > although I am not 100% sure if a userspace msr filter overrides the in-kernel msr handling.
> 
> I thought about it at the time. It's not that simple though, we should
> still let KVM set the hypercall bytecode, and other quirks like the Xen
> one.

Yeah, that Xen quirk is quite the killer.

Can you provide pseudo-assembly for what the final page is supposed to look like?
I'm struggling mightily to understand what this is actually trying to do.

