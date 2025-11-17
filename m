Return-Path: <linux-hyperv+bounces-7629-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F0CC6560B
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id ADC702AA74
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182930CD95;
	Mon, 17 Nov 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2usAj6e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBE30C603;
	Mon, 17 Nov 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399045; cv=none; b=M/waY4dXPDW0Ee2KfQ8t2zjHyGlK3zot1AIXFGKaHZYtsv+ImnptM2MxKE/54x4BVJ1scNlBOJWa0poOi7oAB1dWqjrYlp7dXIOOXo/iqW+puDca8LIffromHM6dAk019VxEC7ouWZ40sAAzOcSu5tp1yKykBkinR3Bye2CWcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399045; c=relaxed/simple;
	bh=jfDFGm1JQBFAv0lknTiR+fGMBLG9xKp8BRi0BuGqsT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7bJf7dnurT201R70eEUwkZJd9PwBitW4Nsn863V73vDmqSpXv9BP3LyhTRM7AsjVsoAeXJzT1Swh/+OToqOZtnGw3GCpY9YijCA7GeLv3Xf2ew8lKU/CLFPwMqsXEVMQcpvovgoF1flGx2lpkYaXXRwtY7xZHz48sOC5uOXtuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2usAj6e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763399043; x=1794935043;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jfDFGm1JQBFAv0lknTiR+fGMBLG9xKp8BRi0BuGqsT8=;
  b=d2usAj6e9u7vaDZHzjSigPVD0ImlEs+kv8nIQfgmL1fpwNBVCIVNrP6Z
   PPPqsALpBC/Yw7Ps7T1AqbZx3YM5mJ8oAHDzx323cSoqbC9hEAtJjrmgb
   w0Wj+kagq4IFCxGZk9VjB0g4WWBAhqdTosWbJA7+xQluaOFlfweCVQ9Xe
   0hQOl3SZMqme9WPmPlfpHnEWuV0clks2vhGlWAR5St1BhbdSq8psZX1dk
   cyQaLwiHSdodmrWOvcAcfwa2HXIhSG7i7tkAN/H4gyeRmaoNXXlNJkAk7
   W5zBAwOcARn7hJpbCbum+8NEyv9KdZQbwCRqv+Ys7GH728JVWUwLE+H0f
   A==;
X-CSE-ConnectionGUID: 3tbYLBpRSeabCXhyHOX8Mg==
X-CSE-MsgGUID: nniIbfeaSQiLKWNiYRs58A==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69253638"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="69253638"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:01 -0800
X-CSE-ConnectionGUID: iOXDyFimQ5aKT7QpxKhLEg==
X-CSE-MsgGUID: 5qYTIB5RSGyiZK7crcLciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="195445170"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 17 Nov 2025 09:02:47 -0800
Subject: [PATCH v7 1/9] x86/acpi: Add functions to setup and access the
 wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-rneri-wakeup-mailbox-v7-1-4a8b82ab7c2c@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763398999; l=3044;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=jfDFGm1JQBFAv0lknTiR+fGMBLG9xKp8BRi0BuGqsT8=;
 b=ZUmWD/ItY6KcHAS/APAhvjsEjKEZ1u4qaM7PMQCgP4XSBeF6kD+8KE9YC0Yp0paICrGY5ZfoV
 s4hV1mE9LTUCvLMxQAjiJeTRk4dE8BjQU9iBoNkitYWvqdeaXkvzhUc
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

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
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


