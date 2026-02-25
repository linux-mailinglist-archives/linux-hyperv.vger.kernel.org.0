Return-Path: <linux-hyperv+bounces-8982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAYOJMfunmk/XwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8982-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:44:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936019788F
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26A953038395
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CFC3AE6F0;
	Wed, 25 Feb 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="a5D5hFSU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AD3B8BDC;
	Wed, 25 Feb 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023471; cv=pass; b=VszmOy/5UsQrSDAlw8I8kfre2Tv76+LzMaF2Ib8fAuqpf6aiFTSygO+Edl1HHXwqPeJis2XCVNwhU6i4n0UXoWa98yv2notpnSKHYJ2o2V77JIK0eJUkw+BlP+W05yKSpOjAt8s7AFlHtLm7qBNcqJzyPe0xu+IOv09UlQQi8l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023471; c=relaxed/simple;
	bh=CRbIdAoq3DLU5lbymx77lbmed7urdnYOTlWNibtDGYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiOxz4RewAYSqZZp7U7uBuitYsvLUd1QksxedEBNeTWJ6gwysT8zIFIYMzUescr2oFgp+R6Nh/aB/CEsHpzoKD/kGofHiEwfTN2VcLxmvKU8TFGlA+xAi5I2WG9lPzZ8goywqgYNE3+bQkYc080nQSNYxOMu9V3pBHkQuFEq5p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=a5D5hFSU; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1772023460; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NmwJH/nDrIdnWhUzzZtC5CbW0A96dXoeFnQjKWskSQNeq0R35Dncu0N449QLZR1LNiisdzjk9ovzGzieryJm52vqx/USOd7cwukaNqBdh0nGFKwZKURhD0xoQc8kHgUVJHfsBczj0fi3+hYzHB2v0vsUl3GIizbrpGVaf0CAyxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772023460; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fG+8vVFhZIped1F/mbSApTwZNbLnzNAsr70jFt/qte4=; 
	b=MArxvPCIjcIdhv8q2IDK3wVUOeKFmNuRWab8wgMIHITZSyPRBvfFT+vGBWCf4D5TDUtseSl9WytmHrT7gP9k3nsu3OyeXFRhh1uu8+NOHa8lPjxlcjeMLyNMGHu9HoDcrcwerNZhr7hZVuN1sgpTnR4+Oc8omsHU58kGwrBk8e8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772023460;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=fG+8vVFhZIped1F/mbSApTwZNbLnzNAsr70jFt/qte4=;
	b=a5D5hFSUi3iaADR2oy1Y/za+NjzWApzJbqy/Qqd4Z5tNwDjmcrsmCv1AxTdiuidE
	7zYGc7WwkfjGBdYYFrIcA6F6IfIJBIbNYJQS1a1ZnPv30bHWWTYJcf9bxPKR3KWoYpe
	3CvvuCu0eXO9u54/4BTCKCrvSEvFljW7jfp1IDqc=
Received: by mx.zohomail.com with SMTPS id 1772023458155385.9574680466594;
	Wed, 25 Feb 2026 04:44:18 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v6 1/2] mshv: refactor synic init and cleanup
Date: Wed, 25 Feb 2026 12:44:02 +0000
Message-Id: <20260225124403.2187880-2-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225124403.2187880-1-anirudh@anirudhrb.com>
References: <20260225124403.2187880-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[anirudhrb.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8982-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,anirudhrb.com:mid,anirudhrb.com:dkim,anirudhrb.com:email]
X-Rspamd-Queue-Id: 3936019788F
X-Rspamd-Action: no action

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Rename mshv_synic_init() to mshv_synic_cpu_init() and
mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
these functions handle per-cpu synic setup and teardown.

Use mshv_synic_init/cleanup() to perform init/cleanup that is not per-cpu.
Move all the synic related setup from mshv_parent_partition_init.

Move the reboot notifier to mshv_synic.c because it currently only
operates on the synic cpuhp state.

Move out synic_pages from the global mshv_root since its use is now
completely local to mshv_synic.c.

