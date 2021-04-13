Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB89D35E2AA
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 17:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbhDMPXB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346623AbhDMPXA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 11:23:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE8EC06138E;
        Tue, 13 Apr 2021 08:22:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m18so6192319plc.13;
        Tue, 13 Apr 2021 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7OMHxrj++vzM3fqEEVHDpiVziTWhlJNkVZ7Vyu86JI=;
        b=T5vaVLMUq+BSyeo4P00ERe3jcN9BMhr3sW7g4DPzvszr9JoM4a06kaXX2VA3CunQU9
         sNyW+XrBogbdRMYThNPNTxEeYbTwoXiYiSEBMru0sCnTtbjKYOWvcSzEpZqMLd2rW01c
         fK5vhict2PBva9W7d1SL5E54gqd65o/OP6Jz/vEonESOhR10ga7afbnLejAkOo+ND7Yj
         p+oXoMguV+7xJDzw1U5jhi0bN8oNdoD5l1vsSm9uEBZpxV1xHIC4RZswTI1H5GNZNRTq
         ohQ33Y19oVwTURbqwSJHc4o9/fHP0pjxRyNqrV2x9Ij4y4PMFRjEqPnP6YwxePvMMbD7
         GVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7OMHxrj++vzM3fqEEVHDpiVziTWhlJNkVZ7Vyu86JI=;
        b=iRCZK+Yg4nwQP2AEkTl7PqZs0emf6bNikEkfmSIrlmdwew/4W/kCf5ITK5nSzxNqEl
         75G5uiC9PjhhThJUA50FNeM1stBv5o+LBUJeCJJZ3lzc+3vaqiBlxvKYpI1v45iEfpzp
         1dOg39YEv9HQFEp8UDtZ4FISqIFawJ+HJRlEbH15xSXE9syC5mboN8SFL/FtLQKHAdWv
         C9S0wXccMpAzD2+I1rH/foCwEZlef4Up8vRlVQhD6oB2oIvqMtYAY/feK+iPBtA/rqi/
         C8OpM7zDxZNR/a7pZ+zZdPamESXTqZ7yWucmTUjQaAVMaCsIZy8j7FCjPAXHVEk2YN04
         Cq1Q==
X-Gm-Message-State: AOAM530Sx09tNJSAyy5Gu6e9/jvXjQpTHLoerwnt5hIRQaNfEqoOGGw9
        Rfftd9Z2Q+OgETkKozhamlI=
X-Google-Smtp-Source: ABdhPJy15ZuYK7gp0yamkwsMJxkcmPC9zafSjPwbDSYQm9S162f0mB9CbhPiXL9N0rkR5xhuPQLcQg==
X-Received: by 2002:a17:902:d2cf:b029:eb:390b:cf28 with SMTP id n15-20020a170902d2cfb02900eb390bcf28mr2207382plc.41.1618327359757;
        Tue, 13 Apr 2021 08:22:39 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:39 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, akpm@linux-foundation.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC V2 PATCH 7/12] HV/Vmbus: Initialize VMbus ring buffer for Isolation VM
Date:   Tue, 13 Apr 2021 11:22:12 -0400
Message-Id: <20210413152217.3386288-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

VMbus ring buffer are shared with host and it's need to
be accessed via extra address space of Isolation VM with
SNP support. This patch is to map the ring buffer
address in extra address space via ioremap(). HV host
visibility hvcall smears data in the ring buffer and
so reset the ring buffer memory to zero after calling
visibility hvcall.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/channel.c      | 10 +++++
 drivers/hv/hyperv_vmbus.h |  2 +
 drivers/hv/ring_buffer.c  | 83 +++++++++++++++++++++++++++++----------
 mm/ioremap.c              |  1 +
 mm/vmalloc.c              |  1 +
 5 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 407b74d72f3f..4a9fb7ad4c72 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -634,6 +634,16 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (err)
 		goto error_clean_ring;
 
+	err = hv_ringbuffer_post_init(&newchannel->outbound,
+				      page, send_pages);
+	if (err)
+		goto error_free_gpadl;
+
+	err = hv_ringbuffer_post_init(&newchannel->inbound,
+				      &page[send_pages], recv_pages);
+	if (err)
+		goto error_free_gpadl;
+
 	/* Create and init the channel open message */
 	open_info = kzalloc(sizeof(*open_info) +
 			   sizeof(struct vmbus_channel_open_channel),
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 0778add21a9c..d78a04ad5490 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -172,6 +172,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
 /* Interface */
 
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
+int hv_ringbuffer_post_init(struct hv_ring_buffer_info *ring_info,
+		struct page *pages, u32 page_cnt);
 
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		       struct page *pages, u32 pagecnt);
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 35833d4d1a1d..c8b0f7b45158 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -17,6 +17,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
+#include <linux/io.h>
+#include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
 
