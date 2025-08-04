Return-Path: <linux-hyperv+bounces-6461-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9550B1AB43
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Aug 2025 01:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063E9170B13
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Aug 2025 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B1291C01;
	Mon,  4 Aug 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7EiZ6El"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2D231A30
	for <linux-hyperv@vger.kernel.org>; Mon,  4 Aug 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754349004; cv=none; b=cbnyMCMyxfJwJ2gOEvmV1IiazQ07lQ23DDOUPEqY6Uhx/E4ldXw+kl7xPqQqkHYoQYc/D2tyq8k5hcHe2h+ov35WVzVQupUqcoF1lPaRHLsXBgD6PCbJm1jB6Fq5RLdRXoPdDmhRokyurQk0GB/H+yBpTmcgBqCrBSYyTJbYaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754349004; c=relaxed/simple;
	bh=jGEm0DtgPk8+RabZ/v6woIGn/2BhjebzCgIbNh+Ac80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C67MoxfGNNM4alhwbXhTIygOg7Osbkd7OQfRON+d/xIqsOUa2Pq3AP8Lhg+9jqQ/TE2SQ+FRL6ua8ETCXgQCjdINi1wZMAE2hvxuRWwyd8MdReEWllI/FcqlnRYjYrUnxgNki+rFnGJMz5G47QRjgg2d3qiL8HTosFskClnUOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7EiZ6El; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b115fb801bcso6748652a12.3
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Aug 2025 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754349001; x=1754953801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tG0zFdwSMEPj6TjvMjIhSWrku59KtpikLJvWaNvieXY=;
        b=X7EiZ6Elq84ytvAMYbzXAelu/Uvw/oj6a7ydvZlyA2EqZc4Y58MfQ1XFQmZ+w9vrrd
         AZdSknweCxEO79fSpO0EoFlmEFQAYSCQhjoQFyh+tYr1jbxw4qHF7ejF40jgXKCo0lAH
         09OmkyQt8RHDP3t57HZ17t25t224yfdOIHULtkuECNsqg44pBW6sEYA7XPAUSwzz5FVO
         U7ulk5RGtcIIfdYnNXPkRH2hsk0ORyQUWLla1pdrB0HKMVKx7bT6IUTKwBmXHZp32+UF
         BtoQ9Ve7JvXu7pF6X6WgzkTcnG0vt0uzjgIVq69pf1zg3VPwmbX3Ow4RROtz+yVEYCfR
         PDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754349001; x=1754953801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tG0zFdwSMEPj6TjvMjIhSWrku59KtpikLJvWaNvieXY=;
        b=OZUut7Ox/tgK0IfRZndO4Lrd5OdE7+sIoTH6W493YGJenD0INABvRfoSFWWp7TrLcn
         QOUIjK1xdxoCdwkc56fP2YgMB8W+WD9mIxwuWUfLzPt2dayzZXllhqMYMdC6hry3ufmw
         j823Ur7weCLfV4AuD+Y/LdCZjpBnuqiqdFEVdQLccDDaR4LpHQCQioQAiH8cBoQ5cFxC
         qc3U0EqgeOP58GkHH2qwwfWgUKydHu14AxAn8mB73JVW9cM1cMcJEHJg8GsV3rgna0Xj
         P26HmqhJdJLwcmUdl03KBHPql1oB/HXjtvk6WaFA39YMAuzgMj197Lt1+BAZCtuQu0dx
         cL0w==
X-Forwarded-Encrypted: i=1; AJvYcCVtFwKVGWmoceWaVsCwRnQLHqPE4CdndK2R9sy2e25YBX3+oztvkj/524618pIj/YoFI0YciyYiDJfzxYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvXmbwwo8diKeN22j2StmZsqcyQ6mMIgPlRFnlLU3UJy7/4DH
	ys2GiTn0tA8eR+u+mqymDWRx350B9DK0oxUlsiaKLmC2DHRDLx+7pAFMDVsqePWS7aTJh1iiSIi
	xOtYIXQ==
