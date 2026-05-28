Return-Path: <linux-hyperv+bounces-11284-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOuPDsuPF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11284-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27005EB556
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AEF8305B8FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920326E718;
	Thu, 28 May 2026 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RNhNwfkY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51F23536B;
	Thu, 28 May 2026 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928965; cv=none; b=QWFCsQ7H04f+ijIsyz/7+4T3RWb6PHDQUupO2pZIKi3WACUTrAd2nH5ihLIfAB4h2PG7AvkCiJ87wUXboczYBOZZ8RcYQ9IMXziDVNhvmLLOeCM032FNO3U7lNMW9u4/BrecgEbxfRs76Qbkaihb1g4kXVpILfgsOYrx7s2IxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928965; c=relaxed/simple;
	bh=jIC4CKCBiGTOGbgSVoLk/6jmXjT4BsQEE7tn8PJKOVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVcxr4wtiDVF2wJPf2eJkew2K3FIWX6noj+kQeIbAZd8aHZiTco/56yJ9hma63jN6g1zseW3Kk7+hC2ckwuLu+4v3MB07RFvjoVGkE/3XuE4m7wX6udhq3RaF2LcQpmvMSsRI5l45xeWto6vXBPmaLoeEljMM8C59P/41aPIb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RNhNwfkY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 0D42720B7188; Wed, 27 May 2026 17:42:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D42720B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928949;
	bh=O/QO0IpAqcokJA6roh58O/Dw9JAaJxaD1pnU8pzdaMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNhNwfkYgRd2z9VAjNzOknS7yjNRlafAg2Sr4b+cJtD9q5C2zRLIhO4C4LynVYtHk
	 4Ry6qcr50ntQnVAhBXFA6Bx1CCL383brJc5waKn3rYwtXRwPqmg4nSufrnA2bub7f0
	 D0sEXD6vVJl8WPuGxUp2NavOwL2Cxl8OiG6reNzk=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 20/20] mshv: freeze and vacuum partitions across kexec
Date: Wed, 27 May 2026 17:42:02 -0700
Message-ID: <20260528004204.1484584-21-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11284-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: D27005EB556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Before kexec the kernel must ensure no VMs are actively running so that
no VP modifies VM-memory that Linux will re-use post-kexec, and record
the partition IDs so the next kernel can clean them up.

Add mshv_freeze_and_get_partition_ids() which:
- Sets a global frozen flag to block new partition and VP creation
- Prevents (re-)dispatching of existing VPs
- Kicks all VPs to exit their dispatch loops, then waits for each to
  finish by acquiring its mutex
- Tears down doorbell ports owned by the parent partition, which
  otherwise survive kexec and cause port ID collisions in the new kernel
- Collects all partition IDs into a kho_alloc_preserve()'d array

The freeze is triggered from the reboot notifier callback. The ID
array is serialized into the KHO FDT so the next kernel can retrieve
it via mshv_retrieve_frozen_partition_ids().

After kexec the previous kernel's partitions are still alive in the
hypervisor. vacuum_stale_partitions() retrieves their IDs from the
KHO-preserved FDT and tears each one down (finalize, withdraw
deposited memory, delete) so the pages become available to the new
kernel.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_page_preserve.c | 100 +++++++++-
 drivers/hv/mshv_page_preserve.h |   3 +
 drivers/hv/mshv_root.h          |   2 +
 drivers/hv/mshv_root_main.c     | 339 +++++++++++++++++++++++++++++---
 4 files changed, 417 insertions(+), 27 deletions(-)

diff --git a/drivers/hv/mshv_page_preserve.c b/drivers/hv/mshv_page_preserve.c
index e16fb946790d..dba7975ab058 100644
--- a/drivers/hv/mshv_page_preserve.c
+++ b/drivers/hv/mshv_page_preserve.c
@@ -24,6 +24,8 @@
 
 static void *fdt_page;
 static struct kho_radix_tree preserved_pages_tree;