@@ -188,6 +190,44 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 	mutex_init(&channel->outbound.ring_buffer_mutex);
 }
 
+int hv_ringbuffer_post_init(struct hv_ring_buffer_info *ring_info,
+		       struct page *pages, u32 page_cnt)
+{
+	struct vm_struct *area;
+	u64 physic_addr = page_to_pfn(pages) << PAGE_SHIFT;
+	unsigned long vaddr;
+	int err = 0;
+
+	if (!hv_isolation_type_snp())
+		return 0;
+
+	physic_addr += ms_hyperv.shared_gpa_boundary;
+	area = get_vm_area((2 * page_cnt - 1) * PAGE_SIZE, VM_IOREMAP);
+	if (!area || !area->addr)
+		return -EFAULT;
+
+	vaddr = (unsigned long)area->addr;
+	err = ioremap_page_range(vaddr, vaddr + page_cnt * PAGE_SIZE,
+			   physic_addr, PAGE_KERNEL_IO);
+	err |= ioremap_page_range(vaddr + page_cnt * PAGE_SIZE,
+				  vaddr + (2 * page_cnt - 1) * PAGE_SIZE,
+				  physic_addr + PAGE_SIZE, PAGE_KERNEL_IO);
+	if (err) {
+		vunmap((void *)vaddr);
+		return -EFAULT;
+	}
+
+	/* Clean memory after setting host visibility. */
+	memset((void *)vaddr, 0x00, page_cnt * PAGE_SIZE);
+
+	ring_info->ring_buffer = (struct hv_ring_buffer *)vaddr;
+	ring_info->ring_buffer->read_index = 0;
+	ring_info->ring_buffer->write_index = 0;
+	ring_info->ring_buffer->feature_bits.value = 1;
+
+	return 0;
+}
+
 /* Initialize the ring buffer. */
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		       struct page *pages, u32 page_cnt)
@@ -197,33 +237,34 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	BUILD_BUG_ON((sizeof(struct hv_ring_buffer) != PAGE_SIZE));
 
-	/*
-	 * First page holds struct hv_ring_buffer, do wraparound mapping for
-	 * the rest.
-	 */
-	pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct page *),
-				   GFP_KERNEL);
-	if (!pages_wraparound)
-		return -ENOMEM;
-
-	pages_wraparound[0] = pages;
-	for (i = 0; i < 2 * (page_cnt - 1); i++)
-		pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
+	if (!hv_isolation_type_snp()) {
+		/*
+		 * First page holds struct hv_ring_buffer, do wraparound mapping for
+		 * the rest.
+		 */
+		pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct page *),
+					   GFP_KERNEL);
+		if (!pages_wraparound)
+			return -ENOMEM;
 
-	ring_info->ring_buffer = (struct hv_ring_buffer *)
-		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, PAGE_KERNEL);
+		pages_wraparound[0] = pages;
+		for (i = 0; i < 2 * (page_cnt - 1); i++)
+			pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
 
-	kfree(pages_wraparound);
+		ring_info->ring_buffer = (struct hv_ring_buffer *)
+			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, PAGE_KERNEL);
 
+		kfree(pages_wraparound);
 
-	if (!ring_info->ring_buffer)
-		return -ENOMEM;
+		if (!ring_info->ring_buffer)
+			return -ENOMEM;
 
-	ring_info->ring_buffer->read_index =
-		ring_info->ring_buffer->write_index = 0;
+		ring_info->ring_buffer->read_index =
+			ring_info->ring_buffer->write_index = 0;
 
-	/* Set the feature bit for enabling flow control. */
-	ring_info->ring_buffer->feature_bits.value = 1;
+		/* Set the feature bit for enabling flow control. */
+		ring_info->ring_buffer->feature_bits.value = 1;
+	}
 
 	ring_info->ring_size = page_cnt << PAGE_SHIFT;
 	ring_info->ring_size_div10_reciprocal =
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fa1ab41d152..d63c4ba067f9 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -248,6 +248,7 @@ int ioremap_page_range(unsigned long addr,
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(ioremap_page_range);
 
 #ifdef CONFIG_GENERIC_IOREMAP
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e6f352bf0498..19724a8ebcb7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2131,6 +2131,7 @@ struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 				  NUMA_NO_NODE, GFP_KERNEL,
 				  __builtin_return_address(0));
 }
+EXPORT_SYMBOL_GPL(get_vm_area);
 
 struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				const void *caller)
-- 
2.25.1

