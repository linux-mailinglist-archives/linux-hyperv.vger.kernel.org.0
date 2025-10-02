Return-Path: <linux-hyperv+bounces-7053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E0BB48DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1288116D875
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2325A651;
	Thu,  2 Oct 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S+GJ+3Qw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982FF2417C5;
	Thu,  2 Oct 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422947; cv=none; b=a0Q4ebWaJeyzc/MPTrmseMmf6YfoUgNF7ItaFsUdV1695nVkw9E3Zr43LAUEkffjRXU+tUbXd3+ceOgK2lrTeqd8/BBLiRqlouIxI5OZJUJcrI/SJ6WFOtsSleD13OHZwPaPZj+2Nx0hb75Syily/rdScEj8yxWEpKXkKxLsD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422947; c=relaxed/simple;
	bh=F8pWJ4VGA5Qa7BcxilBKImoBnSrW79tM0rR0YaivYEQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=kod7ZfnkVxccQEeHDJEEo/9wyefPTe0btlW3V+OOlJy9Gx3XR9K8DI3aH3iiAqe4wb8gaSzE17QbpQSj8S0idY4FrsNlEsNDKZsWrGvj6UmhE2yuE6nn15C0RB+HeLent05WgM8gDCf5Urms3ZWNNCx4znhPXhOXLX9HEeQUz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S+GJ+3Qw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 92CF22118E36;
	Thu,  2 Oct 2025 09:35:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92CF22118E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759422944;
	bh=SMm6NBBrFPCON/EovRRCrR9M6e9ZB97tAbF35WmmeK0=;
	h=Subject:From:To:Cc:Date:From;
	b=S+GJ+3Qwt1fINdkPbPelwBmVnWbQYo1WL+fXBSOQN7nYYRuyHbZZ5dOF1Y8ui/Mtt
	 3m/eU8U49Wg9sXYAva7Lwo8dwG3iVfg4CoGzxIWav0wNB40ornHlDR4znjFhnHthUw
	 pLL27dwEoaZNb+rmk3aRocadgLpYB9ALwtk8fUfY=
Subject: [PATCH v3 0/5] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Oct 2025 16:35:44 +0000
Message-ID: 
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
 drivers/hv/mshv_root_main.c    |  480 +++++++++++++++++++++++++++++++++-------
 4 files changed, 410 insertions(+), 83 deletions(-)


