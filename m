Return-Path: <linux-hyperv+bounces-7575-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46431C5AA8C
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 00:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBAE84E9438
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 23:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351AD32C95D;
	Thu, 13 Nov 2025 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1I3YAKE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5D329E7F
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076945; cv=none; b=Uavj5lIUwkvffJtA9K1BzLxEielV6I5vlkixzIRRp5Eghp9EMJl+uJQ8H9yXtzrusjJGupeT/rXIXys/uvOuUK5H31ObJXx9TE6tWueu1WMDSjvCKht/T1jfvcm0d9VskA1wUE3M8XkNXE80706qZTp9CRzaR4G6W9bzltRXJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076945; c=relaxed/simple;
	bh=iZwbsjBlUGB/L7Tt4aRhcCGUMR1cTPa3EF2l5Ki/nAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYCv71vs93uEkJ/VxtfCWS++8AJ+YC1uQKmYUOBTit6EAvBW+QM+/NRYqHl+E8UnPigz8jISYt4TZ0pBxL8L8VzhvFdsVbtQ2MFKeaLuVrNadLegdUCKdbpfoK/WV4nYe+eaz5IuCW3U0jN9aoYD1q84AwNOSn9/FhjqsGuFmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1I3YAKE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2958c80fcabso36156845ad.0
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763076943; x=1763681743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9bY2qG6GLBD8ld0AXT/mnVjS4VslzGu1FqILp2o5yc=;
        b=S1I3YAKEZsS++gGiW8sOcYMb/z+O5sa7y3n8DBcn/d4nC2HNrrcvhdCMFq7CI7NZHx
         tm/71h4w9Z8HCfOisDmMCyLJc+yuKvBXDPAlv1PwXVo89zMvtdoCmJHMcql6wdbM25Ls
         nTHwLjdjpf8IK6gCsYC/3Nk0Gp+7u7o2uY3kroeqFn71vC6uyNIJhSX0hPvurP/Bx9sM
         eO4KHTPIdiadJukFXs2671wv0oetY6SIlQW8ugN/EOC1s7q2pWxrCA6DkXu4MXiZhzsR
         x54fti7caG0eQP3Cg1XG0MCjnUH4dzwzfUpKaU1JjwOBoPxPNpMQybcfv289iodKwll6
         oxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076943; x=1763681743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9bY2qG6GLBD8ld0AXT/mnVjS4VslzGu1FqILp2o5yc=;
        b=jgVt4uZ9PLHe+hmeun1/jPqScX4qhwTKHYfpCh5O3n1ifEzBfVqUCSO4Hwu/uXDtv/
         HZ/B6h+btqRRvNNxzQjdUbSLpw+oSt6B6tQd5z4R2qPkGxEDdp83E80voQcAr1C+OwvY
         b/3xRt/ZpupOnppoFfs2P0vuWKaJQKLkENYCsrsyVd0jGaGRaBfu2DNzW3gvworW7Psg
         GHkcdDgihnUx/GT3liGGnaZ/rdBAvZ+lgIUDRm0Mbyjyr8xEO4sPu/RbA0K/8vaqTFjX
         nuo33cznlTzrDtzN9A5Lasts4s9gbY65IWi1a1saB2ZUlsGt00QBOIPNi2h6r3nvjXGN
         rxiw==
X-Forwarded-Encrypted: i=1; AJvYcCV9jfp2tUN6hJ36hLK60NQTN9gS4zOb49PjdjivE2d+1THVikzh6KXpLSnuZG1DYL/OQqrPTcrY46dEkG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFuWuvpvi2FUwvuoTrSOJs4jLSw3zBvOZrHLHgrp+DgDNQ6ph5
	y+EvK+KnadfxZcLA4Z7TCLzz+smsaJWDOzFItM3WuH5rPvEnBr9Lrukn7gvfSXup0liW4PmT6kU
	1FrdaNA==
X-Google-Smtp-Source: AGHT+IHiEXultMrBzWQBw6MQatdUadNItuUPOf3mN9tETlZpsd9HGNR80a/bTNqX66s75+oFG4xEuoH7iS4=
X-Received: from plcz19.prod.google.com ([2002:a17:903:4093:b0:297:d486:2aa3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e783:b0:262:cd8c:bfa8
 with SMTP id d9443c01a7336-2986a741baemr8297665ad.34.1763076943007; Thu, 13
 Nov 2025 15:35:43 -0800 (PST)
Date: Thu, 13 Nov 2025 15:35:41 -0800
In-Reply-To: <ellmjkhqmgpsbhc4if3emhn3fzbqd3ji4u2dnyvmub6bjgfnti@vtvjhn5cjwrs>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113225621.1688428-1-seanjc@google.com> <20251113225621.1688428-4-seanjc@google.com>
 <ellmjkhqmgpsbhc4if3emhn3fzbqd3ji4u2dnyvmub6bjgfnti@vtvjhn5cjwrs>
Message-ID: <aRZrTdgOagDSjrUO@google.com>
Subject: Re: [PATCH 3/9] KVM: SVM: Add a helper to detect VMRUN failures
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 13, 2025, Yosry Ahmed wrote:
> On Thu, Nov 13, 2025 at 02:56:15PM -0800, Sean Christopherson wrote:
> > Add a helper to detect VMRUN failures so that KVM can guard against its
> > own long-standing bug, where KVM neglects to set exitcode[63:32] when
> > synthesizing a nested VMFAIL_INVALID VM-Exit.  This will allow fixing
> > KVM's mess of treating exitcode as two separate 32-bit values without
> > breaking KVM-on-KVM when running on an older, unfixed KVM.
> > 
> > Cc: Jim Mattson <jmattson@google.com>
> > Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/nested.c | 16 +++++++---------
> >  arch/x86/kvm/svm/svm.c    |  4 ++--
> >  arch/x86/kvm/svm/svm.h    |  5 +++++
> >  3 files changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index ba0f11c68372..8070e20ed5a7 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -1134,7 +1134,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> >  	vmcb12->control.exit_info_1       = vmcb02->control.exit_info_1;
> >  	vmcb12->control.exit_info_2       = vmcb02->control.exit_info_2;
> >  
> > -	if (vmcb12->control.exit_code != SVM_EXIT_ERR)
> > +	if (svm_is_vmrun_failure(vmcb12->control.exit_code))
> 
> This was flipped, wasn't it?

Ugh, yes.  Hrm, I'm surprised this wasn't caught by svm_nested_soft_inject_test.c.

Oof.  We should probably also extend svm_is_vmrun_failure() (in the future) to
detect any failure, e.g. VMEXIT_INVALID_PMC might be relevant soon?

> >  		nested_save_pending_event_to_vmcb12(svm, vmcb12);

