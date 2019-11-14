Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C254DFD146
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Nov 2019 00:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKNXBd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Nov 2019 18:01:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33242 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNXBd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Nov 2019 18:01:33 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 6CA9120110BD; Thu, 14 Nov 2019 15:01:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CA9120110BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1573772492;
        bh=Ckk87F5MC07qtgzW/3HfYOthBvz6QWmpl5e5thFSOf8=;
        h=From:To:Cc:Subject:Date:From;
        b=gvWYGLhtDUn3goNXxVYHrRg6RqeoknZZwUWDSqtNOAi8FQsp4UTKYSLg5E2Gt+cDj
         BbQsZf/bWA2znltYAEoUbUPpUJPnDMK53Pr2W+iBz0Kt7lSnpwdhvgCFpmrXOnqJYi
         DVustrb2a3jo8O+KNwoJMHZumxPbjv94qlPODxfI=
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
Subject: [PATCH] storvsc: Properly set queue depth for scsi disk
Date:   Thu, 14 Nov 2019 15:01:26 -0800
Message-Id: <1573772486-40662-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

The disk queue depth should be set based on host queue depth.

While it's possible that we may have multiple disks on the host, the combined
queue depths from those disks may exceed host queue depth. It's still better
than hard-coding them.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 542d2bac2922..12c499f5da44 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1442,6 +1442,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 			sdevice->no_write_same = 0;
 	}
 
+	scsi_change_queue_depth(sdevice, sdevice->host->can_queue);
+
 	return 0;
 }
 
@@ -1691,7 +1693,6 @@ static struct scsi_host_template scsi_driver = {
 	.eh_timed_out =		storvsc_eh_timed_out,
 	.slave_alloc =		storvsc_device_alloc,
 	.slave_configure =	storvsc_device_configure,
-	.cmd_per_lun =		2048,
 	.this_id =		-1,
 	/* Make sure we dont get a sg segment crosses a page boundary */
 	.dma_boundary =		PAGE_SIZE-1,
-- 
2.20.1

