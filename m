Return-Path: <linux-hyperv+bounces-776-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098937E5BC7
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA151C20AB8
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B0A30351;
	Wed,  8 Nov 2023 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBBb5N7W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBE18E14
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 16:55:54 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047981FF1
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 08:55:54 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc42d3f61eso55648405ad.3
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Nov 2023 08:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699462553; x=1700067353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CO2pM5qIBGIHIMO4lmTRmf1V07gbvmlwqsAp7UxomaA=;
        b=YBBb5N7WEYMBaAA5ux62ku+PbsXxhSvXuUUrpZjpoWOBT3fe0HV+9zVabIR1CgHzRK
         upvphGrCm05yvgZ/wUeA8KAp+KKsESz0BFY4FmY/J9T1xC/5uuo13ocfCBOW55DrVO5C
         IURtmCUepduiO9wYq93pjLfMh0v+rLVpD0wlkonSIDcueeSw8pMDSMRGvwiP3U3CEGYd
         LdFyGpk7DpZETId0nO1Fl08JZDrs3nwezmB2Sd2/+q/zUyMXuZKZiQm+WEOaJdfb5we3
         dDZvAQ6LBIkFpyWU3EVbRtqFS5MEaZx455OR2uEOXZiJ7LHJJIgYKLmFyiS9Qymb6V36
         4PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699462553; x=1700067353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CO2pM5qIBGIHIMO4lmTRmf1V07gbvmlwqsAp7UxomaA=;
        b=XVi8mPI3MDYfYcrgBR+bIPdLy+dusbdxzCBbz1JcHu8DqAvsoy4l5aGHeWLRwSVU1H
         vDNzbDfWktSfCVaN9LW5SfevqSeaPOCFKnMXWc5LnkGun7ub0ZwsTWkJtO0ITjOTgwPV
         m01X8uBNPpPun6tfrq1DvJ8hLt+x40jNNtjViS4r0EsfHptnC1n+RIW9n1tyC2ARRFLw
         eW5GUBI7beikrIjbV9C/mefntg0bMHK9RiwRqiTuhIvJqg/KS6EE2jYavwn46UAsTa9s
         4iATwZZ3uANalnwtH1WvQer9pqGCS1rqYGLAn77Ewdw5H55/+of0Mlcy3w1BLSgOJmby
         mmIw==
X-Gm-Message-State: AOJu0YyzElXJ3q2s8NrSSxFVuTO86aHTrqb46rDvsGNFMnZpPHyqKkwu
	m4m/6B+ySlxLKzdTvDqyJ6xuoyi0+hU=
X-Google-Smtp-Source: AGHT+IEbMq7I/7xfJWRovgT43Hk7brbn1/glVCYaEVcm/QGognSV8XOqAs3MxDssM6rkTG0d5HCi76zXJBc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f813:b0:1cc:29fb:f398 with SMTP id
 ix19-20020a170902f81300b001cc29fbf398mr50209plb.10.1699462553486; Wed, 08 Nov
 2023 08:55:53 -0800 (PST)
Date: Wed, 8 Nov 2023 08:55:51 -0800
In-Reply-To: <20231108111806.92604-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com>
Message-ID: <ZUu9lwJHasi2vKGg@google.com>
Subject: Re: [RFC 0/33] KVM: x86: hyperv: Introduce VSM support
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
	corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> This RFC series introduces the necessary infrastructure to emulate VSM
> enabled guests. It is a snapshot of the progress we made so far, and its
> main goal is to gather design feedback.

Heh, then please provide an overview of the design, and ideally context and/or
justification for various design decisions.  It doesn't need to be a proper design
doc, and you can certainly point at other documentation for explaining VSM/VTLs,
but a few paragraphs and/or verbose bullet points would go a long way.

The documentation in patch 33 provides an explanation of VSM itself, and a little
insight into how userspace can utilize the KVM implementation.  But the documentation
provides no explanation of the mechanics that KVM *developers* care about, e.g.
the use of memory attributes, how memory attributes are enforced, whether or not
an in-kernel local APIC is required, etc.

Nor does the documentation explain *why*, e.g. why store a separate set of memory
attributes per VTL "device", which by the by is broken and unnecessary.

> Specifically on the KVM APIs we introduce. For a high level design overview,
> see the documentation in patch 33.
> 
> Additionally, this topic will be discussed as part of the KVM
> Micro-conference, in this year's Linux Plumbers Conference [2].
> 
> The series is accompanied by two repositories:
>  - A PoC QEMU implementation of VSM [3].
>  - VSM kvm-unit-tests [4].
> 
> Note that this isn't a full VSM implementation. For now it only supports
> 2 VTLs, and only runs on uniprocessor guests. It is capable of booting
> Windows Sever 2016/2019, but is unstable during runtime.
> 
> The series is based on the v6.6 kernel release, and depends on the
> introduction of KVM memory attributes, which is being worked on
> independently in "KVM: guest_memfd() and per-page attributes" [5].

This doesn't actually apply on 6.6 with v14 of guest_memfd, because v14 of
guest_memfd is based on kvm-6.7-1.  Ah, and looking at your github repo, this
isn't based on v14 at all, it's based on v12.

That's totally fine, but the cover letter needs to explicitly, clearly, and
*accurately* state the dependencies.  I can obviously grab the full branch from
github, but that's not foolproof, e.g. if you accidentally delete or force push
to that branch.  And I also prefer to know that what I'm replying to on list is
the exact same code that I am looking at.

> A full Linux tree is also made available [6].
> 
> Series rundown:
>  - Patch 2 introduces the concept of APIC ID groups.
>  - Patches 3-12 introduce the VSM capability and basic VTL awareness into
>    Hyper-V emulation.
>  - Patch 13 introduces vCPU polling support.
>  - Patches 14-31 use KVM's memory attributes to implement VTL memory
>    protections. Introduces the VTL KMV device and secure memory
>    intercepts.
>  - Patch 32 is a temporary implementation of
>    HVCALL_TRANSLATE_VIRTUAL_ADDRESS necessary to boot Windows 2019.
>  - Patch 33 introduces documentation.
> 
> Our intention is to integrate feedback gathered in the RFC and LPC while
> we finish the VSM implementation. In the future, we will split the series
> into distinct feature patch sets and upstream these independently.
> 
> Thanks,
> Nicolas
> 
> [1] https://raw.githubusercontent.com/Microsoft/Virtualization-Documentation/master/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf
> [2] https://lpc.events/event/17/sessions/166/#20231114
> [3] https://github.com/vianpl/qemu/tree/vsm-rfc-v1
> [4] https://github.com/vianpl/kvm-unit-tests/tree/vsm-rfc-v1
> [5] https://lore.kernel.org/lkml/20231105163040.14904-1-pbonzini@redhat.com/.
> [6] Full tree: https://github.com/vianpl/linux/tree/vsm-rfc-v1. 

When providing github links, my preference is to format the pointers as:

  <repo> <branch>

or
  <repo> tags/<tag>

e.g.

  https://github.com/vianpl/linux vsm-rfc-v1

so that readers can copy+paste the full thing directly into `git fetch`.  It's a
minor thing, but AFAIK no one actually does review by clicking through github's
webview.

>     There are also two small dependencies with
>     https://marc.info/?l=kvm&m=167887543028109&w=2 and
>     https://lkml.org/lkml/2023/10/17/972

Please use lore links, there's zero reason to use anything else these days.  For
those of us that use b4, lore links make life much easier.

