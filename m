Return-Path: <linux-hyperv+bounces-9386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B/VNh0ks2nMSgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9386-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:37:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6E279589
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A42329A15E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570B3F54CB;
	Thu, 12 Mar 2026 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seHyQRKf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAC3F0A8F;
	Thu, 12 Mar 2026 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347301; cv=none; b=f6ZME6jX598uwVAbbLhjmU1t+dnmTfY4JeytOwfPbFbLEwTTcUNHEo8vTheMKB5SzO6URnSHaJ3d2p3KrP5P1sGZU0Bq4HMlkwusHLy3pU6uCBl44/ud4jmEmdHVl7pSNqKPldwv2cL+BbWTqq9MlhSn4NfNqmYieyC4tB6uquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347301; c=relaxed/simple;
	bh=c9ukDFMfjwhzlsDJMNmh/uTfuZTbg9jKdguqmYo0LoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNKVnkpIgd2dRBrwBOF3fkQo5wBKhorNqtaNVtAnzMc3sexMtb3LvZpoj7pQ4ubDf/pbpqZrtk9A8T/QMWog4wAF5cgw6UEtekofzigwGNPDfVt9bvQEKJ4IroAFkl9UJ5MA6k+kHQVrwrjB975ifwVR4wtJ46VxGVeMRsAuePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seHyQRKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8DDC4CEF7;
	Thu, 12 Mar 2026 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773347301;
	bh=c9ukDFMfjwhzlsDJMNmh/uTfuZTbg9jKdguqmYo0LoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seHyQRKfprsXz966V294X+6IfJ1CWwP+Y0wpW00vbCO8EQJItDqXB7+2hMzKpRTiQ
	 hYxn7e7+9UCh7o3hYaUyDJd3fWBLwSLb/VzbQhxY5E1+xRRlNEria4jIf3+0tM1TKj
	 ckVDA5igQCIE50LBljWdQUwotHE2U3Ez8Fc1WnFiB1Q5tfbcqGAHLT9MRgJT+cetd1
	 qLLkVpiJCENrZF2ULSXblNRls2CogOVLNbRgrw3r5a8qG6Yc5kSqUbGJBzNccVlFWe
	 trOGLbrWQHTLqWRwgfKFh12xjS5E2ZkFSoSWmZaKoF/+X7y7oSJo/BOQEakebgTaH7
	 Y/MtwSGbAIzGw==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bodo Stroesser <bostroesser@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH 14/15] uio: replace deprecated mmap hook with mmap_prepare in uio_info
Date: Thu, 12 Mar 2026 20:27:29 +0000
Message-ID: <8673929c7fee995e78c1a703949d4ad53363d678.1773346620.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773346620.git.ljs@kernel.org>
References: <cover.1773346620.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9386-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67A6E279589
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The f_op->mmap interface is deprecated, so update uio_info to use its
successor, mmap_prepare.

Therefore, replace the uio_info->mmap hook with a new
uio_info->mmap_perepare hook, and update its one user, target_core_user, to
both specify this new mmap_prepare hook and also to use the new
vm_ops->mapped() hook to continue to maintain a correct udev->kref
refcount.

Then update uio_mmap() to utilise the mmap_prepare compatibility layer to
invoke this callback from the uio mmap invocation.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 drivers/target/target_core_user.c | 26 ++++++++++++++++++--------
 drivers/uio/uio.c                 | 10 ++++++++--
 include/linux/uio_driver.h        |  4 ++--
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index af95531ddd35..9d211dad5e53 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1860,6 +1860,17 @@ static struct page *tcmu_try_get_data_page(struct tcmu_dev *udev, uint32_t dpi)
 	return NULL;
 }
 
+static int tcmu_vma_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
+			   const struct file *file, void **vm_private_data)
+{
+	struct tcmu_dev *udev = *vm_private_data;
+
+	pr_debug("vma_open\n");
+
+	kref_get(&udev->kref);
+	return 0;
+}
+
 static void tcmu_vma_open(struct vm_area_struct *vma)
 {
 	struct tcmu_dev *udev = vma->vm_private_data;
@@ -1919,26 +1930,25 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 }
 
 static const struct vm_operations_struct tcmu_vm_ops = {
+	.mapped = tcmu_vma_mapped,
 	.open = tcmu_vma_open,
 	.close = tcmu_vma_close,
 	.fault = tcmu_vma_fault,
 };
 
-static int tcmu_mmap(struct uio_info *info, struct vm_area_struct *vma)
+static int tcmu_mmap_prepare(struct uio_info *info, struct vm_area_desc *desc)
 {
 	struct tcmu_dev *udev = container_of(info, struct tcmu_dev, uio_info);
 
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &tcmu_vm_ops;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
+	desc->vm_ops = &tcmu_vm_ops;
 
-	vma->vm_private_data = udev;
+	desc->private_data = udev;
 
 	/* Ensure the mmap is exactly the right size */
-	if (vma_pages(vma) != udev->mmap_pages)
+	if (vma_desc_pages(desc) != udev->mmap_pages)
 		return -EINVAL;
 
-	tcmu_vma_open(vma);
-
 	return 0;
 }
 
@@ -2253,7 +2263,7 @@ static int tcmu_configure_device(struct se_device *dev)
 	info->irqcontrol = tcmu_irqcontrol;
 	info->irq = UIO_IRQ_CUSTOM;
 
-	info->mmap = tcmu_mmap;
+	info->mmap_prepare = tcmu_mmap_prepare;
 	info->open = tcmu_open;
 	info->release = tcmu_release;
 
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5a4998e2caf8..1e4ade78ed84 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -850,8 +850,14 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 		goto out;
 	}
 
-	if (idev->info->mmap) {
-		ret = idev->info->mmap(idev->info, vma);
+	if (idev->info->mmap_prepare) {
+		struct vm_area_desc desc;
+
+		compat_set_desc_from_vma(&desc, filep, vma);
+		ret = idev->info->mmap_prepare(idev->info, &desc);
+		if (ret)
+			goto out;
+		ret = __compat_vma_mmap(&desc, vma);
 		goto out;
 	}
 
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 334641e20fb1..53bdc557c423 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -97,7 +97,7 @@ struct uio_device {
  * @irq_flags:		flags for request_irq()
  * @priv:		optional private data
  * @handler:		the device's irq handler
- * @mmap:		mmap operation for this uio device
+ * @mmap_prepare:	mmap_pepare operation for this uio device
  * @open:		open operation for this uio device
  * @release:		release operation for this uio device
  * @irqcontrol:		disable/enable irqs when 0/1 is written to /dev/uioX
@@ -112,7 +112,7 @@ struct uio_info {
 	unsigned long		irq_flags;
 	void			*priv;
 	irqreturn_t (*handler)(int irq, struct uio_info *dev_info);
-	int (*mmap)(struct uio_info *info, struct vm_area_struct *vma);
+	int (*mmap_prepare)(struct uio_info *info, struct vm_area_desc *desc);
 	int (*open)(struct uio_info *info, struct inode *inode);
 	int (*release)(struct uio_info *info, struct inode *inode);
 	int (*irqcontrol)(struct uio_info *info, s32 irq_on);
-- 
2.53.0


