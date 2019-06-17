Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0E481C7
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFQMUY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 08:20:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfFQMUW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Dq9Njb+qhzSDcsVPaU4aYBgOsheFWdLFfOs+ZTIErU=; b=YjywLrl2OwDF9FbLBlrS9/G0uJ
        8Kr1bQQtMXvYRu9o4CPnBOLicChZA0FXMPJFr8WOrt2gbE7Ipowf5gAjyAKMU97rbr6u2DZAzqIAK
        +IidUOPG+BdLxqrcXfc8z1A+F+AzdNBiWe2utwrcXdgSOLRkaMMKgXvreIy4lP7jdvnB0H+x64wPR
        44ZHlB8x657qAgPFUAkl3vTugaYSVC+5bz9HxBFVYyrDOB2iv04LpgBexo4ofl0QzXdJFq4rwz6yj
        fb3c2OdrYwmDVMdyAuzgW70cCXy3YyAqpzPHCR59QtoLy92t9JGh8dMwlSP0+mPLopuKhFTyz1DGB
        WCOir/1Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqcW-0004h7-1v; Mon, 17 Jun 2019 12:20:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] mpt3sas: set an unlimited max_segment_size for SAS 3.0 HBAs
Date:   Mon, 17 Jun 2019 14:19:59 +0200
Message-Id: <20190617122000.22181-8-hch@lst.de>
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

When using a virt_boundary_mask, as done for NVMe devices attached to
mpt3sas controllers we require an unlimited max_segment_size, as the
virt boundary merging code assumes that.  But we also need to propagate
that to the DMA mapping layer to make dma-debug happy.  The SCSI layer
takes care of that when using the per-host virt_boundary setting, but
given that mpt3sas only wants to set the virt_boundary for actual
NVMe devices we can't rely on that.  The DMA layer maximum segment
is global to the HBA however, so we have to set it explicitly.  This
patch assumes that mpt3sas does not have a segment size limitation,
which seems true based on the SGL format, but will need to be verified.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1ccfbc7eebe0..c719b807f6d8 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10222,6 +10222,7 @@ static struct scsi_host_template mpt3sas_driver_template = {
 	.this_id			= -1,
 	.sg_tablesize			= MPT3SAS_SG_DEPTH,
 	.max_sectors			= 32767,
+	.max_segment_size		= 0xffffffff,
 	.cmd_per_lun			= 7,
 	.shost_attrs			= mpt3sas_host_attrs,
 	.sdev_attrs			= mpt3sas_dev_attrs,
-- 
2.20.1

