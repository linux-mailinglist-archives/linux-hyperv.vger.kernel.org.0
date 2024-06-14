Return-Path: <linux-hyperv+bounces-2426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C8908906
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB951C2606A
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7419AA7A;
	Fri, 14 Jun 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDz+aWu8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349301991A1;
	Fri, 14 Jun 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359168; cv=none; b=tOaxF0V12gWIXphWdxNUC8w12LIdhmToYYxIw9CvaQ+WqMYM4Dw7xOoWKg8gEaEZeLq5YPXDMeGOtjyRPxszxK/D+9GJTZDUn2p7vfQFnkXJXkVAUITcS8GYzl3Na4lQNZpLmlX2Jm+qNx8k1PLL8eicQaVh+c0qmYej2HDan7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359168; c=relaxed/simple;
	bh=DBcJsWV4nfgk/8fw3M6vcKnfFbP1zoB1PzLmLNRfgyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPiw+fdFnHGjCNr/qF+kUuN879dLVr8Atn8d8CE0m2tDzK37XxEu1h05FTZ5VjKZGXIJ0Jue9/YwjbZnpQoaYQbppLiNaCsNx65G9ERHZmoY9I5xLDnYpWtK5uw8zMzLwH8kPSzXD28bu8yIxjPzM304jexnoe37XR4p3NWe9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDz+aWu8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359166; x=1749895166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DBcJsWV4nfgk/8fw3M6vcKnfFbP1zoB1PzLmLNRfgyE=;
  b=FDz+aWu8e9Fe4OwA5zeiOfE11THM/TO+H8WEgd/lDDFEA3fO6Pxgn5YR
   MOfZXnOIXFKXlbafLoNPd0nmPsSWqOMbxovfPIbHWIn11D7Bia2Rl6KWv
   MGY3huqELdQNrzAC6gYe9CDns6k0ku4VBmPWnO9DIf+ly/UB4BlM8E0NX
   KKQYixSkGh/GGzssL+AEXmXYnywJUaVNpjbXrl67xo5lQDNSZvME+GjPx
   wTUB3UM9vodiWkK+6As4cAVIdvQSH40XXZEIJPSq9EHabJsxg6aIXf0mz
   iUC4CXirhlBKdx+vUnEn3B9y/+Cy8JzeLDe0Bl3VmFTKgCDKnVlnnERJw
   A==;
X-CSE-ConnectionGUID: ttZpbPHmTSeMU6J6vlT74g==
X-CSE-MsgGUID: REbD4/apQ3a/J4hmUBeZNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15466715"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15466715"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:23 -0700
X-CSE-ConnectionGUID: M+N+3myGTvOefJC7ibg31A==
X-CSE-MsgGUID: jJfHHzqoS0Ki5Dj5WGpWOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="77930015"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2024 02:59:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2D98D2B10; Fri, 14 Jun 2024 12:59:09 +0300 (EEST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCHv12 13/19] x86/mm: Do not zap page table entries mapping unaccepted memory table during kdump.
Date: Fri, 14 Jun 2024 12:58:58 +0300
Message-ID: <20240614095904.1345461-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashish Kalra <ashish.kalra@amd.com>

During crashkernel boot only pre-allocated crash memory is presented as
E820_TYPE_RAM. This can cause page table entries mapping unaccepted memory
table to be zapped during phys_pte_init(), phys_pmd_init(), phys_pud_init()
and phys_p4d_init() as SNP/TDX guest use E820_TYPE_ACPI to store the
unaccepted memory table and pass it between the kernels on
kexec/kdump.

E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
be required by kernel to function properly.

The problem was discovered during debugging kdump for SNP guest. The
unaccepted memory table stored with E820_TYPE_ACPI and passed between
the kernels on kdump was getting zapped as the PMD entry mapping this
is above the E820_TYPE_RAM range for the reserved crashkernel memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/init_64.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7e177856ee4f..28002cc7a37d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -469,7 +469,9 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pte_init(pte, __pte(0), init);
 			continue;
 		}
@@ -524,7 +526,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pmd_init(pmd, __pmd(0), init);
 			continue;
 		}
@@ -611,7 +615,9 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pud_init(pud, __pud(0), init);
 			continue;
 		}
@@ -698,7 +704,9 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_p4d_init(p4d, __p4d(0), init);
 			continue;
 		}
-- 
2.43.0


