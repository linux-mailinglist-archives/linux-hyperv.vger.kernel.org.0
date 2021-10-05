Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4362422577
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Oct 2021 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhJELnG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Oct 2021 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhJELnF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Oct 2021 07:43:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12658C061749;
        Tue,  5 Oct 2021 04:41:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so76164030edc.11;
        Tue, 05 Oct 2021 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dP0dp6S1K23nYcgVnLdQY9FQ0JJKDn9S4Adpna91Wk=;
        b=WuwAODlVsQO/YxDLaxPa+fWnErWGZeTG+jj5QbR2XlvUba/OpSvWuhqVBT9LviGd0i
         5KR6JqxQMRvLMTgsPLJ2EEZK05TeiX6cy99IZG4ZIp/iMJwmg/2pSsqgGBsknUMQYHLc
         h8IsQEMpgK+GLg+bYkbgvMWt9twc1AOTiYO3GDIIoRhWxNCGs87/+kMXaFMzWxCubb78
         2OOqw38URj+MPn4B491mDXCuYdmqx6RWlZFlr008vFw8jZU2CjY6SVl7Ix7WSeAKTNZ7
         mkFLM/GFfR6A4ODMRH6i7EWE/jYxfbkiP3kCqtHIeX9NOz5DR4ESv43cesKAC89xH4Za
         oI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dP0dp6S1K23nYcgVnLdQY9FQ0JJKDn9S4Adpna91Wk=;
        b=ly5/zS0I/XeNuSlSBZbItPZuHWSt+PKfhyJIwPOs3UW91wm5rdZhoeNmCXya4F5/UL
         p+k2Q1yqW4jAbFzE035jWjOkBK0gVwAMD2wGy+SRveicQEnuimp1tlRPkmyV7iEJa94o
         2I3AB9JkHpRbiiH6Xks6GCUHzvDqns2K0uQ2aXmH2T1xCUhJq8ZFh2oaYZwiSi24AmFe
         WcTRjQ1KkGH6ftm7rVH04FkVCscK48c4OzP0Q1rqBQUOnsH1YCy+QIGVHUt3IZAA42zl
         SyuBuuQa3zeY02F5sPV7cqiYAkdg19mCZVOdWR3V/HkTQpv+piAOjmNP8hc1MR6kyu8E
         2yzQ==
X-Gm-Message-State: AOAM531HuPkYN9IAbLWx6ywp/szqOyeUL4W0o+LoB8tYrLuF0pkr6BJH
        j0KUD+Tt2zqNm/cbB71JkuCdUQpKuKTDskv/
X-Google-Smtp-Source: ABdhPJz/vMjY2GearIQuKYktdUaC4sF5V50euf6kfHdhrC6kN3OF9pBiHIHR39NJT563C+NfsWtkcQ==
X-Received: by 2002:aa7:ccd8:: with SMTP id y24mr15268314edt.358.1633434073274;
        Tue, 05 Oct 2021 04:41:13 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id l19sm2437168edb.65.2021.10.05.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:41:12 -0700 (PDT)
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
Subject: [PATCH] scsi: storvsc: Fix validation for unsolicited incoming packets
Date:   Tue,  5 Oct 2021 13:41:03 +0200
Message-Id: <20211005114103.3411-1-parri.andrea@gmail.com>
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
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
Changes since RFC[1]:
  - Merge length checks (Haiyang Zhang)

[1] https://lkml.kernel.org/r/20210928163732.5908-1-parri.andrea@gmail.com

 drivers/scsi/storvsc_drv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ebbbc1299c625..349c1071a98d4 100644
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
@@ -1285,11 +1288,15 @@ static void storvsc_on_channel_callback(void *context)
 	foreach_vmbus_pkt(desc, channel) {
 		struct vstor_packet *packet = hv_pkt_data(desc);
 		struct storvsc_cmd_request *request = NULL;
+		u32 pktlen = hv_pkt_datalen(desc);
 		u64 rqst_id = desc->trans_id;
+		u32 minlen = rqst_id ? sizeof(struct vstor_packet) -
+			stor_device->vmscsi_size_delta : VSTOR_MIN_UNSOL_PKT_SIZE;
 
-		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
-				stor_device->vmscsi_size_delta) {
-			dev_err(&device->device, "Invalid packet len\n");
+		if (pktlen < minlen) {
+			dev_err(&device->device,
+				"Invalid pkt: id=%llu, len=%u, minlen=%u\n",
+				rqst_id, pktlen, minlen);
 			continue;
 		}
 
-- 
2.25.1

