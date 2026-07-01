Return-Path: <linux-hyperv+bounces-11783-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2cbTLHpzRWrzAQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11783-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:07:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C16F1458
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HYcW8ifl;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11783-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11783-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AB7D305E1BE
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECEE288C81;
	Wed,  1 Jul 2026 19:52:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C27431E7B;
	Wed,  1 Jul 2026 19:52:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935567; cv=none; b=riz29Pg1OKEpIEo3c+k+Bi0QSyNs5ejr4af6Xqlsjdv5RelDFCe/oy+iXc19GAghZhXgFRVuAiA5p2QgE9JzWuyj6ewpkXOFC6ToNP4Jz0Rfof/JjdeHnfyyNI1xm1OvLqWJeJMCqf+oCQRFRpaFnR5gzBN5B/BaJzk6jEn1NXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935567; c=relaxed/simple;
	bh=v9ypOhuLzby2y5I0BqI3IKmlE9ia3q9uAf89NQfGrGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3dPYaG44L25l79hRkf0K8MMwoz0o3oznmvSJS/csMdJrlOoumgI2Z+Zul/Wn6zjE+QkZLhhAWqvwKhXk4oI8cWAVz5p7bSgv2g1pH8DXaWyq+MJDlPvC9X91SYV7e8egb42w6QUyLMow+iBm8j1Z4+ukCsmiCmB5Eg6zfUKp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYcW8ifl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467DB1F00A3A;
	Wed,  1 Jul 2026 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935565;
	bh=UoISlQwd1D3V7COTvqZiyb1RMc2Wrne/ds568cT5vG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HYcW8ifl5zw6J+fHJkqAkpjiSmOwhL1cUcHUwK4d4pRxEHAM+3ONCpC9wEDKLEB18
	 a1JYjhvfHmsDGfT3uK0oQp+oOHeDWnQGkIPNWSLwfSmK4oT0+HuYvy71zi8lCZ2NtM
	 jB2Hz7StIDFrkRbx+dxJWrAFmGjjJCX+X4dQjaK3qYNkzeDXdfrtFKAC/IdgzSjOIU
	 rkwA+W/4+Za6/Hh6MDU8+yl/sI0BiJkfleRYf+Vmr3JG32vMLvmsqM+K3CUE8MT5Aa
	 a4HBQMdVMJU5jhH/UHN5/F3OdR6vay60EGzg9N+68VWqwlfVXRvKTApJ8fH3+59Rpo
	 1QuziSjkgn30g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/51] x86/acrn: Register TSC/CPU frequency callbacks
 iff frequency is actually in CPUID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260701193212.749551-13-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-13-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:52:44 +0000
Message-Id: <20260701195245.467DB1F00A3A@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11783-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:linux-hyperv@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D2C16F1458

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ACRN hypervisor integration statically hardcodes its CPUID leaf to=
 0x40000010 without applying the dynamic base offset, breaking nested setup=
s and potentially causing severe timekeeping corruption.
--

commit 8beac699ed1da5364ebdf7f1cc4475bed5521d60
Author: Sean Christopherson <seanjc@google.com>

x86/acrn: Register TSC/CPU frequency callbacks iff frequency is actually in=
 CPUID

This commit modifies ACRN initialization to only register the TSC and CPU
frequency override callbacks if the hypervisor actually provides a non-zero
frequency in its CPUID leaf. It achieves this by reading the frequency
during platform initialization and caching the result.

> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index ad8f2da8003b3..dc71a6fdd4613 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
[ ... ]
> @@ -26,13 +28,19 @@ static u32 __init acrn_detect(void)
> =20
>  static unsigned int __init acrn_get_tsc_khz(void)
>  {
> -	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
> +	return acrn_tsc_khz_cpuid;
>  }
> =20
>  static void __init acrn_init_platform(void)
>  {
>  	/* Install system interrupt handler for ACRN hypervisor callback */
>  	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
> +
> +	acrn_tsc_khz_cpuid =3D cpuid_eax(ACRN_CPUID_TIMING_INFO);

[Severity: High]
This is a pre-existing issue, but does hardcoding ACRN_CPUID_TIMING_INFO to
0x40000010 without dynamically applying the base offset break nested setups?

If Linux is booted as an L2 guest with an L0 hypervisor like KVM occupying
the base 0x40000000 leaf, and L1 ACRN resides at 0x40000100, acrn_detect()
correctly finds ACRN using cpuid_base_hypervisor() at the 0x40000100 base.

However, acrn_init_platform() hardcodes the fetch:

arch/x86/include/asm/acrn.h:
#define ACRN_CPUID_TIMING_INFO        0x40000010

Will this bypass the dynamic base detected earlier and read the timing info
from the wrong hypervisor's CPUID space (e.g., KVM's L0 frequency)?

If nested under a hypervisor that returns garbage for 0x40000010, could
acrn_tsc_khz_cpuid be populated with a non-zero bogus value and corrupt
guest timekeeping?

> +	if (acrn_tsc_khz_cpuid) {
> +		x86_init.hyper.get_tsc_khz =3D acrn_get_tsc_khz;
> +		x86_init.hyper.get_cpu_khz =3D acrn_get_tsc_khz;
> +	}
>  }
> =20
>  static bool acrn_x2apic_available(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D12

