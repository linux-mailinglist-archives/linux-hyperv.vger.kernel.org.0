Return-Path: <linux-hyperv+bounces-9374-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NXFERQis2m5SQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9374-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:29:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CD279231
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D2C731C649E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4113803D2;
	Thu, 12 Mar 2026 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK1Wltim"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8E37C0E7;
	Thu, 12 Mar 2026 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347273; cv=none; b=sYWvBfMlxHbhvu9+L3r8bkQeqtfvAHA6200fktWlBpaPH9e4WeXBgmBbpG2/fOF4Wenus7E9QQuzK5YJSbmPF8UPdswf+RX8YRTTPmSvOYIc/k4A9SPZNogoc57bNeltKV/v6+JDSz0ukhB4c2XYj1/7epPvPnrdXkcHVzNahqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347273; c=relaxed/simple;
	bh=Vhnl6dyI6DciWh1R2wyZ1qlkDiUoqFRvSKLSiU1V8ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWF4uGOlCClOW3Fu9tepBHjkZQ2lilYq6MtMWEBo0qJyCm/71ivrKliLHfqvnFWqDj09gQmYL7SCz8DuymYKK4XjrtQ44GSofCDtQNuPOd7Ksi+AURIwlcFbh8L3+bMdeT7q+waI+anO/yb4PsB2+SU8i1a0nx8eB0+6PFAMeh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK1Wltim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B7DC19425;
	Thu, 12 Mar 2026 20:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773347273;
	bh=Vhnl6dyI6DciWh1R2wyZ1qlkDiUoqFRvSKLSiU1V8ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZK1WltimUAZc0jYB/huW7CthVu5Pu5VFPFyTyvlS4T7HMAkTnJpb74i68i41ylW7Q
	 7fyRQuCh/gLCub/cymRHsmhpsfS8DFpbAqZr1SS92G3+vQpwXbZfJnBMCChrImWhS6
	 V+8bnKKwhWmdij/nWi43ezCIkdrjaJHlgcQy5rFniS8jR/7Rlk/YDXp43NqjK9oYzc
	 FeI0J/rG34AJ6d6heDnhG73A8JiyAlXMohvdqoF701Bc7TYx5fMtntCofNtc6fMrPg
	 EWAXKwA/Mf9O9WCfz+8946sw4KO8eURIrObVsTiW6QjgNpFc+hr+6SFctAmLsbLljH
	 BJiGxYp2Ms+uA==
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
Subject: [PATCH 02/15] mm: add documentation for the mmap_prepare file operation callback
Date: Thu, 12 Mar 2026 20:27:17 +0000
Message-ID: <c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9374-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: E24CD279231
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This documentation makes it easier for a driver/file system implementer to
correctly use this callback.

It covers the fundamentals, whilst intentionally leaving the less lovely
possible actions one might take undocumented (for instance - the
success_hook, error_hook fields in mmap_action).

The document also covers the new VMA flags implementation which is the only
one which will work correctly with mmap_prepare.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 Documentation/filesystems/mmap_prepare.rst | 131 +++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/filesystems/mmap_prepare.rst

diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/filesystems/mmap_prepare.rst
new file mode 100644
index 000000000000..76908200f3a1
--- /dev/null
+++ b/Documentation/filesystems/mmap_prepare.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+mmap_prepare callback HOWTO
+===========================
+
+Introduction
+############
+
+The `struct file->f_op->mmap()` callback has been deprecated as it is both a
+stability and security risk, and doesn't always permit the merging of adjacent
+mappings resulting in unnecessary memory fragmentation.
+
+It has been replaced with the `file->f_op->mmap_prepare()` callback which solves
+these problems.
+
+## How To Use
+
+In your driver's `struct file_operations` struct, specify an `mmap_prepare`
+callback rather than an `mmap` one, e.g. for ext4:
+
+
+.. code-block:: C
+
+    const struct file_operations ext4_file_operations = {
+        ...
+        .mmap_prepare    = ext4_file_mmap_prepare,
+    };
+
+This has a signature of `int (*mmap_prepare)(struct vm_area_desc *)`.
+
+Examining the `struct vm_area_desc` type:
+
+.. code-block:: C
+
+    struct vm_area_desc {
+        /* Immutable state. */
+        const struct mm_struct *const mm;
+        struct file *const file; /* May vary from vm_file in stacked callers. */
+        unsigned long start;
+        unsigned long end;
+
+        /* Mutable fields. Populated with initial state. */
+        pgoff_t pgoff;
+        struct file *vm_file;
+        vma_flags_t vma_flags;
+        pgprot_t page_prot;
+
+        /* Write-only fields. */
+        const struct vm_operations_struct *vm_ops;
+        void *private_data;
+
+        /* Take further action? */
+        struct mmap_action action;
+    };
+
+This is straightforward - you have all the fields you need to set up the
+mapping, and you can update the mutable and writable fields, for instance:
+
+.. code-block:: Cw
+
+    static int ext4_file_mmap_prepare(struct vm_area_desc *desc)
+    {
+        int ret;
+        struct file *file = desc->file;
+        struct inode *inode = file->f_mapping->host;
+
+        ...
+
+        file_accessed(file);
+        if (IS_DAX(file_inode(file))) {
+            desc->vm_ops = &ext4_dax_vm_ops;
+            vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
+        } else {
+            desc->vm_ops = &ext4_file_vm_ops;
+        }
+        return 0;
+    }
+
+Importantly, you no longer have to dance around with reference counts or locks
+when updating these fields - __you can simply go ahead and change them__.
+
+Everything is taken care of by the mapping code.
+
+VMA Flags
+=========
+
+Along with `mmap_prepare`, VMA flags have undergone an overhaul. Where before
+you would invoke one of `vm_flags_init()`, `vm_flags_reset()`, `vm_flags_set()`,
+`vm_flags_clear()`, and `vm_flags_mod()` to modify flags (and to have the
+locking done correctly for you, this is no longer necessary.
+
+Also, the legacy approach of specifying VMA flags via `VM_READ`, `VM_WRITE`,
+etc. - i.e. using a `VM_xxx` macro has changed too.
+
+When implementing `mmap_prepare()`, reference flags by their bit number, defined
+as a `VMA_xxx_BIT` macro, e.g. `VMA_READ_BIT`, `VMA_WRITE_BIT` etc., and use one
+of (where `desc` is a pointer to `struct vma_area_desc`):
+
+* `vma_desc_test_flags(desc, ...)` - Specify a comma-separated list of flags you
+  wish to test for (whether _any_ are set), e.g. - `vma_desc_test_flags(desc,
+  VMA_WRITE_BIT, VMA_MAYWRITE_BIT)` - returns `true` if either are set,
+  otherwise `false`.
+* `vma_desc_set_flags(desc, ...)` - Update the VMA descriptor flags to set
+  additional flags specified by a comma-separated list,
+  e.g. - `vma_desc_set_flags(desc, VMA_PFNMAP_BIT, VMA_IO_BIT)`.
+* `vma_desc_clear_flags(desc, ...)` - Update the VMA descriptor flags to clear
+  flags specified by a comma-separated list, e.g. - `vma_desc_clear_flags(desc,
+  VMA_WRITE_BIT, VMA_MAYWRITE_BIT)`.
+
+Actions
+=======
+
+You can now very easily have actions be performed upon a mapping once set up by
+utilising simple helper functions invoked upon the `struct vm_area_desc`
+pointer. These are:
+
+* `mmap_action_remap()` - Remaps a range consisting only of PFNs for a specific
+  range starting a virtual address and PFN number of a set size.
+
+* `mmap_action_remap_full()` - Same as `mmap_action_remap()`, only remaps the
+  entire mapping from `start_pfn` onward.
+
+* `mmap_action_ioremap()` - Same as `mmap_action_remap()`, only performs an I/O
+  remap.
+
+* `mmap_action_ioremap_full()` - Same as `mmap_action_ioremap()`, only remaps
+  the entire mapping from `start_pfn` onward.
+
+**NOTE:** The 'action' field should never normally be manipulated directly,
+rather you ought to use one of these helpers.
-- 
2.53.0


