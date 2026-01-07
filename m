Return-Path: <linux-hyperv+bounces-8184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D8D003E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16DAF30BD6E0
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB7337BBF;
	Wed,  7 Jan 2026 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aENHfmdk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8B31ED68;
	Wed,  7 Jan 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822370; cv=none; b=Ec+kJij+L15kFsAQOQR/7Cby+l4MwiEGM1b5Ng9xuJb90bChlGWl7qzF6J8udyJqT6vRBtrEK2NXmDRrvNxWIiSEqByDutwuzZQqx+ox1OSsiAiXSvAypU7nAmdzfPQqx4tlLBZoaty2eqixhwjGLIUq1aZ1TwcU2MO0hYkL0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822370; c=relaxed/simple;
	bh=75gXCNmWgP9UCQ6UxMfu7Sl0kTqwUzmvTWLhZ8xynLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFy5UDaIoHKZ4VBgzzyLewq8FmqXOFZV/9/m/zTDIqoCb1QVRs2pM3+U8feGJru1pokY0Yv+Suv5583CW83StAsPtTpe1Oc9BZgZA15q2NQxdcMs0ZyxJmzlTy+qBQYynCH5GHlPLky3yriaM0PtbseNfzej1yxIQLwWx0Qi7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aENHfmdk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822368; x=1799358368;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=75gXCNmWgP9UCQ6UxMfu7Sl0kTqwUzmvTWLhZ8xynLc=;
  b=aENHfmdks903tqhm/PcqaRkZl8Op8dSLqeDfzuPAoP8u2ZfucIY2E8c5
   suucaFCnnGz7l4PnN02WDKxO2jgQsAjQbGmRWFhlXZWqWyTuAU0BRLXIQ
   CyIQmpdt6r5EC6Lkks7Ug4Ip5FZgF816lVPu4D0xz9jX/5482KQT+fwJQ
   cxgE4s0yi/7RuQFZ2zxQ5XdnnU4vvGKwDs4BX/xGitdD+Mri0oQWqEwIo
   jS0F0GCEHpuQbozOzaAI5UDgseJyD6EEnlq9sN7CcBzq4Fo7CMnifdcNZ
   0p16r/YPUtrdJvYCVWuyXPB26gqobxiOfZYUePl6aZAcla3keEnF2xczO
   w==;
X-CSE-ConnectionGUID: P1ZdbrlQTOugFqZy+Q4QUw==
X-CSE-MsgGUID: /JdPCQHxTjW3Ch/5t/iEew==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359301"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
X-CSE-ConnectionGUID: jtyQX7f4R8yD8KlmOHJhww==
X-CSE-MsgGUID: B55a4nvUSWay4eYq2HJcaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510923"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:44 -0800
Subject: [PATCH v8 08/10] x86/acpi: Add a helper get the address of the
 wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-8-2f5b6785f2f5@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=2313;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=75gXCNmWgP9UCQ6UxMfu7Sl0kTqwUzmvTWLhZ8xynLc=;
 b=DQTPnGDhVwgmiG7/0cA/L4oc2UHvc9RSwGoqs/04eMnozRkAXukWXM11mGN2y4wZPdRBI6P9d
 1lAsIexyXDgBSdFSRty+S61PrrWwWVndnemGPybQuYrIhGt8rqNr3/I
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

A Hyper-V VTL level 2 guest in a TDX environment needs to map the physical
page of the ACPI Multiprocessor Wakeup Structure as private (encrypted). It
needs to know the physical address of this structure. Add a helper function
to retrieve the address.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v8:
 - Added Acked-by tag from Rafael. Thanks!

Changes in v7:
 - Moved the added function to arch/x86/kernel/acpi/madt_wakeup.c
 - Dropped Reviewed-by tags from Dexuan and Michael as this patch
   changed.

Changes in v6:
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Renamed function to acpi_get_mp_wakeup_mailbox_paddr().
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Introduced this patch

Changes in v2:
 - N/A
---
 arch/x86/include/asm/acpi.h        | 6 ++++++
 arch/x86/kernel/acpi/madt_wakeup.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 820df375df79..c4e6459bd56b 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -184,6 +184,7 @@ void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 
 void acpi_setup_mp_wakeup_mailbox(u64 addr);
 struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+u64 acpi_get_mp_wakeup_mailbox_paddr(void);
 
 #else /* !CONFIG_ACPI */
 
@@ -210,6 +211,11 @@ static inline struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mail
 	return NULL;
 }
 
+static inline u64 acpi_get_mp_wakeup_mailbox_paddr(void)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_ACPI */
 
 #define ARCH_HAS_POWER_INIT	1
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 82caf44b45e3..48734e4a6e8f 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -258,3 +258,8 @@ struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
 {
 	return acpi_mp_wake_mailbox;
 }
+
+u64 acpi_get_mp_wakeup_mailbox_paddr(void)
+{
+	return acpi_mp_wake_mailbox_paddr;
+}

-- 
2.43.0


