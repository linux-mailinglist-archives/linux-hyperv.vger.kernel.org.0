Return-Path: <linux-hyperv+bounces-9663-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JHDL+vOvWneCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9663-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:49:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3513D2E21A0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1EE1308661C
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3AD3F8E09;
	Fri, 20 Mar 2026 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGuUE9a4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF03D7D9F;
	Fri, 20 Mar 2026 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046454; cv=none; b=mAl6AO9BJy+q9J0Y5WAt8ngvKcYMBGbhR66CEqul6NEm3SIjvptA/BEZZXmnBOw462PnMyxxSdY1MK5r6Dp8z4xx7zDz9IdhACVrI/4ZOR+d35UTmpZfIZmseYoVOjI+Yjxeu70CR8L6QPpJkfjuXbyjdS76vW+FfkK/y4pFdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046454; c=relaxed/simple;
	bh=fRD05uAyOWBqNhdag2475Dgc8A9zXK7k9oX0V7v52Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWWZIXu2B/2Q2WcTo4HsMAndsgdZMYd14zSsEneZ6LE7RanFvYWu3wIoIFM4UcV8UA3hzb6+AP4bZ28KpXPuiYY8ffZtoC087A0RuWcDUfP4kWhBPVVAmzsPZF1NSe9P2rR7/aC5VvgHh4xyjoI0ajFA+SL1fgvOGr2PJRkgPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGuUE9a4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFD4C2BC87;
	Fri, 20 Mar 2026 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046454;
	bh=fRD05uAyOWBqNhdag2475Dgc8A9zXK7k9oX0V7v52Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGuUE9a4c2hZHiqHujn0BUmFS7EklH8dhxhHAHfiYxu7U0JEOD0eUVwF2CD3zpU3B
	 sfPyqFh3UoHDr0a7ssNkZeCHZwcJJwulK6/N5tnUhUpRuJJKs0uIa/ELG2wTrPDYTN
	 IvFAfTOz9iVUM8RUdZsz+8XE+UPFPLCUpG4adN8Itfu+IyN/4h6f75HXhbMTYD9gT+
	 j2FlwRuikF7v0mMHp1k+0I7Uizqk5Rsfc/GfB8PdlB7MAWEO/RvlGtLmMgBedYYE+L
	 2KFlFDq63Q+BbzKGkAvt/n0COHMOR9R+oy/Kh0S4aw6gBAKwkgfSA+YpVy/li5v80z
	 JGpbmw+QzEAuQ==
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
Subject: [PATCH v4 17/21] mm: allow handling of stacked mmap_prepare hooks in more drivers
Date: Fri, 20 Mar 2026 22:39:43 +0000
Message-ID: <24aac3019dd34740e788d169fccbe3c62781e648.1774045440.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9663-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 3513D2E21A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While the conversion of mmap hooks to mmap_prepare is underway, we will
encounter situations where mmap hooks need to invoke nested mmap_prepare
hooks.

The nesting of mmap hooks is termed 'stacking'.  In order to flexibly
facilitate the conversion of custom mmap hooks in drivers which stack, we
must split up the existing __compat_vma_mmap() function into two separate
functions:

* compat_set_desc_from_vma() - This allows the setting of a vm_area_desc
  object's fields to the relevant fields of a VMA.

* __compat_vma_mmap() - Once an mmap_prepare hook has been executed upon a
  vm_area_desc object, this function performs any mmap actions specified by
  the mmap_prepare hook and then invokes its vm_ops->mapped() hook if any
  were specified.

In ordinary cases, where a file's f_op->mmap_prepare() hook simply needs
to be invoked in a stacked mmap() hook, compat_vma_mmap() can be used.

However some drivers define their own nested hooks, which are invoked in
turn by another hook.

A concrete example is vmbus_channel->mmap_ring_buffer(), which is invoked
in turn by bin_attribute->mmap():

