Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D966F8907
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 May 2023 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjEESwM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 May 2023 14:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjEESwL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 May 2023 14:52:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D21112A;
        Fri,  5 May 2023 11:51:59 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 0E5D220EA203; Fri,  5 May 2023 11:51:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E5D220EA203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1683312719;
        bh=mb5lvwg5ohLnnbkdoeBM8lxdqhlZn5srSg8X66I10YQ=;
        h=From:To:Cc:Subject:Date:Reply-To:From;
        b=FGPYeoobBbC8zpKtp262vui8o6VTAI05CAw2wWRvQj7vOvJOgCkmGRsoxzUd4ognE
         8hgvhBdXC4TabrBsmVt5QU2yZvs1DgNBfj09deVQkxZEKDpolp5jO8Q3y/plDgNGrU
         JBDyMi63+Xf5VRF+oIQq0/gqUqe2cYzdjMvIM2MI=
From:   longli@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: [PATCH] RDMA/mana_ib: Use v2 version of cfg_rx_steer_req to enable RX coalescing
Date:   Fri,  5 May 2023 11:51:48 -0700
Message-Id: <1683312708-24872-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

With RX coalescing, one CQE entry can be used to indicate multiple packets
on the receive queue. This saves processing time and PCI bandwidth over
the CQ.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/qp.c |  5 ++++-
 include/net/mana/mana.h         | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 54b61930a7fd..83c768f96506 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -13,7 +13,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 				      u8 *rx_hash_key)
 {
 	struct mana_port_context *mpc = netdev_priv(ndev);
-	struct mana_cfg_rx_steer_req *req = NULL;
+	struct mana_cfg_rx_steer_req_v2 *req = NULL;
 	struct mana_cfg_rx_steer_resp resp = {};
 	mana_handle_t *req_indir_tab;
 	struct gdma_context *gc;
@@ -33,6 +33,8 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	mana_gd_init_req_hdr(&req->hdr, MANA_CONFIG_VPORT_RX, req_buf_size,
 			     sizeof(resp));
 
+	req->hdr.req.msg_version = GDMA_MESSAGE_V2;
+
 	req->vport = mpc->port_handle;
 	req->rx_enable = 1;
 	req->update_default_rxobj = 1;
@@ -46,6 +48,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
 	req->indir_tab_offset = sizeof(*req);
 	req->update_indir_tab = true;
+	req->cqe_coalescing_enable = true;
 
 	req_indir_tab = (mana_handle_t *)(req + 1);
 	/* The ind table passed to the hardware must have
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index cd386aa7c7cc..f8314b7c386c 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -596,6 +596,23 @@ struct mana_cfg_rx_steer_req {
 	u8 hashkey[MANA_HASH_KEY_SIZE];
 }; /* HW DATA */
 
+struct mana_cfg_rx_steer_req_v2 {
+	struct gdma_req_hdr hdr;
+	mana_handle_t vport;
+	u16 num_indir_entries;
+	u16 indir_tab_offset;
+	u32 rx_enable;
+	u32 rss_enable;
+	u8 update_default_rxobj;
+	u8 update_hashkey;
+	u8 update_indir_tab;
+	u8 reserved;
+	mana_handle_t default_rxobj;
+	u8 hashkey[MANA_HASH_KEY_SIZE];
+	u8 cqe_coalescing_enable;
+	u8 reserved2[7];
+}; /* HW DATA */
+
 struct mana_cfg_rx_steer_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW DATA */
-- 
2.17.1

