Return-Path: <linux-hyperv+bounces-5331-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93302AA8227
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CD21B60F78
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52B27FD49;
	Sat,  3 May 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKoA87e+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815327EC98;
	Sat,  3 May 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299417; cv=none; b=UaSDebP5zTPFyrSfhQbJLiNutfuVTImmfCwzDkLm13ARB+0V50JSggM+otanbzdRMLKUlLlsn4Mexxc+YusQv1lBcSeHoCUzu1dt3i85BPAVtUsio8lGSh9eFhL14eOM5QqCAFCEguI37kUADDSzfIG/YPFnOljvUCf5aNe++IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299417; c=relaxed/simple;
	bh=BaLb2QakL7PuMfqddKhuZkTxakaJyY5sp9hXxk46Dug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e35mlDlGdaOPNy6H1syzda66IiLLwtF8XiQHXON1xde0rAlRW8vC6ZzWigjiOFz6eCe6Oa40oPrSPQ6SCwmOjq2nRiX1FiXqZW+acJm+sJYF3v3CEE+ViGJhNZ0pid4Fgh3QjgUlNBIsdlxJCC9Qm0ZA4MCV8C/ov9bc+weOZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKoA87e+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299415; x=1777835415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BaLb2QakL7PuMfqddKhuZkTxakaJyY5sp9hXxk46Dug=;
  b=ZKoA87e+AxUudKrKpmytrP5MBs0rbm8vSEEqE9n9ZBHHek4ASz87ccSD
   zY2u6Btho4Um4CbH6UrfXaqf44jN0M/BsVru/xSxFTvkGKtelVgOCzmeF
   zuJSKyRFSQEHREY7X7nYA5oklxTbvl4phQUM6wHXl+WAF4EJ/bp5gTOzR
   DFjwdfBjmF5jV7W74bfKVwOj347lMDamx4k6RmW29YGTJpCsTyLW22/oy
   +WyRfOcHcLbARcoQA53+mCX/Y6SvZJLkAJIlhMb6SnlkIc6BmFiITOP4H
   5Z//1ILKQSXAxeWhIwdXsiNdVEPKcmmkW+boE9/zGOGl1pUmJ1gYKmPTb
   w==;
X-CSE-ConnectionGUID: fiWnhD0eQK220+uRd2eu7g==
X-CSE-MsgGUID: MJtYF9HaRgGuJeuBnnT9tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095624"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095624"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:13 -0700
X-CSE-ConnectionGUID: I7xJ/xtGQB6Cuffp6pMekw==
X-CSE-MsgGUID: 3uKN/U4zS8WwXlkbDgETuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046094"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:12 -0700
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
Subject: [PATCH v3 05/13] x86/dt: Parse the `enable-method` property of CPU nodes
Date: Sat,  3 May 2025 12:15:07 -0700
Message-Id: <20250503191515.24041-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add functionality to parse and validate the `enable-method` property for
platforms that use alternative methods to wakeup secondary CPUs (e.g., a
wakeup mailbox).

Most x86 platforms boot secondary CPUs using INIT assert, de-assert
followed by a Start-Up IPI messages. These systems do no need to specify an
`enable-method` property in the cpu@N nodes of the DeviceTree.

Although it is possible to specify a different `enable-method` for each
secondary CPU, the existing functionality relies on using the
APIC wakeup_secondary_cpu{ (), _64()} callback to wake up all CPUs. Ensure
that either all CPUs specify the same `enable-method` or none at all.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Introduced this patch.

Changes since v1:
 - N/A
---
 arch/x86/kernel/devicetree.c | 88 +++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index dd8748c45529..5835afc74acd 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -127,8 +127,59 @@ static void __init dtb_setup_hpet(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
+#ifdef CONFIG_SMP
+static const char *dtb_supported_enable_methods[] __initconst = { };
+
+static bool __init dtb_enable_method_is_valid(const char *enable_method_a,
+					      const char *enable_method_b)
+{
+	int i;
+
+	if (!enable_method_a && !enable_method_b)
+		return true;
+
+	if (strcmp(enable_method_a, enable_method_b))
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(dtb_supported_enable_methods); i++) {
+		if (!strcmp(enable_method_a, dtb_supported_enable_methods[i]))
+			return true;
+	}
+
+	return false;
+}
+
+static int __init dtb_configure_enable_method(const char *enable_method)
+{
+	/* Nothing to do for a missing enable-method or if the system has one CPU */
+	if (!enable_method || IS_ERR(enable_method))
+		return 0;
+
+	return -ENOTSUPP;
+}
+#else /* !CONFIG_SMP */
+static inline bool dtb_enable_method_is_valid(const char *enable_method_a,
+					      const char *enable_method_b)
+{
+	/* No secondary CPUs. We do not care about the enable-method. */
+	return true;
+}
+
+static inline int dtb_configure_enable_method(const char *enable_method)
+{
+	return 0;
+}
+#endif /* CONFIG_SMP */
+
+static void __init dtb_register_apic_id(u32 apic_id, struct device_node *dn)
+{
+	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+	set_apicid_to_node(apic_id, of_node_to_nid(dn));
+}
+
 static void __init dtb_cpu_setup(void)
 {
+	const char *enable_method = ERR_PTR(-EINVAL), *this_em;
 	struct device_node *dn;
 	u32 apic_id;
 
@@ -138,9 +189,42 @@ static void __init dtb_cpu_setup(void)
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
-		set_apicid_to_node(apic_id, of_node_to_nid(dn));
+
+		/*
+		 * Also check the enable-method of the secondary CPUs, if present.
+		 *
+		 * Systems that use the INIT-!INIT-StartUp IPI sequence to boot
+		 * secondary CPUs do not need to define an enable-method.
+		 *
+		 * All CPUs must have the same enable-method. The enable-method
+		 * must be supported. If absent in one secondary CPU, it must be
+		 * absent for all CPUs.
+		 *
+		 * Compare the first secondary CPU with the rest. We do not care
+		 * about the boot CPU, as it is enabled already.
+		 */
+
+		if (apic_id == boot_cpu_physical_apicid) {
+			dtb_register_apic_id(apic_id, dn);
+			continue;
+		}
+
+		this_em = of_get_property(dn, "enable-method", NULL);
+
+		if (IS_ERR(enable_method)) {
+			enable_method = this_em;
+			dtb_register_apic_id(apic_id, dn);
+			continue;
+		}
+
+		if (!dtb_enable_method_is_valid(enable_method, this_em))
+			continue;
+
+		dtb_register_apic_id(apic_id, dn);
 	}
+
+	if (dtb_configure_enable_method(enable_method))
+		pr_err("enable-method '%s' needed but not configured\n", enable_method);
 }
 
 static void __init dtb_lapic_setup(void)
-- 
2.43.0


