Return-Path: <linux-hyperv+bounces-11396-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL24BAWNGmo75ggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11396-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 09:08:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DA60B8A0
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 09:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC14304B684
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 07:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A11E511;
	Sat, 30 May 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqof6lFw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D211ABED9;
	Sat, 30 May 2026 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124929; cv=none; b=p8nSmHcaX07WG9r1xE+6FQeTYchKOqcKn2EbxXGrBucvcJG1Oa7n3Jpt57WQom8VndWJ1QhdEyd4Lx9LK/S2XusXk3zSoTVS0iQtbS9UYwOdQQ79RRP6a7JKLAhKdYejmx+Fki6cSVtiXCsTL6L9hxSC6qSznJVWVvFlqmcgWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124929; c=relaxed/simple;
	bh=I68GCXOYT+kBemWQ+Q/y8hSCY/ISUAplZcpfblBZLPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0lydUmBHGFeVVne51BJatayk9SO/aUm+bs2c+P1AhNSCP7OvXZEEmP+RcZKaP3mB80Xr1haGMA63nfD0yZlJMX+ediR4z/V1cEl51GxHz6zbo1EMnleYPqc+MCYiZ7RXwWMfaExSRMWhYv0FjXR7wGOWFTplyK3n7XQelxofiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqof6lFw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158521F00893;
	Sat, 30 May 2026 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780124928;
	bh=dwHFy/b0JudLXpY4i3M/0W7fKXIXPymSPkcsf3JbQZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hqof6lFw0RFBU0JROqjz0cB6t7lXwr/UjqFUK0YEN7eudxge9qcDQlNvgRIdZnTJ+
	 iG7iwwgITjNY9V/0PBAMiHdzD40aI1oxO7jVUIm3pf6YkS3xYrvRDEfe4WwqqpNCBU
	 ojSu867mJeisfGFqCnFK7zhok1z/Qg3IJzs5TmHm7w9ViE/VFx2E3jKk8lTdnFU3yp
	 BTKSM0bisIFpmx/geg8N80EBO0U41zMPg1uzKTm6ELrX1agyCwl745c4jMX/r+vaqs
	 wnhXOkcM/0tuR3Mo9kxOnX3yY8XfIfxwfjMOAUV1C/7/MzWcarbIqxEdBDER2pZDq2
	 Ug/gs+3cxa1kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 26/47] x86/kvm: Don't disable kvmclock on BSP in
 syscore_suspend()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260529144435.704127-27-seanjc@google.com>
References: <20260529144435.704127-27-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 07:08:47 +0000
Message-Id: <20260530070848.158521F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11396-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 649DA60B8A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] MSR_KVM_MIGRATION_CONTROL is disabled during CPU offline and syste=
m suspend but is never re-enabled upon online/resume, permanently breaking =
live migration.
--

commit 44d44f9fdfe9da0700b2023c4cf04e9f6f582d4c
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()

This commit prevents KVM from disabling kvmclock on the BSP during
syscore_suspend(). It introduces a kvm_guest_cpu_action enum to pass specif=
ic
actions down to the kvmclock CPU offline path, ensuring the clock is preser=
ved
across a suspend/resume cycle.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index c81a24d0efdf6..fd1c417b4f9b9 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -460,7 +460,7 @@ static void __init sev_map_percpu_data(void)

[ ... ]

> -static void kvm_guest_cpu_offline(bool shutdown)
> +static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
>  {
>  	kvm_disable_steal_time();
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> @@ -468,9 +468,10 @@ static void kvm_guest_cpu_offline(bool shutdown)
>  	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
>  		wrmsrq(MSR_KVM_MIGRATION_CONTROL, 0);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that
MSR_KVM_MIGRATION_CONTROL is cleared to 0 here during CPU offline and system
suspend, but it does not appear to be re-enabled upon online/resume.

Since this patch introduces the kvm_guest_cpu_action enum to solve an
identical state-machine issue for kvmclock, should we also use this action
enum to ensure the migration control MSR isn't incorrectly cleared on
suspend? Otherwise, wouldn't a single CPU hotplug event or a suspend/resume
cycle permanently disable live migration for the entire VM?

>  	kvm_pv_disable_apf();
> -	if (!shutdown)
> +	if (action !=3D KVM_GUEST_SHUTDOWN)
>  		apf_task_wake_all();
> -	kvmclock_disable();
> +
> +	kvmclock_cpu_action(action);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D26

