Return-Path: <linux-hyperv+bounces-7636-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E430C656CF
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 895E3361815
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5F9340D87;
	Mon, 17 Nov 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQqqhPrN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392A33F379;
	Mon, 17 Nov 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399051; cv=none; b=YTSeUlxHycgDBioYN4lKL9f00qBZjkRcBGUYNw99gO3VuYREbqHU50O3Ly0sJfopDg8gqwXmTpR8vIHAt4onjEwAQjJcqO5y1YBj2PesCcCV+llZJNVeXhR3aB/Bl4shGwyZYdLlK/+9IFzLXpo80zjr5oAGJFNVptmIYV9pdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399051; c=relaxed/simple;
	bh=4R7LgMkRG5wJg2Ahbn+7dl/q4jcDQhLIjGU3Bl7isGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8wblRqXoqVuD94FsPmv0otv/el5Zqksq9lCkjK4Os5gspkwjpvY+b5UvHBKHGREPQTVeFqrKoef0HE9flvei5P7SzZYi4P0aYdCj4Dpc6AaFRvZ5spQ25WqtduZG4lNLDZuYNvacdRaCsl/JtWIs/5nBYTVif7doTJ/tPrWlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQqqhPrN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763399049; x=1794935049;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4R7LgMkRG5wJg2Ahbn+7dl/q4jcDQhLIjGU3Bl7isGo=;
  b=nQqqhPrNaljON2YGleFKPjQ4pEHuRRoPVBcVm4Z1UBnmmH9qzi1egKdH
   sNmQT4za8pCV5JdgPCNuqkBbLZpKv1y969QUdrmQDsUnfxfTPOZGWUtpT
   bLhLvOJcLkZeu8rv+T0ZITOm7m/cj9dAEieMyRh7HSFKtUAhmX+NZxDY4
   4Nf2J58svGyrJlsR/ATPvj6z9UxG1ncbublT7Xk9f7Q3J+xDJBGvqlX1V
   u/9FjejCJS+n/RzcGfWgG1m+ivqNMKIvVWfNuPKtVm16JMF6EgAR99AP9
   cpMsX6svehdddPm++kX9DuRggilQCxbnaEpUhJMqx5pPSSds4P0zzkz35
   w==;
X-CSE-ConnectionGUID: 3kXBKmNTQmWj0ycxSkhPBQ==
X-CSE-MsgGUID: Mm4jk0BcQQiyx5nwgL4gAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69253673"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="69253673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:02 -0800
X-CSE-ConnectionGUID: NXq6yhtdTVW/kc9h/xYzUg==
X-CSE-MsgGUID: xTZtYLSuQm2uFNfBPnVBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="195445197"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 17 Nov 2025 09:02:53 -0800
Subject: [PATCH v7 7/9] x86/acpi: Add a helper get the address of the
 wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-rneri-wakeup-mailbox-v7-7-4a8b82ab7c2c@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763398999; l=2194;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=4R7LgMkRG5wJg2Ahbn+7dl/q4jcDQhLIjGU3Bl7isGo=;
 b=hwMPtBtasp6xE9Vp+UUnIulXQakGWFrUb5FM38R8iqAE+DKtlOv1kHREYb49rXuucnfflmWOE
 lCwileUX7EACqFuSqknGHHF/FOKluW2fVKOxdLc9/KYSWtt69wk6xDv
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

A Hyper-V VTL level 2 guest in a TDX environment needs to map the physical
page of the ACPI Multiprocessor Wakeup Structure as private (encrypted). It
needs to know the physical address of this structure. Add a helper function
to retrieve the address.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
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


