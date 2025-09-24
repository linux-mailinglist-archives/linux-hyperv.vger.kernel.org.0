Return-Path: <linux-hyperv+bounces-6981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F7B9C461
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Sep 2025 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C219E1B251E0
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Sep 2025 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE41E0B9C;
	Wed, 24 Sep 2025 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VOnA7Cs0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3967244685;
	Wed, 24 Sep 2025 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749459; cv=none; b=rqP/JHd3ulIpyic2wX9Sl6jx6KjEpKq4JSg+XQuDKaV9fGgXoydOEBWaRxvk6JOQ9xG2nDFbh4JHx6Lq3LbndiYfgbA9gDh0G57oUkAC9CMDtsiJphE1DepBwsY0bWJ3Gi8c6+IVADwAGgooLPcNaN0dc+5lTP6SXy/NA07uWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749459; c=relaxed/simple;
	bh=b1hHQCyMkHFCqBa7xRaNXwh8CoaWZw+jQgEK0A1VP4s=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=p3J/a4jxusKfqd/ICwErl+qb+zAz8POGRhoAHh5Dp9KRFAznM0uv68RpTB9Kpivn4i8Yxc/b637KfirjY08dkQHmMCQ/3Vfg+qVbUkE+pTHfAmvfI4i2ewf3zFfQv1qk/OoQcHo6B67QAAp2/y3qm+aE9+7F3I+VAB6Vm/pSPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VOnA7Cs0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB071211628D;
	Wed, 24 Sep 2025 14:30:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB071211628D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758749457;
	bh=MqM5hbTWYUFaCALE/IFlet1OYGEInC9bY09egyW03Rc=;
	h=Subject:From:To:Cc:Date:From;
	b=VOnA7Cs0w0XxRFxWp/UjQ4TGHfZtGs8DqLCWFggO5Ja7uiQeAwosRMZVd7KqOfg/M
	 9cLcyuumkih/Y9bRbRBbhmjJCvyZDsIJoo7i46kTi/O5F4SVRaTWemlyzmvpMvAJGk
	 /q+BwJtWwKlpbSSoWUeCl1WFZbMKtk+Rd2iEqn+8=
Subject: [PATCH 0/3] Introduce movable pages for Hyper-V guests
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 21:30:56 +0000
Message-ID: 
 <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

---

Stanislav Kinsburskii (3):
      Drivers: hv: Rename a few memory region related functions for clarity
      Drivers: hv: Centralize guest memory region destruction in helper
      Drivers: hv: Add support for movable memory regions


 drivers/hv/Kconfig          |    1 
 drivers/hv/mshv_root.h      |    8 +
 drivers/hv/mshv_root_main.c |  448 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 397 insertions(+), 60 deletions(-)


