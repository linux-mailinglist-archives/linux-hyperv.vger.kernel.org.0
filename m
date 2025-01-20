Return-Path: <linux-hyperv+bounces-3730-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68603A171D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070BE3AB302
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A211F03FF;
	Mon, 20 Jan 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lscGDzgO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D11EE02F;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394055; cv=none; b=jHXjTc7zqsyL3yhfzFB5FRJ+qLErWjsBSlpAdRXRRU+5sD/2xSLrHCohnwNGKtt2fwr4XvLKMkxC0A3qEJo+WPpkxMDqNpylIX91n4Z3LhYVpgPS7y3OSrfYd3GYNx4VCXZ2Ls+I3g0khbfTYOCvVmuVrVaH/9XVEOwJO82LBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394055; c=relaxed/simple;
	bh=PYOrqQxzNHYnf+KWBiZK+CFRAyryVBsNbmttmqKrMsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SCZKd/izw+LEJOftgxjh9SCEv4a8ifAGQykJoMWCfZCh++n9XfKYghH95T01i7NrOACak1getJ3dqg4yIuobDuDhvDjI7qCDJ/zdLW4f44N5UbBnN4BleQIJ51nNeBcjke5tmrnMS5kH7P986FhsBh6Kc8ccNaSbcndmRfFX27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lscGDzgO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4817E205A9CD;
	Mon, 20 Jan 2025 09:27:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4817E205A9CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=Ev/ugUf7j8aXjIyIOEcly1CoRsR5j3zIdl2kzD7vcfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lscGDzgO4aS7wqc/Qhi1LQu7byEVCd8E1HXM4PBZ+EJN3czd2bE98RBlz8J/XcKuU
	 5mc61fAkYJmZOrR3PgeW4C6o93NfFlgzz+gCRD2wMHkFoOyWrxMdveNihvaEiI1NHM
	 YaAq6dXqIK8SJyO+hZqTqBu7st9QyS7kABDhGrGE=
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
Subject: [PATCH rdma-next 07/13] RDMA/mana_ib: create/destroy AH
Date: Mon, 20 Jan 2025 09:27:13 -0800
Message-Id: <1737394039-28772-8-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement create and destroy AH for kernel.

In mana_ib, AV is passed as an sge in WQE.
Allocate DMA memory and write an AV there.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/Makefile  |  2 +-
 drivers/infiniband/hw/mana/ah.c      | 58 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/device.c  | 13 ++++++-
 drivers/infiniband/hw/mana/mana_ib.h | 30 ++++++++++++++
 4 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/mana/ah.c

diff --git a/drivers/infiniband/hw/mana/Makefile b/drivers/infiniband/hw/mana/Makefile
index 88655fe..6e56f77 100644
--- a/drivers/infiniband/hw/mana/Makefile
+++ b/drivers/infiniband/hw/mana/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MANA_INFINIBAND) += mana_ib.o
 
