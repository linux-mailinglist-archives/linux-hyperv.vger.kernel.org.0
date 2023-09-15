Return-Path: <linux-hyperv+bounces-100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05F7A2594
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 20:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69791C2093E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9F18B1C;
	Fri, 15 Sep 2023 18:24:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF1171C3;
	Fri, 15 Sep 2023 18:24:37 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D28F1FD7;
	Fri, 15 Sep 2023 11:24:36 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
	id 7A8BC212BE76; Fri, 15 Sep 2023 11:24:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A8BC212BE76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1694802275;
	bh=B/5omYi3NMx7LhZ02tzamkjg2YG+tTuPu1ZrPCF6Ks4=;
	h=From:To:Cc:Subject:Date:From;
	b=gCcS07miBSR7haO7qHEEdgKzu2BtS7fOefTXK5BX6HcIhbEdN9pgNqxMMllTdoPyN
	 zfBRpOrDqnqBD1yQVH83JUsZa+1fp0jgkDk8Su/pBeeKL6EXSZtgAUdznq52tT2cTW
	 KUojN81/rHw4C3SvXFXqcbOQqW9vicbIE3s+HK04=
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
Subject: [Patch v6 0/5] RDMA/mana_ib
Date: Fri, 15 Sep 2023 11:24:25 -0700
Message-Id: <1694802270-17452-1-git-send-email-sharmaajay@linuxonhyperv.com>
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

Change from v5:
Use xarray for qp lookup.

Ajay Sharma (5):
  RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
  RDMA/mana_ib : Register Mana IB  device with Management SW
  RDMA/mana_ib : Create adapter and Add error eq
  RDMA/mana_ib : Query adapter capabilities
  RDMA/mana_ib : Send event to qp

 drivers/infiniband/hw/mana/cq.c               |  12 +-
 drivers/infiniband/hw/mana/device.c           |  78 +++--
 drivers/infiniband/hw/mana/main.c             | 290 +++++++++++++-----
 drivers/infiniband/hw/mana/mana_ib.h          | 102 +++++-
 drivers/infiniband/hw/mana/mr.c               |  42 ++-
 drivers/infiniband/hw/mana/qp.c               |  86 +++---
 drivers/infiniband/hw/mana/wq.c               |  21 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  16 +-
 10 files changed, 543 insertions(+), 259 deletions(-)

-- 
2.25.1


