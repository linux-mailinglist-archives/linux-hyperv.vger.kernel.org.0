Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98952C5ED1
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Nov 2020 03:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbgK0C6S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Nov 2020 21:58:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7740 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgK0C6R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Nov 2020 21:58:17 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Chznk5RHPzkgtf;
        Fri, 27 Nov 2020 10:57:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 10:58:04 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <longli@microsoft.com>, <cavery@redhat.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] scsi: storvsc: Fix error return in storvsc_probe()
Date:   Fri, 27 Nov 2020 11:02:06 +0800
Message-ID: <20201127030206.104616-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix to return a error code "-ENOMEM" from the error handling case
instead of 0.

Fixes: 436ad9413353 ("scsi: storvsc: Allow only one remove lun work item to be issued per lun")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/storvsc_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 0c65fbd41035..ded00a89bfc4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1994,8 +1994,10 @@ static int storvsc_probe(struct hv_device *device,
 			alloc_ordered_workqueue("storvsc_error_wq_%d",
 						WQ_MEM_RECLAIM,
 						host->host_no);
-	if (!host_dev->handle_error_wq)
+	if (!host_dev->handle_error_wq) {
+		ret = -ENOMEM;
 		goto err_out2;
+	}
 	INIT_WORK(&host_dev->host_scan_work, storvsc_host_scan);
 	/* Register the HBA and start the scsi bus scan */
 	ret = scsi_add_host(host, &device->device);
-- 
2.22.0

