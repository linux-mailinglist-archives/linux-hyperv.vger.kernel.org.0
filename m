Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617E6488713
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Jan 2022 01:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiAIASK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Jan 2022 19:18:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42870 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiAIASJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Jan 2022 19:18:09 -0500
Received: from JUVAZQ-LAPTOP.ntdev.corp.microsoft.com (unknown [174.127.243.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2593620B7179;
        Sat,  8 Jan 2022 16:18:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2593620B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641687489;
        bh=Zh39nvFX2Vtr201U2ft0pGSdbQfE0lKNX7WCXpthc6g=;
        h=From:To:Cc:Subject:Date:From;
        b=QhQrv13nFG0KcmdxBoZSBvG4i0BoZd6BKz90jyDQBzLfuegPb6mcqlkPV9FZuO55s
         /fFfvLvIh6PllYl0rqw+oVpZI3VGp2aKt0G9j1VK6mzd3uaZRP7/Hp6UToVHDek/Zw
         ez3CmEx8QzJJPVOLzlcyzAwJSVUJbPIQtVfi/Mgk=
From:   Juan Vazquez <juvazq@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, mikelley@microsoft.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: storvsc: Fix storvsc_queuecommand() memory leak
Date:   Sat,  8 Jan 2022 16:17:58 -0800
Message-Id: <20220109001758.6401-1-juvazq@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix possible memory leak in error path of storvsc_queuecommand() when
DMA mapping fails.

Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
Signed-off-by: Juan Vazquez <juvazq@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2273b843d9d2..9a0bba5a51a7 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1850,8 +1850,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.offset = offset_in_hvpg;
 
 		sg_count = scsi_dma_map(scmnd);
-		if (sg_count < 0)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+		if (sg_count < 0) {
+			ret = SCSI_MLQUEUE_DEVICE_BUSY;
+			goto err_free_payload;
+		}
 
 		for_each_sg(sgl, sg, sg_count, j) {
 			/*
@@ -1886,13 +1888,18 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	put_cpu();
 
 	if (ret == -EAGAIN) {
-		if (payload_sz > sizeof(cmd_request->mpb))
-			kfree(payload);
 		/* no more space */
-		return SCSI_MLQUEUE_DEVICE_BUSY;
+		ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		goto err_free_payload;
 	}
 
 	return 0;
+
+err_free_payload:
+	if (payload_sz > sizeof(cmd_request->mpb))
+		kfree(payload);
+
+	return ret;
 }
 
 static struct scsi_host_template scsi_driver = {
-- 
2.32.0

