Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6131FAD2F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFPJzz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 05:55:55 -0400
Received: from verein.lst.de ([213.95.11.211]:37309 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgFPJzy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 05:55:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8EE268AFE; Tue, 16 Jun 2020 11:55:49 +0200 (CEST)
Date:   Tue, 16 Jun 2020 11:55:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616095549.GA27917@lst.de>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87blljicjm.fsf@vitty.brq.redhat.com> <20200616093341.GA26400@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616093341.GA26400@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Actually, what do you think of this one:

---
From a5ee278f4244c6bfc0ce2d2b2fd4f99358dbde4d Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Jun 2020 11:50:59 +0200
Subject: x86/hyperv: allocate the hypercall page with only read and execute
 bits

Avoid a W^X violation cause by the fact that PAGE_KERNEL_EXEC includes the
writable bit.

Fixes: 78bb17f76edc ("x86/hyperv: use vmalloc_exec for the hypercall page")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/hyperv/hv_init.c            | 4 +++-
 arch/x86/include/asm/pgtable_types.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a54c6a401581dd..f4875bf05c17ff 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -375,7 +375,9 @@ void __init hyperv_init(void)
 	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	hv_hypercall_pg = vmalloc_exec(PAGE_SIZE);
+	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
+			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_RX,
+			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE, __func__);
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 		goto remove_cpuhp_state;
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 2da1f95b88d761..591b5c92a66249 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -194,6 +194,7 @@ enum page_cache_mode {
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
 #define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_RX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
 #define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
 #define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
@@ -219,6 +220,7 @@ enum page_cache_mode {
 #define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
 #define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
 #define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
+#define PAGE_KERNEL_RX		__pgprot_mask(__PAGE_KERNEL_RX         | _ENC)
 #define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
 #define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
-- 
2.26.2

