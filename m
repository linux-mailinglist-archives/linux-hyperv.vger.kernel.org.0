Return-Path: <linux-hyperv+bounces-9646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBqpA87MvWmsCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9646-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:40:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A72602E1D35
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBDA93031E84
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120A37B008;
	Fri, 20 Mar 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyQwSOAj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97ED2E1F11;
	Fri, 20 Mar 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046406; cv=none; b=toEa7kYE4QWoux8i2vMYGAlyfCN9zqULT7u5SzSe0g3QuZrievGyc13kNqouS9tClWaDs62oG0JrjA/W03SK/DrwHpTnrdjF/YIIO6MgyeSMrXTEagSvmkGyDAGgnncsnF7EzrrYNsfEgSvR3Su5XuDQeyZoGN66lLHsKWZ1oNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046406; c=relaxed/simple;
	bh=P2mslC++0zk+mcj13b8jLsDA4S5ZGJbmZDQiowDGZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUJ/YzzH9J6ZsKIN9Cmm52T2M47e6My+icMqYViGUMVIimuSjA3k9LZ+lEL+1qI0dOozYjbQ4qIGK/G+9SIkzogp3+iitnxkJuZyMtLQ0vmIeW0GtYrckbogLlDpQXn29TzSBB2LGRxX7/iTWeHn6QfNztVS490oEWLSxqgh5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyQwSOAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E20C4CEF7;
	Fri, 20 Mar 2026 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774046406;
	bh=P2mslC++0zk+mcj13b8jLsDA4S5ZGJbmZDQiowDGZDE=;
	h=From:To:Cc:Subject:Date:From;
	b=IyQwSOAjCQNvWLi99FsyWyA9GCrN68275qcV2+Tebm9ZMvRz6KuIghiKEY8GsySsm
	 I17pFqJyqx9rr5vYHO7P0EAPefKlWABUW/DpvDLLFVYxnJH6+RN0m34os5KpKYH8qF
	 nCQ3jz7X0qeQDqnQnYv1rZx9FChvzhpWLF0s0u13j9FQJDup/n4agriaxrDV6qtv7T
	 I7WtUvonBYeBUCjvB9OcdzUF73Vzn0eAw6rxoc4W6bcHign7vDKR74EgB76KnDm9Vp
	 P32kO5lkRTlpmDwHpbqyWFSHU8irzhWpP5y6RLH2agII8/XtTrdZWyXcCPKGoPS5RQ
	 kAAclJMcwaA8g==
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
Subject: [PATCH v4 00/21] mm: expand mmap_prepare functionality and usage
Date: Fri, 20 Mar 2026 22:39:26 +0000
Message-ID: <cover.1774045440.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	TAGGED_FROM(0.00)[bounces-9646-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A72602E1D35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series expands the mmap_prepare functionality, which is intended to
replace the deprecated f_op->mmap hook which has been the source of bugs
and security issues for some time.

This series starts with some cleanup of existing mmap_prepare logic, then
adds documentation for the mmap_prepare call to make it easier for
filesystem and driver writers to understand how it works.

It then importantly adds a vm_ops->mapped hook, a key feature that was
missing from mmap_prepare previously - this is invoked when a driver which
specifies mmap_prepare has successfully been mapped but not merged with
another VMA.

mmap_prepare is invoked prior to a merge being attempted, so you cannot
manipulate state such as reference counts as if it were a new mapping.

The vm_ops->mapped hook allows a driver to perform tasks required at this
stage, and provides symmetry against subsequent vm_ops->open,close calls.

The series uses this to correct the afs implementation which wrongly
manipulated reference count at mmap_prepare time.

It then adds an mmap_prepare equivalent of vm_iomap_memory() -
mmap_action_simple_ioremap(), then uses this to update a number of drivers.

It then splits out the mmap_prepare compatibility layer (which allows for
invocation of mmap_prepare hooks in an mmap() hook) in such a way as to
allow for more incremental implementation of mmap_prepare hooks.

It then uses this to extend mmap_prepare usage in drivers.

Finally it adds an mmap_prepare equivalent of vm_map_pages(), which lays
the foundation for future work which will extend mmap_prepare to DMA
coherent mappings.

v4:
* Added partial revert of AFS as per Vlasta. Labelled as hotfix.
* Updated subsequent afs patch to apply against this version of AFS.
* Reverted rmap_lock_held changes to util.c, mm.h mmap_action_complete()
  etc. as per Vlasta.
* Added hotfix to fix issue with rmap lock held over munmap() as per
  Vlasta. Labelled as hotfix.
* Force-disable the rmap lock hold feature in the compatbility layer
  because being run under the mmap hook eliminates the need for it.
* Removed superfluous map->hold_file_rmap_lock field.
* Moved handling of rmap lock and unmapping to mmap_action_complete().
* Removed unmap_vma_locked() as previous added patches render it
  unnecessary.
* Removed __compat_vma_mapped() from compatibility layer and
  call_vma_mapped() from VMA layer and made it part of mmap_action_finish()
  for all callers.
* Propagated changes to VMA tests.
* Updated mmap_action_map_kernel_pages[_full]() patch to add missing
  mmap_complete() noop switch enum value as per Nathan.
* Fixed a doc issue in the mmap_prepare docs - reference
  vma_desc_test_flags() rather than _any().
* Rearranged logic so the vm_ops->mapped hook is called before the success
  hook, but this should have no impact.

v3:
* Propagated tags (thanks Suren, Richard!)
* Updated 12/16 to correctly clear the vm_area_desc data structure in
  set_desc_from_vma() as per Joshua Hahn (thanks! :)
* Fixed type in 12/16 as per Suren (cheers!)
* Fixed up 6/16 to use mmap_action_ioremap_full() in simple_ioremap_prepare() as
  suggested by Suren.
* Also fixed up 6/16 to call io_remap_pfn_range_prepare() direct rather than
  mmap_action_prepare() as per Suren.
* Also fixed up 6/16 to pass vm_len rather than vm_[start, end] to
  __simple_ioremap_prep() as per Suren (thanks for all the above! :)
* Fixed issue in rmap lock being held - we were referencing a vma->vm_file after
  the VMA was unmapped, so UAF. Avoid that. Also do_munmap() relies on rmap lock
  NOT being held or may deadlock, so extend functionality to ensure we drop it
  when it is held on error paths.
* Updated 'area' -> 'vma' variable in 3/16 in VMA test dup.h.
* Fixed up reference to __compat_vma_mmap() in 12/16 commit message.
* Updated 1/16 to no longer duplicatively apply io_remap_pfn_range_pfn().
* Updated 1/16 to delegate I/O remap complete to remap complete logic.
* Fixed various typos in 12/16.
* Fixed stale comment typos in 13/16.
* Fixed commit msg and comment typos in 14/16.
* Removed accidental sneak peak to future functionality in 15/16 commit message
  :).
