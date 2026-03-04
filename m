Return-Path: <linux-hyperv+bounces-9146-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECqcGibEqGk2xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9146-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:45:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C246C209169
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F46A310DDA2
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6463A874F;
	Wed,  4 Mar 2026 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqoP30BM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA339FCC6;
	Wed,  4 Mar 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667756; cv=none; b=kll1WwCFxSMTOATS2PnysDPYKDkx5SCDdl1iGW/OjPFaizD/pFXnp4hgDhqR67bWE/9Nai80FxF5iM6RJGQKfEhNWMFDWqHjVOZbYbyHvHJ9q8Z9OVI0EIQT0KfYbfNfFgJhaLbGqBJ7CGGyJYlGwT7SORO7HIDkF508pT2jLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667756; c=relaxed/simple;
	bh=ypGU+Sc9IMTeMy+CkoquJKf6ONAvdn2Y3tywEbk/UAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtlObMd0Gv22imu8mkztmSA80wWBKA38N75rJcP0bX574cEmWd2cH1R1ZTjqnkloUKYRcIpvjb78Z/klji75B4b1dEKyPrxiEbHIzvtfhCAM4mpubvp7V+xrpsZFUl3D7nW+f+6ynv+sMBRYyM2ELOHaSxRsXBksDk5cRVdVah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqoP30BM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667755; x=1804203755;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ypGU+Sc9IMTeMy+CkoquJKf6ONAvdn2Y3tywEbk/UAE=;
  b=JqoP30BMAbRIJN04oEfmBtFjVYu2nLHql27/W+VJmRxOcVo2DiLpASzX
   gV6umhURQ+6Bsp+HM6KAMgsnGDBS1NTDd3IwZnrmjkZLbfG691SCuL10s
   F6aJEmmC5lQAe7NMScpqVIRiSDpwK7UMCpRqDJuwCnhjkXGRNiq9Y6uLN
   VWj1wVU3ji4y2OO4dBW98UAhxkwVtGXVM85Fjai3Y9sq90nSClLEk9+GC
   bQwVrSgqVwreTPUszsU3N5UkgQ82oQLU+knbRC/DgrxJerKy7oTlMN7nb
   XoEJ5fMWKvzTyEYYBIvFnpVhwPzIoSzRMTvXdIXDnUSZ+ilnOpoGiWHvv
   Q==;
X-CSE-ConnectionGUID: 59doAzelTrmbDydIbr2tMw==
X-CSE-MsgGUID: 8+lyaS+MSHS86iQk1RaCHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359401"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359401"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:30 -0800
X-CSE-ConnectionGUID: dwHfYddrSNGBwzHAyt858w==
X-CSE-MsgGUID: A/DFWrCHSjKvdyE6Zh3oTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376922"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:20 -0800
Subject: [PATCH v9 09/10] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-9-a5c6845e6251@linux.intel.com>
References: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
In-Reply-To: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=2907;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=VnyoIBcxvAxhgqHs1GCVfBflQlo5uE8gnhBmcNxKAEg=;
 b=knZOuLVG0k9i35fc/VsP1qPjv4qFzbZ855kdi7NQoyFJvDomMRDddLfW6T36fJouBcB9/LWFf
 Fs/qz5d3QctAYorAvawXk67hKLAss+OLVslMQAfV66X+VLQ6jW1byNW
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: C246C209169
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9146-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

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
Changes in v9:
 - None

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
index b94fffa67312..1e2f5b3ea772 100644
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


