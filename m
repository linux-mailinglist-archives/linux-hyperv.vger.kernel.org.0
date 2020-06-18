Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29831FEBAB
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 08:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgFRGn3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgFRGn2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 02:43:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3FC06174E;
        Wed, 17 Jun 2020 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dtJsCrnFHit/sIeBcuwVf3/K6OgLll85jPlFKT9SOgs=; b=mk7UtqQRF1PZuq+tu6pevUgyUL
        S+xAyJgPEys2sAFlqj2AZjGk8iCUd7BVQgcH3JxLOWXe70bCx2n9JBQ7cRkxBxMGPsnOLg0M91PHR
        PRmQicJ6mcFrDClEfljqw+XUe24Zb949cEdW8e/22bN6U21gEKrgHwrXhvQPQiVZswNxdCxcp+ZgL
        ik2pLS/r8DP7koivurpTixni0zJg5Mk5LHr4W0j9o6PwseGCIKtiOjHIdhGoRugFFc+fcFxHdVsT9
        TLypr9Rv4eh268xA9B0gJSxiQQDsyJNywegoHg/69gFdq1uhKCHWKvpwinTOvnKGpxhkR0rzkQPAs
        aXc8Dxnw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jloGe-00081Z-Qm; Thu, 18 Jun 2020 06:43:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 3/3] mm: remove vmalloc_exec
Date:   Thu, 18 Jun 2020 08:43:07 +0200
Message-Id: <20200618064307.32739-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618064307.32739-1-hch@lst.de>
References: <20200618064307.32739-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Merge vmalloc_exec into its only caller.  Note that for !CONFIG_MMU
__vmalloc_node_range maps to __vmalloc, which directly clears the
__GFP_HIGHMEM added by the vmalloc_exec stub anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/vmalloc.h |  1 -
 kernel/module.c         |  4 +++-
 mm/nommu.c              | 17 -----------------
 mm/vmalloc.c            | 20 --------------------
 4 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 48bb681e6c2aed..0221f852a7e1a3 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -106,7 +106,6 @@ extern void *vzalloc(unsigned long size);
 extern void *vmalloc_user(unsigned long size);
 extern void *vmalloc_node(unsigned long size, int node);
 extern void *vzalloc_node(unsigned long size, int node);
-extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *vmalloc_32_user(unsigned long size);
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask);
diff --git a/kernel/module.c b/kernel/module.c
index e8a198588f26ee..0c6573b98c3662 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2783,7 +2783,9 @@ static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
 
 void * __weak module_alloc(unsigned long size)
 {
-	return vmalloc_exec(size);
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
+			NUMA_NO_NODE, __func__);
 }
 
 bool __weak module_init_section(const char *name)
diff --git a/mm/nommu.c b/mm/nommu.c
index cdcad5d61dd194..f32a69095d509e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -290,23 +290,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-/**
- *	vmalloc_exec  -  allocate virtually contiguous, executable memory
- *	@size:		allocation size
- *
- *	Kernel-internal function to allocate enough pages to cover @size
- *	the page level allocator and map them into contiguous and
- *	executable kernel virtual space.
- *
- *	For tight control over page level allocator and protection flags
- *	use __vmalloc() instead.
- */
-
-void *vmalloc_exec(unsigned long size)
-{
-	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM);
-}
-
 /**
  * vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
  *	@size:		allocation size
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3091c2ca60dfd1..f60948aac0d0e4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2696,26 +2696,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-/**
- * vmalloc_exec - allocate virtually contiguous, executable memory
- * @size:	  allocation size
- *
- * Kernel-internal function to allocate enough pages to cover @size
- * the page level allocator and map them into contiguous and
- * executable kernel virtual space.
- *
- * For tight control over page level allocator and protection flags
- * use __vmalloc() instead.
- *
- * Return: pointer to the allocated memory or %NULL on error
- */
-void *vmalloc_exec(unsigned long size)
-{
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __builtin_return_address(0));
-}
-
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
 #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
 #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
-- 
2.26.2

