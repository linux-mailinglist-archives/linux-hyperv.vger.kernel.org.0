Return-Path: <linux-hyperv+bounces-11571-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id snf4AaZgKGrJCwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11571-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:51:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750E6636B5
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:51:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i+zC7B0R;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11571-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11571-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 828C8303FB9C
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6205B331EC9;
	Tue,  9 Jun 2026 18:51:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207263AEF30
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 18:51:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031067; cv=none; b=G3E8Fbhxk/8uVPbaJ7ctLnIIEK88IACWVz1+PQN675/kPHYBdtDyXurIjCSprDd3v0A6RwPbpvzahnKNeQBjuAYN+60Fgmc1dh81ULPtvRogo485KHhaHu/OEUmvdotEPhBVQvYxkGWddhW3t4M0D0nBj7CHI0j5qYRSfOWNBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031067; c=relaxed/simple;
	bh=9z9uCZSaa7UjJose2P6N/UOYqEk59NZYbgxq8R2gPZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HYzsLlciGMhg0joNGBkJbw9FsXMLz/tVrmrviEyFd4NVKeGJijwCqI5AlbM0YgyAJt6Qre0mxfz8ALFo0UsKUareWLAW4nh0r1yunm1zimfWg58p7ejUjw8kvRR81+c4PSjr0DiCm1sEWxKDysjQn+mub4xJQXKPOsHLJMa0kmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+zC7B0R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A39E1F00893;
	Tue,  9 Jun 2026 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031065;
	bh=b+ujqpsxSxZmIHiLTseL14tk3sskgKtw9D9Hnq0tL8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i+zC7B0Rxxu1i/OfeTuvrMSQuZ7KT3xkSO/LmEJ4xlvi2tNfsQR2ElFFz+UcPtfY5
	 nXNPld89KntJvvNerGbNgonRLt/A3468ndjqTqBiuuVcpBc4VQDAt+mw7H9jjGEQIS
	 w2y4Km83+3LoPF/RU2axiz3/6NhHM42iTDm8RfnuIK5Yd4izFGeNRN0QZVojLbcPuS
	 G6zPhl3nk1V40ekzOTlchmi7f2sZrMSlAGTGzJbG+F3cwS1J2+Ag5oLiDPJMyJbjP7
	 AGAqr6yX03UUgzz3m2JhoX+yRScM4OY9FzxFaGYmhJkobGuOnLksa6wlmxBIM+LPSO
	 8B/3gs83T1HuQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260609181030.2378391-4-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-4-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:51:05 +0000
Message-Id: <20260609185105.8A39E1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11571-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5750E6636B5

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The generic hypercall wrappers (`hv_do_hypercall`, `hv_do_fast_hyp=
ercall8`, `hv_do_fast_hypercall16`) were not updated to use the RSI_HOST_CA=
LL interface, breaking hypercalls for CCA Realms.
- [High] Missing NULL pointer check for the dynamically allocated per-CPU `=
hostcall` buffer in `hv_set_vpreg()` and `hv_get_vpreg_128()` can cause a r=
ecursive crash during a panic.
- [Low] Complex error handling and cleanup logic for early boot memory allo=
cation failures violates subsystem guidelines.
--

commit 286a7465cb0cf6433c1d0e69d74a2bf4a0c1a935
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms

This patch introduces the hyperv_pcpu_hostcall_struct to support Arm CCA
Realms, which must route hypercalls through the RSI_HOST_CALL interface.
It allocates this per-CPU structure for the boot CPU and secondary CPUs.

> Arm CCA Realms cannot issue Hyper-V hypercalls via HVC; the guest must
> route them through the RSI_HOST_CALL interface, which takes the IPA of a
> per-CPU rsi_host_call structure as its argument.

[Severity: High]
Does this patch miss updating the generic hypercall wrappers?

Looking at hv_do_hypercall() in arch/arm64/hyperv/hv_core.c, it still issues
an HVC instruction unconditionally via arm_smccc_1_1_hvc().

Since these generic functions are heavily used throughout the Hyper-V stack
(including early initialization like hv_get_partition_id()), could a CCA
Realm guest crash when it inadvertently executes the trapped HVC instructio=
n?

> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d74..08fec82691683 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c

[ ... ]

> @@ -60,6 +66,46 @@ static bool __init hyperv_detect_via_acpi(void)
> =20
>  #endif
> =20
> +static void hv_hostcall_free(void)
> +{
> +	int cpu;
> +
> +	if (!hyperv_pcpu_hostcall_struct)
> +		return;
> +
> +	for_each_possible_cpu(cpu)
> +		kfree(*per_cpu_ptr(hyperv_pcpu_hostcall_struct, cpu));
> +	free_percpu(hyperv_pcpu_hostcall_struct);
> +	hyperv_pcpu_hostcall_struct =3D NULL;
> +}
> +
> +static int hv_cpu_init(unsigned int cpu)
> +{
> +	void **hostcall_struct;
> +	gfp_t flags;
> +	void *mem;
> +
> +	if (hyperv_pcpu_hostcall_struct) {
> +		/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> +		flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> +
> +		hostcall_struct =3D (void **)this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		/*
> +		 * The hostcall_struct memory is not freed when the CPU
> +		 * goes offline. If a previously offlined CPU is brought
> +		 * back online, the memory is reused here.
> +		 */
> +		if (!*hostcall_struct) {
> +			mem =3D kzalloc_obj(struct rsi_host_call, flags);
> +			if (!mem)
> +				return -ENOMEM;
> +			*hostcall_struct =3D mem;
> +		}

[Severity: High]
Is it safe to assume this pointer is always initialized during a panic?

If a secondary CPU panics before or during its bringup phase, its per-CPU
hostcall_struct pointer remains NULL.

The globally registered Hyper-V panic notifier runs on the panicking CPU and
calls hv_set_vpreg() and hv_get_vpreg_128(). These functions unconditionally
fetch the local pointer and perform an unprotected memset(hostcall, 0,
sizeof(*hostcall)).

Additionally, if cpuhp_setup_state() fails later during initialization,
hv_hostcall_free() clears hyperv_pcpu_hostcall_struct to NULL. Since
hv_common_free() does not unregister the panic notifiers, a subsequent
panic would cause this_cpu_ptr(NULL) to evaluate to __my_cpu_offset.

Could doing a memset() on these uninitialized pointers trigger a double
fault in the panic handler or memory corruption, losing the crash report
entirely?

> +	}
> +
> +	return hv_common_cpu_init(cpu);
> +}

[ ... ]

> @@ -85,6 +133,27 @@ static int __init hyperv_init(void)
>  	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
> =20
> +	/*
> +	 * The RSI host-call buffer is only ever used when
> +	 * is_realm_world() is true. Skip the per-CPU allocation on
> +	 * non-Realm guests.
> +	 */
> +	if (is_realm_world()) {
> +		hyperv_pcpu_hostcall_struct =3D alloc_percpu(void *);
> +		if (!hyperv_pcpu_hostcall_struct)
> +			return -ENOMEM;
> +
> +		hostcall_struct =3D (void **)this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		if (!*hostcall_struct) {
> +			mem =3D kzalloc_obj(struct rsi_host_call);
> +			if (!mem) {
> +				ret =3D -ENOMEM;
> +				goto free_hostcall_mem;

[Severity: Low]
Is this complex error handling and cleanup logic necessary here?

Since hyperv_init() is an early_initcall, physical memory should be
available. A failure at this stage typically implies the system cannot
boot anyway, making this teardown logic unnecessary dead code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609181030.2378=
391-1-kameroncarr@linux.microsoft.com?part=3D3

