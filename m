Return-Path: <linux-hyperv+bounces-11383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCMkA+7jGWrrzggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11383-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 21:07:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C24607B48
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D358A302FA67
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64D343893;
	Fri, 29 May 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SauZxRkt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76196373BF2
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081057; cv=none; b=APmrL63Kt4DXFX7btmQgAsX/OzwTfL88mx8l+jiV6SdgNSLIqzAtA8SakbcJbYff0PgnjWEJhFJNpqPAz682B3Ziee1IROacvBaxF2xOAkyuRNTdz9geih2HH6GhKy7s48q4cewcKaaDsydKwlgg0dBY2/k7fiaGimilBt4O2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081057; c=relaxed/simple;
	bh=0Ac6Y0XbIulsI8e3BoESoWqp4Ms/oUKG/jhOEdJSmhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqhxkz7+H5nS9qp1FFUwoB0iWdW5q92+sh/cHo2uGzJpeiXlT/j6HYYn3c4+D6dE0atmNtn/MjQeK7p0QyajEjnYZwLxhDkUHYKTS1fIdMQ8qgy6Wf1XELYxI7J7zTa9QRzd0yXG+2kLz9n5zNuzZYuv9fBzgBq4c71Vn5o1XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SauZxRkt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c477290bso8165270a12.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780081056; x=1780685856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=trcaqpaPheQ9pegSLrZ7Icm7wT70eldJiw4H2do/7sU=;
        b=SauZxRktoPsuynO4ZMeyfuGk0OLrdzEAD6RfSDjb4T3pyfX83zbYQVqWjigLD579EG
         rqoTvY6RCixCUUiLEj1+tAXAa7ZXA1RfC3VC4OgY0yuDDWTi0FLrtDfzffSSjKM2/tYi
         6CZqT6VBsDvgYwMYom8Wy2RkWf4WMNVdS+M6PRUF5vn55ndJ64M7hkFbNDB7I4ofL/Vg
         U+v7aX1NZRJ9ZWVyPFoan+Ufjt9o7qIeHrM8AlpcUjFgyDoSgmD1iaB3icCNEhe/s1SZ
         zJNZhOJU+BEyZOOVK5Vq1y7jxwOIUxtHk8rS3x7mpuQXfgPro4VTBk3s5/t1orZyzMj0
         qXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780081056; x=1780685856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trcaqpaPheQ9pegSLrZ7Icm7wT70eldJiw4H2do/7sU=;
        b=Ql065oedDIwjFQJXksTPUeT2+vm3bQbTZ1b/Hh+G2m0c8o+LFBriOzz01YWIRFZpsd
         wGQSfh11Ba0+xa+SBernIQEGValmTphgiIuhaq0CMGDt6c6B4tqIRipMo7PfCWwe79u5
         z6dIuh5rKYNNJt2G4PuJ1gx+TFMpjOLd6WQur4DiFYqh+v8mem6mTJF5+PuJy7GWcXUJ
         KD6VraLCKZ3fnZVvpnzr1aFg9BtFyQ3blWbRuOapOWEemnX2AVUciJ8FgWdAbmxWY8XI
         UB1jQoWFqOLXNvGtcCBnj146WwgKlxJM3MQdjgEIuO/jlzHEfnGGPJpoJcrHRF+Bx/G8
         7H+w==
X-Gm-Message-State: AOJu0Yx+a3AYO5NhllUL4OYrU/i7a5dfKsuDwtta5H9JrH5qpbIoZfAl
	hqWPXgVfWYjo3k9h8hd8gPR02Lxt8YoETXqrYtlcX3WeDj52a2rvmJgSJNacv8EcnW+holW95g1
	FTFYCnw==
X-Received: from pgc24.prod.google.com ([2002:a05:6a02:2f98:b0:c80:192c:51ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce85:b0:2bd:4d4b:9143
 with SMTP id d9443c01a7336-2bf36795110mr12953405ad.8.1780081055498; Fri, 29
 May 2026 11:57:35 -0700 (PDT)
Date: Fri, 29 May 2026 11:57:34 -0700
In-Reply-To: <20260529181213.0B27A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-18-seanjc@google.com> <20260529181213.0B27A1F00893@smtp.kernel.org>
Message-ID: <ahnhnjvfIblFxTFX@google.com>
Subject: Re: [PATCH v4 17/47] x86/kvm: Mark TSC as reliable when it's constant
 and nonstop
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11383-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A5C24607B48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 909d3e5e5bcd5..4fe9c69bf40b3 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> [ ... ]
> > @@ -1040,7 +1041,20 @@ static void __init kvm_init_platform(void)
> [ ... ]
> > -	kvmclock_init();
> > +        /*
> > +         * If the TSC counts at a constant frequency across P/T states, counts
> > +         * in deep C-states, and the TSC hasn't been marked unstable, treat the
> > +         * TSC reliable, as guaranteed by KVM.  Note, the TSC unstable check
> > +         * exists purely to honor the TSC being marked unstable via command
> > +         * line, any runtime detection of an unstable will happen after this.
> > +         */
> > +	tsc_is_reliable = boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > +			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > +			  !check_tsc_unstable();
> 
> [Severity: High]
> Does this evaluate check_tsc_unstable() too early to catch the command line
> parameter?

Huh, it does indeed.

> It looks like kvm_init_platform() is called from setup_arch(), but the
> tsc=unstable kernel parameter is parsed via __setup() later during
> parse_args() in start_kernel().
> 
> If check_tsc_unstable() evaluates to 0 here because the parameter hasn't
> been parsed yet, wouldn't it incorrectly force X86_FEATURE_TSC_RELIABLE
> and set prefer_tsc to true?

Yep, but this is a pre-existing problem that goes all the way back to the original
commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if invariant TSC is exposed").

We could try to fix that, but I'm _very_ strongly inclined to add (yet another)
patch to simply drop the check_tsc_unstable() since it has always been dead code.

