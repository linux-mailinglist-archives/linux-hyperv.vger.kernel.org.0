Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A695ED975
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Sep 2022 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiI1Jv0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Sep 2022 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI1JvZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Sep 2022 05:51:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE065A6C06;
        Wed, 28 Sep 2022 02:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664358684; x=1695894684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Br2i/PQsVuorfzONFXOsgP+GRMRyazWmVkbxSLZDOVE=;
  b=CL0wURgX/CMbJlPPBHWlyY5Z37NsJ44L9JqCsV2D3dNG1uh4Y8BptL1a
   sY03SqAjEBPKMCALB8oXH5JGKnjyWEgSQzWdFu7bF1pOvkCD4OzkWlHNm
   gRgH+Nr0U4K/1/mECtvZr/zigO/VXGoFmJi3+qKr4L0yY+EigGxFK0hFN
   K1FFxZDaLwNJuJasFDR5weJBbg1T/i8WbOz+qtfEVOR92n7PVIRyv7kFX
   0kT/nH51zbldYQnRT8w80YpPmrk+K199JhubcUM9Bfgwt+vkY5OnFa0Uj
   kUduteBl2BL4mZb5WWuTiTYYFF8i0rrKGdqIFRzJFoJTjs93/wcudb6P2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="303041247"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="303041247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 02:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652617338"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="652617338"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by orsmga008.jf.intel.com with ESMTP; 28 Sep 2022 02:51:19 -0700
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Date:   Wed, 28 Sep 2022 17:56:40 +0800
Message-Id: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

kmap() is being deprecated in favor of kmap_local_page()[1].

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap's pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
single thread and is short live. So, in this case, it's safe to simply use
kmap_local_page() to create mapping, and this avoids the wasted cost of
kmap() for global synchronization.

In addtion, the fuction hyperv_init() checks if kmap() fails by BUG_ON().
From the original discussion[2], the BUG_ON() here is just used to
explicitly panic NULL pointer. So still keep the BUG_ON() in place to check
if kmap_local_page() fails. Based on this consideration, memcpy_to_page()
is not selected here but only kmap_local_page() is used.

Therefore, replace kmap() with kmap_local_page() in hyperv/hv_init.c.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
[2]: https://lore.kernel.org/lkml/20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2/

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

---
Suggested by credits.
	Dave: Referred to his comments about whether kmap() can fail and the
	      suggestion to keep BUG_ON() in place.
	Ira: Referred to his task documentation and review comments about
	     keeping BUG_ON() for kmap_local_page().
	Fabio: Stole some of his boiler plate commit message.
---
 arch/x86/hyperv/hv_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3de6d8b53367..72fe46eb183f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -459,13 +459,13 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 		pg = vmalloc_to_page(hv_hypercall_pg);
-		dst = kmap(pg);
+		dst = kmap_local_page(pg);
 		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
 				MEMREMAP_WB);
 		BUG_ON(!(src && dst));
 		memcpy(dst, src, HV_HYP_PAGE_SIZE);
 		memunmap(src);
-		kunmap(pg);
+		kunmap_local(dst);
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
-- 
2.34.1

