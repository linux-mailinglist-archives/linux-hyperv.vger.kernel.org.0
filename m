Return-Path: <linux-hyperv+bounces-7623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD3C65441
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95E3B4EF132
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4273009F2;
	Mon, 17 Nov 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C7RFJy4r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372D82F5337;
	Mon, 17 Nov 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398355; cv=none; b=EBObBgZmj6zb4G1wsFd+ySfWMZkGT5wCwRFSEF7/lW2IY/X0021pYgbDVZKnweeUrQnKIUyQkbkHcCIJaRPcNvvCYCZwEVoM96F4/zqxTQdWZRkTONW0bcylWCD/4SwpbmWXFhAoQE4wuYzWK4DpSxoEORRzesqWExdp1L50lS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398355; c=relaxed/simple;
	bh=u/TWw9jTb4okzB/xfvG98wgF58bBPignSIKLCV7RQWs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=q1Cz88+IVWoF9oHucovo9zABGwO3oXlk/CVsJ74uxf9S1MglycFFt61nmwwQH1bigN6g9Vl6KPa+eARS9pi8zlBTFC037YruRp/7MspdW1NQEoQFDQFFuOV5m8H9KrNfyzfafwWywroXi4GGDZFmMkYOxGhqVGXqlbEh4jAwuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C7RFJy4r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 29E26206C17D;
	Mon, 17 Nov 2025 08:52:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29E26206C17D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763398352;
	bh=sYXWF03wN4JRuFtjCB/9t+MairaKt7H//keIxZ8MwAs=;
	h=Subject:From:To:Cc:Date:From;
	b=C7RFJy4rabGJYDzcdcm+NxOKLBWlgIkBHIx016jdA7wgk1Hbk7SLyFaeKyF/eXhTP
	 Uz+pSUB5Ub0f8F/e9DrXPP481y3rTB9+SrKGfKbcT2qT7FztALOUmySJwvxm2itUDm
	 3Z56ZgxC9EPPRrcUXwl/s+j2dquY1xIjMNc64FXA=
Subject: [PATCH v6 0/5] Series short description
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Nov 2025 16:52:32 +0000
Message-ID: 
 <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

Stanislav Kinsburskii (5):
      Drivers: hv: Refactor and rename memory region handling functions
      Drivers: hv: Centralize guest memory region destruction
      Drivers: hv: Batch GPA unmap operations to improve large region performance
      Drivers: hv: Ensure large page GPA mapping is PMD-aligned
      Drivers: hv: Add support for movable memory regions


 drivers/hv/Kconfig             |    1 
 drivers/hv/mshv_root.h         |   10 +
 drivers/hv/mshv_root_hv_call.c |    2 
 drivers/hv/mshv_root_main.c    |  497 +++++++++++++++++++++++++++++++++-------
 4 files changed, 426 insertions(+), 84 deletions(-)


