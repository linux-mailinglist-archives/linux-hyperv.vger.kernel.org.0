Return-Path: <linux-hyperv+bounces-10943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLbYDPJzB2r03wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10943-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:28:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9009556D0A
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D67CA30BDC5E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281CE3FDC01;
	Fri, 15 May 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWE5+zrE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA864392C50
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872855; cv=none; b=AYOXM36BBk5Vkpbl5UddhnnYy6XgfvxucNbGP0N99w1UUaRrkT5sv3zxP5VBgu3m50LkOvvWHzsW+5paNyx6Bw3mRgKDhuaE9voGxx1jYlZWyJWpNltCJD5J5U67bhnyyAZ3xOnsEMhs4fGnN4QGuqBaeNaGOh2HdzkCnGz6d0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872855; c=relaxed/simple;
	bh=xUpUGQiJgAA1ZwmKSf8xfquX01gunhdqbyqPreoYY78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B2OYguhLviPI/xu7KgFmqnZuFNb1tRvoweM1RPaCig+Vd93rXIYvS2sOT8y9rtzXJ2kGb8g+dWnAyJpnfcnSAJ2c1AyW5JtA0dHxNsHSi7GW0iKFlnsCrNtB1mFlGlFLYKD7IbhoXsenxGWSlzpjQn2STKFJGsd4JWmDT+XjuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWE5+zrE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc7f9b2213so1365295ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872853; x=1779477653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KhBZEy0/QKSWfL+Tze5jxYQtO7z6AVGLrSR5LBAuSZ4=;
        b=lWE5+zrE+getZ+4F8eR1KgiFAruihoO9kkdcxqOq0hvIFT9fFUuKKaL1WY06PArdfl
         6Vo4M5Wn9Kqay9z3iUP30BndhCOn8KUdMFD4S+sdaeUS1LoCNV4HHM17gpSC3Qbbd8OO
         OU0WFhXIH2pq7N1DB7Q1qIVfJRuD/sZN/Y3vvDJP/HL0creCyeQRoVhsCnkadDmhPmJX
         3VOZ+MDq/2Zf/V1v6b99x6otVvqV3GhJEO6yjHPK/FtbHeH8TT50IqOZ28R1Vc14H6x4
         bQfIfqDaLiWuH5p1dBRTTh9UA7pCt+e2JmC7TnRwUfaoTbhOsX4DvQkPdS3mw+JsJeQj
         5KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872853; x=1779477653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhBZEy0/QKSWfL+Tze5jxYQtO7z6AVGLrSR5LBAuSZ4=;
        b=o+tL7E8i/EWftC02unfv4ESs1Lt5kwx/bFuWl+LFcabg4HfcLotP9hAOkebimjzp+t
         /AOt3YRIOHhuHVlx+ZNLBJo7in6QYbdC9ARHsu/7RJh0PkI6AmYOpHezHT0WI9Hj7Gx3
         EyoFCL418gfbHE+5SkGT/g2tIsFAnGVlvyeCO45naafv8tzBzK27b85NDmOmHg74BRbZ
         mtIl/F3Fh2SpHdDjzjr1n6EhAuwaySpqH8Yv1v+nGBP7WxkE2LqHNVlINCe5S6/KaXJh
         v03LsiiNwGrdAY6RCOPMCD/tL0+PyBDv6HuMS0cSb/6fw5utwekl0+Cqlt+cuFmf9632
         iaDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yeFe5vjmYRrrKuQ1r+AZOdXlvp20qJlqp6yvQneyG/4UHpK8V6/5iBn4iWsemaoc4n/oywGn4YmUJO40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycom+HbQD3aVeNGP1Owq5cE+dlqvwgPjMPVpWSmY7QlLRpQqGr
	cxqheNQ/Y2XvCO3UKkN2AcVSySs6qdhybYfIgLXj/y+BvIeNonCqJH4oU6kfjbvvABQHmab2d8/
	l+0jdcA==
X-Received: from plbmo16.prod.google.com ([2002:a17:903:a90:b0:2ab:194e:4d54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c28:b0:2ba:bfb5:9cc
 with SMTP id d9443c01a7336-2bd7e8d3b9fmr61656605ad.26.1778872852484; Fri, 15
 May 2026 12:20:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:21 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-21-seanjc@google.com>
Subject: [PATCH v3 20/41] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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
X-Rspamd-Queue-Id: E9009556D0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10943-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index ee7095febfd1..f087bb76457d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -444,7 +444,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.54.0.563.g4f69b47b94-goog


