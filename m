Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB236430
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfFETKD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:10:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFETKD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E/iOQT4M1fyenwDbyi+jqJusuZ1NUczgmpSGXIQ2f+0=; b=M/uUYRR8pgDnnzzz4z4TbrU+9D
        GPsjq2ZKOcMVS1H8gsKcilta+otGh2XS3aUQd1ajUwasAh52+CrohDwRcmv5YXxwti+HJMhZTmjgj
        XntimabGSGg6z2wQJnWXnrymQbeHuKn5y2J+cyhPjdDYoBWVg+VuDFQA7JpL75+hU1i6vxttofkCE
        vwzndjdfQuiK3u7gXhRYVjJ1n6IgY/AJIBzsqY+2OFxomE6nc7y4rMA4ssWz0lwAPY5aND9gIDfsc
        x+JU83gIZQ+sj0n8Hw8/fU1x1+jABSSj2CQkJReliwpQmnoRoPIlFDeSjIz20A14i1edYfTctRpi3
        JIatSf2Q==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHk-00063E-KD; Wed, 05 Jun 2019 19:09:21 +0000
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
Subject: [PATCH 11/13] mpt3sas: set virt_boundary_mask in the scsi host
Date:   Wed,  5 Jun 2019 21:08:34 +0200
Message-Id: <20190605190836.32354-12-hch@lst.de>
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
SCSI midlayer.  Note that the effect is global, as the IOMMU merging
is based off a paramters in struct device.  We could still turn if off
if no PCIe devices are present, but I don't know how to find that out.

Also remove the bogus nomerges flag, merges do take the virt_boundary
into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1ccfbc7eebe0..03a0df2a3379 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2361,14 +2361,6 @@ scsih_slave_configure(struct scsi_device *sdev)
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
 		scsih_change_queue_depth(sdev, qdepth);
-		/* Enable QUEUE_FLAG_NOMERGES flag, so that IOs won't be
-		 ** merged and can eliminate holes created during merging
-		 ** operation.
-		 **/
-		blk_queue_flag_set(QUEUE_FLAG_NOMERGES,
-				sdev->request_queue);
-		blk_queue_virt_boundary(sdev->request_queue,
-				ioc->page_size - 1);
 		return 0;
 	}
 
@@ -10472,6 +10464,9 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->transportt = mpt3sas_transport_template;
 	shost->unique_id = ioc->id;
 
+	/* XXX: only strictly needed if NVMe devices are attached */
+	shost->virt_boundary_mask = ioc->page_size - 1;
+
 	if (ioc->is_mcpu_endpoint) {
 		/* mCPU MPI support 64K max IO */
 		shost->max_sectors = 128;
-- 
2.20.1

