Return-Path: <linux-hyperv+bounces-7169-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E1BCA107
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 18:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D73D354FD0
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Oct 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E9D2D9EF8;
	Thu,  9 Oct 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kzWMB8Cg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285E225A38;
	Thu,  9 Oct 2025 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025920; cv=none; b=QD2ZVpDfAqoyBV8zIQDXccP9XlbZPlQ0F6OtXFPnwwXg4L88gAVenLI1/ugeiuebwdPBNrw/ca8iX624vLKC9KI/Jh4A2mI7caqwOBInElvD5mkHgURhVRGOsyupKXlPFi0bRjauhQknDRaP1z0VcJLTa3WfcOgRP+Ny+SzEqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025920; c=relaxed/simple;
	bh=zyejt96P0FeNu60HKHr+d7rAco1Ux5PlVDsaxY1OCxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ow2RZnsBByZPhUAHefrowkGGUTWJv3sGLzcsN+k5Ek7Q0CplkGu3WUZ5nNXPviHf0Ubzv147JbzR0FS1c8y5PhHFf4mTIkQ/IhF7xBL2NoI8VivjJz4QCLyeUmMFgNTEiT1P6GbKYVxJzhHu/ugPdhSPN5fz4siMEYJCgUmA2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kzWMB8Cg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (syn-072-191-074-189.res.spectrum.com [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79DEA211CE10;
	Thu,  9 Oct 2025 09:05:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79DEA211CE10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760025913;
	bh=HGtw/hLxsNqO+uJzT+Bj75q6zBOtKZdgbeh1YUgDHYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzWMB8CgCvRPyoYFWk/Z05B2jwXwqg6Ns8EjbV9YbcZjdut2H3k5QTsGveLQVKOOh
	 pVmLncEMk3gwkHRuVck8xm4lNupXLoKfG/H/QQOZdj5LSETuW5jERsNXpLczDk70tZ
	 GN6SQ5Kl2KMAA1tL0yPjTLIWYdRgghBVy+7F3Xso=
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
	prapal@linux.microsoft.com
Subject: [PATCH 2/2] hyperv: Enable clean shutdown for root partition with MSHV
Date: Thu,  9 Oct 2025 10:58:51 -0500
Message-ID: <20251009160501.6356-3-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009160501.6356-1-prapal@linux.microsoft.com>
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit enables the root partition to perform a clean shutdown when
running with MSHV hypervisor.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c      |   7 ++
 drivers/hv/hv_common.c         | 118 +++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |   1 +
 3 files changed, 126 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index afdbda2dd7b7..57bd96671ead 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -510,6 +510,13 @@ void __init hyperv_init(void)
 		memunmap(src);
 
 		hv_remap_tsc_clocksource();
+		/*
+		 * The notifier registration might fail at various hops.
+		 * Corresponding error messages will land in dmesg. There is
+		 * otherwise nothing that can be specifically done to handle
+		 * failures here.
+		 */
+		(void)hv_sleep_notifiers_register();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e109a620c83f..c5165deb5278 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -837,3 +837,121 @@ const char *hv_result_to_string(u64 status)
 	return "Unknown";
 }
 EXPORT_SYMBOL_GPL(hv_result_to_string);
+
+/*
+ * Corresponding sleep states have to be initialized, in order for a subsequent
+ * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
+ * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supported.
+ *
+ * ACPI should be initialized and should support S5 sleep state when this method
+ * is called, so that, it can extract correct PM values and pass them to hv.
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
+	acpi_status = acpi_get_sleep_type_data(ACPI_STATE_S5,
+						&sleep_type_a, &sleep_type_b);
+	if (ACPI_FAILURE(acpi_status))
+		return -ENODEV;
+
+	local_irq_save(flags);
+	in = (struct hv_input_set_system_property *)(*this_cpu_ptr(
+		hyperv_pcpu_input_arg));
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
+		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
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
+	in = (struct hv_input_enter_sleep_state *)
+			(*this_cpu_ptr(hyperv_pcpu_input_arg));
+	in->sleep_state = (enum hv_sleep_state)sleep_state;
+
+	status = hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
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
+	if (SYS_HALT == code || SYS_POWER_OFF == code)
+		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
+
+	return ret ? NOTIFY_DONE : NOTIFY_OK;
+}
+
+static struct notifier_block hv_reboot_notifier = {
+	.notifier_call  = hv_reboot_notifier_handler,
+};
+
+static int hv_acpi_sleep_handler(u8 sleep_state, u32 pm1a_cnt, u32 pm1b_cnt)
+{
+	int ret = 0;
+
+	if (sleep_state == ACPI_STATE_S5)
+		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
+
+	return ret == 0 ? 1 : -1;
+}
+
+static int hv_acpi_extended_sleep_handler(u8 sleep_state, u32 val_a, u32 val_b)
+{
+	return hv_acpi_sleep_handler(sleep_state, val_a, val_b);
+}
+
+int hv_sleep_notifiers_register(void)
+{
+	int ret;
+
+	acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
+	acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);
+
+	ret = register_reboot_notifier(&hv_reboot_notifier);
+	if (ret)
+		pr_err("%s: cannot register reboot notifier %d\n",
+			__func__, ret);
+
+	return ret;
+}
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 64ba6bc807d9..903d089aba82 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -339,6 +339,7 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
+int hv_sleep_notifiers_register(void);
 #else /* CONFIG_HYPERV */
 static inline void hv_identify_partition_type(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
-- 
2.51.0


