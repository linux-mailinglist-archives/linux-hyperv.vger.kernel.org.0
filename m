Return-Path: <linux-hyperv+bounces-7978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70DCA93E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9417930E02E3
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA32D94A1;
	Fri,  5 Dec 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AmYTCFqZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834822D8DDF;
	Fri,  5 Dec 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965856; cv=none; b=t6uIapKecEsV61a0lGQOuY89Gj28NohKCgxrhK7snqgF3k/VV/nPB4pJ+ELtuUTsbOWwZg6RyxWTcW8WQfkeJyjaOYBSH3TwpRmW8g96SicVdZiwGiP4pHSgREfuD4y0vuzmbDGNYe/fW52ax0HRU0OzBGIOhtWOezo19w/cJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965856; c=relaxed/simple;
	bh=l5UAG+eKDS7RFbmJ/qkhj7JVtXvOkdzJ5ekUesT8pxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDKV5vHcaVJ3H6krdmjY3ly6kp7BO/OkY+osRm47afpTYVIJmMxK9HfksSSqA2vygVwd2Ll4W6CuTqScc8ErTwBMcKXLzaukBEudF4pIlcQ98ti8p6O94c+eRlV1JzoaMeUQwcGu4tx4ldahSDpwUJDwiR7WmlBZAMeGUiYReYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AmYTCFqZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id C36BB2116025;
	Fri,  5 Dec 2025 12:17:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C36BB2116025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764965853;
	bh=8aflDMUPlUIlId6bLXcwBHu5JpqbaUXHvQgoII92W/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmYTCFqZSvhWe2FXm9XXhSGWDim5blAZUrXAqcD9fBsaxCnRCtSnaOQPdspU4uszf
	 Vb9kGIjQhzaJ1Hwir2z0hCdPqJa+ZjMBAFiVZPVqCh9hxINty0AngmgLZLJBwM2vZL
	 AYktRmkp43IERWfWpzEeqqjDI4YBaZg8UvqZPe5w=
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
Subject: [PATCH v7 3/4] hyperv: Use reboot notifier to configure sleep state
Date: Fri,  5 Dec 2025 14:17:07 -0600
Message-ID: <20251205201721.7253-4-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201721.7253-1-prapal@linux.microsoft.com>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configure sleep state information from ACPI in MSHV hypervisor using
a reboot notifier. This data allows the hypervisor to correctly power
off the host during shutdown.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Stansialv Kinsburskii <skinsburskii@linux.miscrosoft.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  1 +
 arch/x86/include/asm/mshyperv.h |  1 +
 drivers/hv/mshv_common.c        | 78 +++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e28737ec7054..daf97a984b78 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -555,6 +555,7 @@ void __init hyperv_init(void)
 
 		hv_remap_tsc_clocksource();
 		hv_root_crash_init();
+		hv_sleep_notifiers_register();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 10037125099a..62a89debfbce 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -177,6 +177,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
+void hv_sleep_notifiers_register(void);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
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


