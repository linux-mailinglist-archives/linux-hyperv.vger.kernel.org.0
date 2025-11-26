Return-Path: <linux-hyperv+bounces-7825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74515C87C5D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 03:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5603E4E13A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F52305E2F;
	Wed, 26 Nov 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TvMEm39S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6597114A4F0;
	Wed, 26 Nov 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122934; cv=none; b=kOUD44dVAG2IDNH4ExN3huzevp+P+/kktplgIoCar9x8zY509IyYRv3hK902c3cBr1C1bmxZNNuk1+CIdYnyu1nQlvtQWjaRrZIwIUei+DfIg15zLCuCQdRimubOmYoOVH844az6qM1xWvxtJ/WaA08j0FbVvmAgPMrXe0LmvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122934; c=relaxed/simple;
	bh=CwO3mjVbk8nZ9C6HHV8N5pcf3F0IJG8APhjzbaXRwGs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=JvoBMq/XTZz2rNb6DRWOssOJGH+WJM3dYXAN+3VG30HD0KayVNEkAAYETld/odPxqYIdXlFE8Ls3cat/y702WKkRKfGvfncJmQrsj0JoqkLFbkQM2wJUAsExLxs2ccfv3jH+IVkuHi3wWoOykp1qXlHnHVIemxBsqH+vKjbsVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TvMEm39S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 785FE2120E92;
	Tue, 25 Nov 2025 18:08:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 785FE2120E92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764122926;
	bh=0X4Mmff/vXBeiQPcealBbL/aI6SmB9fauocai9L4U6w=;
	h=Subject:From:To:Cc:Date:From;
	b=TvMEm39SbyPMWMsLOI7MEf/bEbf6YfDK5dBToVLZaVu6SCG0m0mOcIqPkHspPobgZ
	 rTX7AVtg39ntfZ08sAcAiX+pHOH92M5FNpUZnnamqfgpRxfYXSTtjHDAYHAqup8qNc
	 OxXQ2f9fQuYNnK4apCN/e9d83K8UXRP8uGB/LoYE=
Subject: [PATCH v7 0/7] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 02:08:46 +0000
Message-ID: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

Stanislav Kinsburskii (7):
      Drivers: hv: Refactor and rename memory region handling functions
      Drivers: hv: Centralize guest memory region destruction
      Drivers: hv: Move region management to mshv_regions.c
      Drivers: hv: Fix huge page handling in memory region traversal
      Drivers: hv: Improve region overlap detection in partition create
      Drivers: hv: Add refcount and locking to mem regions
      Drivers: hv: Add support for movable memory regions


 drivers/hv/Kconfig          |    2 
 drivers/hv/Makefile         |    2 
 drivers/hv/mshv_regions.c   |  548 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h      |   32 ++-
 drivers/hv/mshv_root_main.c |  382 +++++++++++++-----------------
 5 files changed, 745 insertions(+), 221 deletions(-)
 create mode 100644 drivers/hv/mshv_regions.c


