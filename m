Return-Path: <linux-hyperv+bounces-3725-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AAFA171B7
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A521C162632
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA961EE7D6;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YBlaLAV+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276AD1E3DFC;
	Mon, 20 Jan 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394053; cv=none; b=KMlU/aHDy6ZW0I9WV7RwxO+vtIEvBH+MwdH35QOm/O28+atAo/HBYRoHBxUDbAEc7YQGJxz0knKNcqSsWeSsV+KCB4njWhrKc60HNJ9psUQO4VdaK2PPwYAkV5sdUvlcqlu8yq1RHNh0TCPUCPPglgGSr3dObmGNB9ppX1Aojv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394053; c=relaxed/simple;
	bh=9bw+UBu/tOCWjJ6Fg8uY75GtYdYQK7A9ut5Y49yI7to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NxPh34+LxJ3dcrUB1OZOJp5h0IDTyIhsddFe5vESG1IhhCCa7eEYTp5HOTlt393JwyEJQq3EEUK5BvP9HpiaDsukI7hWvUl5WDj7hrwvUy8UAGv4BLMJGBADMPDGM50BDgrTOT3MGlfY202CL9qJ6grpmkLrkzf30ZgH3dV8bVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YBlaLAV+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5271205A9C9;
	Mon, 20 Jan 2025 09:27:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5271205A9C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394045;
	bh=M7twiefFnYi507g6r9hAld0uVIT8tdnuhUU8hD5ipcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBlaLAV+DmY3us2prFIBjapX9OGfv4w8adkw8Rt7lDWZVMRiM6xDqKFzByxa1dd2y
	 HuI+8/Ktwag27zasz1LIJxrusZR1EyI0I4zSxBwb7ebr5loxLYiEaRg0vmnfV08O/I
	 AWJqrq4py/uNEtRjE1T7xEHBgfgkJnyEHSbJQqQc=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 03/13] RDMA/mana_ib: helpers to allocate kernel queues
Date: Mon, 20 Jan 2025 09:27:09 -0800
Message-Id: <1737394039-28772-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Introduce helpers to allocate queues for kernel-level use.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c             | 23 +++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h          |  3 +++
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 45b251b..f2f6bb3 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -240,6 +240,27 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
 }
 
+int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
+				struct mana_ib_queue *queue)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct gdma_queue_spec spec = {};
+	int err;
+
+	queue->id = INVALID_QUEUE_ID;
+	queue->gdma_region = GDMA_INVALID_DMA_REGION;
+	spec.type = type;
+	spec.monitor_avl_buf = false;
+	spec.queue_size = size;
+	err = mana_gd_create_mana_wq_cq(&gc->mana_ib, &spec, &queue->kmem);
+	if (err)
+		return err;
+	/* take ownership into mana_ib from mana */
+	queue->gdma_region = queue->kmem->mem_info.dma_region_handle;
+	queue->kmem->mem_info.dma_region_handle = GDMA_INVALID_DMA_REGION;
+	return 0;
+}
+
 int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
 			 struct mana_ib_queue *queue)
 {
@@ -279,6 +300,8 @@ void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue
 	 */
 	mana_ib_gd_destroy_dma_region(mdev, queue->gdma_region);
 	ib_umem_release(queue->umem);
+	if (queue->kmem)
+		mana_gd_destroy_queue(mdev_to_gc(mdev), queue->kmem);
 }
 
 static int
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index b53a5b4..79ebd95 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -52,6 +52,7 @@ struct mana_ib_adapter_caps {
 
 struct mana_ib_queue {
 	struct ib_umem *umem;
+	struct gdma_queue *kmem;
 	u64 gdma_region;
 	u64 id;
 };
@@ -388,6 +389,8 @@ int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 				  mana_handle_t gdma_region);
 
+int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
+				struct mana_ib_queue *queue);
 int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
 			 struct mana_ib_queue *queue);
 void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e97af7a..3cb0543 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -867,6 +867,7 @@ free_q:
 	kfree(queue);
 	return err;
 }
+EXPORT_SYMBOL_NS(mana_gd_create_mana_wq_cq, NET_MANA);
 
 void mana_gd_destroy_queue(struct gdma_context *gc, struct gdma_queue *queue)
 {
-- 
2.43.0


