Return-Path: <linux-hyperv+bounces-11986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxPoDpT/VmqCEAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11986-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:33:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E475A4C7
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11986-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11986-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8369309559D
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3939021E;
	Wed, 15 Jul 2026 03:30:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4E03AE1BB;
	Wed, 15 Jul 2026 03:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086227; cv=none; b=T3jsZAUvKqW7w1orlR49AL1IWVJgBp/Gd5i0Hv499MLKtMvRflk6sbcnfqGD5Gjd8BnVzXYuXNnfLkXF7SfqYw59OwNw5eEEA4zpsIkqfbCzStnQFTVZkSyNO9Jt9WY87qUg3a9zHYYg8z1JJLuX5RP0up7Q8Jaei93i0Giv/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086227; c=relaxed/simple;
	bh=q7xlc0jgLWkQEZnLwUwGoguyH0ciJn5gJSXrvkEj6fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJd1wIz6C9Tofo2vxDqTLtFwhBnlTtOPbk8e7NTVah/VuyeOZsCcjz3dflKADr3I3vRyb8l3lI5wz5UH64UsFr0zjRmO0oHAY+BxtTVvODcADxpXnbVziYprwyLKZv57hwbn/Ez/Zh3KEAqBeYtIxAXeB11bvPA6PH4NbSOl3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 5285C20B716F; Tue, 14 Jul 2026 20:30:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5285C20B716F
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] net: mana: support concurrent HWC requests with proper synchronization
Date: Tue, 14 Jul 2026 20:29:40 -0700
Message-ID: <20260715032942.3945317-7-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260715032942.3945317-1-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11986-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E3E475A4C7

The HWC serialized all management commands behind a depth-1 semaphore, a
bottleneck when many commands must be issued concurrently.  Allowing
multiple in-flight requests exposes several shared-state races that this
patch addresses together.

  - Replace the semaphore with a waitqueue + bitmap scheme so senders
    acquire message slots in parallel and sleep only when all slots are
    busy.

  - A response is delivered by handle_resp() in CQ interrupt context
    while the issuing sender may concurrently time out and return; both
    touch the same caller_ctx slot (output_buf, output_buflen, error):

      CPU A (sender timeout)            CPU B (handle_resp, IRQ)
      ------------------------------    ------------------------------
      read/clear output_buf             write response into output_buf,
                                        complete the slot

    Add a per-slot spinlock to make these mutually exclusive, a per-slot
    refcount so the last of {sender, handle_resp} releases the bitmap
    slot (no double-release, no stuck slot), and an embedded completion
    the sender waits on.  The sender always NULLs output_buf after
    waking, so a late handle_resp() skips the copy.

  - Add a per-queue lock to hwc_wq; mana_gd_post_and_ring() is not safe
    to call concurrently on the same queue.

  - Add channel_up (cleared under the bitmap lock in destroy_channel) and
    hwc_timed_out flags so new slot acquisitions are rejected during
    teardown and after a timeout.

  - destroy_channel() must not free the HWC while senders are still in
    flight.  Track senders with an atomic refcount; destroy_channel()
    force-completes the in-flight slots (-ENODEV) and then waits for the
    count to reach zero before freeing.  The drain waitqueue lives on
    gdma_context, not hwc, so the final wake_up() after the last
    atomic_dec does not dereference freed hwc memory.

  - The sender looks up the channel via gc->hwc.driver_data, which
    destroy_channel() clears and then frees.  Without serialization the
    lookup and the reference can straddle the free:

      CPU A (mana_gd_send_request)      CPU B (destroy_channel)
      ------------------------------    ------------------------------
      hwc = gc->hwc.driver_data;  // ok
                                        driver_data = NULL;
                                        wait active_senders == 0;  // 0!
                                        kfree(hwc);
      atomic_inc(&hwc->active_senders); // use-after-free

    Guard driver_data with a new gc->hwc_lock spinlock, taken by the
    readers (mana_gd_send_request, mana_need_log, mana_serv_reset) and by
    the publish/clear, so "load the pointer + take a sender reference" is
    atomic against the clear.  After the clear a sender either already
    holds a reference (and is waited for) or observes NULL and returns
    -ENODEV.  These are all control-plane paths (HWC commands sleep,
    reset runs on a workqueue), so a plain spinlock -- not RCU -- is
    sufficient.

