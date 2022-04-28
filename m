Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC151369E
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 16:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348205AbiD1ORx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348192AbiD1ORv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 10:17:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82DB6E70;
        Thu, 28 Apr 2022 07:14:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p6so4455204pjm.1;
        Thu, 28 Apr 2022 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=the4yA34RGUD48q304/xQ5DG1rsnoGDHZu5Bqshv4b4=;
        b=IoFEsTlkhJ1tegef+ipqlLKrrmXBKiFGc4RMdw1/tIy22ZjfsCrWFEJ7f8vRZPt/RS
         7PoxvHGu9WKZoSi651rEMlRQoyb/Hm92oQwQdB53JulJEtjQkZZxS74e+VuosNXKMebV
         vmaGjn3BTmPJh1RZj0LsSPeA9SOKu+kvrTnnsioao/RGCjsLyNmk5lnGGQ72y3cEn2/T
         n6AChK9VYkXgGPbcO4PHPavZe/INFNTuoOzFppg1MLT5vBLZj130X+pZK+BG5mKpPN2W
         2wjGWtqMLvbX8AkF2goPSABn8g5m2CFGgZRm0uoDXon1jFovjDeWlzodvcFaUo0HiwMu
         kyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=the4yA34RGUD48q304/xQ5DG1rsnoGDHZu5Bqshv4b4=;
        b=56mJofzrg/3P9kLyJAJLMuRvDbTLFVq6YM4flDafa5zb73zufnUgQ09tuGvFdnP9Wc
         QZArbAHjPaIF+gJjrlT6d0VnWBNcguRKPZ6Cp1Q2QMfBvqfgDcbDa+2Lg/hgoSpyWR94
         JQQ7m99gvLy6MbfgnWjTUAQD3xotD/4hsaSpTyN5i02E/1yJtgyx0g7QVw8n/qEjdlmK
         cFKJxytVLbqxULKzBtg0wddvWXj6Qd7WLDAz6QKSz21F/jhtjYI57zoxqAeeSAhCbVeS
         qCWqN/lLjGeiOEDD0nAxWPU9b1i1M6RvdG6i87ZsLFsSO+TUtHpL8NWCpuZbB8F9MkFy
         o/Nw==
X-Gm-Message-State: AOAM531WCKXwH6c+hXAtIhMDm8P2j4AlnxDRAzHGYupCGowrgtUcPt8k
        g8CjxtyL1j6nQPh1euZ+zos=
X-Google-Smtp-Source: ABdhPJw2ZFQgBay15hbXejlLvhqBSwLf48hvRHEOIhvxG1Dbz8YoaUTn3A4AZ4aPlClceUBb9dNLLg==
X-Received: by 2002:a17:902:9005:b0:158:e46e:688c with SMTP id a5-20020a170902900500b00158e46e688cmr33664927plp.173.1651155275954;
        Thu, 28 Apr 2022 07:14:35 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:de19:84:6ee0:6f2e])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm65331pfl.15.2022.04.28.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:14:34 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        andi.kleen@intel.com, kirill.shutemov@intel.com
Subject: [RFC PATCH 2/2] Swiotlb: Add device bounce buffer allocation interface
Date:   Thu, 28 Apr 2022 10:14:29 -0400
Message-Id: <20220428141429.1637028-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428141429.1637028-1-ltykernel@gmail.com>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

In SEV/TDX Confidential VM, device DMA transaction needs use swiotlb
bounce buffer to share data with host/hypervisor. The swiotlb spinlock
introduces overhead among devices if they share io tlb mem. Avoid such
issue, introduce swiotlb_device_allocate() to allocate device bounce
buffer from default io tlb pool and set up areas according input queue
number. Device may have multi io queues and setting up the same number
of io tlb area may help to resolve spinlock overhead among queues.

