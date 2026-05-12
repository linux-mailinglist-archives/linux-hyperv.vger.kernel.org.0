Return-Path: <linux-hyperv+bounces-10775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OsxInyKAmrVtwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10775-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:03:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E52E518947
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9166E302F6B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3BF23BCEE;
	Tue, 12 May 2026 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sFJJtMRJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCEB2D949C;
	Tue, 12 May 2026 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551402; cv=none; b=u0QjpKdzqRBdbpc9d8oo6cEguIyACmxuSaYggLHRuDfpMOmU4WXX4RyMV2Qo957QoPMNHNQ7q1hygKfsIRzEF40JrPL4JLg/9Yq1a3QoXKAIdn3c3ZaK4csFaO5o+M1JPn3MSpFMgysjlVzR3O05pNptGhlJzC0QuMoppzX94rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551402; c=relaxed/simple;
	bh=dJMFP1lUaQO3U2qnmMPFTtqzgh3f1RMgsuSu4vAUYCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtGUKhRuPEGcZv/2dfcKJO5any+HvkAoyYoNh164icwqNADFm76ZdGrMGtha8UsFSOcR2sfTaBb70VG6rhXSi0s7GBPD+16c+ZVyJ/fPTG5HYXzoH2Wi5/4OeK+I/FFePOTkywJlkscrtqutljrHCpFug042oxrOhSmpFitR+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sFJJtMRJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8099720B7178;
	Mon, 11 May 2026 19:03:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8099720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778551397;
	bh=/NGej0120vNKqYpfLmvqutBNKpHH9eJZWzNxe7ny+6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFJJtMRJzlXARmHWxA5JylGBJN1o5Prfzs/w5iaD+r586N27gnTjG+EsnmfCpJyBg
	 Kw6M3j2us0udwGfeBJizlxgDCWm2X35rpHG16mExOigjCrxdRIlxkIAkBzQBB1r5YS
	 W6878jRwDne2Q6bZHpXJZzjUtfDOBZcGRlRkT8dU=
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
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V3 03/11] mshv: Provide a way to get partition ID if running in a VMM process
Date: Mon, 11 May 2026 19:02:51 -0700
Message-ID: <20260512020259.1678627-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E52E518947
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10775-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim,anirudhrb.com:email]
X-Rspamd-Action: no action

Many PCI passthru related hypercalls require partition ID of the target
guest. Guests are actually managed by MSHV driver and the partition ID
is only maintained there. Add a field in the partition struct in MSHV
driver to save the tgid of the VMM process creating the partition, and
add a function there to retrieve partition ID if the current process is
a VMM process.

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
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


