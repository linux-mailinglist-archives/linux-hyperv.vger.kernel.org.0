Return-Path: <linux-hyperv+bounces-9129-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPfKJ997p2kshwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9129-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:25:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 284621F8E45
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A839030B72A6
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BC29D27A;
	Wed,  4 Mar 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rkd1ezxC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672A23C39A;
	Wed,  4 Mar 2026 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583821; cv=none; b=C91ryZzpc5+DDyzaf8+m3dVMS3Dz/qWQEdLJEL7tAhHLLe7NwWxDvxnQYnh9SrlyESSIune3Px+go1SXwGnfOqSR93E54YxR11vMh0v6Roz1jCQRLLoYH7+8X/NSsLMj/nuCQjlm8MVF9qlYNsa2BPV7iuKlFvL8gSMTtwolIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583821; c=relaxed/simple;
	bh=LkaEcK+IfZK3HGCe3+0neYV6+6ou53odGv814wvv1EA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mcm5ezYXSRsfZxRUPFSFFI10PubFFYBqPJC33wOm1cYFZe2j1kIpY/pWBjfocOnAkkEUuKAtOwOSIaKcX+tqnqmRxB765wevLCktB0qWAoRj588cM7V3S3v4vUgKdKDS6zHY/zFL9bBkXt3lSEvpmcXwE+ZqWLYZG8RThMBx2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rkd1ezxC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 296AC20B6F02;
	Tue,  3 Mar 2026 16:23:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 296AC20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772583820;
	bh=NIo4qOGEDH+VDLFNUsq1zo25FDOm+G8fl4SXzN65BAI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rkd1ezxCdci3LIBaUrnpx9eqGFN1UV0fO9ncrzCs6m6URODP42g/anLsFbgPBMYB7
	 Jh1FlljEsqU9h7uKf7HtOIwuW/OYOySRpwIGsxJ2TkMOAFJJtLehvJwwi2yzweIGxb
	 0s+WMUWoGN6TmD97lX1UiSwJZlYQTJNDY0dnkV4s=
Subject: [PATCH 2/4] mshv: Fix pre-depositing of pages for partition
 initialization
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 00:23:40 +0000
Message-ID: 
 <177258381999.229866.4628731518107275272.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 284621F8E45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9129-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Action: no action

Deposit enough pages upfront to avoid partition initialization failures due
to low memory. This also speeds up partition initialization.

Move page depositing from the hypercall wrapper to the partition
initialization code. The required number of pages is empirical. This logic
fits better in the partition initialization code than in the hypercall
wrapper.

A partition with nested capability requires 40x more pages (20 MB) to
accommodate the nested MSHV hypervisor. This may be improved in the future.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |    1 +
 drivers/hv/mshv_root_hv_call.c |    6 ------
 drivers/hv/mshv_root_main.c    |   23 +++++++++++++++++++++--
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 947dfb76bb19..40cf7bdbd62f 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -106,6 +106,7 @@ struct mshv_partition {
 
 	struct hlist_node pt_hnode;
 	u64 pt_id;
+	u64 pt_flags;
 	refcount_t pt_ref_count;
 	struct mutex pt_mutex;
 
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index bdcb8de7fb47..b8d199f95299 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -15,7 +15,6 @@
 #include "mshv_root.h"
 
 /* Determined empirically */
-#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
 #define HV_UMAP_GPA_PAGES		512
 
 #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
@@ -139,11 +138,6 @@ int hv_call_initialize_partition(u64 partition_id)
 
 	input.partition_id = partition_id;
 
-	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
-				    HV_INIT_PARTITION_DEPOSIT_PAGES);
-	if (ret)
-		return ret;
-
 	do {
 		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
 					       *(u64 *)&input);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d753f41d3b57..fbfc50de332c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -35,6 +35,10 @@
 #include "mshv.h"
 #include "mshv_root.h"
 
+/* The deposit values below are empirical and may need to be adjusted. */
+#define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
+#define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)
+
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
@@ -1587,6 +1591,15 @@ mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
 	return ret;
 }
 
+static u64
+mshv_partition_deposit_pages(struct mshv_partition *partition)
+{
+	if (partition->pt_flags &
+	    HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE)
+		return MSHV_PARTITION_DEPOSIT_PAGES_NESTED;
+	return MSHV_PARTITION_DEPOSIT_PAGES;
+}
+
 static long
 mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 {
@@ -1595,6 +1608,11 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	if (partition->pt_initialized)
 		return 0;
 
+	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
+				    mshv_partition_deposit_pages(partition));
+	if (ret)
+		goto withdraw_mem;
+
 	ret = hv_call_initialize_partition(partition->pt_id);
 	if (ret)
 		goto withdraw_mem;
@@ -1610,8 +1628,8 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 finalize_partition:
 	hv_call_finalize_partition(partition->pt_id);
 withdraw_mem:
-	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
-
+	hv_call_withdraw_memory(MSHV_PARTITION_DEPOSIT_PAGES,
+				NUMA_NO_NODE, partition->pt_id);
 	return ret;
 }
 
@@ -2032,6 +2050,7 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 		return -ENOMEM;
 
 	partition->pt_module_dev = module_dev;
+	partition->pt_flags = creation_flags;
 	partition->isolation_type = isolation_properties.isolation_type;
 
 	refcount_set(&partition->pt_ref_count, 1);



