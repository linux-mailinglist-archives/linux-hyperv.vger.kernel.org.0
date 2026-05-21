Return-Path: <linux-hyperv+bounces-11148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADoBGnN2D2pEMgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11148-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:17:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C11605AC146
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B5DC3026745
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314CA3A599D;
	Thu, 21 May 2026 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INe6ga14"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFC34388A
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398248; cv=none; b=sP4u+UAhJPOPP9UhZoEWnQLCD01vIcZP+NKFoQNHWcjo3/ss7o3WoZMgg4Hu30bcis88lunWdiscUUKBkit44Voc4L93bcDDsc9Q9a/JoTy8XZJJQwAa6hZNBPf8U520So9yZFd86mdHQFm8jXzkCcGR6OerKYsROJsk+EyAxo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398248; c=relaxed/simple;
	bh=XW2WAcTP4Sm+wf3twJ/QoA4Nko2nJVwNKYlSfZwWKSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxt3Eo0RkT04HEWp+cbGvyd00xBh7oQ4fNEPTrq8/pIptU2vrlwpN3hIjCfkwyar/C3if6sX5xnFx8yNtn7h/hO4Mcoh19nsRQ8xQ7Bx2ASym7wJuwpnzriW8jQBmapwYPb4PFLrhTCgW2WHaZ0zJ7N8UmqVdPkBjgzy7J1EsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INe6ga14; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso117127475ad.1
        for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779398246; x=1780003046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jW9XtyrtynBxdJYPv96DfQ4Rw5zedPSv+/BbmcgSxI=;
        b=INe6ga14hO+LrZApp+y9FDGLXUp87rFwRyJJBIl+Z89cq0GN8oo0/Jg+D/hGu1Acoj
         QZ3L+uvWmPdBRcM00eL+GbwfszHyGIf77ququvAEP78jtvxrcuiYVA0wy1ToEhlk7W17
         xLdK8/BRxRernNhpMaJzEzSpKGQttOvsGyaGt1X2pK5O7xx0KOAKqi474YXK2RWM3M9C
         sAD4bAginlDYBIx6/uYqXNWnx3Tg80wEPpiyHSZtBIsCK7ydi70Kxcyjlj1iqGZCG4ZC
         dL7tc53D/fVwPAC/DP2FjEeHv2i0QcGh5A1oI4UoiIlhLuvvI0yXiE5Gt60YwiDLJ5h4
         enlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779398246; x=1780003046;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jW9XtyrtynBxdJYPv96DfQ4Rw5zedPSv+/BbmcgSxI=;
        b=N+oqNYFcRQ1V5/MqEkvenFJS+n99e3Z2hHw5kYK1UnwX7G0d/lsMKt1OypqqhA0iAF
         dO/U9hmIxSVI/VOu1/amEJnsmvLhwtCPT8ljrrITnGnSA7YoU1gbuYg7qbReyb+6d9gb
         NYBOyiV+dS5ifQo++g24k2SoqfCzR/cDwfZ2Az3gIO3mp5xvPuNZiX4jmMJ8St3/pvL5
         XWTqtLW6jtCjn64KIKZUUDbcIaWP0pu3uU3U1I2OrCihERlK4wEk1OJssSftGeHL7+f9
         UMXC56vem6nYqfgzu2u1nDGPLAAXYcjfCjflpz/aw0X23Kg++wG90xLZF0ctAx7TUOYy
         Axtg==
X-Forwarded-Encrypted: i=1; AFNElJ/j+iss/ZlwaNfwVEbE9DrNPVUoQtKNoMAJKFzHbh1rSBU5VZrmdw/BE0UeenwrtU4XeHiRC1yDMXTyfGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmDyLVehT1pdZ8pulWw9NYSqmlweT8BCvnmXnHGK4LNkUadfF
	HK0DoDXpqwKsBRJYlDeFfYDi8mulEClws6GXucRDsWkHw5nsw0nXDH4yQHLKijEgC6TnIYie1dd
	IcHsS7g==
X-Received: from plbkh13.prod.google.com ([2002:a17:903:64d:b0:2b0:c78a:4537])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd0:b0:2b4:5f19:1d34
 with SMTP id d9443c01a7336-2beb05eec0amr6266755ad.17.1779398245853; Thu, 21
 May 2026 14:17:25 -0700 (PDT)
Date: Thu, 21 May 2026 14:17:25 -0700
In-Reply-To: <342098f6bfe1e4c7b233433df8f79713b4220614.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
 <ag9wz3RiJOtVZrK0@google.com> <342098f6bfe1e4c7b233433df8f79713b4220614.camel@infradead.org>
Message-ID: <ag92Ze_FADmL1llo@google.com>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11148-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C11605AC146
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026, David Woodhouse wrote:
> On Thu, 2026-05-21 at 13:53 -0700, Sean Christopherson wrote:
> >=20
> > E.g. this is what I've got for the early flow.=C2=A0 Testing now.=20
> >=20
> > =C2=A0 void __init tsc_early_init(void)
> > =C2=A0 {
> > 	unsigned int known_cpu_khz =3D 0, known_tsc_khz =3D 0;
> >=20
> > 	if (!boot_cpu_has(X86_FEATURE_TSC))
> > 		return;
> > 	/* Don't change UV TSC multi-chassis synchronization */
> > 	if (is_early_uv_system())
> > 		return;
> >=20
> > 	if (x86_init.hyper.get_cpu_khz)
> > 		known_cpu_khz =3D x86_init.hyper.get_cpu_khz();
> >=20
> > 	if (tsc_early_khz)
> > 		known_tsc_khz =3D tsc_early_khz;
> > 	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> > 		known_tsc_khz =3D snp_secure_tsc_init();
> > 	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> > 		known_tsc_khz =3D tdx_tsc_init();
> >=20
> > 	/*
> > 	 * If the TSC frequency is still unknown, i.e. not provided by the use=
r
> > 	 * or by trusted firmware, try to get it from the hypervisor (which is
> > 	 * untrusted when running as a CoCo guest).
> > 	 */
> > 	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
> > 		known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
> >=20
> > 	if (known_tsc_khz)
> > 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> >=20
> > 	if (!determine_cpu_tsc_frequencies(true, known_cpu_khz, known_tsc_khz)=
)
> > 		return;
> > 	tsc_enable_sched_clock();
> > =C2=A0 }
>=20
> That seems reasonable. Where does the call to native_calibrate_tsc()
> happen; is that from determine_cpu_tsc_frequencies()?=20

Yep.

static bool __init determine_cpu_tsc_frequencies(bool early,
						 unsigned int known_cpu_khz,
						 unsigned int known_tsc_khz)
{
	/* Make sure that cpu and tsc are not already calibrated */
	WARN_ON(cpu_khz || tsc_khz);

	if (early) {
		/*
		 * Early CPU calibration can only use methods that are available
		 * early in boot (obviously).
		 */
		if (known_cpu_khz)
			cpu_khz =3D known_cpu_khz;
		else
			cpu_khz =3D native_calibrate_cpu_early();
		if (known_tsc_khz)
			tsc_khz =3D known_tsc_khz;
		else
			tsc_khz =3D native_calibrate_tsc();
	} else {
		cpu_khz =3D pit_hpet_ptimer_calibrate_cpu();
	}

	...

