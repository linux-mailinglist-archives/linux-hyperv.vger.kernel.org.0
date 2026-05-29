Return-Path: <linux-hyperv+bounces-11376-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAfbCD/DGWqyywgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11376-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 18:47:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A113605EBC
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07B98301E6D5
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237F3EDAD5;
	Fri, 29 May 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGkKy2zW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60B3EBF35;
	Fri, 29 May 2026 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072820; cv=none; b=AN+x/A5OKkml1dicFdDpYjOR8hN5HoXnczHFTwUDVKkY3rOgy0688U8bO5a06ZEzfKv3IYs38Fz8Qi840nmOYYKUtndyle6AxcXo0VLlkeSOSX2HkeprFWNk3FJaDl9um6XZ9UK7wtsmYeYpCbboAkrfmijtxPCevc3t55wDmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072820; c=relaxed/simple;
	bh=RLCMblZAmO9z8lqczvJS97ibYbLBIdR04Q/p2oNSLf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n5o22ulQYFMoOE6SxAs+/LWUtoxOfA9iSRB4OaG3DDHJwgj+zrRUDnESLudLatceyz/L9xCtCnFmPReGurk1Ysg2rHS1So/ohhptQcpku6X43jPJgAeQcZ81HhiGngIbXP88038qP6pUdBejefJ5x0wcqfkqnxMJ7UYxVA8L8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGkKy2zW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519101F00899;
	Fri, 29 May 2026 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780072819;
	bh=P+/SyUCoUE5/t/HWSx8+Y8GgHzZUz0dCGkswepvYttI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGkKy2zWjzfTC8a5uRbZ1yVlD15PB2mkm6EwMj65ERCPoZsqZF1iJwq6HW6um+9wb
	 I8InSk+H++UAzQCA71Pg3cuN4HBpu6uHZsEjtBHHL2D4zeN/ZAWHiwsPJ8Nr1YvTq/
	 A+MQT5kFXPYTzd5iGPI7F2fFLfqEda6dT8mQ7meCJ8lOJKtvJPLAxNCeB+o5FIgeUr
	 GEnTNmmuBK+WwDqVckpyFnYUEQuQ2zd/SLxxs5F/EVaatc/NckaL8OUnXc+bRNDLG1
	 BkJRy6EDfIYJuugBCa4e+DkOWMfFHb5pbv297gcoeDzod1HIWBXFM9q+ZfnjLuh7gi
	 2+jv+SOvqViRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/47] x86/acrn: Mark TSC frequency as known when
 using ACRN for calibration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260529144435.704127-10-seanjc@google.com>
References: <20260529144435.704127-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:40:18 +0000
Message-Id: <20260529164019.519101F00899@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11376-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A113605EBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditionally setting X86_FEATURE_TSC_KNOWN_FREQ skips TSC ref=
inement even if the hypervisor fails to provide a valid TSC frequency.
--

commit 44594dfd95dd7a3adcfc1b7f3c8d37e15ed4e143
Author: Sean Christopherson <seanjc@google.com>

x86/acrn: Mark TSC frequency as known when using ACRN for calibration

This commit marks the TSC frequency as known when using ACRN's PV CPUID
information, assuming the hypervisor explicitly provides it.

> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index ad8f2da8003b3..0303fe6a2efa7 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -33,6 +33,8 @@ static void __init acrn_init_platform(void)
>  {
>  	/* Install system interrupt handler for ACRN hypervisor callback */
>  	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
> +
> +	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

[Severity: Medium]
Does this unconditionally skip TSC refinement even if the hypervisor fails
to provide a valid TSC frequency?

ACRN TSC frequency is obtained via acrn_get_tsc_khz(), which queries
cpuid_eax(ACRN_CPUID_TIMING_INFO). If the hypervisor does not support this
leaf or returns 0, the kernel falls back to early hardware calibration
(e.g., PIT/HPET via x86_platform.calibrate_tsc()).

Because X86_FEATURE_TSC_KNOWN_FREQ is unconditionally forced here,
init_tsc_clocksource() will assume the frequency is known and skip the
refined calibration phase. This regression locks in the imprecise early
calibration and could cause time drift.

I see this regression was addressed in a later commit b0e7d8e1edd52
("x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ for PV code")
which correctly gates the capability setting on known_tsc_khz !=3D 0.

>  }
> =20
>  static bool acrn_x2apic_available(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D9

