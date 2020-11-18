Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45C2B7FD8
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKROyB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKROyB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:54:01 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8E9C0613D4;
        Wed, 18 Nov 2020 06:54:01 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so2540435wrw.1;
        Wed, 18 Nov 2020 06:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noyj//pQAVL0F3TT1GEpmdCZZctT7gUdg23e2fukuL4=;
        b=ntCI44C4kjqgCGo1yYRBpvXVz5rJOFRbkY02AVMtdy9mPWcyC+k3PY+9uEHczo1c7v
         28Vb2QzJL3K4jr2VMiaqlsVmyijSVZ6Ui2FoffLAIFf4n8dJYKlpVycSPFBUwUvRE4qR
         El1eoDUfQp5/s2gbP/l7DxJ5QIzp+ElzUvv7QHZb5WJHdHU/L1Bg6gyUokp07hV7okJY
         nj+Od9ZWnmFZaNfb0JjB9iQotnHhldsbYXb8Pc5lhoLEAcUtkbZgdXf7akq1G0/02xGb
         FVT/E4UMFNTt6fPunBOkFLJKk8jXEKk9MpzkOs2TrzR7AhSHZ97Hs9ZSW9daafG2th9g
         OgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=noyj//pQAVL0F3TT1GEpmdCZZctT7gUdg23e2fukuL4=;
        b=NdBR5MLe+dAz4ORXO+gQhCvEKGtjYsBNDCPbULsNMpgn2DpT8P627Qhaa1MJSkeIW0
         B/2ci2R2Tl3mI1EWbVZRX+GisbXQzHEmNML+TINRQtuiyH5NEpr+vvh1Df43zPLed2Bx
         HOdRAgxaguVtD/t2DbBGUbkmm+XusKT97fDPH1ucWFrqFtmNVmyzXpZUaKpNmbu2iwvD
         3KqtJm854OkfBGHSQlXBB4UeKx6ehbVEsTb1NurS/mASbgJgaW2u0RzOnXuavlLqGzAq
         lW7Mku6h3NQyUHWWFg0azuojUp1pxy4OQ6JEfp0iGdisIEYHKkvxy5U2APbxz+4RDSRc
         0H0g==
X-Gm-Message-State: AOAM530VZXm5dZ0XDgpTSWHa0LKXRbIeZvjsHY2te2Rm/lD4jR8PHzGY
        5HyFahJy5WyB4cIV45bZRcijBps2L8oAzdPK
X-Google-Smtp-Source: ABdhPJz5Ixt95dpw0tbcmzoh/UimTZIfdS9pfrUy3+Ck7lRj3q7TkGYplYgsiHg0DapKjZ1X7dhkDA==
X-Received: by 2002:adf:fd85:: with SMTP id d5mr4884502wrr.99.1605711239584;
        Wed, 18 Nov 2020 06:53:59 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id o197sm3973785wme.17.2020.11.18.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:53:58 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()
Date:   Wed, 18 Nov 2020 15:53:48 +0100
Message-Id: <20201118145348.109879-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Check that the packet is of the expected size at least, don't copy
data past the packet.

Reported-by: Saruhan Karademir <skarade@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
Based on hyperv-next.

 drivers/scsi/storvsc_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 331a33a04f1ad..629a46a0bab6e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1270,6 +1270,11 @@ static void storvsc_on_channel_callback(void *context)
 
 		request = (struct storvsc_cmd_request *)(unsigned long)cmd_rqst;
 
+		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) - vmscsi_size_delta) {
+			dev_err(&device->device, "Invalid packet len\n");
+			continue;
+		}
+
 		if (request == &stor_device->init_request ||
 		    request == &stor_device->reset_request) {
 			memcpy(&request->vstor_packet, packet,
-- 
2.25.1

