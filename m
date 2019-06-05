Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA536427
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfFETJh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:09:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfFETJg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3bkukSS82+wj1sa4UwaAnaEsPot66Pp1IhVKWWk3PRs=; b=mGRP1yv+6nhs3018nR7FDir6MR
        yW2KpUdkVXd8h8RkJdDj1tuGagsIAIvpd1VsALfxZ1DkT4wTVouzt7qhx+73meALgT70AlcO5xLHj
        mTIETncl9oUJn/qpMemeFTJGAcf9Mk/DdNXarbduY3tsrC0BpsrAU63i+ieaDTF+frDi5rUDG95zO
        q4mlexgv5VIHBxFBUrE5p3dVpmNhgD6qhgXTrM1ZvvIMuwKpIxJce+GwGO3FW3tBca0H74QS1jVrx
        GVv4fTGrwEQe7jPzVrmoe1J027ZfC4xFWFkAjvSMCJmU9Ie+smQqtLl9B8rKE+HvIybF29GTgGbqf
        aKajtGeQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHs-0006Cv-4J; Wed, 05 Jun 2019 19:09:28 +0000
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
Subject: [PATCH 13/13] uas: set virt_boundary_mask in the scsi host
Date:   Wed,  5 Jun 2019 21:08:36 +0200
Message-Id: <20190605190836.32354-14-hch@lst.de>
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
 drivers/usb/storage/uas.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 047c5922618f..d20919e7bbf4 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -789,29 +789,9 @@ static int uas_slave_alloc(struct scsi_device *sdev)
 {
 	struct uas_dev_info *devinfo =
 		(struct uas_dev_info *)sdev->host->hostdata;
-	int maxp;
 
 	sdev->hostdata = devinfo;
 
-	/*
-	 * We have two requirements here. We must satisfy the requirements
-	 * of the physical HC and the demands of the protocol, as we
-	 * definitely want no additional memory allocation in this path
-	 * ruling out using bounce buffers.
-	 *
-	 * For a transmission on USB to continue we must never send
-	 * a package that is smaller than maxpacket. Hence the length of each
-         * scatterlist element except the last must be divisible by the
-         * Bulk maxpacket value.
-	 * If the HC does not ensure that through SG,
-	 * the upper layer must do that. We must assume nothing
-	 * about the capabilities off the HC, so we use the most
-	 * pessimistic requirement.
-	 */
-
-	maxp = usb_maxpacket(devinfo->udev, devinfo->data_in_pipe, 0);
-	blk_queue_virt_boundary(sdev->request_queue, maxp - 1);
-
 	/*
 	 * The protocol has no requirements on alignment in the strict sense.
 	 * Controllers may or may not have alignment restrictions.
@@ -1004,6 +984,22 @@ static int uas_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	 */
 	shost->can_queue = devinfo->qdepth - 2;
 
+	/*
+	 * We have two requirements here. We must satisfy the requirements of
+	 * the physical HC and the demands of the protocol, as we definitely
+	 * want no additional memory allocation in this path ruling out using
+	 * bounce buffers.
+	 *
+	 * For a transmission on USB to continue we must never send a package
+	 * that is smaller than maxpacket.  Hence the length of each scatterlist
+	 * element except the last must be divisible by the Bulk maxpacket
+	 * value.  If the HC does not ensure that through SG, the upper layer
+	 * must do that.  We must assume nothing about the capabilities off the
+	 * HC, so we use the most pessimistic requirement.
+	 */
+	shost->virt_boundary_mask =
+		usb_maxpacket(udev, devinfo->data_in_pipe, 0) - 1;
+
 	usb_set_intfdata(intf, shost);
 	result = scsi_add_host(shost, &intf->dev);
 	if (result)
-- 
2.20.1

