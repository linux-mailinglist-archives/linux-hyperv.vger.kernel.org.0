Return-Path: <linux-hyperv+bounces-11361-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NSsBqCvGWqiyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11361-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:24:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C29460499C
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9ED53050829
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508333FF1B9;
	Fri, 29 May 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTj86DPw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62333FF1A9
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067300; cv=none; b=pdm40lld+ZiIiMZNH3OjnzzhfJwdz7xsVpOiAVhw4KiQ/bs3eyLsP1ixA/A7xLe/RoKJ+yjbax3UoADXhneQ9w31SFR9aA9sub7zVF00ew0CgonCKNq4ebGZpllVihNvrnU+OjGCRhjzA6Q6Q1m7NQgEYhXQZsYVSOn1RtSwlq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067300; c=relaxed/simple;
	bh=cK9bQGlpdv9LZcFmZsWC/IHJdDiSPttcr7RlDSILQVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZtAzjwbHrmpW9v6WlM9GCdarnTnU/HenUqTXRBB1SgxMPYGiUsNPc+yGUa7VsbFrYStRfU3eAokLujVoA9vpsCPsmWzMqAWM0858abAQrQYsNT7GSDeh3vWqX6c/IRXadlCwqa9OrCoIE24K9oEQbcDOwGN6JCmTCDLE4Ub8aRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTj86DPw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36781927b4dso8581658a91.0
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067298; x=1780672098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tzOZYRAyrYNaAuUvG5/Y5SZS8EF8Fxjy2/uxgYTIQuI=;
        b=GTj86DPwVtIzh07TZ2E9ZzCewjDPtXPKYcAYlo23mfKTQn7KRrK/IdGQU7bYrBsfiF
         zPmoBrnO/fxLJLbOjkwppkFk5a5xlgr7d/aQayrEYvHEPfLQgk04rwJgGRaDmAevzvDe
         rT3wlF4CR1o1gUj/BnnyeongLnetidaLuGrUik4p0D2yrjFhDqF8+tlsKj0jL4fsoSGG
         s4KS7wf5LDFQunxbnE6lXy/JLIaedxI0VsYadTnBie/U2Q7ZeHiXCWkethTVioycLSxj
         ELJT8xyMdA0WbYZ29VRuNb6/Mht7O5UMoQVJi3Hxdb1Dn0NBt9aNBN7kTGWLEYZp9pOW
         f0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067298; x=1780672098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzOZYRAyrYNaAuUvG5/Y5SZS8EF8Fxjy2/uxgYTIQuI=;
        b=EUGfG25DgAAt8F7DN+pF2x5hJGk5Hf31wyAqtN4FD/eUAFJ2gYJfrC4z7jSjgQ0JrJ
         +0zLuFLNf2fSIkD2/3xzi8M6E/kG80GaOQufKmjYTqdTUtnGsffIxRk+j3iwb2bFd938
         j3DnKFWbd/Pr4ZAWgVssDY+AoOZOTnd0YEgAZX2i3/wvwZ4v1JbxqrasY2ZH+m3kKl2v
         aPlerdNHiATOfOnPB+/0QsVsAZkiX/OMQPPwOQR1iVtxm2Aejo2CpdPW7NHT/P9ciZKd
         GFfjd6qdLOiEUEDn3o0u7Rxbw94xRLE8eBJgm6fIqRQxpRB+hpLKMKEAo32tjuliYXUw
         RMeA==
X-Forwarded-Encrypted: i=1; AFNElJ9WD1twDYZ+xZ7gBiIo7PzbWyYIdOVqH4B7hTJc8BV8v/VUIfprJSktHWDYZwXodlLZlcFNWepbz/aMiP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNc9woUnbt07iSYGWepCJhbjW6EdAEyb1eMaoUzk4913krwEa
	iQDovU6Ue7epvcL3W4sNmc2qwRP0UfgMKpNHu5HHh9kiSvUPZ6i0DwmHJxr0Oi1cwYiLoQoH1Nk
	e2MJR3g==
X-Received: from pgbbz16.prod.google.com ([2002:a05:6a02:610:b0:c82:253f:d5e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:36b:293:68d1
 with SMTP id 98e67ed59e1d1-36bbcfd8de4mr3965602a91.16.1780067297895; Fri, 29
 May 2026 08:08:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:14 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150814.714658-1-seanjc@google.com>
Subject: [PATCH v4 39/47] timekeeping: Resume clocksources before reading
 persistent clock
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11361-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,infradead.org,outlook.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 0C29460499C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When resuming timekeeping after suspend, restore clocksources prior to
reading the persistent clock.  Paravirt clocks, e.g. kvmclock, tie the
validity of a PV persistent clock to a clocksource, i.e. reading the PV
persistent clock will return garbage if the underlying PV clocksource
hasn't been enabled.  The flaw has gone unnoticed because kvmclock is a
mess and uses its own suspend/resume hooks instead of the clocksource
suspend/resume hooks, which happens to work by sheer dumb luck (the
kvmclock resume hook runs before timekeeping_resume()).

Note, there is no evidence that any clocksource supported by the kernel
depends on a persistent clock.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c493a4010305..26f3291a814d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2098,11 +2098,16 @@ void timekeeping_resume(void)
 	u64 cycle_now, nsec;
 	unsigned long flags;
 
-	read_persistent_clock64(&ts_new);
-
 	clockevents_resume();
 	clocksource_resume();
 
+	/*
+	 * Read persistent time after clocksources have been resumed.  Paravirt
+	 * clocks have a nasty habit of piggybacking a persistent clock on a
+	 * system clock, and may return garbage if the system clock is suspended.
+	 */
+	read_persistent_clock64(&ts_new);
+
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
 
 	/*
-- 
2.54.0.823.g6e5bcc1fc9-goog


