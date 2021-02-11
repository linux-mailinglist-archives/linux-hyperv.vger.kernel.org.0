Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002B231967A
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Feb 2021 00:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhBKXT5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Feb 2021 18:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhBKXTz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Feb 2021 18:19:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B8C061756;
        Thu, 11 Feb 2021 15:19:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u15so4177284plf.1;
        Thu, 11 Feb 2021 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IawPhYvhu3AkS9vPcoIjPCh4BAXno8jnWq7wzFVXxAc=;
        b=GdmmvbM5Y1JE6okKyMR+qvc3OXxIRt+dtvdrbtwTDpLGdbHh8DVjppxR4fUe6Cqaaw
         vASMhZf4ZQM0aD9yAhyp3+HXx/4lh3g8njKYkk7CjTwyYUSX7oeCpCXPSTyJXmfYxDU2
         PNXsG3CXAfnjJB1G2b5TBBxLeltVodLAjCwVYwV5QeFe8VZxvhexlZb07clLiYFPVP7B
         j5xpW0YA6XTw4YX+byOOkPqfYmFDFhjSXKgiysVv5vWjJ9wNG6kRNTkmiZyGdlaqhIXr
         r525N0Y4dusp7itOD+yUsbEzRjCjWdrgGdhDgqkTgkVFdhoxTU+GTNWLSds0Ho6V+jqK
         hHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IawPhYvhu3AkS9vPcoIjPCh4BAXno8jnWq7wzFVXxAc=;
        b=OLOpDdvXHjE5d+mocmnC/je5gZoi4qgw62NPxKsSzJ/HMfE+e+Mo5ARD7GcvI9wLQG
         IIhKvj3AKw0U711yvps/HXOi0HX42XwvlrMtM9dOVeRnDhFosHgP/UZy5kIktlzaDRIm
         EbNAxc92uBNO4RtBzt1QOSjfQkmWqyN9j87uqS5K2KP+F4sk0JtAfvbrvIGjhJ8OeHnx
         fL3ahcPNPjKdBiU3+mEfJcQhQwcb5Igoz/5qR4aomg0NmYl2DTTLgEZtsyMIc/ixhwue
         LpXYGsLFVq2mTmztuxNRPjRs91eDQztxqxpw6M6vdu1nwmTihRPmAahpzm7G0vzpRPO3
         1u3g==
X-Gm-Message-State: AOAM5319zQRDU/mvFoT6IM0D9juDRfgDbevCcbLPQput/bQjrzcQ7GCT
        3ZsLZhw+ERnaU8RBAiTYaIwOjztf56CFnQ==
X-Google-Smtp-Source: ABdhPJyKkmINMYjuCjY9rSXXrIA/PM5PRrvkJbFz2vrHTPH5aitG2RpkQATnPfpY7/QBdAx8Qgi+Sw==
X-Received: by 2002:a17:90a:7c06:: with SMTP id v6mr68337pjf.37.1613085554161;
        Thu, 11 Feb 2021 15:19:14 -0800 (PST)
Received: from vm-120.slytdz3n204uxoeeqq2h5obquh.xx.internal.cloudapp.net ([52.247.223.84])
        by smtp.gmail.com with ESMTPSA id c9sm5950309pjr.44.2021.02.11.15.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:19:13 -0800 (PST)
From:   Melanie Plageman <melanieplageman@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     andres@anarazel.de, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
Subject: [PATCH v3] scsi: storvsc: Parameterize number hardware queues
Date:   Thu, 11 Feb 2021 23:18:03 +0000
Message-Id: <20210211231803.25463-1-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>

Add ability to set the number of hardware queues with new module parameter,
storvsc_max_hw_queues. The default value remains the number of CPUs.  This
functionality is useful in some environments (e.g. Microsoft Azure) where
decreasing the number of hardware queues has been shown to improve
performance.

Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e4fa77445fd..a64e6664c915 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
 static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
 static int storvsc_vcpus_per_sub_channel = 4;
+static int storvsc_max_hw_queues = -1;
 
 module_param(storvsc_ringbuffer_size, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
+module_param(storvsc_max_hw_queues, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware queues");
+
 module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
 
@@ -1897,6 +1901,7 @@ static int storvsc_probe(struct hv_device *device,
 {
 	int ret;
 	int num_cpus = num_online_cpus();
+	int num_present_cpus = num_present_cpus();
 	struct Scsi_Host *host;
 	struct hv_host_device *host_dev;
 	bool dev_is_ide = ((dev_id->driver_data == IDE_GUID) ? true : false);
@@ -2004,8 +2009,19 @@ static int storvsc_probe(struct hv_device *device,
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
 	 */
-	if (!dev_is_ide)
-		host->nr_hw_queues = num_present_cpus();
+	if (!dev_is_ide) {
+		if (storvsc_max_hw_queues == -1)
+			host->nr_hw_queues = num_present_cpus;
+		else if (storvsc_max_hw_queues > num_present_cpus ||
+			 storvsc_max_hw_queues == 0 ||
+			storvsc_max_hw_queues < -1) {
+			storvsc_log(device, STORVSC_LOGGING_WARN,
+				"Resetting invalid storvsc_max_hw_queues value to default.\n");
+			host->nr_hw_queues = num_present_cpus;
+			storvsc_max_hw_queues = -1;
+		} else
+			host->nr_hw_queues = storvsc_max_hw_queues;
+	}
 
 	/*
 	 * Set the error handler work queue.
@@ -2169,6 +2185,14 @@ static int __init storvsc_drv_init(void)
 		vmscsi_size_delta,
 		sizeof(u64)));
 
+	if (storvsc_max_hw_queues > num_present_cpus() ||
+		storvsc_max_hw_queues == 0 ||
+		storvsc_max_hw_queues < -1) {
+		pr_warn("Setting storvsc_max_hw_queues to -1. %d is invalid.\n",
+			storvsc_max_hw_queues);
+		storvsc_max_hw_queues = -1;
+	}
+
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
 	fc_transport_template = fc_attach_transport(&fc_transport_functions);
 	if (!fc_transport_template)
-- 
2.20.1

