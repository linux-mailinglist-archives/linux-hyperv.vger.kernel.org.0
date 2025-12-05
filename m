Return-Path: <linux-hyperv+bounces-7969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7ACA90DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 20:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62C8F3089713
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208C34AAF9;
	Fri,  5 Dec 2025 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aFCtNPyC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489D349B1B;
	Fri,  5 Dec 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961474; cv=none; b=Y7VS+XNRGNE6gWVmQnAgHU9bWrVlAefRSWrqRb6+O/C1tDuTqVAvYNej/okN22KAg8qEM7Yq6IZKK3fb9dslnMEgpt0zdNUJN4DsmQ8iL+QjQPHwHSxImmWXn1Ix6Fl4hUEJQG3amMikURb8BRhCkSszGnAH4MJi2ILek33RWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961474; c=relaxed/simple;
	bh=K1YF31dc9rInSXyHBTHgsS6RnTHds9s1rqCwvWE8Fuo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OAkJVUGo4uzX5VUMvHikwhRRDil5+T6FEKEROu4nymLLJ/tZyjTp9krAbZmx2a/ITlWL0Z1I3RACWOw6uS/wgMM75Beb2hKfkkoQfVKvz4gYaNW8pXsyELDF/yGLz9fODt1zmZyVW85/Swm4zkGpcr62jSk14VMA65PxAEzVEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aFCtNPyC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 82B9F2120EB6; Fri,  5 Dec 2025 10:58:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82B9F2120EB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764961123;
	bh=lv290XAnEJyHGyAB6nkOt0kXdnl3odgJZGIpSlP8tkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aFCtNPyCFqKp8HCGvyP6ONTxzljLLSV8kw5nD1OU2EXYIjHhjq+qArxKW96117Jsi
	 0UhEONwy9nYKOX3SqBPZn3skIK7gXGPTYI1xBUirA1rxS9oxOmpSIpQ/HC9UD295Wd
	 hesWvagUW84YXc/ONyoyEWLXbeCOOp5TRFWTeFs8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 0/3] mshv: Debugfs interface for mshv_root
Date: Fri,  5 Dec 2025 10:58:39 -0800
Message-Id: <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Expose hypervisor, logical processor, partition, and virtual processor
statistics via debugfs. These are provided by mapping 'stats' pages via
hypercall.

Patch #1: Update hv_call_map_stats_page() to return success when
          HV_STATS_AREA_PARENT is unavailable, which is the case on some
          hypervisor versions, where it can fall back to HV_STATS_AREA_SELF
Patch #2: Introduce the definitions needed for the various stats pages
Patch #3: Add mshv_debugfs.c, and integrate it with the mshv_root driver to
          expose the partition and VP stats.

---
Changes in v2:
- Remove unnecessary pr_debug_once() in patch 1 [Stanislav Kinsburskii]
- CONFIG_X86 -> CONFIG_X86_64 in patch 2 [Stanislav Kinsburskii]

---
Nuno Das Neves (2):
  mshv: Add definitions for stats pages
  mshv: Add debugfs to view hypervisor statistics

Purna Pavan Chandra Aekkaladevi (1):
  mshv: Ignore second stats page map result failure

 drivers/hv/Makefile            |    1 +
 drivers/hv/mshv_debugfs.c      | 1122 ++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h         |   34 +
 drivers/hv/mshv_root_hv_call.c |   41 +-
 drivers/hv/mshv_root_main.c    |   52 +-
 include/hyperv/hvhdk.h         |  437 +++++++++++++
 6 files changed, 1662 insertions(+), 25 deletions(-)
 create mode 100644 drivers/hv/mshv_debugfs.c

-- 
2.34.1


