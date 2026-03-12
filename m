Return-Path: <linux-hyperv+bounces-9372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN/LJcchs2m5SQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9372-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:27:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3127917B
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2292303A5DE
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADBA373BE0;
	Thu, 12 Mar 2026 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="craZlvZb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364533242AC;
	Thu, 12 Mar 2026 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347269; cv=none; b=YAL/wto9t1ZEgXR+rQnwGig2OZCew1g/dffUaeqPUvp/I18T84fY+zXZFX8jsFwC8LpATlxiz3jQLLbIXxYdGEnNJgb2faloYDX0d5cSZm6VdpyKVlhprSnhpVsqlXdIvcbHoasHwJCbtJ7rG2v611ZIkp2Gv675j/nSOtClK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347269; c=relaxed/simple;
	bh=UHRT8qRmUgXL60CxpkG8XqJ40rRzobM0A/lzS/hpZy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKPpvJr8qIBpX0owczbZEsYnnJIvxIcb6M1zvyQsGYo+CfOnmiAOWwBlLWqAVGzaT6su0ZIZw6ZupKJxSIHhoTWcjFLSYGpdVaeVOmSlXdBtHRk9+P85lr670jHTOlxuMT3kSYtya/JT8ngZs4j6MVXdGFPcWEyk1REtzDC2JmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=craZlvZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0DDC4CEF7;
	Thu, 12 Mar 2026 20:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773347268;
	bh=UHRT8qRmUgXL60CxpkG8XqJ40rRzobM0A/lzS/hpZy8=;
	h=From:To:Cc:Subject:Date:From;
	b=craZlvZb5CGklOhHfqyBv/N2B4J7VOxsEGxAyy49uaJyF1Jyg/1A800kZeyO1k4yW
	 d4nk35Hw7zkQKIqmK7i3AotkuZ9aCNg5kxBohTKgQiC/uPu/S8LiGo/e5ToGK1QfhL
	 xDjyWyVf4HhkL/qRL1ZknbK8aS+MIfLKHEYCRjLEBYMJlSBM9eRsvDIYzl4YfSpmsj
	 iB7IBjXqGYz+BNhwdRbqTNlG379au2uoUSMc6AvVYa8NoaP28LQ32Omvd8/6aW2CWE
	 MvfLMlDkSAkFhGIFTmwORZMdnQ9l/wOcUhOFUQoYNegqsXtG1QaNKdM6TFCpqdII1U
	 /nFm+u8VpBCFA==
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
Subject: [PATCH 00/15] mm: expand mmap_prepare functionality and usage
Date: Thu, 12 Mar 2026 20:27:15 +0000
Message-ID: <cover.1773346620.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9372-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 41B3127917B
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

Importantly, mmap_prepare is invoked prior to a merge being attempted, so
you cannot manipulate state such as reference counts as if it were a new
mapping.

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

Lorenzo Stoakes (Oracle) (15):
  mm: various small mmap_prepare cleanups
  mm: add documentation for the mmap_prepare file operation callback
  mm: document vm_operations_struct->open the same as close()
  mm: add vm_ops->mapped hook
  fs: afs: correctly drop reference count on mapping failure
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

 Documentation/driver-api/vme.rst           |   2 +-
 Documentation/filesystems/mmap_prepare.rst | 141 ++++++++++++++
 drivers/char/hpet.c                        |  12 +-
 drivers/hv/hyperv_vmbus.h                  |   4 +-
 drivers/hv/vmbus_drv.c                     |  27 ++-
 drivers/hwtracing/stm/core.c               |  31 ++-
 drivers/misc/open-dice.c                   |  19 +-
 drivers/mtd/mtdchar.c                      |  21 +-
 drivers/staging/vme_user/vme.c             |  20 +-
 drivers/staging/vme_user/vme.h             |   2 +-
 drivers/staging/vme_user/vme_user.c        |  51 +++--
 drivers/target/target_core_user.c          |  26 ++-
 drivers/uio/uio.c                          |  10 +-
 drivers/uio/uio_hv_generic.c               |  11 +-
 fs/afs/file.c                              |  20 +-
 include/linux/fs.h                         |  14 +-
 include/linux/hyperv.h                     |   4 +-
 include/linux/mm.h                         | 158 +++++++++++++--
 include/linux/mm_types.h                   |  17 +-
 include/linux/uio_driver.h                 |   4 +-
 mm/internal.h                              |  41 ++--
 mm/memory.c                                | 174 ++++++++++++-----
 mm/util.c                                  | 213 +++++++++++++++------
 mm/vma.c                                   |  56 ++++--
 mm/vma.h                                   |   2 +-
 tools/testing/vma/include/dup.h            | 143 ++++++++++----
 tools/testing/vma/include/stubs.h          |   9 +-
 27 files changed, 933 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/filesystems/mmap_prepare.rst

--
2.53.0

