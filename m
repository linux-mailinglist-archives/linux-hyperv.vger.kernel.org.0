Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B9311383
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Feb 2021 22:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBEV1R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Feb 2021 16:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhBEV0B (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Feb 2021 16:26:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F328C0613D6
        for <linux-hyperv@vger.kernel.org>; Fri,  5 Feb 2021 13:25:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x9so4224457plb.5
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Feb 2021 13:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dq2sfPsaC0htAYqkq6DLR1GVTnEBQqxWpYN9gwQwdHM=;
        b=a5p+V3UZPIiiwHROjUBfc1DcJeY3ewhUmG5EsRYhF/7PExIliKY3uojdGfJB1IIZf8
         pO2MIaLHs8JHMjaq6Ihhd0Tx9DQPIfkWOQAxs7Wr4VGVp11tULkqzac6bx0yZNDMLKrC
         zOgpYsTWDk7fwfID5FvvTrjLfeVTU7hYShqr9lkX6avXKYfQz2nwQW9VGIdC86ypVlgI
         UanEWSQutxLLeqO3fY6dpL1RHXfFPyP05TyXoIKO8n0FSN8OjkGO9uoKVn9xKG5E77q5
         K5zpslrmNcCk8Jmv1d1w2JZHnsfuESeSgBvmrI82mSGSmY2Dl2eF4MUwwCaQbhYQ/k00
         zk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dq2sfPsaC0htAYqkq6DLR1GVTnEBQqxWpYN9gwQwdHM=;
        b=aSYt+cjmybqngY2LYZq0cx/Q5sFCTjcC9UHcGS6ZAtH/RIJ4AXFkpieLo1luAkFGPn
         Phhzx3LJUV8DgX2DbZBMmaHs77+OsRyONwnNDQ3o3Nhsd6YvJHurzbDWzY9jsGpsc5sB
         GAYDfOlaEjPn7FWVsFc6jXMXs1XaOEK6uKCRtV0ysmWptdxVIDSzQWk0QI1NLoS+Ye4C
         uSe2xoEBKXQwxQji7PERVy7uljW34JP7WMcB0OygrTHc/QwgFeHu3BBJtaBPz+LPtWPF
         bJeVCyQQj+E4ISiuq0YOtW6RfjPlVLT4p0/UA68IaF4je193GLrP3QfgMLbN9Tl5vj3B
         rq4w==
X-Gm-Message-State: AOAM532dZlbN4O0jhDgkFLKQ4iuxXTDmDpyEICE7Fxva5Am4WTx8LN22
        lV9S6sr5Jmoc/9jL2GYHUW4=
X-Google-Smtp-Source: ABdhPJwFZtVkzqfPVWzC8Wtzpd68fT1UAQn/qHFdJzRaPJx3O77PzGUt5CZBH9n5awT5ql+bP0pZMg==
X-Received: by 2002:a17:90b:3583:: with SMTP id mm3mr3887668pjb.47.1612560319866;
        Fri, 05 Feb 2021 13:25:19 -0800 (PST)
Received: from vm-122.slytdz3n204uxoeeqq2h5obquh.xx.internal.cloudapp.net ([51.141.169.192])
        by smtp.gmail.com with ESMTPSA id h15sm7828607pfo.84.2021.02.05.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:25:19 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     andres@anarazel.de
Cc:     haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, melanieplageman@gmail.com,
        sashal@kernel.org, mikelley@microsoft.com, sthemmin@microsoft.com
Subject: [PATCH 1/2] scsi: storvsc: Parameterize number hardware queues
Date:   Fri,  5 Feb 2021 21:24:46 +0000
Message-Id: <20210205212447.3327-2-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205212447.3327-1-melanieplageman@gmail.com>
References: <20210203010904.hywx5xmwik52ccao@alap3.anarazel.de>
 <20210205212447.3327-1-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add ability to set the number of hardware queues. The default value
remains the number of CPUs.  This functionality is useful in some
environments (e.g. Microsoft Azure) when decreasing the number of
hardware queues has been shown to improve performance.

Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e4fa77445fd..d72ab6daf9ae 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
 static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
 static int storvsc_vcpus_per_sub_channel = 4;
+static int storvsc_nr_hw_queues = -1;
 
 module_param(storvsc_ringbuffer_size, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
+module_param(storvsc_nr_hw_queues, int, S_IRUGO);
+MODULE_PARM_DESC(storvsc_nr_hw_queues, "Number of hardware queues");
+
 module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
 
@@ -2004,8 +2008,12 @@ static int storvsc_probe(struct hv_device *device,
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
 	 */
-	if (!dev_is_ide)
-		host->nr_hw_queues = num_present_cpus();
+	if (!dev_is_ide) {
+		if (storvsc_nr_hw_queues == -1)
+			host->nr_hw_queues = num_present_cpus();
+		else
+			host->nr_hw_queues = storvsc_nr_hw_queues;
+	}
 
 	/*
 	 * Set the error handler work queue.
@@ -2155,6 +2163,7 @@ static struct fc_function_template fc_transport_functions = {
 static int __init storvsc_drv_init(void)
 {
 	int ret;
+	int ncpus = num_present_cpus();
 
 	/*
 	 * Divide the ring buffer data size (which is 1 page less
@@ -2169,6 +2178,14 @@ static int __init storvsc_drv_init(void)
 		vmscsi_size_delta,
 		sizeof(u64)));
 
+	if (storvsc_nr_hw_queues > ncpus || storvsc_nr_hw_queues == 0 ||
+			storvsc_nr_hw_queues < -1) {
+		printk(KERN_ERR "storvsc: Invalid storvsc_nr_hw_queues value of %d.
+						Valid values include -1 and 1-%d.\n",
+				storvsc_nr_hw_queues, ncpus);
+		return -EINVAL;
+	}
+
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
 	fc_transport_template = fc_attach_transport(&fc_transport_functions);
 	if (!fc_transport_template)
-- 
2.20.1

