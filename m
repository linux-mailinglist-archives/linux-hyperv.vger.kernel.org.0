Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2076E516FD7
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 May 2022 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiEBM6O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 May 2022 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385105AbiEBM6O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 May 2022 08:58:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513D0E0E5;
        Mon,  2 May 2022 05:54:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g3so11630883pgg.3;
        Mon, 02 May 2022 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN/fKJaSIZtDp6gQxOCgt91Vdq1JSEAMP+iuJMs6E2A=;
        b=hrgLy/VpAgIhhjqt4SAwfD8DP+zK4BkEfr2buQP7FspXbT0PSM0e9Cbi8khqemP56W
         U8rv5ojLJlRhXNdeK9IfEizYG7JyZbbhGjvNsH4js/gdN7CZOxcCLiK5n+uhD/ErnRZN
         qqulEtGgDqLRKJHN9ls7JDscJV3a+D3lDHadEhLEgRXcoQgPb+8BJ2bUR33kQyXZ88fW
         EQbupi/9LoIDPhOBs1WAVllhJDWbGXfXNfQoqnQhodaQ2uTIU4bvM8QuHaCJ7WC9pjk6
         2pp3LUvs3ZgRhkZBWeRZrg64hY2JzwFDzuUdxkPYeB9TLoDY08Nfq6z8JaXr+msrmd00
         GfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN/fKJaSIZtDp6gQxOCgt91Vdq1JSEAMP+iuJMs6E2A=;
        b=EYmZ5s6STyQsiIIljSn8Z260q/DPth/jlIIrdjycQfcevBhDu1+AfW2orHeewNfli+
         qhmBSidQZo3iWpEmp3pkQ0afYdfWCpHSJNtB822XkTbPkqMr69B4JPPA+I3aoGlybsdM
         Gyn6NOzYemcs1HBT7rXnGGIrlxXhewV+bkKPw4d92DrISY6Z2zXEA+Lhluw51zv0L3MG
         ED02VsMjyQo9xlOkSRV9UKe1i50xCgKJrAFrC5W8qtC41Z1815TzTZLYK3fSMBDcCL/t
         KNJ6Pn5Znx/+uY6sRlHk2SGIDu/IOTpY6W3PTTVA8GZQY0I1ipQxx6gyc/cOGwKTGa5l
         lrng==
X-Gm-Message-State: AOAM530Fqb9Y7td3jzYGcKlEvk9XzVnrXXMgKuM4DlXtdhHrvsaQkn7l
        S3hysq/ABcHf9ane8G5pUEE=
X-Google-Smtp-Source: ABdhPJxluc/MwrTa+ANe+CP4VNLdZ/2QrcVXP5LkWoKqW5fmpK1MYR0/ySmxJkMq30rZk3IKZqcZmA==
X-Received: by 2002:a63:8449:0:b0:3ab:5075:d40d with SMTP id k70-20020a638449000000b003ab5075d40dmr9636514pgd.12.1651496084809;
        Mon, 02 May 2022 05:54:44 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:3:7753:ad69:7fc0:9dfc])
        by smtp.gmail.com with ESMTPSA id n5-20020a62e505000000b0050dc76281cesm4634892pff.168.2022.05.02.05.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 05:54:44 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        andi.kleen@intel.com, kirill.shutemov@intel.com
Subject: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Date:   Mon,  2 May 2022 08:54:35 -0400
Message-Id: <20220502125436.23607-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502125436.23607-1-ltykernel@gmail.com>
References: <20220502125436.23607-1-ltykernel@gmail.com>
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Traditionally swiotlb was not performance critical because it was only
used for slow devices. But in some setups, like TDX/SEV confidential
guests, all IO has to go through swiotlb. Currently swiotlb only has a
single lock. Under high IO load with multiple CPUs this can lead to
significant lock contention on the swiotlb lock.