Introduce IO TLB Block unit(2MB) concepts to allocate big bounce buffer
from default pool for devices. IO TLB segment(256k) is too small.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  33 ++++++++
 kernel/dma/swiotlb.c    | 173 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 489c249da434..380bd1ce3d0f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -31,6 +31,14 @@ struct scatterlist;
 #define IO_TLB_SHIFT 11
 #define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
 
+/*
+ * IO TLB BLOCK UNIT as device bounce buffer allocation unit.
+ * This allows device allocates bounce buffer from default io
+ * tlb pool.
+ */
+#define IO_TLB_BLOCKSIZE   (8 * IO_TLB_SEGSIZE)
+#define IO_TLB_BLOCK_UNIT  (IO_TLB_BLOCKSIZE << IO_TLB_SHIFT)
+
 /* default to 64MB */
 #define IO_TLB_DEFAULT_SIZE (64UL<<20)
 
@@ -72,11 +80,13 @@ extern enum swiotlb_force swiotlb_force;
  * @index:	The slot index to start searching in this area for next round.
  * @lock:	The lock to protect the above data structures in the map and
  *		unmap calls.
+ * @block_index: The block index to start earching in this area for next round.
  */
 struct io_tlb_area {
 	unsigned long used;
 	unsigned int area_index;
 	unsigned int index;
+	unsigned int block_index;
 	spinlock_t lock;
 };
 
