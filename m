Return-Path: <linux-hyperv+bounces-11086-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAR2GmoiDmru6QUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11086-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:06:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CAA59A740
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCB4E3014C6A
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55A37AA8B;
	Wed, 20 May 2026 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cG2Z8MWj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699D345CBD
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311206; cv=none; b=WTXgtBCDeD7APvw0axgk23g/FDIBdkaKqzjviySVSLXZY/Nvx2T3+Py656h/7L4EqKwem2SCO5M5nuDs2EXQvcSvRCtrmmwIo0ng+ZO/pPlGgIrxl110Licy00od/4mu/f/ncQ2MgXY2jijWAmofBoKExltXwXS+IEg552f2SAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311206; c=relaxed/simple;
	bh=AkGtEPLI8YUYNvTXu8Kh0Ow1uRQIZlr5HS+MCfYPWaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UeeevjgdBvSDC3OPC20shRNz7QhAspQ4ZM7LjlNmL6S3HVGsUW6xEqCFuh6uujIm7eofNRElLKmv0fBNATcwhvBNqnxJz0DTpisHc5Stypm6lD9YSXQoXd6VqmJorZMjDRdRSrl2Et+vZIjjBkNVrQC47X7w2C+yoETOA5iWa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cG2Z8MWj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8276c91addso2920070a12.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779311205; x=1779916005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzU733i4LRzT0VTX5lJXk+wXutwbub7NmvSDpQIkegg=;
        b=cG2Z8MWjoAdoqozHXOwoaOhTY3Ozd/UfWu1tKULbuoSUP4RbkNoKPGzbHl0vCiAH1Z
         nrtq+z/CgCtHbCwDtnoSdQCTwSfqHyJNsQqY+jv6GW4rLQ8x9WdZed35Biel+d5lzW55
         0t/knrhPC5XYybepliabTwcSng9RQspSqTrYMn8qghr/1dxvQn8zbDYUCVMtKjdJIN/Y
         4zEwgssUQUjjw57HOA5b9tjWAu7Cx7T09VdaFQTLCmI7hw+RxnuXvZD31MRaY/kHoQ3q
         dhC8Q0T06LpW+Z6QtSsF4NBMUXd8cjSmHyeFw3r8vLOaWIFsK/jkYQkTyD9xHXj6LslM
         yoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311205; x=1779916005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzU733i4LRzT0VTX5lJXk+wXutwbub7NmvSDpQIkegg=;
        b=k6+y0UF6+h1PWD6O0PpOmkvG2vgc8uEtmOL1GIu/4Q07AgvQQxXS8nR53KykiwNRSM
         H4jGOWXCMFrbZPm7Nwvy20KRSMdAZmMBhMdf5MYSayuiQeYHeCqbwGc6kjeZ1X4fqTeb
         v+NV05DN3kF7IMKK/i3ch9iPttvMqrE691BB+S5xky5zBXopzAqnKmVf15YFJkWvhw3g
         WMLeXfPofCBpAjWUA2SbCFSHrVUI4Q5HplrNlanS6SOk4GwhHuy0OlMoXNJDxh4qJLcb
         xCxb7HxP7GI5HJXhiI8OMvJewU+Wt36BX9X40FNiL6bRLWbvrQjpB+9T8pZ4Rgoz2wAq
         b93A==
X-Gm-Message-State: AOJu0Yy84wqrJDZe0NioXGO7wHPjH6gNW0Ft94MfT4776HCPPM/14jkh
	nqrtuHyuHeHd8xo3zb9+2ZrndOqUM+PEi+R1mq3zDf9CDjmlp6c29jsZb47XHViu1Mr4HjT1pff
	GAdydIQ==
X-Received: from pfbfc32.prod.google.com ([2002:a05:6a00:2e20:b0:82f:96ee:b9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd8c:b0:837:6bb9:acb7
 with SMTP id d2e1a72fcca58-8414ab08b90mr219137b3a.0.1779311204529; Wed, 20
 May 2026 14:06:44 -0700 (PDT)
Date: Wed, 20 May 2026 14:06:43 -0700
In-Reply-To: <20260515195934.C790BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-42-seanjc@google.com> <20260515195934.C790BC2BCB0@smtp.kernel.org>
Message-ID: <ag4iYyTLtJEEyabl@google.com>
Subject: Re: [PATCH v3 41/41] x86/kvmclock: Get CPU base frequency from CPUID
 when it's available
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11086-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0CAA59A740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index 62c8ea2e67691..7607920ae386e 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -190,6 +190,20 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
> >  	}
> >  }
> >  
> > +static unsigned long kvm_get_cpu_khz(void)
> > +{
> > +	unsigned int cpu_khz;
> > +
> > +	/*
> > +	 * Prefer CPUID over kvmclock when possible, as the base CPU frequency
> > +	 * isn't necessarily the same as the kvmlock "TSC" frequency.
> > +	 */
> > +	if (!cpuid_get_cpu_freq(&cpu_khz))
> > +		return cpu_khz;
> > +
> > +	return pvclock_tsc_khz(this_cpu_pvti());
> 
> Before this patch, both calibrate_cpu and calibrate_tsc used
> kvm_get_tsc_khz(), which checks kvm_para_tsc_khz() to get the exact TSC
> frequency from KVM's PV CPUID timing leaf, and only falls back to
> pvclock_tsc_khz() if it is unavailable.
> 
> Does the fallback path in kvm_get_cpu_khz() bypass kvm_para_tsc_khz()
> entirely? For VMs that expose KVM's PV CPUID timing leaf but not
> CPUID.0x16, it looks like cpu_khz will now be reverse-calculated from
> pvclock multipliers instead of using the exact hypervisor-provided value.
> 
> Could this introduce a precision regression due to truncation loss, causing
> cpu_khz and tsc_khz to needlessly diverge on the fallback path?

David pointed this out too, I'll fix in the next version.

