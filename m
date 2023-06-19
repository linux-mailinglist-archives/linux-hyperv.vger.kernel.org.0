Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D32736033
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFSXnh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 19:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFSXng (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 19:43:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888CB134;
        Mon, 19 Jun 2023 16:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687218215; x=1718754215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bFAmHT8B0DUdACwd5EopvbtZl1G4nAgQL+houxurEK4=;
  b=O9b8/n/JAn+2Wa9X0gGZgsPhb59KbUtkzb7YSxcO+2Nynl5509kORQlm
   s6xd29ljG/PCIKDkKMcL9/Laxpl8Q/ArD5ifGZoh253t+JC6gS8GJV4er
   NN3mmQscAJDIh9gTD8P589p/CNbQ/rRXYMmVFQKhNxxy/FbOkSdHcAzZr
   IfKwKuxpi8KNIZ0w6pXD80td4VF6RKuD9skimTFQzAJH43pvnGD8agwzX
   OvFhhcGTQsgJIFzOkEOAylcAAHQzPx7Xin/NyFYVm9+vNJZSZY278n/2z
   /Vq42JGnVT17XZNrVfw0oHv2Nyol5ltk+OF27diUqnI9xrFhGZ5ruc6a9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="340071454"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="340071454"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 16:43:35 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="747789686"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="747789686"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2023 16:43:33 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, steve.wahl@hpe.com,
        mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, xin3.li@intel.com, seanjc@google.com,
        jiangshanlai@gmail.com, jgg@ziepe.ca, yangtiezhu@loongson.cn
Subject: [PATCH 1/3] x86/vector: Rename send_cleanup_vector() to vector_schedule_cleanup()
Date:   Mon, 19 Jun 2023 16:16:09 -0700
Message-Id: <20230619231611.2230-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619231611.2230-1-xin3.li@intel.com>
References: <20230619231611.2230-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Rename send_cleanup_vector() to vector_schedule_cleanup() for the next
patch to replace vector cleanup IPI with a timer callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/hw_irq.h       | 4 ++--
 arch/x86/kernel/apic/vector.c       | 8 ++++----
 arch/x86/platform/uv/uv_irq.c       | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 drivers/iommu/hyperv-iommu.c        | 4 ++--
 drivers/iommu/intel/irq_remapping.c | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece58151..551829884734 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -97,10 +97,10 @@ extern struct irq_cfg *irqd_cfg(struct irq_data *irq_data);
 extern void lock_vector_lock(void);
 extern void unlock_vector_lock(void);
 #ifdef CONFIG_SMP
-extern void send_cleanup_vector(struct irq_cfg *);
+extern void vector_schedule_cleanup(struct irq_cfg *);
 extern void irq_complete_move(struct irq_cfg *cfg);
 #else
-static inline void send_cleanup_vector(struct irq_cfg *c) { }
+static inline void vector_schedule_cleanup(struct irq_cfg *c) { }
 static inline void irq_complete_move(struct irq_cfg *c) { }
 #endif
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index c1efebd27e6c..aa370bd0d933 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -967,7 +967,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
 	raw_spin_unlock(&vector_lock);
 }
 
-static void __send_cleanup_vector(struct apic_chip_data *apicd)
+static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 {
 	unsigned int cpu;
 
@@ -983,13 +983,13 @@ static void __send_cleanup_vector(struct apic_chip_data *apicd)
 	raw_spin_unlock(&vector_lock);
 }
 
-void send_cleanup_vector(struct irq_cfg *cfg)
+void vector_schedule_cleanup(struct irq_cfg *cfg)
 {
 	struct apic_chip_data *apicd;
 
 	apicd = container_of(cfg, struct apic_chip_data, hw_irq_cfg);
 	if (apicd->move_in_progress)
-		__send_cleanup_vector(apicd);
+		__vector_schedule_cleanup(apicd);
 }
 
 void irq_complete_move(struct irq_cfg *cfg)
@@ -1007,7 +1007,7 @@ void irq_complete_move(struct irq_cfg *cfg)
 	 * on the same CPU.
 	 */
 	if (apicd->cpu == smp_processor_id())
-		__send_cleanup_vector(apicd);
+		__vector_schedule_cleanup(apicd);
 }
 
 /*
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index ee21d6a36a80..4221259a5870 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -58,7 +58,7 @@ uv_set_irq_affinity(struct irq_data *data, const struct cpumask *mask,
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0) {
 		uv_program_mmr(cfg, data->chip_data);
-		send_cleanup_vector(cfg);
+		vector_schedule_cleanup(cfg);
 	}
 
 	return ret;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..b5900e70de60 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3658,7 +3658,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
 	 */
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8302db7f783e..8a5c17b97310 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -51,7 +51,7 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return 0;
 }
@@ -257,7 +257,7 @@ static int hyperv_root_ir_set_affinity(struct irq_data *data,
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a1b987335b31..55d899f5a14b 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1180,7 +1180,7 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
 	 */
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
-- 
2.34.1

