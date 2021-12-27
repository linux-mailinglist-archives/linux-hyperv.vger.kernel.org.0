Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CA47FA03
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Dec 2021 05:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhL0EDZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Dec 2021 23:03:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15982 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhL0EDZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Dec 2021 23:03:25 -0500
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JMkTN0ldxzZdqG;
        Mon, 27 Dec 2021 12:00:08 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 27 Dec
 2021 12:03:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mikelley@microsoft.com>,
        <Tianyu.Lan@microsoft.com>, <longli@microsoft.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] scsi: storvsc: Fix unsigned comparison to zero
Date:   Mon, 27 Dec 2021 12:03:11 +0800
Message-ID: <20211227040311.54584-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The unsigned variable sg_count is being assigned a return value
from the call to scsi_dma_map() that can return -ENOMEM.

Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: define sg_count as int type
---
 drivers/scsi/storvsc_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ae293600d799..2273b843d9d2 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1753,7 +1753,6 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	struct hv_device *dev = host_dev->dev;
 	struct storvsc_cmd_request *cmd_request = scsi_cmd_priv(scmnd);
 	struct scatterlist *sgl;
-	unsigned int sg_count;
 	struct vmscsi_request *vm_srb;
 	struct vmbus_packet_mpb_array  *payload;
 	u32 payload_sz;
@@ -1826,18 +1825,17 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
 
 	sgl = (struct scatterlist *)scsi_sglist(scmnd);
-	sg_count = scsi_sg_count(scmnd);
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
 	payload_sz = sizeof(cmd_request->mpb);
 
-	if (sg_count) {
+	if (scsi_sg_count(scmnd)) {
 		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
 		struct scatterlist *sg;
 		unsigned long hvpfn, hvpfns_to_add;
-		int j, i = 0;
+		int j, i = 0, sg_count;
 
 		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 
-- 
2.17.1

