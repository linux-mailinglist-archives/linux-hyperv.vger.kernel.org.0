Return-Path: <linux-hyperv+bounces-9774-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE3JEGY6xGnkxQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9774-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 20:41:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D3B32B5D4
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 20:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F8D0301BA9C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9FA359A65;
	Wed, 25 Mar 2026 19:41:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D032B331A41;
	Wed, 25 Mar 2026 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467664; cv=none; b=A28mP8M8BpKa5YyHyELlsabKuCGFwnSMff02/pjdRY9ZRxbDm8eqczsL/Wftde0DQ0xuburRTupY4gNYcpQv/Untxsy3HWhmAdnudCXtzEa2J3IuegMooM43gTkiiozZwfnub4nKmX6Qz8kJcz9kPatZH8NpjLi243mAU2vjfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467664; c=relaxed/simple;
	bh=BqKYKxS+fD+Li5X4iSypVe7kEkWxNLBgTnD+rUHOmzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EzpaMMZoK+DGoyV0TTeTCMam5tqJJ/8WOLeQ4wneTJG2iM7qNI+ipPIHdRKj0u7DBuUh2qFExJfH+N6Gy8VHPVGDae49O1MkCGlVY1FtSxg4qYWDSuLHW7mqA0cWe8qeHbTkrEtMuPfQlS90HPPF1+avEj2X+q0Y6BRf64+NQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id B0ADB20B710C; Wed, 25 Mar 2026 12:41:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0ADB20B710C
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
	Dexuan Cui <decui@microsoft.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH rdma v3] RDMA/mana_ib: Disable RX steering on RSS QP destroy
Date: Wed, 25 Mar 2026 12:40:57 -0700
Message-ID: <20260325194100.1929056-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9774-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2D3B32B5D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an RSS QP is destroyed (e.g. DPDK exit), mana_ib_destroy_qp_rss()
destroys the RX WQ objects but does not disable vPort RX steering in
firmware. This leaves stale steering configuration that still points to
the destroyed RX objects.

If traffic continues to arrive (e.g. peer VM is still transmitting) and
the VF interface is subsequently brought up (mana_open), the firmware
may deliver completions using stale CQ IDs from the old RX objects.
These CQ IDs can be reused by the ethernet driver for new TX CQs,
causing RX completions to land on TX CQs:

  WARNING: mana_poll_tx_cq+0x1b8/0x220 [mana]  (is_sq == false)
  WARNING: mana_gd_process_eq_events+0x209/0x290 (cq_table lookup fails)

Fix this by disabling vPort RX steering before destroying RX WQ objects.
Note that mana_fence_rqs() cannot be used here because the fence
completion is delivered on the CQ, which is polled by user-mode (e.g.
DPDK) and not visible to the kernel driver.

Refactor the disable logic into a shared mana_disable_vport_rx() in
mana_en, exported for use by mana_ib, replacing the duplicate code.
The ethernet driver's mana_dealloc_queues() is also updated to call
this common function.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
---
v3:
- Rebased onto rdma for-rc.

v2:
- Removed redundant ibdev_err on mana_disable_vport_rx() failure
  as mana_cfg_vport_steering() already logs all failure scenarios.
- Added comment clarifying this is best effort.

 drivers/infiniband/hw/mana/qp.c               | 15 +++++++++++++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 11 ++++++++++-
 include/net/mana/mana.h                       |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad..c8a7129bb 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -822,6 +822,21 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
 
+	/* Disable vPort RX steering before destroying RX WQ objects.
+	 * Otherwise firmware still routes traffic to the destroyed queues,
+	 * which can cause bogus completions on reused CQ IDs when the
+	 * ethernet driver later creates new queues on mana_open().
+	 *
+	 * Unlike the ethernet teardown path, mana_fence_rqs() cannot be
+	 * used here because the fence completion CQE is delivered on the
+	 * CQ which is polled by userspace (e.g. DPDK), so there is no way
+	 * for the kernel to wait for fence completion.
+	 *
+	 * This is best effort — if it fails there is not much we can do,
+	 * and mana_cfg_vport_steering() already logs the error.
+	 */
+	mana_disable_vport_rx(mpc);
+
 	for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
 		ibwq = ind_tbl->ind_tbl[i];
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 933e9d681..e4268bf2f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2869,6 +2869,13 @@ static void mana_rss_table_init(struct mana_port_context *apc)
 			ethtool_rxfh_indir_default(i, apc->num_queues);
 }
 
+int mana_disable_vport_rx(struct mana_port_context *apc)
+{
+	return mana_cfg_vport_steering(apc, TRI_STATE_FALSE, false, false,
+				       false);
+}
+EXPORT_SYMBOL_NS(mana_disable_vport_rx, "NET_MANA");
+
 int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 		    bool update_hash, bool update_tab)
 {
@@ -3253,10 +3260,12 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 */
 
 	apc->rss_state = TRI_STATE_FALSE;
-	err = mana_config_rss(apc, TRI_STATE_FALSE, false, false);
+	err = mana_disable_vport_rx(apc);
 	if (err && mana_en_need_log(apc, err))
 		netdev_err(ndev, "Failed to disable vPort: %d\n", err);
 
+	mana_fence_rqs(apc);
+
 	/* Even in err case, still need to cleanup the vPort */
 	mana_destroy_vport(apc);
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a078af283..743bfa8ad 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -568,6 +568,7 @@ struct mana_port_context {
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 int mana_config_rss(struct mana_port_context *ac, enum TRI_STATE rx,
 		    bool update_hash, bool update_tab);
+int mana_disable_vport_rx(struct mana_port_context *apc);
 
 int mana_alloc_queues(struct net_device *ndev);
 int mana_attach(struct net_device *ndev);
-- 
2.43.0


