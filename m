Return-Path: <linux-hyperv+bounces-7979-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88721CA93EE
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E45314C6CD
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06E2E0901;
	Fri,  5 Dec 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lzUqVx7R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE12DCF6C;
	Fri,  5 Dec 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965857; cv=none; b=Z8yRjOlRbw2dekJVkWYaro0SL/esyNTxWHBVfK/zE7Yn/OmnOOYQAGjpHirEGspjKU1wD70Cuq3bPuLEYMEAJDwjSQ3pblq2evjUJQ5NbypT422TlJnkZGcvj2W6Ou9e7nKQ+6+LzPF8qkUycv1nVoSJYodAdfHcFkqjw6AbEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965857; c=relaxed/simple;
	bh=eMqUsEd2ZG8Qx42uD0+0w+LpVSuDUonTdGiSafAcRgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCI9tv/EvhqkekLI78XOpgFLzMylRqZzxelxK99BFuffdV2yeMtTGTmo2Mz8Z6mPvlxpzSZoOhjy7ZWG9IRsGPo/vErUtNbhxXwmDO5GiF+sR90MMzh1NorOPYztSzAhHoxj0998/yE9/J3G1PI0p0IeZqUQ5poHIH4OQP0MEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lzUqVx7R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93BBF2116027;
	Fri,  5 Dec 2025 12:17:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93BBF2116027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764965855;
	bh=FzkrmiDFGiKGPB2RPNo66dLcUqDXUjjf3utqEH03Ifk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzUqVx7RkgrEFk6xYICWgW0brcfl5zJ3ijU8dhI2qvq/gxgYCGmqnFT6iPr8Y2x6k
	 Jq01mNv2vzS4dQnHJdnlz3JM5+j6sPxS7b2asLAHHhuGwF3/GV4IO7ztA1qzbFJdup
	 +jILwNqIbZFl+ZVEm+ohleXEFghXMyPY2rnRP1IE=
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
Subject: [PATCH v7 4/4] hyperv: Cleanly shutdown root partition with MSHV
Date: Fri,  5 Dec 2025 14:17:08 -0600
Message-ID: <20251205201721.7253-5-prapal@linux.microsoft.com>
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

Root partitions running on MSHV currently attempt ACPI power-off, which
MSHV intercepts and triggers a Machine Check Exception (MCE), leading
to a kernel panic.

Root partitions panic with a trace similar to:

  [   81.306348] reboot: Power down
  [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
  [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
  [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
  [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
  [   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
  [   81.314717] Kernel panic - not syncing: Fatal machine check

To avoid this, configure the sleep state in the hypervisor and invoke
the HVCALL_ENTER_SLEEP_STATE hypercall as the final step in the shutdown
sequence. This ensures a clean and safe shutdown of the root partition.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 arch/x86/include/asm/mshyperv.h |  1 +
 arch/x86/kernel/cpu/mshyperv.c  |  2 ++
 drivers/hv/mshv_common.c        | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 62a89debfbce..eef4c3a5ba28 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -178,6 +178,7 @@ int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
 void hv_sleep_notifiers_register(void);
+void hv_machine_power_off(void);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index fac9953a72ef..579fb2c64cfd 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -621,6 +621,8 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 
 #if IS_ENABLED(CONFIG_HYPERV)
+	if (hv_root_partition())
+		machine_ops.power_off = hv_machine_power_off;
 #if defined(CONFIG_KEXEC_CORE)
 	machine_ops.shutdown = hv_machine_shutdown;
 #endif
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index ee733ba1575e..58027b23c206 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -216,3 +216,24 @@ void hv_sleep_notifiers_register(void)
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
+	/* should never reach here */
+	BUG();
+
+}
-- 
2.51.0


