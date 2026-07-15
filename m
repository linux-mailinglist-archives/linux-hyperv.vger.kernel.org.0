Return-Path: <linux-hyperv+bounces-11985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PrKpE5P/VmqBEAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11985-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:33:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD675A4C2
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11985-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11985-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B9C31349A4
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872D3ADB94;
	Wed, 15 Jul 2026 03:30:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159BA3AE1B4;
	Wed, 15 Jul 2026 03:30:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086227; cv=none; b=jpUZtse6jRofUNBpR/HEbRuM7pvqhj4L0giEX2U/4X7H5kL02IiSuOqAUcVAiU0kAXkCh5FtJrOHnL1VpCruYclADX1yzqchpjzUS3RLlr2faE6vIt1We3bIgziAsNa6BsqDZcuZWbtXROx9ICG1ZpBocnvpQIy+gb05JQnP+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086227; c=relaxed/simple;
	bh=fi6f805HbMZ9082j95m+67d/nZ2j9AQpOZt/QzumQ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSMxj8exglu3saQUI0n5OvdzOWsWI+5gKh2kNqY5PcX2TkfEgTiQsrt6EL61xc3veQgy5O8VJ3zmXgoaWoHGBGGTV31zX/qOfjAfBctJmqAl/tGD68d1RKWAre+cMtv4wOaurJbBAP6Jj7Z4kSvhDLB8fy0vJjSqjtg9N3eVMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 2B27320B7171; Tue, 14 Jul 2026 20:30:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B27320B7171
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
Subject: [PATCH net-next 7/7] net: mana: add dynamic HWC queue depth with reinit path
Date: Tue, 14 Jul 2026 20:29:41 -0700
Message-ID: <20260715032942.3945317-8-longli@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11985-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DBD675A4C2

The HWC is first established at a bootstrap queue depth of 1.  Query the
device's maximum supported depth and, if larger, tear down and rebuild
the HWC queues at that depth before re-establishing the channel, so more
management commands can be in flight.  Advertise
GDMA_DRV_CAP_FLAG_1_DYN_HWC_QUEUE_DEPTH so the firmware enables this only
when the driver supports it.

mana_hwc_destroy_queues() tears down the CQ first, which deregisters the
EQ IRQ (mana_gd_deregister_irq() + synchronize_rcu()) so no interrupt
handler can touch the queues, then the TXQ, RXQ and inflight resources.

Validate the device-reported dimensions before they size DMA
allocations: enforce the request/response header minimums, ensure
q_depth * max_msg_size plus alignment fits in u32, and cap CQ depth to
U16_MAX/2.  Carry the depth as u32 -- the device field is 24-bit, so
truncating to u16 on receipt could wrap a large value to a small depth
and silently pass these checks.

If reinit fails, fall back to the bootstrap-depth channel when its
teardown succeeded; if teardown also failed, hardware mappings may still
be active, so abort channel creation instead.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/hw_channel.c  | 223 +++++++++++++++++-
 include/net/mana/gdma.h                       |   4 +
 include/net/mana/hw_channel.h                 |   2 +-
 3 files changed, 218 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 9ba4e75a4dd3..3d0f17de3442 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -214,7 +214,12 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 			break;
 
 		case HWC_INIT_DATA_QUEUE_DEPTH:
-			hwc->hwc_init_q_depth_max = (u16)val;
+			/* HWC_INIT_DATA_QUEUE_DEPTH is a 24-bit field.  Keep
+			 * the full device-reported value here; it is clamped
+			 * and validated in mana_hwc_create_channel() rather
+			 * than silently truncated to u16.
+			 */
+			hwc->hwc_init_q_depth_max = val;
 			break;
 
 		case HWC_INIT_DATA_MAX_REQUEST:
@@ -784,7 +789,7 @@ static int mana_hwc_test_channel(struct hw_channel_context *hwc, u16 q_depth,
 	return err;
 }
 
