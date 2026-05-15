Return-Path: <linux-hyperv+bounces-10968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLZlIVV4B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10968-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:47:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E117755716C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942CB301A395
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59DB33688C;
	Fri, 15 May 2026 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLUYMeRx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F6413D60
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874427; cv=none; b=hQJd1um+C6izI4bDf3kq6pG/cH1CqneYhrrHOfcr6Zhs1Zi1EFqTCmbVEGnKOLUaeF1swf85d/vojSZcFWHJfuW59QM8ekvoYCK+ryXyntDye9ltEdSXN8m+ZZT6VmuKk/els7a/4CtXFLj76gZH0bpHFl4voGH4x0crtSxUmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874427; c=relaxed/simple;
	bh=WszqLuvZiR92dHhXY0xItpOMGKtl4nV/zQ0hsrW14V8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwLTcl8H9ITXx5crqgtSCYWayvZwpTON4J8H44aA6Zl911+PhDFHCxfOHHPN/OG1Y9yh7Tb1CDwAyrAbFlNjlLpucJb4nJMiOemnJb79ck9jy+gOIQYvn4ZgZWj9PMsOoNbDjPM2DvhDe8zTwrtVegqdmvr7oHcxj2dy/lTYsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLUYMeRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AFDC2BCB0;
	Fri, 15 May 2026 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874425;
	bh=WszqLuvZiR92dHhXY0xItpOMGKtl4nV/zQ0hsrW14V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZLUYMeRxmeixZ+HR8U22dcPNkQcvjGXV8tKiZRDs0yqaqPH6noY2WeI4iHEDHkA0v
	 HqBBXwQSedbB89SzQqSVUKY7ZGOjgqhLaCMqIJHbM9QuwOiB+0gyaHc8tNl0OTJjKa
	 RFBlJ8a+62jvpooSxPaMPNXSAAf5qlVTel4lBT8ZoTnfiW+KDzzMn+aw6likGMGvUH
	 ePK9vTeovARt0B5sgZT7RkFMdWPdST779IuULEj1seAw6adVQX7JRjH4XL2KkxeYCl
	 XBVHTe+nJ/RMp4IVLUSdW+CEdRc/o4AXq+SmejmfwjfLuVXvjsz7HZjj0AXPh4T5M/
	 WO3p9jUr3+n9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 27/41] x86/kvmclock: Enable kvmclock on APs during
 onlining if kvmclock isn't sched_clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-28-seanjc@google.com>
References: <20260515191942.1892718-28-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:47:04 +0000
Message-Id: <20260515194705.09AFDC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E117755716C
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
	TAGGED_FROM(0.00)[bounces-10968-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The logic to defer AP kvmclock registration to the CPUHP_AP_ONLINE=
_DYN state when it is not used as sched_clock is architecturally unsafe and=
 will break timekeeping.
--

commit 88625772445f01c4397e3dfd4ee43222efd758cf
Author: Sean Christopherson <seanjc@google.com>

x86/kvmclock: Enable kvmclock on APs during onlining if kvmclock isn't sche=
d_clock

This commit prepares for making early_percpu_clock_init() a dedicated
sched_clock hook. It adds logic to enable kvmclock on APs during CPU online
if kvmclock is not used as sched_clock, and includes WARNs in the suspend
and resume paths.

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index e7250d21c6721..d3bb281c0805d 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
[ ... ]
> @@ -141,25 +142,51 @@ static void kvm_restore_sched_clock_state(void)
[ ... ]
>  void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
>  {
> -	/*
> -	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
> -	 * being used for sched_clock, then it needs to be kept alive until the
> -	 * last minute, and restored as quickly as possible after resume.
> -	 */
> -	if (action !=3D KVM_GUEST_BSP_SUSPEND)
> +	switch (action) {
[ ... ]
> +	case KVM_GUEST_AP_ONLINE:
> +		/*
> +		 * Secondary CPUs use dedicated sched_clock hooks to enable
> +		 * kvmclock early during bringup, there's nothing to be done
> +		 * when during CPU online.
> +		 */
> +		if (kvmclock_is_sched_clock)
> +			break;
> +		kvm_register_clock("secondary cpu, online");
> +		break;

Will deferring AP kvmclock registration to the CPU online phase break
timekeeping if kvmclock is still being used as the system clocksource?

If the user boots with clocksource=3Dkvm-clock or if kvmclock is selected a=
s a
fallback, it will be used as the clocksource despite not being sched_clock.
The kvmclock clocksource read function accesses per-CPU memory that the
hypervisor only populates after the AP registers its clock.

If early registration in start_secondary() is skipped, as anticipated here,
an AP will boot, enable local interrupts, and process timer ticks before
reaching the late CPUHP_AP_ONLINE_DYN hotplug state.

Could a call to ktime_get() during this window read uninitialized per-CPU
memory and return 0? It seems this might cause the timekeeper to compute
massive forward time jumps, leading to immediate timer expirations and
watchdogs firing.

> +	case KVM_GUEST_AP_OFFLINE:
> +	case KVM_GUEST_SHUTDOWN:
>  		kvmclock_disable();
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D27

