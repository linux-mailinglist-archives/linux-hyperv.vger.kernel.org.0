Return-Path: <linux-hyperv+bounces-7214-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1ECBDAAAD
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EC694EFEF5
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4803019CF;
	Tue, 14 Oct 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tIPGKRIB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF83002C2;
	Tue, 14 Oct 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460125; cv=none; b=iHzu1N2WEi7PfNpagQDNf7QAJ02XbjYNdyaCNtqflSMSFrmyK/6T+frVkBZAd+3CXZiPoLs4Uh+gBk1eC/dQZr+BfLdsZ66DOm+Upq2aRFzxmplerUMraEdXWuYvl2bJ2lFplN8SRqMwKcVCE2iJPDH7jkl4rhZBh1g0XX8/c28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460125; c=relaxed/simple;
	bh=xLGzket57qc+aNdkdrWaflBsI+C4MqThCE3uLn/pFOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4ObbMOfuTLQxcVFIbHAdVO71K3W3y84Q/C3Kbvndtj6zNr6oyKYXR3ApfVwujbBTyjJgn6mmeJDl5AEHoOYJz2ZnbTV+ftH/A4Rs91HSax0SdKtc9xzEAweR6xJPpqCSDYfcGnebBiYecpFBLr6+jrAFSek5vpvlRVq1w/5f1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tIPGKRIB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (syn-072-191-074-189.res.spectrum.com [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB882201601A;
	Tue, 14 Oct 2025 09:42:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB882201601A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760460122;
	bh=yzbeNZ8YxvygCqgSzYZ63vfhP9nHJotEZoHbkFcn1Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIPGKRIBhRDvzIh1wPAKUFh4wZvqsERbRZgx2f6O6nQfPH3gonkD4JcyXdsl5uE9H
	 Rin4kCYcufRqwxkCZTKImQ0MBR9epuzXli/mB/5fjDyKvlyI/Az5XtCxbL5YmwEoXU
	 F0z3a+wJ3DPyvyp10GBo/Zv+QGS5pyRDDwrtPLuw=
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
Subject: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition with MSHV
Date: Tue, 14 Oct 2025 11:41:21 -0500
Message-ID: <20251014164150.6935-3-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014164150.6935-1-prapal@linux.microsoft.com>
References: <20251014164150.6935-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a shutdown is initiated in the root partition without configuring
sleep states, the call to `hv_call_enter_sleep_state` fails. In such cases
the root falls back to using legacy ACPI mechanisms to poweroff. This call
is intercepted by MSHV and will result in a Machine Check Exception (MCE).

Root panics with a trace similar to:

[   81.306348] reboot: Power down
[   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
[   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
[   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
[   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
[   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
[   81.314717] Kernel panic - not syncing: Fatal machine check

To prevent this, properly configure sleep states within MSHV, allowing
the root partition to shut down cleanly without triggering a panic.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |   7 ++
 arch/x86/include/asm/mshyperv.h |   1 +
 drivers/hv/hv_common.c          | 119 ++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)

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
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index abc4659f5809..fb8d691193df 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -236,6 +236,7 @@ int hyperv_fill_flush_guest_mapping_list(
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
 bool hv_vcpu_is_preempted(int vcpu);
+int hv_sleep_notifiers_register(void);
 #else
 static inline void hv_apic_init(void) {}
 #endif
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e109a620c83f..cfba9ded7bcb 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -837,3 +837,122 @@ const char *hv_result_to_string(u64 status)
 	return "Unknown";
 }
 EXPORT_SYMBOL_GPL(hv_result_to_string);
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
+	acpi_status = acpi_get_sleep_type_data(ACPI_STATE_S5,
+						&sleep_type_a, &sleep_type_b);
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
+#endif
-- 
2.51.0