This patch adds child IO TLB mem support to resolve spinlock overhead
among device's queues. Each device may allocate IO tlb mem and setup
child IO TLB mem according to queue number. Swiotlb code allocates
bounce buffer among child IO tlb mem iterately.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  7 +++
 kernel/dma/swiotlb.c    | 97 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7ed35dd3de6e..4a3f6a7b4b7e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -89,6 +89,9 @@ extern enum swiotlb_force swiotlb_force;
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
+ * @child_nslot:The number of IO TLB slot in the child IO TLB mem.
+ * @num_child:  The child io tlb mem number in the pool.
+ * @child_start:The child index to start searching in the next round.
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -102,6 +105,10 @@ struct io_tlb_mem {
 	bool late_alloc;
 	bool force_bounce;
 	bool for_alloc;
+	unsigned int num_child;
+	unsigned int child_nslot;
+	unsigned int child_start;
+	struct io_tlb_mem *child;
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e2ef0864eb1e..32e8f42530b6 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -207,6 +207,26 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		mem->force_bounce = true;
 
 	spin_lock_init(&mem->lock);
+
+	if (mem->num_child) {
+		mem->child_nslot = nslabs / mem->num_child;
+		mem->child_start = 0;
+
+		/*
+		 * Initialize child IO TLB mem, divide IO TLB pool
+		 * into child number. Reuse parent mem->slot in the
+		 * child mem->slot.
+		 */
+		for (i = 0; i < mem->num_child; i++) {
+			mem->child[i].slots = mem->slots + i * mem->child_nslot;
+			mem->child[i].num_child = 0;
+
+			swiotlb_init_io_tlb_mem(&mem->child[i],
+				start + ((i * mem->child_nslot) << IO_TLB_SHIFT),
+				mem->child_nslot, late_alloc);
+		}
+	}
+
 	for (i = 0; i < mem->nslabs; i++) {
 		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
@@ -336,16 +356,18 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 
 	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 		get_order(array_size(sizeof(*mem->slots), nslabs)));
-	if (!mem->slots) {
-		free_pages((unsigned long)vstart, order);
-		return -ENOMEM;
-	}
+	if (!mem->slots)
+		goto error_slots;
 
 	set_memory_decrypted((unsigned long)vstart, bytes >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, true);
 
 	swiotlb_print_info();
 	return 0;
+
+error_slots:
+	free_pages((unsigned long)vstart, order);
+	return -ENOMEM;
 }
 
 void __init swiotlb_exit(void)
@@ -483,10 +505,11 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
  */
-static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
-			      size_t alloc_size, unsigned int alloc_align_mask)
+static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
+				 struct device *dev, phys_addr_t orig_addr,
+				 size_t alloc_size,
+				 unsigned int alloc_align_mask)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
@@ -565,6 +588,46 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	return index;
 }
 
+static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
+			      size_t alloc_size, unsigned int alloc_align_mask)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_mem *child_mem = mem;
+	int start = 0, i = 0, index;
+
+	if (mem->num_child) {
+		i = start = mem->child_start;
+		mem->child_start = (mem->child_start + 1) % mem->num_child;
+		child_mem = mem->child;
+	}
+
+	do {
+		index = swiotlb_do_find_slots(child_mem + i, dev, orig_addr,
+					      alloc_size, alloc_align_mask);
+		if (index >= 0)
+			return i * mem->child_nslot + index;
+		if (++i >= mem->num_child)
+			i = 0;
+	} while (i != start);
+
+	return -1;
+}
+
+static unsigned long mem_used(struct io_tlb_mem *mem)
+{
+	int i;
+	unsigned long used = 0;
+
+	if (mem->num_child) {
+		for (i = 0; i < mem->num_child; i++)
+			used += mem->child[i].used;
+	} else {
+		used = mem->used;
+	}
+
+	return used;
+}
+
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		unsigned int alloc_align_mask, enum dma_data_direction dir,
@@ -594,7 +657,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem->used);
+				     alloc_size, mem->nslabs, mem_used(mem));
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -617,9 +680,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	return tlb_addr;
 }
 
-static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+static void swiotlb_do_release_slots(struct io_tlb_mem *mem,
+				     struct device *dev, phys_addr_t tlb_addr)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
@@ -660,6 +723,20 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	spin_unlock_irqrestore(&mem->lock, flags);
 }
 
+static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	int index, offset;
+
+	if (mem->num_child) {
+		offset = swiotlb_align_offset(dev, tlb_addr);	
+		index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
+		mem = &mem->child[index / mem->child_nslot];
+	}
+
+	swiotlb_do_release_slots(mem, dev, tlb_addr);
+}
+
 /*
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
-- 
2.25.1

