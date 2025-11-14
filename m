Return-Path: <linux-hyperv+bounces-7585-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1BC5CE90
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 12:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2CE3BEB7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5E313E0C;
	Fri, 14 Nov 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l2kZZHrs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DA35CBC3;
	Fri, 14 Nov 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120602; cv=none; b=bGbO9q9VNkDxtaQziSC9Wepjmj+NJJ2TaZtJFLHI/OMx/BLZTdsBxBJ2ZELj6Hed3KGFQZjaOsc5OOCXHYHHd6oMBCEZiZAtiO3ZkDTEQCKsSWAOvN/72cf/SOiaR9VOvjGpghZwnUcau750DIawP7ZQM5oA4aw+ECNZ0GqqJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120602; c=relaxed/simple;
	bh=kaZhosVkcLQ9u1crvdgctTGMxfSng1jWp0o5JU5YM7I=;
	h=From:To:Subject:Date:Message-Id; b=hHC0B3ZqO1w2P0a+sjGldzN1keDnDu90EQ5h7EQ8fusAtOJl9lqeZzEDLKVWs+IQuQSD52zQzjdVNVnadc6gNBFYsBN2Set/yevvLP+84kuzld4o/54OPwMV2fAGg4OAZzPqUOHZmss6zUk6c+CBjKPHZMQ9jYp96rY3JqMZ2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l2kZZHrs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id F2748201AE58; Fri, 14 Nov 2025 03:43:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2748201AE58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763120601;
	bh=IJCs1GggzDg4PCbZwM5u0znB/62duwjasTJIVQPyjY0=;
	h=From:To:Subject:Date:From;
	b=l2kZZHrsm6cjdmfnQ1xX0YPjAXUm8rraUpUiiRTPBvBDf9klTOdo7XxwkSC26KNZd
	 Fk7Hlrm72kauCfoFipuGfnu8Q4hSuc7mPhxMURKq2rhpXy8LJIkQlJGv4Sf+UAa3gb
	 oh68fnrt7XuCEmsnh4hvoDtmjw+xbbVrNru5D+Og=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	sbhatta@marvell.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net: mana: Refactor GF stats handling and add rx_missed_errors counter
Date: Fri, 14 Nov 2025 03:43:17 -0800
Message-Id: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Restructure mana_query_gf_stats() to operate on the per-VF mana_context,
instead of per-port statistics. Introduce mana_ethtool_hc_stats to
isolate hardware counter statistics and update the
"ethtool -S <interface>" output to expose all relevant counters while
preserving backward compatibility.

Add support for the standard rx_missed_errors counter by mapping it to
the hardware's hc_rx_discards_no_wqe metric. Introduce a
global workqueue that refreshes statistics every 2 seconds, ensuring
timely and consistent updates of hardware counters.

---
Changes in v3:
* Use schedule_delayed_work (global workqueue) instead of
  queue_delayed_work (dedicated workqueue for MANA driver).
* Update commit message for more readability.
* Use reverse x-mas tree format in mana_query_gf_stats.
Changes in v2:
* Update commit message.
* Stop rescheduling workqueue only when HWC timeout is observed.
* Introduce new variable in mana_context for detecting HWC timeout.
* Warn once in mana_get_stat64 when HWC timeout is observed.
---
Erni Sri Satya Vennela (2):
  net: mana: Move hardware counter stats from per-port to per-device
    context
  net: mana: Add standard counter rx_missed_errors

 drivers/net/ethernet/microsoft/mana/mana_en.c | 101 ++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    |  85 ++++++++-------
 include/net/mana/gdma.h                       |   6 +-
 include/net/mana/mana.h                       |  18 +++-
 4 files changed, 130 insertions(+), 80 deletions(-)

-- 
2.34.1
For internal review only. 

