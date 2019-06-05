Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1E3641E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfFETJb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:09:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFETJa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AE7g989qIO1VkopksP3RSlALL0SU6gZzEPZFVDK3h6g=; b=hZ8MIFGcrOz/Vqrtdj0cEeO+RW
        rlhkacZFkVFvFSik93oBnuuJJgxSt8Jxs8Gg6t0gJfCcf3N4IRga5hDuyw47FRdJa9H5Y3XI5A+By
        uaB29+VcBqDZ/AGq7+o1Coz5x8V7ulIklnzC3zym3Hz6r0A4QAknVC1294KixPRfw3MLPfGGsYNjZ
        wdSoljVPRL7SS/KfFTZmrI8NBIosnNsY9SwI1J5Y3m6u5/vGvU8RNZ/zoR1BJhRtyu1SaxhJ98HWY
        hF/o8M5J8UFSjCHu0Q770Bchg1OLtXK22vwknekIgTSpieGddGwb3wOWFuBMeXY47TwSdRLFm2zuf
        2nHKjAOg==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHh-0005zB-51; Wed, 05 Jun 2019 19:09:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi host
Date:   Wed,  5 Jun 2019 21:08:33 +0200
Message-Id: <20190605190836.32354-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This ensures all proper DMA layer handling is taken care of by the
SCSI midlayer.  Note that the effect is global, as the IOMMU merging
is based off a paramters in struct device.  We could still turn if off
if no PCIe devices are present, but I don't know how to find that out.

Also remove the bogus nomerges flag, merges do take the virt_boundary
into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/megaraid/megaraid_sas_base.c   | 46 +++++----------------
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  7 ++++
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3dd1df472dc6..20b3b3f8bc16 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -1870,39 +1870,6 @@ void megasas_set_dynamic_target_properties(struct scsi_device *sdev,
 	}
 }
 
-/*
- * megasas_set_nvme_device_properties -
- * set nomerges=2
- * set virtual page boundary = 4K (current mr_nvme_pg_size is 4K).
- * set maximum io transfer = MDTS of NVME device provided by MR firmware.
- *
- * MR firmware provides value in KB. Caller of this function converts
- * kb into bytes.
- *
- * e.a MDTS=5 means 2^5 * nvme page size. (In case of 4K page size,
- * MR firmware provides value 128 as (32 * 4K) = 128K.
- *
- * @sdev:				scsi device
- * @max_io_size:				maximum io transfer size
- *
- */
-static inline void
-megasas_set_nvme_device_properties(struct scsi_device *sdev, u32 max_io_size)
-{
-	struct megasas_instance *instance;
-	u32 mr_nvme_pg_size;
-
-	instance = (struct megasas_instance *)sdev->host->hostdata;
-	mr_nvme_pg_size = max_t(u32, instance->nvme_page_size,
-				MR_DEFAULT_NVME_PAGE_SIZE);
-
-	blk_queue_max_hw_sectors(sdev->request_queue, (max_io_size / 512));
-
-	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, sdev->request_queue);
-	blk_queue_virt_boundary(sdev->request_queue, mr_nvme_pg_size - 1);
-}
-
-
 /*
  * megasas_set_static_target_properties -
  * Device property set by driver are static and it is not required to be
@@ -1961,8 +1928,10 @@ static void megasas_set_static_target_properties(struct scsi_device *sdev,
 		max_io_size_kb = le32_to_cpu(instance->tgt_prop->max_io_size_kb);
 	}
 
-	if (instance->nvme_page_size && max_io_size_kb)
-		megasas_set_nvme_device_properties(sdev, (max_io_size_kb << 10));
+	if (instance->nvme_page_size && max_io_size_kb) {
+		blk_queue_max_hw_sectors(sdev->request_queue,
+				(max_io_size_kb << 10) / 512);
+	}
 
 	scsi_change_queue_depth(sdev, device_qd);
 
@@ -6258,6 +6227,7 @@ static int megasas_start_aen(struct megasas_instance *instance)
 static int megasas_io_attach(struct megasas_instance *instance)
 {
 	struct Scsi_Host *host = instance->host;
+	u32 nvme_page_size = instance->nvme_page_size;
 
 	/*
 	 * Export parameters required by SCSI mid-layer
@@ -6298,6 +6268,12 @@ static int megasas_io_attach(struct megasas_instance *instance)
 	host->max_lun = MEGASAS_MAX_LUN;
 	host->max_cmd_len = 16;
 
+	if (nvme_page_size) {
+		if (nvme_page_size > MR_DEFAULT_NVME_PAGE_SIZE)
+			nvme_page_size = MR_DEFAULT_NVME_PAGE_SIZE;
+		host->virt_boundary_mask = nvme_page_size - 1;
+	}
+
 	/*
 	 * Notify the mid-layer about the new controller
 	 */
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 4dfa0685a86c..a9ff3a648e7b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1935,6 +1935,13 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 			build_prp = true;
 	}
 
+/*
+ * XXX: All the code following should go away.  The block layer guarantees
+ * merging according to the virt boundary.  And while we might have had some
+ * issues with that in the past we fixed them, and any new bug should be fixed
+ * in the core code as well.
+ */
+
 /*
  * Below code detects gaps/holes in IO data buffers.
  * What does holes/gaps mean?
-- 
2.20.1

