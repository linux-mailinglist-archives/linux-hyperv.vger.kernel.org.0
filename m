Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378F246D01
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2019 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFNXso (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 19:48:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43922 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNXso (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 19:48:44 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so9320565ios.10;
        Fri, 14 Jun 2019 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wpT38r5a880Nz5EpPnP8p2gTTuHwmcJYFjVOC4ylZcM=;
        b=tMJMO2ytWK26Y3fK7EbaPOgDtYckw2mzDmUma4M7GZ6d5B6xAFfJHZ+CO/BcFrauXb
         T7nIZE5HTiElEUrplL94Sc1aMsKCRjFSxIYwns/ska89pIPKO+wxMths5tdhbs+NXB0R
         t/lfJpE/qUMr+ZklWfZHMdaxuWh+uHgX5jh26hpTYxXKagnUkZ8TKXWwdULwy3qju4dU
         KV3n7fMuYdWD846OeXr/A9snLt/JBvG5wWP4mVu6JKcKwr9io6bQVml0HGX84np6qtQ+
         6VRl6pJKDpgZQkV6QOanJDTKePx3HUwDVBd/VLQd6yJbEfxBZXenS8vNAi272jZyMwTo
         5WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wpT38r5a880Nz5EpPnP8p2gTTuHwmcJYFjVOC4ylZcM=;
        b=GFruPQIcQ3h5xOIpgOHGCCIMQJNs3G2nO3Cxl8S6Mm9vARaFCenEhRdHJKGJGvt6Di
         +7SFNJJR4rukcbBkTOvPVEjDJGMfl703MbN/0I5RDA2bCGfZm9u8EBJ7K4NGLeMRPc1d
         65KVCr7R6ZO8XYvkuJ8UtYGelE2w5aBGBifL6MnF6qvoVrRXNT5A89WEPr1k62Io2DHI
         4eq+33/gqv/j8Q6kXmuggDP3aMesK43xJY5h/vZNeoxx/Tud0yEJ6rtr/urCZHqSBoW9
         euhzCpR6KzFQIGFrqa1JCEHiZTnLowUbZkQaqHabjtY1u64q/aGYnPID1oroiSRg7aTr
         30Nw==
X-Gm-Message-State: APjAAAV+vurf8qYCLTtueI4mkxoej2fe5XUVNtpJzZodFkKW0Oxarh9a
        MvH1DW0BJdeqO2RTi007yw==
X-Google-Smtp-Source: APXvYqxMpzZoYdSsD/XNMNJdtE6+/IEP+XHknfiQgq15et56Ewxg+b/Uw8Sj027M59gzDqAkNon6cw==
X-Received: by 2002:a5e:cb06:: with SMTP id p6mr35269477iom.79.1560556123396;
        Fri, 14 Jun 2019 16:48:43 -0700 (PDT)
Received: from Test-Virtual-Machine.mshome.net (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id x22sm3799352ioh.87.2019.06.14.16.48.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 16:48:42 -0700 (PDT)
Received: by Test-Virtual-Machine.mshome.net (Postfix, from userid 1000)
        id 0686060EFA; Fri, 14 Jun 2019 19:48:41 -0400 (EDT)
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: storvsc: Add ability to change scsi queue depth
Date:   Fri, 14 Jun 2019 19:48:22 -0400
Message-Id: <20190614234822.5193-1-brandonbonaby94@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Adding functionality to allow the SCSI queue depth to be changed,
by utilizing the "scsi_change_queue_depth" function.

Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8472de1007ff..719ca9906fc2 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -387,6 +387,7 @@ enum storvsc_request_type {
 
 static int storvsc_ringbuffer_size = (128 * 1024);
 static u32 max_outstanding_req_per_channel;
+static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
 static int storvsc_vcpus_per_sub_channel = 4;
 
@@ -1711,6 +1712,7 @@ static struct scsi_host_template scsi_driver = {
 	.dma_boundary =		PAGE_SIZE-1,
 	.no_write_same =	1,
 	.track_queue_depth =	1,
+	.change_queue_depth =	storvsc_change_queue_depth,
 };
 
 enum {
@@ -1917,6 +1919,15 @@ static int storvsc_probe(struct hv_device *device,
 	return ret;
 }
 
+/* Change a scsi target's queue depth */
+static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth)
+{
+	if (queue_depth > scsi_driver.can_queue){
+		queue_depth = scsi_driver.can_queue;
+	}
+	return scsi_change_queue_depth(sdev, queue_depth);
+}
+
 static int storvsc_remove(struct hv_device *dev)
 {
 	struct storvsc_device *stor_device = hv_get_drvdata(dev);
-- 
2.17.1

