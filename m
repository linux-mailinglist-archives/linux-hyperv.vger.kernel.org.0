Return-Path: <linux-hyperv+bounces-7651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205EC66380
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 22:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15ACE4ED61E
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 21:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2376234D90A;
	Mon, 17 Nov 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MOPL+ApF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5983446D6;
	Mon, 17 Nov 2025 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413755; cv=none; b=f5Xdtjr3Zmkm/DHYbMLnsKdIMIZy/y7H5p3UV2F7nLIkEIcjwlcnVr+JNVKzg7BUPJIGf3nL0q9dgZ0KaDyAAvfjlAmyrL3GOQeyxoW2ypYsFnkaprIqClo+AvuOmlzVuostZesIUYDwBgVsforC0uneYJUea5NzxEp9ii5NKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413755; c=relaxed/simple;
	bh=F7720mKzNkCyKDFLO0uVt6mLlc9YPAcJAP0PCon+qxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJOb37myvn8eiA5lzGAoNQknuYzzWgocs7HCNScl537QBCyd6ffJu9B2nDBsfXYAfhnsRwGKFlTTD7Ifip/VyF392TH+S1O4c5qOBGmYY2trosQnYmlOXA/5iAv+Ge4WhzBMBRFdVn4hbmbmIIKwpCKKo2ACF9lSzMQSPFEHeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MOPL+ApF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4803211C29E;
	Mon, 17 Nov 2025 13:09:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4803211C29E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763413746;
	bh=LSlVSgvFrLjmBkegSWSpoKm3gTlsJwpDrznHfDraKEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOPL+ApF1TVTK4bkcm6N2hEIX4+cOwX3T6th3pzUHVvttfs3ATX4npLeeXz8JjDNx
	 Ng68QVi2L7jsGOTzGngVxTcqHg+cyxPF+eDJx4AQagZ3mUExsdQ9pwP9FH2i2sgjiW
	 TrrYHWw947hDLwUGdRbqo7fCbkAkqBsCF7c+8+s8=
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
Subject: [PATCH v5 3/3] hyperv: Cleanly shutdown root partition with MSHV
Date: Mon, 17 Nov 2025 15:08:18 -0600
Message-ID: <20251117210855.108126-4-prapal@linux.microsoft.com>
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

When a root partition running on MSHV is powered off, the default
behavior is to write ACPI registers to power-off. However, this ACPI
write is intercepted by MSHV and will result in a Machine Check
Exception(MCE).

The root partition eventually panics with a trace similar to:

  [   81.306348] reboot: Power down
  [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
  [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
  [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
  [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
  [   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
  [   81.314717] Kernel panic - not syncing: Fatal machine check

To correctly shutdown a root partition running on MSHV hypervisor, sleep
state information must be configured within the hypervsior. Later, the
HVCALL_ENTER_SLEEP_STATE hypercall should be invoked as the last step in
the shutdown sequence.

The previous patch configures the sleep state information and this patch
invokes HVCALL_ENTER_SLEEP_STATE hypercall to cleanly shutdown the root
partition.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  2 ++
 arch/x86/include/asm/mshyperv.h |  2 ++
 drivers/hv/mshv_common.c        | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 645b52dd732e..24824534ff8d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -34,6 +34,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
+#include <asm/reboot.h>
 
 void *hv_hypercall_pg;
 
@@ -562,6 +563,7 @@ void __init hyperv_init(void)
 		 * failures here.
 		 */
 		hv_sleep_notifiers_register();
+		machine_ops.power_off = hv_machine_power_off;
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 166053df0484..4c22f3257368 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -183,9 +183,11 @@ void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
 bool hv_vcpu_is_preempted(int vcpu);
 void hv_sleep_notifiers_register(void);
+void hv_machine_power_off(void);
 #else
 static inline void hv_apic_init(void) {}
 static inline void hv_sleep_notifiers_register(void) {};
+static inline void hv_machine_power_off(void) {};
 #endif
 
 struct irq_domain *hv_create_pci_msi_domain(void);
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index ee733ba1575e..73505cbdc324 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -216,3 +216,21 @@ void hv_sleep_notifiers_register(void)
 		pr_err("%s: cannot register reboot notifier %d\n", __func__,
 		       ret);
 }
+
+/*
+ * Power off the machine by entering S5 sleep state via Hyper-V hypercall.
+ * This call does not return if successful.
+ */
+void hv_machine_power_off(void)
+{
+	unsigned long flags;
+	struct hv_input_enter_sleep_state *in;
+
+	local_irq_save(flags);
+	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	in->sleep_state = HV_SLEEP_STATE_S5;
+
+	(void)hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
+	local_irq_restore(flags);
+
+}
-- 
2.51.0


