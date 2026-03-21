Return-Path: <linux-hyperv+bounces-9682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMrXF7kFvmmBFgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9682-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 03:43:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEBB2E2F3E
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 03:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D1FA301C582
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926727A904;
	Sat, 21 Mar 2026 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m7rFYZJy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98B40DFAC;
	Sat, 21 Mar 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774060981; cv=none; b=kLisQUB4eJQ0Ob1DTtTTq5G8nkcx0opUjzOH84E4+Q4KgKro6efZf4LjYonw+U4PdukNVaV962MLpC2iOTNsn99KhIY84CaYg9Nc+3cwusAdoyx9eh3f5+3xxhI0x70cRbbHmd5EiM5+OcygzIw4jwHlvIlZN22RGZWchthPG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774060981; c=relaxed/simple;
	bh=BgN7DRMw/b+g+o3kfdBnAM90Udq9D+FeM/bxcwNC3t4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jQVuyXsmMMn3uALX6wUpoilLawxvlwKfMFQpGq1RuisooErOW8tGRvZ1JeMh3Wjvp9qRnIzjQ2SX7EDfVhrvsgT3T+n7/+p6ceL92vLkqzyOqUyid4Q5ejv/G3uyXArVby6Rs2VILTso7EB2yGa5/e9MbvomlOkhXGHZdo1vIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=m7rFYZJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713BDC4CEF7;
	Sat, 21 Mar 2026 02:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774060980;
	bh=BgN7DRMw/b+g+o3kfdBnAM90Udq9D+FeM/bxcwNC3t4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7rFYZJyPUJygsgH+qiD39v5OLPAO4qM/j5uGyhL+yQw8aAoTQB9Y1SEP53/9Kin1
	 3WqGLjL4VUQjZS0N4OUlpTGI2wHXbNDD1qIiuETlW6pZu5Fa+LHFmJAqri/1nO1Grr
	 uitz00N5SqQNSahN3+dkJfjmUakWldSwDxOFAblo=
Date: Fri, 20 Mar 2026 19:42:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bodo Stroesser <bostroesser@gmail.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, David Hildenbrand <david@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Ryan Roberts
 <ryan.roberts@arm.com>
Subject: Re: [PATCH v4 00/21] mm: expand mmap_prepare functionality and
 usage
Message-Id: <20260320194258.9c00594e67c675a239ea44a6@linux-foundation.org>
In-Reply-To: <cover.1774045440.git.ljs@kernel.org>
References: <cover.1774045440.git.ljs@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9682-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAEBB2E2F3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 22:39:26 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:

> This series expands the mmap_prepare functionality, which is intended to
> replace the deprecated f_op->mmap hook which has been the source of bugs
> and security issues for some time.

Thanks, I updated mm-unstable to this version.  Here's how that altered
mm.git:


 Documentation/filesystems/mmap_prepare.rst |    4 
 include/linux/mm.h                         |    3 
 mm/internal.h                              |   27 ++++-
 mm/util.c                                  |   87 +++++++++----------
 mm/vma.c                                   |   41 +-------
 tools/testing/vma/include/dup.h            |   44 +--------
 tools/testing/vma/include/stubs.h          |    3 
 7 files changed, 80 insertions(+), 129 deletions(-)

--- a/Documentation/filesystems/mmap_prepare.rst~b
+++ a/Documentation/filesystems/mmap_prepare.rst
@@ -123,8 +123,8 @@ When implementing mmap_prepare(), refere
 as a ``VMA_xxx_BIT`` macro, e.g. ``VMA_READ_BIT``, ``VMA_WRITE_BIT`` etc.,
 and use one of (where ``desc`` is a pointer to struct vm_area_desc):
 
