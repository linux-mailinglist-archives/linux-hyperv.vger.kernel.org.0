Return-Path: <linux-hyperv+bounces-5337-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D3AA823F
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B521A460B8A
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD660281365;
	Sat,  3 May 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9WHCtgJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B8280A21;
	Sat,  3 May 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299420; cv=none; b=ZsKi+yxppihKf7NLVi8/GaFNwxV24U0nsTI5ullCTFrBWcaTp2Jm10VTD0aVMhVNOxLxBmRYD7fhMxOQfGUQoi72A8MFFZvxT4SEJVU91e9+CngJ+QVqsbI1WBWq2sBoVVchsHkKlOJ2PyfLcnFmC0NjduHp1sryy51LlBGftro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299420; c=relaxed/simple;
	bh=V/Xkg7yztJbvfzhW1m8IZa8xRkZUWnqLeYD/o43R6SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fUhP2HhygAXGmP2Ic3cR5eamw9K2vl1HUzK7A82A9KDngijxFG4Y1GrBBiGWcK7W855XN1XDKURg4eZntuuXJtL1FHx4UJF7boZoU1a/XCTG2/RvGDKB9Lrp7SBxjyGIT2gJncSfT6xDZiroZFFyuq0Whv5rS4KUrU7dWtyvW+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9WHCtgJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299419; x=1777835419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=V/Xkg7yztJbvfzhW1m8IZa8xRkZUWnqLeYD/o43R6SA=;
  b=V9WHCtgJBnRh9sq8tqVwLiTkXuMns+l2texgQ1u8TphwoD21nTh7v4ST
   54Ru7sa832aB6hipbMHDkIJ+NVBjZ1PVj8hA535uAm19iKn/eJUFTbr0Y
   h/B9DCvTJ9GfvONAoNbrV1Pl7Sub6b179gjRwXerDCgl4auc//qVwcxkh
   0+KPIriUarpBvRrJ02bHdmtnxz1gx19zSTuDAz6lwjPXC67PdNVHaqPpn
   28Lpa3WBBp/Rv7kwuCiYylccAEa/FMwta4Rjg7JcJBV3dHiBRv4gNsH+2
   Xlq2+y6nBxRbFhxvTQhwpSBGdf4ehursGa2Y07asTnAO9ayLwtQljWH4u
   Q==;
X-CSE-ConnectionGUID: KPDJa/4tT8KijalqAdtn2Q==
X-CSE-MsgGUID: fGLSD22zQSm2RzrcW4Oiqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095656"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095656"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:16 -0700
X-CSE-ConnectionGUID: SYXTj6XjTw+94e88nzCb/w==
X-CSE-MsgGUID: DEDs71WMSDm3TeRqzmbe+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046118"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:15 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org ,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 11/13] x86/smpboot: Add a helper get the address of the wakeup mailbox
Date: Sat,  3 May 2025 12:15:13 -0700
Message-Id: <20250503191515.24041-12-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

A Hyper-V VTL level 2 guest on a TDX environment needs to map the
physical page of the ACPI Multiprocessor Wakeup Structure as private
(encrypted). It needs to know the physical address of this structure.
Add a helper function.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Introduced this patch

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h | 1 +
 arch/x86/kernel/smpboot.c  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 97bfbd0d24d4..18003453569a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -149,6 +149,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 #ifdef CONFIG_X86_64
 void setup_mp_wakeup_mailbox(u64 addr);
 struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void);
+u64 get_mp_wakeup_mailbox_paddr(void);
 #endif
 
 #else /* !CONFIG_SMP */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6f39ebe4d192..1e211c78c1d3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1431,4 +1431,9 @@ struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void)
 {
 	return acpi_mp_wake_mailbox;
 }
+
+u64 get_mp_wakeup_mailbox_paddr(void)
+{
+	return acpi_mp_wake_mailbox_paddr;
+}
 #endif
-- 
2.43.0


