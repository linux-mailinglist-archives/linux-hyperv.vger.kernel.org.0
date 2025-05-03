Return-Path: <linux-hyperv+bounces-5338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B314AA8244
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344EF1B6249D
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772828151E;
	Sat,  3 May 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUPuLdbv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F6280CD0;
	Sat,  3 May 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299421; cv=none; b=RlBgAR7mJzwhDwMTXOO4UGLPPdY5Thj91XWXW+hSl9gJcHiCtoSko7CBBwmnCmG6xKiBAK3ZRjhHJgy1BX0SoKtW+nXJSTjNYkeXGzzieXRdZTWoqd1Nea048qnGZizfGFbvX3qW9bn3/+C6XToTWnJZYyrlVrOnHOf2SKwGTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299421; c=relaxed/simple;
	bh=BWV+hPZ8NwIXIk/iN6QTrvYj4GcwemlrTx2HSjeDVEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SsYGtwswLwGprsCndVpbplBdRozU2Mi/WGhvctp56Df552KsMZTp7QPHqdcwnyuyijUcMgkqIX/C6qz0G425dWoOc7MAjKpEhGILNVFA7xaAG5IftI6nN6LkIao/9jCxCKeNKiUWS23zZqvCuL+p1XzdEIvmuOyZu+G/+dcWzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUPuLdbv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299420; x=1777835420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BWV+hPZ8NwIXIk/iN6QTrvYj4GcwemlrTx2HSjeDVEg=;
  b=MUPuLdbvMu77nqPkYZamepXVbStXZqhqO+q4Ldkpk71iWp31v7vUQNc4
   +ip3iWAfgdRYfQ9XuJnKjDAVrIMvaQvHGWZwEonlqvPWQT3YRDxahbKf0
   Hac+E77u6F2Suj7jHoQcSog+PV1MgHxInMwjmA8IKZKf2Hm2iJTiZSaSp
   fZKtAbuwG4MCTVVR5HeOg7vqvKC8M6vdN746mP1UqBX1kF1aAsUJ7eHgJ
   ODaO8kCLpvZwE5bAc256eKzsGr/J0J3Tlw3nXwawVqlvoiixcHuphUcS5
   Ci55DCdk1VSTWXOp75FHdfecWUOMGoSKzbASZ4BESI018uxS/JseU4/t3
   w==;
X-CSE-ConnectionGUID: 95YW6nJ7RX60mXGY2MzGrg==
X-CSE-MsgGUID: wbqVcaLqSn++xl6WDKEoHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095661"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:16 -0700
X-CSE-ConnectionGUID: GIeKs3QCTPy4WXrwna3ECQ==
X-CSE-MsgGUID: TZDOebLbSsS+LelOY7bhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046121"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:15 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org ,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 12/13] x86/hyperv/vtl: Mark the wakeup mailbox page as private
Date: Sat,  3 May 2025 12:15:14 -0700
Message-Id: <20250503191515.24041-13-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

The current code maps MMIO devices as shared (decrypted) by default in a
confidential computing VM.

In a TDX environment, secondary CPUs are booted using the Multiprocessor
Wakeup Structure defined in the ACPI specification. The virtual firmware
and the operating system function in the guest context, without
intervention from the VMM. Map the physical memory of the mailbox as
private. Use the is_private_mmio() callback.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Use the new helper function get_mp_wakeup_mailbox_paddr().
 - Edited the commit message for clarity.

Changes since v1:
 - Added the helper function within_page() to improve readability
 - Override the is_private_mmio() callback when detecting a TDX
   environment. The address of the mailbox is checked in
   hv_is_private_mmio_tdx().
---
 arch/x86/hyperv/hv_vtl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 8b497c8292d3..cd48bedd21f0 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -54,6 +54,18 @@ static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
 	hv_vtl_emergency_restart();
 }
 
+static inline bool within_page(u64 addr, u64 start)
+{
+	return addr >= start && addr < (start + PAGE_SIZE);
+}
+
+static bool hv_vtl_is_private_mmio_tdx(u64 addr)
+{
+	u64 mb_addr = get_mp_wakeup_mailbox_paddr();
+
+	return mb_addr && within_page(addr, mb_addr);
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
@@ -61,6 +73,8 @@ void __init hv_vtl_init_platform(void)
 	/* There is no paravisor present if we are here. */
 	if (hv_isolation_type_tdx()) {
 		x86_init.resources.realmode_limit = SZ_4G;
+		x86_platform.hyper.is_private_mmio = hv_vtl_is_private_mmio_tdx;
+
 	} else {
 		x86_platform.realmode_reserve = x86_init_noop;
 		x86_platform.realmode_init = x86_init_noop;
-- 
2.43.0


