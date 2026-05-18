Return-Path: <linux-hyperv+bounces-11010-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oETJHzB9C2qBIQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11010-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 22:57:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738A57398C
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0AB53000BA5
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B23845BE;
	Mon, 18 May 2026 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDI23VGu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDB371053
	for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137835; cv=none; b=OXzPBudHY//0trqqzyfVQGaky0hD4j/EHtPExxmnWSja3WEjmEqb/FX/UqY20yl5NW3V9N3+/OZJUYN61MuQ4QxHA9+r0nH2ZVg09UXaOkx581pxOBYN6UWVwYAoXUPDCOw4aLc5DzI9drlho9RgTrF7vwaqY7Zvha0dCbXbmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137835; c=relaxed/simple;
	bh=06kv6crDp6XZKshrhUXskI9fXrzeLGzJNXc6n7rslSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rxyi/WvaHu5VIAwaTgJIdPdLzUfKLA1gGc8QnabEYqJ3vZS746i9rIHznHRke1zQEXM6+uNR6AeLiLAAIV4wyZ3o1hfBZaFPjoU8CcdGGXuINQJQb6R2PyuIIm3i7ehEVi+6D+nlOc0HEiVtdeZB5ZboPa0ogJT8fPQSpBiaiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDI23VGu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba115ab6bbso30265885ad.3
        for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779137833; x=1779742633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBzoFdeurFIMNQx3LZwRN9zVdUKex6zY1ADox/ll04w=;
        b=lDI23VGuKtgzDTpBOflXEnfDBLS6uzUUfy79K7JpCrTgREPxq42H6Q8053K7FboCD2
         /NhnRTnbgzfbsBLHWCpE2J5IgYp4LtYVBaijg8PRDfVwH7UTlMjl+Rz40kxOjdjMvA+z
         RCSZh22x01zXtwpVMgKa8iXMkDxe9K5ivPlZKQKEsL2gwBuDBThYryx5hSueN4h40PHt
         BS8CU1mi+4hqCYOaIoTmQCUHtXmU8rNvSYwMbeAePlhE4ZpqdaG4OF9SCjI8xY3L2D8D
         wIQOILzF37TUTOaXxkg91wqSjWydaw66q7KrssxvGGGg9Wzjw+7kxE7P5Nm6WgLviYHW
         DT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137833; x=1779742633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBzoFdeurFIMNQx3LZwRN9zVdUKex6zY1ADox/ll04w=;
        b=WAE3dB/wLa43D9CdtyWMSM8FNcVGMBhFR6cpHn5b8v7AmNqO8BkPrp6bclLIRveMKK
         iquTI1fvS8nSUyvaOqqHLCMk/FZ7SYaoacMTMVz/o1yWnF8OoVhnia+xq6aD7v5V2FLI
         XTrckPilNDNWpeIZ9EAb7guYh+d7lvqWcBl52dkwBooHAWC8YGDW49bG2UoOrOisjbWD
         HwgSJbNbkk9eXG/+QM56Hu/LXme7KIxzAXttTxycl3Q8fSQN484PCXOUrVNqP6Lqin9I
         Kone/rS2g6Ga7O0PdmBeoTY4vdphgyr30buguQZS8104gwD1r35nF+cmgKPUiu4CNwT3
         AU/Q==
X-Gm-Message-State: AOJu0YxsQoQ91excToGUeJYJMshdxG/Cgfa8SrU4LW0LFQXV1/hnEqmG
	uCDTjRk5CzxBp+gc3dbKKzb6AOtPSKMFGvQFTT966fL0aRyLHlGEEiCGtq7nVLMYifmKE4HZkJe
	2YegBUg==
X-Received: from plbbb3.prod.google.com ([2002:a17:902:bc83:b0:2bc:b04b:d296])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bc7:b0:2b4:6d92:b002
 with SMTP id d9443c01a7336-2bd7e9e58aemr193521345ad.37.1779137833388; Mon, 18
 May 2026 13:57:13 -0700 (PDT)
Date: Mon, 18 May 2026 13:57:12 -0700
In-Reply-To: <20260515195557.DEF05C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-37-seanjc@google.com> <20260515195557.DEF05C2BCB0@smtp.kernel.org>
Message-ID: <agt9KJ1LDU5zVMIs@google.com>
Subject: Re: [PATCH v3 36/41] x86/kvmclock: Get local APIC bus frequency from
 PV CPUID Timing Info
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11010-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8738A57398C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] lapic_timer_period is incorrectly assigned the raw APIC frequency in kHz, which fails to account for the kernel's HZ configuration and breaks APIC timer calibration for any HZ != 1000.
> --
> 
> commit e5bbef05c7ba30fb00c716accae48693e295289a
> Author: Sean Christopherson <seanjc@google.com>
> 
> x86/kvmclock: Get local APIC bus frequency from PV CPUID Timing Info
> 
> This commit reads the local APIC bus frequency from the PV CPUID leaf
> and uses it to directly set lapic_timer_period, bypassing the standard
> calibration process.
> 
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> [ ... ]
> > @@ -200,10 +200,19 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
> >   */
> >  static unsigned long kvm_get_tsc_khz(void)
> >  {
> > +#ifdef CONFIG_X86_LOCAL_APIC
> > +	u32 apic_khz = kvm_para_apic_bus_khz();
> > +
> >  	/*
> > -	 * If KVM advertises the frequency directly in CPUID, use that
> > -	 * instead of reverse-calculating it from the KVM clock data.
> > +	 * Use the TSC frequency from KVM's (and other hypervisors') PV CPUID
> > +	 * leaf when available, instead of reverse-calculating it from the KVM
> > +	 * clock data.  As a bonus, the CPUID leaf also includes the local APIC
> > +	 * bus/timer frequency.
> >  	 */
> > +	if (apic_khz)
> > +		lapic_timer_period = apic_khz;
> 
> Does setting lapic_timer_period directly to apic_khz assume that HZ is
> always configured to 1000?
> 
> The lapic_timer_period variable represents the number of APIC timer ticks
> per jiffy. This is usually calculated as (frequency_in_hz / HZ), which would
> be (apic_khz * 1000) / HZ.

Ugh, TIL.  That's quite evil.  I'll fix in the next version.

