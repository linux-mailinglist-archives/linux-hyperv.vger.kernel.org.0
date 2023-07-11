Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6D74E822
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jul 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGKHgd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Jul 2023 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGKHgc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Jul 2023 03:36:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40EE419A4;
        Tue, 11 Jul 2023 00:36:02 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id 53DBA21C425F; Tue, 11 Jul 2023 00:36:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53DBA21C425F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689060960;
        bh=gWrM56ccZEADkx2wSZ3+Zj6Jlk8sdux3X4SrHsbdPj8=;
        h=From:To:Cc:Subject:Date:From;
        b=m3dlEX6B8eUiwRK09Oxu0gIDt6IulsTJ2BROn8ryroWW2Xqgk2tDdmqcXOXcNTRKU
         IbwRUa0c1VdK/LYRnNJMNx/7P3NjnAPtXGjGYdPvOyJjFWmqrERk6FLaDgbzDou/t+
         Al4oS4QfuEfPOqfjLTZK+EOOKMxnLmYQDuaY//WA=
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     schakrabarti@microsoft.com,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH V3 net] net: mana: Configure hwc timeout from hardware
Date:   Tue, 11 Jul 2023 00:35:57 -0700
Message-Id: <1689060957-1475-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

At present hwc timeout value is a fixed value.
This patch sets the hwc timeout from the hardware.
It now uses a new hardware capability
GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG to query
and set the value in hwc_timeout.

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
V2 -> V3:
* Removed the stable release from cc
* Formatted the variable position to follow reverse xmas tree
* Removed the log from mana_gd_query_hwc_timeout on success scenario
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 30 ++++++++++++++++++-
 .../net/ethernet/microsoft/mana/hw_channel.c  | 25 +++++++++++++++-
 include/net/mana/gdma.h                       | 20 ++++++++++++-
 include/net/mana/hw_channel.h                 |  5 ++++
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8f3f78b68592..4537a70e30d4 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -106,6 +106,25 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	return 0;
 }
 
+static int mana_gd_query_hwc_timeout(struct pci_dev *pdev, u32 *timeout_val)
+{
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	struct gdma_query_hwc_timeout_resp resp = {};
+	struct gdma_query_hwc_timeout_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_HWC_TIMEOUT,
+			     sizeof(req), sizeof(resp));
+	req.timeout_ms = *timeout_val;
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err || resp.hdr.status)
+		return err ? err : -EPROTO;
+
+	*timeout_val = resp.timeout_ms;
+
+	return 0;
+}
+
 static int mana_gd_detect_devices(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
@@ -879,8 +898,11 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_verify_ver_resp resp = {};
 	struct gdma_verify_ver_req req = {};
+	struct hw_channel_context *hwc;
 	int err;
 
+	hwc = gc->hwc.driver_data;
+
 	mana_gd_init_req_hdr(&req.hdr, GDMA_VERIFY_VF_DRIVER_VERSION,
 			     sizeof(req), sizeof(resp));
 
@@ -907,7 +929,13 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
 			err, resp.hdr.status);
 		return err ? err : -EPROTO;
 	}
-
+	if (resp.pf_cap_flags1 & GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG) {
+		err = mana_gd_query_hwc_timeout(pdev, &hwc->hwc_timeout);
+		if (err) {
+			dev_err(gc->dev, "Failed to set the hwc timeout %d\n", err);
+			return err;
+		}
+	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 2bd1d74021f7..db433501e5e6 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -174,7 +174,25 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 		complete(&hwc->hwc_init_eqe_comp);
 		break;
 
+	case GDMA_EQE_HWC_SOC_RECONFIG_DATA:
+		type_data.as_uint32 = event->details[0];
+		type = type_data.type;
+		val = type_data.value;
+
+		switch (type) {
+		case HWC_DATA_CFG_HWC_TIMEOUT:
+			hwc->hwc_timeout = val;
+			break;
+
+		default:
+			dev_warn(hwc->dev, "Received unknown reconfig type %u\n", type);
+			break;
+		}
+
+		break;
+
 	default:
+		dev_warn(hwc->dev, "Received unknown gdma event %u\n", event->type);
 		/* Ignore unknown events, which should never happen. */
 		break;
 	}
