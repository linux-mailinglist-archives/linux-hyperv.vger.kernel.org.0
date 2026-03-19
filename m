Return-Path: <linux-hyperv+bounces-9561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEBXEpg/vGlzvwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9561-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 19:25:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2192D0D7F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 19:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1463530266CF
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E369E3F9F44;
	Thu, 19 Mar 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUlhN8ha"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8653F54C4;
	Thu, 19 Mar 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944642; cv=none; b=XCLZ/wW57WMJHtLWHyOGoYBHENKqpUE92UMIDQtjEjBwm2SEuWD5nkhod//hAEc4DFrLMlYwHZ8N3VpQbzp+fI0IfHFK3SzEt4pUnTqn0M52synoP77SC9RBmqoYQ4nf1vLKXgzNPg6DNpyEMxFsVesP35KmrRAEBRxbw4LJFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944642; c=relaxed/simple;
	bh=6Gs389cDcfbWp+CxLW+X4AJWAHdnJe2WbDq0Ac8c1Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKDeWshKQZVoSHNnQ4hdZo6GWXLsvKfxP9MjJ8LlJ+IQLA6X2uThRdNf2+zYi2cqfzCvP3jZbtHni4AJbyKyKEdbtPYdwCdZp2FqskurG2E2Og8KA9mTRP98IdpqHtZikDF/sezKd3WrWeOsTQsTfE66XdqXW/6z0cy19iHYFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUlhN8ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10260C19424;
	Thu, 19 Mar 2026 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773944642;
	bh=6Gs389cDcfbWp+CxLW+X4AJWAHdnJe2WbDq0Ac8c1Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUlhN8haks8iHpDvH0wIqg5gSdCrrEldNyOlgD9TsNyj0dXbYG6fnWoWpEQUFWx5q
	 rTg1zx8L0sjbLEazEVdBi75GgyRFBkBC/PQzEl0CH9VAX0X/HeLOi28lekyh4tHlHL
	 yuuNnNAEv1380wGAIGx5hEKAO+j9nXu9ijB5DcWoplNfM+EvpT/cTrZb222pK+KhBD
	 sH7f+F/tco8dLn58XHzoh2T+tXJPX17exc73Ql4kyWYH7IKG89vuFHwbo1UQdXVEmk
	 22QXHLGub2U1S3Qa+c31qYqQwJohwzKf9NScIGmL9qFhYUaRju6YRw+2gcVSMSbXqp
	 tHS2OmWhECtEw==
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
Subject: [PATCH v3 06/16] mm: add mmap_action_simple_ioremap()
Date: Thu, 19 Mar 2026 18:23:30 +0000
Message-ID: <cd8492e65adc48ab75596293c821efd21fea1283.1773944114.git.ljs@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9561-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.968];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC2192D0D7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently drivers use vm_iomap_memory() as a simple helper function for
I/O remapping memory over a range starting at a specified physical address
over a specified length.

In order to utilise this from mmap_prepare, separate out the core logic
into __simple_ioremap_prep(), update vm_iomap_memory() to use it, and add
simple_ioremap_prepare() to do the same with a VMA descriptor object.

We also add MMAP_SIMPLE_IO_REMAP and relevant fields to the struct
mmap_action type to permit this operation also.

We use mmap_action_ioremap() to set up the actual I/O remap operation once
we have checked and figured out the parameters, which makes
simple_ioremap_prepare() easy to implement.

We then add mmap_action_simple_ioremap() to allow drivers to make use of
this mode.

We update the mmap_prepare documentation to describe this mode.  Finally,
we update the VMA tests to reflect this change.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 Documentation/filesystems/mmap_prepare.rst |  3 +
 include/linux/mm.h                         | 24 +++++-
 include/linux/mm_types.h                   |  6 +-
 mm/internal.h                              |  1 +
 mm/memory.c                                | 85 +++++++++++++++-------
 mm/util.c                                  |  5 ++
 tools/testing/vma/include/dup.h            |  6 +-
 7 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/filesystems/mmap_prepare.rst
index 20db474915da..be76ae475b9c 100644
--- a/Documentation/filesystems/mmap_prepare.rst
+++ b/Documentation/filesystems/mmap_prepare.rst
@@ -153,5 +153,8 @@ pointer. These are:
 * mmap_action_ioremap_full() - Same as mmap_action_ioremap(), only remaps
   the entire mapping from ``start_pfn`` onward.
 
