Return-Path: <linux-hyperv+bounces-65-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F31379FAC9
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 07:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C575C281749
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4096132;
	Thu, 14 Sep 2023 05:19:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B936108
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 05:19:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4C212E;
	Wed, 13 Sep 2023 22:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694668767; x=1726204767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DfU6e7Lxi3caIgHaas3RwgcYA9izTEYulGU0upU0hWQ=;
  b=ZzL6Kn4cqvAk6SV+zVcfAh1hkxVgYHhwoavTha/1ib/qszt4DPW2W38l
   G/zrHXbGWXq9QOEccAhBkpu6K+WHiBBH8EvoXsjMBNTCraepdmX7YEplF
   yHgd6DpyqRyddeNLmUJG1TYDcZN1BtOMU5JE59x7YixKWlZ/0nN9517Oo
   p9/YG3kcWg7G7tRyiMdVIWlhZYpq20XLyq37fRQBNUaUP78pVpRCwj7i5
   0d2LvX/8vYZsEEO3OkCPPkYAQQHetkYo5f1XG2v6TiK0CuYXiU2IzjkN1
   7ccVewM14F6YGA+O0FOLJb7bT2fIzJRdriaqJCHW4jND+ypmPimq+Uucc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="382661535"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="382661535"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 22:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779488847"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="779488847"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2023 22:17:47 -0700
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
Subject: [PATCH v10 36/38] x86/fred: Add fred_syscall_init()
Date: Wed, 13 Sep 2023 21:48:03 -0700
Message-Id: <20230914044805.301390-37-xin3.li@intel.com>
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

Add a syscall initialization function fred_syscall_init() for FRED,
and this is really just to skip setting up SYSCALL/SYSENTER related
MSRs, e.g., MSR_LSTAR and invalidate SYSENTER configurations, because
FRED uses the ring 3 FRED entrypoint for SYSCALL and SYSENTER, and
ERETU is the only legit instruction to return to ring 3 per FRED spec
5.0.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kernel/cpu/common.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d960b7276008..4cb36e241c9a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2105,6 +2105,23 @@ static inline void idt_syscall_init(void)
 	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
+static inline void fred_syscall_init(void)
+{
+	/*
+	 * Per FRED spec 5.0, FRED uses the ring 3 FRED entrypoint for SYSCALL
+	 * and SYSENTER, and ERETU is the only legit instruction to return to
+	 * ring 3, as a result there is _no_ need to setup the SYSCALL and
+	 * SYSENTER MSRs.
+	 *
+	 * Note, both sysexit and sysret cause #UD when FRED is enabled.
+	 */
+	wrmsrl(MSR_LSTAR, 0ULL);
+	wrmsrl_cstar(0ULL);
+	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
+	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
+	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
+}
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
-- 
2.34.1


