Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B26481BE
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfFQMUS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 08:20:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfFQMUQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tcdrMn143Ts78QpGHmQeJDKDdB3ysuM20BTYoXIK2ys=; b=WbZMNH56ewuVfs/dzNTmQLvHdi
        zfK3X8Cyjf8E7/DCsud9mKrqUTseRKQ8JgwzZ56tGuR+LwIbVBhrWgPE3QB3n/Ux9IKKDjhoGleOG
        bil9Fs7KWBtBNEMV6EaA8p91CTmUj0EcQPjLdNApAaYGfZXJ2HZYb8EkqsEDtrkS3ZSk4LrO3zvt0
        iTw0b8Qx+8GG9pYGVAfHcRAagg1hy5DUVIFwo5d+01Jek6vJN6tV8x3OeNoBhIUQIwIEJjhwMlxi2
        JoazszsoqQx//nwLhMvzSGkbyKx3/mag8wD9rAMv4sUFqv/cI2w+ro81ba1ll3Ef+n/PcI6SD7G+d
        k9uZsq4w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqcN-0004fd-4P; Mon, 17 Jun 2019 12:20:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] ufshcd: set max_segment_size in the scsi host template
Date:   Mon, 17 Jun 2019 14:19:55 +0200
Message-Id: <20190617122000.22181-4-hch@lst.de>
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

We need to also mirror the value to the device to ensure IOMMU merging
doesn't undo it, and the SCSI host level parameter will ensure that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/ufs/ufshcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3fe3029617a8..505d625ed28d 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4587,8 +4587,6 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	struct request_queue *q = sdev->request_queue;
 
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
-	blk_queue_max_segment_size(q, PRDT_DATA_BYTE_COUNT_MAX);
-
 	return 0;
 }
 
@@ -6991,6 +6989,7 @@ static struct scsi_host_template ufshcd_driver_template = {
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
 	.can_queue		= UFSHCD_CAN_QUEUE,
+	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.sdev_groups		= ufshcd_driver_groups,
-- 
2.20.1

