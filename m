Return-Path: <linux-hyperv+bounces-11142-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOM2KdxwD2o8MQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11142-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:53:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D32AA5ABEC8
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9FEE30055F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884683FE364;
	Thu, 21 May 2026 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAG1evab"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B9388E63
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396819; cv=none; b=oPmaVBAaKCGEDV1hgqMmsUNG6O2X5KyGfv4xpYP23XPi59LQXOcY4xM0AeKYpld1SYBjolgnnKB/ppMNJP9oVRU9SFUQNaK6aRwIhgcm9zpZAE4WfOhmCVN/w2HSQKoDlmy46yGjmUKGbzdXm3bHfTK+Sy4FRKY6vomqd+Tdl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396819; c=relaxed/simple;
	bh=fLtEKBB9bXOUmjY2enVlgjls3t7C38yhOeuHPIwcPQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tm9+26hjucZOaHSdGbmo7YyKKVQx8/oiMnRTYvRhurpTPa7+5MfoMGJvsPsxNcHu2VZdIxA9ZNTOJA2otgNhajmIzX9A6uM8M/vaVg7W5o8XWlLOy/j+AIxd6YYmRkXwqyw9yuHRYNyxdfa4Vtxemn3usNR12L+CYAHvRxpSlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAG1evab; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so3518147b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779396817; x=1780001617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtuSO9Df1yE7JlouGMlcWCEpEnvAH6qlC/HYl6ROkD4=;
        b=gAG1evab3O6Zq1hmqPGXbFwskRHsziWs88blH9z2Ckdpr25OZPIOG+a6fGoc5oWFuW
         A9ZvR7wMk4R82U19yR2JXRAHzGyTe4AurnZB2eU0tybCVpMCNUzV/yt0qsjQzwXuX75R
         m3uSEGSg1HAvLoHIXeJfo7eA9ChCtbBly0HdIJjbetozdFLyRlMK1srH1iDW29H5Pi9p
         I30dGz161BozSjgdm7tRyk7w46unMX8Izx5NXZ40+7t39LyDarzKVxj88GDtZCgtTb4+
         D/9BJzCKq+Da2GhE0AgLCWETRDAp3CCBM/SseBDuOnoEGQ1SSy0lSA5vqbLjOnT7kNFh
         OaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779396817; x=1780001617;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtuSO9Df1yE7JlouGMlcWCEpEnvAH6qlC/HYl6ROkD4=;
        b=h3Y7nZePN9LER5Gs22zx7+Qhb9eC5Q2j9u3ZDlN6NYfa5NzzfmwwUWjw+8G6oDJ3ax
         E1VsFSbIwkS0F4Uai2OJPSWMtdAepAcfKA9E0suzInSzZ4DVEY/gNUrLFItkNDmL5cbe
         /dxh3M4oXxTntOiohxWftxfI5Qvuh7wnh9tzk9yF0gZyzlby8vl4D2DouXRHFz3pDPlm
         BQQu9GLgYtA1IS5OoVNWNXiuU4+tQV8S9cOy9EaiY1VLkwSBv61/yCaUL8vzNZaOSZ2W
         fuLQQNYF4xqK4MkB78IbNrr+S5Qi1pi4m+gEav8NhxByoXlZShf1L9XUEwmnPk8K/Kj1
         PmLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Rx2gq/pqDQkRZ/WTf7D+rmZm5Oq5ODIG7ZPUMVqHW8pf++xrN9TxgyEk9NLQJ0mj/rpSAnezcPZw3qoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyD8hMdr5LyNXBBO/cGHegk5uviX2fWGDGQ3mCk+OTQKgmLp39
	WY5R3VxJ3YhTHPq+Lz9VpxY2ESZ2aX36mf4jwy6jbbEOhAkvX7P4CNfzwrPENjSf3WgTgA4QUsW
	79kNGPg==
