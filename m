Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15EF363F3
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFETJA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:09:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfFETIz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R1iW4uk9+JYFBC35gyWtC7mOUT5yXYQUHNN7P97nTSs=; b=nWELDIOkvEALklb8DYEJm9Zola
        RrJNBquZ49c2ILoqFuo9IQ8xL3NB+D43eQeeWz9Qu3NGtpnoqt6fe5Z3qt23LgbO0AZrHiOLrkVG0
        ZiYgMaaCz50v5eHMDDXn1vLzHb1WwYJDrcO3QoLYvpifiYhzYc7kurFGdALTd/jTAcHL0B7amayZu
        Ra224tArrdENvPKP2OJD8408ZMBKOrMHWKG9DCpXalnsWvmpgzGNlmlFwR8RkXXBbJg9YJLD3UZ0G
        SH8CP7m+xSp2F1Rwk7Wir+fi6JSTF1GYG5wSOXRBTIOF4SR1H1XQanDr5hql//28S5a1hfWd6KQFJ
        bV9v36uA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHB-0005Dh-RI; Wed, 05 Jun 2019 19:08:46 +0000
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
Subject: [PATCH 02/13] rsxx: don't call dma_set_max_seg_size
Date:   Wed,  5 Jun 2019 21:08:25 +0200
Message-Id: <20190605190836.32354-3-hch@lst.de>
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

This driver does never uses dma_map_sg, so the setting is rather
pointless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rsxx/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index de9b2d2f8654..76b73ddf8fd7 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -767,7 +767,6 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 		goto failed_enable;
 
 	pci_set_master(dev);
-	dma_set_max_seg_size(&dev->dev, RSXX_HW_BLK_SIZE);
 
 	st = dma_set_mask(&dev->dev, DMA_BIT_MASK(64));
 	if (st) {
-- 
2.20.1