* Fixed up field names to be identical in VMA tests + mm_types.h in 6/16,
  15/16.
https://lore.kernel.org/all/cover.1773944114.git.ljs@kernel.org/

v2:
* Rebased on
  https://lore.kernel.org/all/cover.1773665966.git.ljs@kernel.org/ to make
  Andrew's life easier :)
* Folded all interim fixes into series (thanks Randy for many doc fixes!))
* As per Suren, removed a comment about allocations too small to fail.
* As per Randy, fixed up typo in documentation for vm_area_desc.
* Fixed mmap_action_prepare() not returning if invalid action->type
  specified, as updated from Andrew's interim fix (thanks!) and also
  reported by kernel test bot.
* Updated mmap_action_prepare() and specific prepare functions to only
  pass vm_area_desc parameter as per Suren.
* Fixed up whitespace as per Suren.
* Updated vm_op->open comment in vm_operations_struct to reference forking
  as per Suren.
* Added a commit to check that input range is within VMA on remap as per
  Suren (this also covers I/O remap and all other cases already asserted).
* Updated AFS to not incorrectly reference count on mmap prepare as per
  Usama.
* Also updated various static AFS functions to be consistent with each
  other.
* Updated AFS commit message to reflect mmap_prepare being before any VMA
  merging as per Suren.
* Updated __compat_vma_mapped() to check for NULL vm_ops as per Usama.
* Updated __compat_vma_mapped() to not reference an unmapped VMA's fields
  as per Usama.
