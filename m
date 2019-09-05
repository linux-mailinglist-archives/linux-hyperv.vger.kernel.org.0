Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65FAAEC1
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 00:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfIEWyi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 18:54:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35788 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfIEWyh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 18:54:37 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 3941E20B7186; Thu,  5 Sep 2019 15:54:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3941E20B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1567724077;
        bh=C1jqP35TMmGSoib6LMXOoVRVdpiCFnrupJ4pnWJ4zms=;
        h=From:To:Cc:Subject:Date:From;
        b=ExajxodJhxktzC8UJzWhnU0TGhekodshFJ+8NkFp1nNRsMlUVKWL4kLZw+6K7WYDC
         3DlafSyBFNHr1GFWM/4VnI3W5BK2QOUh9D6TU27+yZK6I8sRldhWR37LGsALPhQR++
         0jG64gpsg1k54G43damuOgEHiQfNUvAKcp74nRPg=
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
Subject: [Patch v3] storvsc: setup 1:1 mapping between hardware queue and CPU queue
Date:   Thu,  5 Sep 2019 15:54:33 -0700
Message-Id: <1567724073-30192-1-git-send-email-longli@linuxonhyperv.com>
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

Changes:
v2: rely on default upper layer function to map queues. (suggested by Ming Lei
<tom.leiming@gmail.com>)
v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v doesn't
support hot-add CPUs. (suggested by Michael Kelley <mikelley@microsoft.com>)

Signed-off-by: Long Li <longli@microsoft.com>
---
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

