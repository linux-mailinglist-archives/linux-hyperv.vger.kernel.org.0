Return-Path: <linux-hyperv+bounces-10539-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNzkObD382kY9QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10539-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:45:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8134A9578
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FFB6307775C
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 00:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F102FC876;
	Fri,  1 May 2026 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EONvDO0s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5553296BC8;
	Fri,  1 May 2026 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596153; cv=none; b=RPZc6fsgyubjlP+HVk9uSWdsaRC5UKh2Y8Z7HeGbH7GkeNRfJM/qIKQHqf7632L3UBlirYHGR5p+KIincG6+5injEskGL/EaI0jqSRJ9rKy0k6DI8CxbWA6KbSKQaBnIEOPIlHzQH9pU7nGShIckmthHKDELSay30LwXxhOIP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596153; c=relaxed/simple;
	bh=mcU8SYICc38QiN8NqXflQT7TqsEN9UagRERq43TZdyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byXUuImcrW/B4dJHNe0LwdwVD5njxV9ZKlPTCssE4V2h4sK3umDdTnyYLt5iLPksYUq44U3kb5ER0cV7+eamudMPkqIUOfHHbeQefkxc1KsdHfD1pfQK9EzqNcZRKjac/0+lytbFUWmY7lShkeMAsy9gkCAqtgiYOrkPdnWOyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EONvDO0s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B8E720B716E;
	Thu, 30 Apr 2026 17:42:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B8E720B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777596152;
	bh=Tzlgjea1nxDXUDjkwgZNQOaBEUR7afZAQnfUGwI6GXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EONvDO0sMq/bqamsitYbZVI1KN0cT9vnSU35bbSD4wXN1iZt351G3xFD7AovMpBj8
	 4etmfKggNOlM5bJU0boUNAGpQGr+E7im55kyl/JMgQeamCH/sX1QnuICp4u8Gnb4na
	 eIglW5V8rGG0kS79OBiRzkqxjcMko0p34kSkHwr8=
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
Subject: [PATCH V2 11/11] mshv: Mark mem regions as non-movable upfront if device passthru
Date: Thu, 30 Apr 2026 17:41:57 -0700
Message-ID: <20260501004157.3108202-12-mrathor@linux.microsoft.com>
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
X-Rspamd-Queue-Id: 9E8134A9578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10539-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

If a VM is started with device attached, the mem regions must be marked
non-movable as the device attach hypercall right away allows the use of
SLAT for IOMMU. Marking them non-movable forces mapping of the entire
guest RAM in the SLAT at the time of region creation along with the
region pinned. Also, because a device could be dynamically attached
much later in a VM, create a boot parameter to disable movable pages
that users can set if they anticipate such an action.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      |  1 +
 drivers/hv/mshv_root_main.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index b9880d0bdc4d..d57c26950203 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -141,6 +141,7 @@ struct mshv_partition {
 	pid_t pt_vmm_tgid;
 	bool import_completed;
 	bool pt_initialized;
+	bool pt_regions_pinned;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *pt_stats_dentry;
 	struct dentry *pt_vp_dentry;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index a7864463961b..ac71534733bd 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -49,6 +49,10 @@ MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
 static bool hv_nofull_mmio;	/* don't map entire mmio region upon fault */
 module_param(hv_nofull_mmio, bool, 0644);
 
+static bool hv_no_movbl_pgs;	/* disable movable pages completely */
+module_param(hv_no_movbl_pgs, bool, 0644);
+MODULE_PARM_DESC(hv_no_movbl_pgs, "If set, don't do movable pages for VMs");
+
 struct mshv_root mshv_root;
 
 enum hv_scheduler_type hv_scheduler_type;
@@ -1303,6 +1307,12 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
 	*status = partition->async_hypercall_status;
 }
 
+static bool mshv_do_pt_regions_pinned(struct mshv_partition *pt)
+{
+	return pt->pt_regions_pinned || mshv_partition_encrypted(pt) ||
+	       hv_no_movbl_pgs;
+}
+
 /*
  * NB: caller checks and makes sure mem->size is page aligned
  * Returns: 0 with regionpp updated on success, or -errno
@@ -1333,7 +1343,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 
 	if (is_mmio)
 		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
-	else if (mshv_partition_encrypted(partition) ||
+	else if (mshv_do_pt_regions_pinned(partition) ||
 		 !mshv_region_movable_init(rg))
 		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
 	else
@@ -1808,6 +1818,9 @@ static long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
 	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
 		return -EFAULT;    /* cleanup in mshv_device_fop_release() */
 
+	/* For now, all regions must be pinned if there is device passthru. */
+	partition->pt_regions_pinned = true;
+
 	return 0;
 
 undo_out:
-- 
2.51.2.vfs.0.1


