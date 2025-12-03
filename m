Return-Path: <linux-hyperv+bounces-7947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D941CA1B16
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 22:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A73300CA3B
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2F2D7D47;
	Wed,  3 Dec 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YSwlSozD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B02C21D0;
	Wed,  3 Dec 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798036; cv=none; b=ip3Xbj2Jqd3eE5p/Oc48TtdA2FXEucBWPFlqZHsyNY2UX2xSwqE4UYrM5PdWrjVZ9iIDuxKnv5z5+kY4ON4uuN6WlxbEYOYYYBGOP4eR/NgoTwRKyg444YM03QYLW6jaF6DjtWIeutRqmGECqHyaTrcBeAtUpxeNCDQBVio+N60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798036; c=relaxed/simple;
	bh=wLWyPR/DHJ6mj91eIzTE94YFO7JGCzEw2cvblrQQHmg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=qNptsKfm/igbrx/V6IZFdV8JfykIFxelKTA2VXmzMmRUUc3w9G4gS0PSf0aK8tpcTqv8WJzpUkMYBNY7yhY8L/rsLA9GWBkY7SdFbrjcT+aspz1DoI0LiRUDeCjUrSTH93l2iN8InUIowOwilqVTviessxQjMLDkkbZt02TOrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YSwlSozD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1971F200E9F8;
	Wed,  3 Dec 2025 13:40:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1971F200E9F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764798034;
	bh=PZ5jdFFNCSzp8W2eRJ4uer/W7xyftFsEtiLg2ySPw6c=;
	h=Subject:From:To:Cc:Date:From;
	b=YSwlSozDA+E+wLbs8+Q8Y/WCjvnSWXbQRgBficHa5ntEANveg5DpRqix1VygMd75h
	 phfMQnmony40IHekxMNXOQJtaZyc/ixXNNNhaoDbyxZpuaJRqLr/9RkkBttlGCAOOB
	 ekx6No0s9pD7INrRkacadRek5xRRcN5fgV7OMlPY=
Subject: [PATCH v9 0/6] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 21:40:33 +0000
Message-ID: 
 <176479772384.304819.9168337792948347657.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From the start, the root-partition driver allocates, pins, and maps all
guest memory into the hypervisor at guest creation. This is simple: Linux
cannot move the pages, so the guest’s view in Linux and in Microsoft
Hypervisor never diverges.

However, this approach has major drawbacks:
 - NUMA: affinity can’t be changed at runtime, so you can’t migrate guest memory closer to the CPUs running it → performance hit.
 - Memory management: unused guest memory can’t be swapped out, compacted, or merged.
 - Provisioning time: upfront allocation/pinning slows guest create/destroy.
 - Overcommit: no memory overcommit on hosts with pinned-guest memory.

This series adds movable memory pages for Hyper-V child partitions. Guest
pages are no longer allocated upfront; they’re allocated and mapped into
the hypervisor on demand (i.e., when the guest touches a GFN that isn’t yet
backed by a host PFN).
When a page is moved, Linux no longer holds it and it is unmapped from the hypervisor.
As a result, Hyper-V guests behave like regular Linux processes, enabling standard Linux memory features to apply to guests.

Exceptions (still pinned):
 1. Encrypted guests (explicit).
 2. Guests with passthrough devices (implicitly pinned by the VFIO framework).

v9:
 - Fix check to huge page order in the region traversal logic.
 - Fix check for page is huge in region traversal callbacks to support
   hugetlb pages.
 - Removed now unused is_mmio parameter from region creation function.
 - Array allocation change to use the actual variable size instead of
   type size.

v8:
 - Drop the guest regions intersection clean up patch as it's doesn't catch
   a case when a new region completely overlaps an existing region.
 - Fix missing propagation of passed region unmap flags during chunk unmap.

v7:
 - Only the first two patches remain unchanged from v6.
 - Introduced reference counting for memory regions to resolve a race
   condition between region servicing (faulting and invalidation) and region
   destruction.
 - Corrected the assumption that regions starting with a huge page contain
   only huge pages; the code now properly handles regions with mixed page
   size segments.
 - Consolidated region management logic into a dedicated file.
 - Updated the driver to select MMU_NOTIFIER, removing support for
   configurations without this option.
 - Cleaned up and refactored the region management code.
 - Fixed a build issue reported by the kernel test robot for configurations
   where HPAGE_PMD_NR is defined to result in build bug.
 - Replaced VALUE_PMD_ALIGNED with the generic IS_ALIGNED macro.
 - Simplified region flags by introducing a region type for clarity.
 - Improved commit messages.

v6:
 - Fix a bug in large page remapping where setting the large map flag based
   on the PFN offset's large page alignment within the region implicitly
   assumed that the region's start offset was also large page aligned,
   which could cause map hypercall failures.
 - Fix a bug in large page unmapping where setting the large unmap flag for
   an unaligned guest PFN range could result in unmap hypercall failures.

v5:
 - Fix a bug in MMU notifier handling where an uninitialized 'ret' variable
   could cause the warning about failed page invalidation to be skipped.
 - Improve comment grammar regarding skipping the unmapping of non-mapped pages.

v4:
 - Fix a bug in batch unmapping can skip mapped pages when selecting a new
   batch due to wrong offset calculation.
 - Fix an error message in case of failed memory region pinning.

v3:
 - Region is invalidated even if the mm has no users.
 - Page remapping logic is updated to support 2M-unaligned remappings for
   regions that are PMD-aligned, which can occur during both faults and
   invalidations.

v2:
 - Split unmap batching into a separate patch.
 - Fixed commit messages from v1 review.
 - Renamed a few functions for clarity.

---

Stanislav Kinsburskii (6):
      Drivers: hv: Refactor and rename memory region handling functions
      Drivers: hv: Centralize guest memory region destruction
      Drivers: hv: Move region management to mshv_regions.c
      Drivers: hv: Fix huge page handling in memory region traversal
      Drivers: hv: Add refcount and locking to mem regions
      Drivers: hv: Add support for movable memory regions


 drivers/hv/Kconfig          |    2 
 drivers/hv/Makefile         |    2 
 drivers/hv/mshv_regions.c   |  555 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h      |   31 ++
 drivers/hv/mshv_root_main.c |  375 +++++++++++++----------------
 5 files changed, 748 insertions(+), 217 deletions(-)
 create mode 100644 drivers/hv/mshv_regions.c


