Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B409F762993
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 05:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGZD5O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 23:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGZD5K (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 23:57:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FCBF2698;
        Tue, 25 Jul 2023 20:57:09 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
        id BFB602380B21; Tue, 25 Jul 2023 20:57:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFB602380B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1690343828;
        bh=bQxM6vJVSEw/QexBtyHlCUkWh2i7GCiZFOmSxKu+uM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4lXI6CPl/dFIla0vQctx2s1gONNGz66RPh3ww39IBVsMM4Vm+j5zacp8C0LA0xPK
         myols200LrZyHO2ozEl7F0/FeWUl5PZGMHJV2b/araha0DAvGHLJz/TLf2VyQnCz+M
         hb9TNecYo9QNjkJP8RjbqXUutSJVWqWUk7jZY148=
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
Subject: [Patch v2 4/5] RDMA/mana_ib : Create Adapter - each vf bound to adapter object
Date:   Tue, 25 Jul 2023 20:56:59 -0700
Message-Id: <1690343820-20188-5-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
References: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
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

Create adapte object to have nice container
for VF resources.

Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  | 11 +++++-
 drivers/infiniband/hw/mana/main.c    | 50 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 30 +++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 3ab4e69705df..4077e440657a 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -91,15 +91,23 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto deregister_device;
 	}
 
+	ret = mana_ib_create_adapter(mib_dev);
+	if (ret) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to create adapter");
+		goto free_error_eq;
+	}
+
 	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
-		goto free_error_eq;
+		goto destroy_adapter;
 
 	dev_set_drvdata(&adev->dev, mib_dev);
 
 	return 0;
 
+destroy_adapter:
+	mana_ib_destroy_adapter(mib_dev);
 free_error_eq:
 	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
 deregister_device:
@@ -114,6 +122,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *mib_dev = dev_get_drvdata(&adev->dev);
 
 	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
+	mana_ib_destroy_adapter(mib_dev);
 	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
 	ib_unregister_device(&mib_dev->ib_dev);
 	ib_dealloc_device(&mib_dev->ib_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 2ea24ba3065f..aab1cc096824 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -505,6 +505,56 @@ void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
 {
 }
 
+int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev)
+{
+	struct mana_ib_destroy_adapter_resp resp = {};
+	struct mana_ib_destroy_adapter_req req = {};
+	struct gdma_context *gc;
+	int err;
+
+	gc = mib_dev->gc;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req),
+			     sizeof(resp));
+	req.adapter = mib_dev->adapter_handle;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to destroy adapter err %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int mana_ib_create_adapter(struct mana_ib_dev *mib_dev)
+{
+	struct mana_ib_create_adapter_resp resp = {};
+	struct mana_ib_create_adapter_req req = {};
+	struct gdma_context *gc;
+	int err;
+
+	gc = mib_dev->gc;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req),
+			     sizeof(resp));
+	req.notify_eq_id = mib_dev->fatal_err_eq->id;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to create adapter err %d", err);
+		return err;
+	}
+
+	mib_dev->adapter_handle = resp.adapter;
+
+	return 0;
+}
+
 void mana_ib_soc_event_handler(void *ctx, struct gdma_queue *queue,
 				struct gdma_event *event)
 {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 4383777354d3..8a652bccd978 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -32,6 +32,7 @@ struct mana_ib_dev {
 	struct gdma_dev *gdma_dev;
 	struct gdma_context *gc;
 	struct gdma_queue *fatal_err_eq;
+	mana_handle_t adapter_handle;
 };
 
 struct mana_ib_wq {
@@ -94,6 +95,31 @@ struct mana_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_ind_table;
 };
 
+enum mana_ib_command_code {
+	MANA_IB_CREATE_ADAPTER  = 0x30002,
+	MANA_IB_DESTROY_ADAPTER = 0x30003,
+};
+
+struct mana_ib_create_adapter_req {
+	struct gdma_req_hdr hdr;
+	u32 notify_eq_id;
+	u32 reserved;
+}; /*HW Data */
+
+struct mana_ib_create_adapter_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t adapter;
+}; /* HW Data */
+
+struct mana_ib_destroy_adapter_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+}; /*HW Data */
+
+struct mana_ib_destroy_adapter_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
 				 struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
@@ -164,4 +190,8 @@ void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_create_error_eq(struct mana_ib_dev *mib_dev);
 
+int mana_ib_create_adapter(struct mana_ib_dev *mib_dev);
+
+int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev);
+
 #endif
-- 
2.25.1

