Return-Path: <linux-hyperv+bounces-2837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2B95D99F
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114981C22730
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3D1CDA2F;
	Fri, 23 Aug 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arpjZs72"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A111C9DC2;
	Fri, 23 Aug 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455437; cv=none; b=QTAPnrtxBNVoD9YdXrIDI/J799c0u0TnXB+ElDfyrS0f1sUDKRnVRdF/tehNLUJOtdE5MoJAuTKpETUMzNSp6GCG20ZzMXXBnCpO72drzNFxkSk8vP1HYEGjc7D6/PKhABySTnyHrN5YUEtk0htBWc4pavvRa3Y2uMOErQJzyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455437; c=relaxed/simple;
	bh=G/CSfmqqJqpJgE3a56H70L4rj4zApcX4WMSQea2EUAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmrBqxl03uYLblXKeY2JlXgjVHmjeoEZFn0gCix7MJ70/KNqg0sbm2054AoSKrFqepj4ojH/SdnAGd/egvjKLYct/AHwWRVzf4keJQmmy3inhDYiZgkHpEP3bFOLisBca1Bz14JGrTcEaYp/h1k+uBQIdjSw8UYZs50CfLcVGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arpjZs72; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455436; x=1755991436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G/CSfmqqJqpJgE3a56H70L4rj4zApcX4WMSQea2EUAs=;
  b=arpjZs722BF/JuRUDEBWBMAx3V+3CdHWaJbIoGioEzWklsOsk7ZxKeZ1
   gggN/GWenRp7ehvp3yVR5FYn/8ISY+P+pVdQFq8n2xcFQvPoyTDhMlLkl
   gYuUksDWnJUVf7NUJkCJD0+k0HihvvXsfawu9HHMy0gNJPSalPeFKOjY8
   WrJqnkiWq4aGaPwosjGD69/kVtbSxCuhXOysVcznLVi2EXCqWZWQiUaii
   AzRtvHbZZAyS49R1h8hoJfe4rblZGLPGc5V0rqNvvh9FfJTgqK5Ezsg9S
   XpSaU7p4jmUWzn94Wi8lrRN2x04q/CMLCGpKQdV+NF0rZysPy6dyh9dea
   A==;
X-CSE-ConnectionGUID: 3bY2KzRnTCu/z/Ssf0+7Fg==
X-CSE-MsgGUID: HVYrGjjWRjaPTJMsmr/XSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619298"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619298"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:54 -0700
X-CSE-ConnectionGUID: q1uY/s0DTO6DNvor61UFTQ==
X-CSE-MsgGUID: ZIkIOQXvT4GM4A6a1pcBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641007"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2024 16:23:53 -0700
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
	kirill.shutemov@linux.intel.com,
	yunhong.jiang@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 4/9] x86/hyperv: Parse the ACPI wakeup mailbox
Date: Fri, 23 Aug 2024 16:23:22 -0700
Message-Id: <20240823232327.2408869-5-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the wakeup mailbox VTL2 TDX guest. Put it to the guest_late_init, so
that it will be invoked before hyperv_init() where the mailbox address is
checked.

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
index 9c452bfbd571..14b005b6270f 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -365,6 +365,14 @@ void __init ms_hyperv_late_init(void)
 	u8 *randomdata;
 	u32 length, i;
 
+	/*
+	 * Parse the ACPI wakeup structure information from device tree.
+	 * Currently VTL2 TDX guest only.
+	 */
+#ifdef CONFIG_X86_64
+	wakeup_mailbox_addr = dtb_parse_mp_wake();
+#endif
+
 	/*
 	 * Seed the Linux random number generator with entropy provided by
 	 * the Hyper-V host in ACPI table OEM0.
-- 
2.25.1