-static int mana_hwc_establish_channel(struct gdma_context *gc, u16 *q_depth,
+static int mana_hwc_establish_channel(struct gdma_context *gc, u32 *q_depth,
 				      u32 *max_req_msg_size,
 				      u32 *max_resp_msg_size)
 {
@@ -862,6 +867,12 @@ static int mana_hwc_init_queues(struct hw_channel_context *hwc, u16 q_depth,
 {
 	int err;
 
+	/* CQ depth is q_depth * 2 (SQ + RQ) passed as u16 to create_cq.
+	 * Cap to prevent u16 truncation.
+	 */
+	if (q_depth > U16_MAX / 2)
+		q_depth = U16_MAX / 2;
+
 	err = mana_hwc_init_inflight_msg(hwc, q_depth);
 	if (err)
 		return err;
@@ -902,13 +913,62 @@ static int mana_hwc_init_queues(struct hw_channel_context *hwc, u16 q_depth,
 	return err;
 }
 
+/* Tear down all HWC queues and free associated resources.  Used on
+ * the reinit-with-higher-queue-depth path and reinit fallback.
+ *
+ * PRECONDITION: must be called only during channel bring-up in
+ * mana_hwc_create_channel(), before the channel is published to
+ * senders.  There the setup thread is effectively single-threaded
+ * (serialized against teardown by the PCI/PM device_lock or, on the
+ * service path, GC_IN_SERVICE, with the data path not yet probed),
+ * channel_up is still false, caller_ctx is not yet allocated, and
+ * active_senders is 0 — so no concurrent request/response user can
+ * touch these queues.  That is why this skips the hwc_lock-protected
+ * driver_data clear + active_senders drain that
+ * mana_hwc_destroy_channel() needs for the runtime teardown race;
+ * only the CQ-first ordering below (to fence off a pending interrupt)
+ * is required.  Calling this on a live, published channel would be a
+ * use-after-free.
+ */
+static void mana_hwc_destroy_queues(struct hw_channel_context *hwc)
+{
+	struct gdma_context *gc = hwc->gdma_dev->gdma_context;
+
+	/* Destroy CQ first to deregister the EQ from the interrupt
+	 * handler list before freeing caller_ctx, TXQ, or RXQ memory.
+	 * A pending interrupt handler could still reach handle_resp()
+	 * which dereferences caller_ctx.
+	 */
+	if (hwc->cq) {
+		mana_hwc_destroy_cq(gc, hwc->cq);
+		hwc->cq = NULL;
+	}
+
+	kfree(hwc->caller_ctx);
+	hwc->caller_ctx = NULL;
+
+	if (hwc->txq) {
+		mana_hwc_destroy_wq(hwc, hwc->txq);
+		hwc->txq = NULL;
+	}
+
+	if (hwc->rxq) {
+		mana_hwc_destroy_wq(hwc, hwc->rxq);
+		hwc->rxq = NULL;
+	}
+
+	mana_gd_free_res_map(&hwc->inflight_msg_res);
+	hwc->num_inflight_msg = 0;
+}
+
 int mana_hwc_create_channel(struct gdma_context *gc)
 {
 	u32 max_req_msg_size, max_resp_msg_size;
 	struct gdma_dev *gd = &gc->hwc;
 	struct hw_channel_context *hwc;
+	struct gdma_queue __rcu **old_cq_table;
 	unsigned long flags;
-	u16 q_depth_max;
+	u32 q_depth_max;
 	int err;
 
 	hwc = kzalloc_obj(*hwc);
@@ -956,8 +1016,130 @@ int mana_hwc_create_channel(struct gdma_context *gc)
 		goto out;
 	}
 
+	/* The channel was bootstrapped at a minimal queue depth.  If the
+	 * device reports a higher maximum, tear down and rebuild with
+	 * the larger depth so more HWC commands can be in flight.
+	 */
+	if (q_depth_max > HW_CHANNEL_VF_BOOTSTRAP_QUEUE_DEPTH) {
+		/* q_depth_max now carries the full device-reported value
+		 * (HWC_INIT_DATA_QUEUE_DEPTH is 24-bit).  Clamp it to the
+		 * depth the rest of the driver supports — create_cq() takes
+		 * q_depth * 2 as a u16 — before the overflow check below, so
+		 * an over-large but otherwise-valid depth is reduced to the
+		 * maximum instead of wrapping or being rejected.
+		 */
+		if (q_depth_max > U16_MAX / 2)
+			q_depth_max = U16_MAX / 2;
+
+		/* Sanity-check device-reported values before using them
+		 * to size DMA allocations.  Enforce protocol minimums
+		 * for message sizes and check that q_depth * max_msg_size
+		 * plus alignment headroom fits in u32 (for
+		 * mana_hwc_alloc_dma_buf's MANA_PAGE_ALIGN).
+		 */
+		if (!max_req_msg_size || !max_resp_msg_size ||
+		    max_req_msg_size < sizeof(struct gdma_req_hdr) ||
+		    max_resp_msg_size < sizeof(struct gdma_resp_hdr) ||
+		    (u64)q_depth_max * max_req_msg_size >
+			U32_MAX - MANA_PAGE_SIZE ||
+		    (u64)q_depth_max * max_resp_msg_size >
+			U32_MAX - MANA_PAGE_SIZE) {
+			dev_err(hwc->dev,
+				"HWC: invalid dims q=%u req=%u resp=%u\n",
+				q_depth_max, max_req_msg_size,
+				max_resp_msg_size);
+			q_depth_max = HW_CHANNEL_VF_BOOTSTRAP_QUEUE_DEPTH;
+			goto skip_reinit;
+		}
+
+		err = mana_smc_teardown_hwc(&gc->shm_channel, false);
+		if (err) {
+			/* Keep using the bootstrap-depth channel. */
+			dev_err(hwc->dev,
+				"Failed to teardown HWC for reinit: %d\n",
+				err);
+			q_depth_max = HW_CHANNEL_VF_BOOTSTRAP_QUEUE_DEPTH;
+			goto skip_reinit;
+		}
+
+		hwc->setup_active = false;
+
+		/* Destroy queues first — mana_gd_destroy_cq inside
+		 * unpublishes the CQ from cq_table via
+		 * rcu_assign_pointer(NULL) + synchronize_rcu.
+		 * Must happen while cq_table is still valid.
+		 */
+		mana_hwc_destroy_queues(hwc);
+
+		old_cq_table = rcu_replace_pointer(gc->cq_table, NULL, true);
+		synchronize_rcu();
+		vfree(old_cq_table);
+
+		err = mana_hwc_init_queues(hwc, q_depth_max,
+					   max_req_msg_size,
+					   max_resp_msg_size);
+		if (err) {
+			dev_err(hwc->dev, "Failed to reinit HWC: %d\n", err);
+			goto reinit_fallback;
+		}
+
+		err = mana_hwc_establish_channel(gc, &q_depth_max,
+						 &max_req_msg_size,
+						 &max_resp_msg_size);
+		if (err) {
+			dev_err(hwc->dev, "Failed to re-establish HWC: %d\n",
+				err);
+			/* establish_channel does internal teardown on
+			 * failure.  If teardown succeeded (setup_active
+			 * cleared), MST entries are invalidated and we
+			 * can try the bootstrap fallback.  If teardown
+			 * also failed (setup_active still set), hardware
+			 * mappings may still be active — skip fallback.
+			 */
+			if (hwc->setup_active)
+				goto out;
+			goto reinit_fallback;
+		}
+	}
+
+	goto skip_reinit;
+
+reinit_fallback:
+	/* Restore bootstrap-depth channel so the device remains functional.
+	 * Free cq_table if it was allocated by a partially successful
+	 * establish attempt.
+	 */
+	dev_warn(hwc->dev, "HWC reinit failed, falling back to bootstrap depth\n");
+
+	mana_hwc_destroy_queues(hwc);
+
+	old_cq_table = rcu_replace_pointer(gc->cq_table, NULL, true);
+	synchronize_rcu();
+	vfree(old_cq_table);
+
+	err = mana_hwc_init_queues(hwc, HW_CHANNEL_VF_BOOTSTRAP_QUEUE_DEPTH,
+				   HW_CHANNEL_MAX_REQUEST_SIZE,
+				   HW_CHANNEL_MAX_RESPONSE_SIZE);
+	if (err) {
+		dev_err(hwc->dev, "Failed to restore bootstrap HWC: %d\n", err);
+		goto out;
+	}
+
+	err = mana_hwc_establish_channel(gc, &q_depth_max, &max_req_msg_size,
+					 &max_resp_msg_size);
+	if (err) {
+		dev_err(hwc->dev, "Failed to re-establish bootstrap HWC: %d\n",
+			err);
+		goto out;
+	}
+
+skip_reinit:
+
+	/* No RCU needed: still in mana_hwc_create_channel, the
+	 * pointer has not been published to concurrent senders yet.
+	 */
 	err = mana_hwc_test_channel(gc->hwc.driver_data,
-				    HW_CHANNEL_VF_BOOTSTRAP_QUEUE_DEPTH,
+				    hwc->num_inflight_msg,
 				    max_req_msg_size, max_resp_msg_size);
 	if (err) {
 		dev_err(hwc->dev, "Failed to test HWC: %d\n", err);
@@ -972,6 +1154,10 @@ int mana_hwc_create_channel(struct gdma_context *gc)
 
 void mana_hwc_destroy_channel(struct gdma_context *gc)
 {
+	/* This is the only destroy entry point.  driver_data is read
+	 * plainly here (teardown is serialised against other teardown);
+	 * it is cleared under hwc_lock below before hwc is freed.
+	 */
 	struct hw_channel_context *hwc = gc->hwc.driver_data;
 	struct gdma_queue __rcu **old_cq_table;
 	unsigned long flags;
@@ -1011,10 +1197,21 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	 * on the init EQE arriving.
 	 *
 	 * The return value is intentionally not checked.  This is the
-	 * terminal cleanup path — resources must be freed regardless.
-	 * If teardown fails, hardware may still have active MST entries,
-	 * but the EQ deregistration and IOMMU unmapping below prevent
-	 * stale hardware accesses from reaching kernel memory.
+	 * terminal cleanup path (device removal, suspend, or init
+	 * failure) — resources must be freed regardless.  If teardown
+	 * fails, hardware may still have active MST entries, but:
+	 *
+	 *  - Interrupts: mana_hwc_destroy_cq() below calls
+	 *    mana_gd_deregister_irq() which removes the HWC EQ from
+	 *    the interrupt dispatch list via list_del_rcu() +
+	 *    synchronize_rcu().  After that, no interrupt handler can
+	 *    invoke handle_resp() or access CQ/RQ buffers — even if
+	 *    the IRQ is shared with data path queues.
+	 *
+	 *  - DMA: mana_hwc_destroy_wq() frees DMA buffers via
+	 *    dma_free_coherent() which unmaps the IOVA from the
+	 *    IOMMU.  Any stale hardware DMA to the old address
+	 *    faults at the IOMMU, not in kernel memory.
 	 */
 	if (hwc->setup_active) {
 		int td_err = mana_smc_teardown_hwc(&gc->shm_channel, false);
@@ -1042,6 +1239,9 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 				 * them (unsafe).
 				 *
 				 * but leak all DMA buffers to prevent corruption.
+				 * Also leak the EQ IRQ registration since freeing
+				 * it safely requires accessing queue structures we're
+				 * leaving allocated.
 				 */
 
 				dev_warn(gc->dev,
@@ -1061,8 +1261,11 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	}
 
 	/* After SMC teardown, no more hardware events should arrive.
-	 * Force-complete any remaining in-flight senders so they can
-	 * exit and drop their refs.
+	 * If teardown failed, handle_resp() may still race with this
+	 * loop via a late interrupt — this is safe because the per-slot
+	 * refcount model tolerates a concurrent complete() and both
+	 * paths (handle_resp and this loop) will correctly drop their
+	 * respective refs without double-releasing the slot.
 	 */
 	if (hwc->caller_ctx) {
 		struct hwc_caller_ctx *ctx;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 01e845237b6a..a4eac6f7c366 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -708,6 +708,9 @@ enum {
 /* Driver supports dynamic interrupt moderation - DIM */
 #define GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(28)
 
+/* Driver supports dynamic queue depth for HWC */
+#define GDMA_DRV_CAP_FLAG_1_DYN_HWC_QUEUE_DEPTH BIT(29)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -723,6 +726,7 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_DYN_HWC_QUEUE_DEPTH | \
 	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)
 
diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index bc62d1ce7bd4..fb9725e30c8c 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -197,7 +197,7 @@ struct hw_channel_context {
 	u32 max_req_msg_size;
 	u32 max_resp_msg_size;
 
-	u16 hwc_init_q_depth_max;
+	u32 hwc_init_q_depth_max;
 	u32 hwc_init_max_req_msg_size;
 	u32 hwc_init_max_resp_msg_size;
 
-- 
2.43.0


