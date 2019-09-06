Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5DFAC144
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394376AbfIFUIY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Sep 2019 16:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391991AbfIFUIX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Sep 2019 16:08:23 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE1320854;
        Fri,  6 Sep 2019 20:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567800503;
        bh=rB2nTwjhUiu0Mgcy94TeRmJDmlGu0zjrG/3qdk2pnBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6ErQprQExdNgpxnCv5HbF1D9e4KhGGaPR+WNG19EJyNqgqjEV8JqjEZxrfzgbC2T
         ywk8fA31BTzcZYmcuAkzMJsxVR8dsi9wdy+Lw6+u+qhqvnGtR5IpOGjnofoSYaHSz9
         G2hkeyNWYJWZJieeRKRneInH45rdt6XkmVkAl91c=
Date:   Fri, 6 Sep 2019 16:08:20 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v4] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Message-ID: <20190906200820.GE1528@sasha-vm>
References: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 06, 2019 at 10:24:20AM -0700, longli@linuxonhyperv.com wrote:
>From: Long Li <longli@microsoft.com>
>
>storvsc doesn't use a dedicated hardware queue for a given CPU queue. When
>issuing I/O, it selects returning CPU (hardware queue) dynamically based on
>vmbus channel usage across all channels.
>
>This patch advertises num_present_cpus() as number of hardware queues. This
>will have upper layer setup 1:1 mapping between hardware queue and CPU queue
>and avoid unnecessary locking when issuing I/O.
>
>Signed-off-by: Long Li <longli@microsoft.com>
>---
>
>Changes:
>v2: rely on default upper layer function to map queues. (suggested by Ming Lei
><tom.leiming@gmail.com>)
>v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v doesn't
>support hot-add CPUs. (suggested by Michael Kelley <mikelley@microsoft.com>)
>v4: move change logs to after Signed-of-by
>
> drivers/scsi/storvsc_drv.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>index b89269120a2d..cf987712041a 100644
>--- a/drivers/scsi/storvsc_drv.c
>+++ b/drivers/scsi/storvsc_drv.c
>@@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device *device,
> 	/*
> 	 * Set the number of HW queues we are supporting.
> 	 */
>-	if (stor_device->num_sc != 0)
>-		host->nr_hw_queues = stor_device->num_sc + 1;
>+	host->nr_hw_queues = num_present_cpus();

Just looking at the change notes for v3: why isn't this
num_active_cpus() then? One can still isolate CPUs on hyper-v, no?

--
Thanks,
Sasha
