Return-Path: <linux-hyperv+bounces-10971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Dc0MkF5B2oJ5AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10971-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:51:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16855720B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 042F6301CFCE
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99737C0FC;
	Fri, 15 May 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtSh5Rlr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB65350298
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874677; cv=none; b=WEm8NY4U+AgH5Sw02iAWZQxchxxKAz7l2y5hkH0q1INRvuXTiILETHHl8a4y7s0kSIZrxxLRsvk94gi0ySJbQc+rwws0TbB6AG3Nhi4420uyipL6woMw6KQPNCn7TZCAJ5c5ceZZm6LfPwEUNhX4F5caFNpojemBAbpx1NfIRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874677; c=relaxed/simple;
	bh=xvfH/g6acp67trhKIRQHi4phSHBQRxOat9/g/r9uX3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mq/lz1zSm7NetO8UbQDKVA5muzxHSMg1y+3EAIRTn9Pi/tGf3mWoeBBm6ERmPE7A5dsPY8raPj8rNyJhLwOvyydV2gABU6WlidjABYNf3heu5iQdibBV0js8xTEPPl5OQ+U0gdOaoH81WgyUxLPXSBAW8gAsU1zwrPrYfZOKgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtSh5Rlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AFBC2BCB3;
	Fri, 15 May 2026 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874677;
	bh=xvfH/g6acp67trhKIRQHi4phSHBQRxOat9/g/r9uX3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HtSh5RlrnDH4EGRZxGb6PoDf6FjaWacf+o+93o4+txBaH+ja3dCTQErWAixGV7bbw
	 nTMO+GbVrXPE36b57xU81zcypNN5j3VLK5J/gMBngszbj9PaZqQUUFclBDLzHmc3+/
	 KwRcDDHHUi3DtYuxejtngv3d5nEmQ/uDTYwBGQCPBceqTHI+kfE8ifU4Nwn01ZKuDO
	 T1eWaO4wGwvvw8KhOmvEifwI6Ju0qCEfE5qolfg/aa9+zRXOm3aTxZq9a+phEKRb56
	 e//ZF/0CoV7u2guW2+xzHre4+7cD/4yVAuONnUwyuZFZpytf9+Zcywmoqbr5HSyZ7g
	 dyEQbFhL0DSZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 40/41] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-41-seanjc@google.com>
References: <20260515191942.1892718-41-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:51:16 +0000
Message-Id: <20260515195116.E0AFBC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3F16855720B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10971-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unintended clobbering of the global `cpu_khz` variable in `native_=
calibrate_tsc()` due to a missing local variable declaration.
--

commit 36e45379d4c9f40ae24c5c323b4f0471c94c6bef
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Add standalone helper for getting CPU frequency from CPUID

This commit extracts the logic for getting the CPU frequency via CPUID into
a new standalone helper function. It also updates the TSC calibration code
to use this new helper.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c

[ ... ]

> @@ -754,13 +772,8 @@ unsigned long native_calibrate_tsc(void)
>  	 * clock, but we can easily calculate it to a high degree of accuracy
>  	 * by considering the crystal ratio and the CPU speed.
>  	 */
> -	if (!info.crystal_khz && boot_cpu_data.cpuid_level >=3D CPUID_LEAF_FREQ=
) {
> -		unsigned int eax_base_mhz, ebx, ecx, edx;
> -
> -		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
> -		info.crystal_khz =3D eax_base_mhz * 1000 *
> -			info.denominator / info.numerator;
> -	}
> +	if (!info.crystal_khz && !cpuid_get_cpu_freq(&cpu_khz))
> +		info.crystal_khz =3D cpu_khz * info.denominator / info.numerator;

Does this unintentionally clobber the global cpu_khz variable?

Because cpu_khz is not declared locally in native_calibrate_tsc(), this
appears to pass a pointer to the global cpu_khz variable to
cpuid_get_cpu_freq().

Looking at cpuid_get_cpu_freq(), it unconditionally zeroes the target
pointer before checking if CPUID_LEAF_FREQ is supported:

arch/x86/kernel/tsc.c:cpuid_get_cpu_freq() {
        ...
        *cpu_khz =3D 0;

        if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
                return -ENOENT;
        ...
}

If the system exposes CPUID.0x15 with a 0 crystal clock but does not
support CPUID.0x16, cpuid_get_cpu_freq() returns -ENOENT and leaves the
global cpu_khz as 0.

Could this overwrite the previously calibrated CPU frequency and force the
kernel to fall back to legacy PIT/HPET calibration? If so, this might
cause boot regressions on systems where these legacy timers are disabled
or unreliable. Even if CPUID.0x16 is supported, it seems this would silently
overwrite the dynamically calibrated global value with the CPUID base
frequency.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D40