vmbus_channel->mmap_ring_buffer() has a signature of:

int (*mmap_ring_buffer)(struct vmbus_channel *channel,
			struct vm_area_struct *vma);

And bin_attribute->mmap() has a signature of:

	int (*mmap)(struct file *, struct kobject *,
		    const struct bin_attribute *attr,
		    struct vm_area_struct *vma);

And so compat_vma_mmap() cannot be used here for incremental conversion of
hooks from mmap() to mmap_prepare().

There are many such instances like this, where conversion to mmap_prepare
would otherwise cascade to a huge change set due to nesting of this kind.

The changes in this patch mean we could now instead convert
vmbus_channel->mmap_ring_buffer() to
vmbus_channel->mmap_prepare_ring_buffer(), and implement something like:

	struct vm_area_desc desc;
	int err;

	compat_set_desc_from_vma(&desc, file, vma);
	err = channel->mmap_prepare_ring_buffer(channel, &desc);
	if (err)
		return err;

	return __compat_vma_mmap(&desc, vma);

Allowing us to incrementally update this logic, and other logic like it.

Unfortunately, as part of this change, we need to be able to flexibly
assign to the VMA descriptor, so have to remove some of the const
declarations within the structure.

Also update the VMA tests to reflect the changes.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/fs.h              |   3 +
 include/linux/mm_types.h        |   4 +-
 mm/util.c                       | 119 +++++++++++++++++++++++---------
 mm/vma.h                        |   2 +-
 tools/testing/vma/include/dup.h |  68 +++++++++++-------
 5 files changed, 136 insertions(+), 60 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c390f5c667e3..0bdccfa70b44 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2058,6 +2058,9 @@ static inline bool can_mmap_file(struct file *file)
 	return true;
 }
 
