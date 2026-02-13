Return-Path: <linux-hyperv+bounces-8799-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPLqOgsEj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8799-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:59:23 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB71354C1
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E9833079FDC
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFBF352C54;
	Fri, 13 Feb 2026 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxBef7SO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A218EFD1;
	Fri, 13 Feb 2026 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980339; cv=none; b=fUWy6TR7O25YcL9JUqw3gpbQcFlv+FprrnOk26myke8MNPjciD4h+z287DmCU4aSbwBfgec5UeDC7lKxBB8eUPX29Slh0o9IeFbaaKrCmJzYufgRWYdJhHWHYAsbkguHXOEaymzQecPKOJyUIHRx8qJsVz/z+RuXDZd6lC0KzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980339; c=relaxed/simple;
	bh=OXuffjSAJJspR2BKePSZZLjPNwOGTyHREVM0tgzf9d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvt+Ns+dIMQjD8h42/Pq/Md/p17Ho/rh4hVrsu9iW9Rqn1FGac1zbpwa46v8PKCNNL7O+AMzOeVSGcC5M5ahlJd/9uxhMF1tvYj9IMRWmxnaeASn/voz6GlLxWaUlSYDqiWQfZEOLerz0loxnrxQcWSa9nKJL02iBg5KGOzjwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxBef7SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E690C16AAE;
	Fri, 13 Feb 2026 10:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980339;
	bh=OXuffjSAJJspR2BKePSZZLjPNwOGTyHREVM0tgzf9d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxBef7SOT2ku2iS3WOnvv5lgiPhA9QaApHHIS3DeJjUQTR/KmTSQvpb0oDdIkTi+X
	 LkjGs+iJieLDaQFNUGD7tSm8Fzu75yV+KRhXou0KY+1rN8U1gRV8vdna3v9MltZvJj
	 gzmEpmPlsiprCEc5Jfj+y79am3PtxAxiJ9Ip4Hsdq2rNFXs9ohZzMO3TvrFo7ms3wm
	 0FfDN920zegiMWs0MtQDkrLqguhYgys4vINLh0XyjhQy2+J7RBifgv9oK8XmS97i0+
	 F+lKBH0cTpBrd71lixzNtEcS2Sjy5BKB5GUzdQmPBxbp1tDO8Oj4iWomNNZ+hlyfKh
	 KZ4lKR97sRzCg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 01/50] RDMA: Move DMA block iterator logic into dedicated files
Date: Fri, 13 Feb 2026 12:57:37 +0200
Message-ID: <20260213-refactor-umem-v1-1-f3be85847922@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8799-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 52BB71354C1
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The DMA iterator logic was mixed into verbs and umem-specific code,
forcing all users to include rdma/ib_umem.h. Move the block iterator
logic into iter.c and rdma/iter.h so that rdma/ib_umem.h and
rdma/ib_verbs.h can be separated in a follow-up patch.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/Makefile             |  2 +-
 drivers/infiniband/core/iter.c               | 43 ++++++++++++++
 drivers/infiniband/core/verbs.c              | 38 ------------
 drivers/infiniband/hw/bnxt_re/qplib_res.c    |  2 +-
 drivers/infiniband/hw/cxgb4/mem.c            |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c   |  2 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.h    |  2 +-
 drivers/infiniband/hw/irdma/main.h           |  2 +-
 drivers/infiniband/hw/mana/mana_ib.h         |  2 +-
 drivers/infiniband/hw/mlx4/mr.c              |  1 +
 drivers/infiniband/hw/mlx5/mem.c             |  1 +
 drivers/infiniband/hw/mlx5/umr.c             |  1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  2 +-
 drivers/infiniband/hw/qedr/verbs.c           |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    |  2 +-
 include/rdma/ib_umem.h                       | 30 ----------
 include/rdma/ib_verbs.h                      | 48 ---------------
 include/rdma/iter.h                          | 88 ++++++++++++++++++++++++++++
 21 files changed, 147 insertions(+), 129 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index f483e0c12444..48922e0ede56 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o lag.o
