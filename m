Return-Path: <linux-hyperv+bounces-11281-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CZaDa2PF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11281-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7475EB523
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16F553063A90
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2806241686;
	Thu, 28 May 2026 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bds+T53Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98DB23392F;
	Thu, 28 May 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928961; cv=none; b=q5B+byOdka93Fu4vWtI3ErKZSs+axehudTPEMHwrqkvj0AvfCuCQdl4r8nNd8+0y+POxkT8bQC7jPCX6ZEjbVfr9PX8kvLCGdMJQlAzB1G+wWAyzhHDHrE5MWAfZUscqvWBUFBb74noIj7sPcIWgWARyc++OtVqktON5BOrC958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928961; c=relaxed/simple;
	bh=rx6iKkur0ne2X4SzAyPwfxcKTOWxn5ia5n5lA3O1jng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMUj6au/9K9HZMHTOfcM9l5xVfbM0vs2XDNmH2Jn6UKaNkR5HgHnNPKQZMPmmTWHXxV7RT5qQI6UuuzA9xuugi8E6uk0+ttz/sPAVRrIMPD+wEDoOvZdcg+Cd7Nffk+UG21VuYO0Mt9teqxvosfamAUKZ5dsE0aUQ5ElX80w0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bds+T53Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id EC17820B717A; Wed, 27 May 2026 17:42:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC17820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928943;
	bh=lTYSobW1vcaiuFaW/ih0lOZTdJfa7tMYIcB/6JUObEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bds+T53YSwua67KRic1D3xTDVI8g2FG5kFyh9yUH+NKfBwH0s5MxGdFticf7R97vc
	 C6Xh5MCYze42oBrgNFWnDpyid/h5MQYDeNPF/7cyO0UVqYZALjK7f4naGCfMw8KflQ
	 CRrvEG5Kw9ij3UM6KLbWJBmrvJ8vse+aL8vwqdDw=
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
Subject: [RFC PATCH 16/20] mshv: Add debugfs interface to page tracker
Date: Wed, 27 May 2026 17:41:58 -0700
Message-ID: <20260528004204.1484584-17-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11281-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: EE7475EB523
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

- expose stats (page-counts for data & metadata)
- expose tracked pages
- expose scheduler type
- add mshv_iterate_preserved() API for walking the radix tree

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_debugfs.c       | 99 +++++++++++++++++++++++++++++++++
 drivers/hv/mshv_page_preserve.c | 13 +++++
 drivers/hv/mshv_page_preserve.h |  3 +
 drivers/hv/mshv_root.h          |  2 +
 drivers/hv/mshv_root_main.c     |  2 +-
 5 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
index 3c3e02237ae9..d79898e21b36 100644
--- a/drivers/hv/mshv_debugfs.c
+++ b/drivers/hv/mshv_debugfs.c
@@ -33,11 +33,18 @@ static struct dentry *mshv_debugfs;
 static struct dentry *mshv_debugfs_partition;
 static struct dentry *mshv_debugfs_lp;
 static struct dentry **parent_vp_stats;
+
 static struct dentry *parent_partition_stats;
 
 static u64 mshv_lps_count;
 static struct hv_stats_page **mshv_lps_stats;
 
+struct mshv_pt_stats {
+	unsigned long count_data;
+	unsigned long count_meta;
+	struct seq_file *stat_file;
+};
+
 static int lp_stats_show(struct seq_file *m, void *v)
 {
 	const struct hv_stats_page *stats = m->private;
@@ -668,8 +675,89 @@ void mshv_debugfs_partition_remove(struct mshv_partition *partition)
 				 partition->pt_stats_dentry);
 }
 