+static u64 *frozen_partition_ids;
+static unsigned int nr_frozen_partition_ids;
 
 /**
  * mshv_register_preserve_page() - Register a page to be preserved by KHO
@@ -78,7 +80,7 @@ static int preserve_table_cb(phys_addr_t phys, void *data)
 	return kho_preserve_pages(phys_to_page(phys), 1);
 }
 
-static int create_fdt(void)
+static int create_fdt(u64 *partition_ids, unsigned int nr_partition_ids)
 {
 	int err;
 	void *fdt;
@@ -106,6 +108,19 @@ static int create_fdt(void)
 	err = fdt_property(fdt, "root_table", &root_table, sizeof(root_table));
 	if (err)
 		return err;
+	if (nr_partition_ids) {
+		phys_addr_t ids_pa = virt_to_phys(partition_ids);
+		u32 count = nr_partition_ids;
+
+		err = fdt_property(fdt, "partition_ids", &ids_pa,
+				   sizeof(ids_pa));
+		if (err)
+			return err;
+		err = fdt_property(fdt, "nr_partition_ids", &count,
+				   sizeof(count));
+		if (err)
+			return err;
+	}
 	err = fdt_end_node(fdt);
 	if (err)
 		return err;
@@ -118,6 +133,8 @@ static int create_fdt(void)
 
 /**
  * preserve_tree() - Preserve pages owned by Microsoft Hypervisor
+ * @partition_ids: array of frozen partition IDs to serialize, or NULL
+ * @nr_partition_ids: number of entries in @partition_ids
  *
  * This gets called prior to kexec and is our signal to finally preserve the
  * pages with KHO, and create & register the named FDT. We also need to freeze
@@ -125,7 +142,7 @@ static int create_fdt(void)
  *
  * Return: 0 on success, -errno on error.
  */
