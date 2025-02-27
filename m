Return-Path: <linux-hyperv+bounces-4109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B168A472AA
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511237A7554
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A022E011;
	Thu, 27 Feb 2025 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nm8uHFYu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222C22D79A
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622787; cv=none; b=u8bu584Z0rDl4FXj8Zqjo02fxynAsZL+PgYM8QJ59Nt3YKVj11kw390lQFpNwqzG0bFgrc44TE+/XPbAcHL/GOqvwMPlX0zycwlu4qM+j2ykuZIsK8MQHY1MQJoL5uaL0+y3d5OAFEjTc1Jwu7XH/EFAX+B3YHDKnWhT/jXQYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622787; c=relaxed/simple;
	bh=2a8H0eAkRitgl8N78ADmzcHYgYnoAl+7GQjDO0K/gtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLkJHaBekycBX8fNzQQmEaaET3xjLAlOgBTPmlaTLqNJMQQqWYdiCMr8TRPh3Dw+3bF5WfSf7qrkKwsA6GNwmhOUWNcmc9iJx26KqwPKLGUr2vyFk0oU1u7MlnPZwrcAgGLRTr+VocbwjqwR3pJ/2RA0ZMPCJyEp1DeYZg/HpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nm8uHFYu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8fa38f6eso1027145a91.2
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622785; x=1741227585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qN8YI5wmqMG6yVEs+7cu8Sw/AfoU86Z3NaGBSlCYqu0=;
        b=Nm8uHFYuFCk8Bd2Qof4oqMWXSWGl8WVAxHjMxvQY4OFbVcZmBLVgG/N5xWGh8deco4
         bt3AIBG6yct8eJW/F6RmyoZrfmDQLggUH6t+q/debx423fkAmEhwWRJuymWTmpuiiRC7
         /P+yt6HaBQxc83xO5w35QbmGvQ55JUQCwglUDc7XDMI04DPOG3ZGPmz6qDLRsEmSuYDj
         KVUVzKlzVmbvAYldM1erDs/9pX4bSxKfB0thCPvgmlgeQp7OOzUpvNWUMA0gOXktNi7z
         JF8nv4+x1u1DMTwnkpV3RsVlQoqe4odhcfQenOF1luUdcA/2UCyrLsHh6+53/KrEu8Oi
         bHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622785; x=1741227585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN8YI5wmqMG6yVEs+7cu8Sw/AfoU86Z3NaGBSlCYqu0=;
        b=aHg10OkgLFnCKVn07ylPQzRwKyOB5s/Ito/Zg+Zqc071OyxlaKoPMZJPfSQ8/duevN
         yl7TqoGDF7oxjOAVfUtI4sMUMxEp6ELgxixYjeA/GB1VhG3KymcKeMdyspnsoWjP1PZy
         6MoedKAMRCNF8R62iMYER+ZSe0y7G4pQBzV9GN/0PfsFYL4xU0cq7arEEodb9tix/ppT
         G2N6sIuRuHPgXS4aX+cd0RD8YBezuChh9EMfPYK4TmhasdOwUxMZamL/eE8vFtbSoYcs
         MlEjewFrDFdaUaPoVMAdTEkybQlyXQoN15pjbXnnKnu4/0FnltgN32Jt3w/3f1fVYIJf
         +MpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUzA04eFLonBC/cn7/32/RWlOXNGhDbvecUAu7SEJeRAm0AOGapSWDMTMtDfXxT4MluZ4pSJCgc/Jda3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuKBqHiy9H5CoAlmKDo9/dPVf/jV4rcleOsq2XV9q9Jrf21PLO
	C+WSbXDQKbLKIm7eBXASrGI32ZwxOsupTlaxr3rXxDqWoUKkYgBSdO8wVUeEiFf/wvKluNffnxs
	MrA==
X-Google-Smtp-Source: AGHT+IEw7VZRln4iIrg1rWM/7IZnuYkNWSUUNxKKGfY9HmA7vrLySNMf4INY1k647TDU8xAK61s1yi1H724=
X-Received: from pjbsw12.prod.google.com ([2002:a17:90b:2c8c:b0:2fa:284f:adae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5243:b0:2f4:434d:c7f0
 with SMTP id 98e67ed59e1d1-2fe68ada3e8mr17648463a91.12.1740622784911; Wed, 26
 Feb 2025 18:19:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:40 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-25-seanjc@google.com>
Subject: [PATCH v2 24/38] timekeeping: Resume clocksources before reading
 persistent clock
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d076f195..332d053fa9ce 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1794,11 +1794,16 @@ void timekeeping_resume(void)
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
2.48.1.711.g2feabab25a-goog


