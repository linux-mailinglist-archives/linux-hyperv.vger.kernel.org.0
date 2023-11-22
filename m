Return-Path: <linux-hyperv+bounces-1025-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B787F4DB0
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 18:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BB22811AA
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4774EB20;
	Wed, 22 Nov 2023 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JgSb7prC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3988D9F;
	Wed, 22 Nov 2023 09:01:39 -0800 (PST)
Received: from localhost.localdomain (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id C19D120B74C1;
	Wed, 22 Nov 2023 09:01:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C19D120B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700672498;
	bh=BKqGTv7UstB2deyF2KOlDMhyNWpRdGHnOL9MuTocPpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgSb7prCdabwpGgVQnbh4ee5XA8kqbASGpQJSDfED6R3bv7a6g5yCsOUIKJR7i7Em
	 MpEhnCOYWXXxGAoLna1v4W0M97P/5nzYpql5x91XrtfyZR74+92IIBuIOF5jBW3ZqM
	 f07lkA5njUbY2NHdKhdbMyC70l7jrKYd2wZGVr88=
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org,
	Dexuan Cui <decui@microsoft.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	stefan.bader@canonical.com,
	tim.gardner@canonical.com,
	roxana.nicolescu@canonical.com,
	cascardo@canonical.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 2/3] x86/coco: Disable TDX module calls when TD partitioning is active
Date: Wed, 22 Nov 2023 18:01:05 +0100
Message-Id: <20231122170106.270266-2-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce CC_ATTR_TDX_MODULE_CALLS to allow code to check whether TDX module
calls are available. When TD partitioning is enabled, a L1 TD VMM handles most
TDX facilities and the kernel running as an L2 TD VM does not have access to
TDX module calls. The kernel still has access to TDVMCALL(0) which is forwarded
to the VMM for processing, which is the L1 TD VM in this case.

Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/coco/core.c                     | 3 +++
 arch/x86/include/asm/unaccepted_memory.h | 2 +-
 drivers/virt/coco/tdx-guest/tdx-guest.c  | 3 +++
 include/linux/cc_platform.h              | 8 ++++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..2c1116da4d54 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -12,6 +12,7 @@
 
 #include <asm/coco.h>
 #include <asm/processor.h>
+#include <asm/tdx.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
 static u64 cc_mask __ro_after_init;
@@ -24,6 +25,8 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 	case CC_ATTR_MEM_ENCRYPT:
 		return true;
+	case CC_ATTR_TDX_MODULE_CALLS:
+		return !tdx_partitioning_active;
 	default:
 		return false;
 	}
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index f5937e9866ac..b666062555ac 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -8,7 +8,7 @@
 static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+	if (cc_platform_has(CC_ATTR_TDX_MODULE_CALLS)) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
 	} else if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 5e44a0fa69bd..2f995df8c795 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -87,6 +87,9 @@ static int __init tdx_guest_init(void)
 	if (!x86_match_cpu(tdx_guest_ids))
 		return -ENODEV;
 
+	if (!cc_platform_has(CC_ATTR_TDX_MODULE_CALLS))
+		return -ENODEV;
+
 	return misc_register(&tdx_misc_dev);
 }
 module_init(tdx_guest_init);
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..d3c57e86773d 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -90,6 +90,14 @@ enum cc_attr {
 	 * Examples include TDX Guest.
 	 */
 	CC_ATTR_HOTPLUG_DISABLED,
+
+	/**
+	 * @CC_ATTR_TDX_MODULE_CALLS: TDX module calls are available.
+	 *
+	 * The platform supports issuing calls directly to the TDX module.
+	 * This is not a given when TD partitioning is active.
+	 */
+	CC_ATTR_TDX_MODULE_CALLS,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.39.2