+void compat_set_desc_from_vma(struct vm_area_desc *desc, const struct file *file,
+			      const struct vm_area_struct *vma);
+int __compat_vma_mmap(struct vm_area_desc *desc, struct vm_area_struct *vma);
 int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
 int __vma_check_mmap_hook(struct vm_area_struct *vma);
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 174286f9ecf0..d60eefde1db8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -891,8 +891,8 @@ static __always_inline bool vma_flags_empty(const vma_flags_t *flags)
  */
 struct vm_area_desc {
 	/* Immutable state. */
-	const struct mm_struct *const mm;
-	struct file *const file; /* May vary from vm_file in stacked callers. */
+	struct mm_struct *mm;
+	struct file *file; /* May vary from vm_file in stacked callers. */
 	unsigned long start;
 	unsigned long end;
 
diff --git a/mm/util.c b/mm/util.c
index a19f062b84dc..5ae20876ef2c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1163,38 +1163,78 @@ void flush_dcache_folio(struct folio *folio)
 EXPORT_SYMBOL(flush_dcache_folio);
 #endif
 
-static int __compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
-{
-	struct vm_area_desc desc = {
-		.mm = vma->vm_mm,
-		.file = file,
-		.start = vma->vm_start,
-		.end = vma->vm_end,
-
-		.pgoff = vma->vm_pgoff,
-		.vm_file = vma->vm_file,
-		.vma_flags = vma->flags,
-		.page_prot = vma->vm_page_prot,
-
-		.action.type = MMAP_NOTHING, /* Default */
-	};
-	struct mmap_action *action = &desc.action;
-	int err;
+/**
+ * compat_set_desc_from_vma() - assigns VMA descriptor @desc fields from a VMA.
+ * @desc: A VMA descriptor whose fields need to be set.
+ * @file: The file object describing the file being mmap()'d.
+ * @vma: The VMA whose fields we wish to assign to @desc.
+ *
+ * This is a compatibility function to allow an mmap() hook to call
+ * mmap_prepare() hooks when drivers nest these. This function specifically
+ * allows the construction of a vm_area_desc value, @desc, from a VMA @vma for
+ * the purposes of doing this.
+ *
+ * Once the conversion of drivers is complete this function will no longer be
+ * required and will be removed.
+ */
+void compat_set_desc_from_vma(struct vm_area_desc *desc,
+			      const struct file *file,
+			      const struct vm_area_struct *vma)
+{
+	memset(desc, 0, sizeof(*desc));
 
-	err = vfs_mmap_prepare(file, &desc);
-	if (err)
-		return err;
+	desc->mm = vma->vm_mm;
+	desc->file = (struct file *)file;
+	desc->start = vma->vm_start;
+	desc->end = vma->vm_end;
 
-	err = mmap_action_prepare(&desc);
-	if (err)
-		return err;
+	desc->pgoff = vma->vm_pgoff;
+	desc->vm_file = vma->vm_file;
+	desc->vma_flags = vma->flags;
+	desc->page_prot = vma->vm_page_prot;
 
-	/* being invoked from .mmmap means we don't have to enforce this. */
-	action->hide_from_rmap_until_complete = false;
+	/* Default. */
+	desc->action.type = MMAP_NOTHING;
+}
+EXPORT_SYMBOL(compat_set_desc_from_vma);
+
+/**
+ * __compat_vma_mmap() - Similar to compat_vma_mmap(), only it allows
+ * flexibility as to how the mmap_prepare callback is invoked, which is useful
+ * for drivers which invoke nested mmap_prepare callbacks in an mmap() hook.
+ * @desc: A VMA descriptor upon which an mmap_prepare() hook has already been
+ * executed.
+ * @vma: The VMA to which @desc should be applied.
+ *
+ * The function assumes that you have obtained a VMA descriptor @desc from
+ * compat_set_desc_from_vma(), and already executed the mmap_prepare() hook upon
+ * it.
+ *
+ * It then performs any specified mmap actions, and invokes the vm_ops->mapped()
+ * hook if one is present.
+ *
+ * See the description of compat_vma_mmap() for more details.
+ *
+ * Once the conversion of drivers is complete this function will no longer be
+ * required and will be removed.
+ *
+ * Returns: 0 on success or error.
+ */
+int __compat_vma_mmap(struct vm_area_desc *desc,
+		      struct vm_area_struct *vma)
+{
+	int err;
 
-	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, action);
+	/* Perform any preparatory tasks for mmap action. */
+	err = mmap_action_prepare(desc);
+	if (err)
+		return err;
+	/* Update the VMA from the descriptor. */
+	compat_set_vma_from_desc(vma, desc);
+	/* Complete any specified mmap actions. */
+	return mmap_action_complete(vma, &desc->action);
 }
+EXPORT_SYMBOL(__compat_vma_mmap);
 
 /**
  * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
@@ -1203,10 +1243,10 @@ static int __compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  *
  * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
- * stacked filesystems invoke a nested mmap hook of an underlying file.
+ * stacked drivers invoke a nested mmap hook of an underlying file.
  *
- * Until all filesystems are converted to use .mmap_prepare(), we must be
- * conservative and continue to invoke these stacked filesystems using the
+ * Until all drivers are converted to use .mmap_prepare(), we must be
+ * conservative and continue to invoke these stacked drivers using the
  * deprecated .mmap() hook.
  *
  * However we have a problem if the underlying file system possesses an
@@ -1217,14 +1257,27 @@ static int __compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
  * establishes a struct vm_area_desc descriptor, passes to the underlying
  * .mmap_prepare() hook and applies any changes performed by it.
  *
- * Once the conversion of filesystems is complete this function will no longer
- * be required and will be removed.
+ * Once the conversion of drivers is complete this function will no longer be
+ * required and will be removed.
  *
  * Returns: 0 on success or error.
  */
 int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap(file, vma);
+	struct vm_area_desc desc;
+	struct mmap_action *action;
+	int err;
+
+	compat_set_desc_from_vma(&desc, file, vma);
+	err = vfs_mmap_prepare(file, &desc);
+	if (err)
+		return err;
+	action = &desc.action;
+
+	/* being invoked from .mmmap means we don't have to enforce this. */
+	action->hide_from_rmap_until_complete = false;
+
+	return __compat_vma_mmap(&desc, vma);
 }
 EXPORT_SYMBOL(compat_vma_mmap);
 
