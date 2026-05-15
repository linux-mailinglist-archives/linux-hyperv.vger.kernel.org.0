Return-Path: <linux-hyperv+bounces-10942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELz7FEpzB2pZ4AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10942-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:26:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F4556C52
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BD573040B44
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9313F44FC;
	Fri, 15 May 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UT3kJ/Od"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C83E3155
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872855; cv=none; b=gl+Tr3wbApvnWz3GFASeJ8+9G8U6pFKkrGRCLHfaSGcKQLh4CCQ5ww+EOl3qOAJHhOMYGIOksPSDzT8a/vxllDS+OUgc2QE443hLWyS/sP/uZFxeE9ihicnyS5ZUHHmhzfzoXMjt6fuMbsI4iorgzWo7WiBjmqJ7ZyejhkQPahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872855; c=relaxed/simple;
	bh=MgerBvYEE19VEGmb0jwZ6MxNxLG6DRj12L8dn18zHeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJ6Bx0fCWn5eqXAOv/d/q6XB0b8uWy3Yq+ayUplDnpZchV9XIrONckDyydYFW5U48GaKctBZ3MDZ+oZ3yIXaWXex8KnS/Ovn3aw9TikWUlpzRfl8uATXDHd3P4tdG011fWFx5DYOAM1WE5Tv2SFrVxU4VVoN1bBUvZtc8yfKmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UT3kJ/Od; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-836cfd84728so39227b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872852; x=1779477652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pABxqq/LCN+Mp4/TOmuyDPyBXfPq+tAOVmlCcYLwmko=;
        b=UT3kJ/OdQ25yEeZelrAP4l0D3NsjusKqRcRiLrXF8C3awBzRlgCEPLHKHVl5TBzQBE
         bQsph/G2EgTOsYw6qYYWerqfUIcrsHSDhkTsX6FABMPQHCpDZOiI91WBbRdkhuGOe2HV
         fH7RNerArVc6gJfBHrka0y3vsK38vjDDBGX97EUzPMhNX1igvPylPsrVtaE8JwT1Ww0P
         Bs5OkM1PlZXKdEg3ZwgLtT+QWqU4u1h/BIjnCtprPwEk3vb1frwSBrvQAB5NsKlVwUEw
         RUqtWjYOAFfnfrhZWh/s+39RI4myf+cXBTWxvAttaAaDvXKc1WdmH2r6XB2D24rRqImK
         lscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872852; x=1779477652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pABxqq/LCN+Mp4/TOmuyDPyBXfPq+tAOVmlCcYLwmko=;
        b=qyK76NqUHhH5uzaNel089Ups7rsQx3bnWHzWgeHfrfr/DulR8iBsXevebiYQLodqsK
         CdPju+c738dGN/eAjuFZcfXEsejnj5KEhqrwdlhGgk4P+EyQzKHGhOtLrp3FvncvBenK
         s8yeVnwGr6D8LPn3cZuQWB8FGq16qF8hEUFc6o7FKhHszbgnlQktdCHTQzaGYxq//vW4
         tykye4A9akSHGXZ2ODFtcmMVnruYn6Dr0bs9fVE2UwQiv3qYYYh37h6+tnzJN5eQYtcH
         arKucA1Ll8axkEejNHdxjiizM00z7ZQMEGS3zP+kk54j2HDFVYHzoWP7C42U3gvWWqZ0
         at/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/IOVVp2CjMcaCuZdVoiUNhuehSbWXlP9cyfBtWMH08tjK7eNM1gqhMneg4rRvQBFmwVb45MMT3SkzGo4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhtJoW/ALqjnEcjLQGg2aw+SuaNJ2qC7ysCqy+iPV6pKed+CMT
	t3MO0Ax1Ck+2baUOYJlLR0y6revaEtH2/7fW/Wj5ehZ5qzM+6jA/IDD2/0tPBFERszsweZhyUfL
	ObnvLHw==
X-Received: from pfblj16.prod.google.com ([2002:a05:6a00:71d0:b0:83f:22c:66ee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:801b:b0:835:51fd:b7e9
 with SMTP id d2e1a72fcca58-83f18e75ed2mr8194934b3a.20.1778872851317; Fri, 15
 May 2026 12:20:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:20 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-20-seanjc@google.com>
Subject: [PATCH v3 19/41] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
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
X-Rspamd-Queue-Id: EC0F4556C52
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
	TAGGED_FROM(0.00)[bounces-10942-lists,linux-hyperv=lfdr.de];
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

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 962b6fcb5c60..8df6adcd6cd8 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -134,20 +134,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -304,6 +290,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static __init void kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
-- 
2.54.0.563.g4f69b47b94-goog


