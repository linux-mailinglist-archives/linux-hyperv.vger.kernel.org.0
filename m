Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260FE2D765B
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Dec 2020 14:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405601AbgLKNPU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Dec 2020 08:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404463AbgLKNPT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Dec 2020 08:15:19 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36DC0613CF;
        Fri, 11 Dec 2020 05:14:38 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ce23so12264179ejb.8;
        Fri, 11 Dec 2020 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/PXvREWzGnG1B3AGlYhNPwfEngYC/155XNt7j1HiY4=;
        b=b3304GJZrl9gVbA/sa3d6SWrH4NvzgrNYBmYaRGdyqUoL2ulxRsciA/4d6vAouT3eD
         W2NqWIIqDGCP7snYR96h/JvkMEMiHgMd+QsoufPqExebWtPgXS4DoJ6RGuTifvOuqotN
         ohDpT+IqeIh7VajSCXiZn8db/A/TxqHQrqnmfwqNnMyDOnjsQ8omXVSP5qCYGaAR5Zil
         4vDZt+6GrKKinx6I4U90uiMbg5hISQxQ9urHHCaSRNjYHMnFdXvDnB2Qw0J2HS9zpp7o
         YSUxjRD42DMSpzF2II+rBjLOW7Iga45bL22ZLdcNiF3i89jx6Z4JM93suv/mnPXnfp2j
         y5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/PXvREWzGnG1B3AGlYhNPwfEngYC/155XNt7j1HiY4=;
        b=SWogXB/ygXFsKBd50FoscsrrmUK11gMufGNjYNT5BYOaVPTL6TuO2NOfpapUadwv0T
         joLeIXF5l8LMMjIh+9HTU6K2hSpuA/d0HWeC/u22KSARBMqeAxHb5KLinq9vcuyrEmNZ
         9X7zxCxaHMQPWveGQaVpldwQhJXLQ75ZBlC7Kdwq7Xf1bc3xMZBi9aT9krDQLNFLAMRF
         6GPHx8tM+5Checu9tD4BLUif1VzQQ+AUmbgDhrINiN+fU2vc6zF7YleAA9UyLNrmxlNM
         FE2y8avtvqZsbXBx6+fycsZqJRzpWyncJUGdsNjVSzro8ZEnZj84xnfnBG0GNT+MXq8q
         SwJw==
X-Gm-Message-State: AOAM533HNow44kuleVP0yYYisVuh8i1uepPIdVZqr2nVCExyigby729R
        huhN+CxSGU3+1Ps1ViDj8U7YTChpbQFIbtSm
X-Google-Smtp-Source: ABdhPJzKJpaE09o03THDnC19Asrnu/XTbMrmi++Zv98q7dqWeyBoZH2oupdV0JwYvS6clQ+CGnJMaA==
X-Received: by 2002:a17:906:7f10:: with SMTP id d16mr10835685ejr.104.1607692477085;
        Fri, 11 Dec 2020 05:14:37 -0800 (PST)
Received: from localhost.localdomain (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id v18sm7474948edx.30.2020.12.11.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 05:14:35 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] Revert "scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()"
Date:   Fri, 11 Dec 2020 14:14:04 +0100
Message-Id: <20201211131404.21359-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This reverts commit 3b8c72d076c42bf27284cda7b2b2b522810686f8.

Dexuan reported a regression where StorVSC fails to probe a device (and
where, consequently, the VM may fail to boot).  The root-cause analysis
led to a long-standing race condition that is exposed by the validation
/commit in question.  Let's put the new validation aside until a proper
solution for that race condition is in place.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/storvsc_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 99c8ff81de746..ded00a89bfc4e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1246,11 +1246,6 @@ static void storvsc_on_channel_callback(void *context)
 		request = (struct storvsc_cmd_request *)
 			((unsigned long)desc->trans_id);
 
-		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) - vmscsi_size_delta) {
-			dev_err(&device->device, "Invalid packet len\n");
-			continue;
-		}
-
 		if (request == &stor_device->init_request ||
 		    request == &stor_device->reset_request) {
 			memcpy(&request->vstor_packet, packet,
-- 
2.25.1

