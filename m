Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B3B3644A
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFETIy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:08:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfFETIy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2ex9Z2d7jbc5bnEXbMR2ptptCi3L56lPOpUN37M2uJs=; b=W0COMIoNl6a4jD0EeZ9GxwcAzE
        kGjAz0/uc4Yl0BkxnZ3awiHAA0zMlOywp/SgN4c05/W4ytpafDOMsF4VMqDBbgaJjrzMliLTiB0SH
        rY1LipvtRvSYmQhq64DFd1mGIbBshLikmieNysNbAIanhWhF+gxblbkQ4M/C78dt9P6viv0SVtimo
        o+N1OPF62BmZjkopD3TQjJQemjIZjoLNhksAHsedYsBKWsCuks/ywUtGB4EXax4+OVvzu38hDdAi9
        xFsjdBhcI7I0eIeVJC9HrGH4KLi7FOShQIlqLHmbxeYldvNmN4TF5UZpI5EcdhXmoUv5DC/XMj5gf
        TgL4v39Q==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbH8-0005D5-E5; Wed, 05 Jun 2019 19:08:42 +0000
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
Subject: [PATCH 01/13] nvme-pci: don't limit DMA segement size
Date:   Wed,  5 Jun 2019 21:08:24 +0200
Message-Id: <20190605190836.32354-2-hch@lst.de>
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

NVMe uses PRPs (or optionally unlimited SGLs) for data transfers and
has no specific limit for a single DMA segement.  Limiting the size
will cause problems because the block layer assumes PRP-ish devices
using a virt boundary mask don't have a segment limit.  And while this
is true, we also really need to tell the DMA mapping layer about it,
otherwise dma-debug will trip over it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f562154551ce..524d6bd6d095 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2513,6 +2513,12 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	dev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
+
+	/*
+	 * Don't limit the IOMMU merged segment size.
+	 */
+	dma_set_max_seg_size(dev->dev, 0xffffffff);
+
 	mutex_unlock(&dev->shutdown_lock);
 
 	/*
-- 
2.20.1

