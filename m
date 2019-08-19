Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4494E62
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Aug 2019 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfHSTfp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 15:35:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33596 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfHSTfp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 15:35:45 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 4DA6E20B7188; Mon, 19 Aug 2019 12:35:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DA6E20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1566243344;
        bh=AWEcia4tfszUrPYI1tm9PW2DuitYh1vBatPMoqXQ3xQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Z6v20zJrjqckfyfofVImX4AyfVdGBjNQWFT3upVlbKz0JK47KHzGmlip3OheHcI7w
         tqfz+BvbDeEDLBffQpqoX/klvC0PP3HKv7ulaP1HrvgDrvDPimUJw3Qz8ANBeadbvY
         CiGZXWmsA75iVzY2379siWB4mAs2TNu08I15JIp0=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH] storvsc: setup 1:1 mapping between hardware queue and CPU queue
Date:   Mon, 19 Aug 2019 12:35:16 -0700
Message-Id: <1566243316-113690-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

storvsc doesn't use a dedicated hardware queue for a given CPU queue. When
issuing I/O, it selects returning CPU (hardware queue) dynamically based on
vmbus channel usage across all channels.

This patch sets up a 1:1 mapping between hardware queue and CPU queue, thus
avoiding unnecessary locking at upper layer when issuing I/O.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index b89269120a2d..26c16d40ec46 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1682,6 +1682,18 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	return 0;
 }
 
+static int storvsc_map_queues(struct Scsi_Host *shost)
+{
+	unsigned int cpu;
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	for_each_possible_cpu(cpu) {
+		qmap->mq_map[cpu] = cpu;
+	}
+
+	return 0;
+}
+
 static struct scsi_host_template scsi_driver = {
 	.module	=		THIS_MODULE,
 	.name =			"storvsc_host_t",
@@ -1697,6 +1709,7 @@ static struct scsi_host_template scsi_driver = {
 	.this_id =		-1,
 	/* Make sure we dont get a sg segment crosses a page boundary */
 	.dma_boundary =		PAGE_SIZE-1,
+	.map_queues =		storvsc_map_queues,
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 };
@@ -1836,8 +1849,7 @@ static int storvsc_probe(struct hv_device *device,
 	/*
 	 * Set the number of HW queues we are supporting.
 	 */
-	if (stor_device->num_sc != 0)
-		host->nr_hw_queues = stor_device->num_sc + 1;
+	host->nr_hw_queues = num_possible_cpus();
 
 	/*
 	 * Set the error handler work queue.
-- 
2.17.1

