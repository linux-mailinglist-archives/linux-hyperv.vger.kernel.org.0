Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC05692DD
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiGFTvf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 15:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiGFTve (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 15:51:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F9D18390;
        Wed,  6 Jul 2022 12:51:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k30so12455013edk.8;
        Wed, 06 Jul 2022 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=940NON5ZiCzvUCu0CiIkGxD8PkrHui9fksTxAlvFF2Q=;
        b=WD0C7sqAbS/txx8ZqA2ZODw2GWOvOZUpy0KcNt4GEbk3hexy6PqipKnUOgnU/RQZj7
         DAPrsGVCzF2QPmv9S6BDYMgfx9Ic7s1TIWhwJSf5xBaivP9Ymlr9cWWFdW78LXCa3ZJc
         zdIU2bTW3ijEsmGqK7YeX+sgqONpDpotZUTnlmvDJ0YT4D/t1pYpKal5WjL2bp5NUxNu
         PcOP/CfQqL+bX9x27rKyKKehJ6719Bl0f7yb+57RBkEOO6GZtffD2YffmLbr9nRfGTi2
         GrbJNHqUcZNtdn52CTSFohmmQ6/2uaCCLchXKCO8IHROMUd7DXmlGifRDXi6wOjdOEog
         GtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=940NON5ZiCzvUCu0CiIkGxD8PkrHui9fksTxAlvFF2Q=;
        b=3DJdFmAAsW2RE2H2VaJxUqqJbg1dVlK+RUFOqYUWo4JNFRKH9kzdsWjLlViffYA3Si
         loL6navyHXamjcvDynDzgMZwlohgiqrdAxqKSwKKM6tfxPlFAetu/Wh9Uv0/N1xYeaHL
         JIEIPTZcSedGlPVTsL3jcKcxa3rhFKI4R/1h3+/RnNUunoG0pVukRqEJ2oV2p+dznsGD
         VhKoQSutKjL0/jEwqXWP5yH5KRO7Jkr6/3wC6uP1f3D+zyiJnqHw7jiqLEeLFwqQSHQy
         NTr1e4PQpdX/5GsyIMZvbsoeNZmks7kQzupDgDbVzKMuwlC+kpZDLtAJUBF5lSrKGCh6
         XckQ==
X-Gm-Message-State: AJIora9eYyTYWYdokytbTY/q4GfISA7XcpBrLORKydyYHwn4f4Eh8sm9
        BxsV7+Y70TJK7mxojBvvKeo=
X-Google-Smtp-Source: AGRyM1uUFyCfr9/9lM3NU3hu2Vav+/0R7nlwqn8fsfMebpuG36p/QatZHggyU+N4+LYrdP/Tmf2M8A==
X-Received: by 2002:a05:6402:4507:b0:43a:5b42:2be5 with SMTP id ez7-20020a056402450700b0043a5b422be5mr23610276edb.392.1657137090388;
        Wed, 06 Jul 2022 12:51:30 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-199-193.retail.telecomitalia.it. [79.49.199.193])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b0072af18329c4sm1968127ejc.225.2022.07.06.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:51:30 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
        x86@kernel.org, "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 1/2] swiotlb,dma-direct: Move swiotlb_unencrypted_base to direct.c
Date:   Wed,  6 Jul 2022 21:50:26 +0200
Message-Id: <20220706195027.76026-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706195027.76026-1-parri.andrea@gmail.com>
References: <20220706195027.76026-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The variable will come in handy to enable dma_direct_{alloc,free}()
for Hyper-V AMD SEV-SNP Isolated VMs.

Rename swiotlb_unencrypted_base to dma_unencrypted_base to indicate
that the notion is not restricted to SWIOTLB.

No functional change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
Yeah, this is in some sense trading the dependency on SWIOTLB for a
dependency on HAS_DMA:

Q1. I'm unable to envision a scenario where SWIOTLB without HAS_DMA
would make sense but I'm also expecting one of the kernel test bots
to try such a nonsensical configuration... should the references to
dma_unencrypted_base in swiotlb.c be protected with HAS_DMA? other?

Q2. Can the #ifdef CONFIG_HAS_DMA in arch/x86/kernel/cpu/mshyperv.c
be removed? can we make HYPERV "depends on HAS_DMA"?

...

 arch/x86/kernel/cpu/mshyperv.c |  6 +++---
 include/linux/dma-direct.h     |  2 ++
 include/linux/swiotlb.h        |  2 --
 kernel/dma/direct.c            |  8 ++++++++
 kernel/dma/swiotlb.c           | 12 +++++-------
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92a..47e9cece86ff8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -18,7 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/i8253.h>
 #include <linux/random.h>
-#include <linux/swiotlb.h>
+#include <linux/dma-direct.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -333,8 +333,8 @@ static void __init ms_hyperv_init_platform(void)
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
-#ifdef CONFIG_SWIOTLB
-			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
+#ifdef CONFIG_HAS_DMA
+			dma_unencrypted_base = ms_hyperv.shared_gpa_boundary;
 #endif
 		}
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 18aade195884d..0b7e4c4b7b34c 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -14,6 +14,8 @@
 
 extern unsigned int zone_dma_bits;
 
+extern phys_addr_t dma_unencrypted_base;
+
 /*
  * Record the mapping of CPU physical to DMA addresses for a given region.
  */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7ed35dd3de6e7..fa2e85f21af61 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -190,6 +190,4 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
 }
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
 
-extern phys_addr_t swiotlb_unencrypted_base;
-
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8d0b68a170422..06b2b901e37a3 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -22,6 +22,14 @@
  */
 unsigned int zone_dma_bits __ro_after_init = 24;
 
+/*
+ * Certain Confidential Computing solutions, such as Hyper-V AMD SEV-SNP
+ * isolated VMs, use dma_unencrypted_base as a watermark: memory addresses
+ * below dma_unencrypted_base are treated as private, while memory above
+ * dma_unencrypted_base is treated as shared.
+ */
+phys_addr_t dma_unencrypted_base;
+
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
 {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cb50f8d383606..78d4f5294a56c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -67,8 +67,6 @@ static bool swiotlb_force_disable;
 
 struct io_tlb_mem io_tlb_default_mem;
 
-phys_addr_t swiotlb_unencrypted_base;
-
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 
 static int __init
@@ -142,7 +140,7 @@ static inline unsigned long nr_slots(u64 val)
 
 /*
  * Remap swioltb memory in the unencrypted physical address space
- * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
+ * when dma_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
  * Isolation VMs).
  */
 #ifdef CONFIG_HAS_IOMEM
@@ -150,8 +148,8 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 {
 	void *vaddr = NULL;
 
-	if (swiotlb_unencrypted_base) {
-		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
+	if (dma_unencrypted_base) {
+		phys_addr_t paddr = mem->start + dma_unencrypted_base;
 
 		vaddr = memremap(paddr, bytes, MEMREMAP_WB);
 		if (!vaddr)
@@ -213,10 +211,10 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	}
 
 	/*
-	 * If swiotlb_unencrypted_base is set, the bounce buffer memory will
+	 * If dma_unencrypted_base is set, the bounce buffer memory will
 	 * be remapped and cleared in swiotlb_update_mem_attributes.
 	 */
-	if (swiotlb_unencrypted_base)
+	if (dma_unencrypted_base)
 		return;
 
 	memset(vaddr, 0, bytes);
-- 
2.25.1

