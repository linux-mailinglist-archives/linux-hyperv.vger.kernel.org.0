Return-Path: <linux-hyperv+bounces-10969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OQXOLN4B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10969-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:49:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4656D5571A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6C9302FAAC
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095EE3859D3;
	Fri, 15 May 2026 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8YVbpvx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E830C618
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874484; cv=none; b=liFnmAuogvlmY/cyg0UVySlcgOZ2AubdOpSm2XqZwvptTZdMx38P+ALP9fQcrvdxOCxzQjVHUrriudYroluU6l1XelBKE1r7TtU7IC4RYVfLcFMctSbhJM13NAUWcR+UCUfzUlhJZbxvSsUgb1+vNfVBqJSd/yK/vRDwyGu8gC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874484; c=relaxed/simple;
	bh=0QSUHS8m/mRg91U7jSuorHZ7kkONYCPuPv4941aXup0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HjyVVSBvgmxo2uqtTfcR/0V0erVTKVH0QMnRxtLLl8VqdDIbrAw0RbnVZFOp+AR+IVF412mu1d+kYpIUVGPOOIMTUnfN9DxNHF7l4pfYlziXHdKUoWUOThTZ4IA5rb/qi8ceRpbKj98zTzFd70dhIAbkgjK7Xx8Q/uo11mcqXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8YVbpvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D898C2BCB0;
	Fri, 15 May 2026 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874483;
	bh=0QSUHS8m/mRg91U7jSuorHZ7kkONYCPuPv4941aXup0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V8YVbpvxWG6Ioj+LNW3sbzOni6ObrCLcmSiikFbSS3aNiG23G/SjK3GLjTnVfXm5+
	 3Zqi0lOMBRSiAw5YQV+9C0D7XgqTtWYm04UQWU1dsA4LLpCEzBgGoxL3Vo9C2Yer7E
	 EqthdLNZ3vBCztvKO2e7lvZu8uZaXdvrpI83FeH5l0l6+e6hQNulpdfol1kIcs9Nxt
	 8ZLGBm0qQVlqrl5VbAnS8tFaKBCXEi9yd8yfvHYPr3b4iA5wgEwgenkU6AdxMNs2Q4
	 CvJKgo2j4HXsnWq4HIKc7aruUPe+2KP6RnQvXzt2FFTkycZR+2TLsGFD/yMzZQdTyY
	 1vP6TcMUWK7Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/41] x86/xen/time: Nullify x86_platform's
 sched_clock save/restore hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-16-seanjc@google.com>
References: <20260515191942.1892718-16-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:48:02 +0000
Message-Id: <20260515194803.1D898C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4656D5571A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10969-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting `x86_platform.save_sched_clock_state` and `x86_platform.re=
store_sched_clock_state` to NULL causes an unconditional NULL pointer deref=
erence during suspend, hibernation, or kexec operations in Xen guests.
--

commit 07d607146953d7a7f53a708d78545184418c340c
Author: Sean Christopherson <seanjc@google.com>
Subject: x86/xen/time: Nullify x86_platform's sched_clock save/restore hooks

This commit nullifies the x86_platform sched_clock save/restore hooks when
setting up Xen's PV clock. It aims to clarify that these common hooks are
not used when running as a Xen guest.

> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index 3d3165eef8214..21d366d01985e 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -568,6 +568,12 @@ static void __init xen_init_time_common(void)
>  	xen_sched_clock_offset =3D xen_clocksource_read();
>  	static_call_update(pv_steal_clock, xen_steal_clock);
>  	paravirt_set_sched_clock(xen_sched_clock);
> +	/*
> +	 * Xen has paravirtualized suspend/resume and so doesn't use the common
> +	 * x86 sched_clock save/restore hooks.
> +	 */
> +	x86_platform.save_sched_clock_state =3D NULL;
> +	x86_platform.restore_sched_clock_state =3D NULL;

Does setting these hooks to NULL lead to an unconditional pointer dereferen=
ce
regression during suspend, hibernation, or kexec operations in Xen guests?

Looking at save_processor_state() and __restore_processor_state() in
arch/x86/power/cpu.c, the hooks are called directly without being checked
for NULL first:

arch/x86/power/cpu.c:save_processor_state() {
	__save_processor_state(&saved_context);
	x86_platform.save_sched_clock_state();
}

arch/x86/power/cpu.c:__restore_processor_state() {
	...
	do_fpu_end();
	tsc_verify_tsc_adjust(true);
	x86_platform.restore_sched_clock_state();
	...
}

Will operations that trigger a generic CPU state save or restore on a Xen
guest execute a call on these NULL pointers, causing a kernel panic
regression? Should these instead be assigned to an empty stub function to
safely bypass them?

> =20
>  	tsc_register_calibration_routines(xen_tsc_khz, NULL);
>  	x86_platform.get_wallclock =3D xen_get_wallclock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D15