-static int preserve_tree(void)
+static int preserve_tree(u64 *partition_ids, unsigned int nr_partition_ids)
 {
 	const struct kho_radix_walk_cb preserve_cb = {
 		.key = preserve_key_cb,
@@ -141,7 +158,7 @@ static int preserve_tree(void)
 	}
 
 	/* Populate the pre-allocated FDT page with current tree state */
-	err = create_fdt();
+	err = create_fdt(partition_ids, nr_partition_ids);
 	if (err) {
 		pr_warn("%s() - create_fdt() failed: %d\n", __func__, err);
 		return err;
@@ -177,6 +194,11 @@ static int preserve_tree(void)
 /*
  * Reboot-callback triggering page preservation prior to kexec. Other reboots
  * need no KHO preservation.
+ *
+ * The mshv_root module's higher-priority reboot notifier freezes all VPs
+ * and hands off partition IDs via mshv_set_frozen_partition_ids() before
+ * this callback runs. If the module is not loaded, no partitions exist
+ * and the tree is preserved without partition IDs.
  */
 static int reboot_cb(struct notifier_block *nb, unsigned long action,
 		     void *data)
@@ -185,9 +207,9 @@ static int reboot_cb(struct notifier_block *nb, unsigned long action,
 	if (kexec_in_progress) {
 		int err;
 
-		/* Finalize handover: write KHO descriptors, flush metadata */
 		pr_debug("%s() - KHO-preserving page tree\n", __func__);
-		err = preserve_tree();
+		err = preserve_tree(frozen_partition_ids,
+				    nr_frozen_partition_ids);
 		if (err)
 			panic("preserve_tree() failed - must not kexec: %d\n",
 			      err);
@@ -260,6 +282,74 @@ static int __init restore_tree(void)
 	return 0;
 }
 
+/**
+ * mshv_set_frozen_partition_ids() - Hand off frozen partition IDs for KHO
+ * @ids: kho_alloc_preserve()'d array of partition IDs, or NULL
+ * @nr: number of entries in @ids
+ *
+ * Called by the mshv_root module's reboot notifier (which runs at higher
+ * priority) to pass the frozen partition ID list to the built-in page
+ * preservation code before it serializes the KHO FDT.
+ */
+void mshv_set_frozen_partition_ids(u64 *ids, unsigned int nr)
+{
+	frozen_partition_ids = ids;
+	nr_frozen_partition_ids = nr;
+}
+EXPORT_SYMBOL_GPL(mshv_set_frozen_partition_ids);
+
+/**
+ * mshv_retrieve_frozen_partition_ids() - Retrieve frozen partition IDs
+ * @partition_ids: receives pointer to the preserved ID array, or NULL
+ * @nr_ids: receives the number of entries, or 0
+ *
+ * Counterpart to mshv_freeze_and_get_partition_ids(). Reads the partition
+ * ID list from the KHO-preserved FDT. The returned pointer (if non-NULL)
+ * refers to kho_alloc_preserve()'d memory from the previous kernel.
+ *
+ * Return: 0 on success (including when no IDs are found), negative errno on
+ *  error.
+ */
+int mshv_retrieve_frozen_partition_ids(u64 **partition_ids,
+				       unsigned int *nr_ids)
+{
+	int node, len;
+	const phys_addr_t *ids_pa;
+	const u32 *count_prop;
+
+	*partition_ids = NULL;
+	*nr_ids = 0;
+
+	if (!fdt_page)
+		return 0;
+
+	node = fdt_path_offset(fdt_page, "/");
+	if (node < 0)
+		return 0;
+
+	ids_pa = fdt_getprop(fdt_page, node, "partition_ids", &len);
+	if (!ids_pa)
+		return 0;
+
+	if (len != sizeof(*ids_pa)) {
+		pr_err("Malformed preserved FDT: invalid partition_ids property.\n");
+		return -EINVAL;
+	}
+
+	count_prop = fdt_getprop(fdt_page, node, "nr_partition_ids", &len);
+	if (!count_prop || len != sizeof(*count_prop)) {
+		pr_err("Malformed preserved FDT: invalid nr_partition_ids property.\n");
+		return -EINVAL;
+	}
+
+	*partition_ids = phys_to_virt(*ids_pa);
+	*nr_ids = *count_prop;
+
+	pr_info("Retrieved %u frozen partition ID(s) from KHO\n", *nr_ids);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mshv_retrieve_frozen_partition_ids);
+
 /*
  * Restore individual pages using KHO's helper during boot.
  *
diff --git a/drivers/hv/mshv_page_preserve.h b/drivers/hv/mshv_page_preserve.h
index ac99b4e33285..4625d59a3070 100644
--- a/drivers/hv/mshv_page_preserve.h
+++ b/drivers/hv/mshv_page_preserve.h
@@ -14,5 +14,8 @@ int mshv_preserve_init(void);
 int mshv_register_preserve_page(struct page *pg);
 int mshv_unregister_preserve_page(struct page *pg);
 int mshv_iterate_preserved(const struct kho_radix_walk_cb *cb, void *data);
+void mshv_set_frozen_partition_ids(u64 *ids, unsigned int nr);
+int mshv_retrieve_frozen_partition_ids(u64 **partition_ids,
+				       unsigned int *nr_ids);
 
 #endif /* _MSHV_PAGE_PRESERVE_H */
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 216053f8e0ab..7476398d3b47 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -195,6 +195,7 @@ struct mshv_root {
 	spinlock_t pt_ht_lock;
 	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
 	struct hv_partition_property_vmm_capabilities vmm_caps;
+	bool frozen;
 };
 
 /*
@@ -364,6 +365,7 @@ static inline void mshv_debugfs_vp_remove(struct mshv_vp *vp) { }
 
 extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
+
 extern u8 * __percpu *hv_synic_eventring_tail;
 
 struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 5fbd01c12ab8..e95abf4698f8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -18,6 +18,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/cleanup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/random.h>
 #include <asm/mshyperv.h>
@@ -27,6 +28,7 @@
 #include <linux/kexec.h>
 #include <linux/page-flags.h>
 #include <linux/crash_dump.h>
+#include <linux/kexec_handover.h>
 #include <linux/panic_notifier.h>
 #include <linux/vmalloc.h>
 #include <linux/rseq.h>
@@ -359,6 +361,7 @@ mshv_suspend_vp(const struct mshv_vp *vp, bool *message_in_flight)
  */
 static long mshv_run_vp_with_hyp_scheduler(struct mshv_vp *vp)
 {
+	bool message_in_flight;
 	long ret;
 	struct hv_register_assoc suspend_regs[2] = {
 			{ .name = HV_REGISTER_INTERCEPT_SUSPEND },
@@ -375,32 +378,40 @@ static long mshv_run_vp_with_hyp_scheduler(struct mshv_vp *vp)
 	}
 
 	ret = wait_event_interruptible(vp->run.vp_suspend_queue,
-				       vp->run.kicked_by_hv == 1);
-	if (ret) {
-		bool message_in_flight;
+				       vp->run.kicked_by_hv == 1 ||
+				       READ_ONCE(mshv_root.frozen));
 
-		/*
-		 * Otherwise the waiting was interrupted by a signal: suspend
-		 * the vCPU explicitly and copy message in flight (if any).
-		 */
-		ret = mshv_suspend_vp(vp, &message_in_flight);
-		if (ret)
-			return ret;
+	/* Normal wakeup: intercept arrived */
+	if (!ret && !READ_ONCE(mshv_root.frozen)) {
+		vp->run.kicked_by_hv = 0;
+		return 0;
+	}
 
-		/* Return if no message in flight */
-		if (!message_in_flight)
-			return -EINTR;
+	/*
+	 * Signal or frozen: VP was resumed above and may still be
+	 * running in the hypervisor. Suspend it before returning.
+	 */
+	ret = mshv_suspend_vp(vp, &message_in_flight);
+	if (ret)
+		return ret;
 
-		/* Wait for the message in flight. */
-		wait_event(vp->run.vp_suspend_queue, vp->run.kicked_by_hv == 1);
-	}
+	/* No in-flight message or frozen — nothing to deliver */
+	if (!message_in_flight || READ_ONCE(mshv_root.frozen))
+		return -EINTR;
+
+	/* Signal case: wait for the in-flight intercept message */
+	wait_event(vp->run.vp_suspend_queue,
+		   vp->run.kicked_by_hv == 1 ||
+		   READ_ONCE(mshv_root.frozen));
+
+	if (READ_ONCE(mshv_root.frozen))
+		return -EINTR;
 
 	/*
 	 * Reset the flag to make the wait_event call above work
 	 * next time.
 	 */
 	vp->run.kicked_by_hv = 0;
-
 	return 0;
 }
 
@@ -503,7 +514,8 @@ mshv_vp_wait_for_hv_kick(struct mshv_vp *vp)
 	ret = wait_event_interruptible(vp->run.vp_suspend_queue,
 				       (vp->run.kicked_by_hv == 1 &&
 					!mshv_vp_dispatch_thread_blocked(vp)) ||
-				       mshv_vp_interrupt_pending(vp));
+				       mshv_vp_interrupt_pending(vp) ||
+				       READ_ONCE(mshv_root.frozen));
 	if (ret)
 		return -EINTR;
 
@@ -513,6 +525,9 @@ mshv_vp_wait_for_hv_kick(struct mshv_vp *vp)
 				       mshv_vp_dispatch_thread_blocked(vp),
 				       mshv_vp_interrupt_pending(vp));
 
