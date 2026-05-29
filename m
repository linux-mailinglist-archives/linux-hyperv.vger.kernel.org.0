Return-Path: <linux-hyperv+bounces-11381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHwEHL7YGWqjzQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11381-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 20:19:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 176866072FA
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 20:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB7B306CC58
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A6B3F7A82;
	Fri, 29 May 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMe890/O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D4403E98;
	Fri, 29 May 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078340; cv=none; b=RdB2RjgcjTHb5tLmZnh6Efh35v9xPk9MUDBILUWcmSE5/v9mCiW6SHpp2+TqtGYSKHQ0dhPkPbzrAZCmXXmHyWH0V5oWtNuY2ne/1lA97ebaqeoOMzUPQnFXPk07YdOlzK1JyHiBsbnn7Ykc47fpB02yjo7LnRNyPUoL3zc26xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078340; c=relaxed/simple;
	bh=hK6lw5UAT5mzv8lMWPBDobbfFuwuBGr+z1+baJMCbDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HFCc94E+EX+Xafvgl3R6IBLftdSOrOk5NvmNwRz13b6cTa3WuUfC6Kpv9xhnk2l2olhuVasruWG+9MbnkOvYwNL8SuFcE33BfEEiOOsTLFG/XJhdDAyGKxo8kKE9VIdF4KhL47Mm2itIgXOZvLplBwXSwedREYvFwwLNT/IXSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMe890/O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B27A1F00893;
	Fri, 29 May 2026 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078333;
	bh=xzlrJJg+SnnBXhWnpXCJUaW5D4BxDu7YNoLnzeoreL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMe890/Oh/ZabX0s4IV0zve70F8f8KL+o9g6NJBTbRRLlIb9kKRM0EhD0QQcWUItV
	 XXAManvvn+x9w7Rvnck6c2aRquB8lJJTP2QR6KqeBIiG52MZvxYdtUTtaOV4oNvuEH
	 RNm0Hv5JQU2xf4h3NOPBpSxtE+/mnc75++eWeiDa6CKvQPSs6T/JcmylAJ9EtOV4z0
	 naPM84NCsjiRDOP5biz03/ufDIil8VR13ic4jX2831kHY7L8fb6YI5z0rCMWqk7GMY
	 +uffwozisY1+WQsEkSy6npUNbIO7Y7YkO8jotfCuh8H3FvaeFDfUmzpBcMDHq2RQmB
	 XAWvvL2pJ7DjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/47] x86/kvm: Mark TSC as reliable when it's
 constant and nonstop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260529144435.704127-18-seanjc@google.com>
References: <20260529144435.704127-18-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 18:12:12 +0000
Message-Id: <20260529181213.0B27A1F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11381-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 176866072FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The command line parameter `tsc=3Dunstable` is ignored because `ch=
eck_tsc_unstable()` is evaluated before the parameter is parsed, incorrectl=
y forcing `X86_FEATURE_TSC_RELIABLE`.
--

commit c9259f3d89899a7c421eb7c7311cc995cd768eb4
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Mark TSC as reliable when it's constant and nonstop

This commit marks the TSC as reliable if KVM enumerates it as constant and
nonstop, and if the administrator hasn't explicitly marked it unstable. It
prioritizes the TSC over kvmclock to avoid the overhead of emulated watchdog
clocksources.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 909d3e5e5bcd5..4fe9c69bf40b3 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
[ ... ]
> @@ -1040,7 +1041,20 @@ static void __init kvm_init_platform(void)
[ ... ]
> -	kvmclock_init();
> +        /*
> +         * If the TSC counts at a constant frequency across P/T states, =
counts
> +         * in deep C-states, and the TSC hasn't been marked unstable, tr=
eat the
> +         * TSC reliable, as guaranteed by KVM.  Note, the TSC unstable c=
heck
> +         * exists purely to honor the TSC being marked unstable via comm=
and
> +         * line, any runtime detection of an unstable will happen after =
this.
> +         */
> +	tsc_is_reliable =3D boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> +			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> +			  !check_tsc_unstable();

[Severity: High]
Does this evaluate check_tsc_unstable() too early to catch the command line
parameter?

It looks like kvm_init_platform() is called from setup_arch(), but the
tsc=3Dunstable kernel parameter is parsed via __setup() later during
parse_args() in start_kernel().

If check_tsc_unstable() evaluates to 0 here because the parameter hasn't
been parsed yet, wouldn't it incorrectly force X86_FEATURE_TSC_RELIABLE
and set prefer_tsc to true?

This could cause the system to use an unstable TSC for sched_clock(),
which might lead to scheduling anomalies if the TSC jumps backwards.

> +	if (tsc_is_reliable)
> +		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +
> +	kvmclock_init(tsc_is_reliable);
>  	x86_platform.apic_post_init =3D kvm_apic_init;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D17

