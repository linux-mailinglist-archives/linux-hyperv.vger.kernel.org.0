Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89E603098
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Oct 2022 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJRQPv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJRQPu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 12:15:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F522B28;
        Tue, 18 Oct 2022 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666109749; x=1697645749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oVwEkTvo388mdVRGCGIjhvZMJ0FRpThRSVZC/miQszI=;
  b=AuDAbU4viKFqSvmi08HqDMh4LyP6hB6ONicoUlsX1ZWArzPl22qOrmy+
   iTlstDMbQMLTjJoS3KULOevmBSQ9FxP7Gh5/+lJhjpLjR6DqHnjaD1Cto
   fMK52B15BxMUdUKL4JHhRK8uMkrm/HrQhvjwhdwaPoepQlKonymSCzZD1
   iWnAeIjmLanUu/34MqkclFuCqinRSH//HYEIS7+/aOpYqf96R6OrU3CGg
   3U7T4zE3a3KLc9tiK0+dwi5RSQOw1TI4QA22VJEP9wNusKwv4jFgP7uyj
   DWKWTv1AMBzu/h3LdpZcQtiBJoas4oUMKBtr/OTvfMlxqMOyvUZFmH+0N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293524770"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="293524770"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 09:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606617636"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="606617636"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 09:15:45 -0700
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
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] x86/hyperv: Remove BUG_ON() for kmap_local_page()
Date:   Wed, 19 Oct 2022 00:21:17 +0800
Message-Id: <20221018162117.2332508-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

The commit 154fb14df7a3c ("x86/hyperv: Replace kmap() with
kmap_local_page()") keeps the BUG_ON() to check if kmap_local_page()
fails.

But in fact, kmap_local_page() always returns a valid kernel address
and won't return NULL here. It will BUG on its own if it fails. [1]

So directly use memcpy_to_page() which creates local mapping to copy.

[1]: https://lore.kernel.org/lkml/YztFEyUA48et0yTt@iweiny-mobl/

Fixes: 154fb14df7a3 ("x86/hyperv: Replace kmap() with kmap_local_page()")
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 arch/x86/hyperv/hv_init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 29774126e931..f66c5709324f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -459,13 +459,11 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 		pg = vmalloc_to_page(hv_hypercall_pg);
-		dst = kmap_local_page(pg);
 		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
 				MEMREMAP_WB);
-		BUG_ON(!(src && dst));
-		memcpy(dst, src, HV_HYP_PAGE_SIZE);
+		BUG_ON(!src);
+		memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
 		memunmap(src);
-		kunmap_local(dst);
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
-- 
2.34.1

