Return-Path: <linux-hyperv+bounces-11126-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IoANdQND2p7EgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11126-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 15:51:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C55A6502
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2FA9316A117
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9503CBE75;
	Thu, 21 May 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BR+yDFhP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A33B5F48
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368360; cv=none; b=PeAQCfMIcuAFJoxXTH1aV77nAvyeaP16Sq/bLZENuRhi27Xe5pywh8+3bc9TtOkYsATnS5mS8wzEQbHFYtPQ9AK4Q/hyyCDeSJKTrMKURgnHtFWobugEpCNUDU7FolCcfL/s5FPSdnteniyflCIMl+WRv2rPIOGDhbSthg6kNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368360; c=relaxed/simple;
	bh=0rVVosXepCYQeGWe7dkZUA8zbJznpObfcXBvPIXEpbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ck6wrhJlFdXDV8iIio7MuDMKd/rd20MWZH2iRSbYCKUHTeacke3OlWPPXcdlm4V2yLWypvsUFkVnU7UdIXjgPqZyd0Su+LZCAS8OgF6bQWSu/eAzmebFJ/KL1kyFTBtOEICHcXj+qJzTfbnba7okUPkihbTe2CaSllUj58VRDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BR+yDFhP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso3141583b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779368358; x=1779973158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqcHY/DvmkAZ9QjHGP0kTeF7mk7WkCMN/ZHV20HdBXo=;
        b=BR+yDFhPhU2HJTc+bDFimLPjJebhKzYAT6Adqzfv/rz2IQeWTHscExQsyR+KXenzfz
         WkQT9RvGtGdgMVd+FvQQdjWL1Olz4MNs03/O5e/4eiXA8jGQa15BqypT/p02ljc5St4o
         96PNOLS1t3+htnko40+HcSVbb/wnqE+kcgLVjm9TNFCs+dzkmAFqGVGIWFQatwsJJDu4
         T6nrbjXGfjJ9Zazhi6K4L/6+HrOJe7afPsDlKTk41lcl9AIAksz5amaxXmqowkpSr7MW
         H4LRiRO3d4Z9j4YPND6kqqpVGHhmbtZ0ixHXg692rby216OA+miVDMzTk8NQjOR9HxKu
         LQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368358; x=1779973158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqcHY/DvmkAZ9QjHGP0kTeF7mk7WkCMN/ZHV20HdBXo=;
        b=T9suda74Xo5Q7CLgHjLX4w8U+brNTR7qEPYBWeLaBpO2Xe4qQawhNFYy4YGx8H+lpD
         L5jKmOimafl7shp0PtyE7k3+Wg6rz3ZIwZWjYeB3O0aAe504sMC9f2/979j8era1Ix2I
         8FM9eevXxhOY9UO4/p+cioC+1Di/buL1n9+HA7lbrc1g0tEGjGrzdctR1aSi4Z8mwwKI
         92cfTOM7gXmwHHdwJVKjioA4ibJu2kYDMiOOxcnW34SsOrMzKtmekQtY6cRaOCCGcfyW
         o8fOOhX2nDvxxxbm/YyQHpslUPXZPZUOXttDXWb+OSoMDRZKC7d3+FR+VFKF5MlAaDNS
         Lthg==
X-Forwarded-Encrypted: i=1; AFNElJ8sDDPM2CYdAdqKCCUsetD2gZrwg+eE/v8SPwoRN3jsX4C5d9U6l0rmUc0KRjQgup7Zzj/ca64P5ZUbKns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvNzugRASPFO/hDHaTLVNnVr37Jb9YNLzg7eWw74ivSEhePJD
	s+b/UsZl1mzErISLD6RoGIXViNAikvQXMo//PnJUNehKA/2c69b2n1tAbvcPn3LlGS3NOphN5wB
	kfA7yNA==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4655:b0:82f:de7:d29
 with SMTP id d2e1a72fcca58-8414ae013a1mr2977074b3a.31.1779368357753; Thu, 21
 May 2026 05:59:17 -0700 (PDT)
Date: Thu, 21 May 2026 05:59:17 -0700
In-Reply-To: <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-28-seanjc@google.com>
 <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
Message-ID: <ag8Bpc_uVNrNWqfX@google.com>
Subject: Re: [PATCH v3 27/41] x86/kvmclock: Enable kvmclock on APs during
 onlining if kvmclock isn't sched_clock
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
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
	TAGGED_FROM(0.00)[bounces-11126-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
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
X-Rspamd-Queue-Id: 788C55A6502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > In anticipation of making x86_cpuinit.early_percpu_clock_init(), i.e.
> > kvm_setup_secondary_clock(), a dedicated sched_clock hook that will be
> > invoked if and only if kvmclock is set as sched_clock, ensure APs enabl=
e
> > their kvmclock during CPU online.=C2=A0 While a redundant write to the =
MSR is
> > technically ok, skip the registration when kvmclock is sched_clock so t=
hat
> > it's somewhat obvious that kvmclock *needs* to be enabled during early
> > bringup when it's being used as sched_clock.
> >=20
> > Plumb in the BSP's resume path purely for documentation purposes.=C2=A0=
 Both
> > KVM (as-a-guest) and timekeeping/clocksource hook syscore_ops, and it's
> > not super obvious that using KVM's hooks would be flawed.=C2=A0 E.g. it=
 would
> > work today, because KVM's hooks happen to run after/before timekeeping'=
s
> > hooks during suspend/resume, but that's sheer dumb luck as the order in
> > which syscore_ops are invoked depends entirely on when a subsystem is
> > initialized and thus registers its hooks.
> >=20
> > Opportunsitically make the registration messages more precise to help
> > debug issues where kvmclock is enabled too late.
>=20
> That's a hard word to type, isn't it?

Heh, you have no idea.  I've been "this" close to creating a VIM binding fo=
r a
while, it is time...

