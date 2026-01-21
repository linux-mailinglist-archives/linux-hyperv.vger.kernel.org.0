Return-Path: <linux-hyperv+bounces-8441-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHI0Ke5UcWkNEwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8441-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:36:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E65EE4E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 313E43A9DF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524B7441036;
	Wed, 21 Jan 2026 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EIImNe+3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A8425CC7;
	Wed, 21 Jan 2026 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034962; cv=none; b=QwUAhRZc6Yvu1yBecCmHUrkAbxM5MQXii+s14c+kC5m1b5ogrHRiivRBoplZ2yEV9IaqxcI40znQcXpoagJrxspjBOZd0Y9AmT/mW9Wd8DR81uTlPpvd7OKoJ225XCxzXJkV6nz1u7aQVA0B/7W1YL/lWan3vhCL/46BcHkRGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034962; c=relaxed/simple;
	bh=UKhe/QqQJfw+xZryhcCvtf4xQCv+rNEBFhctc6Jlto8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNwI02osC43KPxyqTKYLgbKwjL2DQi8Oc3uxU72uUOXyUHIvsWhZmhhVW1R3a6U3P+ysyHhlZfUu3Ss3a5zvlaTeY/82dVoAGhdf3LnuT6phEyOo8tCi2sqXNb+7zSBuCvC5C7kKk/QbTSFaHkxoRi9OwCzewwygelbpdme4tXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EIImNe+3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id C96C820B716F;
	Wed, 21 Jan 2026 14:35:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C96C820B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769034959;
	bh=f5mu1hGAzQ3IXvctHZbv9iQJl30R2IN56PnohRPYPcU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EIImNe+3mPX/M86bUtaBdFW5oOw+gVVSWusx4PfAKs2QtXvSxSrMo3tWAH1zuYY9M
	 8E3nEGcnbJYToBMXMqghe3kXgpDMoqx+PKka+w0O/QOZ95yZqS/5cUjIKWzo0uPD13
	 J83U8uWDmfxWaf4vzaXd1Z19PfPalko5kNi4BiBk=
Subject: [PATCH 2/2] mshv: Add support for integrated scheduler
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Jan 2026 22:35:59 +0000
Message-ID: 
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8441-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[213.196.21.55:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[4.155.116.186:received,13.77.154.182:received,52.25.139.140:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 890E65EE4E
X-Rspamd-Action: no action

From: Andreea Pintilie <anpintil@microsoft.com>

Query the hypervisor for integrated scheduler support and use it if
configured.

Microsoft Hypervisor originally provided two schedulers: root and core. The
root scheduler allows the root partition to schedule guest vCPUs across
physical cores, supporting both time slicing and CPU affinity (e.g., via
cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
scheduling entirely to the hypervisor.

Direct virtualization introduces a new privileged guest partition type - L1
Virtual Host (L1VH) — which can create child partitions from its own
resources. These child partitions are effectively siblings, scheduled by
the hypervisor's core scheduler. This prevents the L1VH parent from setting
affinity or time slicing for its own processes or guest VPs. While cgroups,
CFS, and cpuset controllers can still be used, their effectiveness is
unpredictable, as the core scheduler swaps vCPUs according to its own logic
(typically round-robin across all allocated physical CPUs). As a result,
the system may appear to "steal" time from the L1VH and its children.

To address this, Microsoft Hypervisor introduces the integrated scheduler.
This allows an L1VH partition to schedule its own vCPUs and those of its
guests across its "physical" cores, effectively emulating root scheduler
behavior within the L1VH, while retaining core scheduler behavior for the
rest of the system.

The integrated scheduler is controlled by the root partition and gated by
the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
supports the integrated scheduler. The L1VH partition must then check if it
is enabled by querying the corresponding extended partition property. If
this property is true, the L1VH partition must use the root scheduler
logic; otherwise, it must use the core scheduler.

Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   79 +++++++++++++++++++++++++++++--------------
 include/hyperv/hvhdk_mini.h |    6 +++
 2 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 1134a82c7881..7a36297feea7 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2053,6 +2053,32 @@ static const char *scheduler_type_to_string(enum hv_scheduler_type type)
 	};
 }
 
+static int __init l1vh_retrive_scheduler_type(enum hv_scheduler_type *out)
+{
+	size_t root_sched_enabled;
+	int ret;
+
+	*out = HV_SCHEDULER_TYPE_CORE_SMT;
+
+	if (!mshv_root.vmm_caps.vmm_enable_integrated_scheduler)
+		return 0;
+
+	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
+						HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED,
+						0, &root_sched_enabled,
+						sizeof(root_sched_enabled));
+	if (ret)
+		return ret;
+
+	if (root_sched_enabled)
+		*out = HV_SCHEDULER_TYPE_ROOT;
+
+	pr_debug("%s: integrated scheduler property read: ret=%d value=%lu\n",
+		 __func__, ret, root_sched_enabled);
+
+	return 0;
+}
+
 /* TODO move this to hv_common.c when needed outside */
 static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
 {
@@ -2085,13 +2111,12 @@ static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
 /* Retrieve and stash the supported scheduler type */
 static int __init mshv_retrieve_scheduler_type(struct device *dev)
 {
-	int ret = 0;
+	int ret;
 
 	if (hv_l1vh_partition())
-		hv_scheduler_type = HV_SCHEDULER_TYPE_CORE_SMT;
+		ret = l1vh_retrive_scheduler_type(&hv_scheduler_type);
 	else
 		ret = hv_retrieve_scheduler_type(&hv_scheduler_type);
-
 	if (ret)
 		return ret;
 
@@ -2211,42 +2236,35 @@ struct notifier_block mshv_reboot_nb = {
 static void mshv_root_partition_exit(void)
 {
 	unregister_reboot_notifier(&mshv_reboot_nb);
-	root_scheduler_deinit();
 }
 
 static int __init mshv_root_partition_init(struct device *dev)
 {
 	int err;
 
-	err = root_scheduler_init(dev);
-	if (err)
-		return err;
-
 	err = register_reboot_notifier(&mshv_reboot_nb);
 	if (err)
-		goto root_sched_deinit;
+		return err;
 
 	return 0;
-
-root_sched_deinit:
-	root_scheduler_deinit();
-	return err;
 }
 
-static void mshv_init_vmm_caps(struct device *dev)
+static int mshv_init_vmm_caps(struct device *dev)
 {
-	/*
-	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
-	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
-	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
-	 */
-	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
-					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
-					      0, &mshv_root.vmm_caps,
-					      sizeof(mshv_root.vmm_caps)))
-		dev_warn(dev, "Unable to get VMM capabilities\n");
+	int ret;
+
+	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
+						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
+						0, &mshv_root.vmm_caps,
+						sizeof(mshv_root.vmm_caps));
+	if (ret) {
+		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
+		return ret;
+	}
 
 	dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
+
+	return 0;
 }
 
 static int __init mshv_parent_partition_init(void)
