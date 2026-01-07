Return-Path: <linux-hyperv+bounces-8177-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47DD003A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B6B5305383A
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01653019CD;
	Wed,  7 Jan 2026 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5eS1ior"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB22FE566;
	Wed,  7 Jan 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822365; cv=none; b=SxiVmHpliVScc57bs3quskaTPVxFWT3OvK/Uo2BndU645A4nlcS8cNIAVmtToJT6oSUeglwctj/d2UOxXbvJL7UeQHxMZG+NuhiA+QsqibsoOL1/xDMjisZaWbRN1kZWucdbZqqy68JojWdEEikmFUu6IjFuL+DVxbcuB4lKUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822365; c=relaxed/simple;
	bh=qsylEiZMnDxF0pG7XJNnK9yxlJ9rH0r3W6wRkR6FHv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RV1Posqi+J74UA7oyCsGlL5Ku0EV0bM+Jy8j+YFxDWdOQRSGqumTQro2n10aHxr4XHysfxHfBnVjTCtdKiZLGrjm6wD7hfZHVxw3ozLp3XHXQWa+Ua020iu1F9M5/LQG6r3g9pKpspD2sz0HoGm7LDQItO9klIp0lXKBLDouKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5eS1ior; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822364; x=1799358364;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qsylEiZMnDxF0pG7XJNnK9yxlJ9rH0r3W6wRkR6FHv8=;
  b=a5eS1ior+e7HH3fkwkfcBrErw6WaPqHCMgOypszfnBlSObCrb5SjqNfl
   1ROhKJpiCXhMbRY9Nm/USyo2uAyBcLA5O1PuJ2W1TsbgoO+WaRhj7e+L0
   9nYwzTilMomh/cmwAk3EkzfDDwf8l4T9eiYLpXgVhR4PB0QFJZvvQP4wI
   qb1ANRp6OwjUFsb95Cl6/5KoWsRpuhERzvVmTjAxl59iT2nCYmNb+XDFh
   VGArrlqIfQ8tXFZke3dK7ktBKa1CHuzTTlaj+KKzTIwPE20fcFkXhpM6i
   ZjI/I7VGUpaZOAzODje1NQUZWC/TvpzIZiOqonHUOpzjtxwU/sE2kcxrW
   A==;
X-CSE-ConnectionGUID: CUH2C1E0Sye1BaggwN2Xpw==
X-CSE-MsgGUID: 6O6uBkWFSICzrVYThkPgoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359274"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359274"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
X-CSE-ConnectionGUID: nCm029DUR1SRzCiq1IpC5g==
X-CSE-MsgGUID: NIGwZLpWSkyRArrvMxXQMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510896"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:38 -0800
Subject: [PATCH v8 02/10] x86/acpi: Add functions to setup and access the
 wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-2-2f5b6785f2f5@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=3163;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=qsylEiZMnDxF0pG7XJNnK9yxlJ9rH0r3W6wRkR6FHv8=;
 b=8SBhZoOGv5eia+5DgOGyokViV8LLjJQp5LuTqFuyBsUd6prxJR7DHFl26g939x0vGklGBLiuy
 b5NOXNb81IwCcJNTc6upOl2UKe01BYcqR/wVdzSgHufCeI2wdu0ecHz
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Systems that describe hardware using DeviceTree graphs may enumerate and
implement the wakeup mailbox as defined in the ACPI specification but do
not otherwise depend on ACPI. Expose functions to setup and access the
location of the wakeup mailbox from outside ACPI code.

The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.

The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
mailbox.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v8:
 - Added Acked-by tag from Rafael. Thanks!

Changes in v7:
 - Moved function declarations to arch/x86/include/asm/acpi.h
 - Added stubs for !CONFIG_ACPI.
 - Do not use these new functions in madt_wakeup.c.
 - Dropped Acked-by and Reviewed-by tags from Rafael and Dexuan as this
   patch changed.

Changes in v6:
 - Fixed grammar error in the subject of the patch. (Rafael)
 - Added Acked-by tag from Rafael. Thanks!
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Squashed the two first patches of the series into one, both introduce
   helper functions. (Rafael)
 - Renamed setup_mp_wakeup_mailbox() as acpi_setup_mp_wakeup_mailbox().
   (Rafael)
 - Dropped the function prototype for !CONFIG_X86_64. (Rafael)

Changes in v3:
 - Introduced this patch.

Changes in v2:
 - N/A
---
 arch/x86/include/asm/acpi.h        | 10 ++++++++++
 arch/x86/kernel/acpi/madt_wakeup.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index a03aa6f999d1..820df375df79 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -182,6 +182,9 @@ void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 #define acpi_os_ioremap acpi_os_ioremap
 #endif
 
+void acpi_setup_mp_wakeup_mailbox(u64 addr);
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
@@ -200,6 +203,13 @@ static inline u64 x86_default_get_root_pointer(void)
 	return 0;
 }
 
+static inline void acpi_setup_mp_wakeup_mailbox(u64 addr) { }
+
+static inline struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_ACPI */
 
 #define ARCH_HAS_POWER_INIT	1
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6d7603511f52..82caf44b45e3 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -247,3 +247,14 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	return 0;
 }
+
+void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
+
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
+}

-- 
2.43.0


