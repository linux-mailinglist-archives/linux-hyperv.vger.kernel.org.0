Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DC3C2317
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhGILqf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhGILqd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76273C0613E6;
        Fri,  9 Jul 2021 04:43:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so24966483wmq.1;
        Fri, 09 Jul 2021 04:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLOJW7d88vrY9GmA9ucvUaUUVOlvzPYC8Oyh2a0Sb1s=;
        b=X2QTLcESCIwC+NZF/PmkMcgrVcV0hAEFbViTcWh/FjZQdeuODsYVC1Ws5lvesbA+jN
         e8DD5/d1lVLz2LvBslpa85oTCn4/UgmDWUXoSaPDnw7dPGeHgIiL+KwdLoYHd+q35oWX
         6TQ5tY4rvKDLOskw1bh6rbCYvbx3o++ay06trQDOw9xtlghmGLxKSQKYr0I25bdGMiYN
         +/TdTsLppRdTBuBefuyKrolQfdtGtu6rdfctjeEKNzcq+BuAYclRhbHoo1phcIQ8Z3y/
         AXNlueogo9QY5FlnrbV9fNMoZJHthuVesLFIzJsL3jsrBXUF9Lj4x0jOxhNqAiQFj2Gk
         EGFQ==
X-Gm-Message-State: AOAM533BOZZ58O0SD3KvluMhbsTJC61z1HhkfZgjvds+ZgbZvRIA277D
        cXihqINbl+hWJ1dYusNwp7w5Na1moZU=
X-Google-Smtp-Source: ABdhPJyoOzdW1/ocaitVPdNhN15vIaawhkBqprEc88D3z21sdADkciIP1zBasQCgJY0b30+cUdo/Wg==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr38602838wmp.11.1625831027824;
        Fri, 09 Jul 2021 04:43:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:47 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Wei Liu <wei.liu@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Yian Chen <yian.chen@intel.com>,
        iommu@lists.linux-foundation.org (open list:INTEL IOMMU (VT-d))
Subject: [RFC v1 3/8] intel/vt-d: make DMAR table parsing code more flexible
Date:   Fri,  9 Jul 2021 11:43:34 +0000
Message-Id: <20210709114339.3467637-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Microsoft Hypervisor provides a set of hypercalls to manage device
domains. The root kernel should parse the DMAR so that it can program
the IOMMU (with hypercalls) correctly.

The DMAR code was designed to work with Intel IOMMU only. Add two more
parameters to make it useful to Microsoft Hypervisor. Microsoft
Hypervisor does not need the DMAR parsing code to allocate an Intel
IOMMU structure; it also wishes to always reparse the DMAR table even
after it has been parsed before.

Adjust Intel IOMMU code to use the new dmar_table_init. There should be
no functional change to Intel IOMMU code.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
We may be able to combine alloc and force_parse?
---
 drivers/iommu/intel/dmar.c          | 38 ++++++++++++++++++++---------
 drivers/iommu/intel/iommu.c         |  2 +-
 drivers/iommu/intel/irq_remapping.c |  2 +-
 include/linux/dmar.h                |  2 +-
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 84057cb9596c..bd72f47c728b 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -408,7 +408,8 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
  * structure which uniquely represent one DMA remapping hardware unit
  * present in the platform
  */
-static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
+static int dmar_parse_one_drhd_internal(struct acpi_dmar_header *header,
+		void *arg, bool alloc)
 {
 	struct acpi_dmar_hardware_unit *drhd;
 	struct dmar_drhd_unit *dmaru;
@@ -440,12 +441,14 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 		return -ENOMEM;
 	}
 
-	ret = alloc_iommu(dmaru);
-	if (ret) {
-		dmar_free_dev_scope(&dmaru->devices,
-				    &dmaru->devices_cnt);
-		kfree(dmaru);
-		return ret;
+	if (alloc) {
+		ret = alloc_iommu(dmaru);
+		if (ret) {
+			dmar_free_dev_scope(&dmaru->devices,
+					    &dmaru->devices_cnt);
+			kfree(dmaru);
+			return ret;
+		}
 	}
 	dmar_register_drhd_unit(dmaru);
 
@@ -456,6 +459,16 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	return 0;
 }
 
+static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
+{
+	return dmar_parse_one_drhd_internal(header, arg, true);
+}
+
+int dmar_parse_one_drhd_noalloc(struct acpi_dmar_header *header, void *arg)
+{
+	return dmar_parse_one_drhd_internal(header, arg, false);
+}
+
 static void dmar_free_drhd(struct dmar_drhd_unit *dmaru)
 {
 	if (dmaru->devices && dmaru->devices_cnt)
@@ -633,7 +646,7 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
  * parse_dmar_table - parses the DMA reporting table
  */
 static int __init
-parse_dmar_table(void)
+parse_dmar_table(bool alloc)
 {
 	struct acpi_table_dmar *dmar;
 	int drhd_count = 0;
@@ -650,6 +663,9 @@ parse_dmar_table(void)
 		.cb[ACPI_DMAR_TYPE_SATC] = &dmar_parse_one_satc,
 	};
 
+	if (!alloc)
+		cb.cb[ACPI_DMAR_TYPE_HARDWARE_UNIT] = &dmar_parse_one_drhd_noalloc;
+
 	/*
 	 * Do it again, earlier dmar_tbl mapping could be mapped with
 	 * fixed map.
@@ -840,13 +856,13 @@ void __init dmar_register_bus_notifier(void)
 }
 
 
-int __init dmar_table_init(void)
+int __init dmar_table_init(bool alloc, bool force_parse)
 {
 	static int dmar_table_initialized;
 	int ret;
 
-	if (dmar_table_initialized == 0) {
-		ret = parse_dmar_table();
+	if (dmar_table_initialized == 0 || force_parse) {
+		ret = parse_dmar_table(alloc);
 		if (ret < 0) {
 			if (ret != -ENODEV)
 				pr_info("Parse DMAR table failure.\n");
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..a4294d310b93 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4310,7 +4310,7 @@ int __init intel_iommu_init(void)
 	}
 
 	down_write(&dmar_global_lock);
-	if (dmar_table_init()) {
+	if (dmar_table_init(true, false)) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR table\n");
 		goto out_free_dmar;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index f912fe45bea2..0e8abef862e4 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -732,7 +732,7 @@ static int __init intel_prepare_irq_remapping(void)
 		return -ENODEV;
 	}
 
-	if (dmar_table_init() < 0)
+	if (dmar_table_init(true, false) < 0)
 		return -ENODEV;
 
 	if (intel_cap_audit(CAP_AUDIT_STATIC_IRQR, NULL))
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e04436a7ff27..f88535d41a6e 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -106,7 +106,7 @@ static inline bool dmar_rcu_check(void)
 	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
 		if (!(tmp)) { continue; } else
 
-extern int dmar_table_init(void);
+extern int dmar_table_init(bool alloc, bool force_parse);
 extern int dmar_dev_scope_init(void);
 extern void dmar_register_bus_notifier(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
-- 
2.30.2

