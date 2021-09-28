Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F641B3FE
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbhI1Qj2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhI1Qj1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 12:39:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0279CC06161C;
        Tue, 28 Sep 2021 09:37:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s17so66732543edd.8;
        Tue, 28 Sep 2021 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrcpzz4dtYaFlPbqYodpFsWNyFSc5+StVlE5y5OqwxM=;
        b=k5ebFqrnBLaLFSno78OpVJG5cLS0Jevk+XVX+K57MW1HGDkaNy0LzwbRiUatPwHPIC
         nqafbskkxODgUlEJSTNq+ZChz2FITbXr1JMVk00bczeaXwafIyrrmLwFTmyq+RYXiKF8
         7nAJEYU8CL135keNqGc7C22BfSkAdVjT5xNHIifeSFteOkGNcTvsIZdEaBMg7+C1bW1N
         LyW1YyjAw6/6FEnlMs1tceIJvtYz5pzTuzlx8F1yHUsudRA6Kj36UEkAigN/6RAjvEnB
         fczwwPjw+OVtyYfQri0TkusvY12RU5oZP+Zs23nVW2n1eV96z5XBECMdk0/DY487o1MC
         W58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrcpzz4dtYaFlPbqYodpFsWNyFSc5+StVlE5y5OqwxM=;
        b=4uG9bNCh2oLiEJ2BMUhJP6820kszRR0a8eEjyM6If2R37EuR4wpMYfcBNrjstzix75
         8pEVY7+mf1eJ/b8ojyNzGNDx8sQdlI4E7tsj5RfpgriEqtiyfACEPKf1ObC6GfeeVGFI
         LXED14Q5/PgWZkU5gHUvN1ulg2IKKZLyXDxovAxzORbhDTVcHxwBQ6ht7lLdw/2bSTpe
         EG8cHsUoLfUsBpyDqCKi6bk4hwVjGitLpg9iP8NYD/Tt6z2mEVC8eJavcUHQn+yh5Z3H
         hpCJbURJYkwKsqRB5ezZaAMgOT/yeBHU+GsZ4BsbmqGFZ3VNpWHoqQqtFB/o5N6AP01P
         ypiw==
X-Gm-Message-State: AOAM531LEGvDxptjBh8k+j+JVPkbvKPKSx4yQe4xhtoOHBsD9azqWR52
        uS2tleCU1G9wlNUmK9IUeSvuNRw6FzSgSg==
X-Google-Smtp-Source: ABdhPJx0IjUpgp+y/ta+eDfb+DgVaWhzMy0duDs4Sk4ZhwrKZ3FpocIZVGLBHxbFgQDHdt2M1yrubQ==
X-Received: by 2002:a17:906:7053:: with SMTP id r19mr7672281ejj.476.1632847065213;
        Tue, 28 Sep 2021 09:37:45 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id u4sm10737848ejc.19.2021.09.28.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 09:37:44 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited incoming packets
Date:   Tue, 28 Sep 2021 18:37:32 +0200
Message-Id: <20210928163732.5908-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The validation on the length of incoming packets performed in
storvsc_on_channel_callback() does not apply to "unsolicited"
packets with ID of 0 sent by Hyper-V.  Adjust the validation
by handling such unsolicited packets separately.

Fixes: 91b1b640b834b2 ("scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
The (new) bound, VSTOR_MIN_UNSOL_PKT_SIZE, was "empirically
derived" based on testing and code auditing.  This explains
the RFC tag...

 drivers/scsi/storvsc_drv.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ebbbc1299c625..a9bbcbbfb54ee 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -292,6 +292,9 @@ struct vmstorage_protocol_version {
 #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
 #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
 
+/* Lower bound on the size of unsolicited packets with ID of 0 */
+#define VSTOR_MIN_UNSOL_PKT_SIZE		48
+
 struct vstor_packet {
 	/* Requested operation type */
 	enum vstor_packet_operation operation;
@@ -1285,11 +1288,13 @@ static void storvsc_on_channel_callback(void *context)
 	foreach_vmbus_pkt(desc, channel) {
 		struct vstor_packet *packet = hv_pkt_data(desc);
 		struct storvsc_cmd_request *request = NULL;
+		u32 pktlen = hv_pkt_datalen(desc);
 		u64 rqst_id = desc->trans_id;
 
-		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
+		/* Unsolicited packets with ID of 0 are validated separately below */
+		if (rqst_id != 0 && pktlen < sizeof(struct vstor_packet) -
 				stor_device->vmscsi_size_delta) {
-			dev_err(&device->device, "Invalid packet len\n");
+			dev_err(&device->device, "Invalid packet: length=%u\n", pktlen);
 			continue;
 		}
 
@@ -1298,8 +1303,14 @@ static void storvsc_on_channel_callback(void *context)
 		} else if (rqst_id == VMBUS_RQST_RESET) {
 			request = &stor_device->reset_request;
 		} else {
-			/* Hyper-V can send an unsolicited message with ID of 0 */
 			if (rqst_id == 0) {
+				if (pktlen < VSTOR_MIN_UNSOL_PKT_SIZE) {
+					dev_err(&device->device,
+						"Invalid packet with ID of 0: length=%u\n",
+						pktlen);
+					continue;
+				}
+
 				/*
 				 * storvsc_on_receive() looks at the vstor_packet in the message
 				 * from the ring buffer.  If the operation in the vstor_packet is
-- 
2.25.1

