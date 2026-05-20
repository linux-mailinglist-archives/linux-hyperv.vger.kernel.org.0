Return-Path: <linux-hyperv+bounces-11085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPUROJUhDmqI6QUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11085-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:03:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889F959A672
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D94C3019894
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2A379EFE;
	Wed, 20 May 2026 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYYAhFQy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4194E379988
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310950; cv=none; b=aPc9O/ZW3L/aIKe1syceG6Mvirf2R9Jr/Z512mBG9b63oyy5HtYjlAvD2LiaedsQHedShE2FjLXXBYjKqTr4FuuJhA68YUFmijU2jNYYLDmpEmcMFGyaFFYk3Am+zdhZvut9FtTSVHt7w2StA9WzuL/U3f4gRhUnU1egC/QIPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310950; c=relaxed/simple;
	bh=/SyQLtBraYhS5/8VMnaEdQSNY3tBbZxFagWmgPcJqrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R0yC7jOyYK65PeGNE/zlQNhtrLCGp5imv2DZe3kboqNcGfBhHfY7KKWOouGd59bhadLgjzJ95K0QuSdCct5Ukpgq7NswlbcEIhJk3NqtZhaOY5kcFkKbKrCrgOB6Z0zzmlUZotxCcx9kV8+fSE0dTdfCBBXx8A6/j7D5Xi73j1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYYAhFQy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3692f395339so5250193a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310947; x=1779915747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMxqN6rGG5Sakxt9VTCj2ZelG+Z0Re7U8JKIeB5aot8=;
        b=rYYAhFQy9vD0gBQ3+G3dns6dwND0hNmtAFduiSdduwZVLMOvJ8uQW3Z3cWWZ0LhBV8
         XZ6FJft/Z1Jxu40v9a89TnBiWWdzrWhfCh4uqNPugsAQB1prOpxZ+2/lnuD2HkAOlyCx
         CWM6hfCXr7h+uFMy+ZMgs/1kyg5B4fl6OfUudPPcoZcLFHqk1TYksy1u4mNTni0gBvlj
         Q47tEQQGybK+qGGh6ep1swxtIGoZRW1brRlnBZS++Sp2WzU9T0rKoQjaLt3Lik7enEaP
         TjjN/GBixeoEpM2UnPvgQ7NGodPzOEkwLiWh0OcuXcmKlWTT1A8c7OMiCrXrv4mr/RLO
         AsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310947; x=1779915747;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IMxqN6rGG5Sakxt9VTCj2ZelG+Z0Re7U8JKIeB5aot8=;
        b=PUIwSZ23MYienvYLEuDsRv30HlOO3DXAjdeoptdwM/F22ldCeHwVHlKLpoz8FNHevu
         XIiMW25vSVzL9Hsm06dRbqHse5pw7FwGnw7jADvQ14dTbQbPMNwPGjNVGCUDTqSs/ueG
         yufQew8NzWo1LvWayoeGx2TzyO7lTEuvrqhQKMwMMaZqPX5ZddreilsJBcMmJW3RRXA2
         nZ0NydPZxMKnK05CvAJL5Dev2D3iNOc32H9E8PD1ETDejYPV4ER+yZjssqECECMxxhWr
         iYUHSLmLYNHd1mqAhh4V92ZChCmBJY3HWykgEhTOzC4tdSiYDAHwUA39G3F4Nt05tqLm
         sqYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FA0Wlhyi37EaMUsdr0n59K28x1qHEtQNQNdvYrO5B/Lv+QeXcLlyBJWXJzD5FRN7NCTesQDRkoe6PHPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmrFMnjB1JNw3i0nwdU6R+SxkNWTGi2UaHgh9sl8BmcGLHZ9m
	jvXJDsmu17bUNy0STjviJksfgWZZ1riFKwyo5IimNbVYDMmw8gMtYcquliyZMcwIK0PRlyOlgF5
	DOmA4eg==
X-Received: from pgnp19.prod.google.com ([2002:a63:7f53:0:b0:c82:7805:9e4d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:279a:10b0:39b:dea7:5626
 with SMTP id adf61e73a8af0-3b308856ca4mr1798637.35.1779310947183; Wed, 20 May
 2026 14:02:27 -0700 (PDT)
Date: Wed, 20 May 2026 14:02:26 -0700
In-Reply-To: <c347d65f555ad1e10a0e87ee57c5879c7046d0e7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-7-seanjc@google.com>
 <c347d65f555ad1e10a0e87ee57c5879c7046d0e7.camel@infradead.org>
Message-ID: <ag4hYu0O71QrLW2y@google.com>
Subject: Re: [PATCH v3 06/41] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11085-lists,linux-hyperv=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[34];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 889F959A672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > Mark the TSC frequency as known when using ACRN's PV CPUID information.
> > Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sen=
se,
> > the TSC freq is explicitly provided by the hypervisor.
> >=20
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > =C2=A0arch/x86/kernel/cpu/acrn.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> > index c1506cb87d8c..2da3de4d470e 100644
> > --- a/arch/x86/kernel/cpu/acrn.c
> > +++ b/arch/x86/kernel/cpu/acrn.c
> > @@ -29,6 +29,7 @@ static void __init acrn_init_platform(void)
> > =C2=A0	/* Install system interrupt handler for ACRN hypervisor callback=
 */
> > =C2=A0	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callba=
ck);
> > =C2=A0
> > +	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > =C2=A0	tsc_register_calibration_routines(acrn_get_tsc_khz,
> > =C2=A0					=C2=A0 acrn_get_tsc_khz);
>=20
> I'd feel slightly happier doing that from within acrn_get_tsc_khz()
> itself....

Ya, though as you note below, this is really a comment on the overall serie=
s.

Waiting to set the cap until the calibration routine is actually run does p=
revent
the case where the something registers a calibration routine, but its routi=
ne is
never run.

However, because the cap is sticky, it doesn't handle the scenario where it=
s
routine _does_ run, but the kernel ultimately throws away its calibration i=
n favor
of something else.

Further complicating things is that ~half of the paravirt flows already for=
ce set
caps before their routines are invoked:

  snp_secure_tsc_init(), jailhouse_init_platform(), ms_hyperv_init_platform=
(),
  vmware_set_capabilities()

Rather than trying to convince everyone that waiting is better, despite tha=
t
approach still being flawed, I chose to handle this by ensuring that once t=
he TSC
is marked known and/or reliable, the kernel won't replace the calibration r=
outine
with a "lesser" source:

  x86/tsc: Rejects attempts to override TSC calibration with lesser routine

That doesn't completely prevent the kernel from being stupid, but it should=
 prevent
both the case where X's routine is registered but never run, as well as the=
 case
where it's run but ultimately ignored.

> which I note is 'static inline'. I'm vaguely surprised that even builds
> (although it does).

Heh, KVM x86 (in the host) does stupid things like this too.  E.g. kvm_pdpt=
r_read()
is a static inline, but then wired up as a function pointer in three differ=
ent
places.

> Probably nicer to move it explicitly out of line in acrn.c though.
>=20
> Most of that should be a comment on patch  2 of the series, I guess?

