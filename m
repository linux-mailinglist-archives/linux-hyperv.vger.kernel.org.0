Return-Path: <linux-hyperv+bounces-429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E410F7B6130
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 08:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EE4CB1C208C2
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA020CA7D;
	Tue,  3 Oct 2023 06:54:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868BCA66
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Oct 2023 06:54:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C804311C;
	Mon,  2 Oct 2023 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316088; x=1727852088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f4gesqgoemAM7gLIVW0tfHuShJv23oH28+TguMOULZ8=;
  b=XNx/RclM0xEqw4CBaxkn2NWr1vRqeAqWPKUXPlYHfPZCU1FB6X7fu5yv
   4cXQnXvMAtDNTtEoMcOdc26lh08Dmpev0POi5kxfsbD6cX9uhqqJ2S1Kq
   nIspiYC0AVLwtp4AR+lnzQiK31P57XsqgpQEfn4wxoFXfWsOOP92rSgnN
   xCRortvC5W4x03HYwZ/UhCuzsJvqv+kJy8xO1btwJYTsFviYg17BXQTgv
   CwurjzxKUA82mS7NC+ndlBp0RX7ETmlgjQMe9t3FmxKEp2KjAiTlyFDEU
   7mX2IR/VxFJD4x4uZRrD9L65iuKUt9+ZoszBqopRV3gDSfbpGGRwYBHjv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367858112"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367858112"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081900951"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081900951"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 23:54:43 -0700
From: Xin Li <xin3.li@intel.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	peterz@infradead.org,
	jgross@suse.com,
	ravi.v.shankar@intel.com,
	mhiramat@kernel.org,
	andrew.cooper3@citrix.com,
	jiangshanlai@gmail.com,
	nik.borisov@suse.com
Subject: [PATCH v12 18/37] x86/fred: Reserve space for the FRED stack frame
Date: Mon,  2 Oct 2023 23:24:39 -0700
Message-Id: <20231003062458.23552-19-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003062458.23552-1-xin3.li@intel.com>
References: <20231003062458.23552-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

When using FRED, reserve space at the top of the stack frame, just
like i386 does.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/thread_info.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b02940747..12da7dfd5ef1 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -31,7 +31,9 @@
  * In vm86 mode, the hardware frame is much longer still, so add 16
  * bytes to make room for the real-mode segments.
  *
- * x86_64 has a fixed-length stack frame.
+ * x86-64 has a fixed-length stack frame, but it depends on whether
+ * or not FRED is enabled. Future versions of FRED might make this
+ * dynamic, but for now it is always 2 words longer.
  */
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_VM86
@@ -39,8 +41,12 @@
 # else
 #  define TOP_OF_KERNEL_STACK_PADDING 8
 # endif
-#else
-# define TOP_OF_KERNEL_STACK_PADDING 0
+#else /* x86-64 */
+# ifdef CONFIG_X86_FRED
+#  define TOP_OF_KERNEL_STACK_PADDING (2 * 8)
+# else
+#  define TOP_OF_KERNEL_STACK_PADDING 0
+# endif
 #endif
 
 /*
-- 
2.34.1


