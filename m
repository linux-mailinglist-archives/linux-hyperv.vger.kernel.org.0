Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2532478A
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Feb 2021 00:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhBXXbR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Feb 2021 18:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBXXbQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Feb 2021 18:31:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A69C061574;
        Wed, 24 Feb 2021 15:30:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id i14so742901pjz.4;
        Wed, 24 Feb 2021 15:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDa353spEJ99h0ZFQUn0JxkftZINLCJU+PEprlTyhaI=;
        b=TyyUsZqsySftNQxWmnrfTsh4J4HitmgvQ/B0QvALBieq+QP1A67AvXOOPHcz/ueXqq
         /X5l+9IZ9yh0qqGjk23abkJX1DJONjj7+hEHYJy6ci5Z2BlkseGFLyzyPfWaz2vTywg1
         Q90J3mBuvyDwgJkg8DIOJyJ5hSdLSdmw1Zg+4/cG5Xk0ug8dIeol9VSV0QsU6PcdYEYT
         2WkADTa3D73t2GaXjEKE2ZPlIPHmDSo8C4XiLckFZ2RI33Ka5olWp4ZjAzbvYpVSdUW8
         h8AwdMflCyS26VPkMtpEODm4qjJLwNXsMxLagvlcwvk7Gz4Uu0cjpUj5wvhPUn08ufJz
         dm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDa353spEJ99h0ZFQUn0JxkftZINLCJU+PEprlTyhaI=;
        b=m/sC3yYcDUTLsab4fz+uxf9FgSjW4gysa7CzZ4IxuKF76zjnnIp1cq9yMcbDwJQ0bl
         SIQWmm7XQ4T+Ron5KaYfWcLS7T8rPb1dL4nv4De/8RDfzS9oSjmFSm2sOJwYHjBw5+v0
         NqH7bmyOhrdKz8dabR3kZsmsttMU/Jgmq1J9iLo3n8AyJosNQgzbDmCEmAuoaB5FpU73
         bQTQ5omaabtwxnuK8+8yHkM6D5N934/Ri0mMrBnrG7C5ap+nswrFJpg85mDntRFJ5g7G
         ha6N/9W3DHvPt6r+3giSDUUqkTHP21jls/L+LB+scfI/uGmXCDzZYFFmBv3z8VGh58qH
         ulnw==
X-Gm-Message-State: AOAM530IZHVCcQc4t2s+0kY+cZtNCHim6I3ePWZtE8nImwN89zLUd9BN
        yqZpuBzqZblcDvJqQ1WMMtWOVuWewuRELPP6
X-Google-Smtp-Source: ABdhPJy6MP53YivXGyD8hnmjkeFryG2XzIxzHA+nId3Yu+8WXHbfJKtjl2+9RErLwrTTaAddiERh+w==
X-Received: by 2002:a17:90a:3ba2:: with SMTP id e31mr250133pjc.201.1614209434852;
        Wed, 24 Feb 2021 15:30:34 -0800 (PST)
Received: from vm-123.slytdz3n204uxoeeqq2h5obquh.xx.internal.cloudapp.net ([52.151.19.72])
        by smtp.gmail.com with ESMTPSA id m16sm3835033pfd.203.2021.02.24.15.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 15:30:34 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     andres@anarazel.de, haiyangz@microsoft.com, jejb@linux.ibm.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        mikelley@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
Subject: [PATCH v4] scsi: storvsc: Parameterize number hardware queues
Date:   Wed, 24 Feb 2021 23:29:48 +0000
Message-Id: <20210224232948.4651-1-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add ability to set the number of hardware queues with new module parameter,
storvsc_max_hw_queues. The default value remains the number of CPUs.  This
functionality is useful in some environments (e.g. Microsoft Azure) where
decreasing the number of hardware queues has been shown to improve
performance.

Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
---
Updated since v3:
- permissions in octal
- param type changed to unsigned int
- removed value checking from module init function
- simplified value checking logic in probe function

 drivers/scsi/storvsc_drv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6bc5453cea8a..dfe005c03734 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -366,10 +366,14 @@ static u32 max_outstanding_req_per_channel;
 static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
 static int storvsc_vcpus_per_sub_channel = 4;
+static unsigned int storvsc_max_hw_queues;
 
 module_param(storvsc_ringbuffer_size, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
+module_param(storvsc_max_hw_queues, uint, 0644);
+MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware queues");
+
 module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
 
@@ -1907,6 +1911,7 @@ static int storvsc_probe(struct hv_device *device,
 {
 	int ret;
 	int num_cpus = num_online_cpus();
+	int num_present_cpus = num_present_cpus();
 	struct Scsi_Host *host;
 	struct hv_host_device *host_dev;
 	bool dev_is_ide = ((dev_id->driver_data == IDE_GUID) ? true : false);
@@ -2015,8 +2020,17 @@ static int storvsc_probe(struct hv_device *device,
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
 	 */
-	if (!dev_is_ide)
-		host->nr_hw_queues = num_present_cpus();
+	if (!dev_is_ide) {
+		if (storvsc_max_hw_queues > num_present_cpus) {
+			storvsc_max_hw_queues = 0;
+			storvsc_log(device, STORVSC_LOGGING_WARN,
+				"Resetting invalid storvsc_max_hw_queues value to default.\n");
+		}
+		if (storvsc_max_hw_queues)
+			host->nr_hw_queues = storvsc_max_hw_queues;
+		else
+			host->nr_hw_queues = num_present_cpus;
+	}
 
 	/*
 	 * Set the error handler work queue.
-- 
2.20.1

