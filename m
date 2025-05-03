Return-Path: <linux-hyperv+bounces-5327-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BFDAA8216
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AB81B60C0D
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204627E7F0;
	Sat,  3 May 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAll8NmU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CD27E1DC;
	Sat,  3 May 2025 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299413; cv=none; b=XqQYHIxcx4Sw0pLiGi2qhqx+OlIjeEhgF8auj9D6nKpSjxJrl12bgeCLXQuBstzE4VufR2WtAqrSSzGECY9ixG27Yzn4bhfh4McT4vV/NPzm/6sIM9eu7jtUHT5lZTDV0Um6nARhCdTx89RzqxlTtfxph7knEipQxaseQp2Lt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299413; c=relaxed/simple;
	bh=v4Qdkyf8Y3iGQ05r5Hs38Sy/RlRbceKXnRy9fjwloE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BXsvhdHZ3kIXPTFRLO06ZtxBNEIAp+6hv4gpu9BzIpa6po/a7raCyjN9Llu1E7YYa+5m9aebEmUY9bxzoWoLryaobreiXFQlYkMMTg/n/nPKKSDmYGENe3jDvIS2DLwc1aC+Tgw3dxpu22skmsrEi6ZvTouolhM/c5QfQbDMRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAll8NmU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299412; x=1777835412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=v4Qdkyf8Y3iGQ05r5Hs38Sy/RlRbceKXnRy9fjwloE4=;
  b=YAll8NmUFmAOEw3aT35yY8ypWHVm5yvnnEQrP0BA+BDoat1Jl/3deARo
   0x8sgpMvJgFttW5U+nBH4G1a9+IPfXamNpW8cqY2zYP4QWhTIRgIg7yw7
   94kYuaLz9pWlRcrY7gCwdlJk4pSuP2eIhfmc6sG0WzO//arqIrrjg9vi8
   O1o18bUz+LQhZf53+e9PLddDZS6UPFp5ur8n6XkkkNRfrwVDNYkMVWEie
   8IeGlwowrGuE9/i3vZUSy+YjCdYju7yYe0Pg8sk8w8DWBbZFKvZcH5eQm
   4XOyXpP9zanmUBFTAwZmKCXJFgjrAnnX7K70PfG70ZHv/JAn3r1HzuBM/
   Q==;
X-CSE-ConnectionGUID: eTJ9ddaUTu2TiHO4ktGgNA==
X-CSE-MsgGUID: anHjMvW/Tdalu6VPCpk47Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095604"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:10 -0700
X-CSE-ConnectionGUID: 3l3QVmyPRi2Yvw4UWZsr+g==
X-CSE-MsgGUID: FHmJDk/kRXWQ79jZnLHYrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046082"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:09 -0700
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
Subject: [PATCH v3 01/13] x86/acpi: Add a helper function to setup the wakeup mailbox
Date: Sat,  3 May 2025 12:15:03 -0700
Message-Id: <20250503191515.24041-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In preparation to move the functionality to wake secondary CPUs up out of
the ACPI code, add a helper function that stores the physical address of
the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.

There is a slight change in behavior: now the APIC callback is updated
before configuring CPU hotplug offline behavior. This is fine as the APIC
callback continues to be updated unconditionally, regardless of the
restriction on CPU offlining.

The wakeup mailbox is only supported for CONFIG_X86_64 and needed only with
CONFIG_SMP=y.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Introduced this patch.

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h         |  4 ++++
 arch/x86/kernel/acpi/madt_wakeup.c | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 0c1c68039d6f..3622951d2ee0 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -146,6 +146,10 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 	return per_cpu(cpu_l2c_shared_map, cpu);
 }
 
+#ifdef CONFIG_X86_64
+void setup_mp_wakeup_mailbox(u64 addr);
+#endif
+
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
 static inline int wbinvd_on_all_cpus(void)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index f36f28405dcc..04de3db307de 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -227,7 +227,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
+	setup_mp_wakeup_mailbox(mp_wake->mailbox_address);
 
 	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
 	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
@@ -243,7 +243,11 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 		acpi_mp_disable_offlining(mp_wake);
 	}
 
-	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
-
 	return 0;
 }
+
+void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
-- 
2.43.0


