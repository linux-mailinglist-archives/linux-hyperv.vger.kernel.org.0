Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E4C49CF47
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jan 2022 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiAZQLK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jan 2022 11:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiAZQLJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jan 2022 11:11:09 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4BC06173B;
        Wed, 26 Jan 2022 08:11:09 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c9so22893186plg.11;
        Wed, 26 Jan 2022 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ta2SflzlSXZZG8agKmpqIan4ZtbVoLMRMWQ8kDRos4Q=;
        b=KeTOxz6XqpTxc5dxaggxM629yBwQmVvQtgZId5U3UBgFvxPZ1ZxVX3GxKeUXUI1Wi7
         EQIxOZWEIBPDSzQcP3hXhOMCMQShm8FgF8vB/HXaqBetpVczrQstxEArvqIiQhxBCSDW
         MD4qvF5aqOWzT4oKWrOczZDWWBN8hRuJR9GRoKHkY7+pFYLB219BN4UlYsabbWQdc9Ug
         fiwC8K4Jwpn/la3wxxYK31i2FMVZYoCVJz1kuLN63NneBXwOqih0oWLsUpabFRSP3FDI
         2aKOEHL1jVnbzT1ivcb/z03ukEf6aySCPoT5McHBc+esL6LsPW5HrJQWjVNsgVNc6Eoe
         L1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ta2SflzlSXZZG8agKmpqIan4ZtbVoLMRMWQ8kDRos4Q=;
        b=RVI+DU6pBqZ7AFbJRzIdY3VO5I3Dj2mB8SY1t3EEAfgHQ5pY/Ke/rD0MyXLk13vsF3
         0T9n1/7ScSsPP8kI6FZy9EAIsyzyZKhrXzlxXc0EHySPJ5yfkDCvUkmhz9oavMe46u3E
         OWDnG9caMucfFN4gioSOvBO1cKmUJtnEeLD2G4l/Hq9FGnK7K3NfNuZFTb+KPEB9o494
         Hcx2KDbUdPf5dPaYWpj+VLIj4AA493DPqwUwIIeFb5SiBoCtqke6WD0MucFLrTKtyp9o
         0oTMn/gd1hWkVxQ6svSrCpMN31xqyeMZ84wojpLxwBzygoNMcGlx/s+wxjB5+7MJNbOa
         0c/Q==
X-Gm-Message-State: AOAM531+m8soPF2xdVeU8ZJPHoVYyYZF8Kw/hPGaPFcmRIQCgd0Ch8SD
        DKBcKTbyynu6wKiD3WdlAYA=
X-Google-Smtp-Source: ABdhPJwIbquMo7YSPPxjfHKPIZFQxYpXbnBLF+REfbW0ZfxMXD0gp/Fw16HdEMsqrqPNDYDncCY6Rw==
X-Received: by 2002:a17:90a:1950:: with SMTP id 16mr9541121pjh.28.1643213469337;
        Wed, 26 Jan 2022 08:11:09 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:35:cf50:7507:71bb:9b04])
        by smtp.gmail.com with ESMTPSA id b9sm2555534pfm.154.2022.01.26.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:11:09 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, hch@infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
Subject: [PATCH 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Date:   Wed, 26 Jan 2022 11:10:52 -0500
Message-Id: <20220126161053.297386-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126161053.297386-1-ltykernel@gmail.com>
References: <20220126161053.297386-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V Isolation VM and AMD SEV VM uses swiotlb bounce buffer to
share memory with hypervisor. Current swiotlb bounce buffer is only
allocated from 0 to ARCH_LOW_ADDRESS_LIMIT which is default to
0xffffffffUL. Isolation VM and AMD SEV VM needs 1G bounce buffer at most.
This will fail when there is not enough contiguous memory from 0 to 4G
address space and devices also may use memory above 4G address space as
DMA memory. Expose swiotlb_alloc_from_low_pages and platform mey set it
to false when it's not necessary to limit bounce buffer from 0 to 4G memory.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  1 +
 kernel/dma/swiotlb.c    | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f6c3638255d5..55c178e8eee0 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -191,5 +191,6 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
 
 extern phys_addr_t swiotlb_unencrypted_base;
+extern bool swiotlb_alloc_from_low_pages;
 
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..159fef80f3db 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -73,6 +73,12 @@ enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem io_tlb_default_mem;
 
+/*
+ * Get IO TLB memory from the low pages if swiotlb_alloc_from_low_pages
+ * is set.
+ */
+bool swiotlb_alloc_from_low_pages = true;
+
 phys_addr_t swiotlb_unencrypted_base;
 
 /*
@@ -284,8 +290,11 @@ swiotlb_init(int verbose)
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
 		return;
 
-	/* Get IO TLB memory from the low pages */
-	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	if (swiotlb_alloc_from_low_pages)
+		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
+
 	if (!tlb)
 		goto fail;
 	if (swiotlb_init_with_tbl(tlb, default_nslabs, verbose))
-- 
2.25.1

