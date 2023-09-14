Return-Path: <linux-hyperv+bounces-46-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769379FA88
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 07:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E71C20869
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 05:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF4250EE;
	Thu, 14 Sep 2023 05:19:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119C20F5
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 05:19:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0E1BE6;
	Wed, 13 Sep 2023 22:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694668760; x=1726204760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbR2wCTkousO/IPIjdDUqT7zLHmXpw3IGG9LN/Z2MXU=;
  b=by/1gscZHY9imVVilKeASC6nrXWpiGIPli9lncLQnJql2IJ0VI8USfo5
   BB/yXnsLMZOiwF24pYWki+PzFzNcKIS970lHgEcx8rcvnc+WrNNv6R0yV
   fGoixDSpDsGsepRHD5qjMSCLEiWz/Uvy22qJXA92BZBFjSfjcfJmc+5EV
   Z2B81tPXi3bg+El0ALQ9hejZybylTc1xfR7vNydlS4Uy7XiZu4RO5te6i
   qwiz08YJ08wGJ2QttgU+Ejz+fBsyaIONH71I8NEDGMV/x1ygFiGLRBxEc
   6GM4pBVLrI3s8w0Gx9k72Nfh4tGN2SbqTwU66v/a8LmeAqQ4CAOtJRRk6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="382661286"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="382661286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 22:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779488790"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="779488790"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2023 22:17:37 -0700
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
	jiangshanlai@gmail.com
Subject: [PATCH v10 17/38] x86/fred: Add a new header file for FRED definitions
Date: Wed, 13 Sep 2023 21:47:44 -0700
Message-Id: <20230914044805.301390-18-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914044805.301390-1-xin3.li@intel.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add a header file for FRED prototypes and definitions.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v6:
* Replace pt_regs csx flags prefix FRED_CSL_ with FRED_CSX_.
---
 arch/x86/include/asm/fred.h | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 arch/x86/include/asm/fred.h

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
new file mode 100644
index 000000000000..f514fdb5a39f
--- /dev/null
+++ b/arch/x86/include/asm/fred.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros for Flexible Return and Event Delivery (FRED)
+ */
+
+#ifndef ASM_X86_FRED_H
+#define ASM_X86_FRED_H
+
+#include <linux/const.h>
+
+#include <asm/asm.h>
+
+/*
+ * FRED event return instruction opcodes for ERET{S,U}; supported in
+ * binutils >= 2.41.
+ */
+#define ERETS			_ASM_BYTES(0xf2,0x0f,0x01,0xca)
+#define ERETU			_ASM_BYTES(0xf3,0x0f,0x01,0xca)
+
+/*
+ * RSP is aligned to a 64-byte boundary before used to push a new stack frame
+ */
+#define FRED_STACK_FRAME_RSP_MASK	_AT(unsigned long, (~0x3f))
+
+/*
+ * Used for the return address for call emulation during code patching,
+ * and measured in 64-byte cache lines.
+ */
+#define FRED_CONFIG_REDZONE_AMOUNT	1
+#define FRED_CONFIG_REDZONE		(_AT(unsigned long, FRED_CONFIG_REDZONE_AMOUNT) << 6)
+#define FRED_CONFIG_INT_STKLVL(l)	(_AT(unsigned long, l) << 9)
+#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_FRED
+#include <linux/kernel.h>
+
+#include <asm/ptrace.h>
+
+struct fred_info {
+	/* Event data: CR2, DR6, ... */
+	unsigned long edata;
+	unsigned long resv;
+};
+
+/* Full format of the FRED stack frame */
+struct fred_frame {
+	struct pt_regs   regs;
+	struct fred_info info;
+};
+
+static __always_inline struct fred_info *fred_info(struct pt_regs *regs)
+{
+	return &container_of(regs, struct fred_frame, regs)->info;
+}
+
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
+{
+	return fred_info(regs)->edata;
+}
+
+#else /* CONFIG_X86_FRED */
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
+#endif /* CONFIG_X86_FRED */
+#endif /* !__ASSEMBLY__ */
+
+#endif /* ASM_X86_FRED_H */
-- 
2.34.1