diff --git a/mm/vma.h b/mm/vma.h
index adc18f7dd9f1..a76046c39b14 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -300,7 +300,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
  * f_op->mmap() but which might have an underlying file system which implements
  * f_op->mmap_prepare().
  */
-static inline void set_vma_from_desc(struct vm_area_struct *vma,
+static inline void compat_set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc)
 {
 	/*
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index a0c2379bd42b..f5f7c45f1808 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -519,8 +519,8 @@ enum vma_operation {
  */
 struct vm_area_desc {
 	/* Immutable state. */
-	const struct mm_struct *const mm;
-	struct file *const file; /* May vary from vm_file in stacked callers. */
+	struct mm_struct *mm;
+	struct file *file; /* May vary from vm_file in stacked callers. */
 	unsigned long start;
 	unsigned long end;
 
@@ -1274,50 +1274,70 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 }
 
 /* Declared in vma.h. */
-static inline void set_vma_from_desc(struct vm_area_struct *vma,
+static inline void compat_set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
+static inline void compat_set_desc_from_vma(struct vm_area_desc *desc,
+			      const struct file *file,
+			      const struct vm_area_struct *vma)
 {
-	return file->f_op->mmap_prepare(desc);
+	memset(desc, 0, sizeof(*desc));
+
+	desc->mm = vma->vm_mm;
+	desc->file = (struct file *)file;
+	desc->start = vma->vm_start;
+	desc->end = vma->vm_end;
+
+	desc->pgoff = vma->vm_pgoff;
+	desc->vm_file = vma->vm_file;
+	desc->vma_flags = vma->flags;
+	desc->page_prot = vma->vm_page_prot;
+
+	/* Default. */
+	desc->action.type = MMAP_NOTHING;
 }
 
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
+static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 {
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
-static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
-	struct vm_area_desc desc = {
-		.mm = vma->vm_mm,
-		.file = file,
-		.start = vma->vm_start,
-		.end = vma->vm_end,
-
-		.pgoff = vma->vm_pgoff,
-		.vm_file = vma->vm_file,
-		.vma_flags = vma->flags,
-		.page_prot = vma->vm_page_prot,
+	return file->f_op->mmap_prepare(desc);
+}
 
-		.action.type = MMAP_NOTHING, /* Default */
-	};
-	struct mmap_action *action = &desc.action;
+static inline int __compat_vma_mmap(struct vm_area_desc *desc,
+		struct vm_area_struct *vma)
+{
 	int err;
 
-	err = vfs_mmap_prepare(file, &desc);
+	/* Perform any preparatory tasks for mmap action. */
+	err = mmap_action_prepare(desc);
 	if (err)
 		return err;
+	/* Update the VMA from the descriptor. */
+	compat_set_vma_from_desc(vma, desc);
+	/* Complete any specified mmap actions. */
+	return mmap_action_complete(vma, &desc->action);
+}
 
-	err = mmap_action_prepare(&desc);
+static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct vm_area_desc desc;
+	struct mmap_action *action;
+	int err;
+
+	compat_set_desc_from_vma(&desc, file, vma);
+	err = vfs_mmap_prepare(file, &desc);
 	if (err)
 		return err;
+	action = &desc.action;
 
 	/* being invoked from .mmmap means we don't have to enforce this. */
 	action->hide_from_rmap_until_complete = false;
 
-	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, action);
+	return __compat_vma_mmap(&desc, vma);
 }
 
 static inline void vma_iter_init(struct vma_iterator *vmi,
-- 
2.53.0