This is in preparation for the next patch which will add more stuff to
mshv_synic_init().

No functional change.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root.h      |  5 ++-
 drivers/hv/mshv_root_main.c | 64 +++++----------------------------
 drivers/hv/mshv_synic.c     | 71 +++++++++++++++++++++++++++++++++----
 3 files changed, 75 insertions(+), 65 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 04c2a1910a8a..826798f1a8ec 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -190,7 +190,6 @@ struct hv_synic_pages {
 };
 
 struct mshv_root {
-	struct hv_synic_pages __percpu *synic_pages;
 	spinlock_t pt_ht_lock;
 	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
 	struct hv_partition_property_vmm_capabilities vmm_caps;
@@ -249,8 +248,8 @@ int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
 void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
 
 void mshv_isr(void);
-int mshv_synic_init(unsigned int cpu);
-int mshv_synic_cleanup(unsigned int cpu);
+int mshv_synic_init(struct device *dev);
+void mshv_synic_exit(void);
 
 static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
 {
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e6509c980763..7fcde33d3e75 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2064,7 +2064,6 @@ mshv_dev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int mshv_cpuhp_online;
 static int mshv_root_sched_online;
 
 static const char *scheduler_type_to_string(enum hv_scheduler_type type)
@@ -2249,27 +2248,6 @@ root_scheduler_deinit(void)
 	free_percpu(root_scheduler_output);
 }
 
-static int mshv_reboot_notify(struct notifier_block *nb,
-			      unsigned long code, void *unused)
-{
-	cpuhp_remove_state(mshv_cpuhp_online);
-	return 0;
-}
-
-struct notifier_block mshv_reboot_nb = {
-	.notifier_call = mshv_reboot_notify,
-};
-
-static void mshv_root_partition_exit(void)
-{
-	unregister_reboot_notifier(&mshv_reboot_nb);
-}
-
-static int __init mshv_root_partition_init(struct device *dev)
-{
-	return register_reboot_notifier(&mshv_reboot_nb);
-}
-
 static int __init mshv_init_vmm_caps(struct device *dev)
 {
 	int ret;
@@ -2314,39 +2292,21 @@ static int __init mshv_parent_partition_init(void)
 			MSHV_HV_MAX_VERSION);
 	}
 
-	mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
-	if (!mshv_root.synic_pages) {
-		dev_err(dev, "Failed to allocate percpu synic page\n");
-		ret = -ENOMEM;
+	ret = mshv_synic_init(dev);
+	if (ret)
 		goto device_deregister;
-	}
-
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
-				mshv_synic_init,
-				mshv_synic_cleanup);
-	if (ret < 0) {
-		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
-		goto free_synic_pages;
-	}
-
-	mshv_cpuhp_online = ret;
 
 	ret = mshv_init_vmm_caps(dev);
 	if (ret)
-		goto remove_cpu_state;
+		goto synic_cleanup;
 
 	ret = mshv_retrieve_scheduler_type(dev);
 	if (ret)
-		goto remove_cpu_state;
-
-	if (hv_root_partition())
-		ret = mshv_root_partition_init(dev);
-	if (ret)
-		goto remove_cpu_state;
+		goto synic_cleanup;
 
 	ret = root_scheduler_init(dev);
 	if (ret)
-		goto exit_partition;
+		goto synic_cleanup;
 
 	ret = mshv_debugfs_init();
 	if (ret)
@@ -2367,13 +2327,8 @@ static int __init mshv_parent_partition_init(void)
 	mshv_debugfs_exit();
 deinit_root_scheduler:
 	root_scheduler_deinit();
-exit_partition:
-	if (hv_root_partition())
-		mshv_root_partition_exit();
-remove_cpu_state:
-	cpuhp_remove_state(mshv_cpuhp_online);
-free_synic_pages:
-	free_percpu(mshv_root.synic_pages);
+synic_cleanup:
+	mshv_synic_exit();
 device_deregister:
 	misc_deregister(&mshv_dev);
 	return ret;
@@ -2387,10 +2342,7 @@ static void __exit mshv_parent_partition_exit(void)
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
 	root_scheduler_deinit();
