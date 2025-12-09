Return-Path: <linux-hyperv+bounces-7995-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69639CAE813
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Dec 2025 01:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8724D300E76F
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Dec 2025 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287F28032D;
	Tue,  9 Dec 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apD7uGpH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5028000C;
	Tue,  9 Dec 2025 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239469; cv=none; b=Ec1orvT9TpEzFxZGiIXJSgey7pouy673IOT90fI7eQ9rXiWk4BYjsMy/evFJXe6T4sIVf1EJ3EPAdywfrX7bh9jyBzhakTtqvbhyFINaRRsE2aS0R9DFRAq8ekQUlvDeQCgxZdKskjyZe/R2FwBtpGAajljKEespyB4bow7XB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239469; c=relaxed/simple;
	bh=s/QEWSZlzMtdYQhFb4Tcru5e4lkOHkbEjgrWsByZkp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klDBTdry/7Z8Iwe1dnoHGCleWUKskETuHrJemwpkRR6oDgnmZjJdlOFpGO8EP0WeJFftDxAdCzRbpVFgyPmhEhZcsRPg7Gsj/fnzOUWbGaI1jIX/JxqP0m4TtGjdqmCcBu8Dg7gtTdKfGkgOE2beMMxWs5S2JT5bCPjlDBmt/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apD7uGpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53262C4CEF1;
	Tue,  9 Dec 2025 00:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239467;
	bh=s/QEWSZlzMtdYQhFb4Tcru5e4lkOHkbEjgrWsByZkp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apD7uGpHW2vh+ajGy7NpltPtgqS3TTz56uQzkva+hk10WMGobaWGp38c01U12Bl0S
	 Q3vnZKgGKd7nlzB+k3Gj3kJiRBcz0uGF+sP9aUV25nIUZHKTzf4DCqQaHfXY+wyeyp
	 7Fc84AkoHF56+G52QVuAlcMyYuAV/6k7b3rcMJBENDEEnA0s4DrfhbQ8uXqEDUdWqQ
	 rFt35mTU2/zAE2AMNIJ1irHtX7iAUscdHiYY3HeiSu4Yw59e2GVJENDR0XfnjC5ZUb
	 mRaTyjQ8ZIgZUIIGefNlsRm65h790p2/zxkIqbQhMCUiJxPabDF7h7jhp7rijbSsS8
	 +jsoCN997lWMQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Aditya Garg <gargaditya@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	leon@kernel.org,
	shradhagupta@linux.microsoft.com,
	mlevitsk@redhat.com,
	ernis@linux.microsoft.com,
	yury.norov@gmail.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] net: mana: Drop TX skb on post_work_request failure and unmap resources
Date: Mon,  8 Dec 2025 19:15:21 -0500
Message-ID: <20251209001610.611575-29-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aditya Garg <gargaditya@linux.microsoft.com>

[ Upstream commit 45120304e84171fd215c1b57b15b285446d15106 ]

Drop TX packets when posting the work request fails and ensure DMA
mappings are always cleaned up.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Link: https://patch.msgid.link/1763464269-10431-3-git-send-email-gargaditya@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Looking at this commit, I need to analyze it for stable backporting
suitability.

## Commit Analysis

### What the commit does:

1. **In `mana_en.c`**: When `mana_gd_post_work_request()` fails during
   TX:
   - Previously: returned `NETDEV_TX_BUSY` without cleaning up DMA
     mappings
   - Now: calls `mana_unmap_skb()` to clean up DMA mappings, then drops
     the packet properly

2. **In `gdma_main.c`**: Removes a noisy `dev_err` message for flow
   control failure

3. **In `mana.h`**: Exports `mana_unmap_skb()` function for use across
   files

### Bug Being Fixed

Looking at the original error path:
```c
if (err) {
    (void)skb_dequeue_tail(&txq->pending_skbs);
    netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
    err = NETDEV_TX_BUSY;
    goto tx_busy;  // DMA mappings NOT unmapped!
}
```

The original code has **two bugs**:
1. **DMA resource leak**: When `mana_gd_post_work_request()` fails, the
   DMA mappings set up earlier (via `mana_map_skb()`) are never freed
2. **Improper error handling**: Returns `NETDEV_TX_BUSY` which tells the
   network stack to retry, but the skb was already dequeued from
   `pending_skbs`, leading to inconsistent state

