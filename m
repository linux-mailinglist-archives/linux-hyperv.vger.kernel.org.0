Return-Path: <linux-hyperv+bounces-7008-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D270EBA9ECB
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 18:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925FD3A7A8F
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25A3081DB;
	Mon, 29 Sep 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HmV0fC7f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DF21770C;
	Mon, 29 Sep 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161787; cv=none; b=oeGxB99GV9Ai5PdQyscCleB4pX3p9FeUE7D0Tph/DbWODY91PH5OZ01tG9nOazqMeclDHZrVatI4ZyGy8wfjqODOc5XMnRlgNj7QPcMA3u3D0BVqrh0KJxkZlbizdxIcvz490+C2ZeyCqROt4ik8S5xOy6RNZuZEFwuLPgbYzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161787; c=relaxed/simple;
	bh=hGMUgbw6cjVDwNlv+c+dlngDpeIVFXMqXu9j+hKYp2Y=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=fDJGLc3jA3u3N8gFH8mh7yelcygQ8vcmL/Q3dGsQFvn6KDVBut57LIhP9qQtqYx0mXfP2v7CPzi3mYJoaIIKJsiJYz2KZaFoLnGNfwyylSA+NS2qZKuZGE+FGlGiTLpB0MGgtCs0Kt1gz9iqwn/ScLrIPzO+jsSBZMzd8HqAoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HmV0fC7f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 832722127309;
	Mon, 29 Sep 2025 09:02:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 832722127309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759161779;
	bh=7RUABCU6LZn2ydAZuIC8BqJa+cIkDKkNw73wboYyaSI=;
	h=Subject:From:To:Cc:Date:From;
	b=HmV0fC7fK7XwH8v30Q4a8HGbjIWDYHVxtJFBMcMnjfHs5MqzcDTQLFjYQG9dwKuDk
	 Z3LcaHNqkdfqYi/9fFbTWMxtUJFySS+VhWIumU10i9pbRDYJSst8K5kUx2jmG1YLEh
	 tV71FwqBHNFq7UK5XIRukn0KJ2R2GzvEGbfD1myg=
Subject: [PATCH v2 0/4] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Sep 2025 16:02:59 +0000
Message-ID: 
 <175916156212.55038.16727147489322393965.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
  2 Guests with passthrough devices (implicitly pinned by the VFIO framework).

v2:
- Split unmap batching into a separate patch.
- Fixed commit messages from v1 review.
- Renamed a few functions for clarity.

---

Stanislav Kinsburskii (4):
      Drivers: hv: Refactor and rename memory region handling functions
      Drivers: hv: Centralize guest memory region destruction
      Drivers: hv: Batch GPA unmap operations to improve large region performance
      Drivers: hv: Add support for movable memory regions


 drivers/hv/Kconfig             |    1 
 drivers/hv/mshv_root.h         |   10 +
 drivers/hv/mshv_root_hv_call.c |    2 
 drivers/hv/mshv_root_main.c    |  472 +++++++++++++++++++++++++++++++++-------
 4 files changed, 403 insertions(+), 82 deletions(-)


