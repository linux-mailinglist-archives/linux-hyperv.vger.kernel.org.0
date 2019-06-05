Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197EC363E6
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfFETJT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:09:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfFETJS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ft2pGuvl7lOdipsW5yXOzcXLvsOnET6aGSo+dOUOkYE=; b=e/LRwE9rAPGwNv/3w25xvDQ/yU
        XrfQV4bNSr3EZ2VqzRz6SXbHPy/59Kbccl4U5FVoa7eEfXV2RfR+PoG7rmjg36NtRLsSbNmnvSNJj
        lDzKzhbP36+QwCDxfau3aYGvhYwi/QRkBnAWzpyGjQ6t3cNAEnRBdirghH92UHb+nBo59MPcCA6BF
        NJLHNNfzljpAK8SsVLk5O3dSaSK1K9h7Lay+DsxZLpRpq1rPKoFj6RdBxdvOBotGUSzsqV9ADYYPv
        KfAqNXWyVRTh4D6wftFOSQF9qA+5SyiNWpmZcn30FaT4mc+8P8mFr8rZ4r1vaPW3R9iusGdJdXRMG
        +07J9XIA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHW-0005ir-71; Wed, 05 Jun 2019 19:09:07 +0000
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
Subject: [PATCH 07/13] storvsc: set virt_boundary_mask in the scsi host template
Date:   Wed,  5 Jun 2019 21:08:30 +0200
Message-Id: <20190605190836.32354-8-hch@lst.de>
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
 drivers/scsi/storvsc_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8472de1007ff..e61051c026f6 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1434,9 +1434,6 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
-	/* Ensure there are no gaps in presented sgls */
-	blk_queue_virt_boundary(sdevice->request_queue, PAGE_SIZE - 1);
-
 	sdevice->no_write_same = 1;
 
 	/*
@@ -1709,6 +1706,8 @@ static struct scsi_host_template scsi_driver = {
 	.this_id =		-1,
 	/* Make sure we dont get a sg segment crosses a page boundary */
 	.dma_boundary =		PAGE_SIZE-1,
+	/* Ensure there are no gaps in presented sgls */
+	.virt_boundary_mask =	PAGE_SIZE-1,
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 };
-- 
2.20.1

