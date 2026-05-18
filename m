Return-Path: <linux-hyperv+bounces-11005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAeXIS9mC2qnHAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11005-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 21:19:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09690572CC7
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 21:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0DA73028136
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047B9381AFA;
	Mon, 18 May 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cli+TAqX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC030CD82
	for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131867; cv=none; b=Mke5RO+5UniMunAib3FSpnc4BDVyezxjTkH8AJQHA17etn4G0bTYJKRO47Mepto+Duxkdpclu5sn4plYTBgwpSh4xi47Kar9tssWaNyjQryXwYgigrz9l+oIkFKodni+zcTyit5729xbHLTBIyEpYMLuf9ltRhTFlWvU6qd8U1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131867; c=relaxed/simple;
	bh=ofODDOkkvzbqdsQg3gi+Qv4QDhxERbrkRCRKD59JhLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BGbG+L33FESaWCPUkBPGTPIoKFa6qk92g/0YGBRLv3Qpgnl546Zce/2ezGaIk3+aeS6UYYhAP5mSxGc2Mi40CJJdLfppspz3GC6USCJwlimV6b2lvjlt6iQd7ysoPDLkZnlvxwzZ8bVE4W4stp9Pm9+ytMXEINGNKu0fQUgzW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cli+TAqX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so1439288b3a.3
        for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779131865; x=1779736665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=byBkYmeeTqdoqUtx0ontJmxUgTZsHoHtMo8LuZGH+UU=;
        b=Cli+TAqXCViUlXtCdR01HGVvn3bQZ2OcmiY3ryOU5ihbuamxm+i+UYWypc5IjHVeMb
         sn9yBCYW06BdfDkJaBDzDPxQwXyTXouXUuRXg91pgzz5553qdjDuvaz8hGlsAjI/5wis
         7X9vIx8xrJBUNPcw3I5NEgomi86b6aONZ49GZz4mCes2cvrkBKMwWcXwFeuH0DhumHzB
         jz06xguvcUQapf7VbPn7Z2EPh1PGXESVUrnmNVW/DHppz/AoN6fz2wakdlje0QhwnqZC
         ZYPZOyn9+yVXAf85QRDJiW83lS//LGNp+1X3zZwUANDJAHfCs3N3u8eJd/kEhc0Wg5OT
         L80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131865; x=1779736665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byBkYmeeTqdoqUtx0ontJmxUgTZsHoHtMo8LuZGH+UU=;
        b=n2Q6QkLCMF8m5QVVceXroG01WtE30qMHBiCn35qD0/hUNH8C78dJ3wbIErm2MiCiOm
         4PunhcNLEVqHY2FTE49KlnuNjPahGs+JMy7Gk2NEhTWfdIPoNrtqsffHkHX6XY85WKNt
         dsUxFEtbtXKoMtmtqb4gKW9WUOjpsFAMKPUryAXh74PEvF+Wbs5XSduKQ2UEDDKR/fVO
         AGsfkU/gP0XbQXfAOhHxdWD2gtueoeiA6DOm7DN3YWiL2oiodOCbg8oPUwi+T/vhLe2L
         R5BX3sjwHeQtXClNWY3cREEKtEjxJfPyftlcCH4WyiOgGhAWde+YLu6UwM1outWZ+NsN
         hGZQ==
X-Gm-Message-State: AOJu0Yy3+PHmbyc+xgx2Ak2Bcz9TKg70R6ZMOk+TktrhNst6fWHkdfwI
	+90F9KkNv+V7e/STQGzQHBLkhsRRP1mW9Y2TeQkrKqEFvZchU848lkUuQeMhRx2SeMnymzzBlqz
	qtUABXw==
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:82f:344e:386a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3010:b0:820:2f9b:fe31
 with SMTP id d2e1a72fcca58-83f33cf0645mr17477098b3a.30.1779131864734; Mon, 18
 May 2026 12:17:44 -0700 (PDT)
