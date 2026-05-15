Return-Path: <linux-hyperv+bounces-10978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GgjC0Z/B2qQ5gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10978-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:17:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D06155758F
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9104A30329B2
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636CE282F1A;
	Fri, 15 May 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk1GNJEE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F684386C25
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876189; cv=none; b=tHFqoPRD48yKmk9ogmnXHkvudIrgzAdggdOK5oN1MN+N8xIdDjfbD9ZRyWiKge4KQ06JysmE3QUEvpatzzknmFRjLHbQxyrAWDhTtCjFaLdOO30cYWVwCHS/zbCwftKjcJYeV3tOGYXhRCkaC4CDDXTu8kGC91q0uUl/q7zQSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876189; c=relaxed/simple;
	bh=+LE8ciODWJx0Uj/lVjPOmW9g9d68dIt4jurrnGfGR94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vz/jEXFS2ityRz5YAqBiGV7oCejzzYSnhKobBJgTpELS0tjptSYHaxiXN86VhBTfbGxWyRyTaAtWrMe0InVzJM5S92jn7pvVLCmcpo3O+JJ7tiIW7HF5i0Cea+1/fbpEZZHXy7uyV2lReUBSRA/86PNibT+d+/t9l0hdLAmJD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk1GNJEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3C5C2BCB3;
	Fri, 15 May 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778876188;
	bh=+LE8ciODWJx0Uj/lVjPOmW9g9d68dIt4jurrnGfGR94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Hk1GNJEEPK/AKsOqt9iGZSt1utYUlOW5lxln4isl0E6ioW3MCXVUO8LVJzZSr/PxK
	 I2UHGjtQIII/PWtimPHBLSD3RcWtEoUYtaRrXNjQUKhcJ11M1oET+xB4xxk1Y69oid
	 Xq1ZHt1/zD71Wyfz7PlMpKdy6CVOntixDA7gAbdkGlc6YaaXLOnmczceqSJs18sSyb
	 AX2aLVI3mAFdosYUig9+HUHhLOlCAXwSdEEXfErhefpMgE/a3EJf1qyVmdapsorNj0
	 PrJOBLd+9HM71O0LY1MMc8nHbHQb6AA1D+DklGF6evN4rRF35Sa5t2y6PXO8506vWp
	 lwdtAHuxoKIng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 32/41] x86/tsc: Rejects attempts to override TSC
 calibration with lesser routine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-33-seanjc@google.com>
References: <20260515191942.1892718-33-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:16:28 +0000
Message-Id: <20260515201628.9E3C5C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7D06155758F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10978-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious WARN_ON stack trace on every boot for CoCo (SEV-SNP/TDX=
) guests under KVM.
--

commit e57255e4d076143a67d0e6e44f914aec31aed8c7
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Rejects attempts to override TSC calibration with lesser routine

This commit adds a sanity check when registering a TSC frequency calibration
routine to ensure the incoming routine is as robust as the outgoing one,
rejecting it with a warning if it is not. This prevents replacing a trusted
calibration source with a less trusted one.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 98bef1d06fa9d..7a261214fa3ef 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1319,8 +1319,13 @@ void tsc_register_calibration_routines(unsigned lo=
ng (*calibrate_tsc)(void),
> =20
>  	if (properties & TSC_FREQUENCY_KNOWN)
>  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
> +		return;
> +
>  	if (properties & TSC_RELIABLE)
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
> +		return;

Will this cause a spurious warning stack trace on every boot for CoCo
(SEV-SNP/TDX) guests under KVM?

For KVM CoCo guests, CoCo registers first via tsc_early_init(), setting both
TSC_FREQUENCY_KNOWN and X86_FEATURE_TSC_RELIABLE.

KVM then registers second via kvmclock_init(). At this point in the patch
series, KVM only passes TSC_FREQUENCY_KNOWN, so the properties & TSC_RELIAB=
LE
check is false, and it falls through to this WARN_ON. Since CoCo already set
the capability, the condition evaluates to true.

I see this is fixed later in the series by the commit "x86/kvmclock: Mark T=
SC
as reliable when it's constant and nonstop", which modifies KVM to pass
TSC_FREQ_KNOWN_AND_RELIABLE on modern hardware, preventing this warning.

Could the patch ordering be adjusted to prevent this intermediate regressio=
n?

> =20
>  	x86_platform.calibrate_tsc =3D calibrate_tsc;
>  	if (calibrate_cpu)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D32

