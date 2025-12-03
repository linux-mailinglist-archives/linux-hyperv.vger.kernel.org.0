Return-Path: <linux-hyperv+bounces-7929-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FCCA13C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A623193D03
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45E305048;
	Wed,  3 Dec 2025 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kJzQbRwF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB6260569;
	Wed,  3 Dec 2025 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786240; cv=none; b=mwi34Bv38dcM5njuIHl9o7+Xj6YEsSIRdjG0m7K0h3l9F3FmrqI+1JgPO2FxBn6Jw3Ks4idIk/BdyG6iWtGp9EGoX3G5FszMVs/bcJvF3dhaeMK93eFV9qkTlKIRIKVO9sGKgIFZOAdkukjE6nFt+HQAlQvoklzhoP6Udl9LErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786240; c=relaxed/simple;
	bh=n3BK+KxWfwmVHU+QdpJCMxJC/nnJnu+XvoohJRvJ0tM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Je8bWBk5w5ErKmSQV+HNp1AJIA60hURshLgbMjJr/XarQZ7Q4fQek2+hHjgXPFXWkB3G/1/fX2nv5cgU/hOwxLLuQ0BbYAkKF34Iej+6GtabAXMSDJz9VVl4GeVEBxaI6DpikVCpmTpbIWmS1Vr3+tUwyG4jJ2EAWG3fmVQmFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kJzQbRwF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B5D1F2120E85;
	Wed,  3 Dec 2025 10:23:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5D1F2120E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764786238;
	bh=RSf/Cj4ls8tmHlX+Gt7PCFxmib+b3DzN3vyqwFdFLbQ=;
	h=Subject:From:To:Cc:Date:From;
	b=kJzQbRwFPhfUq8UbJ8BftvMY0ryGmFaifV15AZNoGF2UWK+8iTIL4+AmMtBSj6TKp
	 0D7H0G6fHDGB+Njo53qRSTjrB0GBNvx3bA8Qvo+gxAo/mqJBM9u0gat+oBf4SQ036k
	 Ax78HgMMocC/hzLmlAPPyNSfNxQM38FzLpvhaCnM=
Subject: [PATCH v8 0/6] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 18:23:58 +0000
Message-ID: 
 <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
 drivers/hv/mshv_regions.c   |  548 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h      |   32 ++-
 drivers/hv/mshv_root_main.c |  376 +++++++++++++-----------------
 5 files changed, 743 insertions(+), 217 deletions(-)
 create mode 100644 drivers/hv/mshv_regions.c


