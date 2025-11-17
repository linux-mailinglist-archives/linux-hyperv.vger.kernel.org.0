Return-Path: <linux-hyperv+bounces-7637-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E557FC6567A
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 393202B576
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE1342528;
	Mon, 17 Nov 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQ73Dmy2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A333FE2F;
	Mon, 17 Nov 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399053; cv=none; b=Im7ZpXIT9ZRhvtt8OWCik6hHLGUIJ8oLGUnOldX8BslJzNZs0XjIVy/Xul5HePA2F5JMlFnXjXy1C0d4ajHgQimgK0tAAACxHiGM6yQ337V3KmXaBjSHsWF76iCUMvRKXMMtWZFliMBN95kN+XPf3ZfM1dKh3WOMdvN+eDmuKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399053; c=relaxed/simple;
	bh=FRbRfJTFR5AVMQDIq7cKx3e5r66bnsKc7qxOJtY5POc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yesb9voY5rePlJZISbOpyq/PCnUxjt80lo9h4Zm1lBFLAcMSQ8u8v1IAhgf5qOQZBEl8AnRdYNCaqT021RX9gVtEYzlFFbg/VL0CVX1ujxwJ7fuX+h2693y4Wo5KYPGxYhskroqVfFkKFrVXm8hxfdbTEEjlbLYRV4E74MmCqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQ73Dmy2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763399051; x=1794935051;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FRbRfJTFR5AVMQDIq7cKx3e5r66bnsKc7qxOJtY5POc=;
  b=UQ73Dmy2lydtX1pEO2flGcqChWX279hhwEYSuhOTr9DpwVMjuAwb0mzS
   Ju4OKNWvcKmnv9gHLXsBTpktQKF/B6wqT3w8kASPinTEzQmt5iOeCccqd
   lsogNzEyWvsUILsHWiehuZFKhSODKv98sfjdooeJK/2LRkgeE8ZjV/ou8
   eLd90Ys/6uc0/kV0zDjKS0TxMZGNEmYC46q4nEqZ36RyfOJYS7Fauv12A
   aHiMygC/c1y8Vd3w0rSN66CXpxtjR7vwOkZn5A//AipgkgriqyyViZIOP
   4eLa3IFT14HEtsdW/vegNIqhCLxiDQfZMiW5b52uyJi5fVNeEOm/ZSuna
   A==;
X-CSE-ConnectionGUID: E52WOdZBQ7SrtDZUk34VnA==
X-CSE-MsgGUID: zsJ0i7OGROyKGLJxJkBKDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69253677"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="69253677"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:03 -0800
X-CSE-ConnectionGUID: nsJbuTZjSDG4rnJpmOFjwA==
X-CSE-MsgGUID: 0pYo9OsdQQen5Y7qAgoZCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="195445200"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 17 Nov 2025 09:02:54 -0800
Subject: [PATCH v7 8/9] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-rneri-wakeup-mailbox-v7-8-4a8b82ab7c2c@linux.intel.com>
References: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
In-Reply-To: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763398999; l=2732;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=kZxiUfbccXocGJCMBY33QWQ1dcE/RS77GqicHi6UIZo=;
 b=Ey7LB6F8aVrJYDbalvaBYqqcH3QTS980cBALIfhJWRjoeWD60eBKHhkW487ecGUTuu27hYAub
 XGjDXH4L9zTA3WFzxGVtV7iGAdxagFkTcbzdwlEvzcV+KJ7eqZkjMW2
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

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changed since v7:
 - Dropped check for !CONFIG_X86_MAILBOX_WAKEUP. The symbol is no longer
   valid and now we have a stub for !CONFIG_ACPI.
 - Dropped Reviewed-by tags from Dexuan and Michael as this patch
   changed.

Changes in v6:
 - Fixed a compile error with !CONFIG_X86_MAILBOX_WAKEUP.
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Updated to use the renamed function acpi_get_mp_wakeup_mailbox_paddr().
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Use the new helper function get_mp_wakeup_mailbox_paddr().
 - Edited the commit message for clarity.

Changes in v2:
 - Added the helper function within_page() to improve readability
 - Override the is_private_mmio() callback when detecting a TDX
   environment. The address of the mailbox is checked in
   hv_is_private_mmio_tdx().
---
 arch/x86/hyperv/hv_vtl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index ca0d23206e67..812d8a434966 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -6,6 +6,7 @@
  *   Saurabh Sengar <ssengar@microsoft.com>
  */
 
+#include <asm/acpi.h>
 #include <asm/apic.h>
 #include <asm/boot.h>
 #include <asm/desc.h>
@@ -54,6 +55,18 @@ static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
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
@@ -66,6 +79,8 @@ void __init hv_vtl_init_platform(void)
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


