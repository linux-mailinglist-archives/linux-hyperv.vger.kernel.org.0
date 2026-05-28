Return-Path: <linux-hyperv+bounces-11280-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBFFMaiPF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11280-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E585EB51B
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD37E3061E55
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8223394E;
	Thu, 28 May 2026 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FHsBi+OY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6779F1DE8AD;
	Thu, 28 May 2026 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928960; cv=none; b=XA/uBK1K/5+qHDUKdoDSOpBDJyV/dqEZDMreovOYu59vJN21x/dKDuJq3dHBv7/ld3DBc3D95/mc7DnxGefqVE1gpiKkDfxOUh4WX9Vur4+TPeyOKmKs9RsZsrd/9sWGZHtXQITxjC1tjRi94dQzyQuq20SMpwUi/wSg5yK4H0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928960; c=relaxed/simple;
	bh=Sw/raEnjUfoIT2HvdYl0g8Ulj5nC52FSfDRwXuORkT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhdSK6EtTujP2nTdisjeiPveBIqnbSHzh6dl3z4CrXHZ3bh3EozKz1XGZaXGD4aN3qjPPfX5vmh7CtmECHjpuQ5oNA7Ay89Nb27abBAvT2pPmH4PG2MiTR7VdVYlA+maP02FlW3P2ZfKDlbVeL+zsnjodIENAlf1DqylLfAun2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FHsBi+OY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id C2BE920B7186; Wed, 27 May 2026 17:42:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2BE920B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928945;
	bh=0yKWet6irofp6Dygz5hKnYjBExq95hNouOEHl1lcaYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHsBi+OYZ9jOcAKcU2N4XgtTRa3DLo/5xpdPQ0VrR5ozMbaqTHr4GszSWV4T/H9ki
	 7ytnnjuF1mEcG+QD8rrmG5BehOPAJhT0V5AyAw2dJe45d31pNsyjIl5QyHdtmMrzf8
	 FP7l0XKJtLFJkM48S1NZyz3bc1EfsdeGKLqW7j4U=
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
Subject: [RFC PATCH 18/20] mshv: Exclude Hyper-V donated pages from crash dump collection
Date: Wed, 27 May 2026 17:42:00 -0700
Message-ID: <20260528004204.1484584-19-jloeser@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-11280-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 68E585EB51B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pages donated to Hyper-V must not be read during crash dump collection.
They are not ordinary RAM and accessing them can hang or corrupt the
crash kernel.

Use the KHO radix tree of preserved pages to drive a vmcore pfn_is_ram()
callback. The radix tree root PA is passed to the crash kernel via
Hyper-V crash MSR P2, since the old kernel's KHO FDT is not accessible
from the crash kernel's direct map.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_page_preserve.c | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/hv/mshv_page_preserve.c b/drivers/hv/mshv_page_preserve.c
index bc3a3a688f5b..e16fb946790d 100644
--- a/drivers/hv/mshv_page_preserve.c
+++ b/drivers/hv/mshv_page_preserve.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "mshv: " fmt
 
 #include <asm/mshyperv.h>
+#include <linux/crash_dump.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho_radix_tree.h>
@@ -327,6 +328,57 @@ static int __init alloc_tree(void)
 	return 0;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+static struct kho_radix_crash_tree crash_preserved_pages_tree;
+
+/**
+ * restore_crash_tree() - Set up the crash tree for dump-time page exclusion.
+ *
+ * In the crash kernel, the old kernel's memory is not in the direct map.
+ * The old kernel stashes the radix tree root PA in Hyper-V crash MSR P2
+ * so we can retrieve it without touching the old kernel's FDT.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int __init restore_crash_tree(void)
+{
+	phys_addr_t root_pa;
+
+	root_pa = hv_get_msr(HV_MSR_CRASH_P2);
+	if (!root_pa)
+		return -ENOENT;
+
+	/*
+	 * The MSR may contain stale data from a previous
+	 * hyperv_report_panic().  Sanity-check that it looks like a
+	 * page-aligned physical address within the architectural limit.
+	 */
+	if (!PAGE_ALIGNED(root_pa) || root_pa >> MAX_POSSIBLE_PHYSMEM_BITS) {
+		pr_warn("Invalid crash tree root PA: 0x%llx\n",
+			(unsigned long long)root_pa);
+		return -EINVAL;
+	}
+
+	return kho_radix_crash_init(&crash_preserved_pages_tree, root_pa);
+}
+
+static bool mshv_vmcore_pfn_is_ram(struct vmcore_cb *cb, unsigned long pfn)
+{
+	/*
+	 * MSHV-owned pages must not be read during crash dump collection.
+	 * Currently all pages are registered at order 0. If higher-order
+	 * registrations are added, this lookup will need to handle them
+	 * (e.g. by querying multiple orders or using a range-based API).
+	 */
+	return !kho_radix_crash_contains_page(&crash_preserved_pages_tree,
+					      pfn, 0);
+}
+
+static struct vmcore_cb mshv_vmcore_cb = {
+	.pfn_is_ram = mshv_vmcore_pfn_is_ram,
+};
+#endif
+
 static struct notifier_block reboot_notifier = {
 	.notifier_call = reboot_cb,
 	.priority = 0,
@@ -347,6 +399,24 @@ int __init mshv_preserve_init(void)
 {
 	int err;
 
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel()) {
+		/*
+		 * Crash kernel only needs the pfn_is_ram callback to exclude
+		 * MSHV-owned pages from the dump.  No page restoration, no
+		 * reboot notifier — the crash kernel reboots after collection.
+		 */
+		err = restore_crash_tree();
+		if (err) {
+			pr_err("Could not set up crash page tree: %d; MSHV pages may appear in dump\n",
+			       err);
+			return 0;
+		}
+		register_vmcore_cb(&mshv_vmcore_cb);
+		return 0;
+	}
+#endif
+
 	if (!kho_is_enabled()) {
 		pr_err("KHO is disabled; page deposits will fail.\n");
 		return 0;
@@ -383,5 +453,15 @@ int __init mshv_preserve_init(void)
 		 */
 		panic("Could not register reboot notification: %d\n", err);
 
+	/*
+	 * Stash the radix tree root PA in crash MSR P2 so the crash
+	 * kernel can retrieve it without touching the old kernel's FDT
+	 * (which is not in the crash kernel's direct map).  The root
+	 * pointer is stable once the tree is initialized — pages are
+	 * added/removed within the existing tree structure.
+	 */
+	hv_set_msr(HV_MSR_CRASH_P2,
+		   virt_to_phys(preserved_pages_tree.root));
+
 	return 0;
 }
-- 
2.43.0