This adds the concurrency infrastructure at the bootstrap queue depth of
1; the next patch raises it to the device-reported maximum.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  53 ++-
 .../net/ethernet/microsoft/mana/hw_channel.c  | 314 +++++++++++++++---
 include/net/mana/gdma.h                       |  15 +
 include/net/mana/hw_channel.h                 |  29 +-
 4 files changed, 365 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index c52ef566dc0c..d44a3e2c4add 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -161,6 +161,8 @@ static int mana_gd_init_registers(struct pci_dev *pdev)
 bool mana_need_log(struct gdma_context *gc, int err)
 {
 	struct hw_channel_context *hwc;
+	bool need_log = true;
+	unsigned long flags;
 
 	if (err != -ETIMEDOUT)
 		return true;
@@ -168,11 +170,13 @@ bool mana_need_log(struct gdma_context *gc, int err)
 	if (!gc)
 		return true;
 
+	spin_lock_irqsave(&gc->hwc_lock, flags);
 	hwc = gc->hwc.driver_data;
 	if (hwc && hwc->hwc_timeout == 0)
-		return false;
+		need_log = false;
+	spin_unlock_irqrestore(&gc->hwc_lock, flags);
 
-	return true;
+	return need_log;
 }
 
 static int mana_gd_query_max_resources(struct pci_dev *pdev)
@@ -367,9 +371,25 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 int mana_gd_send_request(struct gdma_context *gc, u32 req_len, const void *req,
 			 u32 resp_len, void *resp)
 {
-	struct hw_channel_context *hwc = gc->hwc.driver_data;
+	struct hw_channel_context *hwc;
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&gc->hwc_lock, flags);
+	hwc = gc->hwc.driver_data;
+	if (!hwc) {
+		spin_unlock_irqrestore(&gc->hwc_lock, flags);
+		return -ENODEV;
+	}
+	atomic_inc(&hwc->active_senders);
+	spin_unlock_irqrestore(&gc->hwc_lock, flags);
+
+	err = mana_hwc_send_request(hwc, req_len, req, resp_len, resp);
 
-	return mana_hwc_send_request(hwc, req_len, req, resp_len, resp);
+	if (atomic_dec_and_test(&hwc->active_senders))
+		wake_up(&gc->hwc_drain_waitq);
+
+	return err;
 }
 EXPORT_SYMBOL_NS(mana_gd_send_request, "NET_MANA");
 
