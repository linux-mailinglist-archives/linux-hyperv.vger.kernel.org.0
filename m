Return-Path: <linux-hyperv+bounces-7233-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCEBE620F
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC77D5E0BD8
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A4248883;
	Fri, 17 Oct 2025 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/nPod4+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E26187332;
	Fri, 17 Oct 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669331; cv=none; b=p106G71RoiccaTtBLBkPNj4pLx9Jtyit2cbH6ZtGmr4LtSxA4dfTCxI7hvW8RZMaHahgJz9mag4oS9JsFIweje0UhiGFWh1uK2yiTUfinQa1k8957efSRD/2hLiiCEcfKIe1XkO/0kKcOcJPMuF8aSFO3CzUsFniomp7XV9Yrwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669331; c=relaxed/simple;
	bh=LIqUV6VOVMcoYUSWfWyv8zoYNppCVbs3oUzzRQpEXEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGtJGMAHaaAX9zjiHV/4NbR0/nTMX6smFOFnH5hOiOHYkRO1DMzuuHrlySfSH1wbaMTviaeFylKS8CMlMxgjh63KL3vssXnRU6adtvQLvDpy47MJTqnMAkDOn421ywUuNlHSFPTXOqozQqThbOZflewSDuXLaRsF3R0FLoEWpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/nPod4+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669330; x=1792205330;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LIqUV6VOVMcoYUSWfWyv8zoYNppCVbs3oUzzRQpEXEg=;
  b=T/nPod4+MsuIJPkraaSxA9tb+BLI9pxcaBArtzJ5XrrChgZNbKwxMc2P
   B0C12NTqHjRNc4CxPtxzgzRu3uq/UiHjAJrxCeAMhvDlgsSk9/mD0IETB
   jnmOdZeVcA3xBJzcfYWNnA0lxx1W9b8YGVbDeLJcKVvJOBHtm1v8TQArt
   lHOJ2TZ8rKBVIzTVlea/cJxqz9hv3gUW5DwIFSOmvbweDXFud6AgXshhV
   6bJVA4sAUw20joIrKVgSYN/KdYZYiER2GQ5bUGHNsHytGPinFMRUIpp7y
   tdb8uF9CFrLW07Hsoaq1iW6oQYkYjVrkK5R2uARnpUKn6rUguq00Sr5N2
   w==;
X-CSE-ConnectionGUID: +moL93ZpSVOaPEMTNgnLNw==
X-CSE-MsgGUID: VgYWD3JsToWUtgo5/vsQ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321894"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321894"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:48 -0700
X-CSE-ConnectionGUID: gdYNjOJRSKKgN8E2Uinm6Q==
X-CSE-MsgGUID: F/5yH4ydS+aUmw5e+aQz6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776543"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:47 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:23 -0700
Subject: [PATCH v6 01/10] x86/acpi: Add helper functions to setup and
 access the wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-1-40435fb9305e@linux.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
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
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=4248;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=LIqUV6VOVMcoYUSWfWyv8zoYNppCVbs3oUzzRQpEXEg=;
 b=qy4W3Ui4SabjPrVoIccHWHv3fyFCugOxl9VAGFCq62NxCXwgqYna+EdYAKn9VuPgyPXSrORuw
 ubpVWxpR+enB3qGLWHRkm/8JOABuCnHv/fTdVEdZ3fWFWGIyI29cpf0
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

In preparation to move the functionality to wake secondary CPUs up from the
ACPI code, add two helper functions.

The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.

There is a slight change in behavior: now the APIC callback is updated
before configuring CPU hotplug offline behavior. This is fine as the APIC
callback continues to be updated unconditionally, regardless of the
restriction on CPU offlining.

The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
mailbox. Use this helper function only in the portions of the code for
which the variable acpi_mp_wake_mailbox will be out of scope once it is
relocated out of the ACPI directory.

The wakeup mailbox is only supported for CONFIG_X86_64 and needed only with
CONFIG_SMP=y.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Fixed grammar error in the subject of the patch. (Rafael)
 - Added Acked-by tag from Rafael. Thanks!
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes since v4:
 - None

Changes since v3:
 - Squashed the two first patches of the series into one, both introduce
   helper functions. (Rafael)
 - Renamed setup_mp_wakeup_mailbox() as acpi_setup_mp_wakeup_mailbox().
   (Rafael)
 - Dropped the function prototype for !CONFIG_X86_64. (Rafael)

Changes since v2:
 - Introduced this patch.

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h         |  3 +++
 arch/x86/kernel/acpi/madt_wakeup.c | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 22bfebe6776d..47ac4381a805 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -149,6 +149,9 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 	return per_cpu(cpu_l2c_shared_map, cpu);
 }
 
+void acpi_setup_mp_wakeup_mailbox(u64 addr);
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
 static inline void wbinvd_on_all_cpus(void)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6d7603511f52..c3ac5ecf3e7d 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -37,6 +37,7 @@ static void acpi_mp_play_dead(void)
 
 static void acpi_mp_cpu_die(unsigned int cpu)
 {
+	struct acpi_madt_multiproc_wakeup_mailbox *mailbox = acpi_get_mp_wakeup_mailbox();
 	u32 apicid = per_cpu(x86_cpu_to_apicid, cpu);
 	unsigned long timeout;
 
@@ -46,13 +47,13 @@ static void acpi_mp_cpu_die(unsigned int cpu)
 	 *
 	 * BIOS has to clear 'command' field of the mailbox.
 	 */
-	acpi_mp_wake_mailbox->apic_id = apicid;
-	smp_store_release(&acpi_mp_wake_mailbox->command,
+	mailbox->apic_id = apicid;
+	smp_store_release(&mailbox->command,
 			  ACPI_MP_WAKE_COMMAND_TEST);
 
 	/* Don't wait longer than a second. */
 	timeout = USEC_PER_SEC;
-	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
+	while (READ_ONCE(mailbox->command) && --timeout)
 		udelay(1);
 
 	if (!timeout)
@@ -227,7 +228,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
+	acpi_setup_mp_wakeup_mailbox(mp_wake->mailbox_address);
 
 	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
 	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
@@ -243,7 +244,16 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 		acpi_mp_disable_offlining(mp_wake);
 	}
 
+	return 0;
+}
+
+void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
 
-	return 0;
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
 }

-- 
2.43.0


