Return-Path: <linux-hyperv+bounces-9819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG6TADjrxmloQAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9819-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:40:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C734B22C
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7239D3022335
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1439EF14;
	Fri, 27 Mar 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZgpfBo+1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78F39E19C;
	Fri, 27 Mar 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642789; cv=none; b=icI5bPCFN13hD6cdxoM1HQPisc7xiRq95bvkoLa1YdsKAxAPkaOoBieFVw4GSh6AjErtWbYNzNJa74SUNvsgY8B2B4bQ3JfEOXyAJcEFwelQ+5imu9cjKtfm6QjjuNUHL4umNsddfFWkgJziGBkyFNBKDuE+x0jWBEdqaOnghUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642789; c=relaxed/simple;
	bh=9841nyKGaCMbJiPamuLtSUu7rGO7k/yXSVzxhwUWwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSXslF6WNogllqkt+Je0LNnCjp/h+R+hUA3HPtgFr3LXZJSWF85aWZzE6CtqM8R/7kjCg3diRbx0tTiOWGA6MdtmFMBU1KFP+6RDJrzJAFIHGcyBZRobsZFQqF0Ty79xYNggbN+ezhzbxgAta0x/cHMkyJ3dPzm0tc82vw4nwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZgpfBo+1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 6827D20B7136; Fri, 27 Mar 2026 13:19:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6827D20B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774642788;
	bh=q3fRO5i4ffy4kvgvvmuRdroHrhQi79GfqaNfwbQdhoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgpfBo+1mH6j9miu3hxMlnZgvqerHsdINKpFUq65uV1DN5p1VHdbrCbmg8CMrN5rZ
	 McK/PjMiYvJAcsp59nJdu6zKIgfHz0kuGPkBdcmCzl7a5EAO+cuKKJ6a5HeW0wONek
	 cI5pjrUY79Pj9rMYilgAIpfpteMHnhS02jaV7bvk=
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
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH 5/6] mshv: clean up SynIC state on kexec for L1VH
Date: Fri, 27 Mar 2026 13:19:16 -0700
Message-ID: <20260327201920.2100427-6-jloeser@linux.microsoft.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9819-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 3C4C734B22C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register the mshv reboot notifier for all parent partitions, not just
root. Previously the notifier was gated on hv_root_partition(), so on
L1VH (where hv_root_partition() is false) SINT0, SINT5, and SIRBP were
never cleaned up before kexec. The kexec'd kernel then inherited stale
unmasked SINTs and an enabled SIRBP pointing to freed memory.

The L1VH SIRBP also needs special handling: unlike the root partition
where the hypervisor provides the SIRBP page, L1VH must allocate its
own page and program the GPA into the MSR. Add this allocation to
mshv_synic_init() and the corresponding free to mshv_synic_cleanup().

Remove the unnecessary mshv_root_partition_init/exit wrappers and
register the reboot notifier directly in mshv_parent_partition_init().
Make mshv_reboot_nb static since it no longer needs external linkage.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 21 ++++-----------------
 drivers/hv/mshv_synic.c     | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e6509c980763..281f530b68a9 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2256,20 +2256,10 @@ static int mshv_reboot_notify(struct notifier_block *nb,
 	return 0;
 }
 
-struct notifier_block mshv_reboot_nb = {
+static struct notifier_block mshv_reboot_nb = {
 	.notifier_call = mshv_reboot_notify,
 };
 
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
@@ -2339,8 +2329,7 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto remove_cpu_state;
 
-	if (hv_root_partition())
-		ret = mshv_root_partition_init(dev);
+	ret = register_reboot_notifier(&mshv_reboot_nb);
 	if (ret)
 		goto remove_cpu_state;
 
@@ -2368,8 +2357,7 @@ static int __init mshv_parent_partition_init(void)
 deinit_root_scheduler:
 	root_scheduler_deinit();
 exit_partition:
-	if (hv_root_partition())
-		mshv_root_partition_exit();
+	unregister_reboot_notifier(&mshv_reboot_nb);
 remove_cpu_state:
 	cpuhp_remove_state(mshv_cpuhp_online);
 free_synic_pages:
@@ -2387,8 +2375,7 @@ static void __exit mshv_parent_partition_exit(void)
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
 	root_scheduler_deinit();
-	if (hv_root_partition())
-		mshv_root_partition_exit();
+	unregister_reboot_notifier(&mshv_reboot_nb);
 	cpuhp_remove_state(mshv_cpuhp_online);
 	free_percpu(mshv_root.synic_pages);
 }
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 8a7d76a10dc3..32f91a714c97 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -495,13 +495,29 @@ int mshv_synic_init(unsigned int cpu)
 
 	/* Setup the Synic's event ring page */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
-	sirbp.sirbp_enabled = true;
-	*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
-				    PAGE_SIZE, MEMREMAP_WB);
 
-	if (!(*event_ring_page))
-		goto cleanup_siefp;
+	if (hv_root_partition()) {
+		*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
+					    PAGE_SIZE, MEMREMAP_WB);
+
+		if (!(*event_ring_page))
+			goto cleanup_siefp;
+	} else {
+		/*
+		 * On L1VH the hypervisor does not provide a SIRBP page.
+		 * Allocate one and program its GPA into the MSR.
+		 */
+		*event_ring_page = (struct hv_synic_event_ring_page *)
+			get_zeroed_page(GFP_KERNEL);
+
+		if (!(*event_ring_page))
+			goto cleanup_siefp;
 
+		sirbp.base_sirbp_gpa = virt_to_phys(*event_ring_page)
+				>> PAGE_SHIFT;
+	}
+
+	sirbp.sirbp_enabled = true;
 	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
 
 #ifdef HYPERVISOR_CALLBACK_VECTOR
@@ -581,8 +597,15 @@ int mshv_synic_cleanup(unsigned int cpu)
 	/* Disable SYNIC event ring page owned by MSHV */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 	sirbp.sirbp_enabled = false;
-	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
-	memunmap(*event_ring_page);
+
+	if (hv_root_partition()) {
+		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
+		memunmap(*event_ring_page);
+	} else {
+		sirbp.base_sirbp_gpa = 0;
+		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
+		free_page((unsigned long)*event_ring_page);
+	}
 
 	/*
 	 * Release our mappings of the message and event flags pages.
-- 
2.43.0


