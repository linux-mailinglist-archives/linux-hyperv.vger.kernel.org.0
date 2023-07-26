Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03E762988
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 05:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGZD5G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 23:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGZD5E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 23:57:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D70D71BF2;
        Tue, 25 Jul 2023 20:57:03 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
        id 1A4BB2380B17; Tue, 25 Jul 2023 20:57:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A4BB2380B17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1690343823;
        bh=+FVUEn1yD0tAL3RMqa721SSRIJPoJUbzwns9YtZH6jY=;
        h=From:To:Cc:Subject:Date:From;
        b=XF6CDhGicdUdrGXLMt1FMTgiZBG9hmmlYdUfRtKfv8hsIVfeLijxyPD1xHZBP7S9M
         W0p9bLWATFsR87DPae1MA6t9J1b+6MuswUUDdvLfmVAl8WMlLh8AKmmKtzpRq/N8Ug
         Pz4wJ3zcZchQuZLAV+mqlqXOvrLcKSEypjy/SfLU=
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
Subject: [Patch v2 0/5] RDMA/mana_ib Read Capabilities
Date:   Tue, 25 Jul 2023 20:56:55 -0700
Message-Id: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ajay Sharma <sharmaajay@microsoft.com>

This version has style formatting corrections.
The V1 introduced changes to control resource
allocation. The resources are managed by
Management SW and the patch allows reading the
limits to prevent overflow. 

Ajay Sharma (5):
  RDMA/mana-ib : Rename all mana_ib_dev type variables to mib_dev
  RDMA/mana_ib : Register Mana IB  device with Management SW
  RDMA/mana_ib : Add error eq and notification from SoC
  RDMA/mana_ib : Create Adapter - each vf bound to adapter object
  RDMA/mana_ib : Query adapter capabilities

 drivers/infiniband/hw/mana/cq.c               |  12 +-
 drivers/infiniband/hw/mana/device.c           |  72 +++--
 drivers/infiniband/hw/mana/main.c             | 258 ++++++++++++------
 drivers/infiniband/hw/mana/mana_ib.h          |  96 ++++++-
 drivers/infiniband/hw/mana/mr.c               |  42 ++-
 drivers/infiniband/hw/mana/qp.c               |  82 +++---
 drivers/infiniband/hw/mana/wq.c               |  21 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 151 +++++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  16 +-
 10 files changed, 505 insertions(+), 248 deletions(-)

-- 
2.25.1

