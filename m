Return-Path: <linux-hyperv+bounces-10973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBWbMLN6B2rG5AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10973-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:57:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F885572CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE1263021E71
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEF5413D6C;
	Fri, 15 May 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6A9uXWH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA235E1A1
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874958; cv=none; b=bFU3Ql8Gx2s4dsl6P4OaDdlFyDQhE8ZPumX5XN/Fu6k+eDAwgsZa1R6A0TpSd/s4ikj+Wv5WX8fMbTd5dOefW5OFxxx3lBDWl6xUYNAfDBleko8/GoiYJJurgQ7jbh+kavmhfaY2Rlw9xlj0LYBEULUTXR+Wp1xH1anYPM5Z7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874958; c=relaxed/simple;
	bh=b1C3ZYMqbMUXuJwfK0nJ46SR12LZcEDfwzg/+eG4Nwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7ycnOTKyPo6oa2DJnd1ZMBgR6GhVYz3YbsipWFD71WQlu9vUPVvrbR45ewl3M1OEnMYlLfDs1c6MnsKubu+hm0PlXwRBDxSI56XKkxlueePJsZ6kqxOoUacfXAhjP6QmNGYXuE/JwXEpIxH7V13YOt5lELHrsogEqRmtJSv/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6A9uXWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF05C2BCB0;
	Fri, 15 May 2026 19:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874958;
	bh=b1C3ZYMqbMUXuJwfK0nJ46SR12LZcEDfwzg/+eG4Nwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=j6A9uXWHFoSH8CoR6UGZsG/8Q20tHZ03p1cPZXm7RTDJIctt3G11YvhqkcX0u69Cx
	 BvijPQo8Uj8tziNvnXu1GmW9Egn8tuIrMfYHEGFsWpAZk3cOCvIaRfwTO+pTFxgq5A
	 RtoMQ6Lo1fMxtdRb5aaIGgFI57YcuDqbkPy0w/Xz5JRVkxgSf7EriC8snPpLC+xKyW
	 nKUF+Tpj4kaILH+vQxhUqf9JiQLpd9GRf99b6hsrgz+rg2lbQvIWrSwa+VoOM3JkFI
	 vpGEU7fE/p2GOVR0NELzrl2EOJNN1Dl2PjbaWQoKcAmpj2DLnCk1luhddKmtEpvXw4
	 bGgNqERD37zOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 36/41] x86/kvmclock: Get local APIC bus frequency
 from PV CPUID Timing Info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-37-seanjc@google.com>
References: <20260515191942.1892718-37-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:55:51 +0000
Message-Id: <20260515195557.DEF05C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 29F885572CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10973-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] lapic_timer_period is incorrectly assigned the raw APIC frequency =
in kHz, which fails to account for the kernel's HZ configuration and breaks=
 APIC timer calibration for any HZ !=3D 1000.
--

commit e5bbef05c7ba30fb00c716accae48693e295289a
Author: Sean Christopherson <seanjc@google.com>

x86/kvmclock: Get local APIC bus frequency from PV CPUID Timing Info

This commit reads the local APIC bus frequency from the PV CPUID leaf
and uses it to directly set lapic_timer_period, bypassing the standard
calibration process.

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
[ ... ]
> @@ -200,10 +200,19 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action =
action)
>   */
>  static unsigned long kvm_get_tsc_khz(void)
>  {
> +#ifdef CONFIG_X86_LOCAL_APIC
> +	u32 apic_khz =3D kvm_para_apic_bus_khz();
> +
>  	/*
> -	 * If KVM advertises the frequency directly in CPUID, use that
> -	 * instead of reverse-calculating it from the KVM clock data.
> +	 * Use the TSC frequency from KVM's (and other hypervisors') PV CPUID
> +	 * leaf when available, instead of reverse-calculating it from the KVM
> +	 * clock data.  As a bonus, the CPUID leaf also includes the local APIC
> +	 * bus/timer frequency.
>  	 */
> +	if (apic_khz)
> +		lapic_timer_period =3D apic_khz;

Does setting lapic_timer_period directly to apic_khz assume that HZ is
always configured to 1000?

The lapic_timer_period variable represents the number of APIC timer ticks
per jiffy. This is usually calculated as (frequency_in_hz / HZ), which would
be (apic_khz * 1000) / HZ.

Assigning the value of apic_khz directly means the period is exactly
frequency_in_hz / 1000. If the kernel is built with HZ set to 100 or 250,
could this result in a timer period that is too small, potentially causing
timer interrupts to fire much more frequently than intended?

> +#endif
> +
>  	return kvm_para_tsc_khz() ? : pvclock_tsc_khz(this_cpu_pvti());
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D36