### Code Change Assessment

The fix is straightforward and surgical:
```c
if (err) {
    (void)skb_dequeue_tail(&txq->pending_skbs);
    mana_unmap_skb(skb, apc);  // NEW: Clean up DMA mappings
    netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
    goto free_sgl_ptr;  // Drop packet properly
}
```

### Stable Criteria Evaluation

| Criterion | Assessment |
|-----------|------------|
| Fixes real bug | ✅ Yes - DMA resource leak and improper error handling
|
| Obviously correct | ✅ Yes - unmapping DMA on error is clearly correct
|
| Small and contained | ✅ Yes - only affects error path in MANA driver |
| No new features | ✅ Yes - pure bug fix |
| User impact | ✅ Medium-high - affects Azure VM users; leaks can cause
long-term instability |

### Risk Assessment

- **Low risk**: Changes only affect the TX error path
- **Self-contained**: The `mana_unmap_skb()` function already exists,
  just made non-static
- **No dependencies**: This commit is standalone
- **Well-tested**: Has "Reviewed-by" tag from Microsoft maintainer

### Missing Signals

- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag

However, this is clearly fixing a resource leak bug that has existed
since the error path was written. Resource leaks in network drivers are
exactly the kind of bugs stable trees should fix.

### User Impact

The MANA driver is used in Microsoft Azure VMs. DMA mapping leaks:
- Cause memory pressure over time
- Can lead to allocation failures under sustained TX errors
- May cause VM instability in production cloud environments

This is a production-relevant bug affecting real cloud users.

### Conclusion

This commit fixes a genuine resource leak bug in the MANA network
driver. The fix is:
- Small (adds one function call + declaration)
- Surgical (only affects error path)
- Obviously correct (unmapping DMA on error is mandatory)
- Low risk (doesn't touch normal TX path)
- Important for production Azure VM users

The lack of stable/Fixes tags is unfortunate but doesn't diminish the
clear bug-fix nature of this change.

**YES**

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 6 +-----
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 7 +++----
 include/net/mana/mana.h                         | 1 +
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 43f034e180c41..7d232ac250958 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1299,7 +1299,6 @@ int mana_gd_post_work_request(struct gdma_queue *wq,
 			      struct gdma_posted_wqe_info *wqe_info)
 {
 	u32 client_oob_size = wqe_req->inline_oob_size;
-	struct gdma_context *gc;
 	u32 sgl_data_size;
 	u32 max_wqe_size;
 	u32 wqe_size;
@@ -1329,11 +1328,8 @@ int mana_gd_post_work_request(struct gdma_queue *wq,
 	if (wqe_size > max_wqe_size)
 		return -EINVAL;
 
-	if (wq->monitor_avl_buf && wqe_size > mana_gd_wq_avail_space(wq)) {
-		gc = wq->gdma_dev->gdma_context;
-		dev_err(gc->dev, "unsuccessful flow control!\n");
+	if (wq->monitor_avl_buf && wqe_size > mana_gd_wq_avail_space(wq))
 		return -ENOSPC;
-	}
 
 	if (wqe_info)
 		wqe_info->wqe_size_in_bu = wqe_size / GDMA_WQE_BU_SIZE;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0142fd98392c2..6d37f39930453 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -438,9 +438,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	if (err) {
 		(void)skb_dequeue_tail(&txq->pending_skbs);
+		mana_unmap_skb(skb, apc);
 		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
-		err = NETDEV_TX_BUSY;
-		goto tx_busy;
+		goto free_sgl_ptr;
 	}
 
 	err = NETDEV_TX_OK;
@@ -460,7 +460,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_stats->bytes += len + ((num_gso_seg - 1) * gso_hs);
 	u64_stats_update_end(&tx_stats->syncp);
 
-tx_busy:
 	if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
 		netif_tx_wake_queue(net_txq);
 		apc->eth_stats.wake_queue++;
@@ -1606,7 +1605,7 @@ static int mana_move_wq_tail(struct gdma_queue *wq, u32 num_units)
 	return 0;
 }
 
-static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
 {
 	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0921485565c05..330e1bb088bb9 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -580,6 +580,7 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 void mana_query_phy_stats(struct mana_port_context *apc);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
 extern struct dentry *mana_debugfs_root;
-- 
2.51.0


