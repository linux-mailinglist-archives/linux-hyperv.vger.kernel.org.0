Return-Path: <linux-hyperv+bounces-10975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEJkLFh7B2rG5AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10975-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:00:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0F55732E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37E83040C70
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4035E1DE;
	Fri, 15 May 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts1FuaT7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBF36F8F9
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875175; cv=none; b=I8qoXn+n1GfAB1cx/2OHVMBryGJZxH3XC5l0dBRZPUMFYyxe7MMSCsZedD663CB6OFf81LgublVv5oMFdnIXqRSxMCu8s18mMFYrWreq6nxVjsgRWXLGqsceDuSKW3g4ryEiwRmx08m5b2vKXTnCB6gftLqL7eNHrkBGnC+Pe2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875175; c=relaxed/simple;
	bh=KgQXXpnl0N1cFWAbnQO7/XsL0iPJDYHkQ1+8IJQUmwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N0N4n/TX3mLMm8GZsXsXXbAPSdrvlH5LAghzvDkikQ+KvJNAn+7E4Mr/B42saumdmae8qv4ko5KAuuE4Z+kxVruZVc3dnVdNeP7UsU3m8EGm5LKLwkAuzl+gMLUruyhEON89KjD+zwutkU2+NCm2QlBw+8BaTU/BKM2e2ztomc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts1FuaT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C790BC2BCB0;
	Fri, 15 May 2026 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875174;
	bh=KgQXXpnl0N1cFWAbnQO7/XsL0iPJDYHkQ1+8IJQUmwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ts1FuaT7uxD+f81IbDuvAmp9FhJZoOu9DheharD83WcnloWcnwNsASOsrTOolqEHL
	 T+6R0EJ6xap0bF/wpIhdzWkim0WvnZDzcowc/P7WHviE1oUiR2YVZqmgZqZ5JxWKXd
	 gO2YqQVQaBdJhORHzrvkOykTIYmQBGnJXO+zRNogNZ5WWKdsi27G50t4dGU0hKhL/H
	 2n7OyC1yvck3h+fBvdF0bnMuOu1jQNQ1yYAuDp0+wHG9TEvQpsrVpXeXPz1LfZX31G
	 stZtMe6SfQADDP+UMRcs3hzNpnVywhoiIzlzMXTJJVPCtaUtrPNf4vFHkHMzljF02v
	 CQymy4qXjFTpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 41/41] x86/kvmclock: Get CPU base frequency from
 CPUID when it's available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-42-seanjc@google.com>
References: <20260515191942.1892718-42-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:59:34 +0000
Message-Id: <20260515195934.C790BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 28E0F55732E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10975-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Fallback path in `kvm_get_cpu_khz()` bypasses `kvm_para_tsc_khz(=
)`, causing a precision regression when CPUID.0x16 is missing.
- [Medium] Core x86 timekeeping logic unconditionally overwrites `cpu_khz` =
if it diverges from `tsc_khz` by >10%, nullifying the commit's intent.
--

commit 244283a64d7a3809c004f242b3973386bb521665
Author: Sean Christopherson <seanjc@google.com>

    x86/kvmclock: Get CPU base frequency from CPUID when it's available

This commit updates kvmclock initialization to prefer fetching the base CPU
frequency from CPUID.0x16 instead of assuming the virtual CPU runs at the
same frequency as the TSC. It introduces kvm_get_cpu_khz() which falls back
to the PV clock TSC calculation if CPUID is unavailable.

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 62c8ea2e67691..7607920ae386e 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -190,6 +190,20 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action a=
ction)
>  	}
>  }
> =20
> +static unsigned long kvm_get_cpu_khz(void)
> +{
> +	unsigned int cpu_khz;
> +
> +	/*
> +	 * Prefer CPUID over kvmclock when possible, as the base CPU frequency
> +	 * isn't necessarily the same as the kvmlock "TSC" frequency.
> +	 */
> +	if (!cpuid_get_cpu_freq(&cpu_khz))
> +		return cpu_khz;
> +
> +	return pvclock_tsc_khz(this_cpu_pvti());

Before this patch, both calibrate_cpu and calibrate_tsc used
kvm_get_tsc_khz(), which checks kvm_para_tsc_khz() to get the exact TSC
frequency from KVM's PV CPUID timing leaf, and only falls back to
pvclock_tsc_khz() if it is unavailable.

Does the fallback path in kvm_get_cpu_khz() bypass kvm_para_tsc_khz()
entirely? For VMs that expose KVM's PV CPUID timing leaf but not
CPUID.0x16, it looks like cpu_khz will now be reverse-calculated from
pvclock multipliers instead of using the exact hypervisor-provided value.

Could this introduce a precision regression due to truncation loss, causing
cpu_khz and tsc_khz to needlessly diverge on the fallback path?

> +}
> +
>  /*
>   * If we don't do that, there is the possibility that the guest
>   * will calibrate under heavy load - thus, getting a lower lpj -

[ ... ]

> @@ -434,7 +448,7 @@ void __init kvmclock_init(void)
>  		kvm_sched_clock_init(stable);
>  	}
> =20
> -	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
> +	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
>  					  tsc_properties);

The commit message notes that treating the TSC and CPU frequencies as one
and the same is nonsensical when the hypervisor explicitly enumerates the
CPU frequency.

However, looking at the core x86 initialization in
determine_cpu_tsc_frequencies(), it unconditionally overwrites cpu_khz if it
diverges from tsc_khz by more than 10%:

arch/x86/kernel/tsc.c:determine_cpu_tsc_frequencies() {
	...
	if (tsc_khz =3D=3D 0)
		tsc_khz =3D cpu_khz;
	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
		cpu_khz =3D tsc_khz;
	...
}

If the hypervisor explicitly enumerates a CPU base frequency via CPUID.0x16
that genuinely differs from the TSC frequency by more than 10%, will this
core logic silently discard the explicitly enumerated CPU frequency and
overwrite it with the TSC frequency?=20

Does this check thwart the patch's goal of decoupling the two values
exactly in the scenarios where they substantially differ?

> =20
>  	x86_platform.get_wallclock =3D kvm_get_wallclock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D41

