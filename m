Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9736420
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFETJg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:09:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfFETJf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iu6giSDQep7gyGP1lDKtlc6IYXmVnaTVrX/CCTaVb0M=; b=DjtDAC+Fj3ONzc3f/LuiTUKvxo
        SDHshO4T3HLu3MQm0sH37Fbdepe5vHrMh2X85ZIRB3VKOFCMD6eu9hbSHPVXb/JEZlTVz4fb/QaOO
        BDhpIj3EXUQVUT2d08hdmc3vkXIK09a1I2y36ZeBdJojaOBtTGQKqMEq1bBjcQ9+oxSMJ6wh9XndQ
        XFFmfRdMT7PK47VLSVOApDsSWhQlhOShT9lQkQ27wwQ5dQ9Reu8WMtU3dBcEwVqIH/+3N3VSUo+dA
        Al21lR6b/0ULA1Vne9lErcUCQ0iQn/gB9iDUQXUDKnuMLXYjLzLH5ccM+azrWJFGQdvlsLAuQBjnS
        RkEjsxRA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHo-00067d-E1; Wed, 05 Jun 2019 19:09:25 +0000
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
Subject: [PATCH 12/13] usb-storage: set virt_boundary_mask in the scsi host
Date:   Wed,  5 Jun 2019 21:08:35 +0200
Message-Id: <20190605190836.32354-13-hch@lst.de>
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
 drivers/usb/storage/scsiglue.c | 10 ----------
 drivers/usb/storage/usb.c      | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 59190d88fa9f..02c3b66b3f78 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -65,7 +65,6 @@ static const char* host_info(struct Scsi_Host *host)
 static int slave_alloc (struct scsi_device *sdev)
 {
 	struct us_data *us = host_to_us(sdev->host);
-	int maxp;
 
 	/*
 	 * Set the INQUIRY transfer length to 36.  We don't use any of
@@ -74,15 +73,6 @@ static int slave_alloc (struct scsi_device *sdev)
 	 */
 	sdev->inquiry_len = 36;
 
-	/*
-	 * USB has unusual scatter-gather requirements: the length of each
-	 * scatterlist element except the last must be divisible by the
-	 * Bulk maxpacket value.  Fortunately this value is always a
-	 * power of 2.  Inform the block layer about this requirement.
-	 */
-	maxp = usb_maxpacket(us->pusb_dev, us->recv_bulk_pipe, 0);
-	blk_queue_virt_boundary(sdev->request_queue, maxp - 1);
-
 	/*
 	 * Some host controllers may have alignment requirements.
 	 * We'll play it safe by requiring 512-byte alignment always.
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 9a79cd9762f3..b0f23f4f58e3 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -1050,6 +1050,16 @@ int usb_stor_probe2(struct us_data *us)
 	usb_autopm_get_interface_no_resume(us->pusb_intf);
 	snprintf(us->scsi_name, sizeof(us->scsi_name), "usb-storage %s",
 					dev_name(&us->pusb_intf->dev));
+
+	/*
+	 * USB has unusual scatter-gather requirements: the length of each
+	 * scatterlist element except the last must be divisible by the
+	 * Bulk maxpacket value.  Fortunately this value is always a
+	 * power of 2.  Inform the block layer about this requirement.
+	 */
+	us_to_host(us)->virt_boundary_mask =
+		usb_maxpacket(us->pusb_dev, us->recv_bulk_pipe, 0) - 1;
+
 	result = scsi_add_host(us_to_host(us), dev);
 	if (result) {
 		dev_warn(dev,
-- 
2.20.1

