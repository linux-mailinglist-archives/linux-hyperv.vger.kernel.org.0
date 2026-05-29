Return-Path: <linux-hyperv+bounces-11336-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBuCC0SvGWpyyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11336-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:22:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B11D604938
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35892327741A
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC1D3FCB05;
	Fri, 29 May 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7MrJ1oZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E213FA5F8
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065912; cv=none; b=nG3eVihlaXNBwY3NiT/wV47VHyCdfkG7T6bK2ZG/A75kVmERUfFHJmjkSfwVLwZ8ezkOV3Die7Agj2LQ5LrtgKub3S50u5TgW19DZVxys9xJ5eM3HqoPQ24V/O2XubQ/6GWdPBckqd+1TTNWwr/L9uoAmlnTmFjtOCrOzCQ6Y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065912; c=relaxed/simple;
	bh=H4O1Uc1N5QXpjXIPDVIAG3zCuTw/l761jFnyTqpLBcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KHtAVdBuZ6z0wz4cHWKiqecAbtA6JUxKCuaTUbLLS3zzs8qtHqOk23ZLsONs2YE3qLIMgUhUcf6pUAgjNebhmquFxc9Yk4zuqJ7QBYkIbOrz/P5AHEA119CFpb8DVUgOu96FnzRbUVuSELdwuaDK65Xu+bx1R+Io6PwxCF6Hf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7MrJ1oZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-366344513a3so26702758a91.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065909; x=1780670709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dFi7v06+6W1FLZftWdDZ5nEL1MuL8W1WaU9VoOY7VWI=;
        b=V7MrJ1oZKspQN7qETJjPUM7LaEej9HVimZwS0xAvdnP3YrMACxPA/yCxYtFu01eURv
         6DUqbetAiRv8q52VuFfPYhIxh/Bf/YCba1+tsQrs2FNTjAiwo1rd7/YW/MCL1TSQG9ui
         lmPIdZnRNENchq/YHUBy+1EIMn8WJoQT+gpwEfohBvnpMQiX7pUJc4GaYARfC8/SDtLj
         FUTK1W87im8sn0Jq4bcCqFOEhAZVmj7t1+hB2PAnHhXnHsMT6Q96x346bsbmssDizETW
         gFKX/IzYEpB8U4H9m8iAS1WTaIIwQF+04Gdg+dpHyANxl75TNBgQAg3JmM2yExHahoU2
         tPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065909; x=1780670709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFi7v06+6W1FLZftWdDZ5nEL1MuL8W1WaU9VoOY7VWI=;
        b=YlIF3BLcK/RzSY/a7tL59aMtARjdmLEfXVcUzvYZlXofdX2f/Qh0kgQ7j+ghZOry/e
         lT6Q+Fnvz6kPgS4wfik+nN6RbqhO35LB8YnViK7eIGqJnI9MsHJ1La4yLneqZOoOmJ0C
         tqk4eReQy+h08sdjoEIHP1JxgyjdQ9uwSM8J1nhmT5ofbH9WTS2KPzy1PlA2uV4HyW8m
         bq6lR2eT9AOA+DYu/2aZ0UQtD0MbFdSRFdeKCGs9t5JF3JRp9T5bB+iHvQ7pK0z/JeLQ
         Bl3+w6tQuHQ4r5my7HrzPZwnQ2e9/PC7jzMBN/lkaqiOic0UVJiCwv7wKpJrlR97DJo6
         Jrig==
X-Forwarded-Encrypted: i=1; AFNElJ/WnwYFuy4xDT13wg7C4P+PpmIApjKcXkmI1xfDO6cr+mX4fuMnXGOrUQSvRBlxROrevGNOJpmlB12iIW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvorJ7ADJjTB2MKYxfn5qzhaWYHKIrkJ6INmNyihVqF/WD5xn
	BFdQLqYEqIOUag6LG+lsQaI2h4tFY4gbxIYmUZif08Q5zk28PXapufUzFsYa0ZkWHsX9EI8AwLb
	E1Fipww==
X-Received: from pjwy3.prod.google.com ([2002:a17:90a:d0c3:b0:369:1a1a:82d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:518e:b0:35f:b6a1:8d27
 with SMTP id 98e67ed59e1d1-36bbcd92760mr4080563a91.18.1780065908349; Fri, 29
 May 2026 07:45:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:01 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-15-seanjc@google.com>
Subject: [PATCH v4 14/47] x86/kvmclock: Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11336-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9B11D604938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz() in anticipation of
adding support for getting TSC info from PV CPUID, i.e. in a KVM specific
way, but without non-kvmclock.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 69752b170e0a..c4a782a0c903 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -115,7 +115,7 @@ static inline void kvm_sched_clock_init(bool stable)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned int __init kvm_get_tsc_khz(void)
+static unsigned int __init kvmclock_get_tsc_khz(void)
 {
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
@@ -125,7 +125,7 @@ static void __init kvm_get_preset_lpj(void)
 	unsigned long khz;
 	u64 lpj;
 
-	khz = kvm_get_tsc_khz();
+	khz = kvmclock_get_tsc_khz();
 
 	lpj = ((u64)khz * 1000);
 	do_div(lpj, HZ);
@@ -320,8 +320,8 @@ void __init kvmclock_init(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
-	x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
-	x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
+	x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
+	x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
-- 
2.54.0.823.g6e5bcc1fc9-goog


