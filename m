Return-Path: <linux-hyperv+bounces-6043-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701CAEC4A0
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF84A85E2
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92612222A8;
	Sat, 28 Jun 2025 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhNXkMD8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FF220F5A;
	Sat, 28 Jun 2025 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081728; cv=none; b=Phj3Ba6PO/CG4jfxOxCfIQJHeH4YOCJ1jERimC/HkTVjRuWh91jLGSijmJIrHkBnhoFx85oD/FcWJ6PaK3Z1ZarPQ4E5P3I1LoWXRItzmBj+2/+tozUeaaBQFsWMIJgfaLx+pDqZ94A27/TEXResd1zzdhpMfg/DhO2wpUQl9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081728; c=relaxed/simple;
	bh=bA+cp60Wn+c2Q2SZQk3sBkJyRd3e890T+LyFFWB2XgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rU9xgQR3Z0bU2lww8Oxz9uKk+B8Mg+WXD3SKFrXdnpA1PEy5EQmgLBY/rLtDqlxAQp9z3NIhbV5JnWWXftLa+eJnHF2Mva+HqZFC37uH5N4UIEIQzX28PBkeD/lt4KtY2cUwMF2MSX5OPr0jTm3mXZxcFtr3NpDX9cNj3tsXsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhNXkMD8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081727; x=1782617727;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bA+cp60Wn+c2Q2SZQk3sBkJyRd3e890T+LyFFWB2XgE=;
  b=HhNXkMD8TrSO6aFHeyjC7EUD+wsGpp36Ia6ZKeiIdBRMzfEC0J1ziQRJ
   NQnJZNEjxc7dy5sENA7r0Op4++Ex09i1SFRJNOan6BYtq/ZyQCXeDFAIR
   h8RwGganbyTO0MRd+oDMLtGhCv6j3BV18o1Z9di30pCAEqKu08riHvShp
   njx3uwno+MrGOQIxn080GlKMf4k2tD35TNc5DqA4OpaAHqhv98CiKz6yq
   CindFnstOy0pMZBisi5EwF86DNXQDFgHwKd+KIlNot9ij33n7P4HenLtX
   ZYMhcpbLFqG4Z7ckYXQn/weDStitUGEm0F44OvXGVtoZ/yNvCjKa0kxSG
   Q==;
X-CSE-ConnectionGUID: X4bHyIXERzClQSCml01ZRw==
X-CSE-MsgGUID: fbxARklrQ4y7wISliXaDaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335362"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:22 -0700
X-CSE-ConnectionGUID: QFza1kH1R8OmyHa67d5u8A==
X-CSE-MsgGUID: her6WysNTaWVZqgZ+5Pkqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141956"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:21 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:15 -0700
Subject: [PATCH v5 09/10] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-9-df547b1d196e@linux.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=2277;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=9g1YRz6FR6zJlHZ79s4vEPUPGZUICsglX98SibsY/ZY=;
 b=PptK7p3kg/euz4gfz+AKQVUtImSQRNvFKTF7PbB15t8dTYJ/c7/2oc4wYqFkFnel9sDPr/38g
 j2ZaeSskVxoCWf/4SMBQEBHmZEY9PJ4R/DPPDY87yjHSHj7Xaw99pZd
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

The current code maps MMIO devices as shared (decrypted) by default in a
confidential computing VM.

In a TDX environment, secondary CPUs are booted using the Multiprocessor
Wakeup Structure defined in the ACPI specification. The virtual firmware
and the operating system function in the guest context, without
intervention from the VMM. Map the physical memory of the mailbox as
private. Use the is_private_mmio() callback.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 - None

Changes since v3:
 - Updated to use the renamed function acpi_get_mp_wakeup_mailbox_paddr().
 - Added Reviewed-by tag from Michael. Thanks!

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
index ca0d23206e67..ed633a7e05b4 100644
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
+	u64 mb_addr = acpi_get_mp_wakeup_mailbox_paddr();
+
+	return mb_addr && within_page(addr, mb_addr);
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	/*
@@ -66,6 +78,8 @@ void __init hv_vtl_init_platform(void)
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


