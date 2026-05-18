Return-Path: <linux-hyperv+bounces-11009-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALmtIHh2C2o+IAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11009-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 22:28:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A4657364B
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64A8830219B1
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2F38911E;
	Mon, 18 May 2026 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjAeZUij"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEF38BF9E
	for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136117; cv=none; b=eXm2726HYRkKIv2UD8oFFGWm6eKcxQzh4b6ISJU9/XNgKNCf0Jcfx0LjieD/TZJwfCvtqLJ/xIMin+zAK7cFK4BAUflfQjFmwku3Wmob8EVjnhyBbeBvpEAk/FDE3nwXSM2ExznbskrOkn94jZqrtaTjug2IEzdqQ7bLUZkQyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136117; c=relaxed/simple;
	bh=hmHa3lERLAq0VNHm3jD5e+yPlQ3U2iPLROYP9DzeTNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRFzGYXnUThSxcG+xFSwg2dhm0PC+zO8CD7D9gpkXdfSUGc2OTAKxBWYR7B3CN0xCC8d1j8Jr6k2ISBPjxskLoWs0eqYL9QmDwS4XxbzSFQjFDNSG5/1p4Xm0A2HXYyDNPDliSfovZqVwnCwrHdXcHvf+p5vQYSg45DINa2UGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjAeZUij; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso6249900a91.2
        for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779136116; x=1779740916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1XaWuXLMM9xEhwF3D0/7qJrCIna4fGcfUBNTL97l5Y=;
        b=DjAeZUijHxycpmDhr8j6tkcMiuJp0M8qoPztYHAtCwPUo2TMPEEGFIcPGn4Zg0iaXn
         VgAcjTkJ+yDSpSNoSVKV7d7rroocNhVhvle39RoYiV3B9nCP/aonbS/J2KbwdDyGDd/x
         wIAAvvH2w3oEMi1emBsRc7j4kkKpsmQ7jCRtwaKfZ2NrsZdIu3qPlH5FUZx5YdHym7rN
         mv2u5+0xUBG/tNGz5/Ke0h7kQOz1tJ+Xyr1ejS9hWNhuzayEWDpNvSSl/2JhotU5uTxP
         +l+BoRCUucg52kgn0HfhqefZLgW9SwQO0cOLNA3Sl5eZ0dyKB0Uox28wibYoAtUqDjn5
         2zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136116; x=1779740916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1XaWuXLMM9xEhwF3D0/7qJrCIna4fGcfUBNTL97l5Y=;
        b=C2k7euyihGlsLjDi5+FFicypbce+tlK9ZdiKi9wTsDEdLE7VJo9j6E4mwBlZq1RmEc
         kilJz5BKxzoRGUr7336qDakwuQ+KYuhPUU0qb9ExvlSKhAlz0bDmDmJDc16GJg9Res8F
         X8Ufq9586Jg7eOMGwXv+B9bM6lZrmh3RirFOxZUXxPVu8g0mHTZwGLj/1D5hAwTx7N8h
         OOFUt1aUjhbqarFUgmDl64LF7QQtboaQfl3Z9kIFNsyB0YZ39dSdu8hDSXYLarUFhEmZ
         y9npzZ9Siwgk3fpENnR1mqqVahARNdL21p2iTy6tohgOBSL8D3thwezpaRrm1sxj2pWz
         dT7Q==
X-Gm-Message-State: AOJu0Yw75nTtG55p43IrKcj10MQiygWYvnCQdgf72FETj4Iz8G+T4MM/
	ZUXiCoENIH5rGX/tLRMFprKBlvemlFg6EqFF1LQR/MnL+bbeiWHxL1P7lPN2QAzgr+SQNDnCmE2
	5Ggd3oA==