+* mmap_action_simple_ioremap() - Sets up an I/O remap from a specified
+  physical address and over a specified length.
+
 **NOTE:** The ``action`` field should never normally be manipulated directly,
 rather you ought to use one of these helpers.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 68dee1101313..ef2e4dccfe8e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4337,11 +4337,33 @@ static inline void mmap_action_ioremap(struct vm_area_desc *desc,
  * @start_pfn: The first PFN in the range to remap.
  */
 static inline void mmap_action_ioremap_full(struct vm_area_desc *desc,
-					  unsigned long start_pfn)
+					    unsigned long start_pfn)
 {
 	mmap_action_ioremap(desc, desc->start, start_pfn, vma_desc_size(desc));
 }
 
+/**
+ * mmap_action_simple_ioremap - helper for mmap_prepare hook to specify that the
+ * physical range in [start_phys_addr, start_phys_addr + size) should be I/O
+ * remapped.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start_phys_addr: Start of the physical memory to be mapped.
+ * @size: Size of the area to map.
+ *
+ * NOTE: Some drivers might want to tweak desc->page_prot for purposes of
+ * write-combine or similar.
+ */
+static inline void mmap_action_simple_ioremap(struct vm_area_desc *desc,
+					      phys_addr_t start_phys_addr,
+					      unsigned long size)
+{
+	struct mmap_action *action = &desc->action;
+
+	action->simple_ioremap.start_phys_addr = start_phys_addr;
+	action->simple_ioremap.size = size;
+	action->type = MMAP_SIMPLE_IO_REMAP;
+}
+
 int mmap_action_prepare(struct vm_area_desc *desc);
 int mmap_action_complete(struct vm_area_struct *vma,
 			 struct mmap_action *action,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4a229cc0a06b..50685cf29792 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -814,6 +814,7 @@ enum mmap_action_type {
 	MMAP_NOTHING,		/* Mapping is complete, no further action. */
 	MMAP_REMAP_PFN,		/* Remap PFN range. */
 	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
 };
 
 /*
@@ -822,13 +823,16 @@ enum mmap_action_type {
  */
 struct mmap_action {
 	union {
-		/* Remap range. */
 		struct {
 			unsigned long start;
 			unsigned long start_pfn;
 			unsigned long size;
 			pgprot_t pgprot;
 		} remap;
+		struct {
+			phys_addr_t start_phys_addr;
+			unsigned long size;
+		} simple_ioremap;
 	};
 	enum mmap_action_type type;
 
diff --git a/mm/internal.h b/mm/internal.h
index e0f554178143..2aa04d87ac10 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1804,6 +1804,7 @@ int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 int remap_pfn_range_prepare(struct vm_area_desc *desc);
 int remap_pfn_range_complete(struct vm_area_struct *vma,
 			     struct mmap_action *action);
+int simple_ioremap_prepare(struct vm_area_desc *desc);
 
 static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 9dec67a18116..b3bcc21af20a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3170,6 +3170,58 @@ int remap_pfn_range_complete(struct vm_area_struct *vma,
 	return do_remap_pfn_range(vma, start, pfn, size, prot);
 }
 
+static int __simple_ioremap_prep(unsigned long vm_len, pgoff_t vm_pgoff,
+				 phys_addr_t start_phys, unsigned long size,
+				 unsigned long *pfnp)
+{
+	unsigned long pfn, pages;
+
+	/* Check that the physical memory area passed in looks valid */
+	if (start_phys + size < start_phys)
+		return -EINVAL;
+	/*
+	 * You *really* shouldn't map things that aren't page-aligned,
+	 * but we've historically allowed it because IO memory might
+	 * just have smaller alignment.
+	 */
+	size += start_phys & ~PAGE_MASK;
+	pfn = start_phys >> PAGE_SHIFT;
+	pages = (size + ~PAGE_MASK) >> PAGE_SHIFT;
+	if (pfn + pages < pfn)
+		return -EINVAL;
+
+	/* We start the mapping 'vm_pgoff' pages into the area */
+	if (vm_pgoff > pages)
+		return -EINVAL;
+	pfn += vm_pgoff;
+	pages -= vm_pgoff;
+
+	/* Can we fit all of the mapping? */
+	if ((vm_len >> PAGE_SHIFT) > pages)
+		return -EINVAL;
+
+	*pfnp = pfn;
+	return 0;
+}
+
+int simple_ioremap_prepare(struct vm_area_desc *desc)
+{
+	struct mmap_action *action = &desc->action;
+	const phys_addr_t start = action->simple_ioremap.start_phys_addr;
+	const unsigned long size = action->simple_ioremap.size;
+	unsigned long pfn;
+	int err;
+
+	err = __simple_ioremap_prep(vma_desc_size(desc), desc->pgoff,
+				    start, size, &pfn);
+	if (err)
+		return err;
+
+	/* The I/O remap logic does the heavy lifting. */
+	mmap_action_ioremap_full(desc, pfn);
+	return io_remap_pfn_range_prepare(desc);
+}
+
 /**
  * vm_iomap_memory - remap memory to userspace
  * @vma: user vma to map to
@@ -3187,32 +3239,15 @@ int remap_pfn_range_complete(struct vm_area_struct *vma,
  */
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len)
 {
-	unsigned long vm_len, pfn, pages;
-
-	/* Check that the physical memory area passed in looks valid */
-	if (start + len < start)
-		return -EINVAL;
-	/*
-	 * You *really* shouldn't map things that aren't page-aligned,
-	 * but we've historically allowed it because IO memory might
-	 * just have smaller alignment.
-	 */
-	len += start & ~PAGE_MASK;
-	pfn = start >> PAGE_SHIFT;
-	pages = (len + ~PAGE_MASK) >> PAGE_SHIFT;
-	if (pfn + pages < pfn)
-		return -EINVAL;
-
-	/* We start the mapping 'vm_pgoff' pages into the area */
-	if (vma->vm_pgoff > pages)
-		return -EINVAL;
-	pfn += vma->vm_pgoff;
-	pages -= vma->vm_pgoff;
+	const unsigned long vm_start = vma->vm_start;
+	const unsigned long vm_end = vma->vm_end;
+	const unsigned long vm_len = vm_end - vm_start;
+	unsigned long pfn;
+	int err;
 
-	/* Can we fit all of the mapping? */
-	vm_len = vma->vm_end - vma->vm_start;
-	if (vm_len >> PAGE_SHIFT > pages)
-		return -EINVAL;
+	err = __simple_ioremap_prep(vm_len, vma->vm_pgoff, start, len, &pfn);
+	if (err)
+		return err;
 
 	/* Ok, let it rip */
 	return io_remap_pfn_range(vma, vma->vm_start, pfn, vm_len, vma->vm_page_prot);
diff --git a/mm/util.c b/mm/util.c
index fc1bd8a8f3ea..879ba62b5f0c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1392,6 +1392,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 		return remap_pfn_range_prepare(desc);
 	case MMAP_IO_REMAP_PFN:
 		return io_remap_pfn_range_prepare(desc);
+	case MMAP_SIMPLE_IO_REMAP:
+		return simple_ioremap_prepare(desc);
 	}
 
 	WARN_ON_ONCE(1);
@@ -1423,6 +1425,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		err = remap_pfn_range_complete(vma, action);
 		break;
 	case MMAP_IO_REMAP_PFN:
+	case MMAP_SIMPLE_IO_REMAP:
 		/* Should have been delegated. */
 		WARN_ON_ONCE(1);
 		err = -EINVAL;
@@ -1441,6 +1444,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 		break;
 	case MMAP_REMAP_PFN:
 	case MMAP_IO_REMAP_PFN:
+	case MMAP_SIMPLE_IO_REMAP:
 		WARN_ON_ONCE(1); /* nommu cannot handle these. */
 		break;
 	}
@@ -1460,6 +1464,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		break;
 	case MMAP_REMAP_PFN:
 	case MMAP_IO_REMAP_PFN:
+	case MMAP_SIMPLE_IO_REMAP:
 		WARN_ON_ONCE(1); /* nommu cannot handle this. */
 
 		err = -EINVAL;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index aa34966cbc62..1b86c34e1158 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -453,6 +453,7 @@ enum mmap_action_type {
 	MMAP_NOTHING,		/* Mapping is complete, no further action. */
 	MMAP_REMAP_PFN,		/* Remap PFN range. */
 	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+	MMAP_SIMPLE_IO_REMAP,	/* I/O remap with guardrails. */
 };
 
 /*
@@ -461,13 +462,16 @@ enum mmap_action_type {
  */
 struct mmap_action {
 	union {
-		/* Remap range. */
 		struct {
 			unsigned long start;
 			unsigned long start_pfn;
 			unsigned long size;
 			pgprot_t pgprot;
 		} remap;
+		struct {
+			phys_addr_t start_phys_addr;
+			unsigned long size;
+		} simple_ioremap;
 	};
 	enum mmap_action_type type;
 
-- 
2.53.0