-* ``vma_desc_test_flags(desc, ...)`` - Specify a comma-separated list of flags
-  you wish to test for (whether _any_ are set), e.g. - ``vma_desc_test_flags(
+* ``vma_desc_test_any(desc, ...)`` - Specify a comma-separated list of flags
+  you wish to test for (whether _any_ are set), e.g. - ``vma_desc_test_any(
   desc, VMA_WRITE_BIT, VMA_MAYWRITE_BIT)`` - returns ``true`` if either are set,
   otherwise ``false``.
 * ``vma_desc_set_flags(desc, ...)`` - Update the VMA descriptor flags to set
--- a/include/linux/mm.h~b
+++ a/include/linux/mm.h
@@ -4394,8 +4394,7 @@ static inline void mmap_action_map_kerne
 
 int mmap_action_prepare(struct vm_area_desc *desc);
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action,
-			 bool rmap_lock_held);
+			 struct mmap_action *action);
 
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
--- a/mm/internal.h~b
+++ a/mm/internal.h
@@ -202,14 +202,6 @@ static inline void vma_close(struct vm_a
 /* unmap_vmas is in mm/memory.c */
 void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap);
 
-static inline void unmap_vma_locked(struct vm_area_struct *vma)
-{
-	const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-	mmap_assert_write_locked(vma->vm_mm);
-	do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
-}
-
 #ifdef CONFIG_MMU
 
 static inline void get_anon_vma(struct anon_vma *anon_vma)
@@ -1826,6 +1818,25 @@ static inline int io_remap_pfn_range_pre
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
--- a/mm/util.c~b
+++ a/mm/util.c
@@ -1198,25 +1198,6 @@ void compat_set_desc_from_vma(struct vm_
 }
 EXPORT_SYMBOL(compat_set_desc_from_vma);
 
-static int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
-{
-	const struct vm_operations_struct *vm_ops = vma->vm_ops;
-	void *vm_private_data = vma->vm_private_data;
-	int err;
-
-	if (!vm_ops || !vm_ops->mapped)
-		return 0;
-
-	err = vm_ops->mapped(vma->vm_start, vma->vm_end, vma->vm_pgoff, file,
-			     &vm_private_data);
-	if (err)
-		unmap_vma_locked(vma);
-	else if (vm_private_data != vma->vm_private_data)
-		vma->vm_private_data = vm_private_data;
-
-	return err;
-}
-
 /**
  * __compat_vma_mmap() - Similar to compat_vma_mmap(), only it allows
  * flexibility as to how the mmap_prepare callback is invoked, which is useful
@@ -1251,13 +1232,7 @@ int __compat_vma_mmap(struct vm_area_des
 	/* Update the VMA from the descriptor. */
 	compat_set_vma_from_desc(vma, desc);
 	/* Complete any specified mmap actions. */
-	err = mmap_action_complete(vma, &desc->action,
-				   /*rmap_lock_held=*/false);
-	if (err)
-		return err;
-
-	/* Invoke vm_ops->mapped callback. */
-	return __compat_vma_mapped(desc->file, vma);
+	return mmap_action_complete(vma, &desc->action);
 }
 EXPORT_SYMBOL(__compat_vma_mmap);
 
@@ -1290,12 +1265,17 @@ EXPORT_SYMBOL(__compat_vma_mmap);
 int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc;
+	struct mmap_action *action;
 	int err;
 
 	compat_set_desc_from_vma(&desc, file, vma);
 	err = vfs_mmap_prepare(file, &desc);
 	if (err)
 		return err;
+	action = &desc.action;
+
+	/* being invoked from .mmmap means we don't have to enforce this. */
+	action->hide_from_rmap_until_complete = false;
 
 	return __compat_vma_mmap(&desc, vma);
 }
@@ -1399,25 +1379,47 @@ again:
 	}
 }
 
