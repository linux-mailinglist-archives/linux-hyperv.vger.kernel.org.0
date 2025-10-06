Return-Path: <linux-hyperv+bounces-7106-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CFBBE6E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 17:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D2314E2C47
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C72D63F7;
	Mon,  6 Oct 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MHuxLh+r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C482652A6;
	Mon,  6 Oct 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763171; cv=none; b=DKK+3YYSK54M3bDEUa7sfhO96ngnYvgXjulacOAdGG4OZ4UaB4pHy46qmz+ZPXJjELJ7U6sjXJ+SFdkDwgEEeMVudrf3Z1hmdGXClj8qnJeA1UiMJfBq24m6Ombu7O9y5b1DYZWoDKJDClZabSM/YCyTrHGX9PkVt5Oe0+hOsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763171; c=relaxed/simple;
	bh=SPFBHoPXdWKgOZgmM7vLVhGzo5rEIe9DbYUn7Vtzweg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=MW0a0PyyxZL4PtNyopBJnQfGrKhG7+ldcIj/ketOdofpKDpZmKYF65PbUaGKpvZ26zgF3SjSLxU5O7orDl9gLyKq9MmU4mIK2ekY9/hkVuM52va4Sc7obgT3aYI2WuGWruSKVazUBNzg11gO3Ugr8erGcZH6ryYpSozTYiLfZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MHuxLh+r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8638D2012C1C;
	Mon,  6 Oct 2025 08:06:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8638D2012C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759763166;
	bh=zLEmFCFdXZazQv8KlqAh7/t6gQYCtTaqB1Ht33uqNLE=;
	h=Subject:From:To:Cc:Date:From;
	b=MHuxLh+rWdekkwu6LTNF7RAtseg1JgZ/yFgOb5EGj/yTRDuwP8icy4LLwIWuY1rla
	 2QBBSjHnfN0H98DnxnMKb3Z//NS5zmgO2Hj16E/6GqsNgGPmDwfz8kLR1o3kdbXt2l
	 D631cT3tmaK3JA5VOa3VyRx/jPpZDnPe7PMjejj0=
Subject: [PATCH v4 0/5] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2025 15:06:06 +0000
Message-ID: 
 <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
 drivers/hv/mshv_root_main.c    |  495 +++++++++++++++++++++++++++++++++-------
 4 files changed, 424 insertions(+), 84 deletions(-)


