Return-Path: <linux-hyperv+bounces-11375-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLNXLAXMGWqNzAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11375-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:25:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 177AD606664
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 351FA3289AB7
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AD636606B;
	Fri, 29 May 2026 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3bfTX4J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF33DDDD7
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071812; cv=none; b=KvP+oC9hGukZKvGrJlkxlCCgaCX3fU3F2Y2OEJkBlXEqVVKJ+fhnY2+5Oa/kEOrkvD93gzuIMRVMZRYN3DTb6PV96CGKWoTrM7Cyd8UaDcEV8WULH2AgZMoYF6xkF07KZICjEKZye5kb3ttDmFSND42qtEETa8D3Xz+g+HYLpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071812; c=relaxed/simple;
	bh=pSxoxMhbYF7BHHLDnIxxdXcvcxE9JP52g/U+97KRZUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GoanLh6rw21VxUBD8pz1ZcyffGrosrb+cIZ/k0btc7gFVAXZVWgI4M8gPWU5us2v9eA+Rmdf0kFWUithKqGn5adCFX9ZjxQbPGms5IWXF8bCz4aZu/vnPu5LxbJSAgD9ICHX4+EuwnCAC6eZQhvNT3KV8P8Z//v5fvVEuoMWo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3bfTX4J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso145806385ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780071809; x=1780676609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Scb9q7Vc7fjy0mJZyLF9pe8pDeFrn1cuBRV6rD40tUE=;
        b=K3bfTX4JecjtDE7MfJqXzQm3x4yY69RoAe4V3aqDIMxepXCDzugj1JrKlN0ZbLIr+K
         w7ccArh4rpSNoWPETw2qhH/3YYkvuvj5wTVwb3v9HTNDsdpF8YToQUJren2rQC2c/P9D
         jn+c7S8+9cNvHhD+3quTo3H6NBh11CPP8EZHQ2sF4qHTepFsKQ9k7f/kDAlhjaatlMYm
         QroWts9Wiv2kOWdaCV/DS0yUfWBzlR4aiMl+dAlEJ2689cKcT5st9OiK/44XOT1R0t3k
         HX5A8pQiXtmbLENbFksRV7wmTQlNwhzT4FaA+xFfMFKG6aKud7L/oO2fLcXYC2KyVcRa
         oz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071809; x=1780676609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Scb9q7Vc7fjy0mJZyLF9pe8pDeFrn1cuBRV6rD40tUE=;
        b=SfnyMHlFpY7NjiGTxrJ5lJ4a7Six0j2XTy84G8tHS0lJb5nnUfTeUHB5fKs3NoIx/1
         scKPvJfKQi3vc3tFg/ipwUKkcoAP13bN0Ev5JJsdAUe1IXHq72B71htP8SpM5aIHslTD
         Uqp0uy3aanvKWmGIWEr4RMvdpC+LIyLNfbit1PTENwgiRTCHbabpCEKnq1Jo24d0kAml
         Y6HydNca38u1Ea5CpbWel0mR8gTVz5QBLHNgYG0xhprAUBLcUTA0KkVNL9VgHJdhy7yP
         CT9FQHqm7OnXmCun4h5V640GJM/QmnzboQIqM+FiiokoAiMnSkEZPI7UhsHJVayKJJLf
         oXWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tdIoh01zJ78315fZd2VANpVG5kt+YY4RZRe8IDNwAC+2VtzNv4yA8E4QIdkV0sCmIhdABvpcxBPH2rW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRub55S/QtoXw+8SDEhMDpjjzDy8aYBQDAdyAQOXS5lQKl3oll
	O7GYFMukzAwMTplHGvT4Y3iHGk9oeotdIzTQECmrl7Kf6tCN3R11j5uz5X1pAeVQybVNYI8ehaC
	FBv3LKg==
X-Received: from pgct19.prod.google.com ([2002:a05:6a02:5293:b0:c85:746c:1066])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c6:b0:2bd:9c0a:32c
 with SMTP id d9443c01a7336-2bf3683b78dmr6175505ad.19.1780071808895; Fri, 29
 May 2026 09:23:28 -0700 (PDT)
Date: Fri, 29 May 2026 09:23:27 -0700
In-Reply-To: <20260529161442.754A41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-7-seanjc@google.com> <20260529161442.754A41F00893@smtp.kernel.org>
Message-ID: <ahm9fwLDnnby9q0k@google.com>
Subject: Re: [PATCH v4 06/47] x86/sev: Shove SNP's secure/trusted TSC
 frequency directly into "calibration"
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11375-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 177AD606664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 833eed5c048a9..2b8f94c3fcc7f 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> [ ... ]
> > @@ -1537,16 +1538,20 @@ static void __init tsc_enable_sched_clock(void)
> >  
> >  void __init tsc_early_init(void)
> >  {
> > +	unsigned int known_tsc_khz = 0;
> > +
> >  	if (!boot_cpu_has(X86_FEATURE_TSC))
> >  		return;
> >  	/* Don't change UV TSC multi-chassis synchronization */
> >  	if (is_early_uv_system())
> >  		return;
> >  
> > -	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> > -		snp_secure_tsc_init();
> > +	if (tsc_early_khz)
> > +		known_tsc_khz = tsc_early_khz;
> > +	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> > +		known_tsc_khz = snp_secure_tsc_init();
> 
> [Severity: High]
> Does skipping snp_secure_tsc_init() when tsc_early_khz is provided omit
> critical CPU capabilities?
> 
> In the pre-patch code, snp_secure_tsc_init() was called unconditionally to
> set up hardware capabilities before determining frequencies:
> 
> arch/x86/coco/sev/core.c:snp_secure_tsc_init() {
> 	...
> 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> 	...
> }
> 
> By chaining this into an else-if block, if tsc_early_khz is provided
> (e.g., via the kernel command line), snp_secure_tsc_init() is bypassed.

Which is bizarre and awful, but in practice is effectively what was already
happening, because the kernel would simply never invoke x86_platform.calibrate_tsc().

I have no objection to ignoring tsc_early_khz when running as a CoCo guest with
a secure/trusted TSC, but if we want to go that route, I'd like to do it as a
patch on top of everything else, so that it can be easily reverted if it turns
out someone is somehow depending on that combination.

