Return-Path: <linux-hyperv+bounces-9387-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOsJIJAis2m5SQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9387-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:31:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B84279345
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36A18305B08D
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1753FFABE;
	Thu, 12 Mar 2026 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/IDHplT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3B3FF897;
	Thu, 12 Mar 2026 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347304; cv=none; b=QtXyJ1vBltxv62qbB2XiHKNOz1DV40neb0bCjEzr6HktlFc7ayTJS7amfW0FPqzxQL/mJzsmaM6tAZtNDDhhu31koYzjZzI/1O8k2wkY6g0BRNmbQ7Y9r06TDHnAaZCxG5qQA61LNBy5AWgRXYJJyqXAQoH3CuvTxDVp3qQhgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347304; c=relaxed/simple;
	bh=jgGSscmoelPI8GEiWGdwMLRrmOSZJpVQGB2V/0UBDOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC8P3TNhyH5ubYcKJ4B/KXuWKDaenMdBcEmIWb0OBLyZkYi1w1+xt5q86cW8IXn7TegojHYQHgUQ7PmXOTRIBJC3SrOTNGD0W6lXsJmE30gBtOCJmO38t9fxyQ1ZRbZAG64Wd5tygkZwq+LKhSkk4pUps9Qn1rScEcoROtumjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/IDHplT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C774C19425;
	Thu, 12 Mar 2026 20:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773347303;
	bh=jgGSscmoelPI8GEiWGdwMLRrmOSZJpVQGB2V/0UBDOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/IDHplTtuCF1meDV4022nAtR0eunUyZdd/Pn6AG5LG8aC/qQuhx7VdN7Xi60Ijwi
	 rWIms1/Yp+FYH2BYdTfFB1pdAG2cEqHkRwA3NI10yCiiVssqT68FLEMWGinY97G30H
	 AMhWFjHZ8hWHClGwkxaGqF16kgp5Ih0W71zaBA5EXa4DZ9lvVjQJet93KcVY1YsC6w
	 AX6++a3hDsehyLMkh/7gGoppnBdYTd7QlvNYhmEvetQv3AVQaes0b+ASuwvNaf7KHG
	 eDJy51fvOizaY5bkXRbNrzCMor4ti+9ytYmyAT8JmZfpcabApjNaTPAcwwoSPYeevP
	 bV1fSgq3LSIXQ==
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
Subject: [PATCH 15/15] mm: add mmap_action_map_kernel_pages[_full]()
Date: Thu, 12 Mar 2026 20:27:30 +0000
Message-ID: <21d8899bb1f4db61203072fb3a56a6c98a61e23d.1773346620.git.ljs@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9387-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31B84279345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A user can invoke mmap_action_map_kernel_pages() to specify that the
mapping should map kernel pages starting from desc->start of a specified
number of pages specified in an array.

In order to implement this, adjust mmap_action_prepare() to be able to
return an error code, as it makes sense to assert that the specified
parameters are valid as quickly as possible as well as updating the VMA
flags to include VMA_MIXEDMAP_BIT as necessary.

This provides an mmap_prepare equivalent of vm_insert_pages().

We additionally update the existing vm_insert_pages() code to use
range_in_vma() and add a new range_in_vma_desc() helper function for the
mmap_prepare case, sharing the code between the two in range_is_subset().

We add both mmap_action_map_kernel_pages() and
mmap_action_map_kernel_pages_full() to allow for both partial and full VMA
mappings.

We also add mmap_action_map_kernel_pages_discontig() to allow for
discontiguous mapping of kernel pages should the need arise.

We update the documentation to reflect the new features.

Finally, we update the VMA tests accordingly to reflect the changes.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 Documentation/filesystems/mmap_prepare.rst |  8 ++
 include/linux/mm.h                         | 94 +++++++++++++++++++++-
 include/linux/mm_types.h                   |  7 ++
 mm/memory.c                                | 42 +++++++++-
 mm/util.c                                  |  6 ++
 tools/testing/vma/include/dup.h            |  7 ++
 6 files changed, 159 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/filesystems/mmap_prepare.rst
index d21406848bca..f89718285869 100644
--- a/Documentation/filesystems/mmap_prepare.rst
+++ b/Documentation/filesystems/mmap_prepare.rst
@@ -129,5 +129,13 @@ pointer. These are:
 * `mmap_action_simple_ioremap()` - Sets up an I/O remap from a specified
   physical address and over a specified length.
 
+* `mmap_action_map_kernel_pages()` - Maps a specified array of `struct page`
+  pointers in the VMA from a specific offset.
+
+* `mmap_action_map_kernel_pages_full()` - Maps a specified array of `struct
+  page` pointers over the entire VMA. The caller must ensure there are
+  sufficient entries in the page array to cover the entire range of the
+  described VMA.
+
 **NOTE:** The 'action' field should never normally be manipulated directly,
 rather you ought to use one of these helpers.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 88f42faeb377..88ad5649c02d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4160,6 +4160,45 @@ static inline void mmap_action_simple_ioremap(struct vm_area_desc *desc,
 	action->type = MMAP_SIMPLE_IO_REMAP;
 }
 
