Return-Path: <linux-hyperv+bounces-7923-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B0CCA1287
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CEDC30A5EAF
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD93358CF;
	Wed,  3 Dec 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qKSZO8LW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78D335575;
	Wed,  3 Dec 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784414; cv=none; b=Lu/aAYK5Vvd/YZMCoRLfID85rffnjZIS/AjrgLUexeB2pvxNIAgfmv1eLhNfUuoE5+pX7jyis3mXaq6dYytx2qd3FB6vsCo5kFXWyvXVZWfdktwcLybhwdiCg0foIybeblWbq1C99mt6db0H8LP73ZpjK42OmPksNfpyzNgMx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784414; c=relaxed/simple;
	bh=EEUt8hV0MqKo0+xC0ccrEWb/jgRH3CY/surQqIGgw/c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MvEYZfEnqeUeCcm1q+sPYJMzNS64q1EPq8Tn099ulCcqZ1rKjdS4+H4hEq6aURruJEqoHMVR2DxOIj5udZzFQ+Kac1JvjS4Mpj+pFywLdRp2JFuanha4GaPLWv8EjfioYGvqfN84ykprIF2ih9Gs+1QOX41wNc5N4c5Ge72NorQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qKSZO8LW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 5A0562120E85; Wed,  3 Dec 2025 09:53:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A0562120E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764784411;
	bh=6vFuxUfv5OdSp0L2eJPpK0G9ZP/8iytDcEC2XYdfk+E=;
	h=From:To:Cc:Subject:Date:From;
	b=qKSZO8LWzy2yC8MPLVjDq3bTIzBsWoU68Vd9dnXOuitISHtoA0rEiKA2ALmqHHzf1
	 p3xoFkYAIqKAlV5r8wH4FNhJONk09UGzJpfHG3dNAcy4iptN5v3afJW4NanCxFk1GD
	 aVIPlBOqSb0lbrDNwkZrxJijeZimhW5ylPY8wXL4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 0/3] mshv: Debugfs interface for mshv_root
Date: Wed,  3 Dec 2025 09:53:22 -0800
Message-Id: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
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

Nuno Das Neves (2):
  mshv: Add definitions for stats pages
  mshv: Add debugfs to view hypervisor statistics

Purna Pavan Chandra Aekkaladevi (1):
  mshv: Ignore second stats page map result failure

 drivers/hv/Makefile            |    1 +
 drivers/hv/mshv_debugfs.c      | 1122 ++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h         |   34 +
 drivers/hv/mshv_root_hv_call.c |   43 +-
 drivers/hv/mshv_root_main.c    |   52 +-
 include/hyperv/hvhdk.h         |  437 +++++++++++++
 6 files changed, 1664 insertions(+), 25 deletions(-)
 create mode 100644 drivers/hv/mshv_debugfs.c

-- 
2.34.1


