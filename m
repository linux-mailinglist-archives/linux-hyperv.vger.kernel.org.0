Return-Path: <linux-hyperv+bounces-7650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA19C66371
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 22:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64AFD35C2BC
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 21:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF934D4E4;
	Mon, 17 Nov 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S4Gt3xSg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C1329AAF7;
	Mon, 17 Nov 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413754; cv=none; b=pd3KlPGLwnpB+Azzr3Br/6GFVgjM4Bc2OjYsZCN1GY2nbCzkHz7a2u6ztwNYFQwov4nF8v/JwpvPwer8VUn6jCoe39eb4MYgpu0aeunq5pcSjGGGoGwBBABJybke02dQU/1Ggvl3o1TYR6MG/kE68FIpetcVbcGV4xP7wK5TYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413754; c=relaxed/simple;
	bh=mBIuWK0BONjrrdULn6CAG75vc43gqCn4a9WDZMzYjxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfSOGVrhsrKDja7dcWBecbC/gTA6qaVN3bUGt5VH5AK+PysMjX9LNFWuEX0Pqi3dxZCqv4Jy0pSYO18qY1j5J37QCvJ9s1bDsLcYXAB7W6odCKezYZ/dQbwwjngHm+VF3IVKfTBqQM34KPlxdAYH5UiNbpCAy6GOUuTeFSeSO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S4Gt3xSg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F308211C29F;
	Mon, 17 Nov 2025 13:09:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F308211C29F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763413745;
	bh=b0Zn1GH9WbKxJZpKbDg2csMLC6ENSR/SCYX+BgPaWKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4Gt3xSgNLTgLFU++emRc2DDKoRXx/wHvUaj8fOl7vb2KYm2tR5lbhDI5lPTvIlZ7
	 oDeh2RhK2hoEyyhxbwLjUrtUDeuYI6MT5I4VB0NQJ2Rn+Ug/IKvEqWCz7oRn1op8j7
	 i1T1wksyYLuNXukfrCD7qtgy+YwGSJ5/YVrzDXow=
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
Subject: [PATCH v5 2/3] hyperv: Use reboot notifier to configure sleep state
Date: Mon, 17 Nov 2025 15:08:17 -0600
Message-ID: <20251117210855.108126-3-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117210855.108126-1-prapal@linux.microsoft.com>
References: <20251117210855.108126-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configure sleep state information in mshv hypervisor. This sleep state
information from ACPI will be used by hypervisor to poweroff the host.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  7 +++
 arch/x86/include/asm/mshyperv.h |  2 +
 drivers/hv/mshv_common.c        | 78 +++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e28737ec7054..645b52dd732e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -555,6 +555,13 @@ void __init hyperv_init(void)
 
 		hv_remap_tsc_clocksource();
 		hv_root_crash_init();
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
index 10037125099a..166053df0484 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -182,8 +182,10 @@ int hyperv_fill_flush_guest_mapping_list(
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
index aa2be51979fd..ee733ba1575e 100644
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
 
@@ -138,3 +141,78 @@ int hv_call_get_partition_property(u64 partition_id,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
+
+/*
+ * Corresponding sleep states have to be initialized in order for a subsequent
+ * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
+ * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supported.
+ *
+ * In order to pass proper PM values to mshv, ACPI should be initialized and
+ * should support S5 sleep state when this method is invoked.
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
+/*
+ * This notifier initializes sleep states in mshv hypervisor which will be
+ * used during power off.
+ */
+static int hv_reboot_notifier_handler(struct notifier_block *this,
+				      unsigned long code, void *another)
+{
+	int ret = 0;
+
+	if (code == SYS_HALT || code == SYS_POWER_OFF)
+		ret = hv_initialize_sleep_states();
+
+	return ret ? NOTIFY_DONE : NOTIFY_OK;
+}
+
+static struct notifier_block hv_reboot_notifier = {
+	.notifier_call = hv_reboot_notifier_handler,
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
-- 
2.51.0


