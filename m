Return-Path: <linux-hyperv+bounces-11756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6+uDLUdyRWrCAQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11756-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:02:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE56F13B6
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:02:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=CQzCN0AC;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11756-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11756-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B825D30BF641
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DA420322;
	Wed,  1 Jul 2026 19:33:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305541C8FD
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934384; cv=none; b=dynm6iOsQyKOAlKhKzWvoF0plNEHmhK57g0+sZMHbUYt3Hni0jt8+PD9P1I/UW3L79Z3uJEkz5nNW4Yk4QzzwGDq2YHs5nR4nXwxBp8nMELARltKjv8B1moZ/dn2Q9NY0iz40XPatX2AonMa8PQ1/lW+JKVCVamqxUWyP5TIK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934384; c=relaxed/simple;
	bh=7ECvDpVYy24rqoUPVQpDZNfw6Aqt7A7i1akOyN+Prss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nrQ9wwirInCsCbSHM+f4YpxHpLKykYiIXMF+feUU5rJsdWXo7NPeQuLyhdiolYwogxquAI5lwvD8Wk2tDnix0eo6EkFoUCQqUsMgYEqkZb7pFWUk4SmROwu3xbpxt4ERd9ge4MFAXNFGC209zwpiCEwdgvstVHzx5VtyS4JbKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQzCN0AC; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9b1b608e2so14566885ad.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934381; x=1783539181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IHAlzrllQ2SIWnv0fCfBsaTBNv7ymljQujJZvblLIYE=;
        b=CQzCN0ACAaAvmxLn9iO6kp1ucIu/WqLJDOhykicMtxuOouXr9PR/ebiISKMyfORWC0
         5CHZoqSVxkyJOfVbPcE05FrI0g3QCmXj8CX05gJzeFq+RnHmbdtFoTSn2t40rPnl0z4M
         qumURMY0TyqM7kYpox5uXDT74KsdM9vcCKXxLnjahHonTtBqczuEnDCyomANL05UMPq0
         keY+4jq6lQARwFqjwQ0q+xfycGJOGvcqlkbnH2N9b2sx4dzuob/ADc2tAspAu0BYmRj0
         ICALso01B5YaF7ApHwfG6X1LDwLPQcQ7cj3NdknQvQkCbJXdRdN/jriTaOFm83kPbkyJ
         Nk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934381; x=1783539181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHAlzrllQ2SIWnv0fCfBsaTBNv7ymljQujJZvblLIYE=;
        b=VDK60P9/LZkYGY+v5E/7r6vwt47/QaH9W0QIOmnuhTjH6Hy+3eLvlbvOb+DdIq/tn7
         lJDvAuJxxF5BXFpOAaTix3tlIDmNlEQWAfrJj87RhDs4bz3mc2p9AlKhwpCzU/qwz1Ou
         obgSIlCz7fec94kX1aRyNJHjg6CaHCI8dtmWLGEsQXtSz8zdGVLJtoj3M+Dn6rieArGK
         0OnW6eZ24Ha7mg6pM2uA3mhdrZ2UoQKsbNhnAxzaFCrFbn6t+xlnVUeQKNXdLDrlmqk9
         iYgec42uiUg2LdglXh9EDBcSq/obTTFYl70FT0+oYFkIqQjj1t6jx0vBIz7z4YRlUyca
         i5qA==
X-Forwarded-Encrypted: i=1; AHgh+RpoqpEwcSYWVrg7PUQ4HV+5wV/T3PYrOst1kE8U+rL3zS0eGoT/xjL/ptHSHsaXcwvZXckT0BT+PypN/cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4AQ9Wuo/531F2ubgqx1KMTBSmdnr7KW3u1YlNDuGtxdgSXHB
	0oGKrkXwbZQtLtcNflKPD+kMU/sQ7lSrINvZbRuRS9rZziwucDGar3TByMG6fznfbYBAraDK5gK
	fgFgIpA==
X-Received: from plblk15.prod.google.com ([2002:a17:903:8cf:b0:2c7:f338:5690])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c7:b0:2ca:de3:15e2
 with SMTP id d9443c01a7336-2ca7e561189mr31594705ad.0.1782934380474; Wed, 01
 Jul 2026 12:33:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:49 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-29-seanjc@google.com>
Subject: [PATCH v5 28/51] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11756-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1DE56F13B6

Gate kvmclock's secondary CPU code on CONFIG_SMP, not CONFIG_X86_LOCAL_APIC.
Originally, kvmclock piggybacked PV APIC ops to setup secondary CPUs.
When that wart was fixed by commit df156f90a0f9 ("x86: Introduce
x86_cpuinit.early_percpu_clock_init hook"), the dependency on a local APIC
got carried forward unnecessarily.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 2e7ab54cb9dc..b0c871ba8232 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -208,7 +208,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -348,7 +348,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


