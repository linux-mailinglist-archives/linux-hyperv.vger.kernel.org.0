Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7B425300
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Oct 2021 14:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbhJGMag (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Oct 2021 08:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbhJGMaf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Oct 2021 08:30:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E7C061746;
        Thu,  7 Oct 2021 05:28:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b8so22535598edk.2;
        Thu, 07 Oct 2021 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gW5u4BhwhxG/oEIcngyv5/5SCvI3u+z/IqA8blrDDU=;
        b=VkDn2D93CoawI9XWWfHasf5S3RWzT/k7uvP19/IBwH0XAdrAo5zRZiZ8jK4xksx0xp
         jihJDyxYBHRfmjP9KFK//j7RJYSlGfG7pvEROd8nOAfkCE9gSr3n0S/gVzADJedwlv/R
         dUa3lirdU94qEfOXMStWaxH1fZ9oWllmvuYPNz5G0YDcVRD/gqmDvQzhktHkCmyNr3Wd
         aDusuaQCAHyRGrc19KG01HsCNxcjIE2QwxZSHeu/IwmyLmzQeglxg+mQXYwEgOhgSmuX
         RXWIxkYyEpQbv5vWGyhMQPKVmI/+cMSabVP4yo1Z4eF9Z5pfLi6rp5b4d4iL6GqvNRpx
         HAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gW5u4BhwhxG/oEIcngyv5/5SCvI3u+z/IqA8blrDDU=;
        b=ktziQ+O4rEjpwYTm1M9LnYEYKXUa8N3amw5N4/Lr7do6Eztb+3Qg9ufO+iUyIy31Co
         TIICUYGE/19firhrUfMFuY+nU3w2iD0Iu9an3hCaH0Go9i64SXlxk+dxT2FcXIQn8wfY
         u+CsHUwC4LNzrbUvrtf9rdHzFL0vMP+qnMgYWwT+5TKtyJyL0+MfDKo9Wg9maLLHZpvh
         mLJHutw9cffJnw5RJqFwp4qtl8wD/6bVl4s25jg1U7ci5MXLu+XshTzVLpxavKGxphU5
         Yfhmmi0u8aosuMikZPSpKVAlNzYUPIewXfCz5K0TBa76jNo2/IebklfNXfxSdZmepx6B
         INSg==
X-Gm-Message-State: AOAM5337JUim52o+j2kikREe8PsdpTpSvrPKgwwF/37qfmPx8T3rRUMv
        lVJzfUfWMGJ8+WIjL64uh6FI/NqQOjm09gvmN1E=
X-Google-Smtp-Source: ABdhPJz4FI7itBtEDRp3CzwWLpZdPRV57fg4dHaHnuD2URnnOUp9n3b/yi2ojIx0rXn+YPlCKqV5UQ==
X-Received: by 2002:a17:906:3cb:: with SMTP id c11mr5446794eja.404.1633609720213;
        Thu, 07 Oct 2021 05:28:40 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id d17sm7124216edv.58.2021.10.07.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:28:39 -0700 (PDT)
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
Subject: [PATCH v3] scsi: storvsc: Fix validation for unsolicited incoming packets
Date:   Thu,  7 Oct 2021 14:28:28 +0200
Message-Id: <20211007122828.469289-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The validation on the length of incoming packets performed in
storvsc_on_channel_callback() does not apply to unsolicited
packets with ID of 0 sent by Hyper-V.  Adjust the validation
for such unsolicited packets.

Fixes: 91b1b640b834b2 ("scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
Changes since v2[1]:
  - Adjust inline comments (Michael Kelley)

Changes since v1[2]:
  - Use sizeof(enum vstor_packet_operation) instead of 48 (Michael Kelley)
  - Filter out FCHBA_DATA packets (Michael Kelley)

Changes since RFC[3]:
  - Merge length checks (Haiyang Zhang)

[1] https://lkml.kernel.org/r/20211006132026.4089-1-parri.andrea@gmail.com
[2] https://lkml.kernel.org/r/20211005114103.3411-1-parri.andrea@gmail.com
[3] https://lkml.kernel.org/r/20210928163732.5908-1-parri.andrea@gmail.com

 drivers/scsi/storvsc_drv.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ebbbc1299c625..9eb1b88a29dde 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1285,11 +1285,15 @@ static void storvsc_on_channel_callback(void *context)
 	foreach_vmbus_pkt(desc, channel) {
 		struct vstor_packet *packet = hv_pkt_data(desc);
 		struct storvsc_cmd_request *request = NULL;
+		u32 pktlen = hv_pkt_datalen(desc);
 		u64 rqst_id = desc->trans_id;
+		u32 minlen = rqst_id ? sizeof(struct vstor_packet) -
+			stor_device->vmscsi_size_delta : sizeof(enum vstor_packet_operation);
 
-		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta) {
-			dev_err(&device->device, "Invalid packet len\n");
+		if (pktlen < minlen) {
+			dev_err(&device->device,
+				"Invalid pkt: id=%llu, len=%u, minlen=%u\n",
+				rqst_id, pktlen, minlen);
 			continue;
 		}
 
@@ -1302,13 +1306,23 @@ static void storvsc_on_channel_callback(void *context)
 			if (rqst_id == 0) {
 				/*
 				 * storvsc_on_receive() looks at the vstor_packet in the message
-				 * from the ring buffer.  If the operation in the vstor_packet is
-				 * COMPLETE_IO, then we call storvsc_on_io_completion(), and
-				 * dereference the guest memory address.  Make sure we don't call
-				 * storvsc_on_io_completion() with a guest memory address that is
-				 * zero if Hyper-V were to construct and send such a bogus packet.
+				 * from the ring buffer.
+				 *
+				 * - If the operation in the vstor_packet is COMPLETE_IO, then
+				 *   we call storvsc_on_io_completion(), and dereference the
+				 *   guest memory address.  Make sure we don't call
+				 *   storvsc_on_io_completion() with a guest memory address
+				 *   that is zero if Hyper-V were to construct and send such
+				 *   a bogus packet.
+				 *
+				 * - If the operation in the vstor_packet is FCHBA_DATA, then
+				 *   we call cache_wwn(), and access the data payload area of
+				 *   the packet (wwn_packet); however, there is no guarantee
+				 *   that the packet is big enough to contain such area.
+				 *   Future-proof the code by rejecting such a bogus packet.
 				 */
-				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO) {
+				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO ||
+				    packet->operation == VSTOR_OPERATION_FCHBA_DATA) {
 					dev_err(&device->device, "Invalid packet with ID of 0\n");
 					continue;
 				}
-- 
2.25.1

