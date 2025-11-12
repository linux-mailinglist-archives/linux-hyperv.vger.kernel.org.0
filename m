Return-Path: <linux-hyperv+bounces-7524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86353C52682
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 14:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017691883842
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F43233F5;
	Wed, 12 Nov 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Maqh5WS5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5A303CB0;
	Wed, 12 Nov 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953105; cv=none; b=HD4BnoTsgtxA6uiBogfCh2wkPKWVexIc59TQrtkI6fgjnbcagshPmKFflPrFoBUDwxIaSrZ8xL9/X/+eseuswmKJTB/cVhXGNCJMW3N8aR8uc4u4UzBBBKjrT6737KPU1SWjMqqTiEDZk3+coi5RunCycB+DLzizsBLDPJsFJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953105; c=relaxed/simple;
	bh=MTueTFSs1q0w4UK1tTmhRa5E1vlQyVuAnWOVmfIVvFE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=atv4etEUWrjOYEMaaY29zoda8dhKDhCMSdM+df10ytnRm/DNBlv4255y0am1i4GpdNodZ9Sgu7WKjglr7p0QO4wUSwVp/wJx9YrKVvHw6+05FfqhaB26qFjABTv1Pv1Crs82efbb37uHRMmndQ8yQIqSmxdGDALFfgCb/DxuaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Maqh5WS5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 4BBDA201335C; Wed, 12 Nov 2025 05:11:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BBDA201335C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762953103;
	bh=uNBC9zGBMRpWif3v36lXIKy51zE7c+SCSwlVdhGSwZY=;
	h=From:To:Cc:Subject:Date:From;
	b=Maqh5WS53vm92Wr6UEkCCcf9q5vrtgl/AW5YSZ+X7YUki5vtRE7HWaYl45Hkk49Ul
	 Qmcgqwux5b31TvBYRYM5e5SZDlNA6TsWqSaY2lIBtpawsnHHGp7OdcmNNoLAg5RXkk
	 jC0A/HhvjkX4KxW/ZSQuy5f+17/slPniI1iqc33g=
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
Subject: [PATCH net-next v4 0/2] net: mana: Enforce TX SGE limit and fix error cleanup
Date: Wed, 12 Nov 2025 05:01:44 -0800
Message-Id: <1762952506-23593-1-git-send-email-gargaditya@linux.microsoft.com>
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
Changes in v4:
* Fix warning during build reported by kernel test robot
---
Aditya Garg (2):
  net: mana: Handle SKB if TX SGEs exceed hardware limit
  net: mana: Drop TX skb on post_work_request failure and unmap
    resources

 .../net/ethernet/microsoft/mana/gdma_main.c   |  6 +--
 drivers/net/ethernet/microsoft/mana/mana_en.c | 44 ++++++++++++++++---
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
 include/net/mana/gdma.h                       |  6 ++-
 include/net/mana/mana.h                       |  2 +
 5 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.43.0


