Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540EB481B7
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 14:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFQMUM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 08:20:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQMUL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jgA9Ci7AQa++GrkvJehEoqYi+g4K+1QHauLNZ9HwxTY=; b=d1sjX51UWpl8FUDvcTCorx2qXv
        cNA/TAMdL2HqGcHXLOgVtw5yS6Pgy9w6awlEOufCOgzYn9Yo+ODjCMwlkJ1BPUj2lpr22amhwPtVF
        kJb2G5qXC88RE8K9dfSK1ZwZNlqeTZKkp2cLL/DBIVxzhYRF0huY4/ii/urMM+fMCoh6Et80Xvtz3
        jwsVBbDXC1uKlbCL7KrYKlq16Fi/QgkwRAckzXosxghywWmVluEkNo3R1x6p32jW4QwDMY8Qv8S5q
        djo4CV6QR14ST3ZadnWklAVTod9qu2QRvGdix3QQm7gbdFWK3jVfkzckLD4557BDXCV8rR6/q7Ggj
        9j18861Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqcK-0004So-SC; Mon, 17 Jun 2019 12:20:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] scsi: take the DMA max mapping size into account
Date:   Mon, 17 Jun 2019 14:19:54 +0200
Message-Id: <20190617122000.22181-3-hch@lst.de>
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

We need to limit the devices max_sectors to what the DMA mapping
implementation can support.  If not we risk running out of swiotlb
buffers easily.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d333bb6b1c59..f233bfd84cd7 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1768,6 +1768,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 		blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
 	}
 
+	shost->max_sectors = min_t(unsigned int, shost->max_sectors,
+			dma_max_mapping_size(dev) << SECTOR_SHIFT);
 	blk_queue_max_hw_sectors(q, shost->max_sectors);
 	if (shost->unchecked_isa_dma)
 		blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);
-- 
2.20.1

