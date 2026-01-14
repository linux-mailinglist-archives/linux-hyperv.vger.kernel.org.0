Return-Path: <linux-hyperv+bounces-8298-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795ED21619
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 22:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6BC0304EBF3
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACFE37C0E8;
	Wed, 14 Jan 2026 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kh1GoLPU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4343793BF;
	Wed, 14 Jan 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426720; cv=none; b=C9+YyC8qVwbChrmIvS6OSzyoq6LddbP+ZwBpqMMBcaFvrGIVAJoyk52B5bN9jM19Ou6LsCyrmlyYkrzyqDsTAq00unt8/icLEB5og2NtM/XtsfOhD6mI2r6guw9VamVer4IFc3cntU1F4ZxsBpEZ9QqgcbnhmH3BV+xI1ISJW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426720; c=relaxed/simple;
	bh=Ud9CO7xK3C6FIHXGrUVPSXdkbGzlwdZeUQL/ELqGItY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFSft+7t4VepgAyr2TMqaM/I8WRa7QDDf1kOmZmEF3/g7uky/dvTtERCZEr1TopCpgpXU3KUYnARGOx8D9PRHiAE1S4S0UdNhfbATO+7g5qLPIpb6MPgF3Uc2lIxw1F9byqNZdOCOxwvgVdpwriuMYBalwsU1qfA/BhJxhlRhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kh1GoLPU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 7FCBA20B7165; Wed, 14 Jan 2026 13:38:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FCBA20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768426686;
	bh=3FPKL6RKZS3PAfmJj/ndI52aBJ1Zr63x+RcAackQQO0=;
	h=From:To:Cc:Subject:Date:From;
	b=kh1GoLPU0fsRrcvTx+MFGHYHpnW0h6HWITifRMu82LApikQM2wqMYexVJUaPKNqIC
	 /x2cWYFvPVClknzenMmsVYDavTCbyUjGhER3oL/rCOz3bVbZ/Qd/GG80/20IE7aRf0
	 5mzelCXNuuZg0JZYGSzt4L4Is5SSQrpDDoUmK1SU=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3 0/6] mshv: Debugfs interface for mshv_root
Date: Wed, 14 Jan 2026 13:37:57 -0800
Message-ID: <20260114213803.143486-1-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose hypervisor, logical processor, partition, and virtual processor
statistics via debugfs. These are provided by mapping 'stats' pages via
hypercall.

Patch #1: Update hv_call_map_stats_page() to return success when
          HV_STATS_AREA_PARENT is unavailable, which is the case on some
          hypervisor versions, where it can fall back to HV_STATS_AREA_SELF
Patch #2: Use struct hv_stats_page pointers instead of void *
Patch #3: Make mshv_vp_stats_map/unmap() more flexible to use with debugfs code
Patch #4: Always map vp stats page regardless of scheduler, to reuse in debugfs
Patch #5: Introduce the definitions needed for the various stats pages
Patch #6: Add mshv_debugfs.c, and integrate it with the mshv_root driver to
          expose the partition and VP stats.

---
Changes in v3:
- Add 3 small refactor/cleanup patches (patches 2,3,4) from Stanislav. These
  simplify some of the debugfs code, and fix issues with mapping VP stats on
  L1VH.
- Fix cleanup of parent stats dentries on module removal (via squashing some
  internal patches into patch #6) [Praveen]
- Remove unused goto label [Stanislav, kernel bot]
- Use struct hv_stats_page * instead of void * in mshv_debugfs.c [Stanislav]
- Remove some redundant variables [Stanislav]
- Rename debugfs dentry fields for brevity [Stanislav]
- Use ERR_CAST() for the dentry error pointer returned from
  lp_debugfs_stats_create() [Stanislav]
- Fix leak of pages allocated for lp stats mappings by storing them in an array
  [Michael]
- Add comments to clarify PARENT vs SELF usage and edge cases [Michael]
- Add VpLoadAvg for x86 and print the stat [Michael]
- Add NUM_STATS_AREAS for array sizing in mshv_debugfs.c [Michael]

Changes in v2:
- Remove unnecessary pr_debug_once() in patch 1 [Stanislav Kinsburskii]
- CONFIG_X86 -> CONFIG_X86_64 in patch 2 [Stanislav Kinsburskii]

---
Nuno Das Neves (2):
  mshv: Add definitions for stats pages
  mshv: Add debugfs to view hypervisor statistics

Purna Pavan Chandra Aekkaladevi (1):
  mshv: Ignore second stats page map result failure

Stanislav Kinsburskii (3):
  mshv: Use typed hv_stats_page pointers
  mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
  mshv: Always map child vp stats pages regardless of scheduler type

 drivers/hv/Makefile            |    1 +
 drivers/hv/mshv_debugfs.c      | 1103 ++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h         |   49 +-
 drivers/hv/mshv_root_hv_call.c |   64 +-
 drivers/hv/mshv_root_main.c    |  130 ++--
 include/hyperv/hvhdk.h         |  437 +++++++++++++
 6 files changed, 1721 insertions(+), 63 deletions(-)
 create mode 100644 drivers/hv/mshv_debugfs.c

-- 
2.34.1