+	if (READ_ONCE(mshv_root.frozen))
+		return -EBUSY;
+
 	vp->run.flags.root_sched_blocked = 0;
 	vp->run.kicked_by_hv = 0;
 
@@ -539,6 +554,11 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 		u32 flags = 0;
 		struct hv_output_dispatch_vp output;
 
+		if (READ_ONCE(mshv_root.frozen)) {
+			ret = -EBUSY;
+			break;
+		}
+
 		if (__xfer_to_guest_mode_work_pending()) {
 			ret = xfer_to_guest_mode_handle_work();
 
@@ -712,6 +732,11 @@ static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_msg)
 	trace_mshv_run_vp_entry(vp->vp_partition->pt_id, vp->vp_index);
 
 	do {
+		if (READ_ONCE(mshv_root.frozen)) {
+			rc = -EBUSY;
+			break;
+		}
+
 		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 			rc = mshv_run_vp_with_root_scheduler(vp);
 		else
@@ -1074,6 +1099,9 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	struct hv_stats_page *stats_pages[2];
 	long ret;
 
+	if (READ_ONCE(mshv_root.frozen))
+		return -EBUSY;
+
 	if (copy_from_user(&args, arg, sizeof(args)))
 		return -EFAULT;
 
@@ -1762,6 +1790,201 @@ static void drain_all_vps(const struct mshv_partition *partition)
 	}
 }
 
