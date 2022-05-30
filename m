Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFB5376FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 May 2022 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiE3Ijj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 May 2022 04:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiE3Ijj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 May 2022 04:39:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 848F9643F;
        Mon, 30 May 2022 01:39:38 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A7D420BA5D8;
        Mon, 30 May 2022 01:39:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A7D420BA5D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653899978;
        bh=isQm+mC6yQ0sCy8PaEq3jIAYfeo6j5NEVgjYF1/d2VQ=;
        h=From:To:Subject:Date:From;
        b=QiJ6Q5H4Cxr7tpdjLd9/Zo4nh7OqYynFyIfiqUdZCvEyjR3PgKtAY8AtZKU1G+WMt
         WIkICuv/HhEA1XD2EqC4cNsNi1zzRhavo0D/Q+M8bTZ4bapK4hCGVfUNlGkLxACOz3
         Vt5rCNURYrMKN7nznkz8xpN0cB6kdN/vWF1UKM9g=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH] scsi: storvsc: Enabling WRITE_SAME
Date:   Mon, 30 May 2022 01:39:33 -0700
Message-Id: <1653899973-21039-1-git-send-email-ssengar@linux.microsoft.com>
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

This driver already has code logic for WRITE_SAME, but was never working
because of a bug where WRITE_SAME is disabled at scsi controller level.
Apparently if WRITE_SAME is disabled at scsi controller level it takes
precedence over disk level setting. This patch fixes this bug, and enables
this feature only for VMSTOR protocol version 10.0 and above.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ca35309..3e55687 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -50,6 +50,7 @@
  * Win8: 5.1
  * Win8.1: 6.0
  * Win10: 6.2
+ * Win10.1: 10.0
  */
 
 #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) | \
@@ -59,6 +60,7 @@
 #define VMSTOR_PROTO_VERSION_WIN8	VMSTOR_PROTO_VERSION(5, 1)
 #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
 #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
+#define VMSTOR_PROTO_VERSION_WIN10_1	VMSTOR_PROTO_VERSION(10, 0)
 
 /*  Packet structure describing virtual storage requests. */
 enum vstor_packet_operation {
@@ -205,6 +207,7 @@ struct vmscsi_request {
  */
 
 static const int protocol_version[] = {
+		VMSTOR_PROTO_VERSION_WIN10_1,
 		VMSTOR_PROTO_VERSION_WIN10,
 		VMSTOR_PROTO_VERSION_WIN8_1,
 		VMSTOR_PROTO_VERSION_WIN8,
@@ -1558,7 +1561,7 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 			break;
 		}
 
-		if (vmstor_proto_version >= VMSTOR_PROTO_VERSION_WIN10)
+		if (vmstor_proto_version >= VMSTOR_PROTO_VERSION_WIN10_1)
 			sdevice->no_write_same = 0;
 	}
 
@@ -1845,7 +1848,6 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	.this_id =		-1,
 	/* Ensure there are no gaps in presented sgls */
 	.virt_boundary_mask =	PAGE_SIZE-1,
-	.no_write_same =	1,
 	.track_queue_depth =	1,
 	.change_queue_depth =	storvsc_change_queue_depth,
 };
-- 
1.8.3.1

