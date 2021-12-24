Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18347EEAF
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Dec 2021 13:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352624AbhLXMC1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Dec 2021 07:02:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15972 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhLXMC1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Dec 2021 07:02:27 -0500
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JL5FX5y1mzVflm;
        Fri, 24 Dec 2021 19:59:12 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 24 Dec
 2021 20:02:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mikelley@microsoft.com>,
        <Tianyu.Lan@microsoft.com>, <longli@microsoft.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: storvsc: Fix unsigned comparison to zero
Date:   Fri, 24 Dec 2021 20:02:16 +0800
Message-ID: <20211224120216.35896-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 drivers/scsi/storvsc_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ae293600d799..072c752a8c36 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1837,7 +1837,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
 		struct scatterlist *sg;
 		unsigned long hvpfn, hvpfns_to_add;
-		int j, i = 0;
+		int sg_cnt, j, i = 0;
 
 		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 
@@ -1851,11 +1851,11 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
-		sg_count = scsi_dma_map(scmnd);
-		if (sg_count < 0)
+		sg_cnt = scsi_dma_map(scmnd);
+		if (sg_cnt < 0)
 			return SCSI_MLQUEUE_DEVICE_BUSY;
 
-		for_each_sg(sgl, sg, sg_count, j) {
+		for_each_sg(sgl, sg, sg_cnt, j) {
 			/*
 			 * Init values for the current sgl entry. hvpfns_to_add
 			 * is in units of Hyper-V size pages. Handling the
-- 
2.17.1

