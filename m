Return-Path: <linux-hyperv+bounces-11378-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJTFFFzJGWpzzAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11378-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:14:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E01EB606373
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C30F93148E5C
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B3336A36A;
	Fri, 29 May 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fm7RZHpu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6836CE03
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074063; cv=none; b=JqGXhxEANmEpw5RXKSAeGAI/p62QA1bpaGeaazR43+1EzAjh1iqO6EMQpjPG3sAjEclbq5T9CJm55iB/wbqNTcRAkzZkUj2vTXDZ6WygUt51L747fSfmDQ7m9Ijes9KLlOciisH5gLMy2DjuLuxhyMzeeYEF2cFQHqvPLQA/+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074063; c=relaxed/simple;
	bh=7H128GGtnqbG/RSkM/gC5mRXamm7xUEcaHyboBL1r7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qpW+i7td1l0dlKZbWnUCoSyVVzwv8kF1hxBDYIacFBaFsUHQNdErO2lp79cL0oJ2OPa41fc6ImxX8BR/ygwlH+/nBX3Tpanl4vl4PdtDwpxvemf9GQVO21MqghfGDfiS+2VBt7BcwgbD8KnA7ccZzxcR1UdRUzIi3N27T2YH+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fm7RZHpu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8584e3fc96so40778a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780074061; x=1780678861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8OtpbJnY1tjWi0GBlc3JoUE3xbaP0GTQHvl5kMixoc=;
        b=fm7RZHpuEQPD52CL/ZIhAaZSl52swfb3YpKY1KNCR+iFLhCg4SXzZpCRJ9RkNfqQID
         qEXuEyFrwMRvNRq4y4fTd+BcVXg3UpAaT1ajTPXQ4N70dqykhjlcBZaGKOibC+ZsMUey
         MvRaoC+wXWQrLArfxr/IwAOpIt83ntBlUx/j3Np+Gs2MnNIkH/JH2MxmBUaampAdrlYL
         5CtYCMaLqJcyEmJZC4LWz9HQtTg7cjpn+/iGFehDnUbmFqHVL5F2YQI2ewx6LdFE2JEF
         MeE0CsaHQoWGTfFOJZP/tikTURpT9B91qQqcfIGB+ZZ00DOUzS7ub1UgkqoyIVJ8rgoM
         ZtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074061; x=1780678861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8OtpbJnY1tjWi0GBlc3JoUE3xbaP0GTQHvl5kMixoc=;
        b=fpZ1E9Hy1qihNd0ctqzGkNMlX/qVAf0ck5wiVtiiHQIDTQeoO6YeVmu0KPTGZoLBud
         kQ3WyikAmi8ZlY5uFCSOuEMif8UVAAKHiZpvkVcwQXlatx2qsuzUgCiSyhbSGAI5/lg0
         9Wvb42Jbuo1MVcksj6JT5qSR6HhroYvj8ZGR91lWoN0Lv3IjBhOKSESMbJ5FL0BN/6Uz
         qEclpm56kOaUWL/N9Xv0zf1zraySJHTfI876u76veYWwohQmRVBlXSblHzet8+XjjMOx
         3GeFWkmO2CbyJfxzuUA5RLQfg5L+PdvG5SWe53T5CeIzZIgdI6QwI0IEYdsAr5UHVCX4
         ed7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/9ttGJn+7P1bLjtL+927UmaaYZzJyys//Wtb5RIj2fTYOJq0oJ5bY0YSlKRW5UJQiwRQy7DNaA64rVwOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7lWISDf8fguHBxkm3uXmEQo2atypynliIs3kSYP5LZjWivQB
	OUmMIZ84TBdaKDBdfMfubFjzMYUd6v4M3bPGmqEM3OKvs8QxN7y6supK1JWoqnub6YqKzpkalg6
	Z3Bctlg==
X-Received: from pglr17.prod.google.com ([2002:a63:5151:0:b0:c80:2656:4e70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:14c:b0:3aa:f9cb:d435
 with SMTP id adf61e73a8af0-3b4280140a1mr64540637.11.1780074061246; Fri, 29
 May 2026 10:01:01 -0700 (PDT)
Date: Fri, 29 May 2026 10:01:00 -0700
In-Reply-To: <20260529164019.519101F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-10-seanjc@google.com> <20260529164019.519101F00899@smtp.kernel.org>
Message-ID: <ahnGTF5uoihLfk1p@google.com>
Subject: Re: [PATCH v4 09/47] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11378-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E01EB606373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> > index ad8f2da8003b3..0303fe6a2efa7 100644
> > --- a/arch/x86/kernel/cpu/acrn.c
> > +++ b/arch/x86/kernel/cpu/acrn.c
> > @@ -33,6 +33,8 @@ static void __init acrn_init_platform(void)
> >  {
> >  	/* Install system interrupt handler for ACRN hypervisor callback */
> >  	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
> > +
> > +	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> 
> [Severity: Medium]
> Does this unconditionally skip TSC refinement even if the hypervisor fails
> to provide a valid TSC frequency?

Gotta love Sashiko's passive aggressive "questions".

> ACRN TSC frequency is obtained via acrn_get_tsc_khz(), which queries
> cpuid_eax(ACRN_CPUID_TIMING_INFO). If the hypervisor does not support this
> leaf or returns 0, the kernel falls back to early hardware calibration
> (e.g., PIT/HPET via x86_platform.calibrate_tsc()).
> 
> Because X86_FEATURE_TSC_KNOWN_FREQ is unconditionally forced here,
> init_tsc_clocksource() will assume the frequency is known and skip the
> refined calibration phase. This regression locks in the imprecise early
> calibration and could cause time drift.
> 
> I see this regression was addressed in a later commit b0e7d8e1edd52
> ("x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ for PV code")
> which correctly gates the capability setting on known_tsc_khz != 0.

Blech, so many twists and turns.  I'll fix this by adding a prep patch to cache
the CPUID result locally and only register the hooks if it's non-zero, e.g. as
is done by VMware and KVM (later in the series).