+				trace.o lag.o iter.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/iter.c b/drivers/infiniband/core/iter.c
new file mode 100644
index 000000000000..8e543d100657
--- /dev/null
+++ b/drivers/infiniband/core/iter.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. */
+
+#include <linux/export.h>
+#include <rdma/iter.h>
+
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist, unsigned int nents,
+			     unsigned long pgsz)
+{
+	memset(biter, 0, sizeof(struct ib_block_iter));
+	biter->__sg = sglist;
+	biter->__sg_nents = nents;
+
+	/* Driver provides best block size to use */
+	biter->__pg_bit = __fls(pgsz);
+}
+EXPORT_SYMBOL(__rdma_block_iter_start);
+
+bool __rdma_block_iter_next(struct ib_block_iter *biter)
+{
+	unsigned int block_offset;
+	unsigned int delta;
+
+	if (!biter->__sg_nents || !biter->__sg)
+		return false;
+
+	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
+	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
+	delta = BIT_ULL(biter->__pg_bit) - block_offset;
+
+	while (biter->__sg_nents && biter->__sg &&
+	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
+		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
+		biter->__sg_advance = 0;
+		biter->__sg = sg_next(biter->__sg);
+		biter->__sg_nents--;
+	}
+	biter->__sg_advance += delta;
+
+	return true;
+}
+EXPORT_SYMBOL(__rdma_block_iter_next);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 02ebc3e52196..47a97797d7be 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -3154,44 +3154,6 @@ int rdma_init_netdev(struct ib_device *device, u32 port_num,
 }
 EXPORT_SYMBOL(rdma_init_netdev);
 
-void __rdma_block_iter_start(struct ib_block_iter *biter,
-			     struct scatterlist *sglist, unsigned int nents,
-			     unsigned long pgsz)
-{
-	memset(biter, 0, sizeof(struct ib_block_iter));
-	biter->__sg = sglist;
-	biter->__sg_nents = nents;
-
-	/* Driver provides best block size to use */
-	biter->__pg_bit = __fls(pgsz);
-}
-EXPORT_SYMBOL(__rdma_block_iter_start);
-
-bool __rdma_block_iter_next(struct ib_block_iter *biter)
-{
-	unsigned int block_offset;
-	unsigned int delta;
-
-	if (!biter->__sg_nents || !biter->__sg)
-		return false;
-
-	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
-	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
-	delta = BIT_ULL(biter->__pg_bit) - block_offset;
-
-	while (biter->__sg_nents && biter->__sg &&
-	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
-		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
-		biter->__sg_advance = 0;
-		biter->__sg = sg_next(biter->__sg);
-		biter->__sg_nents--;
-	}
-	biter->__sg_advance += delta;
-
-	return true;
-}
-EXPORT_SYMBOL(__rdma_block_iter_next);
-
 /**
  * rdma_alloc_hw_stats_struct - Helper function to allocate dynamic struct
  *   for the drivers.
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 875d7b52c06a..64b02ea98cac 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -46,7 +46,7 @@
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <rdma/ib_verbs.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 
 #include "roce_hsi.h"
 #include "qplib_res.h"
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index adeed7447e7b..e0ec2c4158a0 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -32,9 +32,9 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <rdma/ib_umem.h>
 #include <linux/atomic.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 
 #include "iw_cxgb4.h"
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 22d3e25c3b9d..19e3033d4ff7 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -9,9 +9,9 @@
 #include <linux/log2.h>
 
 #include <rdma/ib_addr.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 #define UVERBS_MODULE_NAME efa_ib
 #include <rdma/uverbs_named_ioctl.h>
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 109a3f3de911..058edc42de58 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -12,7 +12,7 @@
 #include <linux/vmalloc.h>
 #include <net/addrconf.h>
 #include <rdma/erdma-abi.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "erdma.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 6ee911f6885b..c21004814c3c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -32,7 +32,7 @@
  */
 
 #include <linux/vmalloc.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 #include "hns_roce_device.h"
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf)
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 82fda1e3cdb6..63828240d659 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -4,9 +4,9 @@
 #ifndef _IONIC_IBDEV_H_
 #define _IONIC_IBDEV_H_
 
