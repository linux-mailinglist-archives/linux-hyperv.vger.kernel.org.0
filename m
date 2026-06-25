Return-Path: <linux-hyperv+bounces-11680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PboXDitqPWp72wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11680-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:49:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C636E6C801C
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:49:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dH3Mihne;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11680-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11680-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EC34300132D
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ECE3EB110;
	Thu, 25 Jun 2026 17:49:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8525785C
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 17:49:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409768; cv=none; b=tv2JtLpzInYn2B3clMMrjXzHPAfNifoWZDpLFm2cFV485Ue7KHWPNZ4M12RDp12rh8w4gf9ErJj/JOoUI1IStzqFWE1LpP/c1CUL1xDW2P+Xlqmr9ruozIyUZTZClkmAQUA6oz+Hc/8M6ZUXSWgrP+jgHZLoElESvfq5ZUEsx70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409768; c=relaxed/simple;
	bh=I12qWYO4nVXCWSKqK7MkaFaBAPK2raRJEuZzbA2S0AE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCFES+qeWCayiAdcN+fZ38VgCDn4ve+bLr+18DF+VShCMOj3Xpbv+Sodu3Vgf+FYo8hWiQUjxlq1wN2Mt5bo0gPtKDC92e9FiG9FV876w6pkquKYsVPLbeidtBhO60eHJV3/M4xiMIBjiB0YPy+v5efKFIMPn30ZVopONJ6NqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH3Mihne; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87671F00A3A;
	Thu, 25 Jun 2026 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782409766;
	bh=vCH/4gpStn8YxgDzrPfQb2l7QBpwwzHuz4haQ77GWYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dH3Mihne1FcTJE0tJG1oHLLLS+3RBHOPDpcbad81g09hy4oidfPLFShFpyPbZJBVU
	 7/FhG7m5GOydkVVk58VxLQwAag1V24WkvR+vtPGZmG3LilEX//SKA+/5NAW86w3qI6
	 a+9aRa63ug8Uza4aO7K1ImrHxnUgI83oAA5KzJu8ZwmJFp/O0Auj3r4/Yys3hMqtSm
	 3aUK0WYZT1PWr74XoDN5MgZpqTmaCBuW1YveSoe/6h9TbO+klJiL/fdb1SmO76tW9o
	 Cvu1axh/Qo9U21Jk5rlEvjUNyZOmGaFJZw99KGTtqZaVvhpYuV6kItLPpEMpe6Re3G
	 gJ4WGFN3F1bCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260625173500.1995481-4-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-4-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:49:24 +0000
Message-Id: <20260625174926.A87671F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11680-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C636E6C801C

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `hv_hostcall_array` is allocated with `kcalloc()`, which does =
not guarantee the strict 256-byte alignment required by the RMM for `SMC_RS=
I_HOST_CALL`.
- [High] If `hyperv_init()` fails, `hv_hostcall_array` is freed but panic n=
otifiers are left registered, causing a fatal NULL pointer dereference duri=
ng a subsequent panic.
- [Low] The early boot initialization function `hyperv_init()` contains unn=
ecessary memory allocation failure handling and cleanup logic for `hv_hostc=
all_array`.
--

commit 906cd2b30d2ff5884265fe39d28d07e982c9f874
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms

This commit adds a per-CPU rsi_host_call array allocation for Arm CCA
Realms. It routes Hyper-V hypercalls through the RSI_HOST_CALL interface
instead of HVC.

> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d74..7d536d7fb557e 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c

[ ... ]

> @@ -85,6 +96,20 @@ static int __init hyperv_init(void)
>  	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
> =20
> +	/*
> +	 * The RSI host-call buffers are only ever used when
> +	 * is_realm_world() is true. Skip the allocation on non-Realm
> +	 * guests. A single contiguous array of nr_cpu_ids entries is
> +	 * allocated; each CPU indexes into it by its processor ID.
> +	 */
> +	if (is_realm_world()) {
> +		hv_hostcall_array =3D kcalloc(nr_cpu_ids,
> +					    sizeof(struct rsi_host_call),
> +					    GFP_KERNEL);

[Severity: High]
The RMM requires the IPA of the host call structure to be strictly 256-byte
aligned for SMC_RSI_HOST_CALL. Since standard slab allocators like kcalloc()
do not guarantee alignment beyond ARCH_KMALLOC_MINALIGN, could this result
in an unaligned physical address being passed to rsi_host_call() in
hv_set_vpreg()?

> +		if (!hv_hostcall_array)
> +			return -ENOMEM;

[Severity: Low]
This isn't a bug, but since hyperv_init() is an early_initcall executed
early in the boot process, is it necessary to handle this allocation failure
gracefully? Early boot memory allocations typically do not need complex
failure paths, as a failure at this stage implies the system cannot boot.

> +	}
> +
>  	/* Setup the guest ID */

[ ... ]

> @@ -125,6 +151,10 @@ static int __init hyperv_init(void)
> =20
>  	hyperv_initialized =3D true;
>  	return 0;
> +
> +free_hostcall_mem:
> +	hv_hostcall_free();
> +	return ret;

[Severity: High]
If hyperv_init() fails here, hv_hostcall_array is freed and set to NULL.
Since the panic notifiers registered earlier in hv_common_init() are not
unregistered on this error path, will this cause a newly introduced NULL
pointer dereference during a later panic?

When the leaked notifier invokes hyperv_report_panic(), it calls
hv_set_vpreg(), which unconditionally accesses the array:

hv_set_vpreg() {
    ...
    hostcall =3D &hv_hostcall_array[smp_processor_id()];
    memset(hostcall, 0, sizeof(*hostcall));
    ...
}

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625173500.1995=
481-1-kameroncarr@linux.microsoft.com?part=3D3

