Return-Path: <linux-hyperv+bounces-9653-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACr3KfDNvWneCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9653-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:45:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065D2E2074
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98196313AD53
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87B3AA517;
	Fri, 20 Mar 2026 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6DKCirE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF53CCA1F;
	Fri, 20 Mar 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046428; cv=none; b=TGObkgFLVZJ3idtudswZff6goKU05fw4V/VrqekBVRmvzRnVcOqrNruRGedNlEuHRH9EKDZcHhPjkg40s/d3dc+h7nwJkeGCMr4b/i8rcltxpGStXu0m8TJZAihINtSHIr2aigxEb5nlp45ZYAi15Rc49t4yYtvNJ5uJFA/Ia7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046428; c=relaxed/simple;
	bh=R1lkxijSil+wWCmTaCAVOrSSJhw850u2PwIZedjzsl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCuLADUfIWLLJ5OJOmN3bArF2SwVMIuwODsCaO2DimEpBJ7N0I3VTeuBV/HN70npcO5dix8jmu01ep3y4IlkNhfLWrk0b9Cmu66At35DFxPiVse981yY+xNZQfhP3ag3Ag5iw6BzQ6EjwNuTRuvjGtFvHkFCM6FdvH44R6ur3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6DKCirE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47DEC4CEF7;
	Fri, 20 Mar 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046426;
	bh=R1lkxijSil+wWCmTaCAVOrSSJhw850u2PwIZedjzsl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6DKCirEGA6ZKizhrliF1gHxi+wwd3A8ZZ9TJ46wWZGYGTuYJQEieZIrCaNLV0Ceu
	 qrZEFXJM4/VLRUccl/77xdjQ4wRRVkIdtBV+/nu2XvIoRVT8p7pCJLAAVYVeU8/Hzo
	 va/np2+Epr0pid/tAuswDsibpsHEi12de1oz2RUJQlsYB7UdRpwpZlijugUuLtLxrv
	 4x7AWSkBBb4HU+OspbVpMSRtPEJqebIKPtfhisYBdi1CvX+Dm4VvpDRVFl6BpL4tmf
	 qUfrr4IQZoCv3oOucELvpWRO6oesrCrqDegzslK5EFUCjaXz8mFoxvNVfwFeU6XHxl
	 tyaQV5/aT+25w==
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
Subject: [PATCH v4 07/21] mm: have mmap_action_complete() handle the rmap lock and unmap
Date: Fri, 20 Mar 2026 22:39:33 +0000
Message-ID: <8d1ee8ebd3542d006a47e8382fb80cf5b57ecf10.1774045440.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9653-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 2065D2E2074
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rather than have the callers handle this both the rmap lock release and
unmapping the VMA on error, handle it within the mmap_action_complete()
logic where it makes sense to, being careful not to unlock twice.

This simplifies the logic and makes it harder to make mistake with this,
while retaining correct behaviour with regard to avoiding deadlocks.

Also replace the call_action_complete() function with a direct invocation
of mmap_action_complete() as the abstraction is no longer required.

Also update the VMA tests to reflect this change.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/internal.h                   | 19 +++++++++++++++
 mm/util.c                       | 41 +++++++++++++++------------------
 mm/vma.c                        | 26 +--------------------
 tools/testing/vma/include/dup.h |  8 +------
 4 files changed, 40 insertions(+), 54 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0256ca44115a..760fbff9c430 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1817,6 +1817,25 @@ static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc)
 	return 0;
 }

