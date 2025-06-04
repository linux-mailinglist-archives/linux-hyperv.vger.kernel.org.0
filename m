Return-Path: <linux-hyperv+bounces-5737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF99ACD0A2
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A85F3A737D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53514D2B7;
	Wed,  4 Jun 2025 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J93voas7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20C7261C;
	Wed,  4 Jun 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996288; cv=none; b=OP3JzaLnaFF+U6vRO3yXWy4Zz6cuzAFQIxKi5jPPSOlPge9N0rLWEcWJWOEVeq2XpZbgt/Y5Eu47RuTk2/GCfZml7oa8oA5NhseEl2SSmSXOqK4jTpvQmbcPA8hWylRlPvPfX/h5jiuPosiLv7ZJbZoUXyLpGSbJyuk34LJIqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996288; c=relaxed/simple;
	bh=V4sR4hWtPVMZ3ywoOFOkbkpBj99xQxKorVINhU2PHmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeOpsDnQWLA9zUsUoPM66oJj2GfVpVAu+lCj8mRxytF+XuM/FjzDz/cckZUbIlB8ppFiCq+Mym1PyTxyQinI9ikpaVzmk7AJJ+FDSaKjUikEl+x8xDkwt/HUFMtUeDUsYUk+E/o2u43JjozdH9uFTFGyHjAEJMvgNd2x76BUzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J93voas7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996288; x=1780532288;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=V4sR4hWtPVMZ3ywoOFOkbkpBj99xQxKorVINhU2PHmw=;
  b=J93voas7xz+e/dLn3+jO6thWXtyb+4jYMA108VDkpvnTzOlXHznZkM2g
   y1rOrFmtjgpiEv+VFoMQow/IUiFLrgtRuAUcWlnRE2Tx3peFALyuHezGR
   aMcPzXqxq6gI6IU/n+Z33DUIXeqcxm+B3DESIPgpuuE0jPy5nlH/cuP9s
   98hALq12W5Hccvbge3erajDWAxTVM73veGUg4mrWC1KXKsmsqo3k8pfm8
   M0Pm7CH8QBx2VmtHHm7fm0nr/Mnpphu+BZM2DrI6au+qlKK8cTmKKB2hW
   WZrmA2KNIsVW14qw4sRBFQ0vEHLRqL2Mgslloyz1FmQfzPAC5heQoplIR
   w==;
X-CSE-ConnectionGUID: IdJP7aNFR+qa62rIc+Rscw==
X-CSE-MsgGUID: x0bSJUzxQPK5PaeZ3Ww20Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112969"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112969"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:02 -0700
X-CSE-ConnectionGUID: 6YWKi+xaQEibtUd3ry2T2Q==
X-CSE-MsgGUID: va9ZTG5wTDKXle8JBnGjBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904480"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:20 -0700
Subject: [PATCH v4 08/10] x86/smpwakeup: Add a helper get the address of
 the wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-8-d533272b7232@linux.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=1666;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=V4sR4hWtPVMZ3ywoOFOkbkpBj99xQxKorVINhU2PHmw=;
 b=YbzLXOrL8hy7jvbbqW4L3osjtuRhbSMmRT94LsT01Vh/TDKPLYC0KwlfS0L7vAp0K0UmNuoaX
 SlZyoAkkZbPA3rMXeVf/r6Oywxko8sgCM5ZUMkfv6Ziu8nhoyWeELmE
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

A Hyper-V VTL level 2 guest on a TDX environment needs to map the
physical page of the ACPI Multiprocessor Wakeup Structure as private
(encrypted). It needs to know the physical address of this structure.
Add a helper function.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 - Renamed function to acpi_get_mp_wakeup_mailbox_paddr().
 - Added Reviewed-by tag from Michael. Thanks!

Changes since v2:
 - Introduced this patch

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h  | 1 +
 arch/x86/kernel/smpwakeup.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 77dce560a70a..158e8979342e 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -148,6 +148,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 
 void acpi_setup_mp_wakeup_mailbox(u64 addr);
 struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+u64 acpi_get_mp_wakeup_mailbox_paddr(void);
 
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
diff --git a/arch/x86/kernel/smpwakeup.c b/arch/x86/kernel/smpwakeup.c
index e34ffbfffaf5..1d24ca97bdf8 100644
--- a/arch/x86/kernel/smpwakeup.c
+++ b/arch/x86/kernel/smpwakeup.c
@@ -81,3 +81,8 @@ struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
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


