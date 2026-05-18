Return-Path: <linux-hyperv+bounces-11011-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UETEEJiAC2pvIgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11011-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 23:11:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A57573A87
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 23:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EF8B3022696
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 21:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084239657D;
	Mon, 18 May 2026 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdaiDhaV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959C396573
	for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138707; cv=none; b=jNNPKJCYT5pboshPbEhULHyIrgx0ZYzt1exVbph+K1g3wlwj1IjbCFqZTuqblYNZTumtBn6rIPFO/lTkqZHA/1HXOkGN4b1JKDVvclbQES3ge3eLm2MxFyy88dshqpzP8IPVMdZk3VfUUOB9ohtXFkCnS8O9Et8XD7qhE6X2GtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138707; c=relaxed/simple;
	bh=Y9WlSbz5Rarbpnp6OSXzG8yVO1DRu83ex3iEeD+K0qo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p/xxvWNXB4kcFFIAx+zqREqZGusIZN3oIm/sg8evXxHcE9xraK6TTaRjmFDEVSTAlzimHbkKgXI04aEj3n0aRNqM3lInEqVv5SkzXvuPBkH7KV6MJ7vxiIcvgcCsHNqxhB0o1igMphbbH/FXcJsegsDa7wb0UJC3D59TOQ7DM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdaiDhaV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba3245a43dso29499935ad.0
        for <linux-hyperv@vger.kernel.org>; Mon, 18 May 2026 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779138706; x=1779743506; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0HR0/OeCt5J6wDdP6oTOA3/U+zZIegjjUJa8wpeaiw=;
        b=hdaiDhaVaqz/zMC0xG8RqY3S8IElZPQAKAqzBXsSuhQcsW2cjmuS+sopRWEi2Z8gs3
         Ue32m7jM50i6l9zH+utiaxr4pvGz2ZTDXaqg7E+19nr8qV0fJUWn0og6789ZZOb9RnaT
         sp3YE1W+xsi/hw5TGgxjvFSQP7kZ6uPKrvqdDu/AMM4rkK+a6QSXLY4pdgIKPA1j82mu
         RBr+lm/l2kzMfkngiHucKtDvGaErUaQ1cGHTgs7VEkFdo56RS3xjrRABpxLqdJuK8OoA
         Yb5f/jtGO83U+xAQwyhovLb7WQUTlIVr+h6cefIA4pdl5FbApjvl3Mdl4UhgtxAmZmwA
         ZTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138706; x=1779743506;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0HR0/OeCt5J6wDdP6oTOA3/U+zZIegjjUJa8wpeaiw=;
        b=JlRBK09ofe6cHhDxJyyz2QsCdOd32gQsYvaXYzI8ab3zwz1nf6b/Vy4c9NdqlQZT2N
         PMqr0SawM0wPLr6Xi/+8pdQha0oZejvkJ9UZYJHs6kQkoCf5OlbbQf61Kkb7uKJp9n9e
         p3hskJo5CkEWEmJTdmE4TWkAR5S/+6GUb6EPWyu0QCpc9tJfpQVnIlak68l9GzBlUmoi
         nAVsepnmb+7P8KrxgNplhMAuG6q0RlGStPE9L7F5Q1yliDJINfiW3JL/KnsP32hTy7do
         d9WLEDdJyBk3ecz3HoqIid7YagnK4nsijZxfq3FwUU7+hKNxHgqIJr6dricmSCwXrsI1
         gb3g==
X-Forwarded-Encrypted: i=1; AFNElJ8IVkhV0KSnWphBp7LIOzmlyMK4yuT2SdptIF/p+O7hPMZJ6tio9IV6dy7sjr8/C646VibFfEL4xdHqfag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62FTw/14XRKzSbU61nNJbAzpkNjWJe0ME6LqerMULVFYuccRf
	4XEZqOu7VKYHlA9g8pL4sEFEs+9ZcKHv4kfv0xKGz0ABtkwabk3xJRaXUFF5PeNFAWFL6ltFoz0
	5gitukA==
X-Received: from plhq16.prod.google.com ([2002:a17:903:11d0:b0:2b2:43c2:a183])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c4:b0:2bd:9766:bd2b
 with SMTP id d9443c01a7336-2bd9766be37mr135740745ad.19.1779138705542; Mon, 18
 May 2026 14:11:45 -0700 (PDT)
Date: Mon, 18 May 2026 14:11:44 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
Message-ID: <aguAkMTrkSVPthal@google.com>
Subject: Re: [PATCH v3 00/41] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
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
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11011-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 98A57573A87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026, Sean Christopherson wrote:
> Dave/Thomas/Peter/Boris, what's the going rate for bribes to take something
> like this through the tip tree?  
> 
> The bulk of the changes are in kvmclock and TSC, but pretty much every
> hypervisor's guest-side code gets touched at some point.  I am reaonsably
> confident in the correctness of the KVM changes.  Michael tested Hyper-V in
> v2, and while there were conflicts when rebasing, they were largely
> superficial (and I've just jinxed myself).  For all other hypervisors, assume
> the code is compile-tested only, but those changes are all quite small and
> straightforward.
> 
> The only changes that are questionable/contentious are the last two patches,
> which have KVM-as-a-guest use CPUID 0x16 to get the CPU frequency, even on
> AMD (that's the dubious part).  I very deliberately put them last, so that
> they can be dropped at will (I don't care terribly if those patches land).
> To merge them, I would want explicit Acks from Paolo and David W.
> 
> So, except for the last two patches, to get the stuff I really care about
> landed, I think/hope it's just the TSC and guest-side CoCo changes that need
> reviews/acks?

FYI, don't bother reviewing this version.  Sashiko found several glaring flaws,
but I just realized that sashiko-bot's emails are only being sent to myself and
linux-hyperv@vger.kernel.org.  I'll make sure to highlight the changes in the
next version.

In the meantime, Sashiko's feedback is archived on lore if you want to see me
get torched by AI :-)

