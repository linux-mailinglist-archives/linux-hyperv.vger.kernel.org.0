Return-Path: <linux-hyperv+bounces-11384-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICsTJErkGWrrzggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11384-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 21:08:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35861607B90
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 826743001D47
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 19:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BEE348C75;
	Fri, 29 May 2026 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP8DCc2+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DB373BF2;
	Fri, 29 May 2026 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081319; cv=none; b=BhNXAj3g9cPvaFc+KmqYop3BdxMV19cHI5BQkaMJ5PgyWD12FxLgpUcNQ3qnhmHoBNNMXpkozA73sOmbhup1dWO6Z1vJOTGTIKx7o9nsQqhUgbkpDyKoJcM6m5ciifW/Ls+SPwQoP1Fw+LlJnR9nMHnDAZncu8BqXAGl7GnZs40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081319; c=relaxed/simple;
	bh=f05uxl9XETje19IuO8LUXIResnjkhLvmo4MKMKrG5Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQMQ97j6DzrpumQwQ8c+WRaEl7aupJTa2r1YvBONzuRdkjrrRKkxxSEN0WAmFPQ17CklrkSUYovBZdJdi3dyg7k7uZGCzjyjtob1gZwBZc3XVcsb0Miw4T/upMkAOtJ4xwfjwcdcxTi5cXn2fBZfKdB/sq7l/ot+I7f3lalNQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP8DCc2+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85371F00893;
	Fri, 29 May 2026 19:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780081318;
	bh=2Hv0U+jh+1+mjKsosOuYTy2B/PD5GwcvOEQnuqx+SRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FP8DCc2+ueNk5nNQi+QQXr+IaLW2CMDGnLWzlsukaXMeP3GBBkO/l/dCzYFpsK3Al
	 shQxqr/1IRfHdzmTo53eROpFUZQRYZMkJ02xSmyORcPOJHhN287TDw5p/h0tpeBUSV
	 M70YVKqX1RfYXcCpBKWPqQ41zBfJXsm/rIprY8ojIaDM9oyMHDehwUMTnXIKirGUuM
	 Y2+9ONKdJRhaO7e9RB9ELvLwYHnbyxhxw/5hE/Yb6F0zDxmNIOOYd0bBKmspsjdUfc
	 QRVCNVWfE3fuZOSERnWNvqRhmTyQdD0p5tJYT/Aw0UmTfIvHB+iAktMFLhKvTDNoFB
	 ALcc6foWbo6Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260529144435.704127-11-seanjc@google.com>
References: <20260529144435.704127-11-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:01:56 +0000
Message-Id: <20260529190157.E85371F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11384-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 35861607B90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Providing the `tsc_early_khz` command-line parameter on CoCo guest=
s (TDX or SEV-SNP) completely bypasses critical guest-specific TSC initiali=
zation, leading to uninitialized LAPIC timer periods and missing `X86_FEATU=
RE_TSC_RELIABLE` flags.
--

commit 5593e79bcd8390a1e744d159a1d9710aff43225a
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ for PV code

This patch consolidates the setting of X86_FEATURE_TSC_KNOWN_FREQ for
paravirt code. It sets the flag if the TSC frequency is known, but
avoids setting it if the known frequency was provided by the user via
the tsc_early_khz command line parameter.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3625966124423..8cef918486db7 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1569,6 +1569,15 @@ void __init tsc_early_init(void)
>  	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
>  		known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
> =20
> +	/*
> +	 * Mark the TSC frequency as known if it was obtained from a hypervisor
> +	 * or trusted firmware.  Don't mark the frequency as known if the user
> +	 * specified the frequency, as the user-provided frequency is intended
> +	 * as a "starting point", not a known, guaranteed frequency.
> +	 */
> +	if (known_tsc_khz && !tsc_early_khz)
> +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +

[Severity: High]
This isn't a bug introduced by this patch, but looking at tsc_early_init(),
if a user specifies tsc_early_khz on the command line, it completely bypass=
es
critical guest-specific TSC initialization for CoCo guests:

arch/x86/kernel/tsc.c:tsc_early_init() {
    ...
    if (tsc_early_khz)
        known_tsc_khz =3D tsc_early_khz;
    else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
        known_tsc_khz =3D snp_secure_tsc_init();
    else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
        known_tsc_khz =3D tdx_tsc_init();
    ...
}

Does this bypass cause tdx_tsc_init() and snp_secure_tsc_init() to be skipp=
ed
entirely, missing their important side effects?

For example, tdx_tsc_init() computes lapic_timer_period and forces
X86_FEATURE_TSC_RELIABLE:

arch/x86/coco/tdx/tdx.c:tdx_tsc_init() {
    ...
    lapic_timer_period =3D info.crystal_khz * 1000 / HZ;

    /* TSC is the only reliable clock in TDX guest */
    setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
    ...
}

Could an uninitialized lapic_timer_period cause the local APIC timer to fail
on TDX guests, potentially leading to a boot hang?

Additionally, could the missing X86_FEATURE_TSC_RELIABLE flag cause the
clocksource watchdog to spuriously disqualify the TSC on these guests?

>  	if (!determine_cpu_tsc_frequencies(true, known_cpu_khz, known_tsc_khz))
>  		return;
>  	tsc_enable_sched_clock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D10

