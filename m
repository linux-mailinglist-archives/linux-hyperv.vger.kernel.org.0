Return-Path: <linux-hyperv+bounces-235-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B0A7ABFB4
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 12:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 46AE1B208FE
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77C10A1C;
	Sat, 23 Sep 2023 10:11:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172010A19
	for <linux-hyperv@vger.kernel.org>; Sat, 23 Sep 2023 10:11:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462471BE;
	Sat, 23 Sep 2023 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695463908; x=1726999908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7R91mzhAyMwuxf88uvtu3V1UGcA6vznqDxNdL57F/c=;
  b=lI3qFdBJ0gCc7+51MCb+eAv5IiowMkXv3og/CBaw/6tkoV8wy2mGUviT
   PYOP9T7oueM4cPUQLlt/QUHvEBwadIDOxJ8sKmjcY0HnkU2EU3vyuA6rl
   kKkMWLw5k3mMXqyYJq9GT52TEj3IymjS543L+ircqKG/qQapW9JzjdA8Z
   Yj9Jq1JQqMCxLgw03R4vRj3l8vRqg0PFJ4rRIXFhEmqTYaW55wJIdTrWb
   8SrLaU3WgyCuGNha1CNMUezExH/liIDAF8w5MYAwa2JRW+WE/OEyWblPu
   raCnzzZ4u2tTJ63/SbUrVNsluNIlYy/evAHRKm6mzCpHbZQs+H5teYeRs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447492338"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="447492338"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 03:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813388180"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="813388180"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2023 03:11:46 -0700
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
Subject: [PATCH v11 22/37] x86/fred: Allow single-step trap and NMI when starting a new task
Date: Sat, 23 Sep 2023 02:41:57 -0700
Message-Id: <20230923094212.26520-23-xin3.li@intel.com>
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

Entering a new task is logically speaking a return from a system call
(exec, fork, clone, etc.). As such, if ptrace enables single stepping
a single step exception should be allowed to trigger immediately upon
entering user space. This is not optional.

NMI should *never* be disabled in user space. As such, this is an
optional, opportunistic way to catch errors.

Allow single-step trap and NMI when starting a new task, thus once
the new task enters user space, single-step trap and NMI are both
enabled immediately.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v8:
* Use high-order 48 bits above the lowest 16 bit SS only when FRED
  is enabled (Thomas Gleixner).
---
 arch/x86/kernel/process_64.c | 38 ++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4f87f5987ae8..c075591b7b46 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -56,6 +56,7 @@
 #include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
+#include <asm/fred.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
@@ -528,7 +529,7 @@ void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,
-		    unsigned int _cs, unsigned int _ss, unsigned int _ds)
+		    u16 _cs, u16 _ss, u16 _ds)
 {
 	WARN_ON_ONCE(regs != current_pt_regs());
 
@@ -545,11 +546,36 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 	loadsegment(ds, _ds);
 	load_gs_index(0);
 
-	regs->ip		= new_ip;
-	regs->sp		= new_sp;
-	regs->cs		= _cs;
-	regs->ss		= _ss;
-	regs->flags		= X86_EFLAGS_IF;
+	regs->ip	= new_ip;
+	regs->sp	= new_sp;
+	regs->csx	= _cs;
+	regs->ssx	= _ss;
+	/*
+	 * Allow single-step trap and NMI when starting a new task, thus
+	 * once the new task enters user space, single-step trap and NMI
+	 * are both enabled immediately.
+	 *
+	 * Entering a new task is logically speaking a return from a
+	 * system call (exec, fork, clone, etc.). As such, if ptrace
+	 * enables single stepping a single step exception should be
+	 * allowed to trigger immediately upon entering user space.
+	 * This is not optional.
+	 *
+	 * NMI should *never* be disabled in user space. As such, this
+	 * is an optional, opportunistic way to catch errors.
+	 *
+	 * Paranoia: High-order 48 bits above the lowest 16 bit SS are
+	 * discarded by the legacy IRET instruction on all Intel, AMD,
+	 * and Cyrix/Centaur/VIA CPUs, thus can be set unconditionally,
+	 * even when FRED is not enabled. But we choose the safer side
+	 * to use these bits only when FRED is enabled.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		regs->fred_ss.swevent	= true;
+		regs->fred_ss.nmi	= true;
+	}
+
+	regs->flags	= X86_EFLAGS_IF | X86_EFLAGS_FIXED;
 }
 
 void
-- 
2.34.1