+static int pt_count_data_cb(unsigned long key __maybe_unused, void *stats)
+{
+	((struct mshv_pt_stats *)stats)->count_data++;
+	return 0;
+}
+
+static int pt_count_meta_cb(phys_addr_t phys __maybe_unused, void *stats)
+{
+	((struct mshv_pt_stats *)stats)->count_meta++;
+	return 0;
+}
+
+static int pt_stats_show(struct seq_file *m, void *v)
+{
+	const struct kho_radix_walk_cb cb = {
+		.key = pt_count_data_cb,
+		.table = pt_count_meta_cb,
+	};
+
+	struct mshv_pt_stats pt_stats = {0};
+
+	mshv_iterate_preserved(&cb, &pt_stats);
+	seq_printf(m, "Data pages: %lu\n", pt_stats.count_data);
+	seq_printf(m, "Meta pages: %lu\n", pt_stats.count_meta);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pt_stats);
+
+static int pt_tree_data_cb(unsigned long key, void *stats)
+{
+	seq_printf(((struct mshv_pt_stats *)stats)->stat_file,
+		   "data pfn: %#lx\n", key);
+	return 0;
+}
+
+static int pt_tree_meta_cb(phys_addr_t phys, void *stats)
+{
+	seq_printf(((struct mshv_pt_stats *)stats)->stat_file,
+		   "meta pfn: %#llx\n",
+		   (unsigned long long)(phys >> PAGE_SHIFT));
+	return 0;
+}
+
+static int pt_tree_show(struct seq_file *m, void *v)
+{
+	const struct kho_radix_walk_cb cb = {
+		.key = pt_tree_data_cb,
+		.table = pt_tree_meta_cb,
+	};
+
+	struct mshv_pt_stats pt_stats = {.stat_file = m};
+
+	mshv_iterate_preserved(&cb, &pt_stats);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pt_tree);
+
+static int __init mshv_debugfs_pt_create(struct dentry *parent)
+{
+	struct dentry *d;
+
+	d = debugfs_create_file("pt_stats", 0400, parent, NULL, &pt_stats_fops);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	d = debugfs_create_file("pt_tree", 0400, parent, NULL, &pt_tree_fops);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	return 0;
+}
+
+static int scheduler_info_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "Scheduler type: %s (%d)\n",
+		   scheduler_type_to_string(hv_scheduler_type), hv_scheduler_type);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scheduler_info);
+
 int __init mshv_debugfs_init(void)
 {
+	struct dentry *d;
 	int err;
 
 	mshv_debugfs = debugfs_create_dir("mshv", NULL);
@@ -694,6 +782,17 @@ int __init mshv_debugfs_init(void)
 	if (err)
 		goto unmap_lp_stats;
 
+	err = mshv_debugfs_pt_create(mshv_debugfs);
+	if (err)
+		goto unmap_lp_stats;
+
+	d = debugfs_create_file("scheduler_info", 0400, mshv_debugfs, NULL,
+				&scheduler_info_fops);
+	if (IS_ERR(d)) {
+		err = PTR_ERR(d);
+		goto unmap_lp_stats;
+	}
+
 	return 0;
 
 unmap_lp_stats:
diff --git a/drivers/hv/mshv_page_preserve.c b/drivers/hv/mshv_page_preserve.c
index a79725a74663..bc3a3a688f5b 100644
--- a/drivers/hv/mshv_page_preserve.c
+++ b/drivers/hv/mshv_page_preserve.c
@@ -52,6 +52,19 @@ int mshv_unregister_preserve_page(struct page *pg)
 }
 EXPORT_SYMBOL_GPL(mshv_unregister_preserve_page);
 
+/**
+ * mshv_iterate_preserved() - Walk all preserved pages
+ * @cb: callbacks invoked for each key/table entry
+ * @data: opaque data passed to callbacks
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int mshv_iterate_preserved(const struct kho_radix_walk_cb *cb, void *data)
+{
+	return kho_radix_walk_tree(&preserved_pages_tree, cb, data);
+}
+EXPORT_SYMBOL_GPL(mshv_iterate_preserved);
+
 /* Preserve a single page identified by its PFN key with KHO */
 static int preserve_key_cb(unsigned long key, void *data)
 {
diff --git a/drivers/hv/mshv_page_preserve.h b/drivers/hv/mshv_page_preserve.h
index 0609002e5f1d..ac99b4e33285 100644
--- a/drivers/hv/mshv_page_preserve.h
+++ b/drivers/hv/mshv_page_preserve.h
@@ -6,10 +6,13 @@
 #ifndef _MSHV_PAGE_PRESERVE_H
 #define _MSHV_PAGE_PRESERVE_H
 
+#include <linux/kho_radix_tree.h>
+
 struct page;
 
 int mshv_preserve_init(void);
 int mshv_register_preserve_page(struct page *pg);
 int mshv_unregister_preserve_page(struct page *pg);
+int mshv_iterate_preserved(const struct kho_radix_walk_cb *cb, void *data);
 
 #endif /* _MSHV_PAGE_PRESERVE_H */
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 362768786c17..216053f8e0ab 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -379,4 +379,6 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+const char *scheduler_type_to_string(enum hv_scheduler_type type);
+
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bd1359eb58dd..5fbd01c12ab8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2134,7 +2134,7 @@ mshv_dev_release(struct inode *inode, struct file *filp)
 
 static int mshv_root_sched_online;
 
-static const char *scheduler_type_to_string(enum hv_scheduler_type type)
+const char *scheduler_type_to_string(enum hv_scheduler_type type)
 {
 	switch (type) {
 	case HV_SCHEDULER_TYPE_LP:
-- 
2.43.0


