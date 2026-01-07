Return-Path: <linux-hyperv+bounces-8185-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F6ED00376
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D35430082C1
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25A339878;
	Wed,  7 Jan 2026 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpkY4JnE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A532471B;
	Wed,  7 Jan 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822371; cv=none; b=eunJ+zmLa59R7uEiI/mwUk3vBEi2uRr1GJ7jXbQqqz/sbwselzLuyAUx11miVVaDk5w9xJwlcMihbwaRqxgQn/4wUWQXnjcweqmKEATmlgxOJyvfpk98RMoOgL0Ty4PonWr7sRW4MXGSNXTU2s4Pc4geaxc2szGgACzXvxk7vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822371; c=relaxed/simple;
	bh=6AqCFd+n9vdOElKsZfxWCAHJLMVmS2IBiiIVkC9FHXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIQrFEqtI1aXLF35N+tLV9s19bsg9M6WtnzKyIcYKtQerEVUXM+6k5Z7XScH0x03FKFi7ovaDwfxSnq5kWaS7TAvTsb8kSAhcJoQCYZEn8M9wLI6tK9oA11I2Fp77RXS/1BnkjpiOLzx4LcrB0srfrYJ/gpRtda+QVqE3hOXv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpkY4JnE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822369; x=1799358369;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6AqCFd+n9vdOElKsZfxWCAHJLMVmS2IBiiIVkC9FHXQ=;
  b=KpkY4JnEZuqjtPX7OoDP8xrqnDS5j4++X5wNsYj5524SNFg0nCGCbwE7
   NorDDRJWLu/1MT2MtawkZvXzcWWWAbCBSE7T0Kdy9r/X3u3+CELLD+INX
   bEQg2v1puUN9hGTwwH0/yyIkRWiDT+E3znuWXkVt15vx/dU/ekRxsLIQQ
   GF3d1YjMUy8iDNFBS/oIUpZQtzYE2taCWX6XjZ6dyu9jrfuhBLx+djAEf
   F/LKcJShdEl0wlgUG12g13c++dDcvBK2PyjQTeauD5YtmOKr98ouB6Iqx
   0iPS3em82qCysApFqKESDkpwdx5xducSchDZorrOkLv36Y9IhaHPjE1Lg
   Q==;
X-CSE-ConnectionGUID: RDPLZt/gQymkiRjNXFpnwA==
X-CSE-MsgGUID: TbBCftuKQresredyje9M1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359306"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359306"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
X-CSE-ConnectionGUID: clzWEqIRTM2fFPSA1GgUKA==
X-CSE-MsgGUID: ql5PQ8wxQgeOjPO8+qmBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510927"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:45 -0800
Subject: [PATCH v8 09/10] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-9-2f5b6785f2f5@linux.intel.com>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
In-Reply-To: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=2880;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=kjCB4miB0DwMRU0Ssua6vnQm6QUYmHXEZjj940X/k1A=;
 b=IsyeU6Ml8SpVtTl5bGpaN5gY+iub0LMs3HiZpvU/bdnjBsECl7n3Uy1fmLoi2OF8aDQaEguUb
 V76WgsFuTIkAlXgF5E1WaX3fbqXu7uWzFwCHE/S0N6einmonT1mbP9o
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
Changes in v8:
 - Included linux/acpi.h to add missing definitions that caused build
   breaks (kernel test robot)

Changes in v7:
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
 arch/x86/hyperv/hv_vtl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 752101544663..2af825f7a447 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -6,6 +6,9 @@
  *   Saurabh Sengar <ssengar@microsoft.com>
  */
 
+#include <linux/acpi.h>
+
+#include <asm/acpi.h>
 #include <asm/apic.h>
 #include <asm/boot.h>
 #include <asm/desc.h>
@@ -59,6 +62,18 @@ static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
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
@@ -71,6 +86,8 @@ void __init hv_vtl_init_platform(void)
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


