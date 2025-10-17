Return-Path: <linux-hyperv+bounces-7241-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814FBE625D
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A6D1A64BE0
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412E4284884;
	Fri, 17 Oct 2025 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaoHHw2V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8212750E6;
	Fri, 17 Oct 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669337; cv=none; b=UDEN6fSvbHGzWJfMkX2NFpTfMwTKUm1siVb5usTK+DCuGMbNaoInFqcKV/WHa1G2Qc9UiGUe02uJFQAMTBa7ljOH1cmR8kkEknYl5bLzmgCcUmQcZXelWRl9+shAt/uNJU1Jxeppy3T9LbjK/zctV4gidGl6W0fRwRA2gpMAIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669337; c=relaxed/simple;
	bh=rfgYQakiB6rXGq79UY0s3nHmlF8j120ioeVCexCocIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIki5KaCejwsF8iCeyiYbzxjB8rpO30Nn4DBGGkfzyNCSxtHg58tSnFGMj6D8AY03p4752pEvnlrXJMk0W//bTpVeSD9P9TyljTt9nF5jdIf9IxvpeVhNKlo4L0bj8IPT/vi/jCp2rFqFF1/a2M2VDJweu9wx7K1+o3BzTcW1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaoHHw2V; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669336; x=1792205336;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rfgYQakiB6rXGq79UY0s3nHmlF8j120ioeVCexCocIQ=;
  b=XaoHHw2VCVHWqh45/WshKf4Ej8awk8Gn7o5kDrF69V2tHexunE6jHN+A
   Ux5gFGTS5nNVd8gYewqoYvhC/jqD5FL8ELbnea1xRbBnR2bnHHorFHoJl
   X6IPZYnSN0UyARgJHmpSU6VJXWB0jz0QlDxdkAq1gWXT72OjO0UOKAzyY
   FRKS7NDCAogSAA9hCJg9dXOxoHJ0QsXmZg+7PQ6DJFlsyZdpLjDzUZz+h
   UDRGHCfYG5H9g/6pivb1XBBG1Ox3U27jiUYdVZCW11OsArwKxVB7XZQkf
   tJtPzEKbCuADMAV76yWWCPWsLPt8Ls1mcPTM4pGe9CdSkK7pVD+YtcEsD
   g==;
X-CSE-ConnectionGUID: GeipHbbxSvCUSi/Vx+AUgA==
X-CSE-MsgGUID: MAbifTXKQhicm3cAMNM0xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321937"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321937"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:51 -0700
X-CSE-ConnectionGUID: 7TaZSx59SB+i2ybbWi2e2w==
X-CSE-MsgGUID: kNyEf4tZQIiupUCdv1q0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776580"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:50 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:31 -0700
Subject: [PATCH v6 09/10] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-9-40435fb9305e@linux.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=2530;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=sCXBCSStHR5KXeSPe/oKcOxoQ5zJM21CUHF9SXzLUIw=;
 b=oVA33jRldgvUCBMVyH+M5hYlIlAsU81WPVMCWJ6+IabcR7rouVOHUeInnhC0d50XUhEMl0iYU
 js/p7DUtOOgCQAlTg5s1fBfrrK+jXDtmGJwKzpFNGFvVI8eYjgsC1Pr
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

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Fixed a compile error with !CONFIG_X86_MAILBOX_WAKEUP.
 - Added Reviewed-by tag from Dexuan. Thanks!

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
 arch/x86/hyperv/hv_vtl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index ca0d23206e67..4a15de4d5ec2 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -54,6 +54,22 @@ static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
 	hv_vtl_emergency_restart();
 }
 
+static inline bool within_page(u64 addr, u64 start)
+{
+	return addr >= start && addr < (start + PAGE_SIZE);
+}
+
+static bool hv_vtl_is_private_mmio_tdx(u64 addr)
+{
+	if (IS_ENABLED(CONFIG_X86_MAILBOX_WAKEUP)) {
+		u64 mb_addr = acpi_get_mp_wakeup_mailbox_paddr();
+
+		return mb_addr && within_page(addr, mb_addr);
+	}
+
+	return false;
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	/*
@@ -66,6 +82,8 @@ void __init hv_vtl_init_platform(void)
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


