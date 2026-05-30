Return-Path: <linux-hyperv+bounces-11395-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC/6DVyFGmrN5AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11395-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 08:36:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0AC60B733
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 08:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AABFA3047BCC
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676A25B0A3;
	Sat, 30 May 2026 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbtxln74"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEA351C2D;
	Sat, 30 May 2026 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780122933; cv=none; b=V893kN7xvlkSjyRupwTGkEelHOJScZb8YoP0ctigsDEAUSWe9n89liCxinXTgFi2P5loPsnoiuLfPtQru2DuCse8PweO3b1HuRvW71Gjwo96swrrDczOP+C0wcPtub4XDac3dcc1uhd3/lF2JaZqwn//c8peMRMwpQk0wYT9L4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780122933; c=relaxed/simple;
	bh=evkKFr7mv9iYdH86E3P7Xtwu7LwE+GwQsTpUOJHgA8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GZMFIQT+GZHpWliZfTaO5rf+HLVhHKwhH7/Gm2+yike4yD6sIVGHN4Y2Xla8V0KmytjMbzIPMv3Bc9c0zNiPZjoNqLB1pMBMd3ivyP2d/j+SdZZjsBH/jeK2j443TbLB98PLxYBpwnBZYYDORfV5c2Fj28P0GPSId1R9l651loY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbtxln74; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D034A1F00898;
	Sat, 30 May 2026 06:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780122932;
	bh=C0G61IoecwdmJolD9R17vEIOzA8/YNqCGA9j58RPA80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zbtxln74h4kQh/EkLyp9Y5TOkjuHvY8mq6wd+HO8iaascBq9PZScIL0vqSPnximVl
	 5oCo8AqO4GDhRQ3UTgEl2j4kyR0ef3UDpQask+h3fkTank/uFmwkD7+15KPK/+xWr4
	 tbFQfsvvhHVVWhJ/zSYEo73/305qNHqeWPOMLgCG5vzwzqehGN8YZaJMT2B1hkqIdB
	 /fcJCfzPfnVh1R/zqWzYhtTB7yTvzeZYa3O4yDSmgFUS7A562T3M+PYhS6n43G7qH6
	 k6rqB/zfu0dVr4aoNmHBAGrIjZUHBSFimlcVrdbcNhnp2c4zA+SoTu/yomgnyhSmug
	 zpxn9W6JqIdFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/47] x86/xen: Obtain TSC frequency from CPUID if
 present
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260529144435.704127-22-seanjc@google.com>
References: <20260529144435.704127-22-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 06:35:31 +0000
Message-Id: <20260530063531.D034A1F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11395-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,amazon.co.uk:email]
X-Rspamd-Queue-Id: 8B0AC60B733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing Out-of-Bounds CPUID Leaf Check in xen_tsc_khz()
--

commit 7f8bc6380ca7c0fd31cb0c2bf54c9ef13654964c
Author: David Woodhouse <dwmw@amazon.co.uk>

x86/xen: Obtain TSC frequency from CPUID if present

This commit updates the Xen timekeeping code to try reading the guest
TSC frequency directly from Xen CPUID leaf 3, sub-leaf 0, ECX. If the
value is present, it uses it instead of reverse-calculating the frequency
from the pvclock multiplier and shift.

> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index 487ad838c4418..36d66abf53796 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -42,6 +42,17 @@ static unsigned int __init xen_tsc_khz(void)
>  {
>  	struct pvclock_vcpu_time_info *info =3D
>  		&HYPERVISOR_shared_info->vcpu_info[0].time;
> +	u32 base =3D xen_cpuid_base();
> +	u32 eax, ebx, ecx, edx;
> +
> +	/*
> +	 * If Xen provides the guest TSC frequency directly in CPUID
> +	 * (leaf 3, sub-leaf 0, ECX), use that instead of reverse-
> +	 * calculating from the pvclock mul/shift.
> +	 */
> +	cpuid_count(base + 3, 0, &eax, &ebx, &ecx, &edx);
> +	if (ecx)
> +		return ecx;

[Severity: High]
Is it possible for the hypervisor to support a maximum leaf of base + 2,
resulting in an out-of-bounds CPUID query here?

Looking at xen_cpuid_base(), it calls cpuid_base_hypervisor(XEN_SIGNATURE, =
2)
which only guarantees that the hypervisor supports up to leaf base + 2.

If the hypervisor does not support base + 3, this CPUID query could be out
of bounds. Processors handling out-of-bounds CPUID requests typically return
data from the maximum basic leaf.

Since the ECX register of the maximum basic leaf frequently contains non-ze=
ro
data (such as a bus or crystal clock frequency), would the if (ecx) check
blindly accept this unintended data as the guest's TSC frequency?

Using a drastically incorrect TSC frequency could break timekeeping, timers,
and the scheduler during boot.

> =20
>  	return pvclock_tsc_khz(info);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D21

