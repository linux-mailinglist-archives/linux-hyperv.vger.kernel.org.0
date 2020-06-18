Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84F01FEBA4
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgFRGnZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 02:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFRGnY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 02:43:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46713C06174E;
        Wed, 17 Jun 2020 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=SUoVkFQUmyi1QuSIWVOIlXHCGmT/Vk+Hj9VKkJNBZPM=; b=kRMCd9CWE8Z4zk7v4dWebOFH/W
        roNF9rNUIbgg2q64rQLRFQwHvmw82StRDKY3X/rI0d7KpoX2jE+ogKTFOdkdiz4twv24zu4VKsAZo
        5499ut/O2vfwhMrn70kSJZBCATzWSEl5TTiokYnci392puTnJv+Jiv3Ui7HUNMrsj1IT1Wt4aRH0+
        EVB7hcYKvOMBkMM+iC+/K22ox6rh/ch1XZsf6ckiBXfUS2fZNxJFF3zxGrUrlFLfDhq1IfZbGjkfd
        KzwWdJepf4rXaibEpUpx1M8Se4rmg/Bhx5ZCBCPhq7zAGMMzHiQNyUeRvfdyBEA+m857HXYvTkjyD
        RdhhbR6w==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jloGY-0007yl-M6; Thu, 18 Jun 2020 06:43:15 +0000
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
Subject: [PATCH 1/3] x86/hyperv: allocate the hypercall page with only read and execute bits
Date:   Thu, 18 Jun 2020 08:43:05 +0200
Message-Id: <20200618064307.32739-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618064307.32739-1-hch@lst.de>
References: <20200618064307.32739-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Avoid a W^X violation cause by the fact that PAGE_KERNEL_EXEC includes the
writable bit.

For this resurrect the removed PAGE_KERNEL_RX definitіon, but as
PAGE_KERNEL_ROX to match arm64 and powerpc.

Fixes: 78bb17f76edc ("x86/hyperv: use vmalloc_exec for the hypercall page")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c            | 4 +++-
 arch/x86/include/asm/pgtable_types.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a54c6a401581dd..2bdc72e6890eca 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -375,7 +375,9 @@ void __init hyperv_init(void)
 	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	hv_hypercall_pg = vmalloc_exec(PAGE_SIZE);
+	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
+			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
+			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE, __func__);
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 		goto remove_cpuhp_state;
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 2da1f95b88d761..816b31c685505f 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -194,6 +194,7 @@ enum page_cache_mode {
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
 #define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
 #define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
@@ -219,6 +220,7 @@ enum page_cache_mode {
 #define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
 #define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
 #define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
+#define PAGE_KERNEL_ROX		__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
 #define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
 #define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
-- 
2.26.2

