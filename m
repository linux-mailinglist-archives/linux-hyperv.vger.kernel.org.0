Return-Path: <linux-hyperv+bounces-1328-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A368124BA
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Dec 2023 02:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681B928178B
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Dec 2023 01:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A88656;
	Thu, 14 Dec 2023 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="n7TkciNW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13B77D5;
	Wed, 13 Dec 2023 17:51:51 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 90B5920B74C0; Wed, 13 Dec 2023 17:51:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90B5920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1702518710;
	bh=sJRm8CuoV+klJB/nMf1AahuNujNBwErNguiFQXCE6Bk=;
	h=From:To:Cc:Subject:Date:From;
	b=n7TkciNWX6eoTwHaf9TGTd8gnrfuK7Sj1EEM0tJZiJjY+cfvQoi7EMwr7Cibn6NX7
	 ZS5/GgrqeHhzC3IWGI4WHtfP4FHZp115kKdrI/P2A8BThIs2SH4JF2W9/f2cM3bVPW
	 eTGBqn6d8hPX7vUPsCd9MOfaGyXcLhOcf925kbQU=
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
Subject: [Patch v2 0/3] Register with RDMA SOC interface and support for CQ
Date: Wed, 13 Dec 2023 17:51:41 -0800
Message-Id: <1702518704-15886-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

This patchset add support for registering a RDMA device with SoC for
support of querying device capabilities, upcoming RC queue pairs and
CQ interrupts.

This patchset is partially based on Ajay Sharma's work:
https://lore.kernel.org/netdev/1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com

Changes in v2:
Dropped the patches to create EQs for RC QP. They will be implemented with
RC patches.


Long Li (3):
  RDMA/mana_ib: register RDMA device with GDMA
  RDMA/mana_ib: query device capabilities
  RDMA/mana_ib: Add CQ interrupt support for RAW QP

 drivers/infiniband/hw/mana/cq.c               | 34 ++++++-
 drivers/infiniband/hw/mana/device.c           | 31 +++++--
 drivers/infiniband/hw/mana/main.c             | 69 ++++++++++----
 drivers/infiniband/hw/mana/mana_ib.h          | 53 +++++++++++
 drivers/infiniband/hw/mana/qp.c               | 90 ++++++++++++++++---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++
 include/net/mana/gdma.h                       |  5 ++
 7 files changed, 252 insertions(+), 35 deletions(-)

-- 
2.25.1


