Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554713C2316
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhGILqf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:35 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:56176 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhGILqe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:34 -0400
Received: by mail-wm1-f47.google.com with SMTP id j34so6125112wms.5;
        Fri, 09 Jul 2021 04:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6Fu2Yt38r79jvQRn5HVAAOYCNYVH5pxX3ZmV1lqXNs=;
        b=WAObDDkAogK8oOE1xNvU1kKfjZ2wpzzm/uhEE0aXPIxvTichSBkr+xaf7EtmUafOA7
         p6KAg2TtJNbfP/AjOuXTrb/tkaRhJyUmspnOXShkpUS2SW52TujrduIhQ7qDNPkZa+mr
         NzcGt+qYD7nwrG3Fj6qlrcspEFMwhsOgyNvU4UM7q/pvJt+NsOB8w2wyKOVtmhDL/ZKi
         ZtunBGs/TVezcXRSAuvcg7wlCTANdvLl0IhpZT8qL7U82VLnb3pWe6bNUkRZLW6bQJ2a
         /1HXlJRAb76nCj7qmWrDVUPP5bu1CHngGXjm6BcRA/ogroIDmiIwxUDJ9XWGT2Z+FTTD
         DqgA==
X-Gm-Message-State: AOAM533KrjaVauLLLiWaa2C+Ip7UoTFZ6XfYjZ7uHc3SdSOpdUiIYQEU
        mWpiMMoQRNYxBnofguwng9HY8GlnSNw=
X-Google-Smtp-Source: ABdhPJxD+GhXob854wyMk3JbdK4brmN177VhO/jZd11t0KFNcb7l7nzKryHBkM0YiTVPFMJAKUpekw==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr11598095wmq.153.1625831028683;
        Fri, 09 Jul 2021 04:43:48 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:48 -0700 (PDT)
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
        iommu@lists.linux-foundation.org (open list:INTEL IOMMU (VT-d))
Subject: [RFC v1 4/8] intel/vt-d: export intel_iommu_get_resv_regions
Date:   Fri,  9 Jul 2021 11:43:35 +0000
Message-Id: <20210709114339.3467637-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Microsoft Hypervisor runs on Intel platforms it needs to know the
reserved regions to program devices correctly. There is no reason to
duplicate intel_iommu_get_resv_regions. Export it.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/iommu/intel/iommu.c | 5 +++--
 include/linux/intel-iommu.h | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a4294d310b93..01973bc20080 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5176,8 +5176,8 @@ static void intel_iommu_probe_finalize(struct device *dev)
 		set_dma_ops(dev, NULL);
 }
 
-static void intel_iommu_get_resv_regions(struct device *device,
-					 struct list_head *head)
+void intel_iommu_get_resv_regions(struct device *device,
+				 struct list_head *head)
 {
 	int prot = DMA_PTE_READ | DMA_PTE_WRITE;
 	struct iommu_resv_region *reg;
@@ -5232,6 +5232,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 		return;
 	list_add_tail(&reg->list, head);
 }
+EXPORT_SYMBOL_GPL(intel_iommu_get_resv_regions);
 
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 03faf20a6817..f91869f765bc 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -814,6 +814,8 @@ extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
 extern int intel_iommu_gfx_mapped;
+extern void intel_iommu_get_resv_regions(struct device *device,
+				 struct list_head *head);
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -825,6 +827,8 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 }
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
+static inline void intel_iommu_get_resv_regions(struct device *device,
+				 struct list_head *head) {}
 #endif
 
 #endif
-- 
2.30.2

