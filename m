Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE6784611
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHVPrs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjHVPrr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 11:47:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32BEBCDF;
        Tue, 22 Aug 2023 08:47:46 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
        id 7F6E22126CC2; Tue, 22 Aug 2023 08:47:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F6E22126CC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1692719265;
        bh=HVGBPOnzeTlh8V57DK7yO/EoCj0a9cS67LN7UjxUnq0=;
        h=From:To:Cc:Subject:Date:From;
        b=XRyLgiNLWUjgs7IQZBoYir0iiyhMOHKFX444y3j82Bqsm3H175ySMUAt3hb1pFGIe
         CaH/3rL2WOii3wuiGttyL0cWqtbvGQQaKUaNwQuMeEyzoy0zInScw0QVcVfuvsESS2
         DpIE0si7LYBeL8f+qXUN4Wez1Nn2dzBU6y5m8C6k=
From:   sharmaajay@linuxonhyperv.com
To:     Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: [Patch v4 0/4] RDMA/mana_ib
Date:   Tue, 22 Aug 2023 08:47:31 -0700
Message-Id: <1692719255-20183-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ajay Sharma <sharmaajay@microsoft.com>

This patch series introduces some cleanup changes and resource control
changes. The mana and mana_ib devices are used at common places so a
consistent naming is introduced. Adapter object container to have a
common point of object release for resources and query the management
software to prevent resource overflow. It also introduces async
channel for management to notify the clients in case of 
errors/info.



Ajay Sharma (4):
  RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
  RDMA/mana_ib : Register Mana IB  device with Management SW
  RDMA/mana_ib : Create adapter and Add error eq
  RDMA/mana_ib : Query adapter capabilities

 drivers/infiniband/hw/mana/cq.c               |  12 +-
 drivers/infiniband/hw/mana/device.c           |  72 +++--
 drivers/infiniband/hw/mana/main.c             | 283 +++++++++++++-----
 drivers/infiniband/hw/mana/mana_ib.h          |  96 +++++-
 drivers/infiniband/hw/mana/mr.c               |  42 ++-
 drivers/infiniband/hw/mana/qp.c               |  84 +++---
 drivers/infiniband/hw/mana/wq.c               |  21 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 151 ++++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  16 +-
 10 files changed, 525 insertions(+), 255 deletions(-)

-- 
2.25.1

