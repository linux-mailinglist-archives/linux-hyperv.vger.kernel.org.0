Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF457D909
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 05:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiGVDi5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 23:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVDi4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 23:38:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442E93C25;
        Thu, 21 Jul 2022 20:38:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3154691pjl.0;
        Thu, 21 Jul 2022 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a29yCrzmqv8zNaI1yMzH3Qx7gYaf2LNG5kNo/fE/DUE=;
        b=TrKb0Uw+VOc11AVGkutqCQ35Bw+2OmQ0PKMah46laeZkwx582zFO1bWjxQT4FX7RGd
         LhdU7C39UFnNS8s3iqyC9Z6CLvp/w1nhhkEbYbG/9SCXo7TBJewh+wxWyELhumgfhXt6
         R2+F95zKkdFulgQOd+DNL/sMOyrt+/SC3Y7/0IU8VZWpios94Pnw8XppcJMhskyluGYg
         H1ipqR3UVaOgAJSJRNrDiwRjjBEfVR8AH70AjUU8jd9JSYTRJ/R5cPqItth8K2EfGN5X
         JbKqW4OfdFX20YZpmC4gb8egLxOfw6yL7s/WuotT0UFOh5DNFt5/xq876gS/db3Uz1v7
         KsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a29yCrzmqv8zNaI1yMzH3Qx7gYaf2LNG5kNo/fE/DUE=;
        b=PWmG7Ul7mKm3hTceKwgJ7Km2ZNyPK27R297hP5aOy/+byOvrhMa0tk20F3sfHQt9UH
         olp28RsKpBtgqc0gcSKj1ci5uqX8lCle5TJtoLQrDbwrOBCoRUma36UW6o84TQReY7Bq
         BwCjOaLMF4R81ldKi7beJWofo+CPJTOwrRJxsNDkq6Dwr8yi3J1Vi3lW/SM3RpzqUUiX
         B5VRhx3lW432pq9d0sQ0qCfNcyWsTIQaKuot6QBDdgjege9KKtTMDbYOZeNVacE5MiEm
         VijE/VFQX69en0rrFoH6wDE1M80KWmWoQrv+x8rTnwA9P4YMgzXzCHX3QKlKFl4yfRuW
         9zbQ==
X-Gm-Message-State: AJIora+A//g+IFSf4YNhC2DiowW5HLGCdlrTquXj32jsVSLX9ebDvbZr
        dg56e6B3mfRj3iyS3gXa8wE=
X-Google-Smtp-Source: AGRyM1vUUY7kKn/6KhBMe5A/fDpWpu7WshN/fj2ml6WTGt+/r5b8FRKVWzqAbQO/Z1PgJ4A5wm+nhQ==
X-Received: by 2002:a17:902:e887:b0:16c:32e4:6446 with SMTP id w7-20020a170902e88700b0016c32e46446mr1417882plg.142.1658461133058;
        Thu, 21 Jul 2022 20:38:53 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:d8dc:cc5e:7626:bc3c])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79f82000000b005252ab25363sm2521741pfr.206.2022.07.21.20.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 20:38:52 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH] swiotlb: Clean up some coding style and minor issues
Date:   Thu, 21 Jul 2022 23:38:46 -0400
Message-Id: <20220722033846.950237-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Tianyu Lan <tiala@microsoft.com>

- Fix the used field of struct io_tlb_area wasn't initialized
- Set area number to be 0 if input area number parameter is 0
- Use array_size() to calculate io_tlb_area array size
- Fix error handle of io_tlb_used debugfs node and introduce
  fops_io_tlb_used attribute
- Make parameters of swiotlb_do_find_slots() more reasonable

Fixes: 26ffb91fa5e0 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 kernel/dma/swiotlb.c                          | 42 ++++++++++++-------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4a6ad177d4b8..ddca09550f76 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5907,7 +5907,8 @@
 			Format: { <int> [,<int>] | force | noforce }
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
-				 areas with their own lock. Must be power of 2.
+				 areas with their own lock. Will be rounded up
+				 to a power of 2.
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c39483bf067d..5752db98a1f2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -96,7 +96,13 @@ struct io_tlb_slot {
 
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
-	if (!is_power_of_2(nareas))
+	/*
+	 * Set area number to 1 when input area number
+	 * is zero.
+	 */
+	if (!nareas)
+		nareas  = 1;
+	else if (!is_power_of_2(nareas))
 		nareas = roundup_pow_of_two(nareas);
 
 	default_nareas = nareas;
@@ -270,6 +276,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	for (i = 0; i < mem->nareas; i++) {
 		spin_lock_init(&mem->areas[i].lock);
 		mem->areas[i].index = 0;
+		mem->areas[i].used = 0;
 	}
 
 	for (i = 0; i < mem->nslabs; i++) {
@@ -353,8 +360,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	mem->areas = memblock_alloc(sizeof(struct io_tlb_area) *
-		default_nareas, SMP_CACHE_BYTES);
+	mem->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
+		default_nareas), SMP_CACHE_BYTES);
 	if (!mem->areas)
 		panic("%s: Failed to allocate mem->areas.\n", __func__);
 
@@ -479,7 +486,7 @@ void __init swiotlb_exit(void)
 		free_pages((unsigned long)mem->slots, get_order(slots_size));
 	} else {
 		memblock_free_late(__pa(mem->areas),
-				   mem->nareas * sizeof(struct io_tlb_area));
+				   array_size(sizeof(*mem->areas), mem->nareas));
 		memblock_free_late(mem->start, tbl_size);
 		memblock_free_late(__pa(mem->slots), slots_size);
 	}
@@ -593,11 +600,12 @@ static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
  */
-static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
-		struct io_tlb_area *area, int area_index,
-		struct device *dev, phys_addr_t orig_addr,
+static int swiotlb_do_find_slots(struct device *dev,
+		int area_index, phys_addr_t orig_addr,
 		size_t alloc_size, unsigned int alloc_align_mask)
 {
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_area *area = mem->areas + area_index;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
@@ -686,13 +694,12 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size, unsigned int alloc_align_mask)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	int start = raw_smp_processor_id() & ((1U << __fls(mem->nareas)) - 1);
+	int start = raw_smp_processor_id() & (mem->nareas - 1);
 	int i = start, index;
 
 	do {
-		index = swiotlb_do_find_slots(mem, mem->areas + i, i,
-					      dev, orig_addr, alloc_size,
-					      alloc_align_mask);
+		index = swiotlb_do_find_slots(dev, i, orig_addr,
+					      alloc_size, alloc_align_mask);
 		if (index >= 0)
 			return index;
 		if (++i >= mem->nareas)
@@ -903,17 +910,24 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
+static int io_tlb_used_get(void *data, u64 *val)
+{
+	*val = mem_used(&io_tlb_default_mem);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
+
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
 {
-	unsigned long used = mem_used(mem);
-
 	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
 	if (!mem->nslabs)
 		return;
 
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
-	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &used);
+	debugfs_create_file_unsafe("io_tlb_used", 0400, mem->debugfs, NULL,
+			&fops_io_tlb_used);
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
-- 
2.25.1

