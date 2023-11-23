Return-Path: <linux-hyperv+bounces-1032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A0D7F56C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 04:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DAB281417
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F676137;
	Thu, 23 Nov 2023 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="KLkpTxfW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80774D5E;
	Wed, 22 Nov 2023 19:10:19 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id D728020B74C0; Wed, 22 Nov 2023 19:10:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D728020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1700709018;
	bh=sP/kpPj8BkKyVMEDzS+OaFWLgeKMkV1qQHYNF/Vuc7M=;
	h=From:To:Cc:Subject:Date:From;
	b=KLkpTxfWGkaSk8aQ3/pBWPvQFay22P0DsIwccy+/HDwobwVQmW9rMRgLOd68IE3Et
	 ANkXqlUTDR2J9hziRtL7Cu+eCBIiwuvIjFTfnXL94vGArdFw6RT6qiU4GSjKFA8jWG
	 1vAfwrRsL85/sUPOtSCq5KslkzjSud/6eQVX+TjA=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v1 0/4] 
Date: Wed, 22 Nov 2023 19:10:06 -0800
Message-Id: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

This patchset add support for registering a RDMA device handle with SoC
for support of upcoming RC queue pairs and CQ interrupts.

This patchset is partially based on Ajay Sharma's work:
https://lore.kernel.org/netdev/1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com

Long Li (4):
  RDMA/mana_ib: register RDMA device with GDMA
  RDMA/mana_ib: create and process EQ events
  RDMA/mana_ib: create RDMA adapter handle
  RDMA/mana_ib: query device capabilities

 drivers/infiniband/hw/mana/cq.c               |   2 +-
 drivers/infiniband/hw/mana/device.c           |  52 +++++-
 drivers/infiniband/hw/mana/main.c             | 166 ++++++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h          |  85 +++++++++
 drivers/infiniband/hw/mana/qp.c               |  36 +++-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++++++-------
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  19 +-
 8 files changed, 420 insertions(+), 95 deletions(-)

-- 
2.34.1