@@ -2292,6 +2310,10 @@ static int __init mshv_parent_partition_init(void)
 
 	mshv_cpuhp_online = ret;
 
+	ret = mshv_init_vmm_caps(dev);
+	if (ret)
+		goto remove_cpu_state;
+
 	ret = mshv_retrieve_scheduler_type(dev);
 	if (ret)
 		goto remove_cpu_state;
@@ -2301,11 +2323,13 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto remove_cpu_state;
 
-	mshv_init_vmm_caps(dev);
+	ret = root_scheduler_init(dev);
+	if (ret)
+		goto exit_partition;
 
 	ret = mshv_irqfd_wq_init();
 	if (ret)
-		goto exit_partition;
+		goto deinit_root_scheduler;
 
 	spin_lock_init(&mshv_root.pt_ht_lock);
 	hash_init(mshv_root.pt_htable);
@@ -2314,6 +2338,8 @@ static int __init mshv_parent_partition_init(void)
 
 	return 0;
 
+deinit_root_scheduler:
+	root_scheduler_deinit();
 exit_partition:
 	if (hv_root_partition())
 		mshv_root_partition_exit();
@@ -2332,6 +2358,7 @@ static void __exit mshv_parent_partition_exit(void)
 	mshv_port_table_fini();
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
+	root_scheduler_deinit();
 	if (hv_root_partition())
 		mshv_root_partition_exit();
 	cpuhp_remove_state(mshv_cpuhp_online);
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index aa03616f965b..0f7178fa88a8 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -87,6 +87,9 @@ enum hv_partition_property_code {
 	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
 	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES		= 0x00010001,
 
+	/* Integrated scheduling properties */
+	HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED	= 0x00020005,
+
 	/* Resource properties */
 	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING		= 0x00050005,
 	HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION		= 0x00050017,
@@ -102,7 +105,7 @@ enum hv_partition_property_code {
 };
 
 #define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
-#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	58
+#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	57
 
 struct hv_partition_property_vmm_capabilities {
 	u16 bank_count;
@@ -120,6 +123,7 @@ struct hv_partition_property_vmm_capabilities {
 #endif
 			u64 assignable_synthetic_proc_features: 1;
 			u64 tag_hv_message_from_child: 1;
+			u64 vmm_enable_integrated_scheduler : 1;
 			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
 		} __packed;
 	};



