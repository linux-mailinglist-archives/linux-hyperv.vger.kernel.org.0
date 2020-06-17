Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDD51FD293
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFQQrv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQQru (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:47:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9BC06174E;
        Wed, 17 Jun 2020 09:47:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so2525024wmh.2;
        Wed, 17 Jun 2020 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6engyuOwypyI3Dw6jjWo3u6+DC6COU5y4JipbUMiSp8=;
        b=BiyuOqzzti6otT+VT3iiPu7P9zmdvcw3vbiDskCudqkKcVZqVB1kIuDzfqyBZYuNvh
         uzjrbBlNpN0vDzFI2xLgPLDX/ixiQ6gi6eYCqrkw2pPKn7ECf8vzSRjJEOVoWOIBIVsP
         gsYhAhTsbHkFrhaVZhcstfK4SYh2bNd88CxE/htecCQfUIr4eqJSczMUurfYidMfzuR2
         B7TSstWTTpi2K8YVEP/hDcuf6xZ4KX5Di6KbIupcq/o4mC+/yGFhO/ImEO46rvDKTZ2P
         d8D/rZ54qkKvbZRC6e11eb6hnc8sKoFWTIRCgZJri7pyxItxPL1ss+dS1l4sqFywXhty
         sFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6engyuOwypyI3Dw6jjWo3u6+DC6COU5y4JipbUMiSp8=;
        b=H6icQFgUvy90dkEt8VrDWXFPpP6XHIp+E7W85oGCwIXzIRFyyMm02u1QGJsTr71GWq
         hvzddSsUQ8xt2g5wOMFHiNMVzURh2lGF0mALon+ziSCOHJRZOlTaOF+fqbOFEsC9EUDB
         DVa+uvnWDTZMFHUSfzo08UZuX0iZYQpmoMhUEwLL+D67Goz/hloPFm7rn1o9505dU4CL
         noJ87g0cQRzLFzkZG+iop2pb55fS+Qw095ZqG35hex3Sn9WyroW0YXtiu6uke7d2KBlq
         Ov7kJeFbxh/zrWWi1+7+2rAtxZTewTyoXRkmHbdc/F1/3GPIHkfUYBPyD4TnGgvy6Pjv
         9ebQ==
X-Gm-Message-State: AOAM532HVkeLr9f5e8/xID5/BUmOnFu3tIVXtgExEtcxyTwqOnllT/Nt
        /FuC/g80DdOnNjSUH0MDHd4=
X-Google-Smtp-Source: ABdhPJwB33pIboDz5LqbU+1BPle+pXQ2IYzHDz9JJ04TpCWTfYU50GaR7fuw/esvXWLnSridVvjqYA==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr963199wmz.59.1592412468380;
        Wed, 17 Jun 2020 09:47:48 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:47:47 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 1/8] Drivers: hv: vmbus: Remove the target_vp field from the vmbus_channel struct
Date:   Wed, 17 Jun 2020 18:46:35 +0200
Message-Id: <20200617164642.37393-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The field is read only in __vmbus_open() and it is already stored twice
(after a call to hv_cpu_number_to_vp_number()) in target_cpu_store() and
init_vp_index(); there is no need to "cache" its value in the channel
data structure.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c      |  3 ++-
 drivers/hv/channel_mgmt.c |  3 ---
 drivers/hv/vmbus_drv.c    |  2 --
 include/linux/hyperv.h    | 15 +++++++--------
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 90070b337c10d..8848d1548b3f2 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/interrupt.h>
 #include <asm/page.h>
+#include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
 
@@ -176,7 +177,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	open_msg->child_relid = newchannel->offermsg.child_relid;
 	open_msg->ringbuffer_gpadlhandle = newchannel->ringbuffer_gpadlhandle;
 	open_msg->downstream_ringbuffer_pageoffset = newchannel->ringbuffer_send_offset;
-	open_msg->target_vp = newchannel->target_vp;
+	open_msg->target_vp = hv_cpu_number_to_vp_number(newchannel->target_cpu);
 
 	if (userdatalen)
 		memcpy(open_msg->userdata, userdata, userdatalen);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 417a95e5094dd..278e392218079 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -704,8 +704,6 @@ static void init_vp_index(struct vmbus_channel *channel)
 		 */
 		channel->numa_node = cpu_to_node(VMBUS_CONNECT_CPU);
 		channel->target_cpu = VMBUS_CONNECT_CPU;
-		channel->target_vp =
-			hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
 		if (perf_chn)
 			hv_set_alloced_cpu(VMBUS_CONNECT_CPU);
 		return;
@@ -739,7 +737,6 @@ static void init_vp_index(struct vmbus_channel *channel)
 	cpumask_set_cpu(target_cpu, alloced_mask);
 
 	channel->target_cpu = target_cpu;
-	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
 
 	free_cpumask_var(available_mask);
 }
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 47747755d2e1d..7e244727f5686 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -23,7 +23,6 @@
 #include <linux/cpu.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm/mshyperv.h>
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
@@ -1765,7 +1764,6 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 */
 
 	channel->target_cpu = target_cpu;
-	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
 	channel->numa_node = cpu_to_node(target_cpu);
 
 	/* See init_vp_index(). */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 40df3103e890b..738efdb194b09 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -803,15 +803,14 @@ struct vmbus_channel {
 	u64 sig_event;
 
 	/*
-	 * Starting with win8, this field will be used to specify
-	 * the target virtual processor on which to deliver the interrupt for
-	 * the host to guest communication.
-	 * Prior to win8, incoming channel interrupts would only
-	 * be delivered on cpu 0. Setting this value to 0 would
-	 * preserve the earlier behavior.
+	 * Starting with win8, this field will be used to specify the
+	 * target CPU on which to deliver the interrupt for the host
+	 * to guest communication.
+	 *
+	 * Prior to win8, incoming channel interrupts would only be
+	 * delivered on CPU 0. Setting this value to 0 would preserve
+	 * the earlier behavior.
 	 */
-	u32 target_vp;
-	/* The corresponding CPUID in the guest */
 	u32 target_cpu;
 	int numa_node;
 	/*
-- 
2.25.1

