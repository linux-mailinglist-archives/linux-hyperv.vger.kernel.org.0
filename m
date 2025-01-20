Return-Path: <linux-hyperv+bounces-3734-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE4A171C7
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD417A02C7
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A01F131F;
	Mon, 20 Jan 2025 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o8t1ruVS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86D1EF080;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394056; cv=none; b=H16MyDtGuGXOgyawKoSCXjfo6IzKc9w3z5FFxyD0TMlo1UfjRUL58Nql8i62UqhcOpSomMLuf9V1puW2KLfyY/wekIoy1DUAEEnnyd8fWO10Qt9E0Ih/W186hur8I265mFsFJaBbjVpWY1gvka6OI20QS1FcQgrT20RSdY0/Hpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394056; c=relaxed/simple;
	bh=F3l1BHi8b+bBs1Lrsw+qr5uoPMBOOEgQcGC8mPNSyjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BBc8x9DmCi5wRSh6VtB98yWxHThHcnEYM9sxkBce0K8j8Ty9d/NHyqKXhP/btDvitaD8epfYSaIBtqf4AXbGpOpcfCwPRZ+Pby0Q1xPVq0TR4Pl+sGvt6YrHVjkDCv9So8uYM7HKJxP++EzwRKGwrw5BRPoiWeHBlkxinQUzTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o8t1ruVS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95567205A9D0;
	Mon, 20 Jan 2025 09:27:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95567205A9D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=VmhdQ413jRbYE0vPggWDHskxWQLSg1O8TLVBifqo5xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8t1ruVSiablBfy48ABLj0vziZ51fRApSEbmRD4QXqTHAjbY80b9z8EQzcHIOiGqv
	 ux+O4BgUubBcN/tM+xRwEsmh9WoMCghEFMHBUpDIqUGp8lfJEAjS3NnbzbofnmUxMN
	 EI8giAIVp40DmwkqR8ECRkFsq8GAOf9XE8wmF50w=
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
Subject: [PATCH rdma-next 10/13] RDMA/mana_ib: implement req_notify_cq
Date: Mon, 20 Jan 2025 09:27:16 -0800
Message-Id: <1737394039-28772-11-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Arm a CQ when req_notify_cq is called.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c                 | 12 ++++++++++++
 drivers/infiniband/hw/mana/device.c             |  1 +
 drivers/infiniband/hw/mana/mana_ib.h            |  2 ++
 drivers/net/ethernet/microsoft/mana/gdma_main.c |  1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index d26d82d..82f1462 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -168,3 +168,15 @@ void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	kfree(gc->cq_table[cq->queue.id]);
 	gc->cq_table[cq->queue.id] = NULL;
 }
+
+int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
+{
+	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
+	struct gdma_queue *gdma_cq = cq->queue.kmem;
+
+	if (!gdma_cq)
+		return -EINVAL;
+
+	mana_gd_ring_cq(gdma_cq, SET_ARM_BIT);
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 1da86c3..63e12c3 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -47,6 +47,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.query_pkey = mana_ib_query_pkey,
 	.query_port = mana_ib_query_port,
 	.reg_user_mr = mana_ib_reg_user_mr,
+	.req_notify_cq = mana_ib_arm_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mana_ib_cq, ibcq),
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6265c39..bd34ad6 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -595,4 +595,6 @@ int mana_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		      const struct ib_recv_wr **bad_wr);
 int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr);
+
+int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 #endif
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 409e4e8..823f7e7 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -344,6 +344,7 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
 	mana_gd_ring_doorbell(gc, cq->gdma_dev->doorbell, cq->type, cq->id,
 			      head, arm_bit);
 }
+EXPORT_SYMBOL_NS(mana_gd_ring_cq, NET_MANA);
 
 static void mana_gd_process_eqe(struct gdma_queue *eq)
 {
-- 
2.43.0