@@ -622,6 +642,7 @@ static void mana_serv_reset(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct hw_channel_context *hwc;
+	unsigned long flags;
 	int ret;
 
 	if (!gc) {
@@ -631,14 +652,17 @@ static void mana_serv_reset(struct pci_dev *pdev)
 		return;
 	}
 
+	spin_lock_irqsave(&gc->hwc_lock, flags);
 	hwc = gc->hwc.driver_data;
 	if (!hwc) {
+		spin_unlock_irqrestore(&gc->hwc_lock, flags);
 		dev_err(&pdev->dev, "MANA service: no HWC\n");
 		goto out;
 	}
 
 	/* HWC is not responding in this case, so don't wait */
 	hwc->hwc_timeout = 0;
+	spin_unlock_irqrestore(&gc->hwc_lock, flags);
 
 	dev_info(&pdev->dev, "MANA reset cycle start\n");
 
@@ -1200,6 +1224,16 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	if (!MANA_PAGE_ALIGNED(gmi->virt_addr))
 		return -EINVAL;
 
+	/* No RCU needed: this runs only on the data-path queue-creation
+	 * path (mana_gd_create_mana_eq/mana_gd_create_mana_wq_cq, called
+	 * by mana_en under RTNL and by mana_ib RDMA verbs, or during
+	 * init).  Every teardown path — mana_gd_remove, mana_gd_suspend,
+	 * and the HWC reset/service path (which goes through
+	 * mana_gd_suspend) — drains those consumers via mana_rdma_remove()
+	 * + mana_remove() before mana_hwc_destroy_channel() clears
+	 * gc->hwc.driver_data, so no concurrent destroy can race with
+	 * this dereference.
+	 */
 	hwc = gc->hwc.driver_data;
 	req_msg_size = struct_size(req, page_addr_list, num_page);
 	if (req_msg_size > hwc->max_req_msg_size)
@@ -1389,7 +1423,17 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
 	struct hw_channel_context *hwc;
 	int err;
 
+	/* No RCU needed: this runs only inside mana_gd_setup, on the
+	 * probe and resume paths.  The PCI/PM core holds device_lock
+	 * across .probe/.resume and .remove/.suspend, so setup cannot
+	 * overlap teardown of the same device.  The HWC reset/service
+	 * path is additionally serialized by GC_IN_SERVICE and runs
+	 * suspend (destroy) then resume (this) sequentially in one work
+	 * item.  driver_data was just set by mana_hwc_create_channel
+	 * earlier in this same setup call, so it is live here.
+	 */
 	hwc = gc->hwc.driver_data;
+
 	mana_gd_init_req_hdr(&req.hdr, GDMA_VERIFY_VF_DRIVER_VERSION,
 			     sizeof(req), sizeof(resp));
 
@@ -2379,6 +2423,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	mutex_init(&gc->eq_test_event_mutex);
 	mutex_init(&gc->gic_mutex);
+	spin_lock_init(&gc->hwc_lock);
 	pci_set_drvdata(pdev, gc);
 	gc->bar0_pa = pci_resource_start(pdev, 0);
 	gc->bar0_size = pci_resource_len(pdev, 0);
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index b26c2122ebf5..9ba4e75a4dd3 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -7,25 +7,52 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 
+/* Acquire a free message slot from the inflight bitmap.  Returns
+ * -ENODEV if the channel is torn down, or -ETIMEDOUT if a prior HWC
+ * command has timed out (preserving the error code callers expect).
+ */
 static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *msg_id)
 {
 	struct gdma_resource *r = &hwc->inflight_msg_res;
 	unsigned long flags;
 	u32 index;
 
-	down(&hwc->sema);
+	for (;;) {
+		spin_lock_irqsave(&r->lock, flags);
 
-	spin_lock_irqsave(&r->lock, flags);
+		if (!hwc->channel_up || hwc->hwc_timed_out) {
+			spin_unlock_irqrestore(&r->lock, flags);
+			return hwc->channel_up ? -ETIMEDOUT : -ENODEV;
+		}
 
-	index = find_first_zero_bit(hwc->inflight_msg_res.map,
-				    hwc->inflight_msg_res.size);
+		index = find_first_zero_bit(r->map, r->size);
+		if (index < r->size) {
+			struct hwc_caller_ctx *ctx;
+
+			bitmap_set(r->map, index, 1);
+			ctx = &hwc->caller_ctx[index];
+			reinit_completion(&ctx->comp_event);
+			refcount_set(&ctx->refcnt, 1);
+			ctx->msg_id = index;
+			ctx->error = -EINPROGRESS;
+			spin_unlock_irqrestore(&r->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&r->lock, flags);
 
-	bitmap_set(hwc->inflight_msg_res.map, index, 1);
+		wait_event(hwc->msg_waitq,
+			   !hwc->channel_up ||
+			   hwc->hwc_timed_out ||
+			   !bitmap_full(r->map, r->size));
 
-	spin_unlock_irqrestore(&r->lock, flags);
+		if (!hwc->channel_up)
+			return -ENODEV;
 
-	*msg_id = index;
+		if (hwc->hwc_timed_out)
+			return -ETIMEDOUT;
+	}
 
+	*msg_id = index;
 	return 0;
 }
 
@@ -35,10 +62,17 @@ static void mana_hwc_put_msg_index(struct hw_channel_context *hwc, u16 msg_id)
 	unsigned long flags;
 
 	spin_lock_irqsave(&r->lock, flags);
-	bitmap_clear(hwc->inflight_msg_res.map, msg_id, 1);
+	bitmap_clear(r->map, msg_id, 1);
 	spin_unlock_irqrestore(&r->lock, flags);
 
-	up(&hwc->sema);
+	wake_up(&hwc->msg_waitq);
+}
+
+static void hwc_ctx_put(struct hw_channel_context *hwc,
+			struct hwc_caller_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->refcnt))
+		mana_hwc_put_msg_index(hwc, ctx->msg_id);
 }
 
 static int mana_hwc_verify_resp_msg(const struct hwc_caller_ctx *caller_ctx,
@@ -114,22 +148,32 @@ static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
 		resp_len = 0;
 	}
 
