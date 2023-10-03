Return-Path: <linux-hyperv+bounces-414-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E977B611D
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E9F4528175F
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534CD264;
	Tue,  3 Oct 2023 06:54:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC033CA7B
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Oct 2023 06:54:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFD3B8;
	Mon,  2 Oct 2023 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316078; x=1727852078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qsPaAmdkqHl0KD85EKfAfnheAb+UY4gBzEbjksg7Tw=;
  b=UFaRe0FHUrEJ/lXqJO7hpm4Lc+av8SoUNxbjvr7rzTOleMnU3d/V4YM4
   7kP+N2qPGPcj++JMkvGqdWF6UcN1o7Nma+ezOvlo4GeWF4hhVubhhDN2f
   1WycxJfAD9eaj3hB0OTDm5qdA75blYtfinDlMEF3cLMLrGbRPcRDIXt/V
   0zxUPYTyMujSfDSfPpP+T2QMqtKkRAGIilxzuYS15/LyWzThqpnAJWkou
   KRfWkNJYEuIsf6paKd0HC05dny8AsKjzZQ/Ahzjr7beKaOfqCLxuOCX7m
   km724bBNxS2IAeIXnviOGfjna2MhPbnkHFm092B2jNCdf5isBbm53+71l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367857926"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367857926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081900902"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081900902"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 23:54:35 -0700
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
Subject: [PATCH v12 03/37] x86/msr: Add the WRMSRNS instruction support
Date: Mon,  2 Oct 2023 23:24:24 -0700
Message-Id: <20231003062458.23552-4-xin3.li@intel.com>
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

Add an always inline API __wrmsrns() to embed the WRMSRNS instruction
into the code.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/msr.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec1965cd28..c284ff9ebe67 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -97,6 +97,19 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
+/*
+ * WRMSRNS behaves exactly like WRMSR with the only difference being
+ * that it is not a serializing instruction by default.
+ */
+static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
+{
+	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
+	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
+		     "2:\n"
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
+		     : : "c" (msr), "a"(low), "d" (high));
+}
+
 #define native_rdmsr(msr, val1, val2)			\
 do {							\
 	u64 __val = __rdmsr((msr));			\
@@ -297,6 +310,11 @@ do {							\
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
+static __always_inline void wrmsrns(u32 msr, u64 val)
+{
+	__wrmsrns(msr, val, val >> 32);
+}
+
 /*
  * 64-bit version of wrmsr_safe():
  */
-- 
2.34.1


