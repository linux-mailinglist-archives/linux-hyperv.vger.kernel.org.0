Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C64ABEB3
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406064AbfIFRYe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Sep 2019 13:24:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56654 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404294AbfIFRYa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Sep 2019 13:24:30 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 974CE20B7186; Fri,  6 Sep 2019 10:24:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 974CE20B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1567790669;
        bh=FKTihZNngFvRRCwA/80i7qZ10cRQB8xfMfzWyjeanNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Wj15W/uwgnIhIASmA0wYAVO28Gnt9Tj19L+q3dSbVXvz//EWt5esXzNDpFaJLrfSK
         vGigB9zgYDJpgNH+GTRpJsVtVsPOxNmywCk7y/GW8ksD5js3fvWncIu4B0ceRuN6Jo
         avtqN2sIdN7k1e/eMfucZsQMmSg4gtKaBZXt9Z9s=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v4] storvsc: setup 1:1 mapping between hardware queue and CPU queue
Date:   Fri,  6 Sep 2019 10:24:20 -0700
Message-Id: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

storvsc doesn't use a dedicated hardware queue for a given CPU queue. When
issuing I/O, it selects returning CPU (hardware queue) dynamically based on
vmbus channel usage across all channels.

This patch advertises num_present_cpus() as number of hardware queues. This
will have upper layer setup 1:1 mapping between hardware queue and CPU queue
and avoid unnecessary locking when issuing I/O.

Signed-off-by: Long Li <longli@microsoft.com>
---

Changes:
v2: rely on default upper layer function to map queues. (suggested by Ming Lei
<tom.leiming@gmail.com>)
v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v doesn't
support hot-add CPUs. (suggested by Michael Kelley <mikelley@microsoft.com>)
v4: move change logs to after Signed-of-by

 drivers/scsi/storvsc_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index b89269120a2d..cf987712041a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device *device,
 	/*
 	 * Set the number of HW queues we are supporting.
 	 */
-	if (stor_device->num_sc != 0)
-		host->nr_hw_queues = stor_device->num_sc + 1;
+	host->nr_hw_queues = num_present_cpus();
 
 	/*
 	 * Set the error handler work queue.
-- 
2.17.1

