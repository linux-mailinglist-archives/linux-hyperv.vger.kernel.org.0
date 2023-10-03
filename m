Return-Path: <linux-hyperv+bounces-435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F57B6172
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 08:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A5F0F2816E6
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7ACA76;
	Tue,  3 Oct 2023 06:55:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA551CA71
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Oct 2023 06:55:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6023D10C9;
	Mon,  2 Oct 2023 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316105; x=1727852105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vZ6vels66+tC8YRpSCj8dEsAAUPLXovJkO1WpIp9s0Y=;
  b=eS2QIWAKuLck8ingsWmEsHlazcE79NZGqFVLVIswXnQIt0teHTMojPc4
   yY+ntjPD7acGFayNF+q/LPFSLrSUrD3jBUiJgunVc/OZbLqb1IE0xv0qV
   hrHt6ZsBJF6bdTw8arfelXo0W9M/l+gnztkjr6D6miybtyaRAm0Nr3zBd
   35rKq6ZCC/WSSP7e5knULxKa1cNfzAPxW72Y+5Ivz3xUs9VF3BgiZCHue
   S6F5WAVLWQ6PSxUh8k0D8Caj+riGplMJNOAZybQKvl8ZVC7MMY7q+EH5M
   Z62oORfJaSLml68uABx2IeEbg8nJLzcGO3AO+QX9kX54rDHlEtiLvIyP6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367858182"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367858182"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081900971"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081900971"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 23:54:46 -0700
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
Subject: [PATCH v12 23/37] x86/fred: Make exc_page_fault() work for FRED
Date: Mon,  2 Oct 2023 23:24:44 -0700
Message-Id: <20231003062458.23552-24-xin3.li@intel.com>
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

On a FRED system, the faulting address (CR2) is passed on the stack,
to avoid the problem of transient state. Thus we get the page fault
address from the stack instead of CR2.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ab778eac1952..7675bc067153 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/fred.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1516,8 +1517,10 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
-	unsigned long address = read_cr2();
 	irqentry_state_t state;
+	unsigned long address;
+
+	address = cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) : read_cr2();
 
 	prefetchw(&current->mm->mmap_lock);
 
-- 
2.34.1


