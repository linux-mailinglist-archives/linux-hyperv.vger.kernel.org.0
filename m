Return-Path: <linux-hyperv+bounces-10940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFgmE71zB2r03wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10940-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:27:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865D556CE4
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E128F304592E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C03E1228;
	Fri, 15 May 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/N4q977"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBD3E171D
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872851; cv=none; b=a7bk1YYAhH0tmitgvV+KhhqkRZ1g9Za9c5HJCO2nTpRHa4Lomdh24RaWGDYI58wBRM3j12Bya7LyLTDjebaZO+zvCY0/RAL2+0sr4YivUNS8yYR96i0CQTM1c/ceJv6Xw3AOlEpCodzu0vKNw4E65lLdllhUPHoLMa2/4wnqoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872851; c=relaxed/simple;
	bh=VGy+qLRWGOmAxsBGFeiFDyGswDSrJi4JQ5o9B+Fv8MU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q5d+yKPQ0YT/t73ZZQ4BnRR3j6CW3PJrFxY0MMJYSfqCCVTP3FIWAwILIUNd5EspPouO985g66NySsRYX2WxX6tJzkO1aMAugv3WAPitSR65+z+ZcmnHgbrgq9Fysr6rw2qSz/4PCSFDWMI++nc6OheDktcEoM913dXilAYlANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/N4q977; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8294d8c48eso84298a12.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872849; x=1779477649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HUz/DYTZsMDp3XmDdx4uAZCV01b5NalrmHfGrDrQY4I=;
        b=X/N4q977l45ITMvll/o0+19guoFFUzxLB98uebW0VHaX5g1ESYoQcY1gm4J7J68uAK
         eNANpepCp+hfuEVQFDB0cK+WZnMxyypsOWfHpikWrR/1W1liCKDNCCt3VvI94ry6sL+N
         ZMmVfe3GB71WPKZZWlTfkYQoUhqgnt2CYGK7OSuZu4aYLbVgckPVRutwiZ1vLajkusK4
         abciy5J/7KTbhz0j1cnW+Q8p9ZTK2bqSwBNx+GzIrAK/owHrOROSMOFC/YEgF49E27+k
         luy9LifUxLCS6088HLQLTSzDs/A6J97LYu9WSpHihGiARsHfhmkLtWCOpwDw8oS8YnVP
         FM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872849; x=1779477649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUz/DYTZsMDp3XmDdx4uAZCV01b5NalrmHfGrDrQY4I=;
        b=R8eaKJNVK9n+9/4/mIkVMsWvBadKOHRstEY5JJaCvVpJdQK9eaSCSmvN0TtgKK/crq
         1DlDYmKfmgKXE+4RsPlJ+E8rBz65tj4v6UQDeCtqO+7mzSAOjkpSUQuE1RuengMSKHTo
         wuDp36frUn+GXFedtAi4JTZsq0V+/KvOsPjrQwkRPlrxW7dYdZgbBGqTe4myyvUSQGTG
         6LzJjQt40ue+AAWE4ZaJa8RvrDODWrco0u4sieu4pgtpJ+VpP+ylhdYh/ltDrp7rFux4
         2Sz29lGeCLGoORXlEihx5punCdKrgFMNCxiP09iwwL14FwoEEIW72BCwwWs/pZTvNQ7P
         ZyPg==
X-Forwarded-Encrypted: i=1; AFNElJ/gh4Tmb3ZcA0ZLSDbMj99xcVL9zXs9KEKjKmTFCN0PNMrfZWrI9z43UjneVkxfmiQKlSS28zbLexV4xg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLj0DEcRBuVVXs0J6u1EVcuaXPTsBb+XIHYMhEdIMfoB7IgSA
	ek8g/GfVj0EdHfylV96PhpkoUU0oBb1n5/J/K53E00Klj+ZXTFMiEKVSBMgEqnJvUmk8K+O0w7Z
	Pkpl5Nw==
X-Received: from pfmm20.prod.google.com ([2002:a05:6a00:2494:b0:835:43a4:4aaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca2:b0:83d:b11f:7979
 with SMTP id d2e1a72fcca58-83f33c60deemr6247193b3a.29.1778872849160; Fri, 15
 May 2026 12:20:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:18 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-18-seanjc@google.com>
Subject: [PATCH v3 17/41] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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
X-Rspamd-Queue-Id: 7865D556CE4
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10940-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 567d30b30a5a..b14c4ada89a3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -984,9 +984,17 @@ EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
 
 static unsigned long long cyc2ns_suspend;
 
+static __always_inline bool tsc_is_save_restore_needed(void)
+{
+	if (WARN_ON_ONCE(!using_native_sched_clock()))
+		return false;
+
+	return static_branch_likely(&__use_tsc) || sched_clock_stable();
+}
+
 void tsc_save_sched_clock_state(void)
 {
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -1006,7 +1014,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	local_irq_save(flags);
-- 
2.54.0.563.g4f69b47b94-goog


