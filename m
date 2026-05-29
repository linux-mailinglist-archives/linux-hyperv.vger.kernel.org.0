Return-Path: <linux-hyperv+bounces-11373-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAY3F1HBGWo1ywgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11373-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 18:39:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE23B605C6B
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 18:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40FA431F789B
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E603DDDDD;
	Fri, 29 May 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFhcUGim"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E63E1232;
	Fri, 29 May 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071286; cv=none; b=BUPn5xaHSSGrNKm7KtGd5Z9lIL+TC6jv2NeZn2O3GzmMDdgH/dMxZIyEgw1eeeSrQSXwr2mEbHtNrR+6GEktn92zxip1Mgf41G1n1GSGNPugjIpOvj85d4FMYZleo4lKCDvcoC+EC+n0A2kQrRpJbgrBq5DOdmGQ4ic6EIlpWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071286; c=relaxed/simple;
	bh=clPWdb+9bH3y0ZG8zhW+xz1QNCbYVeojcluX0tU9ZsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y1RlSV//HctY32r4s+WxTqvFAUU7HUBV3hPnFruGyqz7B6eEyr92wxhVg8BKHZRN8ujkfeeejXwv8av9Xv2k5BWw1qjHpsLozVKNWCaGN0CxHn12kOyeM7KTJnD6LqTSegAXqgy26jF6WS5wzH5eg2gW3RGyFjykSFojcXKYysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFhcUGim; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754A41F00893;
	Fri, 29 May 2026 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780071282;
	bh=GQhpKBnWXprcJu0Sbtvm7Ub8hKr6TrRpFUcEiIzP2pE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFhcUGimm+EE1R6aU7Cgd2a52p4whHbCT123yr4NKMuZk8lZYVsJzRzcpynY768g4
	 Mf62JGG10hzV6EPsM8JP+RcZ74rsYEtNewE1fp2rrFXwrNYyK/000wh9JVOuO1pXcv
	 raprKTJB68h4gICJXRGnnBnGOUTpPBKsssInGLjNNdPG5KprttxZV5iGGhLYk8izsI
	 6DrA9QxPB8mvr0/eqlJJqJrltiV8x1kACux97N4f5xTFxOSsVQQaUIFXFnIA1yBLOS
	 2DYBjA26aYfdIm+5CJZz8+ibSHedwrloPDhbNfrGc0Af4UlmrCqciD4UPCvoF23ttz
	 KuonfBWfhatsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/47] x86/sev: Shove SNP's secure/trusted TSC
 frequency directly into "calibration"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260529144435.704127-7-seanjc@google.com>
References: <20260529144435.704127-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:14:42 +0000
Message-Id: <20260529161442.754A41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11373-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: BE23B605C6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypassing `snp_secure_tsc_init()` when `tsc_early_khz` is provided=
 omits critical SEV-SNP CPU capabilities, breaking TSC stability and securi=
ty.
--

commit 8e7d363bd0d5d42b37ec02afb4108ddb034a9988
Author: Sean Christopherson <seanjc@google.com>

x86/sev: Shove SNP's secure/trusted TSC frequency directly into "calibratio=
n"

This commit modifies early TSC initialization to directly pass the secure
TSC frequency obtained from SNP firmware to determine_cpu_tsc_frequencies().
It introduces logic to prioritize tsc_early_khz over other sources to
maintain existing behavior.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 833eed5c048a9..2b8f94c3fcc7f 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
[ ... ]
> @@ -1537,16 +1538,20 @@ static void __init tsc_enable_sched_clock(void)
> =20
>  void __init tsc_early_init(void)
>  {
> +	unsigned int known_tsc_khz =3D 0;
> +
>  	if (!boot_cpu_has(X86_FEATURE_TSC))
>  		return;
>  	/* Don't change UV TSC multi-chassis synchronization */
>  	if (is_early_uv_system())
>  		return;
> =20
> -	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> -		snp_secure_tsc_init();
> +	if (tsc_early_khz)
> +		known_tsc_khz =3D tsc_early_khz;
> +	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> +		known_tsc_khz =3D snp_secure_tsc_init();

[Severity: High]
Does skipping snp_secure_tsc_init() when tsc_early_khz is provided omit
critical CPU capabilities?

In the pre-patch code, snp_secure_tsc_init() was called unconditionally to
set up hardware capabilities before determining frequencies:

arch/x86/coco/sev/core.c:snp_secure_tsc_init() {
	...
	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
	...
}

By chaining this into an else-if block, if tsc_early_khz is provided
(e.g., via the kernel command line), snp_secure_tsc_init() is bypassed.

Without X86_FEATURE_TSC_RELIABLE, the TSC clocksource watchdog remains acti=
ve.
In a Confidential VM, an untrusted hypervisor could manipulate legacy exter=
nal
timers (HPET/PIT) to trigger the watchdog, falsely marking the TSC as unsta=
ble
and forcing a fallback to untrusted time sources.

> -	if (!determine_cpu_tsc_frequencies(true))
> +	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
>  		return;
>  	tsc_enable_sched_clock();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D6

