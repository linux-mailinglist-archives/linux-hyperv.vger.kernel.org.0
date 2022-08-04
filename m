Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3689C589EF9
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiHDPzk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Aug 2022 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHDPzk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Aug 2022 11:55:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 346691EC7F;
        Thu,  4 Aug 2022 08:55:39 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id C382820FE2E9;
        Thu,  4 Aug 2022 08:55:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C382820FE2E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659628538;
        bh=QXebqW0hrTf1CNPskOs0B1CdiWnWrgrHvmlsTreY3iI=;
        h=From:To:Subject:Date:From;
        b=XpAj+s7/UC4KrfmgO/5uErQKsx6pZJ8EHfMK18MyuRgk/rKSyDhrTNt03kGN/2Df/
         AJjH7WkAn0wsu1icQFF7aR0A7BcOPVWeSIRIWQ4yog8Ig6L1nvLd4/uMvviZxxcHcG
         /yYEE/8fDSkPoaCeODHUnywF2FBS3zdc+Mz3XqDY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH v2] scsi: storvsc: Remove WQ_MEM_RECLAIM from storvsc_error_wq
Date:   Thu,  4 Aug 2022 08:55:34 -0700
Message-Id: <1659628534-17539-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

storvsc_error_wq workqueue should not be marked as WQ_MEM_RECLAIM
as it doesn't need to make forward progress under memory pressure.
Marking this workqueue as WQ_MEM_RECLAIM may cause deadlock while
flushing a non-WQ_MEM_RECLAIM workqueue.
In the current state it causes the following warning:

[   14.506347] ------------[ cut here ]------------
[   14.506354] workqueue: WQ_MEM_RECLAIM storvsc_error_wq_0:storvsc_remove_lun is flushing !WQ_MEM_RECLAIM events_freezable_power_:disk_events_workfn
[   14.506360] WARNING: CPU: 0 PID: 8 at <-snip->kernel/workqueue.c:2623 check_flush_dependency+0xb5/0x130
[   14.506390] CPU: 0 PID: 8 Comm: kworker/u4:0 Not tainted 5.4.0-1086-azure #91~18.04.1-Ubuntu
[   14.506391] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022
[   14.506393] Workqueue: storvsc_error_wq_0 storvsc_remove_lun
[   14.506395] RIP: 0010:check_flush_dependency+0xb5/0x130
		<-snip->
[   14.506408] Call Trace:
[   14.506412]  __flush_work+0xf1/0x1c0
[   14.506414]  __cancel_work_timer+0x12f/0x1b0
[   14.506417]  ? kernfs_put+0xf0/0x190
[   14.506418]  cancel_delayed_work_sync+0x13/0x20
[   14.506420]  disk_block_events+0x78/0x80
[   14.506421]  del_gendisk+0x3d/0x2f0
[   14.506423]  sr_remove+0x28/0x70
[   14.506427]  device_release_driver_internal+0xef/0x1c0
[   14.506428]  device_release_driver+0x12/0x20
[   14.506429]  bus_remove_device+0xe1/0x150
[   14.506431]  device_del+0x167/0x380
[   14.506432]  __scsi_remove_device+0x11d/0x150
[   14.506433]  scsi_remove_device+0x26/0x40
[   14.506434]  storvsc_remove_lun+0x40/0x60
[   14.506436]  process_one_work+0x209/0x400
[   14.506437]  worker_thread+0x34/0x400
[   14.506439]  kthread+0x121/0x140
[   14.506440]  ? process_one_work+0x400/0x400
[   14.506441]  ? kthread_park+0x90/0x90
[   14.506443]  ret_from_fork+0x35/0x40
[   14.506445] ---[ end trace 2d9633159fdc6ee7 ]---

Fixes: 436ad9413353 ("scsi: storvsc: Allow only one remove lun work item to be issued per lun")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[v2]
  - s/it's/it/
  - Added Fixes commit

 drivers/scsi/storvsc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index fe000da..8ced292 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -2012,7 +2012,7 @@ static int storvsc_probe(struct hv_device *device,
 	 */
 	host_dev->handle_error_wq =
 			alloc_ordered_workqueue("storvsc_error_wq_%d",
-						WQ_MEM_RECLAIM,
+						0,
 						host->host_no);
 	if (!host_dev->handle_error_wq) {
 		ret = -ENOMEM;
-- 
1.8.3.1

