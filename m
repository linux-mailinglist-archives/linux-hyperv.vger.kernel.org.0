Return-Path: <linux-hyperv+bounces-11784-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 51uAA0VwRWr2AAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11784-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:53:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 905756F1228
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:53:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MU68xS68;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11784-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11784-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09C07302F24C
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FA346ACD;
	Wed,  1 Jul 2026 19:53:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C273033E1;
	Wed,  1 Jul 2026 19:53:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935618; cv=none; b=rWogwGZuhFaXcQxcfV+0OyDKiHmv51BZgiBs412ddZoCWC12jCscDw7KFs2VY/bXPO6x+8G+2yLZVAfFC7uD0yU1WB57tjYEiIKRv1GCTiE1+nSdcGLIkC7FkNmy6fqKfP19vJeP0uQgGLwhqI+sXIQzM4rXFRrKR3P+Gdfv/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935618; c=relaxed/simple;
	bh=uSG9EkbuDXwL/9QMcgvILPgIJLFeIzOoOi9nPuVP9PQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BSZfh6pY+/MnN1flMzjcqw1g/zqjBDH62CgAkjvd+ZvRfhjyk43J735NS43TUDMKFd+U6S5Fw0gl928g6hBJIjen2Y/CCPk1Ot1f7FBVoZnT9ZOaY/4nT0SBJJtjrw2wKA2cqiAItUZVtMtv/wXC0erG+Cmk+3E2RYxglQ/g3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU68xS68; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1F01F000E9;
	Wed,  1 Jul 2026 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935617;
	bh=9Jci8C7rM9CuydyCtib8kjeGpRNVeZBNYfRI1R9/TlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MU68xS68e1cZR9lGRG+eAiNPSTU1+BoeFZj2d2Jf67L8iYuXWMjcLHEx3j3+8UN2k
	 LeADLgpNfVQQy1vD2mCi/yLGhndTKZwVNICErlnYXSnehOCyjsUKSSgehy9qGPXqRn
	 +3Uo3zxXb/ot3XCZXdR8XqA42wHL+X6cu4/MmHMIkwNoFaY/MD8/r/k34KRc+GpPYS
	 OAb2N1PsQsPo4c8EnN/vx5teGG88TLVXJn/fJWf2oiNbHbXUZcXJmuOl7HE4S6qA/S
	 pflTeVufdxih8hW0btGZhZIqvI/uHNGgPB2O+QkaeAVdwfj79lEPqLW5AC6TfQd7NQ
	 R1mn2rxS4WUlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/51] x86/sev: Don't override CPU frequency
 calibration for SNP's Secure TSC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260701193212.749551-7-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:53:36 +0000
Message-Id: <20260701195337.2E1F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11784-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 905756F1228

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch removes the `calibrate_cpu` override to allow the CPU =
base frequency to differ from the TSC frequency, but fails to account for `=
determine_cpu_tsc_frequencies()` which will forcefully clobber `cpu_khz` if=
 it diverges by more than 10%.
--

commit 6d3b9e81661ead5f25434666266aec6514dadaa8
Author: Sean Christopherson <seanjc@google.com>

x86/sev: Don't override CPU frequency calibration for SNP's Secure TSC

This commit removes the override of the kernel's CPU frequency calibration
routine when registering SNP's Secure TSC. It aims to decouple the CPU base
frequency from the TSC frequency, as exposing APERF/MPERF requires an
accurate CPU frequency.

> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
> =20
>  	snp_tsc_freq_khz =3D SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->t=
sc_factor);
> =20
> -	x86_platform.calibrate_cpu =3D securetsc_get_tsc_khz;

[Severity: Medium]
Will this removal be sufficient to decouple cpu_khz from tsc_khz if they
diverge significantly?

Looking at determine_cpu_tsc_frequencies() in arch/x86/kernel/tsc.c, there
is a generic sanity check that enforces a 10% limit on the difference
between the two frequencies:

arch/x86/kernel/tsc.c:determine_cpu_tsc_frequencies() {
    ...
    else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
        cpu_khz =3D tsc_khz;
    ...
}

If the true host CPU frequency diverges from the guest TSC frequency by more
than 10%, won't this logic forcefully overwrite the correct cpu_khz back to
tsc_khz, unintentionally undoing the fix for the APERF/MPERF calculation?

>  	x86_platform.calibrate_tsc =3D securetsc_get_tsc_khz;
> =20
>  	early_memunmap(mem, PAGE_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D6

