Return-Path: <linux-hyperv+bounces-8663-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDO4AQ37gGn9DQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8663-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 20:29:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BBD0857
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 20:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C4F30420A4
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997852FCC04;
	Mon,  2 Feb 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V9PocpdJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F042DC763;
	Mon,  2 Feb 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060368; cv=none; b=bIQFOkkEf+z97gIMepFPe/ydQpcDBsvIXKxx+EqIfLzcjt6IX5MUZBBIPG7G6SrurUW6l55IZK4JFgalcMLhaapft3MitfLTsyNUHEmRbzurIBVqVnPLlcvmPORnzCfw6ZhfTCYTsg+OqzxoAJznHuGIuFKN8M/4lTEMcARXJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060368; c=relaxed/simple;
	bh=WVsraIDRQVFQ3yk8ovIarqO7/uE4uTz9UHOF0U92leU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=CmL4Ppo4EkFiC8EXNUXJow2vW+j5KbFRcbuL0xyjz57r3x3izTs92UWLcKvMmx6xk5Y9h2+gBJE5dKk9pP1cUF0k7DrE4oP+9A8n0kE4sX8VxtxgqqlYLstruHSsGlRFxDkI0fp6FMk7AWookZV+Bzz4wTksDn1zNFxHID7RFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V9PocpdJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D99CF20B7168;
	Mon,  2 Feb 2026 11:26:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D99CF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770060366;
	bh=4jkWTwnX2y1YPmZjAizxc+4zTZ+ksMazcV6I0G5GzWQ=;
	h=Subject:From:To:Cc:Date:From;
	b=V9PocpdJQWKzvtnOayjupI3cL47HO63oG00ZvlVs7nUtfFt3JBtWpPSMyyo5J7ta/
	 vsdZ96DUD3IF42vBmhYn87mW+/QVJk5vNjridTv2b9S0JukKKeMEAau0v8AtlOvWde
	 TygQ0ZSsRKh3xBGspkodc+PCjDE2QyvgAer+Z3VU=
Subject: [PATCH v4] mshv: Add support for integrated scheduler
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 19:26:06 +0000
Message-ID: 
 <177006034399.132128.8748943595417271449.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8663-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 5C4BBD0857
X-Rspamd-Action: no action

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
logic; otherwise, it must use the core scheduler. This requirement makes
reading VMM capabilities in L1VH partition a requirement too.

Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   82 ++++++++++++++++++++++++++-----------------
 include/hyperv/hvhdk_mini.h |    7 +++-
 2 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 1134a82c7881..006dd9e68c27 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2053,6 +2053,29 @@ static const char *scheduler_type_to_string(enum hv_scheduler_type type)
 	};
 }
 
+static int __init l1vh_retrieve_scheduler_type(enum hv_scheduler_type *out)
+{
+	u64 integrated_sched_enabled;
+	int ret;
+
+	*out = HV_SCHEDULER_TYPE_CORE_SMT;
+
+	if (!mshv_root.vmm_caps.vmm_enable_integrated_scheduler)
+		return 0;
+
+	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
+						HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED,
+						0, &integrated_sched_enabled,
+						sizeof(integrated_sched_enabled));
+	if (ret)
+		return ret;
+
+	if (integrated_sched_enabled)
+		*out = HV_SCHEDULER_TYPE_ROOT;
+
+	return 0;
+}
+
 /* TODO move this to hv_common.c when needed outside */
 static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
 {
@@ -2085,13 +2108,12 @@ static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
 /* Retrieve and stash the supported scheduler type */
 static int __init mshv_retrieve_scheduler_type(struct device *dev)
 {
-	int ret = 0;
+	int ret;
 
 	if (hv_l1vh_partition())
-		hv_scheduler_type = HV_SCHEDULER_TYPE_CORE_SMT;
+		ret = l1vh_retrieve_scheduler_type(&hv_scheduler_type);
 	else
 		ret = hv_retrieve_scheduler_type(&hv_scheduler_type);
-
 	if (ret)
 		return ret;
 
@@ -2211,42 +2233,29 @@ struct notifier_block mshv_reboot_nb = {
 static void mshv_root_partition_exit(void)
 {
 	unregister_reboot_notifier(&mshv_reboot_nb);
-	root_scheduler_deinit();
 }
 
 static int __init mshv_root_partition_init(struct device *dev)
 {
-	int err;
-
-	err = root_scheduler_init(dev);
-	if (err)
-		return err;
-
-	err = register_reboot_notifier(&mshv_reboot_nb);
-	if (err)
-		goto root_sched_deinit;
-
-	return 0;
-
-root_sched_deinit:
-	root_scheduler_deinit();
-	return err;
+	return register_reboot_notifier(&mshv_reboot_nb);
 }
 
-static void mshv_init_vmm_caps(struct device *dev)
+static int __init mshv_init_vmm_caps(struct device *dev)
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
+	if (ret && hv_l1vh_partition()) {
+		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
+		return ret;
+	}
 
 	dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
+
+	return 0;
 }
 
 static int __init mshv_parent_partition_init(void)
@@ -2292,6 +2301,10 @@ static int __init mshv_parent_partition_init(void)
 
 	mshv_cpuhp_online = ret;
 
+	ret = mshv_init_vmm_caps(dev);
+	if (ret)
+		goto remove_cpu_state;
+
 	ret = mshv_retrieve_scheduler_type(dev);
 	if (ret)
 		goto remove_cpu_state;
@@ -2301,11 +2314,13 @@ static int __init mshv_parent_partition_init(void)
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
@@ -2314,6 +2329,8 @@ static int __init mshv_parent_partition_init(void)
 
 	return 0;
 
+deinit_root_scheduler:
+	root_scheduler_deinit();
 exit_partition:
 	if (hv_root_partition())
 		mshv_root_partition_exit();
@@ -2332,6 +2349,7 @@ static void __exit mshv_parent_partition_exit(void)
 	mshv_port_table_fini();
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
+	root_scheduler_deinit();
 	if (hv_root_partition())
 		mshv_root_partition_exit();
 	cpuhp_remove_state(mshv_cpuhp_online);
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 41a29bf8ec14..c0300910808b 100644
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
-#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	59
+#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	57
 
 struct hv_partition_property_vmm_capabilities {
 	u16 bank_count;
@@ -119,6 +122,8 @@ struct hv_partition_property_vmm_capabilities {
 			u64 reservedbit3: 1;
 #endif
 			u64 assignable_synthetic_proc_features: 1;
+			u64 reservedbit5: 1;
+			u64 vmm_enable_integrated_scheduler : 1;
 			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
 		} __packed;
 	};



