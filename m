Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8835A764033
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGZUI2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 16:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGZUI1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 16:08:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB16A2701;
        Wed, 26 Jul 2023 13:08:26 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
        id 4602A2383123; Wed, 26 Jul 2023 13:08:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4602A2383123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1690402106;
        bh=BGDglPPcOLPbs33vvdiQMlsE2V42+tWMX+3izbX4MkE=;
        h=From:To:Cc:Subject:Date:From;
        b=l6eMBgBeQLt5oYEcLfTwlZuV1sgk/sCELW/55h1Q5PuLYHBzHHNDflPY2QUIlVuT5
         BYvvF9sHsQL0xenbwyzp475yFMIXWq4LVgWfrIokyBWVj6uddE/clth5m+OZRFhksF
         Ca2EpTCv/uH4OAfu+rH1eGBLHPdHRn4rIle0kr4U=
From:   sharmaajay@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: [Patch v3 0/4] RDMA/mana_ib Read Capabilities
Date:   Wed, 26 Jul 2023 13:08:20 -0700
Message-Id: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ajay Sharma <sharmaajay@microsoft.com>

This patch series introduces some cleanup changes and
resource control changes. The mana and mana_ib devices
are used at common places so a consistent naming is
introduced. Adapter object container to have a common
point of object release for resources and query the
management software to prevent resource overflow.
It also introduces async channel for management to
notify the clients in case of errors/info.

Ajay Sharma (4):
  RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
  RDMA/mana_ib : Register Mana IB  device with Management SW
  RDMA/mana_ib : Create adapter and Add error eq
  RDMA/mana_ib : Query adapter capabilities

 drivers/infiniband/hw/mana/cq.c               |  12 +-
 drivers/infiniband/hw/mana/device.c           |  72 +++--
 drivers/infiniband/hw/mana/main.c             | 282 +++++++++++++-----
 drivers/infiniband/hw/mana/mana_ib.h          |  96 +++++-
 drivers/infiniband/hw/mana/mr.c               |  42 ++-
 drivers/infiniband/hw/mana/qp.c               |  82 ++---
 drivers/infiniband/hw/mana/wq.c               |  21 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 151 ++++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  16 +-
 10 files changed, 529 insertions(+), 248 deletions(-)

-- 
2.25.1

