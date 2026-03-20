Return-Path: <linux-hyperv+bounces-9651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKJKBJzNvWmsCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9651-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:43:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A62E1FBF
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF86630F849A
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64E03D090D;
	Fri, 20 Mar 2026 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjT5OfG/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2E3BA255;
	Fri, 20 Mar 2026 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046420; cv=none; b=exxX6GfERkSI0AR0g3QZWOVK40BpFsRaag6pFMdcRTPmrSKDfZSIaFbTw522jh1GrDI9dOl5DqEfJRIBxrkYxU4JEf0V9VPleMfCb3jszYf1VVOURq7CK3Y3UoTDrY1akifo3eDSw0USKYIakz+Dvvtmb/hJvfaVHlq8wE6NuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046420; c=relaxed/simple;
	bh=nTMi7MwgWhsqzEL3innRO8x3UGd+wS99PKV5J1/IH6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3sxqqVN0YYD87i8AvNw1QSii3URvjKjPxa4qHCCqSOmhs8twgu0N0owU+x4yp3LTOx/9gfD7hj58rr/0i/YkAo+0TqlciO9pCsDCb4WCUDm9BuQ2cCM31o+WnbQ32QzpFoIEUasebvSa/R+0PM2fJ4S7kBr78QRXaEhH0Jzm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjT5OfG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E63C2BCB0;
	Fri, 20 Mar 2026 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046420;
	bh=nTMi7MwgWhsqzEL3innRO8x3UGd+wS99PKV5J1/IH6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjT5OfG/LeaNBmLBTUcJPgnFfktEPzYQp1DS+lVjzFF9mviCzUaOB/pv5EHU0EsMM
	 0WimX7637MvnHvbDM5ijVu4+dtO8s0Vvfj0NenkAY/HaB3Ad88bN2u1mlJ0c1QIkvA
	 cIxW5OOMSphnCBkiQSwasBNYmIRGz9qUDAFkFdd6pzQVCWVUiupz5jZCRHZs5XTkYp
	 DB/EkEvfD1Afqqzo+MwllMaR4ktnrqaRLNCUlkajLtTYHG7nILemLEO/ih0qWLXHHT
	 sHtHoecxEP3lZPCejF3YNgU1Tz5BXICj27Ua1a6alZHwlWd+3T5ga9RjPT/WeFhCgB
	 Wbo/bkpNIqoog==
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
Subject: [PATCH v4 05/21] mm: switch the rmap lock held option off in compat layer
Date: Fri, 20 Mar 2026 22:39:31 +0000
Message-ID: <dda74230d26a1fcd79a3efab61fa4101dd1cac64.1774045440.git.ljs@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9651-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 690A62E1FBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the mmap_prepare compatibility layer, we don't need to hold the rmap
lock, as we are being called from an .mmap handler.

The .mmap_prepare hook, when invoked in the VMA logic, is called prior to
the VMA being instantiated, but the completion hook is called after the VMA
is linked into the maple tree, meaning rmap walkers can reach it.

The mmap hook does not link the VMA into the tree, so this cannot happen.

Therefore it's safe to simply disable this in the mmap_prepare
compatibility layer.

Also update VMA tests code to reflect current compatibility layer state.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/util.c                       |  6 ++++-
 tools/testing/vma/include/dup.h | 42 +++++++++++++++++----------------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index a2cfa0d77c35..182f0f5cc400 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1204,6 +1204,7 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)

 		.action.type = MMAP_NOTHING, /* Default */
 	};
+	struct mmap_action *action = &desc.action;
 	int err;

 	err = vfs_mmap_prepare(file, &desc);
@@ -1214,8 +1215,11 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 	if (err)
 		return err;

+	/* being invoked from .mmmap means we don't have to enforce this. */
+	action->hide_from_rmap_until_complete = false;
+
 	set_vma_from_desc(vma, &desc);
-	err = mmap_action_complete(vma, &desc.action);
+	err = mmap_action_complete(vma, action);
 	if (err) {
 		const size_t len = vma_pages(vma) << PAGE_SHIFT;

diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 26c6c3255a94..c62d3998e922 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1256,8 +1256,17 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);

-static inline int __compat_vma_mmap(const struct file_operations *f_op,
-		struct file *file, struct vm_area_struct *vma)
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
@@ -1272,9 +1281,10 @@ static inline int __compat_vma_mmap(const struct file_operations *f_op,

 		.action.type = MMAP_NOTHING, /* Default */
 	};
+	struct mmap_action *action = &desc.action;
 	int err;

-	err = f_op->mmap_prepare(&desc);
+	err = vfs_mmap_prepare(file, &desc);
 	if (err)
 		return err;

@@ -1282,28 +1292,25 @@ static inline int __compat_vma_mmap(const struct file_operations *f_op,
 	if (err)
 		return err;

+	/* being invoked from .mmmap means we don't have to enforce this. */
+	action->hide_from_rmap_until_complete = false;
+
 	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, &desc.action);
-}
+	err = mmap_action_complete(vma, action);
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;

-static inline int compat_vma_mmap(struct file *file,
-		struct vm_area_struct *vma)
-{
-	return __compat_vma_mmap(file->f_op, file, vma);
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+	}
+	return err;
 }

-
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
 	mas_init(&vmi->mas, &mm->mm_mt, addr);
 }

-static inline unsigned long vma_pages(struct vm_area_struct *vma)
-{
-	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-}
-
 static inline void mmap_assert_locked(struct mm_struct *);
 static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
 						unsigned long start_addr,
@@ -1473,11 +1480,6 @@ static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }

-static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
-{
-	return file->f_op->mmap_prepare(desc);
-}
-
 static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
 {
 	/* Changing an anonymous vma with this is illegal */
--
2.53.0

