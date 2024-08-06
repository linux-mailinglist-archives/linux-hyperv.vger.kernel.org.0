Return-Path: <linux-hyperv+bounces-2736-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BAB949B19
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9D1B233A0
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB41176ACE;
	Tue,  6 Aug 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dG8QgZrB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7F176228;
	Tue,  6 Aug 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982386; cv=none; b=F7roBaXvUxtP6/E3GNdupXUruNL1ODdP6+OBM8xxX1K2U8MyeW2xjh4oYi1oI3B6cykFzL51ACw1abXn+LT4APMonlQSuXEhoTer8jbzQGA/8k3LyXGAF4T6quzoec8uh4nnaoAyLg9LbiSz1193miE7ooNENZCDMjdXKbxwGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982386; c=relaxed/simple;
	bh=Kcr+zIFCcu9xq2oIvAWbPmfklwzJtO91yB0E+DYT+P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REoWJ5k2KyiAeqJ9qiIzHzWrquL7XFQdhNC2lufLsgkiM/+p2xxBdEVp4MeM1kOUyj/qsubbn9iOE4hjQinPM2rkZw0L7+Eu8JWTB26+HASYbw9uJRtK1dw7lBrTGgS1gmO9Xhc15cff5WELYZxBcN7tOCFo/+VhIZ1G0YWxr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dG8QgZrB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982385; x=1754518385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kcr+zIFCcu9xq2oIvAWbPmfklwzJtO91yB0E+DYT+P0=;
  b=dG8QgZrBJORrv426BHIVS4b0BJREkwdFq9MGvS1D0zu/kPg7nLKMH4oG
   kDrJt2KxN8NyB9xSR+i1Myze0L9Hrs/LKY1nNirSTI6R/mjq4JSmbKZ/7
   twKleHAfW8c3aJYBqI4JegUlniVfei+jsJ5QQLaU5sW0jYkRbhogQCjsu
   /varweTKne3fasFDLb2yvVLKU/49t1kuvIprP6bY1oa9RX2VvXANx1D6R
   gTnOmU9nqXNcIFPwZYaWslCe/d7fHaRk1fogogYOBRegXI3IYCpBb0zgJ
   Fgb+1w/X/B614hanXFEEhuSEBxqZbRknxbQw3wtzyPPGQ1Cp3jY3HGRuF
   A==;
X-CSE-ConnectionGUID: sdfBZ8c9QHetg6kQYTdDqQ==
X-CSE-MsgGUID: /jX6bratSFCu94Z3VqPQ6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534392"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534392"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:05 -0700
X-CSE-ConnectionGUID: vVID3HzgTJyqVGOV7O7HSA==
X-CSE-MsgGUID: JXr4sURzQkK4Eo//cCQ5qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465637"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:13:04 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	yunhong.jiang@linux.intel.com
Subject: [PATCH 4/7] x86/hyperv: Parse the ACPI wakeup mailbox
Date: Tue,  6 Aug 2024 15:12:34 -0700
Message-Id: <20240806221237.1634126-5-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the wakeup mailbox in the guest_late_init. Put it to the
guest_late_init, so that it will be invoked before hyperv_init() where
the mailbox address will be checked.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/include/asm/mshyperv.h | 3 +++
 arch/x86/kernel/cpu/mshyperv.c  | 2 ++
 drivers/hv/hv_common.c          | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 390c4d13956d..5178b96c7fc9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -10,6 +10,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
+#include <asm/madt_wakeup.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
@@ -49,6 +50,8 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+extern u64 wakeup_mailbox_addr;
+
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3d4237f27569..f6b727b4bd0b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -43,6 +43,8 @@ struct ms_hyperv_info ms_hyperv;
 bool hyperv_paravisor_present __ro_after_init;
 EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
 
+u64 wakeup_mailbox_addr;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_msr(unsigned int reg)
 {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9c452bfbd571..08b9f4a39763 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -365,6 +365,14 @@ void __init ms_hyperv_late_init(void)
 	u8 *randomdata;
 	u32 length, i;
 
+	/*
+	 * Parse the ACPI wakeup structure information from device tree.
+	 * Currently TDX VTL2 guest only.
+	 */
+#ifdef CONFIG_X86_64
+	dtb_parse_mp_wake(&wakeup_mailbox_addr);
+#endif
+
 	/*
 	 * Seed the Linux random number generator with entropy provided by
 	 * the Hyper-V host in ACPI table OEM0.
-- 
2.25.1


