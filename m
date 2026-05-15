Return-Path: <linux-hyperv+bounces-10976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H6EvOcd8B2o75gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10976-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:06:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D241855742A
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E5DE3003482
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758438D017;
	Fri, 15 May 2026 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1Ny7a5J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8F37F00B
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875586; cv=none; b=J2mOws4Bbf3CGUu/iXannAw+k0BQVTLGKD+Lib3VMMQCjhaWyHPK1B8F430HWhkeenr+xbPTaWRhsBV8qhQw6TpfS6sniaHk+bVfhOqiVf7QB7WjpSdZRtOEsYTENvXB1ZLKWF7szKAQezv0olO7Vkjj4e7uTsraKii22w8LJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875586; c=relaxed/simple;
	bh=vsjh5+eQX8GJp/UyD6VxR7kLK+VQlRFS486L25vYmHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zro2ch3rbD3WyobC4IOhdzGuKzx0O7cTSLstnP6o9b40NAZp6dSJlttvCwjDCPUV1h1AQVWUg5Vq0MSgf507qyVGB4bdcJekofELQH4Y5GkprXnDJwt5zGAuphXI4thVkotiu9KIVhtjRuOpA8z7XE5KTHNstbNePSeDbyJGSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1Ny7a5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3294BC2BCB0;
	Fri, 15 May 2026 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875586;
	bh=vsjh5+eQX8GJp/UyD6VxR7kLK+VQlRFS486L25vYmHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q1Ny7a5JAlq0W5YMiG4bVSEiNikzLegD7VMx/62+z9K+ykg5jY+mUyzUZefbrOHes
	 JGdnj45n7MHc4yRUbAY6xpM9qjVgEMtRigEPPMJ2AfKyr3sEyW/5tYYt6ROhaOjoes
	 vTK2LF8Aw/4pZyGBO0/RZAssmbUVa3w8LXMNKIltih4zIqJjAXDplw4N0OZbYq+/z0
	 I2sYTUa+fEY1jHeBnb1mKbHNMIQqVrIVfP+JY90qGPdcLEaDRkDoeH/Q6KYt++skOI
	 r+afH6pKNaROh0GDkVIl7OuoZv7kopj6Yy67DvgZLOWs1K5bb6dPoOOwSiCRDhuZpm
	 1BOx2P9Occ7wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC
 freq calibration routines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-3-seanjc@google.com>
References: <20260515191942.1892718-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:06:25 +0000
Message-Id: <20260515200626.3294BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: D241855742A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10976-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new helper function `tsc_register_calibration_routines` is miss=
ing the `__init` attribute.
--

commit ac711dd28fcd18f28a56325512fc567fdd7d6098
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Add helper to register CPU and TSC freq calibration routines

Add a helper to register non-native CPU and TSC frequency calibration routi=
nes.
This consolidates handling of common TSC properties forced by hypervisors
and guards against overriding a TSC calibration routine with a less trusted=
 one.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index f92236f40cbcc..7e639c0a94a21 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1281,6 +1281,23 @@ static void __init check_system_tsc_reliable(void)
>  		tsc_disable_clocksource_watchdog();
>  }
> =20
> +/*
> + * TODO: Disentangle AMD_MEM_ENCRYPT and make SEV guest support depend on
> + *	 HYPERVISOR_GUEST.
> + */
> +#if defined(CONFIG_HYPERVISOR_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
> +void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(vo=
id),
> +				       unsigned long (*calibrate_cpu)(void))

This isn't a bug, but should tsc_register_calibration_routines() be marked
with the __init attribute?

Since all callers such as kvmclock_init(), snp_secure_tsc_init(), and
ms_hyperv_init_platform() are __init routines, and this function writes to
the x86_platform structure which is typically __ro_after_init, adding the
__init annotation would allow it to be discarded after the boot process
completes.

> +{
> +	if (WARN_ON_ONCE(!calibrate_tsc))
> +		return;
> +
> +	x86_platform.calibrate_tsc =3D calibrate_tsc;
> +	if (calibrate_cpu)
> +		x86_platform.calibrate_cpu =3D calibrate_cpu;
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D2

