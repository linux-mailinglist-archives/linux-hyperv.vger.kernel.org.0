Return-Path: <linux-hyperv+bounces-7677-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3AC690F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 12:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 149FE2A9FE
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2D3431F5;
	Tue, 18 Nov 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KLVBT0cg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C62F2916;
	Tue, 18 Nov 2025 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465182; cv=none; b=Bx7cju2b/s9AhDk5kkHw6zVT1nA4XzAt4KYgFToeZuktAXRgSQqfYItgrDIFjrYgyjO5/Dyk3UyszSy6zKZzrg3G0K0NDrLcxTBuP9VhHk/coOGQNqGqBDGGBaxpeO2955bwK6VurbwAMGJhdM7tHldgXruG5C4FiSWwoWYCqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465182; c=relaxed/simple;
	bh=vWzUtoaCKQC/PBwyyP/HCohOqiB4tgpAueqZad2Z744=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OtIegcXYBRis7a0Ce48qk5iqYhRJlT5UN3Tl6Q2/UWfW7nUZ9a3OhttfXHchlGqJ0ttbsol1K7mVtSuuBYqh/JS4qPyFLeMpbKibU7wLqiIls1vByBo9jewiMnlAv3cj41MogSLzORTdx2Jga8j63/85Y4wEnkDTW97fNxgXmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KLVBT0cg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 18712211629A; Tue, 18 Nov 2025 03:26:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18712211629A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763465181;
	bh=7hXr+xGw/7RQ9/pamKWaDgibXH3w/dpnEE4KmiDW7GE=;
	h=From:To:Cc:Subject:Date:From;
	b=KLVBT0cgTRa8zC63mJ1CNEsyosYWIBRGRUxPzl4rQIKQZvOFwT3Sp/vHXp/c/bx/P
	 flC+AzzhVf3sRxe+Lkg5FmWPFMsweL8RrdAUMTkXLdV6mOnsSftPJhqorjuSvLRFR1
	 P0KV3mHsZGFbsmWA4ShogIDqvbXt0R7r1FJlXU0c=
From: Aditya Garg <gargaditya@linux.microsoft.com>
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
	leon@kernel.org,
	mlevitsk@redhat.com,
	yury.norov@gmail.com,
	sbhatta@marvell.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	gargaditya@microsoft.com
Cc: Aditya Garg <gargaditya@linux.microsoft.com>
Subject: [PATCH net-next v6 0/2] net: mana: Enforce TX SGE limit and fix error cleanup
Date: Tue, 18 Nov 2025 03:11:07 -0800
Message-Id: <1763464269-10431-1-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add pre-transmission checks to block SKBs that exceed the hardware's SGE
limit. Force software segmentation for GSO traffic and linearize non-GSO
packets as needed.

Update TX error handling to drop failed SKBs and unmap resources
immediately.

---
Changes in v6:
* Replace #if logic with constant expression in if().

Changes in v5:
* Drop skb_is_gso() check for disabling GSO in mana_features_check().
* Register .ndo_features_check conditionally to avoid unnecessary call.

Changes in v4:
* Fix warning during build reported by kernel test robot
---
Aditya Garg (2):
  net: mana: Handle SKB if TX SGEs exceed hardware limit
  net: mana: Drop TX skb on post_work_request failure and unmap
    resources

 .../net/ethernet/microsoft/mana/gdma_main.c   |  6 +--
 drivers/net/ethernet/microsoft/mana/mana_en.c | 47 ++++++++++++++++---
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
 include/net/mana/gdma.h                       |  8 +++-
 include/net/mana/mana.h                       |  2 +
 5 files changed, 53 insertions(+), 12 deletions(-)

-- 
2.43.0


