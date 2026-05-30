Return-Path: <linux-hyperv+bounces-11394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCeoIKOCGmr84wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11394-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 08:24:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C86CD60B6E4
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 08:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D1C3040D80
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067E36A377;
	Sat, 30 May 2026 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2jGWcNO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848336A017;
	Sat, 30 May 2026 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780122272; cv=none; b=OdbyffAZEJ06nioAQXDwk4lo2ozVEnBSdekD9nH55YvafKdZdKxy/YQ8f3KPnEohEkYXoOdDd+KfwZABbHXcYltuTMCNDqHFV0jvUyKMxbSvQ9ZylGsAnqgbMdRVW1xpaUh231es6s+S/yUPyKJGDbr6y9dpVa8/gQhwF7VQOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780122272; c=relaxed/simple;
	bh=5yHsplQGGFheIIw532as+DJtPgtcSJKorPP2NxE+O/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UBaA2/ZDXSEcglDfeM8ElIyzQhuXdj5MJP17K3aUnymOwEZlnZ+vwA46WVeYXDLR0GGPwEdsoiaomjfzJM67utRZvGyirLelwyfbOMjTvggqb01z3YoIVvMPyXelQ9pf+pa2uHwRQAXGlHPqWd2p2znStbD16gdawYoHu78ZQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2jGWcNO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9A31F00893;
	Sat, 30 May 2026 06:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780122270;
	bh=FfzJZFF7HoUBZuzlW9jgD2vEus+hPA2d+RKT5/1A4GA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2jGWcNOIEbKMEb50Herd7fgAXCPH4xYM2JQIPNz51iIY2Dmx617q5sv2Sd571tHl
	 MQZDrTTvgyBeUdRCJ3V32Kv/VVvPOjd3fmeU0n4ZyIkqII/mE9CN2MvuilTaf92/dS
	 p16gj+/cLgg3gyeURIl5h4sRyRp62JUTeOrGnoy7YIcgwzkZtCo0C59oYGoEoEscHo
	 DxtJP3B88VBkx6JRtKC1dym0IkyoXfoYsLYCs5ZsVHmBl4S8iXe40yxX4YgxhuF7yP
	 rad2ofNi1Dv8DDZuF/TrtVcBF/pWbZBkV3C2DDtVblp1VXK0Mya0s8jUplaGT5Ck2O
	 wc+QI70lPMBGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/47] x86/kvm: Get CPU base frequency from CPUID
 when it's available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260529144435.704127-21-seanjc@google.com>
References: <20260529144435.704127-21-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 06:24:30 +0000
Message-Id: <20260530062430.AF9A31F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11394-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: C86CD60B6E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The KVM patch attempts to decouple the virtual CPU base frequenc=
y from the TSC frequency by explicitly reading CPUID.0x16, but this intent =
is defeated by the core x86 timekeeping code that forcibly clamps `cpu_khz`=
 to `tsc_khz` if they differ by more than 10%.
--

commit 399b0f26d4487d316fd05edb4e7df98c8da6205f
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Get CPU base frequency from CPUID when it's available

This commit uses CPUID.0x16 to retrieve the CPU base frequency in KVM inste=
ad
of assuming it matches the TSC frequency. It introduces kvm_get_cpu_khz and
hooks it into x86_init.hyper.get_cpu_khz during platform initialization.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c

[ ... ]

> @@ -1049,6 +1055,14 @@ static void __init kvm_init_platform(void)
>  #endif
>  	}
> =20
> +	/*
> +	 * Prefer CPUID.0x16 over KVM's PV CPUID when possible, as the base CPU
> +	 * frequency isn't necessarily the same as the TSC frequency.
> +	 */
> +	kvm_cpu_khz_cpuid =3D __cpu_khz_from_cpuid();
> +	if (kvm_cpu_khz_cpuid)
> +		x86_init.hyper.get_cpu_khz =3D kvm_get_cpu_khz;
> +

[Severity: Medium]
Will the CPU frequency actually remain decoupled from the TSC frequency when
they diverge significantly?

During early boot, tsc_early_init() calls this hook and passes the value
down to determine_cpu_tsc_frequencies() in arch/x86/kernel/tsc.c. Inside
determine_cpu_tsc_frequencies(), there is a clamp that forces cpu_khz to
match tsc_khz if they differ by more than 10%:

arch/x86/kernel/tsc.c:determine_cpu_tsc_frequencies() {
        ...
        else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
                cpu_khz =3D tsc_khz;
        ...
}

If the CPU base frequency from CPUID.0x16 and the TSC frequency differ by
more than 10%, doesn't this unconditional clamp silently overwrite the newly
populated cpu_khz, reverting to the old behavior that this patch aims to fi=
x?

>          /*
>           * If the TSC counts at a constant frequency across P/T states, =
counts
>           * in deep C-states, and the TSC hasn't been marked unstable, tr=
eat the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D20