+/*
+ * When we succeed an mmap action or just before we unmap a VMA on error, we
+ * need to ensure any rmap lock held is released. On unmap it's required to
+ * avoid a deadlock.
+ */
+static inline void maybe_rmap_unlock_action(struct vm_area_struct *vma,
+		struct mmap_action *action)
+{
+	struct file *file;
+
+	if (!action->hide_from_rmap_until_complete)
+		return;
+
+	VM_WARN_ON_ONCE(vma_is_anonymous(vma));
+	file = vma->vm_file;
+	i_mmap_unlock_write(file->f_mapping);
+	action->hide_from_rmap_until_complete = false;
+}
+
 #ifdef CONFIG_MMU_NOTIFIER
 static inline int clear_flush_young_ptes_notify(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
diff --git a/mm/util.c b/mm/util.c
index 182f0f5cc400..a187f3ab4437 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1219,13 +1219,7 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 	action->hide_from_rmap_until_complete = false;

 	set_vma_from_desc(vma, &desc);
-	err = mmap_action_complete(vma, action);
-	if (err) {
-		const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-		do_munmap(current->mm, vma->vm_start, len, NULL);
-	}
-	return err;
+	return mmap_action_complete(vma, action);
 }
 EXPORT_SYMBOL(compat_vma_mmap);

@@ -1320,26 +1314,30 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 static int mmap_action_finish(struct vm_area_struct *vma,
 			      struct mmap_action *action, int err)
 {
+	size_t len;
+
+	if (!err && action->success_hook)
+		err = action->success_hook(vma);
+
+	/* do_munmap() might take rmap lock, so release if held. */
+	maybe_rmap_unlock_action(vma, action);
+	if (!err)
+		return 0;
+
 	/*
 	 * If an error occurs, unmap the VMA altogether and return an error. We
 	 * only clear the newly allocated VMA, since this function is only
 	 * invoked if we do NOT merge, so we only clean up the VMA we created.
 	 */
-	if (err) {
-		if (action->error_hook) {
-			/* We may want to filter the error. */
-			err = action->error_hook(err);
-
-			/* The caller should not clear the error. */
-			VM_WARN_ON_ONCE(!err);
-		}
-		return err;
+	len = vma_pages(vma) << PAGE_SHIFT;
+	do_munmap(current->mm, vma->vm_start, len, NULL);
+	if (action->error_hook) {
+		/* We may want to filter the error. */
+		err = action->error_hook(err);
+		/* The caller should not clear the error. */
+		VM_WARN_ON_ONCE(!err);
 	}
-
-	if (action->success_hook)
-		return action->success_hook(vma);
-
-	return 0;
+	return err;
 }

 #ifdef CONFIG_MMU
@@ -1377,7 +1375,6 @@ EXPORT_SYMBOL(mmap_action_prepare);
  */
 int mmap_action_complete(struct vm_area_struct *vma,
 			 struct mmap_action *action)
-
 {
 	int err = 0;

diff --git a/mm/vma.c b/mm/vma.c
index 6105f54cea61..86f947c90442 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2730,30 +2730,6 @@ static bool can_set_ksm_flags_early(struct mmap_state *map)
 	return false;
 }

-static int call_action_complete(struct mmap_state *map,
-				struct mmap_action *action,
-				struct vm_area_struct *vma)
-{
-	int err;
-
-	err = mmap_action_complete(vma, action);
-
-	/* If we held the file rmap we need to release it. */
-	if (action->hide_from_rmap_until_complete) {
-		struct file *file = vma->vm_file;
-
-		i_mmap_unlock_write(file->f_mapping);
-	}
-
-	if (err) {
-		const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-		do_munmap(current->mm, vma->vm_start, len, NULL);
-	}
-
-	return err;
-}
-
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vma_flags_t vma_flags,
 		unsigned long pgoff, struct list_head *uf)
@@ -2805,7 +2781,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	__mmap_complete(&map, vma);

 	if (have_mmap_prepare && allocated_new) {
-		error = call_action_complete(&map, &desc.action, vma);
+		error = mmap_action_complete(vma, &desc.action);

 		if (error)
 			return error;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c62d3998e922..bf8cffe1ea58 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1296,13 +1296,7 @@ static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 	action->hide_from_rmap_until_complete = false;

 	set_vma_from_desc(vma, &desc);
-	err = mmap_action_complete(vma, action);
-	if (err) {
-		const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-		do_munmap(current->mm, vma->vm_start, len, NULL);
-	}
-	return err;
+	return mmap_action_complete(vma, action);
 }

 static inline void vma_iter_init(struct vma_iterator *vmi,
--
2.53.0