+/**
+ * mmap_action_map_kernel_pages - helper for mmap_prepare hook to specify that
+ * @num kernel pages contained in the @pages array should be mapped to userland
+ * starting at virtual address @start.
+ * @desc: The VMA descriptor for the VMA requiring kernel pags to be mapped.
+ * @start: The virtual address from which to map them.
+ * @pages: An array of struct page pointers describing the memory to map.
+ * @nr_pages: The number of entries in the @pages aray.
+ */
+static inline void mmap_action_map_kernel_pages(struct vm_area_desc *desc,
+		unsigned long start, struct page **pages,
+		unsigned long nr_pages)
+{
+	struct mmap_action *action = &desc->action;
+
+	action->type = MMAP_MAP_KERNEL_PAGES;
+	action->map_kernel.start = start;
+	action->map_kernel.pages = pages;
+	action->map_kernel.nr_pages = nr_pages;
+	action->map_kernel.pgoff = desc->pgoff;
+}
+
+/**
+ * mmap_action_map_kernel_pages_full - helper for mmap_prepare hook to specify that
+ * kernel pages contained in the @pages array should be mapped to userland
+ * from @desc->start to @desc->end.
+ * @desc: The VMA descriptor for the VMA requiring kernel pags to be mapped.
+ * @pages: An array of struct page pointers describing the memory to map.
+ *
+ * The caller must ensure that @pages contains sufficient entries to cover the
+ * entire range described by @desc.
+ */
+static inline void mmap_action_map_kernel_pages_full(struct vm_area_desc *desc,
+		struct page **pages)
+{
+	mmap_action_map_kernel_pages(desc, desc->start, pages,
+				     vma_desc_pages(desc));
+}
+
 int mmap_action_prepare(struct vm_area_desc *desc,
 			struct mmap_action *action);
 int mmap_action_complete(struct vm_area_struct *vma,
@@ -4177,10 +4216,59 @@ static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 	return vma;
 }
 
+/**
+ * range_is_subset - Is the specified inner range a subset of the outer range?
+ * @outer_start: The start of the outer range.
+ * @outer_end: The exclusive end of the outer range.
+ * @inner_start: The start of the inner range.
+ * @inner_end: The exclusive end of the inner range.
+ *
+ * Returns %true if [inner_start, inner_end) is a subset of [outer_start,
+ * outer_end), otherwise %false.
+ */
+static inline bool range_is_subset(unsigned long outer_start,
+				   unsigned long outer_end,
+				   unsigned long inner_start,
+				   unsigned long inner_end)
+{
+	return outer_start <= inner_start && inner_end <= outer_end;
+}
+
+/**
+ * range_in_vma - is the specified [@start, @end) range a subset of the VMA?
+ * @vma: The VMA against which we want to check [@start, @end).
+ * @start: The start of the range we wish to check.
+ * @end: The exclusive end of the range we wish to check.
+ *
+ * Returns %true if [@start, @end) is a subset of [@vma->vm_start,
+ * @vma->vm_end), %false otherwise.
+ */
 static inline bool range_in_vma(const struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
-	return (vma && vma->vm_start <= start && end <= vma->vm_end);
+	if (!vma)
+		return false;
+
+	return range_is_subset(vma->vm_start, vma->vm_end, start, end);
+}
+
+/**
+ * range_in_vma_desc - is the specified [@start, @end) range a subset of the VMA
+ * described by @desc, a VMA descriptor?
+ * @desc: The VMA descriptor against which we want to check [@start, @end).
+ * @start: The start of the range we wish to check.
+ * @end: The exclusive end of the range we wish to check.
+ *
+ * Returns %true if [@start, @end) is a subset of [@desc->start, @desc->end),
+ * %false otherwise.
+ */
+static inline bool range_in_vma_desc(const struct vm_area_desc *desc,
+				     unsigned long start, unsigned long end)
+{
+	if (!desc)
+		return false;
+
+	return range_is_subset(desc->start, desc->end, start, end);
 }
 
 #ifdef CONFIG_MMU
