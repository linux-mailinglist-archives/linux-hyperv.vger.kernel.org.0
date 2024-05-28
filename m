Return-Path: <linux-hyperv+bounces-2242-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B078D17D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31455B24B04
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4016EC0A;
	Tue, 28 May 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ9A+RPc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCF16E867;
	Tue, 28 May 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890159; cv=none; b=Ht0x49F9QveJvlQgHOSj7d1hO/DzvMA1ootD79eMNopsGu3Vd/HZnuV6FJKgjr/VkQhNbU0pC9aIdxyZETCnKDYoyqA4SJnfOL9ohWCPSdcbIikByfsU9NWKBFoRNai5f1ip5YTWQUZ9Mqicy1gIeuh/RaLbsQvTOlLbfVp9wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890159; c=relaxed/simple;
	bh=pNTsKqVQk55IiCN9cveVl7AHQE6wlgXgaA9ysVM35AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA1/cZayh4CSikCuy5n7JAFS5MyFdXjZ0w1sbgdLWZiv6O07vomFqwiAWO9rocMXlMxUWloZjb80uhRuGFIS3V96hEc8vRBwtwT0XPzY111EVFBLjsVFCm7RqjPSKnk5p2wMstLSUFSHvZ+wslD4M6ZD3Synknp+0lCWmC25pks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ9A+RPc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716890158; x=1748426158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pNTsKqVQk55IiCN9cveVl7AHQE6wlgXgaA9ysVM35AI=;
  b=ZJ9A+RPcoYNEb9+FdhIAkV7Y+PtJ2jTeET4ESvxVM4k/kIiAXibKtbgO
   M2O7XZsKGJGYD2vOkyM90q7awRgRcq7q4jww86UExEFfhUEEXq94/OMiD
   EcDuGBIkOYi2Y5BfxGIZ60QMHmvT5elABwraUhzWEYWd9XUFHwh2vji2L
   2M1O6oWZC1ZCG3tSisfoJoF4n9SExrRdg+2D3rieBS0UWSCd2YkO0Xrfi
   KdwwfS+MY9ur8pLClrXg1jLqR/wU7/BWBwJdS0M8vGosSRoYLB07AMpTw
   Gy3Ecc1YIeszP2KuX7N3QTKjw6AcxbbSgVCGI7UNEYRZ61ucQy7iqow5I
   w==;
X-CSE-ConnectionGUID: zut6+ZFsQRqzC9jFSszBIQ==
X-CSE-MsgGUID: HxIRkU/dQMyBhSWYBzf8lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13172243"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13172243"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:55:41 -0700
X-CSE-ConnectionGUID: zDIPCTM4R9OY5MQtlQjkcQ==
X-CSE-MsgGUID: po0/KbjLRleRGWauHTotJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39984759"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 28 May 2024 02:55:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F164E909; Tue, 28 May 2024 12:55:26 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv11 14/19] x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
Date: Tue, 28 May 2024 12:55:17 +0300
Message-ID: <20240528095522.509667-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support MADT wakeup structure version 1, provide more
appropriate names for the fields in the structure.

Rename 'mailbox_version' to 'version'. This field signifies the version
of the structure and the related protocols, rather than the version of
the mailbox. This field has not been utilized in the code thus far.

Rename 'base_address' to 'mailbox_address' to clarify the kind of
address it represents. In version 1, the structure includes the reset
vector address. Clear and distinct naming helps to prevent any
confusion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 include/acpi/actbl2.h              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d222be8d7a07..004801b9b151 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -75,7 +75,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
 	cpu_hotplug_disable_offlining();
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ae747c89d92c..fa63362469aa 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1194,9 +1194,9 @@ struct acpi_madt_generic_translator {
 
 struct acpi_madt_multiproc_wakeup {
 	struct acpi_subtable_header header;
-	u16 mailbox_version;
+	u16 version;
 	u32 reserved;		/* reserved - must be zero */
-	u64 base_address;
+	u64 mailbox_address;
 };
 
 #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032
-- 
2.43.0


