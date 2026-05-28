Return-Path: <linux-hyperv+bounces-11264-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JxcFRCQF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11264-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:45:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DBC5EB5C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1773430086FC
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC98199EAD;
	Thu, 28 May 2026 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N2vAOfpA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451171922F5;
	Thu, 28 May 2026 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928940; cv=none; b=e6qq7M/pJsWLX93NvCUz+1h9OkCxGtIf6dqtVSQ8NgO6XJMmhQE8UxecAlDF2CWtz8MCXRYa4ZPTpY6hA8B9e7OtQ4It5CFFJsHznsNDPJmo6duTZrvGK3EuLMYHuQPgWCgSGbZeS37kgfgenT2AsBFgk0xfJgk/BEVpAALGXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928940; c=relaxed/simple;
	bh=+aNfqG5j2z/20NXpUWO2D0GxWuffbMmVFRNTztCzp1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryqAjaj45Es8moxMULu2oxHD9nAKOALXxR0PDIQ2dKJ45RORNLXQXkAOCxiE3w9InZkCBCo2NVPYhKrJqtnMCgg9zrLQCORrXyDbmkkSoTTC4QClAjHz83mWHC/spaQNeMv487WM3YQA/d4m/zsyuQBz8Dazkg3IJx1sjY+NAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N2vAOfpA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 3F42520B7167; Wed, 27 May 2026 17:42:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F42520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928928;
	bh=MlAphM6lIy04CUio1znmzudM4J3s/1bUFzd6ZYAVWN0=;
	h=From:To:Cc:Subject:Date:From;
	b=N2vAOfpASzX1EDjGy6YAAwkPynJ5GW9q35MDxfssI1LB5uZxHV5aX1fQgJFCn0lWS
	 FWP9njR85BuseWjwEiHUzAbNOhvtyBpu0fBVx/Pp2EtF+fHeg23fnp6RWXL6icFZ37
	 geNEFabO21Jp613vSD92tPBkmeBr1lm1Vy/xYD/U=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages and partitions
Date: Wed, 27 May 2026 17:41:42 -0700
Message-ID: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11264-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A3DBC5EB5C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When Linux runs as an L1 Virtual Host (L1VH) under Hyper-V, the MSHV
root partition driver deposits pages to the hypervisor and creates
partitions for guest VMs. Prior patches enabled kexec for L1VH, but
only when no partitions had been created and no memory had been donated.

This series lifts that limitation. It uses KHO (Kexec Handover) to:

 - Track all pages deposited to the hypervisor in a KHO radix tree
   and preserve them across kexec so the new kernel knows which pages
   are owned by the hypervisor.

 - Freeze running partitions before kexec, record their IDs in the
   KHO FDT, and vacuum (tear down + reclaim memory) stale partitions
   after kexec.

 - In case of a crash, exclude hypervisor-owned pages from crash
   dump collection by passing the radix tree root PA via Hyper-V
   crash MSR P2 to the crash kernel.

Dependency on Pratyush's KHO series
===================================

Patches 1-12 are cherry-picked from Pratyush Yadav's v1 series
"kho: make boot time huge page allocation work nicely with KHO" [1],
which is still under discussion. This series uses functionality from
those patches -- specifically the meta-data page enumeration via table
callbacks and the restructured radix tree API. It also extends the
KHO radix tree with:

 - A freeze mechanism to lock the tree before serializing for kexec
   (patch 13).

 - A crash-kernel-safe variant that memremaps radix nodes for use
   outside the direct map (patch 14).

Patch overview
==============

Patches 1-12:  KHO radix tree and memblock changes (from [1])
Patch 13:      Radix tree freeze and del_key() error reporting
Patch 14:      Crash-kernel-safe radix tree presence check
Patch 15:      Page tracker using KHO radix tree for deposited pages
Patch 16:      Debugfs interface for page tracker
Patches 17-18: Crash MSR reshuffling + crash dump page exclusion
Patch 19:      Export kexec_in_progress for modules
Patch 20:      Freeze and vacuum partitions across kexec

Feedback
========

This is an RFC. I am looking for feedback on the overall approach as
well as the KHO changes (patches 13-14).

[1] https://lore.kernel.org/linux-mm/20260429133928.850721-1-pratyush@kernel.org/

Based-on: linux-next/master (next-20260527)

Jork Loeser (8):
  kho: add radix tree freeze and del_key() error reporting
  kho: Add crash-kernel-safe radix tree presence check
  mshv: Use page tracker to manage MSHV-owned pages and preserve with
    KHO
  mshv: Add debugfs interface to page tracker
  hyperv: Reserve crash MSR P2 for page preservation root PA
  mshv: Exclude Hyper-V donated pages from crash dump collection
  kexec: export kexec_in_progress for modules
  mshv: freeze and vacuum partitions across kexec

Pratyush Yadav (Google) (12):
  kho: generalize radix tree APIs
  kho: store incoming radix tree in kho_in
  kho: add a struct for radix callbacks
  kho: add callback for table pages
  kho: add data argument to radix walk callback
  kho: allow early-boot usage of the KHO radix tree
  kho: allow destroying KHO radix tree
  kho: add kho_radix_init_tree()
  memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
  kho: extended scratch
  kho: return virtual address of mem_map
  mm/hugetlb: make bootmem allocation work with KHO

 arch/arm64/hyperv/hv_core.c        |   6 +-
 arch/x86/hyperv/hv_init.c          |   4 +-
 drivers/hv/Kconfig                 |   3 +
 drivers/hv/Makefile                |   2 +-
 drivers/hv/hv_common.c             |   5 +-
 drivers/hv/hv_proc.c               |  32 +-
 drivers/hv/mshv_debugfs.c          |  99 +++++
 drivers/hv/mshv_page_preserve.c    | 557 ++++++++++++++++++++++++++
 drivers/hv/mshv_page_preserve.h    |  21 +
 drivers/hv/mshv_root.h             |   5 +
 drivers/hv/mshv_root_hv_call.c     |  12 +-
 drivers/hv/mshv_root_main.c        | 341 ++++++++++++++--
 include/linux/kexec_handover.h     |   1 +
 include/linux/kho_radix_tree.h     |  90 ++++-
 include/linux/memblock.h           |  14 +
 kernel/kexec_core.c                |   1 +
 kernel/liveupdate/kexec_handover.c | 605 +++++++++++++++++++++++------
 mm/hugetlb.c                       |  19 +-
 mm/memblock.c                      | 177 +++++++--
 mm/mm_init.c                       |   1 +
 20 files changed, 1767 insertions(+), 228 deletions(-)
 create mode 100644 drivers/hv/mshv_page_preserve.c
 create mode 100644 drivers/hv/mshv_page_preserve.h

--
2.43.0


