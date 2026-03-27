Return-Path: <linux-hyperv+bounces-9817-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HNuCyTrxmloQAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9817-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:40:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05634B1F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BFD5301E731
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84443399364;
	Fri, 27 Mar 2026 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IYT5/W5f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E7399342;
	Fri, 27 Mar 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642785; cv=none; b=P61pTJGwjvzKmVgkTJM6nd3DasBO9ow8XuKvAQ88LyLGxIGkH4jti3hryJX6qiudj1mzLaSyMclQGQeX8YVwVbdKPtSPsNuGCyvB5ztC07rwJui55pzN4wOX5ZN6et5sGuQB/JUFKzxpHPTxrVv99Xj+xSLq/WAPq7/YbLpnQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642785; c=relaxed/simple;
	bh=hNIiNuDPxuZnaMtc1ARblwqwK4xYSWqQw5KM4tx3lJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6hQvD4/cVPxn1wGo2Pubc0FHL8PXta2pnmifoko2yWpXCQF3eoj4S+7wLN5z1HmCcWFzjWqfr2FXHfO49+MxPPuV9Nhank4JX8e5xzifxVJbS9tKS75cSkdHHT6hPMWx7UsQ3DDNd+8Fx3Mw3LnpiypHKE5dxbA3ORJ4mhHXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IYT5/W5f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 4D5E620B712B; Fri, 27 Mar 2026 13:19:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D5E620B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774642784;
	bh=6pzpu/gJFjinb2P2J9+XytwM6zcdOj6YIrKwdbxm5Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYT5/W5f8QvAjtTvI+VM/70qunsoQI/AS3y3nw+46qYI1dyRO2I0yXWjreg7TXRiX
	 5Fz0R7EBouKWz++F++xOG8ml0PkFJxmsn89SmfMyDv72GbhvhDIWGm6QWDmZtUKxxk
	 fNrQu30SwN0Go0jk1+DTs0681ioi5xh9uLCz1k5Y=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>,
	Mukesh Rathor <mukeshrathor@microsoft.com>
Subject: [PATCH 3/6] x86/hyperv: Skip LP/VP creation on kexec
Date: Fri, 27 Mar 2026 13:19:14 -0700
Message-ID: <20260327201920.2100427-4-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9817-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 0F05634B1F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After a kexec the logical processors and virtual processors already
exist in the hypervisor because they were created by the previous
kernel. Attempting to add them again causes either a BUG_ON or
corrupted VP state leading to MCEs in the new kernel.

Add hv_lp_exists() to probe whether an LP is already present by
calling HVCALL_GET_LOGICAL_PROCESSOR_RUN_TIME. When it succeeds the
LP exists and we skip the add-LP and create-VP loops entirely.

Also add hv_call_notify_all_processors_started() which informs the
hypervisor that all processors are online. This is required after
adding LPs (fresh boot) and is a no-op on kexec since we skip that
path.

Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Co-developed-by: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>
Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>
Co-developed-by: Mukesh Rathor <mukeshrathor@microsoft.com>
Signed-off-by: Mukesh Rathor <mukeshrathor@microsoft.com>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  7 +++++
 drivers/hv/hv_proc.c           | 47 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h | 10 ++++++++
 include/hyperv/hvgdk_mini.h    |  1 +
 include/hyperv/hvhdk_mini.h    | 12 +++++++++
 5 files changed, 77 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 235087456bdf..f653feea880b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -429,6 +429,10 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 #ifdef CONFIG_X86_64
+	/* If AP LPs exist, we are in a kexec'd kernel and VPs already exist */
+	if (num_present_cpus() == 1 || hv_lp_exists(1))
+		return;
+
 	for_each_present_cpu(i) {
 		if (i == 0)
 			continue;
@@ -436,6 +440,9 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 		BUG_ON(ret);
 	}
 
+	ret = hv_call_notify_all_processors_started();
+	WARN_ON(ret);
+
 	for_each_present_cpu(i) {
 		if (i == 0)
 			continue;
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 5f4fd9c3231c..63a48e5a02c5 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -239,3 +239,50 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hv_call_create_vp);
+
+int hv_call_notify_all_processors_started(void)
+{
+	struct hv_input_notify_partition_event *input;
+	u64 status;
+	unsigned long irq_flags;
+	int ret = 0;
+
+	local_irq_save(irq_flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->event = HV_PARTITION_ALL_LOGICAL_PROCESSORS_STARTED;
+	status = hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT,
+				 input, NULL);
+	local_irq_restore(irq_flags);
+
+	if (!hv_result_success(status)) {
+		hv_status_err(status, "\n");
+		ret = hv_result_to_errno(status);
+	}
+	return ret;
+}
+
+bool hv_lp_exists(u32 lp_index)
+{
+	struct hv_input_get_logical_processor_run_time *input;
+	struct hv_output_get_logical_processor_run_time *output;
+	unsigned long flags;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	input->lp_index = lp_index;
+	status = hv_do_hypercall(HVCALL_GET_LOGICAL_PROCESSOR_RUN_TIME,
+				 input, output);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status) &&
+	    hv_result(status) != HV_STATUS_INVALID_LP_INDEX) {
+		hv_status_err(status, "\n");
+		BUG();
+	}
+
+	return hv_result_success(status);
+}
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index d37b68238c97..bf601d67cecb 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -347,6 +347,8 @@ bool hv_result_needs_memory(u64 status);
 int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
+int hv_call_notify_all_processors_started(void);
+bool hv_lp_exists(u32 lp_index);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
 #else /* CONFIG_MSHV_ROOT */
@@ -366,6 +368,14 @@ static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
 {
 	return -EOPNOTSUPP;
 }
+static inline int hv_call_notify_all_processors_started(void)
+{
+	return -EOPNOTSUPP;
+}
+static inline bool hv_lp_exists(u32 lp_index)
+{
+	return false;
+}
 static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 {
 	return -EOPNOTSUPP;
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 056ef7b6b360..f2598e186550 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -435,6 +435,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 /* HV_CALL_CODE */
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE		0x0002
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST		0x0003
+#define HVCALL_GET_LOGICAL_PROCESSOR_RUN_TIME		0x0004
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT			0x0008
 #define HVCALL_SEND_IPI					0x000b
 #define HVCALL_ENABLE_VP_VTL				0x000f
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 091c03e26046..b4cb2fa26e9b 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -362,6 +362,7 @@ union hv_partition_event_input {
 
 enum hv_partition_event {
 	HV_PARTITION_EVENT_ROOT_CRASHDUMP = 2,
+	HV_PARTITION_ALL_LOGICAL_PROCESSORS_STARTED = 4,
 };
 
 struct hv_input_notify_partition_event {
@@ -369,6 +370,17 @@ struct hv_input_notify_partition_event {
 	union hv_partition_event_input input;
 } __packed;
 
+struct hv_input_get_logical_processor_run_time {
+	u32 lp_index;
+} __packed;
+
+struct hv_output_get_logical_processor_run_time {
+	u64 global_time;
+	u64 local_run_time;
+	u64 rsvdz0;
+	u64 hypervisor_time;
+} __packed;
+
 struct hv_lp_startup_status {
 	u64 hv_status;
 	u64 substatus1;
-- 
2.43.0


