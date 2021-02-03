Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3230DDD3
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 16:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhBCPP2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 10:15:28 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52550 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhBCPFY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:24 -0500
Received: by mail-wm1-f50.google.com with SMTP id l12so4794469wmq.2;
        Wed, 03 Feb 2021 07:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1AnwUhpK3uc/E6NKbzj7KMKk+WsZG+5G79p8q0Z4Cfs=;
        b=pUGilZj2/zyqK+LuasZGj2vvbUKN6bTA40w6cLRx7KQmhlfBoi9pFycO6aBzmbrS1u
         pupS15/l35qy9CAxWIvkxlcL4ZvCUzrDefwYz6yq0+WGL7y68RuDYInyJwza0VPwZaSW
         Y2J2jpPxzFr0DNyDyaeMLpCO2MmLj5LaUkVroxa/B7l6+vf8p/lxFQhwdcr64+0JFAN8
         EZbvuhVNiIN2QT/FsOQW5oXM15bsPFHXMRE6+wB4JWcPxEcdqQLi1TvMXRM/dbL2wRZ5
         LwkYUBHtZSEwqyaUq6lIoyqO8n9iWXT59lCy3DuEREMaKMA08UmDZLlSh4DnMAE09Azm
         qAcQ==
X-Gm-Message-State: AOAM531Px1PXdYX7DpzerVtOb3fSwNxws47Q6UOUkwk1evf5J/WLBqJn
        Yc4O9vx+1Ah8lMGAk+cte+HERHJQ+eI=
X-Google-Smtp-Source: ABdhPJzPr+NQUL59Rga5aoJly1Lsz5oBnK2ydrT0Z4XYAg2AfczfjevxVKxe2tQeJ48jPS7kVRLNlQ==
X-Received: by 2002:a05:600c:19c7:: with SMTP id u7mr3184131wmq.122.1612364682570;
        Wed, 03 Feb 2021 07:04:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:42 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 05/16] x86/hyperv: allocate output arg pages if required
Date:   Wed,  3 Feb 2021 15:04:24 +0000
Message-Id: <20210203150435.27941-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
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

