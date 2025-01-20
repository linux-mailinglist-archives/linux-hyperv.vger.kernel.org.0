Return-Path: <linux-hyperv+bounces-3724-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB05A171B1
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E343E188A52B
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72A1ADC7B;
	Mon, 20 Jan 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Yc/Lg8fH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C661E9B00;
	Mon, 20 Jan 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394052; cv=none; b=dcUy+11rMMKIdEl3gQtdc/x/nithMZBcdJKUFGa5MJZXO89lHmvvOKlxF4NUlVlJrbQIWhve8xgHEHuTj2y60ZlO2zhbTQr2gaqWtTgCLEyVlMqK6G6h686P8T1uLrnHCEIpCY4HatDIJwwBItj1OrSxtXQjTPAxtX6Kz20yE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394052; c=relaxed/simple;
	bh=F36zJOzrYXnnxRvRSL0eK6xhoBQhmHCL0F3Q1ZOntGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IGIDxCmQKzHxKSoPIO0AV+P5nF5/WBCbt3RtjCmbXzLgoaTROpm+3c+1ucG3AH+CNwZHaw99r719p8VEDrqKW2L68CelpuirutYjLC8ATH+zgUNlPvDtvSNkibIC+9w8pexAnoWQUEwiG/WnE/dPfCNshVjIAy99ED1E7iBb9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Yc/Lg8fH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB94E205A9C8;
	Mon, 20 Jan 2025 09:27:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB94E205A9C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394045;
	bh=6Q7KhQEHK6x5EZ2rC99hM7Tlbuzw4R7mcVgBDZzZSzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yc/Lg8fHg2sOI/jMVWsuqmFJ0nza2ZjGOmdFKISBvGFSZBNrsE1YZZI2D0NR/NmiW
	 Vwj0B+NlFS+R+6q8EBrCJMlNodN4zFR0TweMMHTuEYsllGDswNC8XptH7fRqRk2oRf
	 FZIjJv/zfiIW7dRk+/02yPD7QOMUcv0pGOnSQ06M=
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
Subject: [PATCH rdma-next 02/13] RDMA/mana_ib: implement get_dma_mr
Date: Mon, 20 Jan 2025 09:27:08 -0800
Message-Id: <1737394039-28772-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement allocation of DMA-mapped memory regions.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c |  1 +
 drivers/infiniband/hw/mana/mr.c     | 36 +++++++++++++++++++++++++++++
 include/net/mana/gdma.h             |  5 ++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 7ac0191..215dbce 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -32,6 +32,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.destroy_rwq_ind_table = mana_ib_destroy_rwq_ind_table,
 	.destroy_wq = mana_ib_destroy_wq,
 	.disassociate_ucontext = mana_ib_disassociate_ucontext,
+	.get_dma_mr = mana_ib_get_dma_mr,
 	.get_link_layer = mana_ib_get_link_layer,
 	.get_port_immutable = mana_ib_get_port_immutable,
 	.mmap = mana_ib_mmap,
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 887b09d..3a047f8 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -8,6 +8,8 @@
 #define VALID_MR_FLAGS                                                         \
 	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ)
 
+#define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
+
 static enum gdma_mr_access_flags
 mana_ib_verbs_to_gdma_access_flags(int access_flags)
 {
@@ -39,6 +41,8 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 	req.mr_type = mr_params->mr_type;
 
 	switch (mr_params->mr_type) {
+	case GDMA_MR_TYPE_GPA:
+		break;
 	case GDMA_MR_TYPE_GVA:
 		req.gva.dma_region_handle = mr_params->gva.dma_region_handle;
 		req.gva.virtual_address = mr_params->gva.virtual_address;
@@ -169,6 +173,38 @@ err_free:
 	return ERR_PTR(err);
 }
 
+struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags)
+{
+	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
+	struct gdma_create_mr_params mr_params = {};
+	struct ib_device *ibdev = ibpd->device;
+	struct mana_ib_dev *dev;
+	struct mana_ib_mr *mr;
+	int err;
+
+	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+
+	if (access_flags & ~VALID_DMA_MR_FLAGS)
+		return ERR_PTR(-EINVAL);
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mr_params.pd_handle = pd->pd_handle;
+	mr_params.mr_type = GDMA_MR_TYPE_GPA;
+
+	err = mana_ib_gd_create_mr(dev, mr, &mr_params);
+	if (err)
+		goto err_free;
+
+	return &mr->ibmr;
+
+err_free:
+	kfree(mr);
+	return ERR_PTR(err);
+}
+
 int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mana_ib_mr *mr = container_of(ibmr, struct mana_ib_mr, ibmr);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 03e1b25..a94b04e 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -801,6 +801,11 @@ struct gdma_destory_pd_resp {
 };/* HW DATA */
 
 enum gdma_mr_type {
+	/*
+	 * Guest Physical Address - MRs of this type allow access
+	 * to any DMA-mapped memory using bus-logical address
+	 */
+	GDMA_MR_TYPE_GPA = 1,
 	/* Guest Virtual Address - MRs of this type allow access
 	 * to memory mapped by PTEs associated with this MR using a virtual
 	 * address that is set up in the MST
-- 
2.43.0


