Return-Path: <linux-hyperv+bounces-10939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCHFMgpzB2r03wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10939-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:24:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA8556BD1
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FCFE3019035
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28C3E1227;
	Fri, 15 May 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQKdmMYz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB33E1228
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872851; cv=none; b=Dq4hmRF1JF0h2lyIuk0mtcCHa2ochgfOVNTlobI8OObAVctHx7Ws3Ncsbot1RkB10xGdJKE+8I3w+OhOpmSkzI+QYbofCFmZAhEaJTKzzWOvFCDqcAeFKUkZdNt6D1Mw5zKcnIpFaupZ48M7P3LaefOqJv1PDY3n0qRPMpxXcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872851; c=relaxed/simple;
	bh=7t7bZAkjWH8tEuvlMroGRphDuT5a2BO5RqjwXybBung=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gY+xUOqSW7FtPCl3k4ws6qmMhkyU2R5plKtFMNvQmEGGoKu6UbqzWpguBDXgXo4EWniMs1QwKRZUd2I4NN8ro0eW4BG96KKXec5V8BJc8i2uBZFHvULThJmTlX6ERv5qcr7WKr0IkdpcvX7vwB09nBE3OUYxCug2ea5Gufos7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQKdmMYz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso223282b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872848; x=1779477648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=c0VSXuwvwTL0EdvBxlPRCLOC48TzlA2S3UU4EaITdRg=;
        b=MQKdmMYzTBG8D2ABaPQCcAEXqkCMCGJv6YwKGlaX17DMGnVCbdP3MUgauOOEQVKXMw
         A1acNcHqJLtVxzGoElkRdW00I+B6Eq/ogRlIhwAHxHQBb7DI7LU0YLJhPBCP/Tfmqlbq
         qdX76nD9qXo8PynEjKxwaLLRclGgRG+c8tzwVHdcQHcb5Jr9xZY1vbBqM5EfNoBaVDsQ
         8GTii7EzsxR8ngTFNT1kJRBts7PgUylrNdnGQAyzy/J934KhT7vEkfCcC+4HesscZh29
         66XT19rx4KZdOoE7LWfYTKMlNy9umwj4UPDZr0Bj9VjvIWedfr6+hPzz4WF40enA78Ce
         UBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872848; x=1779477648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0VSXuwvwTL0EdvBxlPRCLOC48TzlA2S3UU4EaITdRg=;
        b=jft9ixxBn51cyG9DaYB5bZe07X3QbI6lG5LwgXLBqhrNoje7nhIfXUV3F7DfOEFYhY
         wb1tCZJCkGqBEIYS69yeULz+ansZ67djTHQ1Fmqsta+YIcIrqns1JMj6HzlRR0n7QG1u
         tWKzL8pdjTjGPtTl7153ksokxWLSwNh71Lkswh0HTx7AcXsgW78sxv1gAL8frgyPcrfd
         du/L15Hr5fDvYw8XkHCFZIFqgbgwHRgnSPEqsm2VOOOI6HmpQgdYTVSxCH023orcUmZ/
         rQwDKG5yxp/ro5sRsqB39QoHUGzOxNX4Bw1eLSwX0wHOpWBOZ+KO2XMYy5sXjXnZk1gs
         makw==
X-Forwarded-Encrypted: i=1; AFNElJ+4hNKDnKxKBR6jBqyp9Wh+8JhQT8VaxWv+XKN0dg5UJhUsbS8zswB6Tv00Rf8qSxn+ldxIwRa4CR3VtNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLq1Bx8L4+dXoFmr8vC00IpTadfKUGf+O8Aoy3l2W6jbR+83k
	EKRa8pScj5aONk1k6ev8qlAyWcsMwBSItSXKThcMWcjdba07TL7xAEuEuMMoLSqnQqzzbNMltDE
	BJUGE5w==
X-Received: from pfbff26.prod.google.com ([2002:a05:6a00:2f5a:b0:83e:dfc6:971])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1908:b0:82f:50cd:e586
 with SMTP id d2e1a72fcca58-83f33cb2c40mr5886442b3a.13.1778872848066; Fri, 15
 May 2026 12:20:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:17 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-17-seanjc@google.com>
Subject: [PATCH v3 16/41] x86/vmware: Nullify save/restore hooks when using
 VMware's sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A9BA8556BD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10939-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Nullify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index b88d9ca01202..b5cb66ca022b 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = NULL;
+		x86_platform.restore_sched_clock_state = NULL;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.54.0.563.g4f69b47b94-goog


