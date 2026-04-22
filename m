Return-Path: <linux-hyperv+bounces-10298-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAJbFSk06Gk6GwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10298-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:36:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C83CE4417D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEEB7308137C
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1F38A72A;
	Wed, 22 Apr 2026 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s+NK51tP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594993815C5;
	Wed, 22 Apr 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825236; cv=none; b=oO6SYhTO+9nm8Ht2ip/7znJV0sAZfBc1xiYNTXARa6N9rVsIKuw3oCCUVMXAFXr7aSjutVYFbLdpwnOhGCwx0vvcx+l2at/eFp/tgzVq2spz/zH3/L83LAqhO4RoCB/1JiS8hhj1+M7mBDat61QOsL/EoXiXVSsa3jO42H6/Fws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825236; c=relaxed/simple;
	bh=yqHoN0/B7kB4uVVOu+NW/uh2AcmRAs1ftzDdzQp4n00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlj2j5Gk8H00aEuQMINC/AwZzLTXLZ9mKtuh9DRexe7aCyr4dk0d3eSTDU7TVhMj4z8+JHkNZGUe+xR+nvZuWnBjXCS8+wRORDpjEgwDRmn+rxD6n74ANhM0r9sk8FiQfizueph4wRtaiyr2+VfUa41/VI3BX5xcR1OBuzSkdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s+NK51tP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD44420B6F15;
	Tue, 21 Apr 2026 19:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD44420B6F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825222;
	bh=F42zVdEs44T8GRjrW0mPW72by/e2QFwD5VC6Q2hyg6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+NK51tPdoLfcxZ6OffDm6U7IvvtWOvDL0BH4ln5pINhW0LUgQc8ibHZoufX7y6gY
	 voDlcKrXSxemicI9qs5qJ3LSpm7jfovEK6myrTsLivNmMDyziKAsh6BhQj/wGyFFa1
	 2DrPOCAnCFSz15t0IL1xYXUKqU0PDWO3dcKCaw6Q=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Subject: [PATCH V1 04/13] mshv: Provide a way to get partition id if running in a VMM process
Date: Tue, 21 Apr 2026 19:32:30 -0700
Message-ID: <20260422023239.1171963-5-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10298-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C83CE4417D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Many PCI passthru related hypercalls require partition id of the target
guest. Guests are actually managed by MSHV driver and the partition id
is only maintained there. Add a field in the partition struct in MSHV
driver to save the tgid of the VMM process creating the partition,
and add a function there to retrieve partition id if current process
is a VMM process.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |  1 +
 drivers/hv/mshv_root_main.c    | 22 ++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  5 +++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1..a85c24dcc701 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -138,6 +138,7 @@ struct mshv_partition {
 
 	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
 	u64 isolation_type;
+	pid_t pt_vmm_tgid;
 	bool import_completed;
 	bool pt_initialized;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bd1359eb58dd..02c107458be9 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1908,6 +1908,27 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/* Given a process tgid, return partition id if it is a VMM process */
+u64 mshv_current_partid(void)
+{
+	struct mshv_partition *pt;
+	int i;
+	u64 ret_ptid = HV_PARTITION_ID_INVALID;
+
+	rcu_read_lock();
+
+	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {
+		if (pt->pt_vmm_tgid == current->tgid) {
+			ret_ptid = pt->pt_id;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return ret_ptid;
+}
+EXPORT_SYMBOL_GPL(mshv_current_partid);
+
 static int
 add_partition(struct mshv_partition *partition)
 {
@@ -2073,6 +2094,7 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 		goto cleanup_irq_srcu;
 
 	partition->pt_id = pt_id;
+	partition->pt_vmm_tgid = current->tgid;
 
 	ret = add_partition(partition);
 	if (ret)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..e8cbc4e3f7ad 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -350,6 +350,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_notify_all_processors_started(void);
 bool hv_lp_exists(u32 lp_index);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
+u64 mshv_current_partid(void);
 
 #else /* CONFIG_MSHV_ROOT */
 static inline bool hv_root_partition(void) { return false; }
@@ -380,6 +381,10 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
 {
 	return -EOPNOTSUPP;
 }
+static inline u64 mshv_current_partid(void)
+{
+	return HV_PARTITION_ID_INVALID;
+}
 #endif /* CONFIG_MSHV_ROOT */
 
 static inline int hv_deposit_memory(u64 partition_id, u64 status)
-- 
2.51.2.vfs.0.1