X-Google-Smtp-Source: AGHT+IE2NsYRZGLMA0DfVkuf5vaTZrSFR4fZkpJO3aIRBFjVMmkA+JR/oFWBMzx7rkrijiPT3c3wcqzhSlk=
X-Received: from pjyf7.prod.google.com ([2002:a17:90a:ec87:b0:31f:1707:80f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3886:b0:31e:f3b7:49d2
 with SMTP id 98e67ed59e1d1-3211611bdf3mr16662659a91.0.1754349000710; Mon, 04
 Aug 2025 16:10:00 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:09:59 -0700
In-Reply-To: <87tt2nm6ie.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1750432368.git.jpiotrowski@linux.microsoft.com>
 <4266fc8f76c152a3ffcbb2d2ebafd608aa0fb949.1750432368.git.jpiotrowski@linux.microsoft.com>
 <875xghoaac.fsf@redhat.com> <ca26fba1-c2bb-40a1-bb5e-92811c4a6fc6@linux.microsoft.com>
 <87o6tttliq.fsf@redhat.com> <aHWjPSIdp5B-2UBl@google.com> <87tt2nm6ie.fsf@redhat.com>
Message-ID: <aJE9x_pjBVIdiEJN@google.com>
Subject: Re: [RFC PATCH 1/1] KVM: VMX: Use Hyper-V EPT flush for local TLB flushes
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	alanjiang@microsoft.com, chinang.ma@microsoft.com, 
	andrea.pellegrini@microsoft.com, Kevin Tian <kevin.tian@intel.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 04, 2025, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > It'll take more work than the below, e.g. to have VMX's construct_eptp() pull the
> > level and A/D bits from kvm_mmu_page (vendor code can get at the kvm_mmu_page with
> > root_to_sp()), but for the core concept/skeleton, I think this is it?
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 6e838cb6c9e1..298130445182 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3839,6 +3839,37 @@ void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu)
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_mmu_free_guest_mode_roots);
> >  
> > +struct kvm_tlb_flush_root {
> > +       struct kvm *kvm;
> > +       hpa_t root;
> > +};
> > +
> > +static void kvm_flush_tlb_root(void *__data)
> > +{
> > +       struct kvm_tlb_flush_root *data = __data;
> > +
> > +       kvm_x86_call(flush_tlb_root)(data->kvm, data->root);
> > +}
> > +
> > +void kvm_mmu_flush_all_tlbs_root(struct kvm *kvm, struct kvm_mmu_page *root)
> > +{
> > +       struct kvm_tlb_flush_root data = {
> > +               .kvm = kvm,
> > +               .root = __pa(root->spt),
> > +       };
> > +
> > +       /*
> > +        * Flush any TLB entries for the new root, the provenance of the root
> > +        * is unknown.  Even if KVM ensures there are no stale TLB entries
> > +        * for a freed root, in theory another hypervisor could have left
> > +        * stale entries.  Flushing on alloc also allows KVM to skip the TLB
> > +        * flush when freeing a root (see kvm_tdp_mmu_put_root()), and flushing
> > +        * TLBs on all CPUs allows KVM to elide TLB flushes when a vCPU is
> > +        * migrated to a different pCPU.
> > +        */
> > +       on_each_cpu(kvm_flush_tlb_root, &data, 1);
> 
> Would it make sense to complement this with e.g. a CPU mask tracking all
> the pCPUs where the VM has ever been seen running (+ a flush when a new
> one is added to it)?
> 
> I'm worried about the potential performance impact for a case when a
> huge host is running a lot of small VMs in 'partitioning' mode
> (i.e. when all vCPUs are pinned). Additionally, this may have a negative
> impact on RT use-cases where each unnecessary interruption can be seen
> problematic. 

Oof, right.  And it's not even a VM-to-VM noisy neighbor problem, e.g. a few
vCPUs using nested TDP could generate a lot of noist IRQs through a VM.  Hrm.

So I think the basic idea is so flawed/garbage that even enhancing it with per-VM
pCPU tracking wouldn't work.  I do think you've got the right idea with a pCPU mask
though, but instead of using a mask to scope IPIs, use it to elide TLB flushes.

With the TDP MMU, KVM can have at most 6 non-nested roots active at any given time:
SMM vs. non-SMM, 4-level vs. 5-level, L1 vs. L2.  Allocating a cpumask for each
TDP MMU root seems reasonable.  Then on task migration, instead of doing a global
INVEPT, only INVEPT the current and prev_roots (because getting a new root will
trigger a flush in kvm_mmu_load()), and skip INVEPT on TDP MMU roots if the pCPU
has already done a flush for the root.

Or we could do the optimized tracking for all roots.  x86 supports at most 8192
CPUs, which means 1KiB per root.  That doesn't seem at all painful given that
each shadow pages consumes 4KiB...

