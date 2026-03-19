Return-Path: <linux-hyperv+bounces-9567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKHYLlRAvGlzvwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9567-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 19:28:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5C2D0EF4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 19:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AB11308E30D
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 18:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714933FB7C9;
	Thu, 19 Mar 2026 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZgkP81+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869D3FB076;
	Thu, 19 Mar 2026 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944660; cv=none; b=RO7iAdDPFxRQ8+vVybZIPn3MAs4oPDcFGWTKIuaWtgSF5vTZLy7SwUwNs+czeF8QJtv4FkLjYQ5h6urgV2ZeZ57sX3S4tRl501YWOy/0ehj+vRE8Av2ODjX+HtwD2/5u30ARrGwEUPGc33BNkBSUGx+Zc6eTdtiOI+TW6rslhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944660; c=relaxed/simple;
	bh=xhLlmwR4AUj9PhlewTo4sEx2FcR6iF+ofwi5SoZX8Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWi9r49KfETE3IHT2E3kEzfDKr7Ajwn98qDhjkvexBsTXmxa8/cWt7K69R4oo/si0ATmGfn9lKcRo3BSrnsr/Y6f8aGl0So1UakYlzsgl3L+o1npiP9INrYBZll4Lzq6A58vWMLnaji//Hw9ebLx4gnfDn/ajjSnRQCUv990O2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZgkP81+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8234FC2BCB1;
	Thu, 19 Mar 2026 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773944660;
	bh=xhLlmwR4AUj9PhlewTo4sEx2FcR6iF+ofwi5SoZX8Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZgkP81+To5o4+opP9DVY1B5L2QIqkffzZEmmi0qbgQF8ZVYK6KsNBItOdUPSj8Nw
	 bMAJAsZplTZg309A7z2OhoR8cJq1hs3Voltr+9XPsXqcr6B8T7QpMIUib8B1mw5zpn
	 zoJGI26UscPsQWtn1lV1WfrFgdQq/o2bKzW0dF1zLlzxZsvheOTfctL2OpkWYsLPm6
	 nf4EakEPzGXz2D3JzZ3dRo797Ig/ffZ8ia8X/aRBpZVx1/2wLN18YVJKawCcJFWUqK
	 28ck4MYHjmCzOUK3wFG9x513U6FnnHUq3xwOTyMHg9ARTMeUrZvVAYbymNlAVqMYPt
	 dO8wscgfJc1bg==
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
Subject: [PATCH v3 12/16] mm: allow handling of stacked mmap_prepare hooks in more drivers
Date: Thu, 19 Mar 2026 18:23:36 +0000
Message-ID: <05b4d97d6248777a827f17445760b460cd293cb4.1773944114.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773944114.git.ljs@kernel.org>
References: <cover.1773944114.git.ljs@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9567-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DD5C2D0EF4
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
 mm/util.c                       | 112 ++++++++++++++++++++++---------
 mm/vma.h                        |   2 +-
 tools/testing/vma/include/dup.h | 114 +++++++++++++++++++++-----------
 5 files changed, 162 insertions(+), 73 deletions(-)

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
index 50685cf29792..7538d64f8848 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -891,8 +891,8 @@ static __always_inline bool vma_flags_empty(vma_flags_t *flags)
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
index 879ba62b5f0c..8cf59267a9ac 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1163,34 +1163,40 @@ void flush_dcache_folio(struct folio *folio)
 EXPORT_SYMBOL(flush_dcache_folio);
 #endif
 
-static int __compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
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
 {
-	struct vm_area_desc desc = {
-		.mm = vma->vm_mm,
-		.file = file,
-		.start = vma->vm_start,
-		.end = vma->vm_end,
+	memset(desc, 0, sizeof(*desc));
 
-		.pgoff = vma->vm_pgoff,
-		.vm_file = vma->vm_file,
-		.vma_flags = vma->flags,
-		.page_prot = vma->vm_page_prot,
-
-		.action.type = MMAP_NOTHING, /* Default */
-	};
-	int err;
+	desc->mm = vma->vm_mm;
+	desc->file = (struct file *)file;
+	desc->start = vma->vm_start;
+	desc->end = vma->vm_end;
 
-	err = vfs_mmap_prepare(file, &desc);
-	if (err)
-		return err;
+	desc->pgoff = vma->vm_pgoff;
+	desc->vm_file = vma->vm_file;
+	desc->vma_flags = vma->flags;
+	desc->page_prot = vma->vm_page_prot;
 
-	err = mmap_action_prepare(&desc);
-	if (err)
-		return err;
-
-	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, &desc.action, /*rmap_lock_held=*/false);
+	/* Default. */
+	desc->action.type = MMAP_NOTHING;
 }
