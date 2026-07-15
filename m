Return-Path: <linux-hyperv+bounces-11983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TaOxGW//Vmp+EAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11983-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:33:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D175A4B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11983-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11983-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B8D312A9C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3317B3ADB94;
	Wed, 15 Jul 2026 03:30:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD93A7F7A;
	Wed, 15 Jul 2026 03:30:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086216; cv=none; b=Jehfu1h75pgQOsl/LasKVQyAFONIeo6UldHwOEYsJPBwzbyU6A0mx9bTfAU7s8isk8xitJf3G45PAUpMXy9GlERjmAQW6kQnDaTqEo7pqSITWdP+N7eQb2jzFdho16upF6mggYbCL/EdhnX03m1/WkB0geU+ZbzbYWeqbqRXLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086216; c=relaxed/simple;
	bh=2zJR6uxy0j0AruNUd8uJFxVj6MIqqnp1SzBCRWyjCYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUtM6DFB0mMLv30IUtt+aG5KD7HHKQGFug50Em8FsSrLcRFfXbQRJU6qkWtrj4rt+mqp7mrFKzUSpu9WjDsRoGgvY9y1xNa8c2E0KMGZ4i0XAHe9eTVMKhITmgqpgvN6hb8nSkManAYRBxVNamWUReRuw/0yoTQLSxRqENs/m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 4FA5120B716B; Tue, 14 Jul 2026 20:30:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FA5120B716B
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
Subject: [PATCH net-next 5/7] net: mana: fix HWC teardown safety with setup_active flag and destroy ordering
Date: Tue, 14 Jul 2026 20:29:39 -0700
Message-ID: <20260715032942.3945317-6-longli@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11983-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: B11D175A4B9

Two teardown hazards let the hardware touch memory the driver freed.

First, once mana_smc_setup_hwc() succeeds the device has active MST
entries and can DMA into the HWC queue buffers.  If a later step in
mana_hwc_establish_channel() fails, the caller had no reliable way to
know teardown was required and could free those buffers while the
mappings were still live -- a DMA-after-free.  max_num_cqs was used as a
"HWC is up" proxy, but it is only set when the init EQE arrives.

Add a setup_active flag, set the moment setup_hwc activates MST entries.
establish_channel() now tears down on any later failure and clears
setup_active once teardown succeeds; destroy_channel() gates teardown on
setup_active.  max_num_cqs is no longer reset: it is an immutable bound
(see gdma.h) and cq_table == NULL is the sole teardown signal.

Second, destroy_channel() freed the TXQ/RXQ buffers while the HWC EQ was
still on the interrupt dispatch list, so an in-flight interrupt could run
the handler against freed buffers:

  CPU A (mana_gd_intr, hard IRQ)        CPU B (destroy_channel)
  ----------------------------------    ------------------------------
                                        free TXQ/RXQ DMA buffers
  handler accesses RQ/TXQ buffers       (EQ still registered)

Destroy the CQ first: mana_hwc_destroy_cq() -> mana_gd_deregister_irq()
removes the EQ via list_del_rcu() + synchronize_rcu(), after which no
handler can reach the queues; only then free the TXQ and RXQ.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/hw_channel.c  | 106 ++++++++++++++----
 include/net/mana/gdma.h                       |   8 +-
 include/net/mana/hw_channel.h                 |   8 ++
 3 files changed, 100 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 68236727aee8..b26c2122ebf5 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -4,6 +4,7 @@
 #include <net/mana/gdma.h>
 #include <net/mana/mana.h>
 #include <net/mana/hw_channel.h>
+#include <linux/pci.h>
 #include <linux/vmalloc.h>
 
 static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *msg_id)
