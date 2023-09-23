Return-Path: <linux-hyperv+bounces-227-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E817ABF96
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C50BD1C20952
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6D10A1A;
	Sat, 23 Sep 2023 10:11:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FF10A13
	for <linux-hyperv@vger.kernel.org>; Sat, 23 Sep 2023 10:11:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686391A7;
	Sat, 23 Sep 2023 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695463904; x=1726999904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szPt1r95a6G9RGqQRcu9cfSwmWMFMGoo6TuZWPez9pk=;
  b=aiHp3F93ZLAAx68RVNAF9kDM48Xa4MHBEVCM0o7rJH0sKCBEdKCIyB1x
   Ip7LpJojTmQfHM9DuxeA6AeyAyukQImVfp8Nid6IXm3jmoPgaiGMbjtSH
   8obi3zGXrgb7JsG7WXXxo9Cbt8Cb3hLmADuIgIjxBKsHJ+oSjaFnJuf8B
   6p5IpWXil2gARsKf9soNV8ts4mXAHTjBDM67MlzR0CzL9r7JIb9NQgSGH
   1tRJz0pbjlykJ3aNi1ZiTGqTBXRmMDWnpe8zmWja1nMxanmShFGTSmFDs
   Kmv6lGFcahhw5t/RWJ1qo8iuDhsrE0L/qzvzzmD/BNrfm0REJU1ui78gx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447492240"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="447492240"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 03:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813388148"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="813388148"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2023 03:11:42 -0700
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
Subject: [PATCH v11 14/37] x86/cpu: Add MSR numbers for FRED configuration
Date: Sat, 23 Sep 2023 02:41:49 -0700
Message-Id: <20230923094212.26520-15-xin3.li@intel.com>
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

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add MSR numbers for the FRED configuration registers per FRED spec 5.0.

Originally-by: Megha Dey <megha.dey@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/msr-index.h       | 13 ++++++++++++-
 tools/arch/x86/include/asm/msr-index.h | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6a6b0f763f67..200d7715696d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer */
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index a00a53e15ab7..fc75e3ca47d9 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer */
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
-- 
2.34.1


