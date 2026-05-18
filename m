Return-Path: <linux-hyperv+bounces-11012-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNCABe2BC2pvIgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11012-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 23:17:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F778573B7A
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 23:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F791302EE94
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 21:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5039768F;
	Mon, 18 May 2026 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oi4FlO5V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5F4A3E
	for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138879; cv=none; b=honcMwK31p8BF0s0zrSCSY7YHhonyN2W6IbAqtttyUfuw2r29o3mf9+37y/kUdLDY1GJaVqR2tdor4gTPiNgOzOlyC3jV3CfgBiykgZcJG5izTrg8DzsBC1K7+adoSmST/3n1VcQwn+ylQ8lboAmyQtrwWpZ7pG1DNW7LmINfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138879; c=relaxed/simple;
	bh=6FgsMK20z2ieU5Def3pMwxUzvlyh5j56ZnCu7u+YAtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wq9HcFBu86yeGK5PTCV7SdB/VNL5cjaR78As+trmlntWOVRIB246lhPj0iSU9XQjT0DM1MwOvHnKfgG5ZRz+dhTizvbSpC+wP6GV3JvoLNBB4knoF5U/gnWm1i+xv0FogWFYuKuFzVhFQmRIqvItTQSwcFHBqPeIUfu8K39nOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oi4FlO5V; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83565161a6eso1298308b3a.1
        for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779138877; x=1779743677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zo21oM2VaVJk1wHkstVYW2kwV5RKdIS60liRPY2giE=;
        b=Oi4FlO5VopEZNJ1YAp8p/sIPwAMgFBH54hiRwWiwoWXaycinAU0n+1CNEh9gnhDvBg
         GGUxijD/ZU/3fInxGtzT3oAiXpDWrxEZhbM2QB66hZQzZFCRRkONKXvdRd0dGopgGfEX
         nNwIdTsjcpBjlIJwiWOof/J60yh7KwkAk8JuegIeughSQrJEf6qRgtUKDz1xok5Fr0Ei
         DUk1RX5iQ3KoQA4W/r0GRS+G32HYps5QuessEh32xoGGwKMbU0J8NS2QkEliaaJQZdvz
         70+As6CXgBb0krlZo7ronVemmlOwHSzkvEhcN9m62M1kj7dMPJh/nuOftQq96kQE1Pgc
         1Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138877; x=1779743677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zo21oM2VaVJk1wHkstVYW2kwV5RKdIS60liRPY2giE=;
        b=kWWtF8p7svXkBY/2h1zzZtoIjT7Szbq/TAq0V5zeZtfXUHcwl8EfIwGfhaUSguVr7o
         jIlQ2noaHBK9G2CyDCpGMP6pCJGopcKDGksyZnpLq5YYrtgj1QiltIRQaqqAmTEmToiA
         plQpqBH0b9TZlH6/L75UAMxvJaZPxveQbumI3RlKcbUanjsGmLTZwB8XOeiAaqGlixwt
         g7SYgTfqLsyavuQp1T5v3Xsk+bPWtYEYbm0GhKzvPdcbaqZuMJBabOjGFMtSLa9D6BBC
         SeOSD1gSE5unSQtURVNwz7i43+Qeyi2J+10y4BWV9Wj9MuZcuCuRKcxC5T65fEH2Q1eM
         Wx+g==
X-Gm-Message-State: AOJu0YwYiq54EVvt+DIUOuBcIFuZ5yWWokT/OCIYAueFwOVY9JuXIPPk
	bJeYGMeTneBwcWZLkWnqUuOsOBr/z2y0FM2p2inwnCvDvJGhpIG6Nw08VhNTZ9w3V/uQjINJRDs
	0hDtIyQ==
X-Received: from pfuj2.prod.google.com ([2002:a05:6a00:1302:b0:837:7965:c70c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a907:b0:837:f111:b70
 with SMTP id d2e1a72fcca58-83f18d5b89cmr17688828b3a.4.1779138876899; Mon, 18
 May 2026 14:14:36 -0700 (PDT)
Date: Mon, 18 May 2026 14:14:36 -0700
In-Reply-To: <20260515194804.AE30FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-30-seanjc@google.com> <20260515194804.AE30FC2BCB0@smtp.kernel.org>
Message-ID: <aguBPFuPX0ih_ybf@google.com>
Subject: Re: [PATCH v3 29/41] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11012-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F778573B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm_sched_clock_read is registered as the system sched_clock before its required offset (kvm_sched_clock_offset) is initialized.
> --
> 
> commit b6e429e4990c00d845488d46e8dc4132f3a2fd8b
> Author: Sean Christopherson <seanjc@google.com>
> x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
> 
> This commit adds a return code to __paravirt_set_sched_clock() to allow the
> kernel to reject attempts to use a PV sched_clock. It updates the caller
> in kvmclock to check the return value and abort initialization if needed.
> 
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index d3bb281c0805d..9b3d1ed1a96dc 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> [ ... ]
> > @@ -338,10 +338,12 @@ static int kvmclock_setup_percpu(unsigned int cpu)
> >  
> >  static __init void kvm_sched_clock_init(bool stable)
> >  {
> > +	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
> > +				       kvm_save_sched_clock_state,
> > +				       kvm_restore_sched_clock_state))
> > +		return;
> > +
> >  	kvm_sched_clock_offset = kvm_clock_read();
> 
> Could this cause a massive backward jump in system time if an NMI or early
> exception calls sched_clock() right after registration?
> 
> __paravirt_set_sched_clock() uses static_call_update() to globally publish
> kvm_sched_clock_read() as the live system sched_clock. Since the
> initialization of kvm_sched_clock_offset is now delayed until after this
> registration completes, any early caller will execute kvm_sched_clock_read()
> with a zero offset, returning a huge absolute raw clock value.
> 
> When the code resumes, it sets the offset to the current raw clock value.
> Subsequent sched_clock() calls will abruptly subtract this large offset,
> causing time to jump backwards and violating monotonic clock guarantees.
> 
> Would it be safer to initialize kvm_sched_clock_offset before calling
> __paravirt_set_sched_clock(), since calculating the offset early has no
> side effects even if the registration is subsequently rejected?

Hmm, yes.  I'll also add a comment explaining exactly that.

