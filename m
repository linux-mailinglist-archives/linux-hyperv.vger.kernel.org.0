Return-Path: <linux-hyperv+bounces-11543-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gKi+GxJfJ2pMvQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11543-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 02:32:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2D65B5B7
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 02:32:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=leHyf0cd;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11543-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11543-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0CFB3061CDA
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF07223322;
	Tue,  9 Jun 2026 00:31:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01781E5B68
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 00:31:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965088; cv=none; b=O7QySV10E64VFo+/1edhIQIZd4KOxWmqL8r5FQANcwZh/hAsFaUFdGCr7yJW+QtaTKHOj554UhQvQ2joyVOQNzef11smNUWnyL5njt/vRt+Rv8nXlSHXiL57VvWZ9TSHzbv+l0DHNOdjuNmRVoX8Y47z6/i2CBQBQryd+r0XuU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965088; c=relaxed/simple;
	bh=yIJ6TQJxT7dONmA/83aONXNhkBdZrn6zCKFw130M9Q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYj9ep0UWFNAa2J8iYGNU/eDy9tC/k8bI22eY8gjesXNkmsJeC5fFJADHffqYrL5idyIOHCUg6XcSQwXpnF8dx08YqVNRtFSGnmvzhcfr2YGOxuVwvJZfjku/IuPFKojFBS/LlwM5wGKMfd5JWXyJYtqnZV2rlQMRiXEL+fuuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leHyf0cd; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d97415004so9351972a91.2
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jun 2026 17:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780965087; x=1781569887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2pVFo4dJytLODVsSoHOHadkmK9decmDzlODrRei+YU=;
        b=leHyf0cdogosuxxRPjbyiB8XJyMDOjXYEh1zdkbpSjrn/myRf1p2V0bAWPZ3I46xAd
         HU8+F0GSG/0gImPb3sRwhzzgknD8mtFSt4HyG1kd22w+9iQa2GnQWCnU228N78WaxMJN
         Vc5D1xHt4WSYR33XTspNrBWZ0lNGlVBAAHlDPCZjFea8VfbL2KcjmvLFTvGHKW7Cc/Jo
         6svmRjNKIYkODQZpsJhnGnZVkSAr6zUCTmdUA1avO3qm3H7gOhhyiWp3wqvP42QUdkHR
         bLUSVPnNwYEoOaUjQBAkuV11UyMNWzwjOoBgEvpwo/BpVleCju/Ueijr8+SCbJ70vbAW
         0LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965087; x=1781569887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2pVFo4dJytLODVsSoHOHadkmK9decmDzlODrRei+YU=;
        b=svEpshitgTMp49PwCY/FMc4e1gpraVXjBfiex+ves1+hSz//wFR9srqrWqgoAxBNN2
         HNd2JroX44i5baWYXGocUNcrvlxH3Q6AJ9NtaMpIT2BmvJMm+I+c7tcz3pzkcdrwlKPj
         R/jf9wykVEmxuruO6DnTDev9UcmB0huGlKo6CJe2LvkdNOCftFs6Ukc3APxEw3L4mNZ3
         uUdPS/nw+/yLNu0uK2JQZapvzFxBabpo76QAT+oTfLdxkKtXXMCkP5P5697iKL7MB0D1
         2+fSx5qo/95br8JqzfeStXOPTyG44tHZBEgn7oWW/ZL10fuLJ9MWQe2ZLhOxMr6dx5Qo
         ySVw==
X-Gm-Message-State: AOJu0YwGaozneTy+R9mVvZbJTaxts3/4VEaPmNAP+9mF8NEi7bZ6LSdL
	r6hYaBnpJ53czE1q6/BROJUsexRr48Y+3Dnu98DubKyGs9OzrVvST5q+ypC8i8BpR4gAk7hTJZM
	m5CNtmA==
X-Received: from pjbfh16.prod.google.com ([2002:a17:90b:350:b0:36b:c7cb:baf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58e7:b0:36b:936e:73c8
 with SMTP id 98e67ed59e1d1-370f0e4ad33mr20840879a91.19.1780965086844; Mon, 08
 Jun 2026 17:31:26 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:31:26 -0700
In-Reply-To: <20260530070848.158521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-27-seanjc@google.com> <20260530070848.158521F00893@smtp.kernel.org>
Message-ID: <aide3ppnmB_suEab@google.com>
Subject: Re: [PATCH v4 26/47] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11543-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9B2D65B5B7

On Sat, May 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index c81a24d0efdf6..fd1c417b4f9b9 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -460,7 +460,7 @@ static void __init sev_map_percpu_data(void)
> 
> [ ... ]
> 
> > -static void kvm_guest_cpu_offline(bool shutdown)
> > +static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
> >  {
> >  	kvm_disable_steal_time();
> >  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> > @@ -468,9 +468,10 @@ static void kvm_guest_cpu_offline(bool shutdown)
> >  	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
> >  		wrmsrq(MSR_KVM_MIGRATION_CONTROL, 0);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed that
> MSR_KVM_MIGRATION_CONTROL is cleared to 0 here during CPU offline and system
> suspend, but it does not appear to be re-enabled upon online/resume.
> 
> Since this patch introduces the kvm_guest_cpu_action enum to solve an
> identical state-machine issue for kvmclock, should we also use this action
> enum to ensure the migration control MSR isn't incorrectly cleared on
> suspend? Otherwise, wouldn't a single CPU hotplug event or a suspend/resume
> cycle permanently disable live migration for the entire VM?

Looks like.  That's someone else's future problem though.

