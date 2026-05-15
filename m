Return-Path: <linux-hyperv+bounces-10985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJZiDnGmB2rP/QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10985-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 01:04:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC77755930A
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 01:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13D6630078A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 23:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B5175A9A;
	Fri, 15 May 2026 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPSVX4oL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D7341ADD
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886254; cv=none; b=TUD1LCE86KR/vYfwxLmREhs7Ai5kbLWOTruo/FqRjSCDqHnYVHa4SJ/C+qS0REGtj9GzxIvmImz1lGSRNbv1neaBocQnOZA8GR8dP3hNTOnuMH6uOO9i5nnpMx+X3j802Uf5zA6xR3vByKsbu5OKs7Nd+5fsJydL9n/e4TnpS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886254; c=relaxed/simple;
	bh=bb5ysJcNu53CRVPhD2WY4M0eL4SFH7mVl780sk2znBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJbRbBUEmRNyyiczY99W9uJxOAOCQX78BuGJZfWLjkAq8cIQZd/fL7sZ1Yuvd7Jkm8Bf4YgyRjHuXk8DzwYPORT5qdW2XoCW618jHskqC+iskABwWudlKfdNvQVr5dR3stE4STSDagFjqkwjSc11pdDxt/n8Kh6B2/KL63HpanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kPSVX4oL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba5f794825so2517445ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778886252; x=1779491052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSd6SQzj/M/7k2HqLEnMpGD+gr6VAxiNUNUCcOG58wc=;
        b=kPSVX4oLpJfGAgBBsmANOKLsLDrZfXWwys+6c5n3825VQY4WK4YgF9uV0FS4N+oVYX
         4aGbUp1cuqzOEh7tlBJYDOF+fgmQc8gcPZldP0DS8e3fOgVjTBG/ook/vk9wWTcQ7ZLp
         IoOiTPsWWm+dJBJ5JmgbnDuzYY10wdo9G2k5cnnN9ob0EYjnZa9PAeR6m86EK6PwKPS9
         +ERB3qUrH4FdEV1Pxuhs+/FgqgXvdql3IBW+vPD7zJHdMD6fQPLXS5BnTPLJ8rLeij5A
         mdkGB0bBwHURWYwNDwJVAHv3z2ot4dZHFgSrSYzutrpH/Y0Ber8uYR2459B5jdpji+Mv
         Zptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778886252; x=1779491052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSd6SQzj/M/7k2HqLEnMpGD+gr6VAxiNUNUCcOG58wc=;
        b=sLBD/kVRzw/byysxg4pOoEaHsdg1crCnkJ8TIqeQcubFnMRnbsk7whn3GSrsdmB7D4
         +Ex9V9gx2LaTs8OxLSP4cdMTVDfWmRv6I/cA6hmqSplgRs8Ng0CFR94sJZerdW+yrJNJ
         Yv/kUAUOK2ebrlAZtrNY0OIKBBF5ZvxjcNVj7XgsO+A8jPo568/YyvSyO/lXKib1BCeS
         8HmC6TwiBjyIJTqM16I3b2YoQonW6IdPEvz9y2jCPwl8EQXyrEk/8dZzkr1lzDoBj1Yg
         T4vN18ZqHpxA69GXydrO42C3472C6GJpiaoLeXNtdSsHAeiRWTM4nSKt++pwtfpJTHMw
         PkKA==
X-Gm-Message-State: AOJu0YwbwSfitmAc1ejh65AUnYGAfY+lZDeCiIJivIpvx0QnSpyYNuhD
	rGURptp0P8f2RgXYDy7nvkUQ4z5Rgp//UugG0iEzkK/sf2dHQcz6hKb2/iZSMNDLU1R33AVg/xN
	qMNAcHw==
X-Received: from plbli3.prod.google.com ([2002:a17:903:2943:b0:2bc:aee2:8f39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:7044:b0:2b2:d09c:c07c
 with SMTP id d9443c01a7336-2bd7e90e820mr45008385ad.36.1778886251737; Fri, 15
 May 2026 16:04:11 -0700 (PDT)
Date: Fri, 15 May 2026 16:04:11 -0700
In-Reply-To: <20260515195116.E0AFBC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-41-seanjc@google.com> <20260515195116.E0AFBC2BCB3@smtp.kernel.org>
Message-ID: <agema3no38bvH3Y5@google.com>
Subject: Re: [PATCH v3 40/41] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: CC77755930A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10985-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unintended clobbering of the global `cpu_khz` variable in `native_calibrate_tsc()` due to a missing local variable declaration.
> --
> 
> commit 36e45379d4c9f40ae24c5c323b4f0471c94c6bef
> Author: Sean Christopherson <seanjc@google.com>
> 
> x86/tsc: Add standalone helper for getting CPU frequency from CPUID
> 
> This commit extracts the logic for getting the CPU frequency via CPUID into
> a new standalone helper function. It also updates the TSC calibration code
> to use this new helper.
> 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> 
> [ ... ]
> 
> > @@ -754,13 +772,8 @@ unsigned long native_calibrate_tsc(void)
> >  	 * clock, but we can easily calculate it to a high degree of accuracy
> >  	 * by considering the crystal ratio and the CPU speed.
> >  	 */
> > -	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
> > -		unsigned int eax_base_mhz, ebx, ecx, edx;
> > -
> > -		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
> > -		info.crystal_khz = eax_base_mhz * 1000 *
> > -			info.denominator / info.numerator;
> > -	}
> > +	if (!info.crystal_khz && !cpuid_get_cpu_freq(&cpu_khz))
> > +		info.crystal_khz = cpu_khz * info.denominator / info.numerator;
> 
> Does this unintentionally clobber the global cpu_khz variable?

Yep.  I don't think I even realized there was such a global variable.  Probably
makes sense to use a different name for the local variables.