-	if (hv_root_partition())
-		mshv_root_partition_exit();
-	cpuhp_remove_state(mshv_cpuhp_online);
-	free_percpu(mshv_root.synic_pages);
+	mshv_synic_exit();
 }
 
 module_init(mshv_parent_partition_init);
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index f8b0337cdc82..f716c2a4952f 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -12,11 +12,16 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/random.h>
+#include <linux/cpuhotplug.h>
+#include <linux/reboot.h>
 #include <asm/mshyperv.h>
 
 #include "mshv_eventfd.h"
 #include "mshv.h"
 
+static int synic_cpuhp_online;
+static struct hv_synic_pages __percpu *synic_pages;
+
 static u32 synic_event_ring_get_queued_port(u32 sint_index)
 {
 	struct hv_synic_event_ring_page **event_ring_page;
@@ -26,7 +31,7 @@ static u32 synic_event_ring_get_queued_port(u32 sint_index)
 	u32 message;
 	u8 tail;
 
-	spages = this_cpu_ptr(mshv_root.synic_pages);
+	spages = this_cpu_ptr(synic_pages);
 	event_ring_page = &spages->synic_event_ring_page;
 	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
 
@@ -393,7 +398,7 @@ mshv_intercept_isr(struct hv_message *msg)
 
 void mshv_isr(void)
 {
-	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_message *msg;
 	bool handled;
@@ -446,7 +451,7 @@ void mshv_isr(void)
 	}
 }
 
-int mshv_synic_init(unsigned int cpu)
+static int mshv_synic_cpu_init(unsigned int cpu)
 {
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
@@ -455,7 +460,7 @@ int mshv_synic_init(unsigned int cpu)
 	union hv_synic_sint sint;
 #endif
 	union hv_synic_scontrol sctrl;
-	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
 			&spages->synic_event_flags_page;
@@ -542,14 +547,14 @@ int mshv_synic_init(unsigned int cpu)
 	return -EFAULT;
 }
 
-int mshv_synic_cleanup(unsigned int cpu)
+static int mshv_synic_cpu_exit(unsigned int cpu)
 {
 	union hv_synic_sint sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sirbp sirbp;
 	union hv_synic_scontrol sctrl;
-	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
 	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
 	struct hv_synic_event_flags_page **event_flags_page =
 		&spages->synic_event_flags_page;
@@ -663,3 +668,57 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
 
 	mshv_portid_free(doorbell_portid);
 }
+
+static int mshv_synic_reboot_notify(struct notifier_block *nb,
+			      unsigned long code, void *unused)
+{
+	if (!hv_root_partition())
+		return 0;
+
+	cpuhp_remove_state(synic_cpuhp_online);
+	return 0;
+}
+
+static struct notifier_block mshv_synic_reboot_nb = {
+	.notifier_call = mshv_synic_reboot_notify,
+};
+
+int __init mshv_synic_init(struct device *dev)
+{
+	int ret = 0;
+
+	synic_pages = alloc_percpu(struct hv_synic_pages);
+	if (!synic_pages) {
+		dev_err(dev, "Failed to allocate percpu synic page\n");
+		return -ENOMEM;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
+				mshv_synic_cpu_init,
+				mshv_synic_cpu_exit);
+	if (ret < 0) {
+		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
+		goto free_synic_pages;
+	}
+
+	synic_cpuhp_online = ret;
+
+	ret = register_reboot_notifier(&mshv_synic_reboot_nb);
+	if (ret)
+		goto remove_cpuhp_state;
+
+	return 0;
+
+remove_cpuhp_state:
+	cpuhp_remove_state(synic_cpuhp_online);
+free_synic_pages:
+	free_percpu(synic_pages);
+	return ret;
+}
+
+void mshv_synic_exit(void)
+{
+	unregister_reboot_notifier(&mshv_synic_reboot_nb);
+	cpuhp_remove_state(synic_cpuhp_online);
+	free_percpu(synic_pages);
+}
-- 
2.34.1