-mana_ib-y := device.o main.o wq.o qp.o cq.o mr.o
+mana_ib-y := device.o main.o wq.o qp.o cq.o mr.o ah.o
diff --git a/drivers/infiniband/hw/mana/ah.c b/drivers/infiniband/hw/mana/ah.c
new file mode 100644
index 0000000..f56952e
--- /dev/null
+++ b/drivers/infiniband/hw/mana/ah.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Microsoft Corporation. All rights reserved.
+ */
+
+#include "mana_ib.h"
+
+int mana_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr,
+		      struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev = container_of(ibah->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_ah *ah = container_of(ibah, struct mana_ib_ah, ibah);
+	struct rdma_ah_attr *ah_attr = attr->ah_attr;
+	const struct ib_global_route *grh;
+	enum rdma_network_type ntype;
+
+	if (ah_attr->type != RDMA_AH_ATTR_TYPE_ROCE ||
+	    !(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH))
+		return -EINVAL;
+
+	if (udata)
+		return -EINVAL;
+
+	ah->av = dma_pool_zalloc(mdev->av_pool, GFP_ATOMIC, &ah->dma_handle);
+	if (!ah->av)
+		return -ENOMEM;
+
+	grh = rdma_ah_read_grh(ah_attr);
+	ntype = rdma_gid_attr_network_type(grh->sgid_attr);
+
+	copy_in_reverse(ah->av->dest_mac, ah_attr->roce.dmac, ETH_ALEN);
+	ah->av->udp_src_port = rdma_flow_label_to_udp_sport(grh->flow_label);
+	ah->av->hop_limit = grh->hop_limit;
+	ah->av->dscp = (grh->traffic_class >> 2) & 0x3f;
+	ah->av->is_ipv6 = (ntype == RDMA_NETWORK_IPV6);
+
+	if (ah->av->is_ipv6) {
+		copy_in_reverse(ah->av->dest_ip, grh->dgid.raw, 16);
+		copy_in_reverse(ah->av->src_ip, grh->sgid_attr->gid.raw, 16);
+	} else {
+		ah->av->dest_ip[10] = 0xFF;
+		ah->av->dest_ip[11] = 0xFF;
+		copy_in_reverse(&ah->av->dest_ip[12], &grh->dgid.raw[12], 4);
+		copy_in_reverse(&ah->av->src_ip[12], &grh->sgid_attr->gid.raw[12], 4);
+	}
+
+	return 0;
+}
+
+int mana_ib_destroy_ah(struct ib_ah *ibah, u32 flags)
+{
+	struct mana_ib_dev *mdev = container_of(ibah->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_ah *ah = container_of(ibah, struct mana_ib_ah, ibah);
+
+	dma_pool_free(mdev->av_pool, ah->av, ah->dma_handle);
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 215dbce..d534ef1 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -19,6 +19,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.add_gid = mana_ib_gd_add_gid,
 	.alloc_pd = mana_ib_alloc_pd,
 	.alloc_ucontext = mana_ib_alloc_ucontext,
+	.create_ah = mana_ib_create_ah,
 	.create_cq = mana_ib_create_cq,
 	.create_qp = mana_ib_create_qp,
 	.create_rwq_ind_table = mana_ib_create_rwq_ind_table,
@@ -27,6 +28,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.dealloc_ucontext = mana_ib_dealloc_ucontext,
 	.del_gid = mana_ib_gd_del_gid,
 	.dereg_mr = mana_ib_dereg_mr,
+	.destroy_ah = mana_ib_destroy_ah,
 	.destroy_cq = mana_ib_destroy_cq,
 	.destroy_qp = mana_ib_destroy_qp,
 	.destroy_rwq_ind_table = mana_ib_destroy_rwq_ind_table,
@@ -44,6 +46,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.query_port = mana_ib_query_port,
 	.reg_user_mr = mana_ib_reg_user_mr,
 
+	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mana_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mana_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_qp, mana_ib_qp, ibqp),
@@ -135,15 +138,22 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto destroy_rnic;
 	}
 
+	dev->av_pool = dma_pool_create("mana_ib_av", mdev->gdma_context->dev,
+				       MANA_AV_BUFFER_SIZE, MANA_AV_BUFFER_SIZE, 0);
+	if (!dev->av_pool)
+		goto destroy_rnic;
+
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
-		goto destroy_rnic;
+		goto deallocate_pool;
 
 	dev_set_drvdata(&adev->dev, dev);
 
 	return 0;
 
+deallocate_pool:
+	dma_pool_destroy(dev->av_pool);
 destroy_rnic:
 	xa_destroy(&dev->qp_table_wq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
@@ -161,6 +171,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
 	ib_unregister_device(&dev->ib_dev);
+	dma_pool_destroy(dev->av_pool);
 	xa_destroy(&dev->qp_table_wq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_ib_destroy_eqs(dev);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 5e470f1..7b079d8 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -11,6 +11,7 @@
 #include <rdma/ib_umem.h>
 #include <rdma/mana-abi.h>
 #include <rdma/uverbs_ioctl.h>
+#include <linux/dmapool.h>
 
 #include <net/mana/mana.h>
 
@@ -32,6 +33,11 @@
  */
 #define MANA_CA_ACK_DELAY	16
 
+/*
+ * The buffer used for writing AV
+ */
+#define MANA_AV_BUFFER_SIZE	64
+
 struct mana_ib_adapter_caps {
 	u32 max_sq_id;
 	u32 max_rq_id;
@@ -65,6 +71,7 @@ struct mana_ib_dev {
 	struct gdma_queue **eqs;
 	struct xarray qp_table_wq;
 	struct mana_ib_adapter_caps adapter_caps;
+	struct dma_pool *av_pool;
 };
 
 struct mana_ib_wq {
@@ -88,6 +95,25 @@ struct mana_ib_pd {
 	u32 tx_vp_offset;
 };
 
+struct mana_ib_av {
+	u8 dest_ip[16];
+	u8 dest_mac[ETH_ALEN];
+	u16 udp_src_port;
+	u8 src_ip[16];
+	u32 hop_limit	: 8;
+	u32 reserved1	: 12;
+	u32 dscp	: 6;
+	u32 reserved2	: 5;
+	u32 is_ipv6	: 1;
+	u32 reserved3	: 32;
+};
+
+struct mana_ib_ah {
+	struct ib_ah ibah;
+	struct mana_ib_av *av;
+	dma_addr_t dma_handle;
+};
+
 struct mana_ib_mr {
 	struct ib_mr ibmr;
 	struct ib_umem *umem;
@@ -532,4 +558,8 @@ int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
 int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type);
 int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
+
+int mana_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
+		      struct ib_udata *udata);
+int mana_ib_destroy_ah(struct ib_ah *ah, u32 flags);
 #endif
-- 
2.43.0


