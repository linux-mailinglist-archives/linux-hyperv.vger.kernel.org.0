Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2D481CB
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfFQMU1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 08:20:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfFQMUY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QmF+hMORbQndpCz32PB+cZz6ZyE8AYGsI14jgQiJTGk=; b=b/Db0BK20TJuwRjOioLVHLjfCP
        h0tNT6G+x72Lb4VACGbEjLKCc2EuIorIcUIk9AjaDE40GJ1TGwMHfizV9PYWXJwG0aaxpjF6pssHC
        n9KdkoApYCeHtw3BBhh3ksfCB0QgJ52hSU2Mz9QF8wrEXte7SlPAHC5AdHuL2Gqql87SxzSI2ivWh
        9VdpkfuSLKJhmFJF3+1+1bolgO0OHXcQPBbYx10GjZxfvZLBw9JjG6NBOi6coBDLpbSZyVhmB4Lqr
        wr8eE/xR16kTjIKNT7AOV9jfx2e8yqxuZTdBZ/Ev1K0ETjeySqndLq0HnXl8ymTavhst/9jyH3PK/
        ZZ9NnB7A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqcY-0004hd-7k; Mon, 17 Jun 2019 12:20:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] megaraid_sas: set an unlimited max_segment_size
Date:   Mon, 17 Jun 2019 14:20:00 +0200
Message-Id: <20190617122000.22181-9-hch@lst.de>
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
megaraid_sas controllers we require an unlimited max_segment_size, as
the virt boundary merging code assumes that.  But we also need to
propagate that to the DMA mapping layer to make dma-debug happy.  The
SCSI layer takes care of that when using the per-host virt_boundary
setting, but given that megaraid_sas only wants to set the virt_boundary
for actual NVMe devices we can't rely on that.  The DMA layer maximum
segment is global to the HBA however, so we have to set it explicitly.
This patch assumes that megaraid_sas does not have a segment size
limitation, which seems true based on the SGL format, but will need
to be verified.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3dd1df472dc6..59f709dbbab9 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3207,6 +3207,7 @@ static struct scsi_host_template megasas_template = {
 	.shost_attrs = megaraid_host_attrs,
 	.bios_param = megasas_bios_param,
 	.change_queue_depth = scsi_change_queue_depth,
+	.max_segment_size = 0xffffffff,
 	.no_write_same = 1,
 };
 
-- 
2.20.1

