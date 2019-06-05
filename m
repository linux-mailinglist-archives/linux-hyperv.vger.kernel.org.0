Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA873643E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFETJ0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:09:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfFETJZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BZynmndmGYCWQ7WGzgFBa5UwSeviNORnIHKuHoOiZgI=; b=ELWyStyyodCbtc4qhQmbuCcIUN
        wh3ZVf2OSIPH0gIf3fMg4Ip6F+Vhfu90uqR70s8bj/9BGX6DPZeiU0kJFMwseFvv+QO8NX6t4fb1Y
        Q5t146rOhFqQjVGS3COL970Km1QpopnQQKGxs+6L9Ls5jmvRVxU6fGplwYaOpgqhHDPPJrYjMdGaE
        3xmDfTxvxQtn2GSJAP1paKNtiv8PryOAYKjfbl3LEKeKC0PpF90Ar2Ppja/QLcnBO3M5lnoqHePTa
        IsTDSONs9p756x0mWrUEVNNvCHEVOMNY+HggY5gDgfV2AyIQL62W9B/8bcmvEZLwSi6w5G7ZJh4Z8
        3WRs4LLw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHd-0005ug-Su; Wed, 05 Jun 2019 19:09:14 +0000
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
Subject: [PATCH 09/13] IB/srp: set virt_boundary_mask in the scsi host
Date:   Wed,  5 Jun 2019 21:08:32 +0200
Message-Id: <20190605190836.32354-10-hch@lst.de>
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
SCSI midlayer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index be9ddcad8f28..944fe8eee1ea 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3061,20 +3061,6 @@ static int srp_target_alloc(struct scsi_target *starget)
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
@@ -3277,7 +3263,6 @@ static struct scsi_host_template srp_template = {
 	.name				= "InfiniBand SRP initiator",
 	.proc_name			= DRV_NAME,
 	.target_alloc			= srp_target_alloc,
-	.slave_alloc			= srp_slave_alloc,
 	.slave_configure		= srp_slave_configure,
 	.info				= srp_target_info,
 	.queuecommand			= srp_queuecommand,
@@ -3812,6 +3797,9 @@ static ssize_t srp_create_target(struct device *dev,
 	target_host->max_cmd_len = sizeof ((struct srp_cmd *) (void *) 0L)->cdb;
 	target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
 
+	if (!(ibdev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
+		target_host->virt_boundary_mask = ~srp_dev->mr_page_mask;
+
 	target = host_to_target(target_host);
 
 	target->net		= kobj_ns_grab_current(KOBJ_NS_TYPE_NET);
-- 
2.20.1

