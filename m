Return-Path: <linux-hyperv+bounces-11377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ImMKG3SGWodzQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11377-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:52:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE83606DE7
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5A736AAE66
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A53F8712;
	Fri, 29 May 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgiUGXrj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32D3F86E7
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073978; cv=none; b=QWgjnxE7tveczPr68zFW6DbmU5Y+JyLa+DgH0lR3FXBMW7Z1JMYAyiYZqspvbsHg5NJCUj5nIvnR2GVBqCpezP4z9tdBbmujYFKL7mNmD+2tsL6thDqrMe/70oJXBfYqihXnUgfZkIzeS4IUMWA/2IAwC6zQbvVmKlEJ1GJnV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073978; c=relaxed/simple;
	bh=QxzH5176QV1Z3ehduHKIGQu/MHoL+J9s1KmhHLaMQYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSqkw2GnszXPhfPWOzUhibo0u7lbDC0e0HKgXakyqCwctT0Ofq7e143cfwiMNY8FtLPVgspfvx3s6lZq5c6mwqW/BYH2W9aVK8Bt7qslGbFITTCf8OXc9U5oCPYtqekyA3HUp+8QKTCs44ztk97Sl4M8n/EKvlAH0cGnlW48Upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VgiUGXrj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so293067485ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073977; x=1780678777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIfZI+15eXnt1VS1ntObygvWhZxyllpwUaeyj935Nek=;
        b=VgiUGXrj0kd28rwfhj/jVylcMGnXjPfEfylZt/hA39rn478ou6knrVrt9+G1CcG2wi
         Z1xmQSMlMziHsQjtrthewzgojDF6zTRCIt7HoqbduDWNOlX05oYqnYchpHDHCXscYs26
         UzzXbT2YLco6l34+wacQU5tbfnCen22Oq+pbXKITzmvEAWX4+baJY7sY9j5uNcOTt9Fj
         n4PMhfGLlFJjZwNu7tXT0LT6SXBcx5lJC9ScHfh8I9Gz8LKWS85sldtvMuzO5eij9Iqr
         uG6x6W+aeP/hZdySoAYRXe2QQtiBJ2/uSnZz2jkR7R0r/pGmtBJmh4qXb4yBSUjNbmvB
         gdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073977; x=1780678777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIfZI+15eXnt1VS1ntObygvWhZxyllpwUaeyj935Nek=;
        b=S/62WzQAnKXnxPYfLN6OJ1/AZyI/18PG0I4/LB3Wf+/Is2sQxFANnsrctvXWoi6P15
         lKlUnpZcH7Ug0zJIi219vLFP/T8dpzwPfGIceNAWS2QyI+fGh+kF4XvBQYzvnLU+DPRR
         CWku0cplZ0IR/WJneRKvye47nYzqR1tISDJfD5lMFy3EFF07T5KZ7gYdKI4BeLWCGWhV
         9v4sSeHGjmVgf7xyViNx5orBaQPx30h7AQ9j8FSAE/+U7QXUhjnaLuAEL5RRrl/jwASW
         EtZrhtoxxjQAEeh5NFQiUI2OjTvtO+ja61K5PHIhInA+eqUhFx4YPnfJaJ3DCepVru8J
         KR1A==
X-Gm-Message-State: AOJu0YzkfIJkB1Q7CkS4TKbFRLjnODZtw9fPL5AbymqWKn9mvt4DM+OI
	7iCKj3DmZwHe2HEhsBleDY7UzYiEX2KLxZtNBf/McGUAySScgOvYtiC8EVpIjO32kKpS3QzWARm
	o7AS3VA==
X-Received: from plry22.prod.google.com ([2002:a17:902:b496:b0:2bd:9e64:2df1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78e:b0:2b4:5cea:f61c
 with SMTP id d9443c01a7336-2bf3679355bmr9901385ad.4.1780073976883; Fri, 29
 May 2026 09:59:36 -0700 (PDT)
Date: Fri, 29 May 2026 09:59:36 -0700
In-Reply-To: <20260529162111.990441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-8-seanjc@google.com> <20260529162111.990441F00893@smtp.kernel.org>
Message-ID: <ahnF-FehodVd474X@google.com>
Subject: Re: [PATCH v4 07/47] x86/tdx: Force TSC frequency with CPUID-based
 info provided by the TDX-Module
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11377-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EEE83606DE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 2b8f94c3fcc7f..2603f136e29bd 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> 
> [ ... ]
> 
> > @@ -1550,6 +1551,8 @@ void __init tsc_early_init(void)
> >  		known_tsc_khz = tsc_early_khz;
> >  	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> >  		known_tsc_khz = snp_secure_tsc_init();
> > +	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> > +		known_tsc_khz = tdx_tsc_init();
> 
> [Severity: Medium]
> Does this structure accidentally bypass the TDX APIC timer and TSC capability
> initializations if the user provides the tsc_early_khz boot parameter?
> 
> Previously, setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE) was executed
> unconditionally in tdx_early_init() for TDX guests. With this change, 
> tdx_tsc_init() is skipped entirely when tsc_early_khz is provided due to
> the if/else if chain.

Drat.  But this isn't benign.  I don't see a better option than biting the bullet
and ignoring tsc_early_khz for Coco guests, e.g. in the SNP patch do:

	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
		known_tsc_khz = snp_secure_tsc_init();

	if (!known_tsc_khz)
		known_tsc_khz = tsc_early_khz;
	else if (tsc_early_khz)
		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware\n");

and then this becomes:

	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
		known_tsc_khz = snp_secure_tsc_init();
	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
		known_tsc_khz = tdx_tsc_init();

	if (!known_tsc_khz)
		known_tsc_khz = tsc_early_khz;
	else if (tsc_early_khz)
		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware\n");

At that point, I think it makes sense to double down and ignore tsc_early_khz if
the hypervisor provides the frequency.  It'll yield cleaner code overall, and
will be easy enough to document, e.g. to end up with:

	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
		known_tsc_khz = snp_secure_tsc_init();
	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
		known_tsc_khz = tdx_tsc_init();

	/*
	 * If the TSC frequency wasn't provided by trusted firmware, try to get
	 * it from the hypervisor (which is untrusted when running as a CoCo guest).
	 */
	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
		known_tsc_khz = x86_init.hyper.get_tsc_khz();

	/*
	 * Mark the TSC frequency as known if it was obtained from a hypervisor
	 * or trusted firmware.  Don't mark the frequency as known if the user
	 * specified the frequency, as the user-provided frequency is intended
	 * as a "starting point", not a known, guaranteed frequency.
	 */
	if (known_tsc_khz)
		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

	if (!known_tsc_khz)
		known_tsc_khz = tsc_early_khz;
	else if (tsc_early_khz)
		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware or hypervisor\n");

