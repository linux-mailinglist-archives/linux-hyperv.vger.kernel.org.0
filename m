Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80EC546A80
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jun 2022 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbiFJQei (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Jun 2022 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349742AbiFJQd6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Jun 2022 12:33:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B69A590BE;
        Fri, 10 Jun 2022 09:33:50 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id C1D2820BE632;
        Fri, 10 Jun 2022 09:33:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1D2820BE632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654878829;
        bh=/b3rhCsLk+dR82/EPLL1D6TioCvSqpU+hE4SbKy13BQ=;
        h=From:To:Subject:Date:From;
        b=esKR0fKGIjBKjCu22T0Ap88L1UL6DlJf8mLhdNXsQPKzuaxFB9YVh7a2uwUtR/Bj7
         gQypSQBNqC601gqM1jlGlI2pe67YLyXVF6yaJNKZCjF6bRc99lpDOd3K0tHGhzmw8R
         UpYuWjEY0C0pRcnBMPEYJlzTMMf6hemFYyB0+ot0=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH] scsi: storvsc: Correct sysfs parameters as per Hyper-V storvsc requirement
Date:   Fri, 10 Jun 2022 09:33:44 -0700
Message-Id: <1654878824-25691-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch corrects 3 parameters:
1. Correct the sysfs entry for maximum hardware transfer limit of single
   transfer (max_hw_sectors_kb) by setting max_sectors, this was set to
   default value 512kb before.
2. Correct SGL memory offset alignment as per Hyper-V page size.
3. Correct sg_tablesize which accounts for max SGL segments entries in a
   single SGL.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ca3530982e52..3e032660ae36 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1844,7 +1844,7 @@ static struct scsi_host_template scsi_driver = {
 	.cmd_per_lun =		2048,
 	.this_id =		-1,
 	/* Ensure there are no gaps in presented sgls */
-	.virt_boundary_mask =	PAGE_SIZE-1,
+	.virt_boundary_mask =	HV_HYP_PAGE_SIZE - 1,
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 	.change_queue_depth =	storvsc_change_queue_depth,
@@ -1969,11 +1969,31 @@ static int storvsc_probe(struct hv_device *device,
 	/* max cmd length */
 	host->max_cmd_len = STORVSC_MAX_CMD_LEN;
 
+	/* max_hw_sectors_kb */
+	host->max_sectors = (stor_device->max_transfer_bytes) >> 9;
 	/*
-	 * set the table size based on the info we got
-	 * from the host.
+	 * There are 2 requirements for Hyper-V storvsc sgl segments,
+	 * based on which the below calculation for max segments is
+	 * done:
+	 *
+	 * 1. Except for the first and last sgl segment, all sgl segments
+	 *    should be align to HV_HYP_PAGE_SIZE, that also means the
+	 *    maximum number of segments in a sgl can be calculated by
+	 *    dividing the total max transfer length by HV_HYP_PAGE_SIZE.
+	 *
+	 * 2. Except for the first and last, each entry in the SGL must
+	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE,
+	 *    whereas the complete length of transfer may not be aligned
+	 *    to HV_HYP_PAGE_SIZE always. This can result in 2 cases:
+	 *    Example for unaligned case: Let's say the total transfer
+	 *    length is 6 KB, the max segments will be 3 (1,4,1).
+	 *    Example for aligned case: Let's say the total transfer length
+	 *    is 8KB, then max segments will still be 3(2,4,2) and not 4.
+	 *    4 (read next higher value) segments will only be required
+	 *    once the length is at least 2 bytes more then 8KB (read any
+	 *    HV_HYP_PAGE_SIZE aligned length).
 	 */
-	host->sg_tablesize = (stor_device->max_transfer_bytes >> PAGE_SHIFT);
+	host->sg_tablesize = ((stor_device->max_transfer_bytes - 2) >> HV_HYP_PAGE_SHIFT) + 2;
 	/*
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
-- 
2.25.1

