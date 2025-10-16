Return-Path: <linux-hyperv+bounces-7222-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE209BE119E
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 02:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D43E28B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 00:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F4126C05;
	Thu, 16 Oct 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R4Lvc2Yr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BA1114;
	Thu, 16 Oct 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574411; cv=none; b=KKPjS4uiIgr7psDF060ONqsH3Pf4tLEKtd92HkAke5CKs5ELE0I3VSyRraa5jKOyXtofQITWHPOi6dTbNX562nMC+bJ127x0wEoaWoklP75OwObWiZVt3n0mGedwpIi77SgoegmKyvXINPPPMARC/nGTvDJlK7hTOKpvuEsRS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574411; c=relaxed/simple;
	bh=4V8avRwlwLJiSB+fJIrVl9Yj5bJDeiCEtQgchHHrH58=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=RV64NjlaCGIGKR6Z00p7bRGaszeHRh+Tr3FxNYKJCkHztT4fSa12+dobeshr1RVIT3Z1CReu7t4AD5p/x9NgEH68wgCi1QXKvuleKVY08BMu9ruMKvcEzOL9340i5sPNySyj4Hf/0JD+vzxArM1utyFL2JCacCqvKModScDruuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R4Lvc2Yr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id DFD5421244D5;
	Wed, 15 Oct 2025 17:26:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFD5421244D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760574408;
	bh=nzrPLreH69hMKpah0sqAVPRj1qFALXIV7zsFZ13rJ0E=;
	h=Subject:From:To:Cc:Date:From;
	b=R4Lvc2YrDlJC7z25nVjPK3BOFKd7JtWEp13AC/E6hLM4KIJMgGky1eNF0k9bZlz2X
	 nLRjHkHQQUYH20ygwxzUOv6zHN0iwpmC+VanoaGx7sdlMNV3KhRv0gxWdNfb1ommF4
	 soxKsyOjcWHeLVEbWsqgyx2E4X6m3+3MvzcVLfCM=
Subject: [PATCH v5 0/5] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 00:26:48 +0000
Message-ID: 
 <176057396465.74314.10055784909009416453.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
 drivers/hv/mshv_root_main.c    |  495 +++++++++++++++++++++++++++++++++-------
 4 files changed, 424 insertions(+), 84 deletions(-)