@@ -4212,6 +4300,10 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num);
+int map_kernel_pages_prepare(struct vm_area_desc *desc,
+			     struct mmap_action *action);
+int map_kernel_pages_complete(struct vm_area_struct *vma,
+			      struct mmap_action *action);
 int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 316bb0adf91d..6e7a399f0724 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -815,6 +815,7 @@ enum mmap_action_type {
 	MMAP_REMAP_PFN,		/* Remap PFN range. */
 	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
 	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
+	MMAP_MAP_KERNEL_PAGES,	/* Map kernel page range from array. */
 };
 
 /*
@@ -833,6 +834,12 @@ struct mmap_action {
 			phys_addr_t start_phys_addr;
 			unsigned long size;
 		} simple_ioremap;
+		struct {
+			unsigned long start;
+			struct page **pages;
+			unsigned long nr_pages;
+			pgoff_t pgoff;
+		} map_kernel;
 	};
 	enum mmap_action_type type;
 
diff --git a/mm/memory.c b/mm/memory.c
index 351cc917b7aa..608a98c4c947 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2484,13 +2484,14 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num)
 {
-	const unsigned long end_addr = addr + (*num * PAGE_SIZE) - 1;
+	const unsigned long nr_pages = *num;
+	const unsigned long end = addr + PAGE_SIZE * nr_pages;
 
-	if (addr < vma->vm_start || end_addr >= vma->vm_end)
+	if (!range_in_vma(vma, addr, end))
 		return -EFAULT;
 	if (!(vma->vm_flags & VM_MIXEDMAP)) {
-		BUG_ON(mmap_read_trylock(vma->vm_mm));
-		BUG_ON(vma->vm_flags & VM_PFNMAP);
+		VM_WARN_ON_ONCE(mmap_read_trylock(vma->vm_mm));
+		VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
 	/* Defer page refcount checking till we're about to map that page. */
@@ -2498,6 +2499,39 @@ int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_pages);
 
+int map_kernel_pages_prepare(struct vm_area_desc *desc,
+			     struct mmap_action *action)
+{
+	const unsigned long addr = action->map_kernel.start;
+	unsigned long nr_pages, end;
+
+	if (!vma_desc_test(desc, VMA_MIXEDMAP_BIT)) {
+		VM_WARN_ON_ONCE(mmap_read_trylock(desc->mm));
+		VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));
+		vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
+	}
+
+	nr_pages = action->map_kernel.nr_pages;
+	end = addr + PAGE_SIZE * nr_pages;
+	if (!range_in_vma_desc(desc, addr, end))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(map_kernel_pages_prepare);
+
+int map_kernel_pages_complete(struct vm_area_struct *vma,
+			      struct mmap_action *action)
+{
+	unsigned long nr_pages;
+
+	nr_pages = action->map_kernel.nr_pages;
+	return insert_pages(vma, action->map_kernel.start,
+			    action->map_kernel.pages,
+			    &nr_pages, vma->vm_page_prot);
+}
+EXPORT_SYMBOL(map_kernel_pages_complete);
+
 /**
  * vm_insert_page - insert single page into user vma
  * @vma: user vma to map to
diff --git a/mm/util.c b/mm/util.c
index e739d7c0311c..7934e303b230 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1445,6 +1445,8 @@ int mmap_action_prepare(struct vm_area_desc *desc,
 		return io_remap_pfn_range_prepare(desc, action);
 	case MMAP_SIMPLE_IO_REMAP:
 		return simple_ioremap_prepare(desc, action);
+	case MMAP_MAP_KERNEL_PAGES:
+		return map_kernel_pages_prepare(desc, action);
 	}
 }
 EXPORT_SYMBOL(mmap_action_prepare);
@@ -1473,6 +1475,9 @@ int mmap_action_complete(struct vm_area_struct *vma,
 	case MMAP_IO_REMAP_PFN:
 		err = io_remap_pfn_range_complete(vma, action);
 		break;
+	case MMAP_MAP_KERNEL_PAGES:
+		err = map_kernel_pages_complete(vma, action);
+		break;
 	case MMAP_SIMPLE_IO_REMAP:
 		/*
 		 * The simple I/O remap should have been delegated to an I/O
@@ -1496,6 +1501,7 @@ int mmap_action_prepare(struct vm_area_desc *desc,
 	case MMAP_REMAP_PFN:
 	case MMAP_IO_REMAP_PFN:
 	case MMAP_SIMPLE_IO_REMAP:
+	case MMAP_MAP_KERNEL_PAGES:
 		WARN_ON_ONCE(1); /* nommu cannot handle these. */
 		break;
 	}
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 4f2c9bb6b1ea..50ef2f62150d 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -425,6 +425,7 @@ enum mmap_action_type {
 	MMAP_REMAP_PFN,		/* Remap PFN range. */
 	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
 	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
+	MMAP_MAP_KERNEL_PAGES,	/* Map kernel page range from an array. */
 };
 
 /*
@@ -443,6 +444,12 @@ struct mmap_action {
 			phys_addr_t start;
 			unsigned long len;
 		} simple_ioremap;
+		struct {
+			unsigned long start;
+			struct page **pages;
+			unsigned long num;
+			pgoff_t pgoff;
+		} map_kernel;
 	};
 	enum mmap_action_type type;
 
-- 
2.53.0


