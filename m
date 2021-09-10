Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0AC407187
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Sep 2021 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhIJS6i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Sep 2021 14:58:38 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:41855 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJS6b (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Sep 2021 14:58:31 -0400
Received: by mail-wm1-f54.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so2054540wmq.0;
        Fri, 10 Sep 2021 11:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13EDgotJZ+G06ORiWEpef1AccnsPNuViikUMH2ucpYI=;
        b=NWxY21BCQedoj1DTknmeqO4nx/eoBRMdmNE6dwiKS3SNlNHtfKcDNLflrR8u1+1Uqa
         DGark6sPB7FeIFs7/QoWsd4KfodzXN6MC4b3FgN3DnbPFTL/effxty9lcT4m8MaQtAjb
         eOkc6oHj3+20/v2Oy4s9khRJcSmwPx20z9I6dlr8B7xydQZO01Ygw++0yWuFouztLVUL
         kgzV8Te50nniFMpw7IqTQKnnrFl4EJgmTmG0f9IKT4jxtKKedtMu6VRZepP/M5UQTrPg
         mEQi+W9XTz770SyjpPsuS6SLALMDBqZkwtcPwyp9NEQMHEJ1AhEiktn35KntQBKOfOYw
         eq2g==
X-Gm-Message-State: AOAM530VzCZRNA2FhDvEGnqg0+PLsXQIzetVm+9Bw4/KpelC+rJuj7iG
        1j6F29lVi99TdinLfWzZtzqcBKaUnis=
X-Google-Smtp-Source: ABdhPJw57slBfic7WbKKqf8UnXEcz1SwjB98725fe4ScvL8LAdWM/jtezySQIF8KoYMlaFlgG5Xayg==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr9103269wme.84.1631300238959;
        Fri, 10 Sep 2021 11:57:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y4sm5015351wmi.22.2021.09.10.11.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:57:18 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v2 2/2] x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself
Date:   Fri, 10 Sep 2021 18:57:14 +0000
Message-Id: <20210910185714.299411-3-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910185714.299411-1-wei.liu@kernel.org>
References: <20210910185714.299411-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

It is not a good practice to allocate a cpumask on stack, given it may
consume up to 1 kilobytes of stack space if the kernel is configured to
have 8192 cpus.

The internal helper functions __send_ipi_mask{,_ex} need to loop over
the provided mask anyway, so it is not too difficult to skip `self'
there. We can thus do away with the on-stack cpumask in
hv_send_ipi_mask_allbutself.

Adjust call sites of __send_ipi_mask as needed.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Michael Kelley <mikelley@microsoft.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 68bb7bfb7985d ("X86/Hyper-V: Enable IPI enlightenments")
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---

v2: more robust check in __send_ipi_mask
---
 arch/x86/hyperv/hv_apic.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 90e682a92820..48aefcea724b 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -99,7 +99,8 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
 /*
  * IPI implementation on Hyper-V.
  */
-static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
+static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
+		bool exclude_self)
 {
 	struct hv_send_ipi_ex **arg;
 	struct hv_send_ipi_ex *ipi_arg;
@@ -123,7 +124,10 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 
 	if (!cpumask_equal(mask, cpu_present_mask)) {
 		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
+		if (exclude_self)
+			nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
+		else
+			nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
 	}
 	if (nr_bank < 0)
 		goto ipi_mask_ex_done;
@@ -138,15 +142,25 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 	return hv_result_success(status);
 }
 
-static bool __send_ipi_mask(const struct cpumask *mask, int vector)
+static bool __send_ipi_mask(const struct cpumask *mask, int vector,
+		bool exclude_self)
 {
-	int cur_cpu, vcpu;
+	int cur_cpu, vcpu, this_cpu = smp_processor_id();
 	struct hv_send_ipi ipi_arg;
 	u64 status;
+	unsigned int weight;
 
 	trace_hyperv_send_ipi_mask(mask, vector);
 
-	if (cpumask_empty(mask))
+	weight = cpumask_weight(mask);
+
+	/*
+	 * Do nothing if
+	 *   1. the mask is empty
+	 *   2. the mask only contains self when exclude_self is true
+	 */
+	if (weight == 0 ||
+	    (exclude_self && weight == 1 && cpumask_first(mask) == this_cpu))
 		return true;
 
 	if (!hv_hypercall_pg)
@@ -172,6 +186,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	ipi_arg.cpu_mask = 0;
 
 	for_each_cpu(cur_cpu, mask) {
+		if (exclude_self && cur_cpu == this_cpu)
+			continue;
 		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
 		if (vcpu == VP_INVAL)
 			return false;
@@ -191,7 +207,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	return hv_result_success(status);
 
 do_ex_hypercall:
-	return __send_ipi_mask_ex(mask, vector);
+	return __send_ipi_mask_ex(mask, vector, exclude_self);
 }
 
 static bool __send_ipi_one(int cpu, int vector)
@@ -208,7 +224,7 @@ static bool __send_ipi_one(int cpu, int vector)
 		return false;
 
 	if (vp >= 64)
-		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
+		return __send_ipi_mask_ex(cpumask_of(cpu), vector, false);
 
 	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
 	return hv_result_success(status);
@@ -222,20 +238,13 @@ static void hv_send_ipi(int cpu, int vector)
 
 static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
 {
-	if (!__send_ipi_mask(mask, vector))
+	if (!__send_ipi_mask(mask, vector, false))
 		orig_apic.send_IPI_mask(mask, vector);
 }
 
 static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
 {
-	unsigned int this_cpu = smp_processor_id();
-	struct cpumask new_mask;
-	const struct cpumask *local_mask;
-
-	cpumask_copy(&new_mask, mask);
-	cpumask_clear_cpu(this_cpu, &new_mask);
-	local_mask = &new_mask;
-	if (!__send_ipi_mask(local_mask, vector))
+	if (!__send_ipi_mask(mask, vector, true))
 		orig_apic.send_IPI_mask_allbutself(mask, vector);
 }
 
@@ -246,7 +255,7 @@ static void hv_send_ipi_allbutself(int vector)
 
 static void hv_send_ipi_all(int vector)
 {
-	if (!__send_ipi_mask(cpu_online_mask, vector))
+	if (!__send_ipi_mask(cpu_online_mask, vector, false))
 		orig_apic.send_IPI_all(vector);
 }
 
-- 
2.30.2

