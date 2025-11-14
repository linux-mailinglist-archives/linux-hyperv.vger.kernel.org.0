Return-Path: <linux-hyperv+bounces-7597-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B319C5F563
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 22:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB4A835CE85
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 21:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE9355035;
	Fri, 14 Nov 2025 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UMVHPcOl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8235502C;
	Fri, 14 Nov 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155173; cv=none; b=R1cnCr/8ZHBoaN2MjXQKMKuHlz598yukldwNDnkI9VZveNoBn+FcHOLD6GoUCbaSJ4aPzfb9HhzJsWzFWw/LrtZMi7Xngzzp23tAD8KKz77xmSBxvErpW/yzHnOirYS3hxVOX2KqgAfRb3xM87NFKEtv3gD6wm7+YjjSD3xy1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155173; c=relaxed/simple;
	bh=BUW6cmvwtdbjQboLPPESR1i15jUTbXZvmrtCbZVUNVk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Jh4a9hMtNOEvoy39ofVkjke2miyHFGa5UoMAf8ci6rIOw7dT0mNdVl95Zcf23mnYVO5LU1mX903dKqvUQw9MwLHwawAdUm4hFBPFL9p2krCzf10z5zh34wuifgg41wnhbbg5SfjMpm8NkN2+wG6iuMGJzjgJxTemKetoQCAVEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UMVHPcOl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id E165B201AE64; Fri, 14 Nov 2025 13:19:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E165B201AE64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763155171;
	bh=KG9Wwjz0CIv8Gzt4QY+aoHBszotw4XMzvCmMsigze0E=;
	h=From:To:Cc:Subject:Date:From;
	b=UMVHPcOlM2MZIVGgHkzu2x/K1tgKIwu02BIbfQJKTSScbfBn6636Bw4QAVQKOb7/Q
	 jy001a/LTjGeODPo/aWyaHrcOpSaePFG1d1QK1sDHYrZXyCke6BUtJohqXx1RgZr+h
	 PpECfCj1ukUlVELzb4Wtkks3OPQlGlew6eBWgPHo=
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
Subject: [PATCH net-next v5 0/2] net: mana: Enforce TX SGE limit and fix error cleanup
Date: Fri, 14 Nov 2025 13:16:41 -0800
Message-Id: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
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
 drivers/net/ethernet/microsoft/mana/mana_en.c | 48 ++++++++++++++++---
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
 include/net/mana/gdma.h                       |  8 +++-
 include/net/mana/mana.h                       |  2 +
 5 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.43.0


