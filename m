Return-Path: <linux-hyperv+bounces-2838-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E295D9A3
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D8228499E
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1C1CE6E5;
	Fri, 23 Aug 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dp/RiTy5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C291CB31B;
	Fri, 23 Aug 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455438; cv=none; b=LApQc96nyWfTIhVgkyxBJdR342iwOdqujULhbiK/dCIM85j2YpuESoq10O5p+sOmCOMkImnJER+EaJOw1UQO8slJAA9xMiBF32fJEQMZTUIOQ2kv12JTGnzVRXaGYdxI9bHkgUZZ2/BVACJDOHdvlEX/8GtxSV0X6MvW+c5PXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455438; c=relaxed/simple;
	bh=OD3m+O+sKRGN8XwA4mQy2TaqiRJ40gPU6Id+zBd9F+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsdLR42w49pZ2wfph07ZiyFXWAf5mQciTqauytq29Yg40O7xn7PzWbgJn33N9dxfgKy4TgkG8CEbb6YM0I39yUDUv21T+7LdXZCzosSv4L4e4Dcfiho4LLlObLM9a9C3ItEsJmlW97l+QHwim5+4/ixVeUr6/bWBim9xTy6E3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dp/RiTy5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455437; x=1755991437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OD3m+O+sKRGN8XwA4mQy2TaqiRJ40gPU6Id+zBd9F+M=;
  b=Dp/RiTy54g2mHzT93tII+8Ff8MaaJVitO++NKLagF/6n4lcLhjtaF7sj
   EuXA1JOJBqc8TuSO0gO7WytSG2pWw1M6xwc299iDehkISUD8rki2fot/4
   uNlvZh+o/1diN49OBqboeozZaxik1FYALhbFaVpQu92W3dIkmgvIg9h54
   FZk4AN5GRSfH34b0J0AoOKXdPwFdj6RvK0dzlVwya+Lcbf371IuRlz4+9
   0/J1A+WHrsBabfm+m3Wk/E5XN6LL1UGbSP0skpL648ZM+vKSwd3/DbYSH
   5Q++Iohs74iVWjd3l7V+m4CtGvXvN10sWdJI/wGw1/qiLS+YWono2DQ0f
   A==;
X-CSE-ConnectionGUID: Wi1bp94kScOj7zYYigyF8A==
X-CSE-MsgGUID: ndDRybC1Q6WhKKK0vJHjOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619305"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619305"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:54 -0700
X-CSE-ConnectionGUID: 3HyKYy15SDyoigchZ7zZkw==
X-CSE-MsgGUID: HQVhJAUASQmMzsazYr8bMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641010"
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
Subject: [PATCH v2 5/9] x86/hyperv: Mark ACPI wakeup mailbox page as private
Date: Fri, 23 Aug 2024 16:23:23 -0700
Message-Id: <20240823232327.2408869-6-yunhong.jiang@linux.intel.com>
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

Current code maps MMIO devices as shared (decrypted) by default in a
confidential computing VM. However, the wakeup mailbox must be accessed
as private (encrypted) because it's accessed by the OS and the firmware,
both are in the guest's context and encrypted. Set the wakeup mailbox
range as private explicitly.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/hyperv/hv_vtl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c..987a6a1200b0 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -22,10 +22,26 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
 	return true;
 }
 
+static inline bool within_page(u64 addr, u64 start)
+{
+	return addr >= start && addr < (start + PAGE_SIZE);
+}
+
+/*
+ * The ACPI wakeup mailbox are accessed by the OS and the BIOS, both are in the
+ * guest's context, instead of the hypervisor/VMM context.
+ */
+static bool hv_is_private_mmio_tdx(u64 addr)
+{
+	return wakeup_mailbox_addr && within_page(addr, wakeup_mailbox_addr);
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
 
+	if (hv_isolation_type_tdx())
+		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
-- 
2.25.1


