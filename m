Return-Path: <linux-hyperv+bounces-10-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F7797984
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Sep 2023 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922331C20381
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Sep 2023 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330EB13ACE;
	Thu,  7 Sep 2023 17:16:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58313AC4;
	Thu,  7 Sep 2023 17:16:19 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B90C41FF6;
	Thu,  7 Sep 2023 10:15:56 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
	id A8211212B5B7; Thu,  7 Sep 2023 09:52:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8211212B5B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1694105563;
	bh=TnGfHgFY2Wfj2kjLKNZBPWtx90U/cn7fzLxE5pjtgEg=;
	h=From:To:Cc:Subject:Date:From;
	b=LykX1xyY1FrqxXvWRblMUan79w9CJexO5EW1rLHes1keB3oypqLlC4BGtfVFrfl5w
	 F8kff+mOMAGdTI24vkiPWQoEIm4xWlDXpYo/NzyL94sSG0EZRmjf7v/WjqH6IMFaxW
	 sEVz5W+uY4jJxrOr6JbG4I+QqL4wtkjABuezPBkQ=
From: sharmaajay@linuxonhyperv.com
To: Long Li <longli@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: [Patch v5 0/5] RDMA/mana_ib
Date: Thu,  7 Sep 2023 09:52:34 -0700
Message-Id: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Ajay Sharma <sharmaajay@microsoft.com>

Change from v4:
Send qp fatal error event to the context that
created the qp. Add lookup table for qp.

Ajay Sharma (5):
  RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
  RDMA/mana_ib : Register Mana IB  device with Management SW
  RDMA/mana_ib : Create adapter and Add error eq
  RDMA/mana_ib : Query adapter capabilities
  RDMA/mana_ib : Send event to qp

 drivers/infiniband/hw/mana/cq.c               |  12 +-
 drivers/infiniband/hw/mana/device.c           |  81 +++--
 drivers/infiniband/hw/mana/main.c             | 288 +++++++++++++-----
 drivers/infiniband/hw/mana/mana_ib.h          | 102 ++++++-
 drivers/infiniband/hw/mana/mr.c               |  42 ++-
 drivers/infiniband/hw/mana/qp.c               |  86 +++---
 drivers/infiniband/hw/mana/wq.c               |  21 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  16 +-
 10 files changed, 545 insertions(+), 258 deletions(-)

-- 
2.25.1