-#include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include <rdma/ionic-abi.h>
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index d320d1a228b3..3d49bd57bae7 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -37,8 +37,8 @@
 #include <rdma/rdma_cm.h>
 #include <rdma/iw_cm.h>
 #include <rdma/ib_user_verbs.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 #include "osdep.h"
 #include "defs.h"
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index e447acfd2071..a7c8c0fd7019 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -8,7 +8,7 @@
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_mad.h>
-#include <rdma/ib_umem.h>
+#include <rdma/iter.h>
 #include <rdma/mana-abi.h>
 #include <rdma/uverbs_ioctl.h>
 #include <linux/dmapool.h>
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 94464f1694d9..9b647a300eb9 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -33,6 +33,7 @@
 
 #include <linux/slab.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 
 #include "mlx4_ib.h"
 
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index af321f6ef7f5..75d5b5672b5c 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -31,6 +31,7 @@
  */
 
 #include <rdma/ib_umem_odp.h>
+#include <rdma/iter.h>
 #include "mlx5_ib.h"
 
 /*
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 4e562e0dd9e1..29488fba21a0 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
 
 #include <rdma/ib_umem_odp.h>
+#include <rdma/iter.h>
 #include "mlx5_ib.h"
 #include "umr.h"
 #include "wr.h"
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index dd572d76866c..aa5ca5c4ff77 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -35,8 +35,8 @@
  */
 
 #include <rdma/ib_smi.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include <linux/sched.h>
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 46d911fd38de..bf9211d8d130 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -45,9 +45,9 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/iw_cm.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include "ocrdma.h"
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index ab9bf0922979..cb06c5d894b8 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -39,9 +39,9 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/iw_cm.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/iter.h>
 #include <rdma/uverbs_ioctl.h>
 
 #include <linux/qed/common_hsi.h>
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index 763ddc6f25d1..23e547d4b3a7 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -53,8 +53,8 @@
 #include <linux/pci.h>
 #include <linux/semaphore.h>
 #include <linux/workqueue.h>
-#include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/iter.h>
 #include <rdma/vmw_pvrdma-abi.h>
 
 #include "pvrdma_ring.h"
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0a8e092c0ea8..ce47688dd003 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -76,36 +76,6 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
 
-static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
-						struct ib_umem *umem,
-						unsigned long pgsz)
-{
-	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
-				umem->sgt_append.sgt.nents, pgsz);
-	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
-	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
-}
-
-static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
-{
-	return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
-}
-
-/**
- * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
- * @umem: umem to iterate over
- * @pgsz: Page size to split the list into
- *
- * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
- * returned DMA blocks will be aligned to pgsz and span the range:
- * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, pgsz)
- *
- * Performs exactly ib_umem_num_dma_blocks() iterations.
- */
-#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
-	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
-	     __rdma_umem_block_iter_next(biter);)
-
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8bd020da7745..e1ec5a6c74e6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2950,22 +2950,6 @@ struct ib_client {
 	u8 no_kverbs_req:1;
 };
 
-/*
- * IB block DMA iterator
- *
- * Iterates the DMA-mapped SGL in contiguous memory blocks aligned
- * to a HW supported page size.
- */
-struct ib_block_iter {
-	/* internal states */
-	struct scatterlist *__sg;	/* sg holding the current aligned block */
-	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
-	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
-	unsigned int __sg_nents;	/* number of SG entries */
-	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
-	unsigned int __pg_bit;		/* alignment of current block */
-};
-
 struct ib_device *_ib_alloc_device(size_t size, struct net *net);
 #define ib_alloc_device(drv_struct, member)                                    \
 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
@@ -2994,38 +2978,6 @@ void ib_unregister_device_queued(struct ib_device *ib_dev);
 int ib_register_client   (struct ib_client *client);
 void ib_unregister_client(struct ib_client *client);
 
