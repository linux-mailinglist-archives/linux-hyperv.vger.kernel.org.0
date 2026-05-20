Return-Path: <linux-hyperv+bounces-11077-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCl9Al0gDmqI6QUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11077-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:58:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C2D59A57A
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20F803234AEF
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83531352036;
	Wed, 20 May 2026 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ek0oW5ne"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5F34D38B
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303967; cv=none; b=kdPbM2j/xsRQRs3J/T4THmIeVvr2rMvnhpBNs7X0JvKStmwSPFg/6CXRkthP0QAjU18rcU0bkClYkiOaedaL8i+bAByudVtFA6sjT1i/tYYrzJF/9909k3tD63hklHqeU8WmwMpEnMdvGoJURdQcJ3HjiX6NuuPybtRcQwcayl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303967; c=relaxed/simple;
	bh=RgcPTv4wMW8kG16l9+v1ZPwo8tS4sdbfT4dPD82hdzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R78CZiGt5oGogz4y8lSKzBzuohfCK7zH2rTjtaZYjJTn1QALD0leRxooXEupesODsMclDnSquhktOxr9ZiU509O+HXWkJfeRt/+N3jHwUYZlSYxp+LK5xghyA1zM9t0kyuAx5P9HUJdpJhA3A+9cUHuzZBNsu8Rdl+omO4WEjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ek0oW5ne; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so49918435ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303965; x=1779908765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WNRv8jV4IoEb/swCa+lI2OUcbnWLzJ/hZWZsifg+pw=;
        b=Ek0oW5nelrQLYtTKBSvVKaJjYWTfIwgoMV9tHDddjC4B1HVaarKDSBAohWoc59BNfD
         ONBldzBffkhBjr16Imwj6pmEAe053VOKNYznwrXXVqsIgRfqvAMMSRV+K9fCdDwceLah
         VrQi/QyWRJxcl0s2SbVQw6/+GLmqrYvZXX1MkcNO0ShgXdQ9Cat5M3+fPyeqzEgjFfWK
         ZZ3qT7Tcyl1XmtH04w0fo72jD0jzC9Wk2MhT7M/CY1eOjVqOWfRSNBgKoJ/eHy+AiF13
         g5+74aPdIQJsxpvVmUk2itVplluj/FqRN3fkDWXK+r5+YI8SjEn39w5fmqJSaLRgay3Y
         w0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303965; x=1779908765;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WNRv8jV4IoEb/swCa+lI2OUcbnWLzJ/hZWZsifg+pw=;
        b=bvQ3jexnrjWDQYu+z9txSPXcgu6CWlscbHKWSb7o8T5hGhd3m27NBFp/TaHvsJx50s
         wfso8zdfdHlN6yoJTBRmzMuGkfSxFZ1+8Z4mt4oLa6Tsrh9VJjP/45DNEHuKESuhybwH
         a5T2WK7oqvjPAOuGPTBWAbqg/o/WqPQpOtq3rYnblmA6e48B6GF1m3cCpwrMkEfxzYLa
         qf6+bydoiOvoXHlH/itfd4m6R+Ezdy2V752SToao1i/QZOs1oe6OdAvmkiNocEn1aH5C
         vp9giJNn0Ok9k6199YD1nV4u23LxrTsoHLfrT4LhbA3V/keH3kXPARj3nK4uqRhaZuwm
         gQJg==
X-Forwarded-Encrypted: i=1; AFNElJ9aKPywtRUFRtMOm3nNnSiM2qk0FTBogdMbTt+K2BZhaGoDw3X629UClhv+l/OVZneh/nUgtOoOKJorKGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznHpjKOEhpYopkrSxLy+U1QBYI/UtQJIDek+CA9k4V/M0HZPqV
	trAGCfaUxfBD0EzrFX7n+skyVp/rSxUvYqGwFZJJmuW8sdK4Q7IkBGQOqlKWmN+fE1Ad6vkewaC
	pYx2eYA==
X-Received: from plup11.prod.google.com ([2002:a17:903:4b2b:b0:2ba:67f8:6257])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:7d96:b0:2b0:bed1:46f7
 with SMTP id d9443c01a7336-2bd7e910f99mr193795045ad.37.1779303964438; Wed, 20
 May 2026 12:06:04 -0700 (PDT)
Date: Wed, 20 May 2026 12:06:02 -0700
In-Reply-To: <0a3aa07a1d3c4bec2b89f8026093969155b73caa.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-42-seanjc@google.com>
 <0a3aa07a1d3c4bec2b89f8026093969155b73caa.camel@infradead.org>
Message-ID: <ag4GGqYv0DHoVx-C@google.com>
Subject: Re: [PATCH v3 41/41] x86/kvmclock: Get CPU base frequency from CPUID
 when it's available
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11077-lists,linux-hyperv=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05C2D59A57A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > If CPUID.0x16 is present and valid, use the CPU frequency provided by
> > CPUID instead of assuming that the virtual CPU runs at the same
> > frequency as TSC and/or kvmclock.=C2=A0 Back before constant TSCs were =
a
> > thing, treating the TSC and CPU frequencies as one and the same was
> > somewhat reasonable, but now it's nonsensical, especially if the
> > hypervisor explicitly enumerates the CPU frequency.
> >=20
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > =C2=A0arch/x86/kernel/kvmclock.c | 16 +++++++++++++++-
> > =C2=A01 file changed, 15 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index 62c8ea2e6769..7607920ae386 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -190,6 +190,20 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action=
 action)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +static unsigned long kvm_get_cpu_khz(void)
> > +{
> > +	unsigned int cpu_khz;
> > +
> > +	/*
> > +	 * Prefer CPUID over kvmclock when possible, as the base CPU frequenc=
y
> > +	 * isn't necessarily the same as the kvmlock "TSC" frequency.
> > +	 */
> > +	if (!cpuid_get_cpu_freq(&cpu_khz))
> > +		return cpu_khz;
> > +
> > +	return pvclock_tsc_khz(this_cpu_pvti());
>=20
> I'm fine with this in principle but shouldn't the fallback be calling
> kvm_get_tsc_khz() instead of directly calling pvclock_tsc_khz()?

Oh, yeah, for this patch, definitely yes, so that there's no side effects. =
 The
question really should be answered in the context of "x86/kvmclock: Obtain =
TSC
frequency from CPUID if present", which subtly impacts the CPU frequency, b=
ut I
think the answer is "yes" there as well.