+static int call_vma_mapped(struct vm_area_struct *vma)
+{
+	const struct vm_operations_struct *vm_ops = vma->vm_ops;
+	void *vm_private_data = vma->vm_private_data;
+	int err;
+
+	if (!vm_ops || !vm_ops->mapped)
+		return 0;
+
+	err = vm_ops->mapped(vma->vm_start, vma->vm_end, vma->vm_pgoff,
+			     vma->vm_file, &vm_private_data);
+	if (err)
+		return err;
+
+	if (vm_private_data != vma->vm_private_data)
+		vma->vm_private_data = vm_private_data;
+	return 0;
+}
+
 static int mmap_action_finish(struct vm_area_struct *vma,
-			      struct mmap_action *action, int err,
-			      bool rmap_lock_held)
+			      struct mmap_action *action, int err)
 {
-	if (rmap_lock_held)
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	size_t len;
 
-	if (!err) {
-		if (action->success_hook)
-			return action->success_hook(vma);
+	if (!err)
+		err = call_vma_mapped(vma);
+	if (!err && action->success_hook)
+		err = action->success_hook(vma);
+
+	/* do_munmap() might take rmap lock, so release if held. */
+	maybe_rmap_unlock_action(vma, action);
+	if (!err)
 		return 0;
-	}
 
 	/*
 	 * If an error occurs, unmap the VMA altogether and return an error. We
 	 * only clear the newly allocated VMA, since this function is only
 	 * invoked if we do NOT merge, so we only clean up the VMA we created.
 	 */
-	unmap_vma_locked(vma);
+	len = vma_pages(vma) << PAGE_SHIFT;
+	do_munmap(current->mm, vma->vm_start, len, NULL);
 	if (action->error_hook) {
 		/* We may want to filter the error. */
 		err = action->error_hook(err);
@@ -1459,16 +1461,13 @@ EXPORT_SYMBOL(mmap_action_prepare);
  * mmap_action_complete - Execute VMA descriptor action.
  * @vma: The VMA to perform the action upon.
  * @action: The action to perform.
- * @rmap_lock_held: Is the file rmap lock held?
  *
  * Similar to mmap_action_prepare().
  *
  * Return: 0 on success, or error, at which point the VMA will be unmapped.
  */
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action,
-			 bool rmap_lock_held)
-
+			 struct mmap_action *action)
 {
 	int err = 0;
 
@@ -1489,8 +1488,7 @@ int mmap_action_complete(struct vm_area_
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err,
-				  rmap_lock_held);
+	return mmap_action_finish(vma, action, err);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #else
@@ -1512,8 +1510,7 @@ int mmap_action_prepare(struct vm_area_d
 EXPORT_SYMBOL(mmap_action_prepare);
 
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action,
-			 bool rmap_lock_held)
+			 struct mmap_action *action)
 {
 	int err = 0;
 
@@ -1523,14 +1520,14 @@ int mmap_action_complete(struct vm_area_
 	case MMAP_REMAP_PFN:
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
-	casr MMAP_MAP_KERNEL_PAGES:
+	case MMAP_MAP_KERNEL_PAGES:
 		WARN_ON_ONCE(1); /* nommu cannot handle this. */
 
 		err = -EINVAL;
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err, rmap_lock_held);
+	return mmap_action_finish(vma, action, err);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #endif
--- a/mm/vma.c~b
+++ a/mm/vma.c
@@ -38,8 +38,6 @@ struct mmap_state {
 
 	/* Determine if we can check KSM flags early in mmap() logic. */
 	bool check_ksm_early :1;
-	/* If we map new, hold the file rmap lock on mapping. */
-	bool hold_file_rmap_lock :1;
 	/* If .mmap_prepare changed the file, we don't need to pin. */
 	bool file_doesnt_need_get :1;
 };
@@ -2530,10 +2528,12 @@ static int __mmap_new_file_vma(struct mm
  *
  * @map:  Mapping state.
  * @vmap: Output pointer for the new VMA.
+ * @action: Any mmap_prepare action that is still to complete.
  *
  * Returns: Zero on success, or an error.
  */
-static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
+static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
+	struct mmap_action *action)
 {
 	struct vma_iterator *vmi = map->vmi;
 	int error = 0;
@@ -2582,7 +2582,7 @@ static int __mmap_new_vma(struct mmap_st
 	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
 	map->mm->map_count++;
-	vma_link_file(vma, map->hold_file_rmap_lock);
+	vma_link_file(vma, action->hide_from_rmap_until_complete);
 
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
@@ -2649,8 +2649,6 @@ static int call_action_prepare(struct mm
 	if (err)
 		return err;
 
-	if (desc->action.hide_from_rmap_until_complete)
-		map->hold_file_rmap_lock = true;
 	return 0;
 }
 
@@ -2731,30 +2729,6 @@ static bool can_set_ksm_flags_early(stru
 	return false;
 }
 
-static int call_mapped_hook(struct mmap_state *map,
-			    struct vm_area_struct *vma)
-{
-	const struct vm_operations_struct *vm_ops = vma->vm_ops;
-	void *vm_private_data = vma->vm_private_data;
-	int err;
-
-	if (!vm_ops || !vm_ops->mapped)
-		return 0;
-	err = vm_ops->mapped(vma->vm_start, vma->vm_end, vma->vm_pgoff,
-			     vma->vm_file, &vm_private_data);
-	if (err) {
-		if (map->hold_file_rmap_lock)
-			i_mmap_unlock_write(vma->vm_file->f_mapping);
-
-		unmap_vma_locked(vma);
-		return err;
-	}
-	/* Update private data if changed. */
-	if (vm_private_data != vma->vm_private_data)
-		vma->vm_private_data = vm_private_data;
-	return 0;
-}
-
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vma_flags_t vma_flags,
 		unsigned long pgoff, struct list_head *uf)
@@ -2794,7 +2768,7 @@ static unsigned long __mmap_region(struc
 
 	/* ...but if we can't, allocate a new VMA. */
 	if (!vma) {
-		error = __mmap_new_vma(&map, &vma);
+		error = __mmap_new_vma(&map, &vma, &desc.action);
 		if (error)
 			goto unacct_error;
 		allocated_new = true;
@@ -2806,10 +2780,7 @@ static unsigned long __mmap_region(struc
 	__mmap_complete(&map, vma);
 
 	if (have_mmap_prepare && allocated_new) {
-		error = mmap_action_complete(vma, &desc.action,
-					     map.hold_file_rmap_lock);
-		if (!error)
-			error = call_mapped_hook(&map, vma);
+		error = mmap_action_complete(vma, &desc.action);
 		if (error)
 			return error;
 	}
--- a/tools/testing/vma/include/dup.h~b
+++ a/tools/testing/vma/include/dup.h
@@ -1313,27 +1313,9 @@ static inline unsigned long vma_pages(co
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
-static inline void unmap_vma_locked(struct vm_area_struct *vma)
-{
-	const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-	mmap_assert_write_locked(vma->vm_mm);
-	do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
-}
-
-static inline int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
-	const struct vm_operations_struct *vm_ops = vma->vm_ops;
-	int err;
-
-	if (!vm_ops->mapped)
-		return 0;
-
-	err = vm_ops->mapped(vma->vm_start, vma->vm_end, vma->vm_pgoff, file,
-			     &vma->vm_private_data);
-	if (err)
-		unmap_vma_locked(vma);
-	return err;
+	return file->f_op->mmap_prepare(desc);
 }
 
 static inline int __compat_vma_mmap(struct vm_area_desc *desc,
@@ -1348,35 +1330,27 @@ static inline int __compat_vma_mmap(stru
 	/* Update the VMA from the descriptor. */
 	compat_set_vma_from_desc(vma, desc);
 	/* Complete any specified mmap actions. */
-	err = mmap_action_complete(vma, &desc->action,
-				   /*rmap_lock_held=*/false);
-	if (err)
-		return err;
-
-	/* Invoke vm_ops->mapped callback. */
-	return __compat_vma_mapped(desc->file, vma);
-}
-
-static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
-{
-	return file->f_op->mmap_prepare(desc);
+	return mmap_action_complete(vma, &desc->action);
 }
 
-static inline int compat_vma_mmap(struct file *file,
-		struct vm_area_struct *vma)
+static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc;
+	struct mmap_action *action;
 	int err;
 
 	compat_set_desc_from_vma(&desc, file, vma);
 	err = vfs_mmap_prepare(file, &desc);
 	if (err)
 		return err;
+	action = &desc.action;
+
+	/* being invoked from .mmmap means we don't have to enforce this. */
+	action->hide_from_rmap_until_complete = false;
 
 	return __compat_vma_mmap(&desc, vma);
 }
 
-
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
--- a/tools/testing/vma/include/stubs.h~b
+++ a/tools/testing/vma/include/stubs.h
@@ -87,8 +87,7 @@ static inline int mmap_action_prepare(st
 }
 
 static inline int mmap_action_complete(struct vm_area_struct *vma,
-				       struct mmap_action *action,
-				       bool rmap_lock_held)
+				       struct mmap_action *action)
 {
 	return 0;
 }
_


