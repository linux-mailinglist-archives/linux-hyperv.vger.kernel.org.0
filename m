Return-Path: <linux-hyperv+bounces-11785-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u8woLbBzRWoOAgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11785-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:08:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050576F1491
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:08:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nZTCMV2X;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11785-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11785-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA48E3011869
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696D431E7A;
	Wed,  1 Jul 2026 19:54:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FB431E6E;
	Wed,  1 Jul 2026 19:54:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935681; cv=none; b=tSS8mmmiPx+PqmlA6dYlCeUbeVEaSKOiICc0hj+GWspsx7+xxld1d5kravTAOL9cujS63Qb/N0A79oTatU+mRUv/IiTLzvIEo5YUbjfcZ7XQNJ1y73kmDiXLa0sT5HhqmpPoaZsO392rKYX4AZK14bUwhTGpwudKYuIZkIIHF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935681; c=relaxed/simple;
	bh=enAhnyGQrE5rpr81VnfW8v9km9o6puMQzCNThM26N3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b+dLwtAm2ZeYhMkWdNziN+/fON+YwM9uFWFtMuTFCfWSBZP/a5wwHUTiRBxMeW6YOFgoHiEPoTqNMEMWT2JGfbafnGomxZGc0y0L6VD0c65o7unUzSYdLMf98Zu7b6xrvOyNWSqCGgDZ3Vjjbxchj9+GXxVd3cUAIUTUA9Ft38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZTCMV2X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB301F000E9;
	Wed,  1 Jul 2026 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935680;
	bh=NcGcxsfkrm97VIqYVzSN/seHC8ItFKZXx7nMoUKAWl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZTCMV2X5OOrAGa9mubb85Cqc0NYAhnvu0K975CRPNBTJ+gR87fXtbMxS0TThaJTg
	 YSth9VFsO5skT9r7Qdnv6ALbJRM7DW38uYlkCCbSAKlylu1iTjM3n5OhiZIqIfLbsE
	 Q+oMr2pwgLY8jt9Fys4aQps0O7DsDIO7QFg39avt4/kM4OZx8p2wIrXDB0qOaV6QM6
	 J+v93Lfkheqwg9lYBAWrcmQTveIQJzX1tunk7L0wxvL2FGTtFdG3n17SnpNKTiqDlc
	 UlOe+OTn0WywY9EE8dWVhQnHtAPnKr2MNj9smglcgyUylMYuTwPsf/JoPc94wPGTfD
	 t3FHS/RNtO6Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/51] x86/kvm: Get CPU base frequency from CPUID
 when it's available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260701193212.749551-25-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-25-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:54:39 +0000
Message-Id: <20260701195439.EDB301F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11785-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 050576F1491

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The base CPU frequency obtained from CPUID.0x16 is unconditional=
ly clamped back to the TSC frequency if it differs by >10%, defeating the p=
urpose of the patch.
--

commit 1331572140e49219bdcc6ceabc0370555476adde
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Get CPU base frequency from CPUID when it's available

This commit reads CPUID.0x16 to fetch the CPU base frequency if valid.
It then sets x86_init.hyper.get_cpu_khz to kvm_get_cpu_khz to avoid
assuming the CPU base frequency matches the TSC frequency.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 1cef54e1e7d9e..6c7011ff7bd13 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c

[ ... ]

> @@ -1041,6 +1047,14 @@ static void __init kvm_init_platform(void)
>  		}
>  	}
> =20
> +	/*
> +	 * Prefer CPUID.0x16 over KVM's PV CPUID when possible, as the base CPU
> +	 * frequency isn't necessarily the same as the TSC frequency.
> +	 */
> +	kvm_cpu_khz_cpuid =3D __cpu_khz_from_cpuid();
> +	if (kvm_cpu_khz_cpuid)
> +		x86_init.hyper.get_cpu_khz =3D kvm_get_cpu_khz;

[Severity: Medium]
Will this new CPU frequency actually be used if it diverges significantly
from the TSC frequency?=20

Looking at determine_cpu_tsc_frequencies() in arch/x86/kernel/tsc.c, there
is existing logic that unconditionally clamps the CPU frequency back to the
TSC frequency if they differ by more than 10%:

	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
		cpu_khz =3D tsc_khz;

Does this clamping defeat the purpose of this patch for guests running on
hosts where the base CPU frequency and TSC frequency differ by >10%?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D24

