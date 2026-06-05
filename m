Return-Path: <linux-hyperv+bounces-11506-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1xymCxSeImohbAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11506-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 11:59:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92030647202
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 11:59:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="in/tGv/S";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11506-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11506-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F40A302E7EA
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A43DC861;
	Fri,  5 Jun 2026 09:58:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287E3CD8AF;
	Fri,  5 Jun 2026 09:58:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653508; cv=none; b=Tv+5HUvsGvu6q04sf+m5GpZMQjcogxx9VvUXjw67B+bsS43HcUNJfnufsBHvYOD7cum19eyN/FdiIpTeHffcbFBFRxFqXi8w2Cj8NcRwpDJPKwrJNJ/k3XlJQQnsF6wOlvhwJesCK0JP3RseOCthTzamcVsCOEwIKWpGqD+ZqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653508; c=relaxed/simple;
	bh=AQ7qOOCOfTmM7zXsBWbIkgM+65oU+F7u/bUrguIvmCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s1to1qV2gZlm4ISaKylBwID5nk2Sf3hc0KNddD9/nwgK5uDLbpKqi0GIlWYeX5mFgGAZfVkbIuHFLZaH1KWxk2MaGuBy/VAp800F7YfKMTOZQv0CmM8HFNnLBwGEth/2IKovXQQgEfJCqnQqdxf6KpYbZybqpltAwIIRXKiIDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in/tGv/S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6563E1F00898;
	Fri,  5 Jun 2026 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653507;
	bh=Jlf4tqhREoh3fsxyGCbcGO2LchViCtxV976LhKVi2r0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=in/tGv/SLQ7Z2N5r8B1tN+cCp1LDpppgP/BA2bhkGqciOsUufi0L/RsrvTAItKDRO
	 6GzQvGG4ht8z7sZOWW5zeQJSvrDVho4mqgdLjNV243QflRxcWhLFNrRodiuuDoYsJI
	 0LUtjOzKxvkzqrZygwlBe5NQwLN6pKYwwbr4fFo0kCN7v0GfAo64puLn7+moykGwnZ
	 qc4vTD85g1mcPYrxQF0jCblUua1eYBYvIAsRkij06fpCchDFqhRxleKsd0zF2xY7mn
	 wmzPvWHKaLIsR69hhGkGmvg3wT27nUlnfJieZCj/Kc6tnP1im0L1AW+kkmpylQw1IE
	 EbotCVE8zvBqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] x86/kvmclock: Implement read_snapshot() for
 kvmclock clocksource
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260604095755.64849-3-dwmw2@infradead.org>
References: <20260604095755.64849-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:58:27 +0000
Message-Id: <20260605095827.6563E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11506-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dwmw2@infradead.org,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,amazon.co.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92030647202

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm_clock_get_cycles_snapshot() unconditionally returns raw TSC cy=
cles and bypasses the global last_value monotonicity clamp, breaking timeke=
eping on hosts with unstable TSCs.
--

commit 6dc8b64e567331ab0edc9710a62a9a13cd0b8811
Author: David Woodhouse <dwmw@amazon.co.uk>

x86/kvmclock: Implement read_snapshot() for kvmclock clocksource

This commit implements the read_snapshot() callback for the kvmclock
clocksource. This allows returning both the kvmclock nanosecond value
and the raw TSC value used to compute it.

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index b5991d53fc0ea..cb3d0ca1fa225 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c

[ ... ]

> @@ -87,6 +87,27 @@ static u64 kvm_clock_get_cycles(struct clocksource *cs)
>  	return kvm_clock_read();
>  }
> =20
> +static u64 kvm_clock_get_cycles_snapshot(struct clocksource *cs,
> +					 struct clocksource_hw_snapshot *chs)
> +{
> +	struct pvclock_vcpu_time_info *src;
> +	unsigned version;
> +	u64 ret, tsc;
> +
> +	preempt_disable_notrace();
> +	src =3D this_cpu_pvti();
> +	do {
> +		version =3D pvclock_read_begin(src);
> +		tsc =3D rdtsc_ordered();
> +		ret =3D __pvclock_read_cycles(src, tsc);
> +	} while (pvclock_read_retry(src, version));
> +	preempt_enable_notrace();
> +
> +	chs->hw_cycles =3D tsc;
> +	chs->hw_csid =3D CSID_X86_TSC;

[Severity: High]
Does this open-coded read loop bypass the fallback monotonic clamping used =
in
the standard kvm-clock read path?

The standard path (__pvclock_clocksource_read) enforces clock monotonicity
by clamping to a globally shared last_value accumulator when
PVCLOCK_TSC_STABLE_BIT is not set.

Without this check and clamping logic, if a vCPU migrates to a host with an
unsynchronized or slower TSC, could the snapshot return a derived time that
goes backwards relative to the timekeeper's cycle_last?

Also, by unconditionally returning CSID_X86_TSC and the raw hardware cycles
even when the host marks the TSC as unstable, does this incorrectly trick
cross-timestamping consumers into assuming they have a reliable, synchroniz=
ed
hardware timestamp?

> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095755.6484=
9-1-dwmw2@infradead.org?part=3D2

