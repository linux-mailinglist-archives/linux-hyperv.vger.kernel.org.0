Return-Path: <linux-hyperv+bounces-10532-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKu9GxP382kY9QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10532-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:42:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B644A947B
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08EDD304BBA8
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 00:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC9299923;
	Fri,  1 May 2026 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AY1QqX63"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240128727D;
	Fri,  1 May 2026 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596136; cv=none; b=pMrp62UOYudUvkidFVsAqHNEoLcnUX+EfJ5QkhvCvlRBnMX0nkoHwQ+hDiZ+wh5b/rQKt9FCXBXA/795pOtzgL+iKKVO+cvsclQxkjcES2NeOpe9cP8wycmzu0XMPMIeh1i/AG916jLhfjOqceUhJguIBNnTQGyYnjOwJAtqhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596136; c=relaxed/simple;
	bh=RL8CMF9VtgQzgIX0JTCcMJjTzHoMPhPoxAA/GgN4+eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmgmouWV3u0xGXcltUAdzqzZ0Fn7mRdD8ugu1QWkZyJ6xCkPgPJk2XxvA/sn39WjPgE1GPs7Cq/PYg2w1jmvcsc+2XSdp8I96Lh7r61z3/EDrj5MXPvVcogoiOwFfp8k/T2hbiRaGp7wiW/4UhDC5tHChGye8qvTgKnSfezbgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AY1QqX63; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8717F20B716D;
	Thu, 30 Apr 2026 17:42:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8717F20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777596133;
	bh=kCeRxeZ+DxLmt1F1HSGhNkVBu6/HNQhxryO/F6KU6U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AY1QqX632IgZ7EMmVmvrRSlMIZIoqZR/YDVPw0qU+MZSpqUne0ynyVENNd1Yu06aI
	 zCcQnVnmp0fqJf93kmCwrjc5Zf1ibhAaUHbUrbvdb7MRNAvxZxozVY0fxyXjkYquXF
	 ipommmfLx8ZgXWQ8zn3dtXwRSXwd28KAPv/q255Q=
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
Subject: [PATCH V2 03/11] mshv: Provide a way to get partition id if running in a VMM process
Date: Thu, 30 Apr 2026 17:41:49 -0700
Message-ID: <20260501004157.3108202-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
References: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03B644A947B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10532-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Many PCI passthru related hypercalls require partition id of the target
guest. Guests are actually managed by MSHV driver and the partition id
is only maintained there. Add a field in the partition struct in MSHV
driver to save the tgid of the VMM process creating the partition,
and add a function there to retrieve partition id if current process
is a VMM process.

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


