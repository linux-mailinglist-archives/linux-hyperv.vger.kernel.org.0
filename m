Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C462DDA26
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 21:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgLQUee (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 15:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbgLQUed (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 15:34:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF2C0617B0;
        Thu, 17 Dec 2020 12:33:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m5so27885382wrx.9;
        Thu, 17 Dec 2020 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLhYv2plnIrynx5NUImRq2YwHRg3JhpcreVENKeT2U4=;
        b=jg92lS2PeB9kHQTADGed6FWU0rgQn4s0I7NcmsvHN6kzD8p/BCJW46DWUKr/zTOfwX
         xytDGg+5trVGzrmCwx1d8itL0lT6hLbAlJyS/krxW0Ed4IZCwbflVMnaAUOMa1jW9aI5
         IWz66EQgfxIOnd+YmhZa/nLqoGA9k3qIe67hT8PmS6hO3EuFRehl59wE44PEvt1yWQo2
         tvV8+yN/tv8c4zHyk6g9bhzS5R9T2bpFpIa0OzQBdCI6laWeXWwXN0pLQoHeuMoJwmQl
         C6JYG+03XqItTdLlLKXdoFpL4kPu7NvbOCL4hMxWLCZ9MsFy5eEOrbkMc+kSqblTBPWw
         Pk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLhYv2plnIrynx5NUImRq2YwHRg3JhpcreVENKeT2U4=;
        b=amSgmya//sOXMp+Rtxnnz0Qo3oFblQC8mWmWptLeb+RT742l7lTX2dWuDQK4GPUyQG
         JQ5CiiKBgrR6QW0Of7iIH9+41lm5hY+4TH1ccA8QVivP6+6dLnlA8HyIOIBhlTKMu+w9
         FDhFUF4RQ2eHWNP0sbvYFEpXP7ZPHE1xMx6yoc4sG7Umzb/ABtD805oJG8sgPr2fF3uK
         7gNYwomv6OkoEle6bXmlAqbo6F/o0xfcu/sO0EGSOIiu7i+dLRFptAte6yNoa/XIDia4
         sY0ntDBn+BLol7p3cfiIom3WOIxb5B5C37vzfmv7tgVp9DAjgVK8BonTQBXohSlWKaDQ
         1Xig==
X-Gm-Message-State: AOAM532XJkhqcyzXKQeO0Kv8tuKJxjuJypsMHi3Lf8FgV2c8IUWLWnX5
        BFXQ0qTdDQJX2FufeqgoKEw+T0N4siSygXLI
X-Google-Smtp-Source: ABdhPJx6x4tfp0LLbcj7I/I68ZJumrdIOU3ISdG25sz2Eb0CHZbY6PO+R6W88RZcgr7uJcb30xaR6Q==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr638542wru.268.1608237231730;
        Thu, 17 Dec 2020 12:33:51 -0800 (PST)
Received: from localhost.localdomain (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id a62sm11729128wmh.40.2020.12.17.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 12:33:51 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 2/3] scsi: storvsc: Resolve data race in storvsc_probe()
Date:   Thu, 17 Dec 2020 21:33:20 +0100
Message-Id: <20201217203321.4539-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217203321.4539-1-parri.andrea@gmail.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmscsi_size_delta can be written concurrently by multiple instances of
storvsc_probe(), corresponding to multiple synthetic IDE/SCSI devices;
cf. storvsc_drv's probe_type == PROBE_PREFER_ASYNCHRONOUS.  Change the
global variable vmscsi_size_delta to per-synthetic-IDE/SCSI-device.

Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/storvsc_drv.c | 45 +++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 64298aa2f151e..8714355cb63e7 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -216,18 +216,6 @@ struct vmscsi_request {
 
 } __attribute((packed));
 
-
-/*
- * The size of the vmscsi_request has changed in win8. The
- * additional size is because of new elements added to the
- * structure. These elements are valid only when we are talking
- * to a win8 host.
- * Track the correction to size we need to apply. This value
- * will likely change during protocol negotiation but it is
- * valid to start by assuming pre-Win8.
- */
-static int vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
-
 /*
  * The list of storage protocols in order of preference.
  */
@@ -449,6 +437,17 @@ struct storvsc_device {
 	unsigned char path_id;
 	unsigned char target_id;
 
+	/*
+	 * The size of the vmscsi_request has changed in win8. The
+	 * additional size is because of new elements added to the
+	 * structure. These elements are valid only when we are talking
+	 * to a win8 host.
+	 * Track the correction to size we need to apply. This value
+	 * will likely change during protocol negotiation but it is
+	 * valid to start by assuming pre-Win8.
+	 */
+	int vmscsi_size_delta;
+
 	/*
 	 * Max I/O, the device can support.
 	 */
@@ -762,7 +761,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
 			       (sizeof(struct vstor_packet) -
-			       vmscsi_size_delta),
+			       stor_device->vmscsi_size_delta),
 			       (unsigned long)request,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -816,9 +815,14 @@ static int storvsc_execute_vstor_op(struct hv_device *device,
 				    struct storvsc_cmd_request *request,
 				    bool status_check)
 {
+	struct storvsc_device *stor_device;
 	struct vstor_packet *vstor_packet;
 	int ret, t;
 
+	stor_device = get_out_stor_device(device);
+	if (!stor_device)
+		return -ENODEV;
+
 	vstor_packet = &request->vstor_packet;
 
 	init_completion(&request->wait_event);
@@ -826,7 +830,7 @@ static int storvsc_execute_vstor_op(struct hv_device *device,
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
 			       (sizeof(struct vstor_packet) -
-			       vmscsi_size_delta),
+			       stor_device->vmscsi_size_delta),
 			       (unsigned long)request,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -903,7 +907,7 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 			sense_buffer_size =
 				vmstor_protocols[i].sense_buffer_size;
 
-			vmscsi_size_delta =
+			stor_device->vmscsi_size_delta =
 				vmstor_protocols[i].vmscsi_size_delta;
 
 			break;
@@ -1249,7 +1253,7 @@ static void storvsc_on_channel_callback(void *context)
 		if (request == &stor_device->init_request ||
 		    request == &stor_device->reset_request) {
 			memcpy(&request->vstor_packet, packet,
-			       (sizeof(struct vstor_packet) - vmscsi_size_delta));
+			       (sizeof(struct vstor_packet) - stor_device->vmscsi_size_delta));
 			complete(&request->wait_event);
 		} else {
 			storvsc_on_receive(stor_device, packet, request);
@@ -1461,7 +1465,7 @@ static int storvsc_do_io(struct hv_device *device,
 	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
 
 	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
-					vmscsi_size_delta);
+					stor_device->vmscsi_size_delta);
 
 
 	vstor_packet->vm_srb.sense_info_length = sense_buffer_size;
@@ -1478,12 +1482,12 @@ static int storvsc_do_io(struct hv_device *device,
 				request->payload, request->payload_sz,
 				vstor_packet,
 				(sizeof(struct vstor_packet) -
-				vmscsi_size_delta),
+				stor_device->vmscsi_size_delta),
 				(unsigned long)request);
 	} else {
 		ret = vmbus_sendpacket(outgoing_channel, vstor_packet,
 			       (sizeof(struct vstor_packet) -
-				vmscsi_size_delta),
+				stor_device->vmscsi_size_delta),
 			       (unsigned long)request,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -1589,7 +1593,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
 			       (sizeof(struct vstor_packet) -
-				vmscsi_size_delta),
+				stor_device->vmscsi_size_delta),
 			       (unsigned long)&stor_device->reset_request,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -1939,6 +1943,7 @@ static int storvsc_probe(struct hv_device *device,
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
 	stor_device->host = host;
+	stor_device->vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
 	spin_lock_init(&stor_device->lock);
 	hv_set_drvdata(device, stor_device);
 
-- 
2.25.1

