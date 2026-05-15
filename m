Return-Path: <linux-hyperv+bounces-10948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNOIM4R0B2ro4AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10948-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:31:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1A556DCE
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9EB7300E62B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6F640C7A8;
	Fri, 15 May 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiNyH4Eg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5303B6BFD
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872865; cv=none; b=Wg5M+rKKRHZUv7eQP34hAP/CYvbtFvDD26I5NFnjQ1OQV1EUQXEyemG8hFl8AUsBl86dFqPSu/VvUp6QVrKhPW+SqjV6xr3dpTW8xl5Zc0DQDFjS7EkNIetqLqW/AnmvvKD5B1+clHbfYSQtD+bURhHN/8Em6/D1D1oBIaKXOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872865; c=relaxed/simple;
	bh=++iwLO4D9TJzPz8kuVQ32pM9hy17JXnAFhkjXdC7Tyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B9gvNmr5SBn717e5mA9r1bYA7rxTHl0X1fVuNTYukhZCsGCNIWjiVFzY2maDYjZFHlsHDPcDP+elL5omRg+CISM8IGmuWyV0VXwmIo0JhQQdHoSBV+oxBfjrd9r3p/XnJ4xyZym9we3tszgc34zALpu60D9x9WjHmsCKO1Ghw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiNyH4Eg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so95299b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872863; x=1779477663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cmCCoVXH/wzfqmDby7kD+g/lqwg2CVoD5UqPiffRRm8=;
        b=WiNyH4EgkSkGLo5UY/FqEkQ+GcvsC5gGeLEmdJrO/wKCF5W5PcPAjrMdc8pF45dOVr
         duuJBVD0V2aQUAxk0daA+LrQqRAl9B0uTXEUJVjR1Cx/BOW8liKPJp69WzgtRY4pyCJf
         qtV3BqnoHfgD3p2YmO2Ly4QHSVxxd0+pWeMZvywm+r9qC+ZwsiSCWY0BKUCwazBw3ZEX
         pYOmIEzbP+IOaxSls4h6CprAkHZMdBpUg0pOMRqynVYIulTTtCRjqYp+scoVPK0Qv+3v
         QH9acRF0jGDE3kVCudHAAKRitwMROdkRMitHNu39QSCm8ULokSsxl5xRPQncWKA6Sd/N
         OzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872863; x=1779477663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmCCoVXH/wzfqmDby7kD+g/lqwg2CVoD5UqPiffRRm8=;
        b=sFpHNX6S5DvbvUtPRNKIuOcv6mlCpxIl5uigrdQyRUcdMI8MKfCq/bGzMc+fgU5xCP
         S7eLJLvzLvnhN+C26DVdm1hGx9oFbgvYPaVz8yw1MeQrmq2E4ZNDUwhIMvTwX9/n9tb2
         zOnD9xEUA6UYnVJX8Eu9IXIXGZfMaOxAwBOcjgDdD6OJAHqSCTVCiabFDcvFpDHpYduC
         qDyiYynQ8CpZxdnP1xj8zvoehg5QCF0ca4XVT0y0EXLuIsK9K/Kxn51F2mI1BIrGXi7W
         VWS9nC+lDj36GxJzYoReRTJqF1fVuhvGt68C6LZWzvJpgsCpolCTcgp9cpUHX1SdWdeg
         SjGA==
X-Forwarded-Encrypted: i=1; AFNElJ+wC+obKfB49snNECA04ZPOlytPX7KgPrZwnIEmO6IywvjE5bPXqAOOWatFrrA0gL/bAWXqRQLqx073y24=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9N7mBLN2V+F8CMsFAg4mCBEXneDqYuCCRK/kGtH227irx+J6
	5/89t2AhfL6+UN3waza4iz4g4lIqlkftn8TzYQvyOkCRZXi7IkOVm+jqblWgFMxfBpTvu8zSA1o
	rFu7meA==
X-Received: from pfbeq3.prod.google.com ([2002:a05:6a00:37c3:b0:82f:ad57:40bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44c3:b0:82c:6da7:2d3d
 with SMTP id d2e1a72fcca58-83f33c2a8fdmr5145208b3a.11.1778872862416; Fri, 15
 May 2026 12:21:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:26 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-26-seanjc@google.com>
Subject: [PATCH v3 25/41] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
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
X-Rspamd-Queue-Id: 47B1A556DCE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10948-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ccb2aff89b2f..655037949446 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -131,7 +131,17 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
-	kvm_register_clock("primary cpu clock, resume");
+	kvm_register_clock("primary cpu, sched_clock resume");
+}
+
+static void kvmclock_suspend(struct clocksource *cs)
+{
+	kvmclock_disable();
+}
+
+static void kvmclock_resume(struct clocksource *cs)
+{
+	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
@@ -202,6 +212,8 @@ static struct clocksource kvm_clock = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.id     = CSID_X86_KVM_CLK,
 	.enable	= kvm_cs_enable,
+	.suspend = kvmclock_suspend,
+	.resume = kvmclock_resume,
 };
 
 static void __init kvmclock_init_mem(void)
@@ -297,6 +309,15 @@ static __init void kvm_sched_clock_init(bool stable)
 				   kvm_save_sched_clock_state,
 				   kvm_restore_sched_clock_state);
 
+	/*
+	 * The BSP's clock is managed via dedicated sched_clock save/restore
+	 * hooks when kvmclock is used as sched_clock, as sched_clock needs to
+	 * be kept alive until the very end of suspend entry, and restored as
+	 * quickly as possible after resume.
+	 */
+	kvm_clock.suspend = NULL;
+	kvm_clock.resume = NULL;
+
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
 
-- 
2.54.0.563.g4f69b47b94-goog


