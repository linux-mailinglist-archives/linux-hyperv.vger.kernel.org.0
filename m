Return-Path: <linux-hyperv+bounces-221-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6AD7ABF8E
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 1413E1F236F2
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7910A18;
	Sat, 23 Sep 2023 10:11:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08A10A13
	for <linux-hyperv@vger.kernel.org>; Sat, 23 Sep 2023 10:11:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3F11AB;
	Sat, 23 Sep 2023 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695463902; x=1726999902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZlGESG1ZjbxHp/2vGEpu7uzY2F9a0taEPQgxug8c1Qc=;
  b=LjBnTKGC4TbjnCdJZHwPu10OF/JG4rT6e62vPS/oKnkov/bSeKuBa/Nz
   8H9anR7oHOl7tTFo/vYxhA02mIcl9MbnmcadBeDdSYzJT7FhnaWHeIYvp
   FDX6IyTgDY8Qo8LoYSfiLlVHz/SW7iha8+GhoyrlaCuABGEGr909iVnit
   P9rfLbXAZCxjSEnp2RWC+RpfBlp64KYJVNUQ/4pCQDCU/61KJYFrceT4e
   67ka1X+hyrjsr7H3uiySFugrqMSHikccmAa/dB1Z2Oqe83NSzyKEQgY62
   OfS335aAgnOcAJV8In1YWhPCzwVX/FakejbxcIDnsloXn2ezi2NAF/YKk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447492167"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="447492167"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 03:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813388128"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="813388128"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2023 03:11:39 -0700
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
Subject: [PATCH v11 08/37] x86/cpufeatures: Add the cpu feature bit for FRED
Date: Sat, 23 Sep 2023 02:41:43 -0700
Message-Id: <20230923094212.26520-9-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923094212.26520-1-xin3.li@intel.com>
References: <20230923094212.26520-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Any FRED CPU will always have the following features as its baseline:
  1) LKGS, load attributes of the GS segment but the base address into
     the IA32_KERNEL_GS_BASE MSR instead of the GS segment’s descriptor
     cache.
  2) WRMSRNS, non-serializing WRMSR for faster MSR writes.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c         | 2 ++
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 330876d34b68..57ae93dc1e52 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -321,6 +321,7 @@
 #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
+#define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-Serializing Write to Model Specific Register instruction */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index e462c1d3800a..b7174209d855 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -82,6 +82,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
+	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{}
 };
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 1b9d86ba5bc2..18bab7987d7f 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -317,6 +317,7 @@
 #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
+#define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-Serializing Write to Model Specific Register instruction */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
-- 
2.34.1


