Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE68268A94
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgINLjI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 07:39:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54065 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgINL2T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id x23so10259568wmi.3;
        Mon, 14 Sep 2020 04:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZX/9xWeZ+zP3pP2tlhsq9nW4Y9VjDF3kLRmkcKtgjc=;
        b=moevYX85MMyp53ceQSdKdlE8LWEkB2cGS0AQAZ6rH7le/EQXNU6rTi3gcM0ES3Fgkj
         9kQ6LpW2+jqBb/DoSe0a+p0DKJSwRvXGyuTdkoImmjnZ2cBBqEsSU/0Oe98AYkFX4Y1n
         OHuX/+MGuy9KJzDRKVMpIFvvrzPxYPVCKG3JIRghlADCocq0BId1gWL/eims1Qp4jJoQ
         eWRKqmOsuodNsvSJR/jLumVydUU5TnID79TBhbJsZ55lQsy2FDzsocde6aZsuBO1HvvV
         NyULN4a2eHZXeBUoJ12T5VG/N1RNEHF9apBRt6SLr2M1CpQI2srOTRUqLK4RTylOWV9a
         QL+Q==
X-Gm-Message-State: AOAM532oALcn3EVucC0xVxIBIO3aEqzLhHgjwDAoVjjpxrShi/Jk3qxx
        p06bdweYuBxb5sJh0N9REnR8rHRva/M=
X-Google-Smtp-Source: ABdhPJy1/tqucPdAU8b/c7VL7XG75PLuqU/JAbXL0ZSZRJzZ2Ga6nYJZox2oFMQc3kNXmNo5egmXAA==
X-Received: by 2002:a1c:2ed0:: with SMTP id u199mr14123824wmu.125.1600082895923;
        Mon, 14 Sep 2020 04:28:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:15 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC v1 06/18] x86/hyperv: allocate output arg pages if required
Date:   Mon, 14 Sep 2020 11:27:50 +0000
Message-Id: <20200914112802.80611-7-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Linux runs as the root partition, it will need to make hypercalls
which return data from the hypervisor.

Allocate pages for storing results when Linux runs as the root
partition.

Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/hv_init.c       | 45 +++++++++++++++++++++++++++++----
 arch/x86/include/asm/mshyperv.h |  1 +
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index cac8e4c56261..ebba4be4185d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 void  __percpu **hyperv_pcpu_input_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 
+void  __percpu **hyperv_pcpu_output_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
+
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
@@ -75,14 +78,29 @@ static int hv_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
-	struct page *pg;
+	struct page *input_pg;
 
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
-	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
-	if (unlikely(!pg))
+	input_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+	if (unlikely(!input_pg))
 		return -ENOMEM;
-	*input_arg = page_address(pg);
+	*input_arg = page_address(input_pg);
+
+	if (hv_root_partition) {
+		struct page *output_pg;
+		void **output_arg;
+
+		output_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+		if (unlikely(!output_pg)) {
+			free_page((unsigned long)*input_arg);
+			*input_arg = NULL;
+			return -ENOMEM;
+		}
+
+		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*output_arg = page_address(output_pg);
+	}
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -209,14 +227,25 @@ static int hv_cpu_die(unsigned int cpu)
 	unsigned int new_cpu;
 	unsigned long flags;
 	void **input_arg;
-	void *input_pg = NULL;
+	void *input_pg = NULL, *output_pg = NULL;
 
 	local_irq_save(flags);
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 	input_pg = *input_arg;
 	*input_arg = NULL;
+
+	if (hv_root_partition) {
+		void **output_arg;
+
+		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		output_pg = *output_arg;
+		*output_arg = NULL;
+	}
+
 	local_irq_restore(flags);
+
 	free_page((unsigned long)input_pg);
+	free_page((unsigned long)output_pg);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
@@ -350,6 +379,12 @@ void __init hyperv_init(void)
 
 	BUG_ON(hyperv_pcpu_input_arg == NULL);
 
+	/* Allocate the per-CPU state for output arg for root */
+	if (hv_root_partition) {
+		hyperv_pcpu_output_arg = alloc_percpu(void  *);
+		BUG_ON(hyperv_pcpu_output_arg == NULL);
+	}
+
 	/* Allocate percpu VP index */
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
 				    GFP_KERNEL);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 2a2cc81beac6..f5c62140f28d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -63,6 +63,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 #if IS_ENABLED(CONFIG_HYPERV)
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
+extern void  __percpu  **hyperv_pcpu_output_arg;
 
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
-- 
2.20.1