-	err = mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
-	if (err)
-		goto out;
+	spin_lock(&ctx->lock);
 
-	ctx->status_code = resp_msg->status;
+	err = mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
 
-	memcpy(ctx->output_buf, resp_msg, resp_len);
-out:
-	ctx->error = err;
+	if (!err && ctx->output_buf) {
+		ctx->status_code = resp_msg->status;
+		memcpy(ctx->output_buf, resp_msg, resp_len);
+		ctx->error = 0;
+	} else if (ctx->output_buf) {
+		/* Only overwrite error if the sender hasn't timed out
+		 * or been force-completed by destroy.  When output_buf
+		 * is NULL, a terminal error (-ENODEV or timeout) has
+		 * already been set — preserve it so the sender doesn't
+		 * see a spurious success.
+		 */
+		ctx->error = err;
+	}
 
-	/* Must post rx wqe before complete(), otherwise the next rx may
-	 * hit no_wqe error.
+	/* Post RX WQE before completing — the next response may arrive
+	 * immediately and needs a posted buffer.
 	 */
 	mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
-
 	complete(&ctx->comp_event);
+	spin_unlock(&ctx->lock);
+
+	hwc_ctx_put(hwc, ctx);
 }
 
 static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
@@ -617,6 +661,7 @@ static int mana_hwc_create_wq(struct hw_channel_context *hwc,
 	hwc_wq->gdma_wq = queue;
 	hwc_wq->queue_depth = q_depth;
 	hwc_wq->hwc_cq = hwc_cq;
+	spin_lock_init(&hwc_wq->lock);
 
 	err = mana_hwc_alloc_dma_buf(hwc, q_depth, max_msg_size,
 				     &hwc_wq->msg_buf);
@@ -634,7 +679,7 @@ static int mana_hwc_create_wq(struct hw_channel_context *hwc,
 	return err;
 }
 
-static int mana_hwc_post_tx_wqe(const struct hwc_wq *hwc_txq,
+static int mana_hwc_post_tx_wqe(struct hwc_wq *hwc_txq,
 				struct hwc_work_request *req,
 				u32 dest_virt_rq_id, u32 dest_virt_rcq_id,
 				bool dest_pf)
@@ -673,7 +718,11 @@ static int mana_hwc_post_tx_wqe(const struct hwc_wq *hwc_txq,
 	req->wqe_req.inline_oob_data = tx_oob;
 	req->wqe_req.client_data_unit = 0;
 
+	/* Serialize WQE posting — multiple senders may call concurrently. */
+	spin_lock(&hwc_txq->lock);
 	err = mana_gd_post_and_ring(hwc_txq->gdma_wq, &req->wqe_req, NULL);
+	spin_unlock(&hwc_txq->lock);
+
 	if (err)
 		dev_err(dev, "Failed to post WQE on HWC SQ: %d\n", err);
 	return err;
@@ -684,7 +733,7 @@ static int mana_hwc_init_inflight_msg(struct hw_channel_context *hwc,
 {
 	int err;
 
-	sema_init(&hwc->sema, num_msg);
+	init_waitqueue_head(&hwc->msg_waitq);
 
 	err = mana_gd_alloc_res_map(num_msg, &hwc->inflight_msg_res);
 	if (err)
@@ -714,18 +763,34 @@ static int mana_hwc_test_channel(struct hw_channel_context *hwc, u16 q_depth,
 	if (!ctx)
 		return -ENOMEM;
 
-	for (i = 0; i < q_depth; ++i)
+	for (i = 0; i < q_depth; ++i) {
+		spin_lock_init(&ctx[i].lock);
 		init_completion(&ctx[i].comp_event);
+	}
 
 	hwc->caller_ctx = ctx;
 
-	return mana_gd_test_eq(gc, hwc->cq->gdma_eq);
+	/* channel_up must be set before the test EQ request, because
+	 * the request goes through mana_hwc_get_msg_index() which
+	 * checks channel_up.  caller_ctx is allocated above, so
+	 * concurrent access to a NULL caller_ctx is not possible.
+	 */
+	hwc->channel_up = true;
+
+	err = mana_gd_test_eq(gc, hwc->cq->gdma_eq);
+	if (err)
+		hwc->channel_up = false;
+
+	return err;
 }
 
 static int mana_hwc_establish_channel(struct gdma_context *gc, u16 *q_depth,
 				      u32 *max_req_msg_size,
 				      u32 *max_resp_msg_size)
 {
+	/* No RCU needed: called only from mana_hwc_create_channel
+	 * during init, before the channel is published to senders.
+	 */
 	struct hw_channel_context *hwc = gc->hwc.driver_data;
 	struct gdma_queue *rq = hwc->rxq->gdma_wq;
 	struct gdma_queue *sq = hwc->txq->gdma_wq;
@@ -842,6 +907,7 @@ int mana_hwc_create_channel(struct gdma_context *gc)
 	u32 max_req_msg_size, max_resp_msg_size;
 	struct gdma_dev *gd = &gc->hwc;
 	struct hw_channel_context *hwc;
+	unsigned long flags;
 	u16 q_depth_max;
 	int err;
 
@@ -850,10 +916,11 @@ int mana_hwc_create_channel(struct gdma_context *gc)
 		return -ENOMEM;
 
 	gd->gdma_context = gc;
-	gd->driver_data = hwc;
 	hwc->gdma_dev = gd;
 	hwc->dev = gc->dev;
 	hwc->hwc_timeout = HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS;
+	atomic_set(&hwc->active_senders, 0);
+	init_waitqueue_head(&gc->hwc_drain_waitq);
 
 	/* HWC's instance number is always 0. */
 	gd->dev_id.as_uint32 = 0;
@@ -862,6 +929,15 @@ int mana_hwc_create_channel(struct gdma_context *gc)
 	gd->pdid = INVALID_PDID;
 	gd->doorbell = INVALID_DOORBELL;
 
+	/* Publish driver_data last, under hwc_lock: the lock orders the hwc
+	 * initialisation above before the pointer becomes visible and
+	 * serialises the publish against the control-plane readers in
+	 * mana_gd_send_request(), mana_need_log() and mana_serv_reset().
+	 */
+	spin_lock_irqsave(&gc->hwc_lock, flags);
+	gc->hwc.driver_data = hwc;
+	spin_unlock_irqrestore(&gc->hwc_lock, flags);
+
 	/* mana_hwc_init_queues() only creates the required data structures,
 	 * and doesn't touch the HWC device.
 	 */
@@ -898,13 +974,47 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 {
 	struct hw_channel_context *hwc = gc->hwc.driver_data;
 	struct gdma_queue __rcu **old_cq_table;
+	unsigned long flags;
 
 	if (!hwc)
 		return;
 
+	/* Prevent new requests from starting and wake any
+	 * threads waiting for a free msg slot.  Set channel_up under
+	 * the bitmap lock so get_msg_index() cannot acquire a slot
+	 * and increment active_senders after this point.
+	 *
+	 * If channel_up is already false (e.g. init failed before
+	 * the channel was established), skip the lock — it may not
+	 * have been initialized yet, and no senders can be active.
+	 */
+	if (hwc->channel_up) {
+		spin_lock_irqsave(&hwc->inflight_msg_res.lock, flags);
+		hwc->channel_up = false;
+		spin_unlock_irqrestore(&hwc->inflight_msg_res.lock, flags);
+		wake_up_all(&hwc->msg_waitq);
+	}
+
+	/* Clear the pointer under hwc_lock so new callers in
+	 * mana_gd_send_request() see NULL and return -ENODEV.  The lock
+	 * makes the readers' "load driver_data + atomic_inc(active_senders)"
+	 * atomic against this store, so once it returns no new sender can
+	 * take a reference; the active_senders drain below waits out those
+	 * that already did, before their hwc is freed.
+	 */
+	spin_lock_irqsave(&gc->hwc_lock, flags);
+	gc->hwc.driver_data = NULL;
+	spin_unlock_irqrestore(&gc->hwc_lock, flags);
+
 	/* Tear down the HWC if setup_hwc previously activated MST entries.
 	 * This is the definitive flag — unlike max_num_cqs which depends
 	 * on the init EQE arriving.
+	 *
+	 * The return value is intentionally not checked.  This is the
+	 * terminal cleanup path — resources must be freed regardless.
+	 * If teardown fails, hardware may still have active MST entries,
+	 * but the EQ deregistration and IOMMU unmapping below prevent
+	 * stale hardware accesses from reaching kernel memory.
 	 */
 	if (hwc->setup_active) {
 		int td_err = mana_smc_teardown_hwc(&gc->shm_channel, false);
@@ -950,11 +1060,49 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 		hwc->setup_active = false;
 	}
 
+	/* After SMC teardown, no more hardware events should arrive.
+	 * Force-complete any remaining in-flight senders so they can
+	 * exit and drop their refs.
+	 */
+	if (hwc->caller_ctx) {
+		struct hwc_caller_ctx *ctx;
+		int i;
+
+		for (i = 0; i < hwc->num_inflight_msg; i++) {
+			if (!test_bit(i, hwc->inflight_msg_res.map))
+				continue;
+
+			ctx = &hwc->caller_ctx[i];
+
+			/* Wake senders blocked on wait_for_completion.
+			 * Set error under lock to avoid racing with
+			 * handle_resp() which writes error under the
+			 * same lock.  The sender NULLs output_buf
+			 * after waking — doing it here would race
+			 * with a sender that hasn't set output_buf yet.
+			 */
+			spin_lock_irqsave(&ctx->lock, flags);
+			ctx->error = -ENODEV;
+			complete(&ctx->comp_event);
+			spin_unlock_irqrestore(&ctx->lock, flags);
+		}
+	}
+
+	/* Wait for all sender threads to finish and drop their refs.
+	 * After this, only slots held by timed-out senders whose
+	 * handle_resp() never ran remain in the bitmap.
+	 */
+	wait_event(gc->hwc_drain_waitq,
+		   atomic_read(&hwc->active_senders) == 0);
+
 	/* Tear down the HWC CQ object first — mana_hwc_destroy_cq()
 	 * both unpublishes the CQ from cq_table (+synchronize_rcu) and
-	 * deregisters the HWC EQ from the interrupt handler list (via
-	 * mana_gd_deregister_irq + synchronize_rcu), guaranteeing no
-	 * interrupt handler can access RQ/TXQ buffers after this point.
+	 * deregisters the HWC EQ from the interrupt handler's RCU list
+	 * (via mana_gd_deregister_irq + synchronize_rcu), guaranteeing
+	 * no interrupt handler can access RQ/TXQ buffers after this
+	 * point.  The active_senders drain above ensures no sender is
+	 * accessing the CQ via txq->hwc_cq when it is destroyed.  Then
+	 * destroy TXQ and RQ safely.
 	 */
 	if (hwc->cq)
 		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
@@ -965,6 +1113,23 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	if (hwc->rxq)
 		mana_hwc_destroy_wq(hwc, hwc->rxq);
 
+	/* Release any slots still held — these belong to timed-out
+	 * senders where handle_resp() never ran (refcount = 1 with
+	 * handle_resp's ref still outstanding).
+	 */
+	if (hwc->caller_ctx) {
+		struct hwc_caller_ctx *ctx;
+		int i;
+
+		for (i = 0; i < hwc->num_inflight_msg; i++) {
+			if (!test_bit(i, hwc->inflight_msg_res.map))
+				continue;
+
+			ctx = &hwc->caller_ctx[i];
+			hwc_ctx_put(hwc, ctx);
+		}
+	}
+
 	kfree(hwc->caller_ctx);
 	hwc->caller_ctx = NULL;
 
@@ -978,7 +1143,6 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	hwc->hwc_timeout = 0;
 
 	kfree(hwc);
-	gc->hwc.driver_data = NULL;
 	gc->hwc.gdma_context = NULL;
 
 	old_cq_table = rcu_replace_pointer(gc->cq_table, NULL, true);
@@ -994,13 +1158,17 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	struct hwc_wq *txq = hwc->txq;
 	struct gdma_req_hdr *req_msg;
 	struct hwc_caller_ctx *ctx;
+	unsigned long flags;
 	u32 dest_vrcq = 0;
 	u32 dest_vrq = 0;
 	u32 command;
+	u32 status;
 	u16 msg_id;
 	int err;
 
-	mana_hwc_get_msg_index(hwc, &msg_id);
+	err = mana_hwc_get_msg_index(hwc, &msg_id);
+	if (err)
+		return err;
 
 	tx_wr = &txq->msg_buf->reqs[msg_id];
 
@@ -1012,8 +1180,11 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	}
 
 	ctx = hwc->caller_ctx + msg_id;
+
+	spin_lock_irqsave(&ctx->lock, flags);
 	ctx->output_buf = resp;
 	ctx->output_buflen = resp_len;
+	spin_unlock_irqrestore(&ctx->lock, flags);
 
 	req_msg = (struct gdma_req_hdr *)tx_wr->buf_va;
 	if (req)
@@ -1029,8 +1200,14 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 		dest_vrcq = hwc->pf_dest_vrcq_id;
 	}
 
+	/* Take handle_resp's ref before posting — hardware can respond
+	 * immediately after the doorbell ring.
+	 */
+	refcount_inc(&ctx->refcnt);
+
 	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
 	if (err) {
+		refcount_dec(&ctx->refcnt);
 		dev_err(hwc->dev, "HWC: Failed to post send WQE: %d\n", err);
 		goto out;
 	}
@@ -1041,31 +1218,86 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 			dev_err(hwc->dev, "Command 0x%x timed out: %u ms\n",
 				command, hwc->hwc_timeout);
 
-		/* Reduce further waiting if HWC no response */
+		/* NULL out output_buf so a late handle_resp() won't write
+		 * into the caller's buffer after the sender returns, then
+		 * check whether handle_resp() already delivered a valid
+		 * response between the timeout firing and this lock
+		 * acquisition — ctx->error != -EINPROGRESS means it ran.
+		 */
+		spin_lock_irqsave(&ctx->lock, flags);
+		ctx->output_buf = NULL;
+		err = ctx->error;
+		status = ctx->status_code;
+		spin_unlock_irqrestore(&ctx->lock, flags);
+
+		if (err != -EINPROGRESS) {
+			/* handle_resp() delivered a valid response just after
+			 * the timeout fired.  The hardware is alive, so use the
+			 * response and leave the channel usable — do not latch
+			 * hwc_timed_out or degrade hwc_timeout for what turned
+			 * out to be a transient race.
+			 */
+			hwc_ctx_put(hwc, ctx);
+			goto check_status;
+		}
+
+		/* Genuine timeout: no response arrived.  Reduce further
+		 * waiting, and mark the channel timed out under the bitmap
+		 * lock so get_msg_index() cannot acquire new slots after this.
+		 */
 		if (hwc->hwc_timeout > 1)
 			hwc->hwc_timeout = 1;
 
+		spin_lock_irqsave(&hwc->inflight_msg_res.lock, flags);
+		hwc->hwc_timed_out = true;
+		spin_unlock_irqrestore(&hwc->inflight_msg_res.lock, flags);
+		wake_up_all(&hwc->msg_waitq);
+
 		err = -ETIMEDOUT;
-		goto out;
+		hwc_ctx_put(hwc, ctx);
+		goto done;
 	}
 
-	if (ctx->error) {
-		err = ctx->error;
-		goto out;
-	}
+	/* NULL output_buf so a late handle_resp() won't memcpy into
+	 * the caller's buffer after the sender exits.  Read error and
+	 * status_code under the same lock — after hwc_ctx_put the slot
+	 * may be reused and these fields overwritten.
+	 */
+	spin_lock_irqsave(&ctx->lock, flags);
+	ctx->output_buf = NULL;
+	err = ctx->error;
+	status = ctx->status_code;
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	hwc_ctx_put(hwc, ctx);
+
+check_status:
+	if (err)
+		goto done;
 
-	if (ctx->status_code && ctx->status_code != GDMA_STATUS_MORE_ENTRIES) {
-		if (ctx->status_code == GDMA_STATUS_CMD_UNSUPPORTED) {
+	if (status && status != GDMA_STATUS_MORE_ENTRIES) {
+		if (status == GDMA_STATUS_CMD_UNSUPPORTED) {
 			err = -EOPNOTSUPP;
-			goto out;
+			goto done;
 		}
+
 		if (command != MANA_QUERY_PHY_STAT)
 			dev_err(hwc->dev, "Command 0x%x failed with status: 0x%x\n",
-				command, ctx->status_code);
+				command, status);
 		err = -EPROTO;
-		goto out;
+		goto done;
 	}
+
+	err = 0;
+	goto done;
 out:
-	mana_hwc_put_msg_index(hwc, msg_id);
+	/* Pre-post error paths: no WQE was submitted so handle_resp()
+	 * cannot race here.  refcount is 1 (no second ref taken).
+	 */
+	ctx = hwc->caller_ctx + msg_id;
+	spin_lock_irqsave(&ctx->lock, flags);
+	ctx->output_buf = NULL;
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	hwc_ctx_put(hwc, ctx);
+done:
 	return err;
 }
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 9ca7cf523366..01e845237b6a 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -481,6 +481,21 @@ struct gdma_context {
 	/* Hardware communication channel (HWC) */
 	struct gdma_dev		hwc;
 
+	/* destroy_channel() waits here for all HWC senders to exit.
+	 * Lives on gc (not hwc) so wake_up() after the last sender's
+	 * atomic_dec doesn't dereference freed hwc memory.
+	 */
+	wait_queue_head_t	hwc_drain_waitq;
+
+	/* Serializes hwc.driver_data (the hw_channel_context pointer)
+	 * between the control-plane readers in mana_gd_send_request(),
+	 * mana_need_log() and mana_serv_reset() and the publish/clear in
+	 * mana_hwc_create_channel()/mana_hwc_destroy_channel().  All users
+	 * are control-plane (HWC commands sleep; reset runs on a workqueue),
+	 * so a plain spinlock -- not RCU -- is sufficient.
+	 */
+	spinlock_t		hwc_lock;
+
 	/* Azure network adapter */
 	struct gdma_dev		mana;
 
diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index 684dcec8e612..bc62d1ce7bd4 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -164,6 +164,9 @@ struct hwc_wq {
 	u16 queue_depth;
 
 	struct hwc_cq *hwc_cq;
+
+	/* Serializes concurrent mana_gd_post_and_ring() calls. */
+	spinlock_t lock;
 };
 
 struct hwc_caller_ctx {
@@ -173,6 +176,17 @@ struct hwc_caller_ctx {
 
 	u32 error; /* Linux error code */
 	u32 status_code;
+
+	/* Protects output_buf against concurrent access from
+	 * handle_resp() (CQ interrupt) and the sender timeout path.
+	 */
+	spinlock_t lock;
+
+	/* Tracks sender + handle_resp ownership.  The last put
+	 * (refcount reaches 0) releases the bitmap slot.
+	 */
+	refcount_t refcnt;
+	u16 msg_id;
 };
 
 struct hw_channel_context {
@@ -193,13 +207,24 @@ struct hw_channel_context {
 	struct hwc_wq *txq;
 	struct hwc_cq *cq;
 
-	struct semaphore sema;
 	struct gdma_resource inflight_msg_res;
+	/* Waitqueue for senders blocked on a full inflight bitmap. */
+	wait_queue_head_t msg_waitq;
 
 	u32 pf_dest_vrq_id;
 	u32 pf_dest_vrcq_id;
 	u32 hwc_timeout;
 
+	/* Set after channel is fully established; cleared on teardown to
+	 * abort waiters in mana_hwc_get_msg_index() and reject new sends.
+	 */
+	bool channel_up;
+
+	/* Set on first HWC timeout.  Causes get_msg_index() to return
+	 * -ETIMEDOUT instead of waiting, draining all queued senders.
+	 */
+	bool hwc_timed_out;
+
 	/* Set after mana_smc_setup_hwc() succeeds (hardware has active
 	 * MST entries).  On recoverable paths (establish_channel)
 	 * cleared only after successful teardown so a retry remains
@@ -208,6 +233,8 @@ struct hw_channel_context {
 	 */
 	bool setup_active;
 
+	atomic_t active_senders;
+
 	struct hwc_caller_ctx *caller_ctx;
 };
 
-- 
2.43.0


