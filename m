Return-Path: <linux-hyperv+bounces-9658-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDCrHFzOvWneCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9658-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:46:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAF2E2104
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E10E316894D
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256F3F1663;
	Fri, 20 Mar 2026 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHaH69Mn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944223ED5D4;
	Fri, 20 Mar 2026 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046440; cv=none; b=WvkJ6Sa1AnAz2OWJVLZsEHTiZCBA0YSUM3oHpmr0MIv2iukOfJtFSaL6upa2U9EnWGqcj7rIBdML40YphYGv5LSzp2jX/82WKLeJr3SI54H2s3iUUI+MjBJeEIhyIAVOuRTcUf4UvbcLc/m5MWSfezhwtT0sv01Sr/btWoTp5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046440; c=relaxed/simple;
	bh=zxWNAJj7O8GtoZ6ysYQIGq3mbn9MaN35AkA3dod/SuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvS4SJz66fDnw2qxR05NZAcE3QmCqUW8oM71iSK9tdMRNlBkq3uPDrGhfaWfm17gord/fNmE3sN+q/NvDoSbWOzt0oT7zoCaxjlz9fqBzCgS1WP556/u6b16oJe41eAK84le3M5L2oeI7Kf6QOFdGe8oZFbg8nE1GHFAldQHTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHaH69Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A408AC2BC9E;
	Fri, 20 Mar 2026 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046440;
	bh=zxWNAJj7O8GtoZ6ysYQIGq3mbn9MaN35AkA3dod/SuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHaH69MnrwnjEExESD+N74FB5sHGoJU4Jzp13qn42CieQKBElreTDK4ABKOTkKI9E
	 YVJEQk7Igps5UHFr1QkcNviCX9tiSeCorYcocEKZGuSjbBmhXF1i/McLQmQzd/BvQU
	 GwI4GRVLdXYDi8yLWVHQ9xx1hoS5xAYim9x1t09OJL4K+HgRfFl+5opDDkIHW80Wcw
	 G6sat1uwi9u+56yN/eGbFeoa/9Cs5QGbj5T35mAAZdIpfscfYs6Vrish6ZooqG2kPg
	 bkWKOcBQL5PZbrvNoj0VU0bO6v6Z2M7tEtp3VkTBumY6frrxHwXL/gBDIR57u/+hys
	 aDSMuS29n0SZw==
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
Subject: [PATCH v4 12/21] misc: open-dice: replace deprecated mmap hook with mmap_prepare
Date: Fri, 20 Mar 2026 22:39:38 +0000
Message-ID: <5a83ab00195dc8d0609fa6cc525493010ac4ead1.1774045440.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774045440.git.ljs@kernel.org>
References: <cover.1774045440.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9658-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 9BFAF2E2104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The f_op->mmap interface is deprecated, so update driver to use its
successor, mmap_prepare.

The driver previously used vm_iomap_memory(), so this change replaces it
with its mmap_prepare equivalent, mmap_action_simple_ioremap().

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 drivers/misc/open-dice.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index 24c29e0f00ef..45060fb4ea27 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -86,29 +86,32 @@ static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
 /*
  * Creates a mapping of the reserved memory region in user address space.
  */
-static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
+static int open_dice_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *filp = desc->file;
 	struct open_dice_drvdata *drvdata = to_open_dice_drvdata(filp);
 
-	if (vma->vm_flags & VM_MAYSHARE) {
+	if (vma_desc_test(desc, VMA_MAYSHARE_BIT)) {
 		/* Do not allow userspace to modify the underlying data. */
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_desc_test(desc, VMA_WRITE_BIT))
 			return -EPERM;
 		/* Ensure userspace cannot acquire VM_WRITE later. */
-		vm_flags_clear(vma, VM_MAYWRITE);
+		vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
 	}
 
 	/* Create write-combine mapping so all clients observe a wipe. */
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	vm_flags_set(vma, VM_DONTCOPY | VM_DONTDUMP);
-	return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->size);
+	desc->page_prot = pgprot_writecombine(desc->page_prot);
+	vma_desc_set_flags(desc, VMA_DONTCOPY_BIT, VMA_DONTDUMP_BIT);
+	mmap_action_simple_ioremap(desc, drvdata->rmem->base,
+				   drvdata->rmem->size);
+	return 0;
 }
 
 static const struct file_operations open_dice_fops = {
 	.owner = THIS_MODULE,
 	.read = open_dice_read,
 	.write = open_dice_write,
-	.mmap = open_dice_mmap,
+	.mmap_prepare = open_dice_mmap_prepare,
 };
 
 static int __init open_dice_probe(struct platform_device *pdev)
-- 
2.53.0


