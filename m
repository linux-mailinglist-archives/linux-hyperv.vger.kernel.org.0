Return-Path: <linux-hyperv+bounces-10965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHZ6MNl5B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10965-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:54:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E6D557249
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BD883000BA1
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6715E5DC;
	Fri, 15 May 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv5fRMYy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F033812CD
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874177; cv=none; b=AXPGMs8jl1PU0zWfrGK8ROSDGmLFoEqc6R1r1G8MFR+GlnMlkDVIBRGbnRPYQnFhTs/QDWX1ZFRc/rxEYJ1bEPwwPK9wGOplAdVTVk63bCiEUNpvEZTBKqX2DwdtXI7zMKbAm7rL6LJ5igYf8O8L26XUebySBsMZjoXSbQLbi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874177; c=relaxed/simple;
	bh=UgzYkO5m4lLtP2e571xyUejohNnlX9nz7/RNBviE8h0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ISj3+7FJdflE/PkA2LKs3ucGbMjLE6BGSiM3+wy3PosqPhgnHgKV6Yqy2iJjwCmLCpuC1ZwMu34+YxPT3rDjrjV7D0J0+ScKmpygXZuYLu0L+CyLNk9x90ve3Kkmlm45826anXk+nMIp29F19wH6yjYYZqNk+fZp0CsrrIs/k6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv5fRMYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D588FC2BCB0;
	Fri, 15 May 2026 19:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874177;
	bh=UgzYkO5m4lLtP2e571xyUejohNnlX9nz7/RNBviE8h0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iv5fRMYyv0ecIEt8OxORKGBsxnwri3rUxMRlu1UgY7hYU8fc28nl4s11wVOTcQQbN
	 4OBRcw0g32/AdBflbx3+yfiGy6q96l5W1O2N9NxQ2RuxKQPagYlOw/+TkJOfse0iSp
	 05h3EVgJhrIPzWe42cevOHgKQDfJCuLpom2IyaGIlwzacVNARHbHPpe+krhgQCu3RI
	 dvqJ8sPpIMB/ToS0UVJRfg4Pa+IszhcX4XobukOC4y072jeGZEa/dOdJ5Qi8YVLmRt
	 VufMJauYJD/seiN2T9bnScnyVz4QuOQPEw87h61BKRYtouraaikj4CcMyX7PkBX8AV
	 5JDl1KYPf5hOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/41] x86/vmware: Nullify save/restore hooks when
 using VMware's sched_clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-17-seanjc@google.com>
References: <20260515191942.1892718-17-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:42:56 +0000
Message-Id: <20260515194256.D588FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A8E6D557249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10965-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting `x86_platform.save_sched_clock_state` and `x86_platform.re=
store_sched_clock_state` to `NULL` causes a kernel panic during suspend and=
 resume operations.
--

commit 2ff4708308b8e09ffda052258a76f33f136c2ea8
Author: Sean Christopherson <seanjc@google.com>

x86/vmware: Nullify save/restore hooks when using VMware's sched_clock

This commit sets the sched_clock save and restore hooks to null when
using the VMware sched_clock implementation. It aims to bypass these
hooks during suspend and resume operations for VMware guests.

> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index b88d9ca01202d..b5cb66ca022b8 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c

[ ... ]

> @@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
> =20
>  	vmware_cyc2ns_setup();
> =20
> -	if (vmw_sched_clock)
> +	if (vmw_sched_clock) {
>  		paravirt_set_sched_clock(vmware_sched_clock);
> +		x86_platform.save_sched_clock_state =3D NULL;
> +		x86_platform.restore_sched_clock_state =3D NULL;

Will this cause a kernel panic during suspend and resume operations?

In arch/x86/power/cpu.c, both save_processor_state() and
__restore_processor_state() unconditionally call these function pointers
without checking if they are populated:

arch/x86/power/cpu.c:save_processor_state() {
    ...
    x86_platform.save_sched_clock_state();
    ...
}

Since VMware guests support standard x86 ACPI S3 and hibernate pathways,
executing a null function pointer here will crash the kernel during suspend
or hibernate.

Could these be assigned to an empty dummy function like x86_init_noop
instead of null to safely make them a no-op?

> +	}
> =20
>  	if (vmware_is_stealclock_available()) {
>  		has_steal_clock =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D16

