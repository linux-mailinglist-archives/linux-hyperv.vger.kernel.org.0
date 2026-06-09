Return-Path: <linux-hyperv+bounces-11573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T3rkOjBsKGp2EAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11573-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 21:40:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD10663D36
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 21:40:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uEECr2HU;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11573-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11573-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629B7301D07E
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47E40D56C;
	Tue,  9 Jun 2026 19:28:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5440D564
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 19:28:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033333; cv=none; b=ASlRoSVHbyMYqVx6etRO1+pUPemRFtDm2z0NNUwoRtWXXUKCerFjn+bvQ8OVf/KeCeRnTUVZnlooCMu/INjvtFidEPeieixWaC9tLSFTGFvI/UDEeEhZt0yOfwjHiYgSpEDH0t4mWhAwfXYiEduv6BUpze0KuC3ONbdeymmJuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033333; c=relaxed/simple;
	bh=DEq1jYRvE+O17je84XUU131j/oCIfTBQGBFCnmOvDsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tXXCltoaqPJaNyqwawRC9Hifn/m1OH/qpfwzWa8xHmfELXCWWvc4hOl5YAEFsLY7NgExDU4s58G7+ItVjh7lnBxwMA54YqGM4IDNIcGaILw+SuKquGTRipbAtRkrgYVisMdN+/yLFl6iuV/eS6TzZMIJdGt5FeB3C9Ul8xpKVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEECr2HU; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso7095777a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781033332; x=1781638132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guAeemkMCkyys/PJ2ZLLCH34LSaDcqFIXbZHYNdXwyE=;
        b=uEECr2HUmSWcV55B9qz9Ny9DXNP3hIV/RKcnoFLGbHpIv8QB6MmHdAlq+lQZ79z0eQ
         qbQoP9XGhjLjR+GZMMTeEfSeDIQDcc70Tw39p5niuEKkQQxXwqG72JICA6F1zK4ERkh9
         i6YL0rMFeBwMHfHCcwQ2XRm+7Li/V8KGyH0f6gqzU3JEmsFS2fvfq4mDZzqG/zn+/P8C
         Ava0Zgpviwd/HCc+nBSyIvebYsklKQ8SGTOWnZ7hMsOXhzJgM4hisfLkwcqJk5pT2VsP
         bUYm82u6SFL6AsBLkgVjgWD34maJ6WDmb+n1XgCEON2xgeosYfeSppa2zUHT1x/VUnr2
         FEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033332; x=1781638132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guAeemkMCkyys/PJ2ZLLCH34LSaDcqFIXbZHYNdXwyE=;
        b=jklYAzZncCjQUXxe3aAZPlvWRTNZLZbUSrTbD//5QLTUxkEoGo2+qoBKS8rJBgkruo
         09bDI74VSgw31ZVH4jDkSNORB6vyqvbo2ePWA19poEah2N9Tni2D2Z+QgqmzT9X5rQPC
         gB7220EIp12EwMMZOcj8/+6rnGOCUR6UXrdSkvh3YM6WtHqZ8CalWZA0Zrxih7F372F6
         HRnxLbSNYBVPfC+J+m9bJs8mPMVCdtNZpBjskiIhpdsdNZY+zh78y6KTbw+pOFcI1qKQ
         H+2vYWF51iwAOEHnT5xvVaN/7fhL5mFKSjmF8A8sN1GPwTxEiA9mOPuDADGUfNvcHDCg
         Y27g==
X-Forwarded-Encrypted: i=1; AFNElJ+ZzHXiHKp4P8zrdLxeVWiSXCct1/+6QrzOsqpypkXKs7yJ0QZ+4y4tRu4Wjd33PQZKfIb86LINyBJclnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmCEqgSpKyOhNBSCig9lantFX2WhqljM5uW5xDQjcRBvBwoS+
	vuqvNVdPttfSMEltcyxsoufep9JJdEAOAZwsDGEm4YQ1tGhzmkKMRxofbHwKW5voKBXW3WEB4ey
	gH3SyZw==
X-Received: from pjbgq16.prod.google.com ([2002:a17:90b:1050:b0:36d:c3f4:8460])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390c:b0:36d:f28b:72e2
 with SMTP id 98e67ed59e1d1-370ef2ec248mr22562261a91.8.1781033331787; Tue, 09
 Jun 2026 12:28:51 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:28:50 -0700
In-Reply-To: <20260602034916.GGah5SvARd77mkvxe3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-3-seanjc@google.com>
 <20260602034916.GGah5SvARd77mkvxe3@fat_crate.local>
Message-ID: <aihpch8FG6Esl3Jx@google.com>
Subject: Re: [PATCH v4 02/47] x86/tsc: Add a standalone helpers for getting
 TSC info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11573-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bp@alien8.de,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:dwmw@amazon.co.uk,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw2@infradead.org,m:mhklinux@outlook.com,m:tglx@linutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,linux.intel.com,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,outlook.com,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DD10663D36

On Mon, Jun 01, 2026, Borislav Petkov wrote:
> On Fri, May 29, 2026 at 07:43:49AM -0700, Sean Christopherson wrote:
> > +static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
> > +{
> > +	unsigned int ecx_hz, edx;
> > +
> > +	memset(info, 0, sizeof(*info));
> 
> Let's not clear this unnecessarily...
> 
> > +
> > +	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
> > +		return -ENOENT;
> 
> ... just to return here...
> 
> > +
> > +	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
> > +	cpuid(CPUID_LEAF_TSC, &info->denominator, &info->numerator, &ecx_hz, &edx);
> > +
> > +	if (!info->denominator || !info->numerator)
> > +		return -ENOENT;
> 
> ... or here.
> 
> We wanna clear it here, when we'll return success.

Actually, if we take the approach of relying on the user to check the return
code, then there's no need to zero the struct since all fields will be explicitly
written, especially if we drop the "tsc_khz" field.  I was zeroing the field
purely as defense in depth.

