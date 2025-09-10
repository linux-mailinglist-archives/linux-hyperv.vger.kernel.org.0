Return-Path: <linux-hyperv+bounces-6816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E806B52490
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 01:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387F4A0609D
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Sep 2025 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6286D30E855;
	Wed, 10 Sep 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oNP94Mk8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23FB376F1;
	Wed, 10 Sep 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546094; cv=none; b=anG9PuoBznqN7KOEjSPYD5yVOpW9bkMwnyxuoXcL1ubymEBtiKQtRE2QAf89+mgKHbwQipFGUGB0lHVaPO3lFO64fxML+myz042RVf5QO9JmfckPikBD0ivk4LnB12vrok3ELsVzN6LgFe3l28BxZw9WnUaWhbclPLw83Qhamlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546094; c=relaxed/simple;
	bh=jZbXrZC3UbUO6jclQ2JrQ1SzPCzOebwHEuTlvkX8hPg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XQhnMT8zEsSKlDtYU0XF9B5MjL/bJoJR/8SkSKzFXGl8COFUSFGPZuZMTVRyfeGbfzAzwOaXw5IAUkTRKWYjE7d0unapcCDs9Ckxv8ha35HsZsId7G2acEZ1NM59sd/axhD9bV4jXTTgMyGRn5b4RHMBYXoLOJOMDfm8wJnTOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oNP94Mk8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 5F7EF20171D8; Wed, 10 Sep 2025 16:14:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F7EF20171D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757546092;
	bh=RezlUGLpV/pLWwqJBjb0XFIE+DajNPDCE311xjKkwfc=;
	h=From:To:Cc:Subject:Date:From;
	b=oNP94Mk8ayVDPe5tr4l4rSYgmWuvJukr2ZFcENNvBE0eu6dGQkYHdSek9AGjTT9Ac
	 iRttN2dBezakOiuAZWrSjosNr8f6HTWe0fF3mTscDh05aoaEQoDnCR+6J48KACXRyv
	 mjxl75v3ZwwSaHNY5JUDblUGgKVupyKvuuD9KrWE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 0/5] mshv: Fixes for stats and vp state page mappings
Date: Wed, 10 Sep 2025 16:14:44 -0700
Message-Id: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

There are some differences in how L1VH partitions must map stats and vp
state pages, some of which are due to differences across hypervisor
versions. Detect and handle these cases.

Patch 1:
Fix for the logic of when to map the vp stats page for the root scheduler.

Patch 2-3:
Add HVCALL_GET_PARTITION_PROPERTY_EX and use it to query "vmm capabilities" on
module init.

Patches 4-5:
Check a feature bit in vmm capabilities, to take a new code path for mapping
stats and vp state pages. In this case, the stats and vp state pages must be
allocated by Linux, and a new hypercall HVCALL_MAP_VP_STATS_PAGE2 must be used
to map the stats page.

---
v2:
- Removed patch falling back to SELF page if PARENT mapping fails [Easwar]
  (To be included in a future series)
- Fix formatting of function definitions [Easwar]
- Fix some wording in commit messages [Praveen]
- Proceed with driver init even if getting vmm capabilities fails [Anirudh]

v1:
https://lore.kernel.org/linux-hyperv/1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t

---
Jinank Jain (2):
  mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
  mshv: Introduce new hypercall to map stats page for L1VH partitions

Nuno Das Neves (1):
  mshv: Only map vp->vp_stats_pages if on root scheduler

Purna Pavan Chandra Aekkaladevi (2):
  mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
  mshv: Get the vmm capabilities offered by the hypervisor

 drivers/hv/mshv_root.h         |  24 +++--
 drivers/hv/mshv_root_hv_call.c | 181 +++++++++++++++++++++++++++++++--
 drivers/hv/mshv_root_main.c    | 131 ++++++++++++++----------
 include/hyperv/hvgdk_mini.h    |   2 +
 include/hyperv/hvhdk.h         |  40 ++++++++
 include/hyperv/hvhdk_mini.h    |  33 ++++++
 6 files changed, 339 insertions(+), 72 deletions(-)

-- 
2.34.1


