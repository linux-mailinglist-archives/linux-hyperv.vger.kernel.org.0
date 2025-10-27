Return-Path: <linux-hyperv+bounces-7346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA2C11661
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE0A1A624B8
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3732145A;
	Mon, 27 Oct 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WLEqQ6gC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076631A064;
	Mon, 27 Oct 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596953; cv=none; b=J4ue3YVY5oqCyldW/y9s/JyGeTorx9MzRn2qTwDQk/hEhyyJNwVJP+sMgRF9o5iCMHHUmdphUKwQbAwlMfL7+xYMSyyk6ZCyCqaX/n/qDI4tnV2BArCdvC+BRbSxR8e3bb9suclKCjCINl1lP57cTxPWiUCFFyo/wJTNej2crl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596953; c=relaxed/simple;
	bh=vnr6TK8JReGzvBGFhEqVtDasPNCQQyW45mZ8vOCWTzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKl657FPQL/gP4mVxvvYks0fl0HcjekFgv8U4eAdFqgEj0svbyaa3Zb6cWBZkTeFrW7wtVf25BtLfpBFYpQtXEOIDo4/SqNbmahzFVvHpGL1a01PmavOxKIps0OAcva5si+PTaeXbFukJrXe6ZXTx8lIKK0sdTvWaIMX4Gi9YU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WLEqQ6gC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 456842123279;
	Mon, 27 Oct 2025 13:29:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 456842123279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761596950;
	bh=AZZr3hJeCpe3fLnQl4aCVIwclGJQ1RbC24we1daQtRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLEqQ6gC3rm9ubsgRH+VTQT56gQ2R2RGECFSuzsYu2afu/SWmwTrCqEornPKxtAcF
	 /ZRqdnX3nRbQY49GDGrGjNs6UzXddfZtL+BatArFHeEFiQ9pPJuj6NuxiwoQpWVmu+
	 sksiA2xnMdqb3auQqDpn9EQBdMDRkvZI4FDzkdhk=
From: Praveen K Paladugu <prapal@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Cc: anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	skinsburskii@linux.microsoft.com
Subject: [PATCH v3 2/2] hyperv: Enable clean shutdown for root partition with MSHV
Date: Mon, 27 Oct 2025 15:28:43 -0500
Message-ID: <20251027202859.72006-3-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027202859.72006-1-prapal@linux.microsoft.com>
References: <20251027202859.72006-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without configuing sleep state info within mshv, if a root partition is
shut down, it will try to shutdown by writing to ACPI regions. These
writes are intercepted by mshv and will result in a Machine Check
Exception (MCE).

Root eventually panics with a trace similar to:

[   81.306348] reboot: Power down
[   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
[   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
[   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
[   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
[   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
[   81.314717] Kernel panic - not syncing: Fatal machine check

To prevent this, properly configure sleep states within MSHV, enable a
reboot notifier, allowing the root partition to cleanly shut down without
any panics. Only S5 sleep state is enabled for now.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |   8 +++
 arch/x86/include/asm/mshyperv.h |   2 +
 drivers/hv/mshv_common.c        | 103 ++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e28737ec7054..0a8856009792 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -555,6 +555,14 @@ void __init hyperv_init(void)
 
 		hv_remap_tsc_clocksource();
 		hv_root_crash_init();
+
+		/*
+		 * The notifier registration might fail at various hops.
+		 * Corresponding error messages will land in dmesg. There is
+		 * otherwise nothing that can be specifically done to handle
+		 * failures here.
+		 */
+		hv_sleep_notifiers_register();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 1342d55c2545..fbc1233175ce 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -181,8 +181,10 @@ int hyperv_fill_flush_guest_mapping_list(
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
 bool hv_vcpu_is_preempted(int vcpu);
+void hv_sleep_notifiers_register(void);
 #else
 static inline void hv_apic_init(void) {}
+static inline void hv_sleep_notifiers_register(void) {};
 #endif
 
 struct irq_domain *hv_create_pci_msi_domain(void);
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index aa2be51979fd..12b248ea3498 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -14,6 +14,9 @@
 #include <asm/mshyperv.h>
 #include <linux/resume_user_mode.h>
 #include <linux/export.h>
+#include <linux/acpi.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #include "mshv.h"
 
@@ -138,3 +141,103 @@ int hv_call_get_partition_property(u64 partition_id,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
+
+#if IS_ENABLED(CONFIG_ACPI)
+/*
+ * Corresponding sleep states have to be initialized in order for a subsequent
+ * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
+ * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supported.
+ *
+ * ACPI should be initialized and should support S5 sleep state when this method
+ * is called, so that it can extract correct PM values and pass them to hv.
+ */
+static int hv_initialize_sleep_states(void)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_set_system_property *in;
+	acpi_status acpi_status;
+	u8 sleep_type_a, sleep_type_b;
+
+	if (!acpi_sleep_state_supported(ACPI_STATE_S5)) {
+		pr_err("%s: S5 sleep state not supported.\n", __func__);
+		return -ENODEV;
+	}
+
+	acpi_status = acpi_get_sleep_type_data(ACPI_STATE_S5, &sleep_type_a,
+					       &sleep_type_b);
+	if (ACPI_FAILURE(acpi_status))
+		return -ENODEV;
+
+	local_irq_save(flags);
+	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(in, 0, sizeof(*in));
+
+	in->property_id = HV_SYSTEM_PROPERTY_SLEEP_STATE;
+	in->set_sleep_state_info.sleep_state = HV_SLEEP_STATE_S5;
+	in->set_sleep_state_info.pm1a_slp_typ = sleep_type_a;
+	in->set_sleep_state_info.pm1b_slp_typ = sleep_type_b;
+
+	status = hv_do_hypercall(HVCALL_SET_SYSTEM_PROPERTY, in, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		hv_status_err(status, "\n");
+		return hv_result_to_errno(status);
+	}
+
+	return 0;
+}
+
+static int hv_call_enter_sleep_state(u32 sleep_state)
+{
+	u64 status;
+	int ret;
+	unsigned long flags;
+	struct hv_input_enter_sleep_state *in;
+
+	ret = hv_initialize_sleep_states();
+	if (ret)
+		return ret;
+
+	local_irq_save(flags);
+	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	in->sleep_state = sleep_state;
+
+	status = hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		hv_status_err(status, "\n");
+		return hv_result_to_errno(status);
+	}
+
+	return 0;
+}
+
+static int hv_reboot_notifier_handler(struct notifier_block *this,
+				      unsigned long code, void *another)
+{
+	int ret = 0;
+
+	if (code == SYS_HALT || code == SYS_POWER_OFF)
+		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
+
+	return ret ? NOTIFY_DONE : NOTIFY_OK;
+}
+
+static struct notifier_block hv_reboot_notifier = {
+	.notifier_call = hv_reboot_notifier_handler,
+	.priority = INT_MIN, /* may not return */
+};
+
+void hv_sleep_notifiers_register(void)
+{
+	int ret;
+
+	ret = register_reboot_notifier(&hv_reboot_notifier);
+	if (ret)
+		pr_err("%s: cannot register reboot notifier %d\n", __func__,
+		       ret);
+}
+#endif
-- 
2.51.0


