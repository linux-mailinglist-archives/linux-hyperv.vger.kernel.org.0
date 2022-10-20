Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2805D6059D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJTIdG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Oct 2022 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJTIdF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Oct 2022 04:33:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2A184989;
        Thu, 20 Oct 2022 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666254769; x=1697790769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=24YMBCVcJ762KNP35Wql1ASoAixWvlrZlk6OghTOrWs=;
  b=Vht6SK/4W+VN/EXAfShHBg81hgGky1WwqTxTI1G69GlDlE7NfA5CF01E
   9WSjUWqJ7JujEcT0vgdm5DW4EOwLahjn+y2Mk40E1ogGUevcrfhFQRPi/
   ITzLWuER9dbaF5itWGaT9sBfwa+0Stnj0zaHdS8ymGusuSO3OrCCsD6S4
   sh+hMB/oVFYL+nXR9gorrml5FSLmRD2dNyiVsOjHtVhPYMk3RoNoNSuBS
   PwQV1NCVSzCd56+CqL//gNg2oEFIwBJOYvCrtRo5UowK+0Ft0Kqj2AMDS
   44ZNRiUTAwuJnf7mXNIO4+4D3Jd2yamWknwP5P92JIJv3JT+T1feu7ZLl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="308331471"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="308331471"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="718928199"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="718928199"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 01:32:45 -0700
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
Subject: [PATCH v2] x86/hyperv: Remove BUG_ON() for kmap_local_page()
Date:   Thu, 20 Oct 2022 16:38:20 +0800
Message-Id: <20221020083820.2341088-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Change in v2:
 - Removed "Fixes" tag in patch message.
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

