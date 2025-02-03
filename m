Return-Path: <linux-hyperv+bounces-3827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57461A26411
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2025 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE5F1626E5
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2025 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67B620A5C5;
	Mon,  3 Feb 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fCqn5Wm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938F7081E
	for <linux-hyperv@vger.kernel.org>; Mon,  3 Feb 2025 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612377; cv=none; b=D+aY5x7ads7QV7kyZOjSRYzEwYa4A/WvR72/ANP7Vhftvz7PB0MpYAJV2dNxhvYCv1dbWh1YUZJzQtRcFTpWFXI7PzNwAk+7AD4FXoSzD4r24ku+40O2AEjTFBCkMaDAaDtCTq46yeAe1xhMQmp2p7VGAFNBCNd3mS5L31DyNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612377; c=relaxed/simple;
	bh=vqumdPUecpvskYi8VygICeGGt4cQpB2BlEoPCXjm++o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7T21+cQ0pFRxzgsLkc7U8JXhfp8mIlHWlb1xf3ZboPAqzjvYCV/o4EcMOky5dFdq3+dyjSNRGagGDaU5mXAXLOhIGq7OHIcNyPzH3y6AV1ohio6bmiAGuAFjzfsQc61gzOJTeWYxOepN+AEM3YONfvNn40jXOtqUNN8EZtWnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fCqn5Wm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so103814605ad.3
        for <linux-hyperv@vger.kernel.org>; Mon, 03 Feb 2025 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738612374; x=1739217174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4DCNVElxq2OdBlpMH7Nkzbl/aQqIemXOZXJQi0SM/U=;
        b=2fCqn5WmpfSMTNPk99MabSvdASAUCrZ1YSHoptYwbaStLioHcmAPiAkpXCbtQaTjnS
         wsJXQN5VD20nMBrJCnxMPD8KL/jBP67WZmeFzUg5aHSyj/ndOk14LSB9mIVWdzA7vtL9
         pWKRMNQCxotzDvKGDNxupj3JbQ9xqVus+w1w6wvt4DRmSRvg2wdXFAXpVui5AnyZFvIA
         Os0PpOT8mjQJ5/ri3PJfcQXXl+k7FKSAQriGp+KMY/RGOBwh5UJLnzICi6sxTU5+omNF
         6rWbcae9bq6lDDq2Elt0KQi1+scF8q+/yOSWd1vIH90koUctHZmsqR/EiPjpX6rbWibP
         wiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738612374; x=1739217174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4DCNVElxq2OdBlpMH7Nkzbl/aQqIemXOZXJQi0SM/U=;
        b=n1nO+7sTDdQ9ZAH5S1kV9G1x0RPNZObjWmApJPd7/HZ3WhgL4Ul7+01MTqk0ps3omd
         N7WvaayhglOXRJ8IjbG9h12mQzxa5X8F8tLjABNZSDAXcW+I6SLl5DvRR3qndOQz4wjj
         9ph7mqr2oKkLfPt0ceM4zNm5UcgczbAt1QgVX9nyjOQR8T+bkbs4kr1zZvOQE+KxrOOS
         mGHNpiS8c79rU/PusSsqIMGdyxOjIG4p6noNPv5IM380hnPOF21ATF4xjlByezDFxgKz
         kPSEjPw/8cgCIBzH+DWVVUkeVe/xZvR/RmDw6tvxvACNk9mZZScCt01dE6VIQNinwWuj
         R3hA==
X-Forwarded-Encrypted: i=1; AJvYcCXpkPiFLvHkUggrm/k8TAAokRzRPyFiWwajNPb8yZlNrZLg9msFWC2Eqy/BGZL/i3smrnYU5ncANgvKvYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTfV3GaILez2qeg3nS+PQ6/jsyGQV6mA7uycVwD0c87y3SV3i
	hYVRHB7RqaUL4NaFs66Rz7f152hqeGB9BSGVQHYiUtggkhAy6tHM5QoWnn0Mb7XzeJYOb0xylGX
	ktQ==