* Updated __vma_check_mmap_hook() to check for NULL vm_ops as per Usama.
* Dropped comment about preferring mmap_prepare as seems overly confusing,
  as per Suren.
* Updated the mmap lock assert in unmap_vma_locked() to a write lock assert
  as per Suren.
* Copied vm_ops->open comment over to VMA tests in appropriate patch as per
  Suren.
* Updated mmap_prepare documentation to reflect the fact that no resources
  should be allocated upon mmap_prepare.
* Updated mmap_prepare documentation to reference the vm_ops->mapped
  callback.
* Fixed stray markdown '## How to use' in documentation.
* Fixed bug reported by kernel test bot re: overlooked
  vma_desc_test_flags() -> vma_desc_test() in MTD driver for nommu.
https://lore.kernel.org/linux-mm/cover.1773695307.git.ljs@kernel.org/

v1:
https://lore.kernel.org/linux-mm/cover.1773346620.git.ljs@kernel.org/

Lorenzo Stoakes (Oracle) (21):
  mm: various small mmap_prepare cleanups
  mm: add documentation for the mmap_prepare file operation callback
  mm: document vm_operations_struct->open the same as close()
  mm: avoid deadlock when holding rmap on mmap_prepare error
  mm: switch the rmap lock held option off in compat layer
  mm/vma: remove superfluous map->hold_file_rmap_lock
  mm: have mmap_action_complete() handle the rmap lock and unmap
  mm: add vm_ops->mapped hook
  fs: afs: revert mmap_prepare() change
  fs: afs: restore mmap_prepare implementation
  mm: add mmap_action_simple_ioremap()
  misc: open-dice: replace deprecated mmap hook with mmap_prepare
  hpet: replace deprecated mmap hook with mmap_prepare
  mtdchar: replace deprecated mmap hook with mmap_prepare, clean up
  stm: replace deprecated mmap hook with mmap_prepare
  staging: vme_user: replace deprecated mmap hook with mmap_prepare
  mm: allow handling of stacked mmap_prepare hooks in more drivers
  drivers: hv: vmbus: replace deprecated mmap hook with mmap_prepare
  uio: replace deprecated mmap hook with mmap_prepare in uio_info
  mm: add mmap_action_map_kernel_pages[_full]()
  mm: on remap assert that input range within the proposed VMA

 Documentation/driver-api/vme.rst           |   2 +-
 Documentation/filesystems/index.rst        |   1 +
 Documentation/filesystems/mmap_prepare.rst | 168 ++++++++++++++
 drivers/char/hpet.c                        |  12 +-
 drivers/hv/hyperv_vmbus.h                  |   4 +-
 drivers/hv/vmbus_drv.c                     |  31 ++-
 drivers/hwtracing/stm/core.c               |  31 ++-
 drivers/misc/open-dice.c                   |  19 +-
 drivers/mtd/mtdchar.c                      |  21 +-
 drivers/staging/vme_user/vme.c             |  20 +-
 drivers/staging/vme_user/vme.h             |   2 +-
 drivers/staging/vme_user/vme_user.c        |  51 +++--
 drivers/target/target_core_user.c          |  26 ++-
 drivers/uio/uio.c                          |  10 +-
 drivers/uio/uio_hv_generic.c               |  11 +-
 fs/afs/file.c                              |  36 ++-
 include/linux/fs.h                         |  14 +-
 include/linux/hyperv.h                     |   4 +-
 include/linux/mm.h                         | 158 ++++++++++++-
 include/linux/mm_types.h                   |  17 +-
 include/linux/uio_driver.h                 |   4 +-
 mm/internal.h                              |  46 +++-
 mm/memory.c                                | 175 ++++++++++----
 mm/util.c                                  | 251 ++++++++++++++-------
 mm/vma.c                                   |  48 ++--
 mm/vma.h                                   |   2 +-
 tools/testing/vma/include/dup.h            | 134 +++++++----
 tools/testing/vma/include/stubs.h          |   8 +-
 28 files changed, 956 insertions(+), 350 deletions(-)
 create mode 100644 Documentation/filesystems/mmap_prepare.rst

--
2.53.0

