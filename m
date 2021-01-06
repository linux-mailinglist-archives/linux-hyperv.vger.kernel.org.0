Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28AF2EC518
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAFUf0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:35:26 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41032 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbhAFUel (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:41 -0500
Received: by mail-wr1-f48.google.com with SMTP id a12so3558894wrv.8;
        Wed, 06 Jan 2021 12:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1AnwUhpK3uc/E6NKbzj7KMKk+WsZG+5G79p8q0Z4Cfs=;
        b=VGn0V09AYY+isMLJ80Xep8RrWG63uF5by/9kKQ0r5DtutnW9mCoPpCUgp1ErYbYB2+
         kRLlR5XxcFTivNcBoTa1JDZNfR0HRbar4O7fn2+ozdurqI2bt1vaMirQHQyGb0EHTY3T
         Ve3udtUiSvRkJgURL/L5+SJWiy/yKuNSwUfPdeswoMiIENb58meSdFjk+lKl5uOWNWCb
         gATCd7Zmsvok1l2k04OkSLzp6X3B0bBTVVq0dH4Vag6aO7gdq/nr1uYIhdzhgqoYnka6
         eGKTTm+3bjZpldgWf2AhO6TO1c7GNHavBK1tJ4HEBj0/PXJhzMgVDXh7Sz5GO4tvobT8
         SC9w==
X-Gm-Message-State: AOAM531cwbDdgPRzFkfLflmGiiH00XfIXPgsv3ccRO+Cx0Von8NYtZZy
        4h2WPbJs4zig9kpnJ6ec75TIE3MJV3k=
X-Google-Smtp-Source: ABdhPJxcj4j7q3D1uw1BItVBtjE3jcUeZmlRBt9fH63g+heQnD2bm9tg3hTrRGxeMFhlOGfjxExzqw==
X-Received: by 2002:adf:dc87:: with SMTP id r7mr5901521wrj.305.1609965239043;
        Wed, 06 Jan 2021 12:33:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:33:58 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 06/17] x86/hyperv: allocate output arg pages if required
Date:   Wed,  6 Jan 2021 20:33:39 +0000
Message-Id: <20210106203350.14568-7-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
v3: Fix hv_cpu_die to use free_pages.
v2: Address Vitaly's comments
---
 arch/x86/hyperv/hv_init.c       | 35 ++++++++++++++++++++++++++++-----
 arch/x86/include/asm/mshyperv.h |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e04d90af4c27..6f4cb40e53fe 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -41,6 +41,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 void  __percpu **hyperv_pcpu_input_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 
+void  __percpu **hyperv_pcpu_output_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
+
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
@@ -73,12 +76,19 @@ static int hv_cpu_init(unsigned int cpu)
 	void **input_arg;
 	struct page *pg;
 
-	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
-	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
 	if (unlikely(!pg))
 		return -ENOMEM;
+
+	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 	*input_arg = page_address(pg);
+	if (hv_root_partition) {
+		void **output_arg;
+
+		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*output_arg = page_address(pg + 1);
+	}
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -205,14 +215,23 @@ static int hv_cpu_die(unsigned int cpu)
 	unsigned int new_cpu;
 	unsigned long flags;
 	void **input_arg;
-	void *input_pg = NULL;
+	void *pg;
 
 	local_irq_save(flags);
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	input_pg = *input_arg;
+	pg = *input_arg;
 	*input_arg = NULL;
+
+	if (hv_root_partition) {
+		void **output_arg;
+
+		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*output_arg = NULL;
+	}
+
 	local_irq_restore(flags);
-	free_page((unsigned long)input_pg);
+
+	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
@@ -346,6 +365,12 @@ void __init hyperv_init(void)
 
 	BUG_ON(hyperv_pcpu_input_arg == NULL);
 
+	/* Allocate the per-CPU state for output arg for root */
+	if (hv_root_partition) {
+		hyperv_pcpu_output_arg = alloc_percpu(void *);
+		BUG_ON(hyperv_pcpu_output_arg == NULL);
+	}
+
 	/* Allocate percpu VP index */
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
 				    GFP_KERNEL);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ac2b0d110f03..62d9390f1ddf 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -76,6 +76,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 #if IS_ENABLED(CONFIG_HYPERV)
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
+extern void  __percpu  **hyperv_pcpu_output_arg;
 
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
-- 
2.20.1