+/**
+ * mshv_freeze_and_get_partition_ids() - Freeze all partitions and collect IDs
+ * @partition_ids: on success, receives a kho_alloc_preserve()'d array of
+ *      partition IDs; set to NULL on failure or when no partitions exist
+ * @nr_ids: on success, receives the number of entries in @partition_ids; set to
+ *      0 on failure or when no partitions exist
+ *
+ * Sets the global frozen flag to prevent creation of new partitions and
+ * (re-)dispatching of VPs. Kicks all VPs so they exit their dispatch loops,
+ * then waits for each VP to actually finish by acquiring its mutex.
+ *
+ * Must be called before kexec to ensure no VP modifies VM-memory that Linux
+ * will re-use post-kexec.
+ *
+ * Return: 0 on success, negative errno on failure. On failure, partitions
+ *  and VPs are left in an undefined state — the caller must not proceed
+ *  with kexec and should panic.
+ */
+static int
+mshv_freeze_and_get_partition_ids(u64 **partition_ids, unsigned int *nr_ids)
+{
+	unsigned int nr_alloc = 0, nr_ref = 0, nr_noref = 0;
+	struct mshv_partition *partition;
+	struct mshv_vp *vp;
+	int bkt, i;
+	u64 *ids;
+
+	*partition_ids = NULL;
+	*nr_ids = 0;
+
+	scoped_guard(spinlock, &mshv_root.pt_ht_lock)
+		mshv_root.frozen = true;
+
+	/*
+	 * Count partitions to size the ID array. Frozen prevents new additions,
+	 * so this is an upper bound.
+	 */
+	scoped_guard(rcu)
+		hash_for_each_rcu(mshv_root.pt_htable, bkt, partition, pt_hnode)
+			nr_alloc++;
+
+	if (!nr_alloc) {
+		pr_info("Frozen 0 partition(s) for kexec\n");
+		return 0;
+	}
+
+	ids = kho_alloc_preserve(nr_alloc * sizeof(*ids));
+	if (IS_ERR(ids)) {
+		pr_err("Failed to allocate partition ID array for freeze\n");
+		return PTR_ERR(ids);
+	}
+
+	/*
+	 * Record every partition's ID and obtain a reference for later use.
+	 *
+	 * Zero-refcount partitions (destroy_partition() in progress) still get
+	 * their ID recorded — destruction may not complete before kexec, and
+	 * the next kernel must clean them up. Their IDs are stored at the back
+	 * of the array so the kick/drain phase can iterate only the ref'd
+	 * prefix ids[0..nr_ref).
+	 *
+	 * VP kicking is deferred to the next phase where it happens under
+	 * pt_mutex, which serializes against mshv_partition_ioctl_create_vp().
+	 */
+	rcu_read_lock();
+	hash_for_each_rcu(mshv_root.pt_htable, bkt, partition, pt_hnode) {
+		if (!mshv_partition_get(partition)) {
+			/*
+			 * Zero refcount — destroy_partition() is in progress.
+			 * All fds are closed so no VP ioctl can be running.
+			 * Store at the back; skip VP kicking.
+			 */
+			ids[nr_alloc - 1 - nr_noref++] = partition->pt_id;
+			continue;
+		}
+
+		ids[nr_ref++] = partition->pt_id;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * For each ref'd partition, acquire and release pt_mutex as a barrier
+	 * against any in-flight create_vp. After this, the frozen flag
+	 * prevents new VPs from being created, so pt_vp_array is stable.
+	 * Then kick all VPs and drain by acquiring each vp_mutex.
+	 *
+	 * Root scheduler: disable_vp_dispatch() sets
+	 * HV_REGISTER_DISPATCH_SUSPEND, which causes any in-progress dispatch
+	 * hypercall to return. This is safe regardless of VP state because the
+	 * VP only executes while the kernel thread's dispatch hypercall is
+	 * active — once it returns, the VP cannot run until re-dispatched,
+	 * which the frozen check prevents.
+	 *
+	 * Hyp scheduler: the VP runs independently in the hypervisor and must
+	 * be explicitly suspended from within its dispatch loop (via
+	 * mshv_suspend_vp()) when the kernel thread detects the frozen flag.
+	 * wake_up_all() unblocks the kernel thread so it can do so.
+	 */
+	for (i = 0; i < nr_ref; i++) {
+		/* Ref held; partition stays in hash and alive outside RCU */
+		scoped_guard(rcu)
+			partition = mshv_partition_find(ids[i]);
+
+		/* Barrier: wait for any in-flight create_vp to complete */
+		scoped_guard(mutex, &partition->pt_mutex) {}
+
+		for (bkt = 0; bkt < MSHV_MAX_VPS; bkt++) {
+			vp = partition->pt_vp_array[bkt];
+			if (!vp)
+				continue;
+
+			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
+				disable_vp_dispatch(vp);
+
+			wake_up_all(&vp->run.vp_suspend_queue);
+		}
+
+		/*
+		 * Wait for every VP to finish its current ioctl. Taking the VP
+		 * mutex proves the VP is no longer inside run_vp.
+		 *
+		 * On Hyp-scheduler, prior mshv_suspend_vp() might have failed.
+		 * Since it's idempotent, we can safely re-issue and fail kexec
+		 * if suspend fails again. In this case, the caller is expected
+		 * to panic, so cleanup is unnecessary.
+		 */
+		for (bkt = 0; bkt < MSHV_MAX_VPS; bkt++) {
+			vp = partition->pt_vp_array[bkt];
+			if (!vp)
+				continue;
+
+			scoped_guard(mutex, &vp->vp_mutex) {
+				if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT) {
+					bool mif;
+					int ret;
+
+					ret = mshv_suspend_vp(vp, &mif);
+					if (ret)
+						return ret;
+				}
+			}
+		}
+
+		/*
+		 * Tear down doorbell ports owned by the parent partition.
+		 * These survive child partition deletion and kexec, so the
+		 * new kernel would collide on port IDs if we leave them.
+		 */
+		mshv_eventfd_release(partition);
+
+		mshv_partition_put(partition);
+	}
+
+	/* Move non-ref'd IDs next to ref'd IDs to form a contiguous array */
+	if (nr_noref) {
+		memmove(&ids[nr_ref], &ids[nr_alloc - nr_noref],
+			nr_noref * sizeof(*ids));
+	}
+
+	*partition_ids = ids;
+	*nr_ids = nr_ref + nr_noref;
+
+	pr_info("Frozen %u partition(s) for kexec\n", nr_ref + nr_noref);
+	return 0;
+}
+
+/*
+ * Reboot notifier for the mshv_root module. Runs at higher priority than
+ * the built-in page-preservation notifier so that all VPs are frozen and
+ * partition IDs are handed off before the tree is serialized.
+ */
+static int mshv_root_reboot_cb(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	if (kexec_in_progress) {
+		u64 *partition_ids;
+		unsigned int nr_partition_ids;
+		int err;
+
+		err = mshv_freeze_and_get_partition_ids(&partition_ids,
+							&nr_partition_ids);
+		if (err)
+			panic("mshv_freeze_and_get_partition_ids() failed - must not kexec: %d\n",
+			      err);
+
+		mshv_set_frozen_partition_ids(partition_ids, nr_partition_ids);
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mshv_root_reboot_notifier = {
+	.notifier_call = mshv_root_reboot_cb,
+	.priority = 1, /* higher than the built-in preserve notifier (0) */
+};
+
 static void
 remove_partition(struct mshv_partition *partition)
 {
@@ -1911,13 +2134,27 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 static int
 add_partition(struct mshv_partition *partition)
 {
-	spin_lock(&mshv_root.pt_ht_lock);
+	guard(spinlock)(&mshv_root.pt_ht_lock);
+
+	/*
+	 * Reject new partitions once frozen. Note: there is a small window
+	 * where a concurrent create-ioctl has already called
+	 * hv_call_create_partition() but not yet reached here. If kexec fires
+	 * during that window, the caller's error-path
+	 * hv_call_delete_partition() may never execute and the empty partition
+	 * leaks in the hypervisor.
+	 *
+	 * No pages are deposited at that point, so only the hypervisor-internal
+	 * tracking is lost. Closing this fully would require reworking the
+	 * entire mshv-locking logic so that the frozen check and the hypervisor
+	 * create call happen atomically.
+	 */
+	if (mshv_root.frozen)
+		return -EBUSY;
 
 	hash_add_rcu(mshv_root.pt_htable, &partition->pt_hnode,
 		     partition->pt_id);
 
-	spin_unlock(&mshv_root.pt_ht_lock);
-
 	return 0;
 }
 
@@ -2316,6 +2553,55 @@ root_scheduler_deinit(void)
 	free_percpu(root_scheduler_output);
 }
 
+/**
+ * vacuum_stale_partitions() - Tear down partitions left by a prior kernel.
+ * @dev: device for logging
+ *
+ * After kexec the previous kernel's partitions are still alive in the
+ * hypervisor. Retrieve their IDs from the KHO-preserved FDT and finalize,
+ * withdraw, and delete each one so the deposited pages return to the free pool.
+ */
+static void __init vacuum_stale_partitions(struct device *dev)
+{
+	u64 *ids;
+	unsigned int nr;
+	int i, err;
+
+	err = mshv_retrieve_frozen_partition_ids(&ids, &nr);
+	if (err) {
+		dev_err(dev, "Failed to retrieve stale partition IDs: %d\n",
+			err);
+		return;
+	}
+
+	for (i = 0; i < nr; i++) {
+		dev_info(dev, "Cleaning up stale partition %llu\n",
+			 ids[i]);
+
+		err = hv_call_finalize_partition(ids[i]);
+		if (err == -EINVAL) {
+			dev_info(dev, "partition %llu already gone\n",
+				 ids[i]);
+			continue;
+		}
+		if (err)
+			dev_warn(dev, "finalize partition %llu failed: %d\n",
+				 ids[i], err);
+
+		err = hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, ids[i]);
+		if (err)
+			dev_warn(dev, "withdraw memory %llu failed: %d\n",
+				 ids[i], err);
+
+		err = hv_call_delete_partition(ids[i]);
+		if (err)
+			dev_warn(dev, "delete partition %llu failed: %d\n",
+				 ids[i], err);
+	}
+
+	kho_restore_free(ids);
+}
+
 static int __init mshv_init_vmm_caps(struct device *dev)
 {
 	int ret;
@@ -2372,10 +2658,16 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto synic_cleanup;
 
-	ret = root_scheduler_init(dev);
+	vacuum_stale_partitions(dev);
+
+	ret = register_reboot_notifier(&mshv_root_reboot_notifier);
 	if (ret)
 		goto synic_cleanup;
 
+	ret = root_scheduler_init(dev);
+	if (ret)
+		goto unregister_reboot;
+
 	ret = mshv_debugfs_init();
 	if (ret)
 		goto deinit_root_scheduler;
@@ -2395,6 +2687,8 @@ static int __init mshv_parent_partition_init(void)
 	mshv_debugfs_exit();
 deinit_root_scheduler:
 	root_scheduler_deinit();
+unregister_reboot:
+	unregister_reboot_notifier(&mshv_root_reboot_notifier);
 synic_cleanup:
 	mshv_synic_exit();
 device_deregister:
@@ -2410,6 +2704,7 @@ static void __exit mshv_parent_partition_exit(void)
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
 	root_scheduler_deinit();
+	unregister_reboot_notifier(&mshv_root_reboot_notifier);
 	mshv_synic_exit();
 }
 
-- 
2.43.0


