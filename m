Return-Path: <linux-hyperv+bounces-8916-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHu3IrK/lmmslgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8916-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 08:45:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70DD15CC7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 08:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9698F301455C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B0B2D948D;
	Thu, 19 Feb 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaMxPqGj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375D2C21C4;
	Thu, 19 Feb 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487152; cv=none; b=TXPE9kSBeZerHpHZuGwjhAOBD8LqsjoLTBS9ZdhqQuADxvsCON0kehDNJneVjGVVxuD7Xcu3Oa+L61D6iYDkTXaNbgwp6pqBHtgc/jdjF3JTOwh64zIpPBZZN3ppbxgv9XOOvxjk5yGSPnt93uz/3/+IzoXuqpT+2vLC8Y7nxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487152; c=relaxed/simple;
	bh=z/BIKnB3OFmfyadtE0DY92Y8YH+VNO3ijqGgQfxRQk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KjlU+NJScjk0Ilo+NtYgbvUDgprQHoKl5n0GL0CTdfsNR+MRVtfNlp2Jd12Pmzk1cr+2f/jnZHfbJMHf89n7qIexmMGnn9+PPvrDQP+aKAsT79CH5SAsqryFRxtwC9ypaNQH9clJxc2g3SoGbCcwkwdlf4DnWUFBIk9jdOhpx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaMxPqGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D674C4CEF7;
	Thu, 19 Feb 2026 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771487151;
	bh=z/BIKnB3OFmfyadtE0DY92Y8YH+VNO3ijqGgQfxRQk0=;
	h=Date:From:To:Cc:Subject:From;
	b=BaMxPqGj9Hn9aKsjWEM29juzvjfEt6yKavKCTMKeLqwSymJdRQkK2WOpuBQnrikLG
	 X1tAhKEf+DFQihfhHERInTAbSDcvjPuOFHx/rCC/KL6ND5hROaicp+GrLCFENQemJQ
	 VtvAlGd89gViERHy8Tpbpno5faXwQ4TmrjYtlic5lyMBm3xQnx2fUg6U+jf18gaAmr
	 d6crN6phapbSlzOUzVbGM1chOQnq9uOGb/2+Wc4q33Yg59Yo1+D+bdQKMjTU8CPHeG
	 VxBSwCW43OXQLLMWgXOOj79AKi8rqAxSUN8fpdqd8qGnomDe31s2EI+8Xz4gdbA+5n
	 5tniBDUETd0vA==
Date: Thu, 19 Feb 2026 07:45:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V patches for 7.0
Message-ID: <20260219074550.GA2773704@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8916-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D70DD15CC7B
X-Rspamd-Action: no action

Hi Linus,

The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:

  Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260218

for you to fetch changes up to 158ebb578cd5f7881fdc7c4ecebddcf9463f91fd:

  mshv: Handle insufficient root memory hypervisor statuses (2026-02-19 06:42:11 +0000)

----------------------------------------------------------------
hyperv-next for v7.0
  - Debugfs support for MSHV statistics (Nuno Das Neves)
  - Support for the integrated scheduler (Stanislav Kinsburskii)
  - Various fixes for MSHV memory management and hypervisor status
    handling (Stanislav Kinsburskii)
  - Expose more capabilities and flags for MSHV partition management
    (Anatol Belski, Muminul Islam, Magnus Kulke)
  - Miscellaneous fixes to improve code quality and stability (Carlos
    López, Ethan Nelson-Moore, Li RongQing, Michael Kelley, Mukesh
    Rathor, Purna Pavan Chandra Aekkaladevi, Stanislav Kinsburskii, Uros
    Bizjak) 
  - PREEMPT_RT fixes for vmbus interrupts (Jan Kiszka)
----------------------------------------------------------------
Anatol Belski (1):
      mshv: Add SMT_ENABLED_GUEST partition creation flag

Carlos López (1):
      mshv: clear eventfd counter on irqfd shutdown

Ethan Nelson-Moore (1):
      PCI: hv: remove unnecessary module_init/exit functions

Ethan Tidmore (1):
      x86/hyperv: Fix error pointer dereference

Jan Kiszka (1):
      Drivers: hv: vmbus: Use kthread for vmbus interrupts on PREEMPT_RT

