Return-Path: <linux-hyperv+bounces-11128-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wgsvHmoaD2qeFwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11128-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 16:44:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55C5A7886
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837BC31BFC1C
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885D3F1662;
	Thu, 21 May 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vD2HFtkK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6E3F0762
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370716; cv=none; b=GIqnlcU/ad3R02x8uvk9zvA9PvlotS0sh2Q5T97GhGK9pHIwvWNnKNniKOy6dCXKjoGOXT1ss0fzZ5SgtgDx6m+FnGWCNPcHYUyGbt6vLqY9Xtvy7Z3KR7NDz8wiNFNX8gnzdj9er6Az8dQuw4jKtK3b/pvBOjGDdAL0FhqMJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370716; c=relaxed/simple;
	bh=rZ1N/KoZeh9+iAw5VzELz8I+bOlFA8dDM2e99AiyYKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gg7ABZSCLZ7R8FjMuSHzn4PmQlN+bWSSxhg9EME1P73bw6Lrgmuc96xC+uU88luhw5OvcvK4R3b33uA9Rvc9yHEcX61LpH/1aToWDQw2QWNrzJYRMJJD7l/5ClNHaciMje/DOyS0JiO386k+Qf4iqOMSOpAC9mDJnoTHa6bHB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vD2HFtkK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso3796694b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779370714; x=1779975514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbJ4F8kl/6/QcBmB9dNne3NQOqe79KuT470iYfI7huM=;
        b=vD2HFtkKNCQl2Nxi2sePWDsts6BHG5KLtGT/KpuLQKm3nh+PZIP5l7oPF9PQC2nngV
         lrLpVQvLFbAXcRUVQ4Quntoz6Fi4ox/z4VWqrk+RaWtmpuWZwcoz8tYjot79giG5QaYg
         g0Spda8iBU5cEbnZPnw+hGIR6ZNO2QtihN7AgJgUjo4lpV+oTGmL7Q6HklVtdjQhz7is
         Qi0dX/ZqCtgDQBAcnPIp9JW9dJrVFV9O+nWHYkWfzySGLfaeAOuuC8mN8jOtfQZX8Uhk
         qhXaRgl+rPGT1E4aTmPnD414Ws25FYEPncCtsU6Jq6y6eDWoez/4SoGgFk7sCC6dZJn9
         CLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370714; x=1779975514;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jbJ4F8kl/6/QcBmB9dNne3NQOqe79KuT470iYfI7huM=;
        b=f86aZoiC8358zB2N7D6sjDUi4biTXSLxQ06LiJ3fn9jvG3vfgqRiCh8zoQWVHziq8Z
         LnUaLSFY8eIy9fin6SKSSn/1y2B8EE+IE18rX0fsXycAW+oS02zHMRbhiU8GTqKz6sOV
         Ltiutt0QA5mResmAjX0I9KDBITAGnTYhZsbQ3jgiKmwWjZcmSYauASjLhkGARUk7l8nM
         1ozqRPWHCq+ODmdHPuRNYkwAzOJkoVFC9Nq7A67lpijgAkBuiFIpFoyuo5amGlSr0v3v
         60/vn66xAuUdnWy8nH/FFSsXivSjKNHBijWVazfflc/v0/GfAF47StFYxJRbiMZ1LMIJ
         c5BA==
X-Forwarded-Encrypted: i=1; AFNElJ8J7Ait9vLo7v8Kl3wFpTZM4a/pdynXRvjOX5O+op4fGuuIa1xIJOvkMt8DO1qU7Ygf3EF6ZW3QdGV+hpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXf8O53qw+71yjNxod9y65FjcVjjF4X7LXavlv33z60v3UQuoz
	jj3awawOit6UHuc2nHA7dI2cPyw8RFN8HWF6YgJeDtQlZb1r8T4FVsu48EziTQkmBiiKm4/Aic4
	bByI7Fg==
X-Received: from pfbem15.prod.google.com ([2002:a05:6a00:374f:b0:83d:3c25:eb8b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c8c:b0:827:3b1b:43e6
 with SMTP id d2e1a72fcca58-8414acc6e8emr3123916b3a.21.1779370713612; Thu, 21
 May 2026 06:38:33 -0700 (PDT)
Date: Thu, 21 May 2026 06:38:32 -0700
In-Reply-To: <20260521131019.GI3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-28-seanjc@google.com>
 <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
 <ag8Bpc_uVNrNWqfX@google.com> <20260521131019.GI3126523@noisy.programming.kicks-ass.net>
Message-ID: <ag8K2FRGcoEa-D2Y@google.com>
Subject: Re: [PATCH v3 27/41] x86/kvmclock: Enable kvmclock on APs during
 onlining if kvmclock isn't sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Kiryl Shutsemau <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11128-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC55C5A7886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026, Peter Zijlstra wrote:
> On Thu, May 21, 2026 at 05:59:17AM -0700, Sean Christopherson wrote:
> > On Thu, May 21, 2026, David Woodhouse wrote:
> > > On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > > > In anticipation of making x86_cpuinit.early_percpu_clock_init(), i.=
e.
> > > > kvm_setup_secondary_clock(), a dedicated sched_clock hook that will=
 be
> > > > invoked if and only if kvmclock is set as sched_clock, ensure APs e=
nable
> > > > their kvmclock during CPU online.=C2=A0 While a redundant write to =
the MSR is
> > > > technically ok, skip the registration when kvmclock is sched_clock =
so that
> > > > it's somewhat obvious that kvmclock *needs* to be enabled during ea=
rly
> > > > bringup when it's being used as sched_clock.
> > > >=20
> > > > Plumb in the BSP's resume path purely for documentation purposes.=
=C2=A0 Both
> > > > KVM (as-a-guest) and timekeeping/clocksource hook syscore_ops, and =
it's
> > > > not super obvious that using KVM's hooks would be flawed.=C2=A0 E.g=
. it would
> > > > work today, because KVM's hooks happen to run after/before timekeep=
ing's
> > > > hooks during suspend/resume, but that's sheer dumb luck as the orde=
r in
> > > > which syscore_ops are invoked depends entirely on when a subsystem =
is
> > > > initialized and thus registers its hooks.
> > > >=20
> > > > Opportunsitically make the registration messages more precise to he=
lp
> > > > debug issues where kvmclock is enabled too late.
> > >=20
> > > That's a hard word to type, isn't it?
> >=20
> > Heh, you have no idea.  I've been "this" close to creating a VIM bindin=
g for a
> > while, it is time...
>=20
> 'z=3D' not good enough?

You people and your fancy ways.  I'm just happy I can get in and out of the=
 editor :-)

