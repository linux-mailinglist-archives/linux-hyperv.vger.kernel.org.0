Return-Path: <linux-hyperv+bounces-10981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFUBDHSfB2rP/QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10981-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:34:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D0558EEF
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D563036EC1
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C13F44FC;
	Fri, 15 May 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTKv+1wG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43D37BE8E
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884158; cv=none; b=QRQZ6KGt9sHhbpXRWZyV0ohunJlFS5w3UI40wYkmjaSEBw+v4tFPP6YcRffnBfTNw+LO45R7FDXj3hlTAGyoNVME8xh2yPDtsIX3M1CBJFj2H4FPxsd41JPmeNOGGbA/Yrzfzuvle7DQsHXr0mTH1uBXszNU2kJu6oNUU96q6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884158; c=relaxed/simple;
	bh=3kBs+LoK/41x7KTyqa5sAHIy4wlL0hqntfKNUvehlXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yr7va6FEAPmxz3p+PHF0lG/7jObBIF8cm90IWTS4JOkB3RUloKBVUsD5RejqIPy24pHwweWEi3GYUxQwWfBKUsXPdTjlZfi/U7GZvCYmg161nKboifkpKVD488vmlbey3Q00ha1b2wvmqzY8pHD6oIPvdNXN9uisVD8mTNx4wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTKv+1wG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c829366cf25so379101a12.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884156; x=1779488956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJEFaPkKBrp+ZhLTHzWdmAHs7LO5UggosySgozYIFoU=;
        b=bTKv+1wGONPYNf5K9rQAOCM6BWyw4TVLJGDtWZ0hDL+ukwxCJV5brNH9rYpWAzvzWH
         AkPFqtyQdvAnt0NCLN0Sqgro0hLN8Qr+Uw1zaY/Ox3/stKbretrBlwlGMwJRJbX/iC50
         +oXHQ7VxEaAUjPygesOigNcbOgBYlw4My+NaLpCguqxi/5LRVa5mfH7uXmXyjmjQcGtq
         RcheIfJksIyGBKDd9kEsmyyXoMoWI5vae+TL6aS9AXOuJvoVr0LSPD2Y3JS246E7nJNe
         usmn4MUyEgIqs2hlvZYudnpBjRUwM/RUDYI7yYccU5AUCYAg22AIwjRpvcBe9+yYqyMj
         7BSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884156; x=1779488956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJEFaPkKBrp+ZhLTHzWdmAHs7LO5UggosySgozYIFoU=;
        b=P5TQuRyQ76nok2frHYKamW1skWisJdUvQ5PjQZ3PQTlVxqQ7GZU9O28g2Seg01rSQn
         wg3dFRG4PPWDWH0EtBFA1oesW9aSqELlhXQDzEWlSfse/CnP4dLsKGTiYrsPQP+UvaWn
         3owVn4H4Ga2S2B/IQi7lXvCaK9dlEj/yx+thxcylcrmXkc3jsaP9VZm8fxFubug3Inr+
         QUQxnBlTTihmiCYg+N7jEfvUdQDEpr93WvbHfCILKQOax5InNAIns8TmI/TdvAZfc4rj
         6s4ED0QSqD8EAE+vNPLC7/nX4Y/IHcNRqGzz6dM1WMGeH7iiy0DvbkYHSw3WubGQMs59
         wazw==
X-Gm-Message-State: AOJu0YwI7SqkWGLpAU4Sp1CU1vs4vXF36Z369v06Nwl3Ejek8HUI2ICG
	WnqAlcroZCNrLFaxvmf8twLYyOGS2uFmNEaj5EzhD0OCPh9ZfjAnnTMewPgdc3jeuJJUpy3H4G9
	NsrH4lg==
X-Received: from pfoo19.prod.google.com ([2002:a05:6a00:1a13:b0:82f:20ed:8059])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3028:b0:82f:2243:e445
 with SMTP id d2e1a72fcca58-83f33d9dc40mr6348229b3a.32.1778884156219; Fri, 15
 May 2026 15:29:16 -0700 (PDT)
Date: Fri, 15 May 2026 15:29:15 -0700
In-Reply-To: <20260515203447.ED0E7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-12-seanjc@google.com> <20260515203447.ED0E7C2BCB0@smtp.kernel.org>
Message-ID: <ageeO3P0Nc3Fji48@google.com>
Subject: Re: [PATCH v3 11/41] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 8B5D0558EEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10981-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index df95516a9d899..006e3a13500b4 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> [ ... ]
> > @@ -178,8 +178,22 @@ static void kvm_register_clock(char *txt)
> >  	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
> >  }
> >  
> > +static void kvmclock_disable(void)
> > +{
> > +	if (msr_kvm_system_time)
> > +		native_write_msr(msr_kvm_system_time, 0);
> > +}
> > +
> >  static void kvm_save_sched_clock_state(void)
> >  {
> > +	/*
> > +	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
> > +	 * If the system is hibernating, then kvmclock will likely reside at a
> > +	 * different physical address when the system awakens, and host writes
> > +	 * to the old address prior to reconfiguring kvmclock would clobber
> > +	 * random memory.
> > +	 */
> > +	kvmclock_disable();
> >  }
> 
> Can this lead to memory corruption if another clocksource overwrites the
> x86_platform.save_sched_clock_state callback?

Yes, that's why the kernel only allows one "main" hypervisor.