-void __rdma_block_iter_start(struct ib_block_iter *biter,
-			     struct scatterlist *sglist,
-			     unsigned int nents,
-			     unsigned long pgsz);
-bool __rdma_block_iter_next(struct ib_block_iter *biter);
-
-/**
- * rdma_block_iter_dma_address - get the aligned dma address of the current
- * block held by the block iterator.
- * @biter: block iterator holding the memory block
- */
-static inline dma_addr_t
-rdma_block_iter_dma_address(struct ib_block_iter *biter)
-{
-	return biter->__dma_addr & ~(BIT_ULL(biter->__pg_bit) - 1);
-}
-
-/**
- * rdma_for_each_block - iterate over contiguous memory blocks of the sg list
- * @sglist: sglist to iterate over
- * @biter: block iterator holding the memory block
- * @nents: maximum number of sg entries to iterate over
- * @pgsz: best HW supported page size to use
- *
- * Callers may use rdma_block_iter_dma_address() to get each
- * blocks aligned DMA address.
- */
-#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
-	for (__rdma_block_iter_start(biter, sglist, nents,	\
-				     pgsz);			\
-	     __rdma_block_iter_next(biter);)
-
 /**
  * ib_get_client_data - Get IB client context
  * @device:Device to get context for
diff --git a/include/rdma/iter.h b/include/rdma/iter.h
new file mode 100644
index 000000000000..19d64ef04ba9
--- /dev/null
+++ b/include/rdma/iter.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef _RDMA_ITER_H_
+#define _RDMA_ITER_H_
+
+#include <linux/scatterlist.h>
+#include <rdma/ib_umem.h>
+
+/**
+ * IB block DMA iterator
+ *
+ * Iterates the DMA-mapped SGL in contiguous memory blocks aligned
+ * to a HW supported page size.
+ */
+struct ib_block_iter {
+	/* internal states */
+	struct scatterlist *__sg;	/* sg holding the current aligned block */
+	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
+	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
+	unsigned int __sg_nents;	/* number of SG entries */
+	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
+	unsigned int __pg_bit;		/* alignment of current block */
+};
+
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist,
+			     unsigned int nents,
+			     unsigned long pgsz);
+bool __rdma_block_iter_next(struct ib_block_iter *biter);
+
+/**
+ * rdma_block_iter_dma_address - get the aligned dma address of the current
+ * block held by the block iterator.
+ * @biter: block iterator holding the memory block
+ */
+static inline dma_addr_t
+rdma_block_iter_dma_address(struct ib_block_iter *biter)
+{
+	return biter->__dma_addr & ~(BIT_ULL(biter->__pg_bit) - 1);
+}
+
+/**
+ * rdma_for_each_block - iterate over contiguous memory blocks of the sg list
+ * @sglist: sglist to iterate over
+ * @biter: block iterator holding the memory block
+ * @nents: maximum number of sg entries to iterate over
+ * @pgsz: best HW supported page size to use
+ *
+ * Callers may use rdma_block_iter_dma_address() to get each
+ * blocks aligned DMA address.
+ */
+#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
+	for (__rdma_block_iter_start(biter, sglist, nents,	\
+				     pgsz);			\
+	     __rdma_block_iter_next(biter);)
+
+static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
+						struct ib_umem *umem,
+						unsigned long pgsz)
+{
+	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
+				umem->sgt_append.sgt.nents, pgsz);
+	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
+	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
+}
+
+static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
+{
+	return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
+}
+
+/**
+ * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
+ * @umem: umem to iterate over
+ * @pgsz: Page size to split the list into
+ *
+ * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
+ * returned DMA blocks will be aligned to pgsz and span the range:
+ * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, pgsz)
+ *
+ * Performs exactly ib_umem_num_dma_blocks() iterations.
+ */
+#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
+	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
+	     __rdma_umem_block_iter_next(biter);)
+
+#endif /* _RDMA_ITER_H_ */

-- 
2.52.0