@@ -704,6 +722,7 @@ int mana_hwc_create_channel(struct gdma_context *gc)
 	gd->pdid = INVALID_PDID;
 	gd->doorbell = INVALID_DOORBELL;
 
+	hwc->hwc_timeout = HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS;
 	/* mana_hwc_init_queues() only creates the required data structures,
 	 * and doesn't touch the HWC device.
 	 */
@@ -770,6 +789,8 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	hwc->gdma_dev->doorbell = INVALID_DOORBELL;
 	hwc->gdma_dev->pdid = INVALID_PDID;
 
+	hwc->hwc_timeout = 0;
+
 	kfree(hwc);
 	gc->hwc.driver_data = NULL;
 	gc->hwc.gdma_context = NULL;
@@ -818,6 +839,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 		dest_vrq = hwc->pf_dest_vrq_id;
 		dest_vrcq = hwc->pf_dest_vrcq_id;
 	}
+	dev_err(hwc->dev, "HWC: timeout %u ms\n", hwc->hwc_timeout);
 
 	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
 	if (err) {
@@ -825,7 +847,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 		goto out;
 	}
 
-	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
+	if (!wait_for_completion_timeout(&ctx->comp_event,
+					 (hwc->hwc_timeout / 1000) * HZ)) {
 		dev_err(hwc->dev, "HWC: Request timed out!\n");
 		err = -ETIMEDOUT;
 		goto out;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 96c120160f15..88b6ef7ce1a6 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -33,6 +33,7 @@ enum gdma_request_type {
 	GDMA_DESTROY_PD			= 30,
 	GDMA_CREATE_MR			= 31,
 	GDMA_DESTROY_MR			= 32,
+	GDMA_QUERY_HWC_TIMEOUT		= 84, /* 0x54 */
 };
 
 #define GDMA_RESOURCE_DOORBELL_PAGE	27
@@ -57,6 +58,8 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
+	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
+	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
 };
 
 enum {
@@ -531,10 +534,12 @@ enum {
  * so the driver is able to reliably support features like busy_poll.
  */
 #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)
+#define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
-	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX)
+	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
@@ -664,6 +669,19 @@ struct gdma_disable_queue_req {
 	u32 alloc_res_id_on_creation;
 }; /* HW DATA */
 
+/* GDMA_QUERY_HWC_TIMEOUT */
+struct gdma_query_hwc_timeout_req {
+	struct gdma_req_hdr hdr;
+	u32 timeout_ms;
+	u32 reserved;
+};
+
+struct gdma_query_hwc_timeout_resp {
+	struct gdma_resp_hdr hdr;
+	u32 timeout_ms;
+	u32 reserved;
+};
+
 enum atb_page_size {
 	ATB_PAGE_SIZE_4K,
 	ATB_PAGE_SIZE_8K,
diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index 6a757a6e2732..3d3b5c881bc1 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -23,6 +23,10 @@
 #define HWC_INIT_DATA_PF_DEST_RQ_ID	10
 #define HWC_INIT_DATA_PF_DEST_CQ_ID	11
 
+#define HWC_DATA_CFG_HWC_TIMEOUT 1
+
+#define HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS 30000
+
 /* Structures labeled with "HW DATA" are exchanged with the hardware. All of
  * them are naturally aligned and hence don't need __packed.
  */
@@ -182,6 +186,7 @@ struct hw_channel_context {
 
 	u32 pf_dest_vrq_id;
 	u32 pf_dest_vrcq_id;
+	u32 hwc_timeout;
 
 	struct hwc_caller_ctx *caller_ctx;
 };
-- 
2.34.1