X-Received: from plge17.prod.google.com ([2002:a17:902:cf51:b0:2bd:7970:b71f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3842:b0:368:147b:536c
 with SMTP id 98e67ed59e1d1-36951b75c26mr15658555a91.13.1779136115645; Mon, 18
 May 2026 13:28:35 -0700 (PDT)
Date: Mon, 18 May 2026 13:28:35 -0700
In-Reply-To: <20260515200929.19F2CC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-38-seanjc@google.com> <20260515200929.19F2CC2BCB3@smtp.kernel.org>
Message-ID: <agt2c3WXwLk23aeY@google.com>
Subject: Re: [PATCH v3 37/41] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11009-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 04A4657364B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Bypassing `kvm_sched_clock_init()` when `CONSTANT_TSC` is present
> ignores KVM's `PVCLOCK_TSC_STABLE_BIT`, leading to unfiltered backward time
> jumps in the core scheduler.  --
> 
> commit 57cf68835ef70733c037ca9ffa04fd39e1d70027
> Author: Sean Christopherson <seanjc@google.com>
> 
> x86/kvmclock: Use TSC for sched_clock if it's constant and non-stop
> 
> This commit updates kvmclock_init to prefer the TSC over kvmclock for
> sched_clock when the TSC is constant, non-stop, and not marked unstable.
> It does this by bypassing kvm_sched_clock_init and instead modifying the
> TSC properties so that TSC becomes the preferred clocksource.
> 
> Link: https://lore.kernel.org/all/Z4hDK27OV7wK572A@google.com
> 
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> [ ... ]
> > @@ -416,22 +416,22 @@ void __init kvmclock_init(void)
> [ ... ]
> >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >  	    !check_tsc_unstable()) {
> >  		kvm_clock.rating = 299;
> >  		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
> > +	} else {
> > +		kvm_sched_clock_init(stable);
> >  	}
> >  
> > -	kvm_sched_clock_init(stable);
> 
> Does bypassing kvm_sched_clock_init() when CONSTANT_TSC is present
> accidentally ignore KVM's PVCLOCK_TSC_STABLE_BIT?
> 
> CONSTANT_TSC indicates the hardware TSC rate doesn't change with power
> states, but it doesn't guarantee cross-CPU synchronization, such as across
> multi-socket systems or differing vCPU offsets from hotplug and migration.
> KVM explicitly signals this cross-CPU stability via PVCLOCK_TSC_STABLE_BIT,
> which is mapped to the stable variable.
> 
> Prior to this patch, kvm_sched_clock_init() was always called, invoking
> __paravirt_set_sched_clock() with the stable flag. This allowed the system
> to call clear_sched_clock_stable() if the hypervisor could not guarantee
> synchronization, enabling crucial per-CPU monotonicity filters in
> sched_clock_cpu().
> 
> By skipping kvm_sched_clock_init() entirely and registering
> TSC_FREQ_KNOWN_AND_RELIABLE, the kernel's native cross-CPU TSC synchronization
> checks and the clocksource watchdog appear to be bypassed.

This is very much intented behavior.

> If KVM clears PVCLOCK_TSC_STABLE_BIT, could this result in the guest
> ignoring the condition and using raw, unfiltered rdtsc() values?

Yes, that's the entire point.
 
Note, PVCLOCK_TSC_STABLE_BIT is still set in pvclock_read_flags(&hv_clock_boot[0].pvti),
so anything else that directly consumes PVCLOCK_TSC_STABLE_BIT still does the
right thing.  E.g. kvm_setup_vsyscall_timeinfo() will still set kvm_clock's vDSO
mode to VDSO_CLOCKMODE_PVCLOCK, to communicate that kvm_lock can be used for the
vDSO page, *if* it's chose.

> When tasks migrate between vCPUs with differing TSC offsets, this regression
> might cause backward time jumps in sched_clock(), which breaks rq_clock
> monotonicity and corrupts CFS vruntime and min_vruntime calculations.

Only if the host messed up and incorrectly advertised CONSTANT+NONSTOP.

