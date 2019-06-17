Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A7481CE
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfFQMUe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 08:20:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfFQMUU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PgIiXtMfcMikyRaDpwvwj7hy58i0W7Ad672qESTDqqE=; b=hz9mnb5MQY7x6GS5Cyjq5PdhCP
        eTLXuz02oPqvi8mtrO4sVAUU/62g2xF9NZ2M3tQSTuGus77fIZZomJbE6mBORYcm088soNoRVzpPi
        go3U94XASRiinKgDFuhxTnoD8nrJAJZ3FMnxnPtiWtXLoqHy0/FoSAggZJBHTPlgo1NtOkRq/yczC
        H9LM7b96Ebd9NAKiXYIitWUZXBqEaV5fvoe529SFlxDtmHo4MtQsiyrTVbLd32cD/lVKcJfZnqYum
        a/gAQgyEsYsqt7+3DDQYlHAQGDCsaI24vogdWHGzMFhPQfYlFfcrelBP8F3jI/H4EbhYEtJGJtrNi
        5uh+kk9A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqcT-0004gy-SF; Mon, 17 Jun 2019 12:20:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] IB/srp: set virt_boundary_mask in the scsi host
Date:   Mon, 17 Jun 2019 14:19:58 +0200
Message-Id: <20190617122000.22181-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617122000.22181-1-hch@lst.de>
References: <20190617122000.22181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This ensures all proper DMA layer handling is taken care of by the
SCSI midlayer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4305da2c9037..b3a4ebd85046 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3063,20 +3063,6 @@ static int srp_target_alloc(struct scsi_target *starget)
 	return 0;
 }
 
-static int srp_slave_alloc(struct scsi_device *sdev)
-{
-	struct Scsi_Host *shost = sdev->host;
-	struct srp_target_port *target = host_to_target(shost);
-	struct srp_device *srp_dev = target->srp_host->srp_dev;
-	struct ib_device *ibdev = srp_dev->dev;
-
-	if (!(ibdev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
-		blk_queue_virt_boundary(sdev->request_queue,
-					~srp_dev->mr_page_mask);
-
-	return 0;
-}
-
 static int srp_slave_configure(struct scsi_device *sdev)
 {
 	struct Scsi_Host *shost = sdev->host;
@@ -3279,7 +3265,6 @@ static struct scsi_host_template srp_template = {
 	.name				= "InfiniBand SRP initiator",
 	.proc_name			= DRV_NAME,
 	.target_alloc			= srp_target_alloc,
-	.slave_alloc			= srp_slave_alloc,
 	.slave_configure		= srp_slave_configure,
 	.info				= srp_target_info,
 	.queuecommand			= srp_queuecommand,
@@ -3814,6 +3799,9 @@ static ssize_t srp_create_target(struct device *dev,
 	target_host->max_cmd_len = sizeof ((struct srp_cmd *) (void *) 0L)->cdb;
 	target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
 
+	if (!(ibdev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
+		target_host->virt_boundary_mask = ~srp_dev->mr_page_mask;
+
 	target = host_to_target(target_host);
 
 	target->net		= kobj_ns_grab_current(KOBJ_NS_TYPE_NET);
-- 
2.20.1