+EXPORT_SYMBOL(compat_set_desc_from_vma);
 
 static int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
 {
@@ -1211,6 +1217,50 @@ static int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
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
+
+	/* Perform any preparatory tasks for mmap action. */
+	err = mmap_action_prepare(desc);
+	if (err)
+		return err;
+	/* Update the VMA from the descriptor. */
+	compat_set_vma_from_desc(vma, desc);
+	/* Complete any specified mmap actions. */
+	err = mmap_action_complete(vma, &desc->action,
+				   /*rmap_lock_held=*/false);
+	if (err)
+		return err;
+
+	/* Invoke vm_ops->mapped callback. */
+	return __compat_vma_mapped(desc->file, vma);
+}
+EXPORT_SYMBOL(__compat_vma_mmap);
+
 /**
  * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
  * existing VMA and execute any requested actions.
@@ -1218,10 +1268,10 @@ static int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
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
@@ -1232,20 +1282,22 @@ static int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
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
+	struct vm_area_desc desc;
 	int err;
 
-	err = __compat_vma_mmap(file, vma);
+	compat_set_desc_from_vma(&desc, file, vma);
+	err = vfs_mmap_prepare(file, &desc);
 	if (err)
 		return err;
 
-	return __compat_vma_mapped(file, vma);
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
index 1b86c34e1158..1f123704078e 100644
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
 
@@ -1272,43 +1272,95 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 }
 
 /* Declared in vma.h. */
-static inline void set_vma_from_desc(struct vm_area_struct *vma,
+static inline void compat_set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline int __compat_vma_mmap(const struct file_operations *f_op,
-		struct file *file, struct vm_area_struct *vma)
+static inline void compat_set_desc_from_vma(struct vm_area_desc *desc,
+			      const struct file *file,
+			      const struct vm_area_struct *vma)
 {
-	struct vm_area_desc desc = {
-		.mm = vma->vm_mm,
-		.file = file,
-		.start = vma->vm_start,
-		.end = vma->vm_end,
+	memset(desc, 0, sizeof(*desc));
 
-		.pgoff = vma->vm_pgoff,
-		.vm_file = vma->vm_file,
-		.vma_flags = vma->flags,
-		.page_prot = vma->vm_page_prot,
+	desc->mm = vma->vm_mm;
+	desc->file = (struct file *)file;
+	desc->start = vma->vm_start;
+	desc->end = vma->vm_end;
 
-		.action.type = MMAP_NOTHING, /* Default */
-	};
+	desc->pgoff = vma->vm_pgoff;
+	desc->vm_file = vma->vm_file;
+	desc->vma_flags = vma->flags;
+	desc->page_prot = vma->vm_page_prot;
+
+	/* Default. */
+	desc->action.type = MMAP_NOTHING;
+}
+
+static inline unsigned long vma_pages(const struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline void unmap_vma_locked(struct vm_area_struct *vma)
+{
+	const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+	mmap_assert_write_locked(vma->vm_mm);
+	do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
+}
+
+static inline int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
+{
+	const struct vm_operations_struct *vm_ops = vma->vm_ops;
 	int err;
 
-	err = f_op->mmap_prepare(&desc);
+	if (!vm_ops->mapped)
+		return 0;
+
+	err = vm_ops->mapped(vma->vm_start, vma->vm_end, vma->vm_pgoff, file,
+			     &vma->vm_private_data);
 	if (err)
-		return err;
+		unmap_vma_locked(vma);
+	return err;
+}
 
-	err = mmap_action_prepare(&desc);
+static inline int __compat_vma_mmap(struct vm_area_desc *desc,
+		struct vm_area_struct *vma)
+{
+	int err;
+
+	/* Perform any preparatory tasks for mmap action. */
+	err = mmap_action_prepare(desc);
+	if (err)
+		return err;
+	/* Update the VMA from the descriptor. */
+	compat_set_vma_from_desc(vma, desc);
+	/* Complete any specified mmap actions. */
+	err = mmap_action_complete(vma, &desc->action,
+				   /*rmap_lock_held=*/false);
 	if (err)
 		return err;
 
-	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, &desc.action, /*rmap_lock_held=*/false);
+	/* Invoke vm_ops->mapped callback. */
+	return __compat_vma_mapped(desc->file, vma);
+}
+
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
 }
 
 static inline int compat_vma_mmap(struct file *file,
 		struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap(file->f_op, file, vma);
+	struct vm_area_desc desc;
+	int err;
+
+	compat_set_desc_from_vma(&desc, file, vma);
+	err = vfs_mmap_prepare(file, &desc);
+	if (err)
+		return err;
+
+	return __compat_vma_mmap(&desc, vma);
 }
 
 
@@ -1318,11 +1370,6 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
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
@@ -1492,11 +1539,6 @@ static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
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
@@ -1521,11 +1563,3 @@ static inline pgprot_t vma_get_page_prot(vma_flags_t vma_flags)
 
 	return vm_get_page_prot(vm_flags);
 }
-
-static inline void unmap_vma_locked(struct vm_area_struct *vma)
-{
-	const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-	mmap_assert_write_locked(vma->vm_mm);
-	do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
-}
-- 
2.53.0


