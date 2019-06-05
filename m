Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3765363E4
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFETJM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:09:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfFETJA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q4TbxoiujTGLtL40me7CIHzcsjwa9bU5PcQWV6JWtc8=; b=p6L9DWWUBAdWW1rd75RHaZf5Wz
        o1NB2vy0nvkTLGgx7Z3C0KGh5vDV2+h92cf5+rr1usphixujK/BMgqurLiMDj0iPqoj8XM/VF0YP9
        ansQmzszjOCrsFuBG3rTIcs/QaCDWLlSIqiG3JPxDFBLvMNsipRo1c5UuIgbkGkVW6H/ObN5vk/Bw
        TA3dkCZj+vuslbH+gTS8hZxozDYskw1GB4c57p8jEYzq4+OVoD4f+fi58JtjMlgW/2sc+TsRi7Km8
        GX3hTEIAzoW+55WlEay40s0EE1Llf4e8FJIa2Zt6CepJt6QxzjWhdhfvn6550UCGQyQAds8sVXiN0
        Z48CP2ag==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHG-0005KB-0r; Wed, 05 Jun 2019 19:08:50 +0000
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
Subject: [PATCH 03/13] mtip32xx: also set max_segment_size in the device
Date:   Wed,  5 Jun 2019 21:08:26 +0200
Message-Id: <20190605190836.32354-4-hch@lst.de>
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

If we only set the max_segment_size on the queue an IOMMU merge might
create bigger segments again, so limit the IOMMU merges as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index bacfdac7161c..a14b09ab3a41 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3676,6 +3676,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	blk_queue_physical_block_size(dd->queue, 4096);
 	blk_queue_max_hw_sectors(dd->queue, 0xffff);
 	blk_queue_max_segment_size(dd->queue, 0x400000);
+	dma_set_max_seg_size(&dd->pdev->dev, 0x400000);
 	blk_queue_io_min(dd->queue, 4096);
 
 	/* Set the capacity of the device in 512 byte sectors. */
-- 
2.20.1