Date: Mon, 18 May 2026 12:17:44 -0700
In-Reply-To: <20260515201628.9E3C5C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-33-seanjc@google.com> <20260515201628.9E3C5C2BCB3@smtp.kernel.org>
Message-ID: <agtl2L4Y_jE1MAai@google.com>
Subject: Re: [PATCH v3 32/41] x86/tsc: Rejects attempts to override TSC
 calibration with lesser routine
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11005-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 09690572CC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Spurious WARN_ON stack trace on every boot for CoCo (SEV-SNP/TDX) guests under KVM.
> --
> 
> commit e57255e4d076143a67d0e6e44f914aec31aed8c7
> Author: Sean Christopherson <seanjc@google.com>
> 
> x86/tsc: Rejects attempts to override TSC calibration with lesser routine
> 
> This commit adds a sanity check when registering a TSC frequency calibration
> routine to ensure the incoming routine is as robust as the outgoing one,
> rejecting it with a warning if it is not. This prevents replacing a trusted
> calibration source with a less trusted one.
> 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 98bef1d06fa9d..7a261214fa3ef 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1319,8 +1319,13 @@ void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
> >  
> >  	if (properties & TSC_FREQUENCY_KNOWN)
> >  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > +	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
> > +		return;
> > +
> >  	if (properties & TSC_RELIABLE)
> >  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > +	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
> > +		return;
> 
> Will this cause a spurious warning stack trace on every boot for CoCo
> (SEV-SNP/TDX) guests under KVM?
> 
> For KVM CoCo guests, CoCo registers first via tsc_early_init(), setting both
> TSC_FREQUENCY_KNOWN and X86_FEATURE_TSC_RELIABLE.
> 
> KVM then registers second via kvmclock_init(). At this point in the patch
> series, KVM only passes TSC_FREQUENCY_KNOWN, so the properties & TSC_RELIABLE
> check is false, and it falls through to this WARN_ON. Since CoCo already set
> the capability, the condition evaluates to true.
> 
> I see this is fixed later in the series by the commit "x86/kvmclock: Mark TSC
> as reliable when it's constant and nonstop", which modifies KVM to pass
> TSC_FREQ_KNOWN_AND_RELIABLE on modern hardware, preventing this warning.
> 
> Could the patch ordering be adjusted to prevent this intermediate regression?

Ah shoot, no.  Well, not entirely.  Because when running as a CoCo guest with a
trusted TSC, the kernel needs to prevent overwriting the TSC calibration, *period*.
I.e. changing the ordering will eliminate the unwanted WARN, but it won't fix the
underlying goof that the trusted calibration routines are still being overwritten
with untrusted routines.

Hrm, the SNP secure TSC code complicates things, but I suspect it's broken.  If
it's indeed broken, then I think we can add a TSC_TRUSTED flag and then do:

	if (WARN_ON_ONCE(!calibrate_tsc))
		return;

	if (properties & TSC_FREQUENCY_KNOWN)
		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
		return;

	if (properties & TSC_RELIABLE)
		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
		return;

	if (!cpu_has_trusted_tsc() || (properties & TSC_TRUSTED))
		x86_platform.calibrate_tsc = calibrate_tsc;

	if (calibrate_cpu)
		x86_platform.calibrate_cpu = calibrate_cpu;


Tom / Nikunj,

Isn't it completely wrong to assume the CPU frequency is the same as the TSC
frequency?  The changelog says the difference "does not apply", but that makes
no sense.

    Use the GUEST_TSC_FREQ MSR to discover the TSC frequency instead of
    relying on kvm-clock based frequency calibration.  Override both CPU and
    TSC frequency calibration callbacks with securetsc_get_tsc_khz(). Since
    the difference between CPU base and TSC frequency does not apply in this
    case, the same callback is being used.

E.g. if the host passed through APERF/MPERF, then the difference most definitely
applies.  If TSC != CPU frequency, then knowingly using bad data is even worse
(far, far worse) than hoping the untrusted host is playing nice.

If the TSC and CPU frequencies are somehow guaranteed to be the same (which I
can't possibly imagine is the case), then the above won't work because we also
want to prevent overriding calibrate_cpu().

