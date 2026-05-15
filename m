Return-Path: <linux-hyperv+bounces-10977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJGWHn19B2qO5gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10977-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:09:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D25574B8
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9FFE300E26C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B510137F011;
	Fri, 15 May 2026 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7UeOhWG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F237646A
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875769; cv=none; b=t4a6G3h+6LEGGyqFY6+ahahAUUosKLFkcJhh+cjKNp/rHmaZ8JAVDBA/qahMK2wYqPZiMAJIdJ8Xs/0wHITu5mRDu4EHgDS6OAv4CzQCNcB/uVLwCDOCMgWQxupXN5BWphqtLB6+jDDd0KdkzMVsNVLMw0bBMao/miCSgvDwt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875769; c=relaxed/simple;
	bh=HSgZWDQ6ScBvBxdqxl0R6LOkqYsims2h8/PpgbUQhMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPJinqzYAuzqNkQlt6XgyjACYQguExYVf+Vymqz6/W68I7vmNPNIZyKSlyqFdxeZVHsbbN5XvtVyuUNrM10iAXE20vvZLUgR8b4TF+yV6F+tQ0Mt0FBuObRa3TGKmgQv3nGWCniMdzqkkIbfrUzbxghnQusJImNcPBzuTDZy84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7UeOhWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F2CC2BCB3;
	Fri, 15 May 2026 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875769;
	bh=HSgZWDQ6ScBvBxdqxl0R6LOkqYsims2h8/PpgbUQhMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=u7UeOhWGQxniipCSB1d0cSsx8WdhK44mWwMUYWKnpw7D+oS7ICc0ndGuYBow0xX6n
	 of/6eZEHdKEKPnx4JFkMZjG7Av5lRLF4L7SVro0WFwkFeSDAQVJ5TRlIMdQYHfHnL7
	 ywRkZguSGCtKXWBLN+xiuQp3ClGAIeGM57cw+7f2RXbJflZis74crEHJTVwAHoLegm
	 jV+/TNniWvRJuWoR4bNx4ZXYcrTnYPkwy5orHteJrLtchCuNhx8+cS9U2+6+gCS3Xg
	 I4rVwuZ5WdF9vrGEOk5n+bruT0zsAGMg7Xs8fCqVHHO5OtrTHeqiXEK344Q86J/Lp4
	 wSNeZSToV0V1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 37/41] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-38-seanjc@google.com>
References: <20260515191942.1892718-38-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:09:23 +0000
Message-Id: <20260515200929.19F2CC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: D98D25574B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10977-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypassing `kvm_sched_clock_init()` when `CONSTANT_TSC` is present =
ignores KVM's `PVCLOCK_TSC_STABLE_BIT`, leading to unfiltered backward time=
 jumps in the core scheduler.
--

commit 57cf68835ef70733c037ca9ffa04fd39e1d70027
Author: Sean Christopherson <seanjc@google.com>

x86/kvmclock: Use TSC for sched_clock if it's constant and non-stop

This commit updates kvmclock_init to prefer the TSC over kvmclock for
sched_clock when the TSC is constant, non-stop, and not marked unstable.
It does this by bypassing kvm_sched_clock_init and instead modifying the
TSC properties so that TSC becomes the preferred clocksource.

Link: https://lore.kernel.org/all/Z4hDK27OV7wK572A@google.com

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
[ ... ]
> @@ -416,22 +416,22 @@ void __init kvmclock_init(void)
[ ... ]
>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>  	    !check_tsc_unstable()) {
>  		kvm_clock.rating =3D 299;
>  		tsc_properties =3D TSC_FREQ_KNOWN_AND_RELIABLE;
> +	} else {
> +		kvm_sched_clock_init(stable);
>  	}
> =20
> -	kvm_sched_clock_init(stable);

Does bypassing kvm_sched_clock_init() when CONSTANT_TSC is present
accidentally ignore KVM's PVCLOCK_TSC_STABLE_BIT?

CONSTANT_TSC indicates the hardware TSC rate doesn't change with power
states, but it doesn't guarantee cross-CPU synchronization, such as across
multi-socket systems or differing vCPU offsets from hotplug and migration.
KVM explicitly signals this cross-CPU stability via PVCLOCK_TSC_STABLE_BIT,
which is mapped to the stable variable.

Prior to this patch, kvm_sched_clock_init() was always called, invoking
__paravirt_set_sched_clock() with the stable flag. This allowed the system
to call clear_sched_clock_stable() if the hypervisor could not guarantee
synchronization, enabling crucial per-CPU monotonicity filters in
sched_clock_cpu().

By skipping kvm_sched_clock_init() entirely and registering
TSC_FREQ_KNOWN_AND_RELIABLE, the kernel's native cross-CPU TSC synchronizat=
ion
checks and the clocksource watchdog appear to be bypassed.

If KVM clears PVCLOCK_TSC_STABLE_BIT, could this result in the guest
ignoring the condition and using raw, unfiltered rdtsc() values? When tasks
migrate between vCPUs with differing TSC offsets, this regression might cau=
se
backward time jumps in sched_clock(), which breaks rq_clock monotonicity
and corrupts CFS vruntime and min_vruntime calculations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D37

