Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D76423E8F
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 15:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhJFNWo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 09:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhJFNWn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 09:22:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27624C061749;
        Wed,  6 Oct 2021 06:20:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x7so9642859edd.6;
        Wed, 06 Oct 2021 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOkTBrJ8rFY8f9IVX0lA4SgMpHXgic0fky3oKRvqHqk=;
        b=mUVLyEYqh9+b5aOkFH+/WeECuuGtmvZkHphEI2tlT6gRdiywDz1xqhzW5W7E9xEWmv
         5NReq7Fj7EFtSeVWE0nul7Rw8VG9wHSHqthUclc6QxgWH7/c4nqnKwC6EYBfwevJm3x6
         AKqs22eCqVb6XPalNajSXItmeTULrJhkyVuwPbTqvtXPNoIhYHQWpd1CFYz9UdVCCk2Q
         ytp2YvK0205TSd7/vQCR+pNZDHa1JjGHE+kR6zg6HHXvoV/xCye0xPVMI+b8r8O5L6A2
         IPvdT2aEp1yN9eOkaJkLT/ETKTvmqHncvK6ARonCHBgHCzwBe465PvemsnfNGKWAMw2f
         O+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOkTBrJ8rFY8f9IVX0lA4SgMpHXgic0fky3oKRvqHqk=;
        b=J+uydIRkmafsK9OhDSSx4VfZYD8PPpslFu7/SSpXY9ZkEZ6MMmcmI1o+cp9OJQ6cXz
         1PpYAMIs5NeH7DgUmVww2rigYNqzyQBi5gMbeMHuh56ng4+se5c8kxthSDoprjwiUjbW
         FeZohP8S4ZQcuPgjg4obuf0TMARkXduGYRzqzd2v13XeP0jzCq81ZngxpWBvW/SEu39s
         H3t4bL8vdC/E1o7tHdbP9gCd7PWBNyBedTHXwlCzXitMezRXQtjUQQTyeb64v8iY9xzd
         OegayFQQDfWnvIXA3H2TTaBYLnX+pc9xFwa5kOTe+QpLk7g++w6gFgdRZSjzLZaAMhQg
         WoWQ==
X-Gm-Message-State: AOAM532Yo8AAyyvWTlJ6HP2emuiPK9xg4MEMDG5BLxD5mGleTGQVUWB1
        hte0F/XHSljQtQsvIH9NTh/3omjRcRXKMP7L
X-Google-Smtp-Source: ABdhPJzRURCze2Xv2ON9Gus1R3C8IKipkTMAWw0JtJHFsMZNdEZtD9geIVbN6L+cKhA7GEBDjl2Yfw==
X-Received: by 2002:a17:906:c317:: with SMTP id s23mr29050930ejz.127.1633526441458;
        Wed, 06 Oct 2021 06:20:41 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id e7sm10952836edk.3.2021.10.06.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:20:40 -0700 (PDT)
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
Subject: [PATCH v2] scsi: storvsc: Fix validation for unsolicited incoming packets
Date:   Wed,  6 Oct 2021 15:20:26 +0200
Message-Id: <20211006132026.4089-1-parri.andrea@gmail.com>
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
---
Changes since v1[1]:
  - Use sizeof(enum vstor_packet_operation) instead of 48 (Michael Kelley)
  - Filter out FCHBA_DATA packets (Michael Kelley)

Changes since RFC[2]:
  - Merge length checks (Haiyang Zhang)

[1] https://lkml.kernel.org/r/20211005114103.3411-1-parri.andrea@gmail.com
[2] https://lkml.kernel.org/r/20210928163732.5908-1-parri.andrea@gmail.com

 drivers/scsi/storvsc_drv.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ebbbc1299c625..4869ebad7ec97 100644
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
 
@@ -1302,13 +1306,25 @@ static void storvsc_on_channel_callback(void *context)
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
+				 *
+				 * XXX.  Filter out all "invalid" operations.
 				 */
-				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO) {
+				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO ||
+				    packet->operation == VSTOR_OPERATION_FCHBA_DATA) {
 					dev_err(&device->device, "Invalid packet with ID of 0\n");
 					continue;
 				}
-- 
2.25.1

