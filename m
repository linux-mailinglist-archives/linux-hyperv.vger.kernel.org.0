Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF13272C1
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Feb 2021 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhB1PF4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Feb 2021 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhB1PFg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Feb 2021 10:05:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A56C061793;
        Sun, 28 Feb 2021 07:04:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b8so5431231plh.0;
        Sun, 28 Feb 2021 07:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RWzHKuFvbODTj5jRC+lQmgTrcJKsaKdR6QlCjl9uo0=;
        b=Zm0G1Bh7M355CQ0CnlRcOnUtrs7GJlk7wSeOS+Z/1woubrOge8hWZfiNFctJ6skhc9
         PIOGfy8QO/OkPLS7fxrZ9vMNX2Qzq/00talYDrEncYWmi5HNhKcqbMW8z+iwkfC/Q5dz
         3gBOAcwRJp6RkUYS+BXnXgs5WBpAT04loH1FZF8C1p+/rXcgiupYQh8Dqr/XCjCc/HDT
         efozduLzA+IN+3SPyP0mCifLAwaAPIX0C5gQ/Ln1REb2rB7im1lidZG3ibnVypuR5zzr
         ooKLzWvP4HsqRpJanShD+iq3+s9+N52U1xyN0qd8MbEzdSltNlyFPdX+FyGHbl2FH34G
         ATwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RWzHKuFvbODTj5jRC+lQmgTrcJKsaKdR6QlCjl9uo0=;
        b=f/uPki7FMyrWRGf40JkJGk+l3UgLW1Yf93WGRh//efvimVAp3FfcSbXLxLQtL11B9p
         0GvSA02m5J3qQyy+4r4y9779lnQm6xePMlrL3hgciEtteKG9XM/DrxoS3UxYVBrsyuMf
         SHZCJOvx0WooumiB8UkCrkmWctvzzCcNu59CGvkzD7kbBs1BmX9L6ma/RooK/S+tXS6T
         G3NQ50ZjbSlMiAECRNuWFXEOACnIceTWuzfpaP9toEz2UVJ25mtMpPIJ8xWh/+y427tB
         SDTAqhswN8Zk5uTA3APo7aMTs4uyBWT0MRnQdleUewdzDl+hHZZWMb8lDmbdmfXVOTD0
         TYYg==
X-Gm-Message-State: AOAM532uIv4qXO2Lp/Yipt9JzUOssXXuH9ybec+rMWxKuIG2Lcw6JbwB
        6seZoerKHX1ZCM29xu7EFAA=
X-Google-Smtp-Source: ABdhPJxpYkxlSq8PKfC5naubY2Zm+VoIHoI1m79tpFzJHkL4PgBOeHWtBMc9GoRPrg7uh0LU4ChwvA==
X-Received: by 2002:a17:902:c94f:b029:e4:59a3:2915 with SMTP id i15-20020a170902c94fb02900e459a32915mr11421687pla.9.1614524657383;
        Sun, 28 Feb 2021 07:04:17 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:561f:afde:af07:8820])
        by smtp.gmail.com with ESMTPSA id 142sm8391331pfz.196.2021.02.28.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:04:17 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, akpm@linux-foundation.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC PATCH 7/12] hv/vmbus: Initialize VMbus ring buffer for Isolation VM
Date:   Sun, 28 Feb 2021 10:03:10 -0500
Message-Id: <20210228150315.2552437-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228150315.2552437-1-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
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

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/channel.c      | 10 +++++
 drivers/hv/hyperv_vmbus.h |  2 +
 drivers/hv/ring_buffer.c  | 83 +++++++++++++++++++++++++++++----------
 mm/ioremap.c              |  1 +
 mm/vmalloc.c              |  1 +
 5 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index f31b669a1ddf..4c05b1488649 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -657,6 +657,16 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
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

