Return-Path: <linux-hyperv+bounces-8781-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGBqHnK3jGnlsQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8781-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:08:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9673A1266DA
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2832D3004CBA
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424B346769;
	Wed, 11 Feb 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="IGZ41Mg+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721D34575A;
	Wed, 11 Feb 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829675; cv=pass; b=Y5EAn6f2zytElCHmhkTQwugzETsxGcxIRZLSsdMa/w8sueBt8JupYrrwdWKci5uj0li9sP+91Fp8eHfOWZNnLnBry24tDANN4O9KiY13rXjgyKtX6t8ctAzl9f69iNzmT5lIPP8jmVAuco+9UBZ8SzRUeCMmvODIHdy+mMp0/hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829675; c=relaxed/simple;
	bh=1xxvT3Kg/iBSXBR9OzxkfsDxJiscX72o/Y1BvlTRM3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f74/YiVCxaDEIwQr6PlZ6qNVqEQc/WIuUMRnjL1hEQmbciwBC1IeWZW1ar7w+W0Me4VHWZSgvEOc/NyIAWR496JLB7MuyIdKvbvm8PtRi/Uzb4yvX9TZ83XshsJWZGxIYGuuv3XOCr0nxmeGyujtp+cGmOeDM+z4Y1DCRebGcoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=IGZ41Mg+; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770829667; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XL9NCRXH8u77kGjjGDkMFlR5bwCO8RVxmh1mQ0wMWsX7WkyVN549J+6Tkn4uVObMjqGhVgnal0n//XqAEQDcmJgyuO9fOnKt1mfIq+8l19llJHvwof3woET79eWTz9eYm8xabTVu19GbZxFWfG2vBz2FntyllEYog2OJfwbWA7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770829667; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ljSpnXCWzU5CBVVyspBfoSk6H97ioubmGofKkf0JI1c=; 
	b=DsS7LPLhdvHf0zkKsn7FOedsqtg+8Ga4BjzHTm2TszLeWLEhKuH7jLEId0gjVh3Jhj+TZw0Lyf4M+XqoB4uVqvdZ5y9dyp+hhUCWQ5ACiZL26y+Rn/dsov9k2XZBrRul5BkqZGFSsMYZw/oOs9PKMBo/uwQKArsObJLtaa7Opzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770829667;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ljSpnXCWzU5CBVVyspBfoSk6H97ioubmGofKkf0JI1c=;
	b=IGZ41Mg+HaBZA0ftTLeyYrZ8qGZd6q95Ot7/QuvxgHJb6jnn3wE6fYioG/H92bT6
	+UwqfI5giVSEV52AHUO5Tpsw43NkWrnU/dwYKALbOIRWOqZQ9bj/Yr2LhggFqyB0a8G
	STfHkQ0nPNLzh36JebDmBtzFnL9ush0KUCTqhaVA=
Received: by mx.zohomail.com with SMTPS id 1770829665530260.5854724292375;
	Wed, 11 Feb 2026 09:07:45 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v4 1/2] mshv: refactor synic init and cleanup
Date: Wed, 11 Feb 2026 17:07:27 +0000
Message-Id: <20260211170728.3056226-2-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211170728.3056226-1-anirudh@anirudhrb.com>
References: <20260211170728.3056226-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8781-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9673A1266DA
X-Rspamd-Action: no action

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Rename mshv_synic_init() to mshv_synic_cpu_init() and
mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
these functions handle per-cpu synic setup and teardown.

Use mshv_synic_init/cleanup() to perform init/cleanup that is not per-cpu.
Move all the synic related setup from mshv_parent_partition_init.

Move the reboot notifier to mshv_synic.c because it currently only
operates on the synic cpuhp state.

Move out synic_pages from the global mshv_root since it's use is now
completely local to mshv_synic.c.

This is in preparation for the next patch which will add more stuff to
mshv_synic_init().

No functional change.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root.h      |  5 ++-
 drivers/hv/mshv_root_main.c | 59 +++++-------------------------
 drivers/hv/mshv_synic.c     | 71 +++++++++++++++++++++++++++++++++----
 3 files changed, 75 insertions(+), 60 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3c1d88b36741..26e0320c8097 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -183,7 +183,6 @@ struct hv_synic_pages {
 };
 
 struct mshv_root {
-	struct hv_synic_pages __percpu *synic_pages;
 	spinlock_t pt_ht_lock;
 	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
 	struct hv_partition_property_vmm_capabilities vmm_caps;
@@ -242,8 +241,8 @@ int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
 void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
 
 void mshv_isr(void);
-int mshv_synic_init(unsigned int cpu);
-int mshv_synic_cleanup(unsigned int cpu);
+int mshv_synic_init(struct device *dev);
+void mshv_synic_cleanup(void);
 
 static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
 {
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 681b58154d5e..7c1666456e78 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2035,7 +2035,6 @@ mshv_dev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int mshv_cpuhp_online;
 static int mshv_root_sched_online;
 
 static const char *scheduler_type_to_string(enum hv_scheduler_type type)
@@ -2198,40 +2197,14 @@ root_scheduler_deinit(void)
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
 static void mshv_root_partition_exit(void)
 {
-	unregister_reboot_notifier(&mshv_reboot_nb);
 	root_scheduler_deinit();
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
+	return root_scheduler_init(dev);
 }
 
 static void mshv_init_vmm_caps(struct device *dev)
@@ -2276,31 +2249,18 @@ static int __init mshv_parent_partition_init(void)
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
 
 	ret = mshv_retrieve_scheduler_type(dev);
 	if (ret)
-		goto remove_cpu_state;
+		goto synic_cleanup;
 
 	if (hv_root_partition())
 		ret = mshv_root_partition_init(dev);
 	if (ret)
-		goto remove_cpu_state;
+		goto synic_cleanup;
 
 	mshv_init_vmm_caps(dev);
 
@@ -2318,10 +2278,8 @@ static int __init mshv_parent_partition_init(void)
 exit_partition:
 	if (hv_root_partition())
 		mshv_root_partition_exit();
-remove_cpu_state:
-	cpuhp_remove_state(mshv_cpuhp_online);
-free_synic_pages:
-	free_percpu(mshv_root.synic_pages);
+synic_cleanup:
+	mshv_synic_cleanup();
 device_deregister:
 	misc_deregister(&mshv_dev);
 	return ret;
@@ -2335,8 +2293,7 @@ static void __exit mshv_parent_partition_exit(void)
 	mshv_irqfd_wq_cleanup();
 	if (hv_root_partition())
 		mshv_root_partition_exit();
-	cpuhp_remove_state(mshv_cpuhp_online);
-	free_percpu(mshv_root.synic_pages);
+	mshv_synic_cleanup();
 }
 
 module_init(mshv_parent_partition_init);
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index f8b0337cdc82..074e37c48876 100644
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
+void mshv_synic_cleanup(void)
+{
+	unregister_reboot_notifier(&mshv_synic_reboot_nb);
+	cpuhp_remove_state(synic_cpuhp_online);
+	free_percpu(synic_pages);
+}
-- 
2.34.1


