Return-Path: <linux-hyperv+bounces-213-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99C7ABF83
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 12:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 56C981F22D2A
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532B10A16;
	Sat, 23 Sep 2023 10:11:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953910A08
	for <linux-hyperv@vger.kernel.org>; Sat, 23 Sep 2023 10:11:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E019A;
	Sat, 23 Sep 2023 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695463899; x=1726999899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5bEJT87B98JS6iQ6LlrNVmLBQuK2BkIiNY3V5ZdVNuo=;
  b=bnmx651jWqX+0fN4OJlCk5MMai7c0IBYAiTVDZoZkAXmD763o85SdtWw
   myhCY0aQbYb2Sk51EBdfu3gKaYBgKmPg7xhs7YSDeQIYVlkyK1QfQ537A
   LDiiK54ixXyE3xK76MpZ1bp9q1bDzMoneX7yekigerhnEw/lLFbKx5YyG
   plDnBOT+XOxsGfw/1J0kZF9t664kquhpQIOs8b1nrqLDjp8N2CfkVR/mD
   aUbxkK+ztKyIhfRbuNJGjpgx5NGRN2rbYszSVFHQwJig+Bft69tcmU4TO
   faPRrkOCcT/s/17Q41moohDTgFOsklGVuFuwco24EDWWX15y8qGjCIjX4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447492093"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="447492093"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 03:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813388100"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="813388100"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2023 03:11:36 -0700
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
Subject: [PATCH v11 01/37] x86/cpufeatures: Add the cpu feature bit for WRMSRNS
Date: Sat, 23 Sep 2023 02:41:36 -0700
Message-Id: <20230923094212.26520-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923094212.26520-1-xin3.li@intel.com>
References: <20230923094212.26520-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

WRMSRNS is an instruction that behaves exactly like WRMSR, with
the only difference being that it is not a serializing instruction
by default. Under certain conditions, WRMSRNS may replace WRMSR to
improve performance.

Add the CPU feature bit for WRMSRNS.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 58cb9495e40f..330876d34b68 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -322,6 +322,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
+#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-Serializing Write to Model Specific Register instruction */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 798e60b5454b..1b9d86ba5bc2 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -318,6 +318,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
+#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-Serializing Write to Model Specific Register instruction */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
-- 
2.34.1


