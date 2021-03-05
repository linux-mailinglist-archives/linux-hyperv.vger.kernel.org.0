Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2EC32F68C
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Mar 2021 00:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCEXW7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Mar 2021 18:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCEXWd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Mar 2021 18:22:33 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332DFC06175F;
        Fri,  5 Mar 2021 15:22:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w18so3133294pfu.9;
        Fri, 05 Mar 2021 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHpv+pgq3I0EDiT7Iioa9BihwLKN302mKc5e39MRmOo=;
        b=OVae/4bOUUoCw5+7oD10N0HuOobiSZyscs0zxxcVmtfJBAHsOpB4RiqWzR10w97HPT
         ++4FaEqk851UAQ4QUXTGzuQFlQaZ3Eb9fUUJlwblj0a1wHqQ7dGUNDWotxoTy2w9oQwZ
         X33DyR7wGG4spwyW8+4iNUikQrgdWY68nUmfcp7BfA1dlz21aHsgKnsyLd8O46WbxRMW
         pIcCE5Rmuaai/0pePmrzV0xzyWPSW9JhBpW0yFlO8hH4LdYKrvO9GGT03B5AeZ8i6vwK
         kYByEXNd3tN6mLApHEKWy4tz61mKhINJThIBQHGUw+KWbv4lE6OX6VPqMs7cu8G+KGHz
         lNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHpv+pgq3I0EDiT7Iioa9BihwLKN302mKc5e39MRmOo=;
        b=CgcitS/SxC+KGT7BATeqfpfZfspxJuAM3+PnuQHzqBZclzT4AFdy9N5IJhAOCjjFPq
         WdwoLL57j5k/aiQcU0ie0fUo80gI6h/W/VyjnsN9b85UKWDlYXMqd7Crv4JQWG8DlaWF
         oJ4d9Z1sUpACRUPcqQqDRhJEtIv8m8AWmOcGr95ig3hz9IfcsmwZVbapl3hDUL5mx4+G
         tMIz8hZ3NNH+oQh6+IcqRDFerbw35L2Gf6G9nPj0E0C7ZEAi3ZBfLfcaT5soA3YeOZXB
         cNuv/UMMRIr6k2W6Q8P42c6SikJ8qtMGBKuH/od+xTYRTa8/D9jbaEPZkPX0QteQoLzX
         J7Cg==
X-Gm-Message-State: AOAM530DAnx9NXfOUHE3IVZ/7NY+/TehTFf6dtmur0ne00dK1F/FZz7w
        vEFINf/SLaP9SnwCS1Ymesfc+miJOAU=
X-Google-Smtp-Source: ABdhPJx8I70rJk+WRvA7XZgMxTpFVnhFzNaq7lDcMsfVFt5vUjt7QXrsABfv/jpz+6YiIKBz2yecyg==
X-Received: by 2002:a63:d70e:: with SMTP id d14mr8359293pgg.291.1614986552377;
        Fri, 05 Mar 2021 15:22:32 -0800 (PST)
Received: from vm-123.slytdz3n204uxoeeqq2h5obquh.xx.internal.cloudapp.net ([52.151.19.72])
        by smtp.gmail.com with ESMTPSA id a19sm3178431pjh.39.2021.03.05.15.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:22:31 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     andres@anarazel.de, haiyangz@microsoft.com, jejb@linux.ibm.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        mikelley@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
Subject: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Date:   Fri,  5 Mar 2021 23:21:51 +0000
Message-Id: <20210305232151.1531-1-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The scsi_device->queue_depth is set to Scsi_Host->cmd_per_lun during
allocation.

Cap cmd_per_lun at can_queue to avoid dispatch errors.

Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6bc5453cea8a..d7953a6e00e6 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1946,6 +1946,8 @@ static int storvsc_probe(struct hv_device *device,
 				(max_sub_channels + 1) *
 				(100 - ring_avail_percent_lowater) / 100;
 
+	scsi_driver.cmd_per_lun = min_t(u32, scsi_driver.cmd_per_lun, scsi_driver.can_queue);
+
 	host = scsi_host_alloc(&scsi_driver,
 			       sizeof(struct hv_host_device));
 	if (!host)
-- 
2.20.1

