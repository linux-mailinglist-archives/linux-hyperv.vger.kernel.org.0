Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D691FD29E
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFQQsK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgFQQsF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F9C06174E;
        Wed, 17 Jun 2020 09:48:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so2524053wmj.0;
        Wed, 17 Jun 2020 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaQWLjI5fwfFGmLCckr/wYP6bEsy7u4WBriUtSeoAnM=;
        b=OkfzEmkBHCTsEkJzVex/aFcLll3H8vT+4nF+tYkC5s+bbr3MntTdGpx0O5K+8L8h/h
         bwj7CwiFBq/bagZLqrHRHm7gY6fAX2RYRfdolTkSCQB+qOS6Mx9yEVhfml/Ei5iaTpOt
         Q0w37kyIjLX5REjbUljOO0yPaDLqxH4Dwy7LE79DN6cSrPPohBbt7XA302U8BsthoFif
         t7ZyQKjfdJ1QBrYOvi76LQF22LZHL9WfOJ+n1vCRPDNx9l63b8HsLALKoZ/Y2s3mD02l
         owml6Y4mjKRBQfBzkw820AJEq7RbEM8X8CVhCTFAwsFkAHMTw3TFiT5ZOnAtUuWmJqGj
         NLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaQWLjI5fwfFGmLCckr/wYP6bEsy7u4WBriUtSeoAnM=;
        b=b7jJzqz/k42Nc1ZLx+PNJmahTbjeIxCfNkMyIJLfq4S0mxa6LvxiVFiQY/DTK3h7k8
         KTwTZQimCMvb5iy64KNUSSNf5621yFDRvnuLIWIiYd1Bshaewu9oVy29qgXFvrA5nIPg
         5NIyfXpdlhqT2dTn5/BdkaadyccsjECgbnY3WJFyM8TyviCwxmB/xtL8tHNDVLOPMmAw
         hheL/QZXWa8y2WTc1QlM2/ISjoREbVelC+We4F48Hi/td+3S+55OL6zfiaAtkyP8DFrl
         U73xY7km/HOxKPVkr3U1THhKQU5GcIXmhyHot7W9eVMGosTFtEXcQesOlmNMbzJgC7Fq
         ew9w==
X-Gm-Message-State: AOAM5328s1SGyoFAgAEfRatvHkhCMZj8t1Fzr4uzERar6WX8pdlkpKb0
        2SkHmAvojYtIpk5C2LcIIEoAvV29QzxAJg==
X-Google-Smtp-Source: ABdhPJxNQBUBgHRWphU0wOYQEIoipIPkmiSZ2QsrfmXhuJ/Hr4tg1gCBPJ3jGCyvLYTFLQlCT03z8A==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr964176wmz.59.1592412483964;
        Wed, 17 Jun 2020 09:48:03 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:03 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 7/8] scsi: storvsc: Introduce the per-storvsc_device spinlock
Date:   Wed, 17 Jun 2020 18:46:41 +0200
Message-Id: <20200617164642.37393-8-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

storvsc uses the spinlock of the hv_device's primary channel to
serialize modifications of stor_chns[] performed by storvsc_do_io()
and storvsc_change_target_cpu(), when it could/should use a (per-)
storvsc_device spinlock: this change untangles the synchronization
mechanism for the (storvsc-specific) stor_chns[] array from the
"generic" VMBus code and data structures, clarifying the scope of
this synchronization mechanism.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 072ed87286578..8ff21e69a8be8 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -462,6 +462,11 @@ struct storvsc_device {
 	 * Mask of CPUs bound to subchannels.
 	 */
 	struct cpumask alloced_cpus;
+	/*
+	 * Serializes modifications of stor_chns[] from storvsc_do_io()
+	 * and storvsc_change_target_cpu().
+	 */
+	spinlock_t lock;
 	/* Used for vsc/vsp channel reset process */
 	struct storvsc_cmd_request init_request;
 	struct storvsc_cmd_request reset_request;
@@ -639,7 +644,7 @@ static void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old,
 		return;
 
 	/* See storvsc_do_io() -> get_og_chn(). */
-	spin_lock_irqsave(&device->channel->lock, flags);
+	spin_lock_irqsave(&stor_device->lock, flags);
 
 	/*
 	 * Determines if the storvsc device has other channels assigned to
@@ -676,7 +681,7 @@ static void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old,
 	WRITE_ONCE(stor_device->stor_chns[new], channel);
 	cpumask_set_cpu(new, &stor_device->alloced_cpus);
 
-	spin_unlock_irqrestore(&device->channel->lock, flags);
+	spin_unlock_irqrestore(&stor_device->lock, flags);
 }
 
 static void handle_sc_creation(struct vmbus_channel *new_sc)
@@ -1433,14 +1438,14 @@ static int storvsc_do_io(struct hv_device *device,
 			}
 		}
 	} else {
-		spin_lock_irqsave(&device->channel->lock, flags);
+		spin_lock_irqsave(&stor_device->lock, flags);
 		outgoing_channel = stor_device->stor_chns[q_num];
 		if (outgoing_channel != NULL) {
-			spin_unlock_irqrestore(&device->channel->lock, flags);
+			spin_unlock_irqrestore(&stor_device->lock, flags);
 			goto found_channel;
 		}
 		outgoing_channel = get_og_chn(stor_device, q_num);
-		spin_unlock_irqrestore(&device->channel->lock, flags);
+		spin_unlock_irqrestore(&stor_device->lock, flags);
 	}
 
 found_channel:
@@ -1881,6 +1886,7 @@ static int storvsc_probe(struct hv_device *device,
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
 	stor_device->host = host;
+	spin_lock_init(&stor_device->lock);
 	hv_set_drvdata(device, stor_device);
 
 	stor_device->port_number = host->host_no;
-- 
2.25.1