X-Google-Smtp-Source: AGHT+IGdTeFcZ8i5SvZ2bB5g1492lleQh9maGoQBlpXj01DaF5LbzkfV8PQhJ2gBHFVfNpv3sg2ev2woN1U=
X-Received: from pfsq1.prod.google.com ([2002:a05:6a00:2a1:b0:72d:4132:7360])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2287:b0:72d:a208:d366
 with SMTP id d2e1a72fcca58-72fd0c8bae3mr33309743b3a.20.1738612374524; Mon, 03
 Feb 2025 11:52:54 -0800 (PST)
Date: Mon, 3 Feb 2025 11:52:53 -0800
In-Reply-To: <fb1d32fb-f213-350f-95a4-766c88a6249c@amd.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-9-seanjc@google.com>
 <fb1d32fb-f213-350f-95a4-766c88a6249c@amd.com>
Message-ID: <Z6EelTYbVIcmGH5Q@google.com>
Subject: Re: [PATCH 08/16] x86/tsc: Pass KNOWN_FREQ and RELIABLE as params to registration
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, jailhouse-dev@googlegroups.com, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 03, 2025, Tom Lendacky wrote:
> On 1/31/25 20:17, Sean Christopherson wrote:
> > Add a "tsc_properties" set of flags and use it to annotate whether the
> > TSC operates at a known and/or reliable frequency when registering a
> > paravirtual TSC calibration routine.  Currently, each PV flow manually
> > sets the associated feature flags, but often in haphazard fashion that
> > makes it difficult for unfamiliar readers to see the properties of the
> > TSC when running under a particular hypervisor.
> > 
> > The other, bigger issue with manually setting the feature flags is that
> > it decouples the flags from the calibration routine.  E.g. in theory, PV
> > code could mark the TSC as having a known frequency, but then have its
> > PV calibration discarded in favor of a method that doesn't use that known
> > frequency.  Passing the TSC properties along with the calibration routine
> > will allow adding sanity checks to guard against replacing a "better"
> > calibration routine with a "worse" routine.
> > 
> > As a bonus, the flags also give developers working on new PV code a heads
> > up that they should at least mark the TSC as having a known frequency.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/coco/sev/core.c       |  6 ++----
> >  arch/x86/coco/tdx/tdx.c        |  7 ++-----
> >  arch/x86/include/asm/tsc.h     |  8 +++++++-
> >  arch/x86/kernel/cpu/acrn.c     |  4 ++--
> >  arch/x86/kernel/cpu/mshyperv.c | 10 +++++++---
> >  arch/x86/kernel/cpu/vmware.c   |  7 ++++---
> >  arch/x86/kernel/jailhouse.c    |  4 ++--
> >  arch/x86/kernel/kvmclock.c     |  4 ++--
> >  arch/x86/kernel/tsc.c          |  8 +++++++-
> >  arch/x86/xen/time.c            |  4 ++--
> >  10 files changed, 37 insertions(+), 25 deletions(-)
> > 
> 
> > diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> > index d6f079a75f05..6e4a2053857c 100644
> > --- a/arch/x86/kernel/cpu/vmware.c
> > +++ b/arch/x86/kernel/cpu/vmware.c
> > @@ -385,10 +385,10 @@ static void __init vmware_paravirt_ops_setup(void)
> >   */
> >  static void __init vmware_set_capabilities(void)
> >  {
> > +	/* TSC is non-stop and reliable even if the frequency isn't known. */
> >  	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
> >  	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> 
> Should this line be deleted, too, or does the VMware flow require this
> to be done separate from the tsc_register_calibration_routines() call?

No idea, I just didn't want to break existing setups.  I assume VMware hypervisors
will always advertise the TSC frequency, but nothing in the code guarantees that.

The check on the hypervisor providing the TSC frequency has existed since the
original support was added, and the CONSTANT+RELIABLE logic was added immediately
after.  So even if it the above code _shouldn't_ be needed, I don't want to be
the sucker that finds out :-)

  395628ef4ea12ff0748099f145363b5e33c69acb x86: Skip verification by the watchdog for TSC clocksource.
  eca0cd028bdf0f6aaceb0d023e9c7501079a7dda x86: Add a synthetic TSC_RELIABLE feature bit.
  88b094fb8d4fe43b7025ea8d487059e8813e02cd x86: Hypervisor detection and get tsc_freq from hypervisor

