Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0036433
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFETKT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:10:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFETKT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rAru/g/esClPI2WAaX3PUnaPhvPum8MkxndH0C4U79k=; b=h9hxrx3ykj4KhmvSEPus00VJa6
        wvVDeIH1Qmut2HOHh/RUxiNzSd7gwfRDYSTkLIyqZpUjAbtS5mq55akT0u2mxUTK2z8cSjd/b54dM
        8aoShnW2SqajrE0K8QIVYm2+5j17/DSdIwU3B2iaI+1dOtzkF/E438wsnCRgFlD5sFaqU603aIb5u
        kVWlr+kPIav7QdEej0kJJO6MTlHZQ/6JvBpLs2oeS3bw37SVpNNCNhOIsWeEgnoh0cjM2mzGF3iyr
        QBZD9DNwuko7J2FmoHon7WLxIokgm/Hd8Zkv1CPk1/CwxtBoRMdASJIL8Rlts4b10DQOlSqyKq3fi
        L1gaY8ew==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbHa-0005od-3i; Wed, 05 Jun 2019 19:09:10 +0000
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
Subject: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
Date:   Wed,  5 Jun 2019 21:08:31 +0200
Message-Id: <20190605190836.32354-9-hch@lst.de>
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
 drivers/infiniband/ulp/iser/iscsi_iser.c | 35 +++++-------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 9c185a8dabd3..841b66397a57 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -613,6 +613,7 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
 	struct Scsi_Host *shost;
 	struct iser_conn *iser_conn = NULL;
 	struct ib_conn *ib_conn;
+	struct ib_device *ib_dev;
 	u32 max_fr_sectors;
 
 	shost = iscsi_host_alloc(&iscsi_iser_sht, 0, 0);
@@ -643,16 +644,19 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
 		}
 
 		ib_conn = &iser_conn->ib_conn;
+		ib_dev = ib_conn->device->ib_device;
 		if (ib_conn->pi_support) {
-			u32 sig_caps = ib_conn->device->ib_device->attrs.sig_prot_cap;
+			u32 sig_caps = ib_dev->attrs.sig_prot_cap;
 
 			scsi_host_set_prot(shost, iser_dif_prot_caps(sig_caps));
 			scsi_host_set_guard(shost, SHOST_DIX_GUARD_IP |
 						   SHOST_DIX_GUARD_CRC);
 		}
 
-		if (iscsi_host_add(shost,
-				   ib_conn->device->ib_device->dev.parent)) {
+		if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
+			shost->virt_boundary_mask = ~MASK_4K;
+
+		if (iscsi_host_add(shost, ib_dev->dev.parent)) {
 			mutex_unlock(&iser_conn->state_mutex);
 			goto free_host;
 		}
@@ -958,30 +962,6 @@ static umode_t iser_attr_is_visible(int param_type, int param)
 	return 0;
 }
 
-static int iscsi_iser_slave_alloc(struct scsi_device *sdev)
-{
-	struct iscsi_session *session;
-	struct iser_conn *iser_conn;
-	struct ib_device *ib_dev;
-
-	mutex_lock(&unbind_iser_conn_mutex);
-
-	session = starget_to_session(scsi_target(sdev))->dd_data;
-	iser_conn = session->leadconn->dd_data;
-	if (!iser_conn) {
-		mutex_unlock(&unbind_iser_conn_mutex);
-		return -ENOTCONN;
-	}
-	ib_dev = iser_conn->ib_conn.device->ib_device;
-
-	if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
-		blk_queue_virt_boundary(sdev->request_queue, ~MASK_4K);
-
-	mutex_unlock(&unbind_iser_conn_mutex);
-
-	return 0;
-}
-
 static struct scsi_host_template iscsi_iser_sht = {
 	.module                 = THIS_MODULE,
 	.name                   = "iSCSI Initiator over iSER",
@@ -994,7 +974,6 @@ static struct scsi_host_template iscsi_iser_sht = {
 	.eh_device_reset_handler= iscsi_eh_device_reset,
 	.eh_target_reset_handler = iscsi_eh_recover_target,
 	.target_alloc		= iscsi_target_alloc,
-	.slave_alloc            = iscsi_iser_slave_alloc,
 	.proc_name              = "iscsi_iser",
 	.this_id                = -1,
 	.track_queue_depth	= 1,
-- 
2.20.1