Li RongQing (1):
      mshv: fix SRCU protection in irqfd resampler ack handler

Magnus Kulke (1):
      mshv: expose the scrub partition hypercall

Michael Kelley (7):
      PCI: hv: Remove unused field pci_bus in struct hv_pcibus_device
      mshv: Fix compiler warning about cast converting incompatible function type
      mshv: Use EPOLLIN and EPOLLHUP instead of POLLIN and POLLHUP
      Drivers: hv: Use memremap()/memunmap() instead of ioremap_cache()/iounmap()
      x86/hyperv: Use memremap()/memunmap() instead of ioremap_cache()/iounmap()
      x86/hyperv: Update comment in hyperv_cleanup()
      Drivers: hv: vmbus: Simplify allocation of vmbus_evt

Mukesh R (3):
      x86/hyperv: fix a compiler warning in hv_crash.c
      x86/hyperv: Move hv crash init after hypercall pg setup
      mshv: make field names descriptive in a header struct

Mukesh Rathor (1):
      x86/hyperv: Reserve 3 interrupt vectors used exclusively by MSHV

Muminul Islam (1):
      mshv: Add nested virtualization creation flag

Nuno Das Neves (3):
      mshv: Update hv_stats_page definitions
      mshv: Add data for printing stats page counters
      mshv: Add debugfs to view hypervisor statistics

Purna Pavan Chandra Aekkaladevi (1):
      mshv: Ignore second stats page map result failure

Stanislav Kinsburskii (8):
      mshv: Use typed hv_stats_page pointers
      mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
      mshv: Always map child vp stats pages regardless of scheduler type
      mshv: Add support for integrated scheduler
      mshv: Introduce hv_result_needs_memory() helper function
      mshv: Introduce hv_deposit_memory helper functions
      mshv: Handle insufficient contiguous memory hypervisor status
      mshv: Handle insufficient root memory hypervisor statuses

Uros Bizjak (3):
      x86/hyperv: Use savesegment() instead of inline asm() to save segment registers
      x86/hyperv: Remove ASM_CALL_CONSTRAINT with VMMCALL insn
      mshv: Use try_cmpxchg() instead of cmpxchg()

 arch/x86/hyperv/hv_crash.c               |   3 +-
 arch/x86/hyperv/hv_init.c                |  20 +-
 arch/x86/hyperv/hv_vtl.c                 |   8 +-
 arch/x86/hyperv/ivm.c                    |  11 +-
 arch/x86/kernel/cpu/mshyperv.c           |  25 ++
 drivers/hv/Makefile                      |   1 +
 drivers/hv/hv.c                          |  12 +-
 drivers/hv/hv_common.c                   |   3 +
 drivers/hv/hv_proc.c                     |  53 ++-
 drivers/hv/hyperv_vmbus.h                |   4 +-
 drivers/hv/mshv_debugfs.c                | 726 +++++++++++++++++++++++++++++++
 drivers/hv/mshv_debugfs_counters.c       | 490 +++++++++++++++++++++
 drivers/hv/mshv_eventfd.c                |  22 +-
 drivers/hv/mshv_eventfd.h                |   1 -
 drivers/hv/mshv_regions.c                |  60 +--
 drivers/hv/mshv_root.h                   |  59 ++-
 drivers/hv/mshv_root_hv_call.c           | 104 +++--
 drivers/hv/mshv_root_main.c              | 238 ++++++----
 drivers/hv/mshv_vtl_main.c               |   5 +-
 drivers/hv/vmbus_drv.c                   |  86 +++-
 drivers/pci/controller/pci-hyperv-intf.c |  12 -
 drivers/pci/controller/pci-hyperv.c      |   1 -
 include/asm-generic/mshyperv.h           |  13 +
 include/hyperv/hvgdk_mini.h              |  58 +--
 include/hyperv/hvhdk.h                   |   9 +
 include/hyperv/hvhdk_mini.h              |   9 +-
 include/uapi/linux/mshv.h                |   2 +
 27 files changed, 1775 insertions(+), 260 deletions(-)
 create mode 100644 drivers/hv/mshv_debugfs.c
 create mode 100644 drivers/hv/mshv_debugfs_counters.c

