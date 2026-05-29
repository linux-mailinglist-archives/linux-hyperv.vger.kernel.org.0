Return-Path: <linux-hyperv+bounces-11374-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMenLJbLGWqvzAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11374-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:23:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D46065F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD2E302BDE2
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28C3C8728;
	Fri, 29 May 2026 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6ihMeSI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FA36606B;
	Fri, 29 May 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071673; cv=none; b=gURFM6QUPzmlN/rWU7FK4O9ULaqXdxIlvQIxwxO3K+N5w+Xvpd8RlzbjcFH2rLlx3wPbUfJD1X4nHc5bC9fec0IQaibkPX1GwD81NKcKdj5WT863uHsxsU24ALSw4migAZV0yXSlVau26GpGEKy0h3AcFr4giRLEjN5KQ5tu9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071673; c=relaxed/simple;
	bh=DD2YHak3ZWBXFb0intQ1iL4QeAiaTmJeYTtTw9Zr20Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBUyln3PGz1DZsaVqf9uV01AVyhKUChfpwgPJlB6ebJQmbk9GVpDH1znO7ZsVfH9y43hvIvTiIitx5rKpbrXFIJheGuwedlbvxy873bdeQPQwXBSTzwYFpQ3fJYr8AX6pKGodb3rgmDqGODMUTdbCziJbwt9cjdyBuP89HLGfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6ihMeSI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990441F00893;
	Fri, 29 May 2026 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780071671;
	bh=I6TATacJ1AnX2jQlaEDeS9fvCHVeCf4IE5uJbomCs7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6ihMeSIB+igUGeGxXoj7cJbxv5EcT8LeXXi+vGBg2UFtTTLn9yPPqriToFW7ZvVr
	 +e2MsSwOtN053l5m6PLpKYpi0aIXrp4bl5JTYKLKX+PjUdE8xW00Pte9JhnkiDSMb0
	 JcHfE1zmF9GamQEraJUiUZx94JY/IPXGYgDUi9spaku1wFFz+zDtpYLMs8441ibpo+
	 xEiRcSZoReSU8VaK1lP+vpCzwRyjBlQXT6BTM6xr4X0uMbJ9wKo2eYdlRLXRJ0Medy
	 YPuqWSDFcm2y28xbepkRHxHWoXGqNzSSqKzIQK3eIPbGkt+EyPi+oZPIBYyJypZRbC
	 XdXUZ0Wxrp26A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/47] x86/tdx: Force TSC frequency with CPUID-based
 info provided by the TDX-Module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260529144435.704127-8-seanjc@google.com>
References: <20260529144435.704127-8-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:21:10 +0000
Message-Id: <20260529162111.990441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11374-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 219D46065F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Providing the 'tsc_early_khz=3D' boot parameter silently bypasse=
s TDX-specific APIC timer and TSC capability initializations, causing a fea=
ture regression.
--

commit 8a9e5abad4e72a5ef6c47191b8815b94bbed98c9
Author: Sean Christopherson <seanjc@google.com>

x86/tdx: Force TSC frequency with CPUID-based info provided by the TDX-Modu=
le

This commit updates the TSC frequency initialization for TDX guests to use
trustworthy CPUID-based information provided by the TDX-Module instead of
relying on the hypervisor. It also relocates the TSC_RELIABLE capability
setup from tdx_early_init() to a new tdx_tsc_init() routine.

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 29b6f1ed59ec5..5d79763592201 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c

[ ... ]

> @@ -1123,9 +1124,6 @@ void __init tdx_early_init(void)
> =20
>  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> =20
> -	/* TSC is the only reliable clock in TDX guest */
> -	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> -
>  	cc_vendor =3D CC_VENDOR_INTEL;

[ ... ]

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 2b8f94c3fcc7f..2603f136e29bd 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c

[ ... ]

> @@ -1550,6 +1551,8 @@ void __init tsc_early_init(void)
>  		known_tsc_khz =3D tsc_early_khz;
>  	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
>  		known_tsc_khz =3D snp_secure_tsc_init();
> +	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> +		known_tsc_khz =3D tdx_tsc_init();

[Severity: Medium]
Does this structure accidentally bypass the TDX APIC timer and TSC capabili=
ty
initializations if the user provides the tsc_early_khz boot parameter?

Previously, setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE) was executed
unconditionally in tdx_early_init() for TDX guests. With this change,=20
tdx_tsc_init() is skipped entirely when tsc_early_khz is provided due to
the if/else if chain.

While using tsc_early_khz is an explicit user override, skipping
tdx_tsc_init() completely drops the X86_FEATURE_TSC_RELIABLE capability.
Could this cause the clocksource watchdog to flag the TSC as unstable and
break timekeeping for configurations that rely on this parameter?

> =20
>  	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D7

