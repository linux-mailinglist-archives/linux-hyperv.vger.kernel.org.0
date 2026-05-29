Return-Path: <linux-hyperv+bounces-11382-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAZ5LPfZGWoAzggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11382-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 20:24:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39405607358
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 20:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24C7D3015D14
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13940757B;
	Fri, 29 May 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5KfO4tR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F53ADB91
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079093; cv=none; b=es+nk8w1aujj7voqtUvjeJpCSggp/KGRqmUCEqoVy0rYT7Dm0D617qayDx2u7FYVcWvfPM/mpETpojI8LgmCzy/azHnpRjY2AMHBXLvTKxgYX/bffMDbSQ/FNsG/gDFRhQTArY4byIj7QW13jeBrGIAj8TxVOO0ABTA39GxgnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079093; c=relaxed/simple;
	bh=UeHE8FngsFzOqtRt38sTx5XiaHaRF+B7JZgy2Sp2ZT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkoXE+jLVchdxDqxGHL32UsE44xPh+V2dkBB+V6TyTWFIr57d6IaB/vqY3lgKAGvPvX/EL2gleWHYJhFgvCO/xFbubyEps3vJVL3vtOzIjFAXVYTf7WFE9sik3i5WTL/Icdu5fH8CM31R62IciHFMvhCNq5wCsj8Rl2eUSG2nUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5KfO4tR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c477290bso8147279a12.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780079091; x=1780683891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KC7JwfT5evfbnVHlmq0f2yFu9P+G1LslL1SBdd7A1I=;
        b=v5KfO4tRWWgX+5juf+yF6I+RRd0W6GeOAlLS5sZciCbpVWxlQEOho0r1iBU906bBxe
         Ej60RkHpjNwBJz15nHFvtYN6ehK5vuM2ePlOV1Ka1VtXxB21QfkG+MkBdkfiaPTfLqM7
         TZRQFAYlVt0C61osKiTuD202AguBbBF9P0zrqMRLuA7bQn2jjhk/6pudNmCOWhopbcum
         y1+NajxnPvAUHJpKTPdpVS2UHYPs+ZnP4YBAfbIXDnJMc8NmkaokgWenSeytyn3J4C5h
         +TfYQK1mhQqBrv6xp8tPDnzoVhHA7+DIwX2V9ZtMRuBgSd7h25/hjpAgQwfY/1Ekj0zu
         ZJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079091; x=1780683891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KC7JwfT5evfbnVHlmq0f2yFu9P+G1LslL1SBdd7A1I=;
        b=YD5F5HygV+WomG20qNuUyH0HgBQeDqT32S54e1TSJ8zfcMF7zmlKows4hj36cZPPJN
         6mPHlf6JToc6fJHx/TQNJpHLo5bXgvzoau0hJncPMR+QcPPkPv1u+5H5IKYEbVBvgWQ4
         GwFWG8vy0ui/qWMGlXGv+5uS+HV8edtKAT5NyEJDJ6DLJjGl0prIxYjqyqm+BKD+vrmJ
         viFoDMxGUlGWUmpqfYXSCCRCaNseyOVvBdp1hzCU546H4eOUKmudjH9wZDNskhM5Qe1b
         ICS1fNKQJ3sgxLhtIIj4DcYPNfL2Agi4YpTli9WHkKyFdDfF1sYxLGZXgH6LiDsIbX1O
         5Cbg==
X-Gm-Message-State: AOJu0Yw3BLmFMNbfqWN1oMU/5ZufGPMHUUuIMuO7w5yPoDhNCjKhde8q
	+MG1ihS9e4TWaIFhW+hR+DcMRjqdlq5nB9hVvKUTaQvKoFd9xNMGt5ygbFTHNF5T1kRleG7OxFx
	XqCdzxA==
X-Received: from pgnb26.prod.google.com ([2002:a63:715a:0:b0:c85:71af:a857])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:189:b0:3a2:c683:fa84
 with SMTP id adf61e73a8af0-3b427f6d141mr406494637.27.1780079091312; Fri, 29
 May 2026 11:24:51 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:50 -0700
In-Reply-To: <20260529181207.5E7D81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-19-seanjc@google.com> <20260529181207.5E7D81F00898@smtp.kernel.org>
Message-ID: <ahnZ8tuHFVFTeofW@google.com>
Subject: Re: [PATCH v4 18/47] x86/kvm: Get local APIC bus frequency from PV
 CPUID Timing Info
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11382-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 39405607358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 4fe9c69bf40b3..c1139182121d5 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> 
> [ ... ]
> 
> > @@ -1039,6 +1040,13 @@ static void __init kvm_init_platform(void)
> >  			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
> >  			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
> >  		}
> > +
> > +#ifdef CONFIG_X86_LOCAL_APIC
> > +		/* The leaf also includes the local APIC bus/timer frequency.*/
> > +		apic_khz = cpuid_ebx(timing_info_leaf);
> > +		if (apic_khz)
> > +	               lapic_timer_period = apic_khz * 1000 / HZ;
> 
> [Severity: High]
> Could the intermediate multiplication of apic_khz * 1000 overflow here?
> 
> Since apic_khz is a u32, the multiplication is evaluated in 32-bit unsigned
> arithmetic. If the hypervisor reports an APIC timer frequency greater than
> ~4.29 GHz (apic_khz > 4294967), this calculation will silently overflow.

Hmm, easy enough to use mul_u64_u32_div() (I think that's the write helper for
this?).

But this problem pre-exits in almost every other path that sets lapic_timer_period.
So while I tried to avoid doing yet more tangentially related cleanup, it seems
like adding a helper to set lapic_timer_period is the way to go.  That would also
allow making lapic_timer_period local to arch/x86/kernel/apic/apic.c.

*sigh*