X-Received: from pfbg21.prod.google.com ([2002:a05:6a00:ae15:b0:82f:915e:291f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e06:b0:837:b97d:2fe
 with SMTP id d2e1a72fcca58-8415f18b012mr734843b3a.18.1779396816710; Thu, 21
 May 2026 13:53:36 -0700 (PDT)
Date: Thu, 21 May 2026 13:53:35 -0700
In-Reply-To: <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
Message-ID: <ag9wz3RiJOtVZrK0@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11142-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: D32AA5ABEC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > Add a helper to register non-native, i.e. PV and CoCo, CPU and TSC
> > frequency calibration routines.=C2=A0 This will allow consolidating han=
dling
> > of common TSC properties that are forced by hypervisor (PV routines),
> > and will also allow adding sanity checks to guard against overriding a
> > TSC calibration routine with a routine that is less robust/trusted.
> >=20
> > Make the CPU calibration routine optional, as Xen (very sanely) doesn't
> > assume the CPU runs as the same frequency as the TSC.
> >=20
> > Wrap the helper in an #ifdef to document that the kernel overrides
> > the native routines when running as a VM, and to guard against unwanted
> > usage.=C2=A0 Add a TODO to call out that AMD_MEM_ENCRYPT is a mess and =
doesn't
> > depend on HYPERVISOR_GUEST because it gates both guest and host code.
> >=20
> > No functional change intended.
> >=20
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Tested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>=20
> Mildly concerned that we might want to support multiple options =E2=80=94=
 does
> it have CPUID 0x15? Does it have 0x40000x10? Does it have a pvclock?
> There are various permutations of those which are perhaps best handled
> by *trying* each one, in some order, and populating a struct with the
> answers?
>=20
> But on the basis that perfect is the enemy of good,

This has been bothering me too.

Aha!  AHA!  Idea.

... 4 hours later ...

Mhahahaahah, victory is mine!!!!

TL;DR: Overriding x86_platform_ops hooks is dumb.

To your point about making an informed decision, that's essentialy what thi=
s series
is already doing, just in a very roundabout way:

  1. x86_platform.calibrate_{cpu,tsc}() are initialized to "native" version=
s
  2. Hypervisor init code runs and conditionally overrides calibrate_{cpu,t=
sc}()
  3. CoCo init code runs and conditionally overrides calibrate_{cpu,tsc}()

So the ordering you want is already there, as is "trying" each source to so=
me
extent, in the form of steps #2 and #3 overriding the hooks if and only if =
their
source of information is valid.  For all intents and purposes, the hardenin=
g I
was adding by formalizing the calibration overrides was to enforce the abov=
e ordering.

But that's obviously all but impossible to follow, _and_ it's pointless.

For every PV case, including TDX and SNP, "calibration" is simply informati=
on
retrieval, i.e. it never changes (barring broken hypervisors/firmware), and=
 the
information is always available during early boot.

Contrast that with the pre-CPUID CPU frequency calibration, where the frequ=
ency
might change, the kernel is making a best guest based on other timekeeping =
sources,
and not all timekeeping sources are available during early boot.

And so overriding x86_platform.calibrate_{cpu,tsc}() for PV code is complet=
ely
unecessary, because steps #2 and #3 already know the frequency when they ov=
erride
the hooks, and "success" is guaranteed, i.e. the kernel won't have to switc=
h to a
"late" calibration flow.

If we provide x86_hyper_init hooks:

	unsigned int (*get_tsc_khz)(void);
	unsigned int (*get_cpu_khz)(void);

then we can kill off x86_platform.calibrate_{cpu,tsc}() entirely, explicitl=
y
define the preferred ordering (user-forced =3D> CoCo =3D> Hypervisor =3D> n=
ative), and
depup some of the hypervisor code.

E.g. this is what I've got for the early flow.  Testing now.=20

  void __init tsc_early_init(void)
  {
	unsigned int known_cpu_khz =3D 0, known_tsc_khz =3D 0;

	if (!boot_cpu_has(X86_FEATURE_TSC))
		return;
	/* Don't change UV TSC multi-chassis synchronization */
	if (is_early_uv_system())
		return;

	if (x86_init.hyper.get_cpu_khz)
		known_cpu_khz =3D x86_init.hyper.get_cpu_khz();

	if (tsc_early_khz)
		known_tsc_khz =3D tsc_early_khz;
	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
		known_tsc_khz =3D snp_secure_tsc_init();
	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
		known_tsc_khz =3D tdx_tsc_init();

	/*
	 * If the TSC frequency is still unknown, i.e. not provided by the user
	 * or by trusted firmware, try to get it from the hypervisor (which is
	 * untrusted when running as a CoCo guest).
	 */
	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
		known_tsc_khz =3D x86_init.hyper.get_tsc_khz();

	if (known_tsc_khz)
		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

	if (!determine_cpu_tsc_frequencies(true, known_cpu_khz, known_tsc_khz))
		return;
	tsc_enable_sched_clock();
  }

