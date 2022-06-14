Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB4754A9FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jun 2022 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351301AbiFNHGB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Jun 2022 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiFNHGB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Jun 2022 03:06:01 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 462C3252B0;
        Tue, 14 Jun 2022 00:06:00 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E161F20C29E6;
        Tue, 14 Jun 2022 00:05:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E161F20C29E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655190359;
        bh=+3/54BhUR1W1pwPgw+oEYfy2SbEZH8TjXALpQuOqiIw=;
        h=From:To:Subject:Date:From;
        b=iC7d5RxcZxM6pDwfI6AUbnj8lG9co9+2yaTpyTf2Runnz7aYgwMCV1FbKs3dkidmG
         hLZKPLkEtBdSOfkngpeFBwBYqh0OC1MV8+RtCKnyS2D3iTWUNr4nwiasLwnzFAwmzu
         J4u9pSZVTwnDYk7o6vkMFVUGU+N4O9rbaErrmjF8=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH v3] scsi: storvsc: Correct reporting of Hyper-V I/O size limits
Date:   Tue, 14 Jun 2022 00:05:55 -0700
Message-Id: <1655190355-28722-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Current code is based on the idea that the max number of SGL entries
also determines the max size of an I/O request.  While this idea was
true in older versions of the storvsc driver when SGL entry length
was limited to 4 Kbytes, commit 3d9c3dcc58e9 ("scsi: storvsc: Enable
scatterlist entry lengths > 4Kbytes") removed that limitation. It's
now theoretically possible for the block layer to send requests that
exceed the maximum size supported by Hyper-V. This problem doesn't
currently happen in practice because the block layer defaults to a
512 Kbyte maximum, while Hyper-V in Azure supports 2 Mbyte I/O sizes.
But some future configuration of Hyper-V could have a smaller max I/O
size, and the block layer could exceed that max.

Fix this by correctly setting max_sectors as well as sg_tablesize to
reflect the maximum I/O size that Hyper-V reports. While allowing
I/O sizes larger than the block layer default of 512 Kbytes doesn’t
provide any noticeable performance benefit in the tests we ran, it's
still appropriate to report the correct underlying Hyper-V capabilities
to the Linux block layer.

Also tweak the virt_boundary_mask to reflect that the required
alignment derives from Hyper-V communication using a 4 Kbyte page size,
and not on the guest page size, which might be bigger (eg. ARM64).

Fixes: 3d9c3dcc58e9 ("scsi: storvsc: Enable scatter list entry lengths > 4Kbytes")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
V3
  - Remove single quotes around the 'Fixes' tag
  - max_tx_bytes -> max_xfer_bytes
  - Added empty line at start of comment

 drivers/scsi/storvsc_drv.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ca35309..fe000da 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1844,7 +1844,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	.cmd_per_lun =		2048,
 	.this_id =		-1,
 	/* Ensure there are no gaps in presented sgls */
-	.virt_boundary_mask =	PAGE_SIZE-1,
+	.virt_boundary_mask =	HV_HYP_PAGE_SIZE - 1,
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 	.change_queue_depth =	storvsc_change_queue_depth,
@@ -1895,6 +1895,7 @@ static int storvsc_probe(struct hv_device *device,
 	int target = 0;
 	struct storvsc_device *stor_device;
 	int max_sub_channels = 0;
+	u32 max_xfer_bytes;
 
 	/*
 	 * We support sub-channels for storage on SCSI and FC controllers.
@@ -1968,12 +1969,28 @@ static int storvsc_probe(struct hv_device *device,
 	}
 	/* max cmd length */
 	host->max_cmd_len = STORVSC_MAX_CMD_LEN;
-
 	/*
-	 * set the table size based on the info we got
-	 * from the host.
+	 * Any reasonable Hyper-V configuration should provide
+	 * max_transfer_bytes value aligning to HV_HYP_PAGE_SIZE,
+	 * protecting it from any weird value.
+	 */
+	max_xfer_bytes = round_down(stor_device->max_transfer_bytes, HV_HYP_PAGE_SIZE);
+	/* max_hw_sectors_kb */
+	host->max_sectors = max_xfer_bytes >> 9;
+	/*
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
+	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE.
 	 */
-	host->sg_tablesize = (stor_device->max_transfer_bytes >> PAGE_SHIFT);
+	host->sg_tablesize = (max_xfer_bytes >> HV_HYP_PAGE_SHIFT) + 1;
 	/*
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
-- 
1.8.3.1