@@ -744,20 +745,33 @@ static int mana_hwc_establish_channel(struct gdma_context *gc, u16 *q_depth,
 	if (err)
 		return err;
 
-	if (!wait_for_completion_timeout(&hwc->hwc_init_eqe_comp, 60 * HZ))
-		return -ETIMEDOUT;
+	/* setup_hwc activated MST entries — hardware can now DMA into
+	 * our queue buffers.  If anything below fails, we must tear
+	 * down before returning so the caller doesn't need to track
+	 * whether setup_hwc succeeded.
+	 */
+	hwc->setup_active = true;
+
+	if (!wait_for_completion_timeout(&hwc->hwc_init_eqe_comp, 60 * HZ)) {
+		err = -ETIMEDOUT;
+		goto teardown;
+	}
 
 	*q_depth = hwc->hwc_init_q_depth_max;
 	*max_req_msg_size = hwc->hwc_init_max_req_msg_size;
 	*max_resp_msg_size = hwc->hwc_init_max_resp_msg_size;
 
 	/* Both were set in mana_hwc_init_event_handler(). */
-	if (WARN_ON(cq->id >= gc->max_num_cqs))
-		return -EPROTO;
+	if (WARN_ON(cq->id >= gc->max_num_cqs)) {
+		err = -EPROTO;
+		goto teardown;
+	}
 
 	cq_table = vcalloc(gc->max_num_cqs, sizeof(*cq_table));
-	if (!cq_table)
-		return -ENOMEM;
+	if (!cq_table) {
+		err = -ENOMEM;
+		goto teardown;
+	}
 
 	rcu_assign_pointer(cq_table[cq->id], cq);
 	/* Publish the fully-initialised table last; pairs with the
@@ -766,6 +780,16 @@ static int mana_hwc_establish_channel(struct gdma_context *gc, u16 *q_depth,
 	rcu_assign_pointer(gc->cq_table, cq_table);
 
 	return 0;
+
+teardown:
+	{
+		int td_err = mana_smc_teardown_hwc(&gc->shm_channel, false);
+
+		if (!td_err)
+			hwc->setup_active = false;
+
+		return td_err ? td_err : err;
+	}
 }
 
 static int mana_hwc_init_queues(struct hw_channel_context *hwc, u16 q_depth,
@@ -878,11 +902,62 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	if (!hwc)
 		return;
 
-	/* gc->max_num_cqs is set in mana_hwc_init_event_handler(). If it's
-	 * non-zero, the HWC worked and we should tear down the HWC here.
+	/* Tear down the HWC if setup_hwc previously activated MST entries.
+	 * This is the definitive flag — unlike max_num_cqs which depends
+	 * on the init EQE arriving.
 	 */
-	if (gc->max_num_cqs > 0)
-		mana_smc_teardown_hwc(&gc->shm_channel, false);
+	if (hwc->setup_active) {
+		int td_err = mana_smc_teardown_hwc(&gc->shm_channel, false);
+
+		if (td_err) {
+			dev_err(gc->dev, "HWC teardown failed: %d, issuing FLR\n",
+				td_err);
+
+			/* On systems without IOMMU, freeing DMA memory with
+			 * active hardware MST mappings risks memory corruption.
+			 * Issue FLR to force-reset the device and invalidate
+			 * all hardware state including MST entries.
+			 */
+			td_err = pcie_flr(to_pci_dev(gc->dev));
+			if (td_err) {
+				/* Device is wedged: teardown and FLR both failed.
+				 * Hardware may still have active MST entries that
+				 * allow DMA into our queue buffers.
+				 *
+				 * On IOMMU systems: dma_free_coherent() would unmap
+				 * the IOVA, causing hardware DMA to fault at the
+				 * IOMMU (safe). But on non-IOMMU systems, freeing
+				 * the physical pages allows them to be reused for
+				 * other purposes while hardware can still DMA to
+				 * them (unsafe).
+				 *
+				 * but leak all DMA buffers to prevent corruption.
+				 */
+
+				dev_warn(gc->dev,
+					 "Leaked HWC DMA buffers (CQ/RQ/TXQ) to prevent memory corruption. Device is no longer usable.\n");
+
+				/* Do NOT proceed to mana_hwc_destroy_cq/wq — they
+				 * would call dma_free_coherent().  Leave hwc, cq,
+				 * rxq, txq allocated forever.
+				 */
+				return;
+			}
+
+			dev_info(gc->dev, "FLR succeeded, hardware state cleared\n");
+		}
+
+		hwc->setup_active = false;
+	}
+
+	/* Tear down the HWC CQ object first — mana_hwc_destroy_cq()
+	 * both unpublishes the CQ from cq_table (+synchronize_rcu) and
+	 * deregisters the HWC EQ from the interrupt handler list (via
+	 * mana_gd_deregister_irq + synchronize_rcu), guaranteeing no
+	 * interrupt handler can access RQ/TXQ buffers after this point.
+	 */
+	if (hwc->cq)
+		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
 
 	if (hwc->txq)
 		mana_hwc_destroy_wq(hwc, hwc->txq);
@@ -890,17 +965,6 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	if (hwc->rxq)
 		mana_hwc_destroy_wq(hwc, hwc->rxq);
 
-	if (hwc->cq)
-		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
-
-	/* Reset only after mana_hwc_destroy_cq() above has run with a valid
-	 * max_num_cqs so mana_gd_destroy_cq() clears the CQ table slot and
-	 * waits out in-flight EQ handlers (synchronize_rcu) before the CQ is
-	 * freed.  Clearing it earlier would make that path early-return and
-	 * skip the slot clear, leaving a dangling cq_table entry.
-	 */
-	gc->max_num_cqs = 0;
-
 	kfree(hwc->caller_ctx);
 	hwc->caller_ctx = NULL;
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index da52701e7816..9ca7cf523366 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -428,7 +428,13 @@ struct gdma_context {
 	/* L2 MTU */
 	u16 adapter_mtu;
 
-	/* This maps a CQ index to the queue structure. */
+	/* Size of cq_table, i.e. the largest valid CQ index + 1.  Set once
+	 * when cq_table is allocated and treated as immutable for the
+	 * table's lifetime (a bound only) -- it is never reset on teardown.
+	 * cq_table == NULL is the sole "table torn down" signal, so every
+	 * cq_table[id] access must guard with both !cq_table (gone) and
+	 * id >= max_num_cqs (out of bounds).
+	 */
 	unsigned int		max_num_cqs;
 	/* Both the base pointer and each entry are RCU-managed.  The fast
 	 * path (mana_gd_process_eqe) reads the base via rcu_dereference()
diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index 73671f479399..684dcec8e612 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -200,6 +200,14 @@ struct hw_channel_context {
 	u32 pf_dest_vrcq_id;
 	u32 hwc_timeout;
 
+	/* Set after mana_smc_setup_hwc() succeeds (hardware has active
+	 * MST entries).  On recoverable paths (establish_channel)
+	 * cleared only after successful teardown so a retry remains
+	 * possible.  On the terminal destroy_channel path, cleared
+	 * unconditionally since hwc is about to be freed.
+	 */
+	bool setup_active;
+
 	struct hwc_caller_ctx *caller_ctx;
 };
 
-- 
2.43.0