@@ -110,6 +120,7 @@ struct io_tlb_area {
  * @num_areas:  The area number in the pool.
  * @area_start: The area index to start searching in the next round.
  * @area_nslabs: The slot number in the area.
+ * @areas_block_number: The block number in the area.
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -126,7 +137,14 @@ struct io_tlb_mem {
 	unsigned int num_areas;
 	unsigned int area_start;
 	unsigned int area_nslabs;
+	unsigned int area_block_number;
+	struct io_tlb_mem *parent;
 	struct io_tlb_area *areas;
+	struct io_tlb_block {
+		size_t alloc_size;
+		unsigned long start_slot;
+		unsigned int list;
+	} *block;
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
@@ -155,6 +173,10 @@ unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
+int swiotlb_device_allocate(struct device *dev,
+			    unsigned int area_num,
+			    unsigned long size);
+void swiotlb_device_free(struct device *dev);
 #else
 static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
 {
@@ -187,6 +209,17 @@ static inline bool is_swiotlb_active(struct device *dev)
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
+
+void swiotlb_device_free(struct device *dev)
+{
+}
+
+int swiotlb_device_allocate(struct device *dev,
+			    unsigned int area_num,
+			    unsigned long size)
+{
+	return -ENOMEM;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 00a16f540f20..7b95a140694a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -218,7 +218,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 				    unsigned long nslabs, bool late_alloc)
 {
 	void *vaddr = phys_to_virt(start);
-	unsigned long bytes = nslabs << IO_TLB_SHIFT, i, j;
+	unsigned long bytes = nslabs << IO_TLB_SHIFT, i, j, k;
 	unsigned int block_list;
 
 	mem->nslabs = nslabs;
@@ -226,6 +226,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->end = mem->start + bytes;
 	mem->index = 0;
 	mem->late_alloc = late_alloc;
+	mem->area_block_number = nslabs / (IO_TLB_BLOCKSIZE * mem->num_areas);
 
 	if (swiotlb_force_bounce)
 		mem->force_bounce = true;
@@ -233,10 +234,18 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	for (i = 0, j = 0, k = 0; i < mem->nslabs; i++) {
 		if (!(i % mem->area_nslabs)) {
 			mem->areas[j].index = 0;
+			mem->areas[j].block_index = 0;
 			spin_lock_init(&mem->areas[j].lock);
+			block_list = mem->area_block_number;
 			j++;
 		}
 
+		if (!(i % IO_TLB_BLOCKSIZE)) {
+			mem->block[k].alloc_size = 0;
+			mem->block[k].list = block_list--;
+			k++;
+		}
+
 		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
@@ -308,6 +317,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (!mem->areas)
 		panic("%s: Failed to allocate mem->areas.\n", __func__);
 
+	mem->block = memblock_alloc(sizeof(struct io_tlb_block) *
+				    (default_nslabs / IO_TLB_BLOCKSIZE),
+				     SMP_CACHE_BYTES);
+	if (!mem->block)
+		panic("%s: Failed to allocate mem->block.\n", __func__);
+
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), default_nslabs, false);
 	mem->force_bounce = flags & SWIOTLB_FORCE;
 
@@ -332,7 +347,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
 	unsigned long bytes;
 	unsigned char *vstart = NULL;
-	unsigned int order, area_order;
+	unsigned int order, area_order, block_order;
 	int rc = 0;
 
 	if (swiotlb_force_disable)
@@ -380,6 +395,13 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!mem->areas)
 		goto error_area;
 
+	block_order = get_order(array_size(sizeof(*mem->block),
+		nslabs / IO_TLB_BLOCKSIZE));
+	mem->block = (struct io_tlb_block *)
+		__get_free_pages(GFP_KERNEL | __GFP_ZERO, block_order);
+	if (!mem->block)
+		goto error_block;
+
 	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 		get_order(array_size(sizeof(*mem->slots), nslabs)));
 	if (!mem->slots)
@@ -392,6 +414,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	return 0;
 
 error_slots:
+	free_pages((unsigned long)mem->block, block_order);
+error_block:
 	free_pages((unsigned long)mem->areas, area_order);
 error_area:
 	free_pages((unsigned long)vstart, order);
@@ -403,7 +427,7 @@ void __init swiotlb_exit(void)
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long tbl_vaddr;
 	size_t tbl_size, slots_size;
-	unsigned int area_order;
+	unsigned int area_order, block_order;
 
 	if (swiotlb_force_bounce)
 		return;
@@ -421,6 +445,9 @@ void __init swiotlb_exit(void)
 		area_order = get_order(array_size(sizeof(*mem->areas),
 			mem->num_areas));
 		free_pages((unsigned long)mem->areas, area_order);
+		block_order = get_order(array_size(sizeof(*mem->block),
+			mem->nslabs / IO_TLB_BLOCKSIZE));
+		free_pages((unsigned long)mem->block, block_order);
 		free_pages(tbl_vaddr, get_order(tbl_size));
 		free_pages((unsigned long)mem->slots, get_order(slots_size));
 	} else {
@@ -863,6 +890,146 @@ static int __init __maybe_unused swiotlb_create_default_debugfs(void)
 late_initcall(swiotlb_create_default_debugfs);
 #endif
 
+static void swiotlb_free_block(struct io_tlb_mem *mem,
+			       phys_addr_t start, unsigned int block_num)
+{
+	unsigned int start_slot = (start - mem->start) >> IO_TLB_SHIFT;
+	unsigned int area_index = start_slot / mem->num_areas;
+	unsigned int block_index = start_slot / IO_TLB_BLOCKSIZE;
+	unsigned int area_block_index = start_slot % mem->area_block_number;
+	struct io_tlb_area *area = &mem->areas[area_index];
+	unsigned long flags;
+	int count, i, num;
+
+	spin_lock_irqsave(&area->lock, flags);
+	if (area_block_index + block_num < mem->area_block_number)
+		count = mem->block[block_index + block_num].list;
+	else
+		count = 0;
+
+
+	for (i = block_index + block_num; i >= block_index; i--) {
+		mem->block[i].list = ++count;
+		/* Todo: recover slot->list and alloc_size here. */
+	}
+
+	for (i = block_index - 1, num = block_index % mem->area_block_number;
+	    i < num && mem->block[i].list; i--)
+		mem->block[i].list = ++count;
+
+	spin_unlock_irqrestore(&area->lock, flags);
+}
+
+void swiotlb_device_free(struct device *dev)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_mem *parent_mem = dev->dma_io_tlb_mem->parent;
+
+	swiotlb_free_block(parent_mem, mem->start, mem->nslabs / IO_TLB_BLOCKSIZE);
+}
+
+static struct page *swiotlb_alloc_block(struct io_tlb_mem *mem, unsigned int block_num)
+{
+	unsigned int area_index, block_index, nslot;
+	phys_addr_t tlb_addr;
+	struct io_tlb_area *area;
+	unsigned long flags;
+	int i, j;
+
+	if (!mem || !mem->block)
+		return NULL;
+
+	area_index = mem->area_start;
+	mem->area_start = (mem->area_start + 1) % mem->num_areas;
+	area = &mem->areas[area_index];
+
+	spin_lock_irqsave(&area->lock, flags);
+	block_index = area_index * mem->area_block_number + area->block_index;
+
+	/* Todo: Search more blocks. */
+	if (mem->block[block_index].list < block_num) {
+		spin_unlock_irqrestore(&area->lock, flags);
+		return NULL;
+	}
+
+	/* Update block and slot list. */
+	for (i = block_index; i < block_index + block_num; i++) {
+		mem->block[i].list = 0;
+		for (j = 0; j < IO_TLB_BLOCKSIZE; j++) {
+			nslot = i * IO_TLB_BLOCKSIZE + j;
+			mem->slots[nslot].list = 0;
+			mem->slots[nslot].alloc_size = IO_TLB_SIZE;
+		}
+	}
+	spin_unlock_irqrestore(&area->lock, flags);
+
+	area->block_index += block_num;
+	area->used += block_num * IO_TLB_BLOCKSIZE;
+	tlb_addr = slot_addr(mem->start, block_index * IO_TLB_BLOCKSIZE);
+	return pfn_to_page(PFN_DOWN(tlb_addr));
+}
+
+/*
+ * swiotlb_device_allocate - Allocate bounce buffer fo device from
+ * default io tlb pool. The allocation size should be aligned with
+ * IO_TLB_BLOCK_UNIT.
+ */
+int swiotlb_device_allocate(struct device *dev,
+			    unsigned int area_num,
+			    unsigned long size)
+{
+	struct io_tlb_mem *mem, *parent_mem = dev->dma_io_tlb_mem;
+	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_BLOCKSIZE);
+	struct page *page;
+	int ret = -ENOMEM;
+
+	page = swiotlb_alloc_block(parent_mem, nslabs / IO_TLB_BLOCKSIZE);
+	if (!page)
+		return -ENOMEM;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		goto error_mem;
+
+	mem->slots = kzalloc(array_size(sizeof(*mem->slots), nslabs),
+			     GFP_KERNEL);
+	if (!mem->slots)
+		goto error_slots;
+
+	swiotlb_setup_areas(mem, area_num, nslabs);
+	mem->areas = (struct io_tlb_area *)kcalloc(area_num,
+				   sizeof(struct io_tlb_area),
+				   GFP_KERNEL);
+	if (!mem->areas)
+		goto error_areas;
+
+	mem->block = (struct io_tlb_block *)kcalloc(nslabs / IO_TLB_BLOCKSIZE,
+				sizeof(struct io_tlb_block),
+				GFP_KERNEL);
+	if (!mem->block)
+		goto error_block;
+
+	swiotlb_init_io_tlb_mem(mem, page_to_phys(page), nslabs, true);
+	mem->force_bounce = true;
+	mem->for_alloc = true;
+
+	mem->vaddr = parent_mem->vaddr + page_to_phys(page) -  parent_mem->start;
+	dev->dma_io_tlb_mem->parent = parent_mem;
+	dev->dma_io_tlb_mem = mem;
+	return 0;
+
+error_block:
+	kfree(mem->areas);
+error_areas:
+	kfree(mem->slots);
+error_slots:
+	kfree(mem);
+error_mem:
+	swiotlb_device_free(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(swiotlb_device_allocate);
+
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
 struct page *swiotlb_alloc(struct device *dev, size_t size)
-- 
2.25.1

