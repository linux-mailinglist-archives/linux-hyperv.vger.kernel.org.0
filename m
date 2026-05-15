Return-Path: <linux-hyperv+bounces-10970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FYmC7V4B2qL4wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10970-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:49:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF745571AF
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF2B303133F
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1134251D;
	Fri, 15 May 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvtG0LVP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549BD33FE0A
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874486; cv=none; b=RNmh6L5/fQ4q5QVWatVd7FerGIdttqJ6oABL7+aTOFfgkJYTzeFOW0RCVqNzotfoU2vYJQuhvHqGAjgWP0XkMixZMDGLAI0vpsbbiVKxUonBDpWe/FEurOG5UIneHv1r0PZtGB8UGDZ8bzC+Hqh9I1c71DBvi+n3YOZCa9nliuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874486; c=relaxed/simple;
	bh=m4KuxaRgH35yeK+fK2PB6dxW0Rl2mxcZnApC1n2PqaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aUibomEwcqGPR1dt6Bth5hXMathDuTmJMoZioOahABWzLqQp/b0iD2Q5D2pmrJK+vxFQxGzROsbgMuMCgNWUPMH/9TFjYPbiuX7roHu0EGrz0nsG5dUHRHzC30aitUg1guwfjAAt0d7V4ZzKMrs2QHcPJE7j4I7/SxZ1hpLMgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvtG0LVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE30FC2BCB0;
	Fri, 15 May 2026 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874484;
	bh=m4KuxaRgH35yeK+fK2PB6dxW0Rl2mxcZnApC1n2PqaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lvtG0LVPoBInjVkhLbkDCVYm5sTTCtLmxA/1eHmkqe/m1Ql2YQHVqoO7xzN0NAxz2
	 71gvEau5wg/dhFDVy6fCQE9O+xGSDKX+jPHUYKypEbtrbd1iy0stipZjzL6/Je1fd+
	 PQfJsP9kOI21OjimD/Kaz5cbQn7iD9K+fonYfO4yH3RVFR5NKcx6Ypc/+mz32hiBFS
	 Ke49BYu6JfZYeSw+uY2TT4n5VzKXNrVc7FuxFzHdaHdkvanm1CwDr3pk9Wd/kSrwwE
	 WEb5hT+8O6yGuZRDd/rwp5Syzx1F04JivFrrkp6gVhsZEU8my8gYZK3QIIlC81Oe0I
	 u18o/Zzd3dKPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 29/41] x86/paravirt: Plumb a return code into
 __paravirt_set_sched_clock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-30-seanjc@google.com>
References: <20260515191942.1892718-30-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:48:04 +0000
Message-Id: <20260515194804.AE30FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: CAF745571AF
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
	TAGGED_FROM(0.00)[bounces-10970-lists,linux-hyperv=lfdr.de];
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
- [High] kvm_sched_clock_read is registered as the system sched_clock befor=
e its required offset (kvm_sched_clock_offset) is initialized.
--

commit b6e429e4990c00d845488d46e8dc4132f3a2fd8b
Author: Sean Christopherson <seanjc@google.com>
x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()

This commit adds a return code to __paravirt_set_sched_clock() to allow the
kernel to reject attempts to use a PV sched_clock. It updates the caller
in kvmclock to check the return value and abort initialization if needed.

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index d3bb281c0805d..9b3d1ed1a96dc 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
[ ... ]
> @@ -338,10 +338,12 @@ static int kvmclock_setup_percpu(unsigned int cpu)
> =20
>  static __init void kvm_sched_clock_init(bool stable)
>  {
> +	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
> +				       kvm_save_sched_clock_state,
> +				       kvm_restore_sched_clock_state))
> +		return;
> +
>  	kvm_sched_clock_offset =3D kvm_clock_read();

Could this cause a massive backward jump in system time if an NMI or early
exception calls sched_clock() right after registration?

__paravirt_set_sched_clock() uses static_call_update() to globally publish
kvm_sched_clock_read() as the live system sched_clock. Since the
initialization of kvm_sched_clock_offset is now delayed until after this
registration completes, any early caller will execute kvm_sched_clock_read()
with a zero offset, returning a huge absolute raw clock value.

When the code resumes, it sets the offset to the current raw clock value.
Subsequent sched_clock() calls will abruptly subtract this large offset,
causing time to jump backwards and violating monotonic clock guarantees.

Would it be safer to initialize kvm_sched_clock_offset before calling
__paravirt_set_sched_clock(), since calculating the offset early has no
side effects even if the registration is subsequently rejected?

> -	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
> -				   kvm_save_sched_clock_state,
> -				   kvm_restore_sched_clock_state);
>  	kvmclock_is_sched_clock =3D true;
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D29

