Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E3481C1
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfFQMUT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 08:20:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfFQMUQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u9cOLJO48WXOB3dtbix3j/JKFkfHMXGferUcOdddO0s=; b=SbuVVZK4nKRDFcvtcrN1V2UCMg
        xVbKX39WvDnXIH1RIBRqxilfJSa8P7Jj8BD+YxSIHkov3XW1L74INi6IwtRGs1VyxejO6Ogn18Gbi
        CEpUzj9QmOx/EFCGk5aWM2nv4Dj1nEn6PFueILrpqIoOSvht006cS29Wvi4j3t2CmMbebDppEVeE1
        W9cJ7/Y1+PxpSN3LyyLtayCRQVxAJlB7rgBEhdqQRy8075iTTJq8h5fWjRDjMquEBW7qm5j7n/XdH
        0/53iHjyjc0n2maAChyQvTc5eTMXTA1u8o1HbCdJyUFN/sDqtEtkrposSNkQaI3kUKNIo8n1MzAkv
        tCrvOUzQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqcP-0004ft-AS; Mon, 17 Jun 2019 12:20:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] storvsc: set virt_boundary_mask in the scsi host template
Date:   Mon, 17 Jun 2019 14:19:56 +0200
Message-Id: <20190617122000.22181-5-hch@lst.de>
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
 drivers/scsi/storvsc_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index b89269120a2d..7ed6f2fc1446 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1422,9 +1422,6 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
-	/* Ensure there are no gaps in presented sgls */
-	blk_queue_virt_boundary(sdevice->request_queue, PAGE_SIZE - 1);
-
 	sdevice->no_write_same = 1;
 
 	/*
@@ -1697,6 +1694,8 @@ static struct scsi_host_template scsi_driver = {
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

