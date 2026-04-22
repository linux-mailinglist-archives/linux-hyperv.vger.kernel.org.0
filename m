Return-Path: <linux-hyperv+bounces-10306-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEQ9N0k16Gk6GwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10306-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:41:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5854418B4
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65CFD3078855
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F0391846;
	Wed, 22 Apr 2026 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IZXylSwM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019F383C85;
	Wed, 22 Apr 2026 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825253; cv=none; b=YrkOHnj9FOwwj7nw1CZp1Ld1uOFV79TLwKrKvxw2yMS4snepUxemD0bTTZQCVm3s/Ek+NAITKlqKCi2+T6bokfCqTMN9NBuUwh1bzdvT1ib5Z9HAcVmS1Uif1aqHSF6TAtL5APR0+DZkBgCtau6qaRFdi1Y6j7ZmJVcdwPWwv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825253; c=relaxed/simple;
	bh=DeXjz0SRhQLAqrfm4RH5YKzrqZmSYmsxnp314WPB2yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+DIVA2CQe5ZfBkp8UuPf8fgbsAgd4l4lbi7+JpF88xYeogFXluiaDBPRbSjqjRG4/yMZM0plvQ5Ec6/tGGhmKDJklqYOAD9elCNsqByhNe+YrY4mIseMQlTgbPOhl5i8N8riH2m5ohzOLP9LQvDDAMjmWG0aIEno7aZfWtG6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IZXylSwM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A9B320B6F0C;
	Tue, 21 Apr 2026 19:33:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A9B320B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825240;
	bh=y1jx/hTTfAyQ3CCJQjV0+0ow1B+C2JnMqOep7R/bNGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZXylSwMUWnVpnK/zPOW1AocwdVaoMN1VvQgjP8RPfybnucqhnKEM2kR91gSL6erO
	 GLdPDi6Ja3KA6eP6YyMcrj0hGsvermCipK5rA4kVfM37cx1oLOZby0eON+S6iBFfNM
	 oML8I9tJJp7BjXpoDnF2iMxzXoEqvXYFsiVMOzGs=
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
Subject: [PATCH V1 13/13] mshv: pin all ram mem regions if partition has device passthru
Date: Tue, 21 Apr 2026 19:32:39 -0700
Message-ID: <20260422023239.1171963-14-mrathor@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10306-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 7B5854418B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Given the sporadic errors, mostly from high end devices, when regions are
not pinned and a PCI device is passthru'd to a VM, for now, force all
regions for the VM to be pinned. Even tho VFIO may pin them, the regions
would still be marked movable, so do it upfront in mshv.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      | 6 ++++++
 drivers/hv/mshv_root_main.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index b9880d0bdc4d..32260df84f86 100644
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
@@ -277,6 +278,11 @@ static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
 	return partition->isolation_type == HV_PARTITION_ISOLATION_TYPE_SNP;
 }
 
+static inline bool mshv_pt_regions_pinned(struct mshv_partition *pt)
+{
+	return pt->pt_regions_pinned || mshv_partition_encrypted(pt);
+}
+
 struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
 void mshv_partition_put(struct mshv_partition *partition);
 struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold(RCU);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index a7864463961b..251cf88a2b0b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1333,7 +1333,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 
 	if (is_mmio)
 		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
-	else if (mshv_partition_encrypted(partition) ||
+	else if (mshv_pt_regions_pinned(partition) ||
 		 !mshv_region_movable_init(rg))
 		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
 	else
@@ -1406,6 +1406,9 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 		goto err_out;
 	}
 
+	/* For now, all regions must be pinned if there is device passthru. */
+	partition->pt_regions_pinned = true;
+
 	return 0;
 
 invalidate_region:
-- 
2.51.2.vfs.0.1


