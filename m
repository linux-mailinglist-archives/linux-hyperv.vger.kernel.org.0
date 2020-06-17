Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4341FD294
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFQQr5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQQrx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:47:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7722C06174E;
        Wed, 17 Jun 2020 09:47:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b82so2531061wmb.1;
        Wed, 17 Jun 2020 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vhjo2DvNhb4fwe0D/B0vMGUmFy8Bj8H1qzxao7sOgQg=;
        b=LpHwWg2HL33aOreTmN62CTkC4W70t0pqHf/MyQO04fb/9lSCHoH4GM5TFpWw9h2geA
         pxo0iZ8G9vqOQegSj9jEKDrWlIMEo/uutEM7twKFOdbQyyZVd7kO5DIeVCr0Kj/JcX1j
         eKk7bu8rhQvxd5y+Ll5dVumdueIMTbaGP2n6hRz7+2DqDs1I3kCdPIj3qCbvSg0CmeL1
         VQVLzsnHowHVYGnOfSTMedHa4u8FsoUeTU2OK7fandNPKe/UrLgKqbaP5UF02PteTZ9K
         rHtr4WDRfbGoUhOaNHf4/JNVjQRUA2KCEQ4boKbbk/a9RC3u9NmtrlD4VKV91yPxq+Uz
         K54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vhjo2DvNhb4fwe0D/B0vMGUmFy8Bj8H1qzxao7sOgQg=;
        b=YncII8h6YZ/oHB+EYhfuksk1V0BEVY7coFlD2br8UxxGSM7lg8J5PJu+eI+czW3cvD
         NlUpjmFof3fcWjGb0NFKfL2FIUzcFSG7NQr1AXCwaBZhrhxP8GypqBwUmT3h38MQF18k
         yixH26/E4xvk1MQYDzjrW3+SABELEz3RSfK2S0rShS+OL94Y2/pkey7DYS9NWEgp0Zo7
         3DYBx1BW6bWS8/8dCwmFKlQxSEUYQ3W0vPt5gVhuEyYN3UmQ58xZs387QbTigMOuWDpn
         P58E3KLEyn2tAqKo9VIc4UUoOhcg8JhoKZs0SerXA6PygSLfTGRKyk0A+MOJPSuaIGR7
         dHzw==
X-Gm-Message-State: AOAM530cnCN3RClkLxFZNmhOrbGXNbLKcZQoJoOBN7qdnNk4QfFYHBnA
        ZJaTi9waJVz3ixhoyvHBJZs=
X-Google-Smtp-Source: ABdhPJzWQ/BTV6iJtXJzXTN3SDPRC/wj7bLn5sLBpEqL91KS4gF3/Wjjdy4X7KefcNxFantxmH47pA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr9351199wmc.10.1592412471280;
        Wed, 17 Jun 2020 09:47:51 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:47:50 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 2/8] Drivers: hv: vmbus: Remove the numa_node field from the vmbus_channel struct
Date:   Wed, 17 Jun 2020 18:46:36 +0200
Message-Id: <20200617164642.37393-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The field is read only in numa_node_show() and it is already stored twice
(after a call to cpu_to_node()) in target_cpu_store() and init_vp_index();
there is no need to "cache" its value in the channel data structure.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 2 --
 drivers/hv/vmbus_drv.c    | 3 +--
 include/linux/hyperv.h    | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 278e392218079..36dd8b6c544a4 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -702,7 +702,6 @@ static void init_vp_index(struct vmbus_channel *channel)
 		 * In case alloc_cpumask_var() fails, bind it to
 		 * VMBUS_CONNECT_CPU.
 		 */
-		channel->numa_node = cpu_to_node(VMBUS_CONNECT_CPU);
 		channel->target_cpu = VMBUS_CONNECT_CPU;
 		if (perf_chn)
 			hv_set_alloced_cpu(VMBUS_CONNECT_CPU);
@@ -719,7 +718,6 @@ static void init_vp_index(struct vmbus_channel *channel)
 			continue;
 		break;
 	}
-	channel->numa_node = numa_node;
 	alloced_mask = &hv_context.hv_numa_map[numa_node];
 
 	if (cpumask_weight(alloced_mask) ==
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7e244727f5686..c3205f40d1415 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -226,7 +226,7 @@ static ssize_t numa_node_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 
-	return sprintf(buf, "%d\n", hv_dev->channel->numa_node);
+	return sprintf(buf, "%d\n", cpu_to_node(hv_dev->channel->target_cpu));
 }
 static DEVICE_ATTR_RO(numa_node);
 #endif
@@ -1764,7 +1764,6 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 */
 
 	channel->target_cpu = target_cpu;
-	channel->numa_node = cpu_to_node(target_cpu);
 
 	/* See init_vp_index(). */
 	if (hv_is_perf_channel(channel))
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 738efdb194b09..690394b79d727 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -812,7 +812,6 @@ struct vmbus_channel {
 	 * the earlier behavior.
 	 */
 	u32 target_cpu;
-	int numa_node;
 	/*
 	 * Support for sub-channels. For high performance devices,
 	 * it will be useful to have multiple sub-channels to support
-- 
2.25.1

