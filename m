Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39E35F727
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhDNPCB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhDNPB7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 11:01:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE012C061756;
        Wed, 14 Apr 2021 08:01:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m3so24103667edv.5;
        Wed, 14 Apr 2021 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tT7uwoYzV1OZBhSy625V8SIzoldYD1Jtal4XKpjIk6E=;
        b=gmFJ28R8jAqVvsrufxOILvnC1EhALwJelyqUFa2bAc6yNejyqklzCDN4MNbDh7azi4
         sBwUgn6B+AF30eoC1zW4TYvYvOGV2BDLOW2G5Uoob9pf3ZCTw3S48qS1UjBJUQDzMFGl
         zJJC9JrDNICNRA0LWE4A1tj2hafsaxMS6uPBr9ah0kuYocLCt70qlhvWSOl9FW4cpgSB
         rXsK80Pb0Nddd0bbK91htO5PVtw/oRVEoVOz/tWtHbYI+0CUhqYbowA976+KF0UretoP
         dmd2IyxTiqT0J/b2Hzo8zfnusAgtd8Vcqs35Yu3x3f8A9Cz2fU5VwixFRVYV0PIDU8IX
         bPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tT7uwoYzV1OZBhSy625V8SIzoldYD1Jtal4XKpjIk6E=;
        b=q6cS3HVP3htCzmhlsKlJ+w3xOswByofhRNOOq772udZEtHxD2DwdxZm7M6rOYlM+iV
         C4GYOfX4a1yz4B7wg102Y36mVLVA3vBG2gLVRQXAzD4Z7UT6hGot3AiT23mxSX1rjVrI
         sRbAk6SWXcVkZM3Ir52UTrymTCx0BtyQQbIvQNBjhoTzQiNrZen6W8uS//z2aci8rz/S
         U/Af9f+NkutARichkTwvdbWD9EqSBJN/kHqewKipio5pqrDjWEsbOdFnIM5T+TKwoEIE
         7WNLEXTzkmALdSsUe/cvZFybETaR/1AoLyIBgXBKFnrG7lgkj3xMUYW6t+ndmjpd44/p
         4mWg==
X-Gm-Message-State: AOAM533L2lwQbcwYoRwOWkYk5h9hvRiVPL4ssqfjGjRM25v86piodvec
        aIkzwyCbaC+FDfiRgG4mvvb3yZYbHeUKpg==
X-Google-Smtp-Source: ABdhPJxMIX8qIkKkbUhJ6ZLMBAQ1SepdGNJ7jLGhdrcO/r+YoSmg6OqqtONRLo8V47RZN6qZLXsOfw==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr41713124edd.116.1618412495387;
        Wed, 14 Apr 2021 08:01:35 -0700 (PDT)
Received: from anparri.mshome.net (host-95-232-15-7.retail.telecomitalia.it. [95.232.15.7])
        by smtp.gmail.com with ESMTPSA id c12sm12683393edx.54.2021.04.14.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:01:35 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 3/3] Drivers: hv: vmbus: Check for pending channel interrupts before taking a CPU offline
Date:   Wed, 14 Apr 2021 17:01:18 +0200
Message-Id: <20210414150118.2843-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414150118.2843-1-parri.andrea@gmail.com>
References: <20210414150118.2843-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Check that enough time has passed such that the modify channel message
has been processed before taking a CPU offline.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/hv.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 3e6ff83adff42..dc9aa1130b22f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -15,6 +15,7 @@
 #include <linux/hyperv.h>
 #include <linux/random.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
@@ -292,6 +293,41 @@ void hv_synic_disable_regs(unsigned int cpu)
 		disable_percpu_irq(vmbus_irq);
 }
 
+#define HV_MAX_TRIES 3
+/*
+ * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
+ * bit set, then wait for a few milliseconds.  Repeat these steps for a maximum of 3 times.
+ * Return 'true', if there is still any set bit after this operation; 'false', otherwise.
+ *
+ * If a bit is set, that means there is a pending channel interrupt.  The expectation is
+ * that the normal interrupt handling mechanism will find and process the channel interrupt
+ * "very soon", and in the process clear the bit.
+ */
+static bool hv_synic_event_pending(void)
+{
+	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
+	union hv_synic_event_flags *event =
+		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE_SINT;
+	unsigned long *recv_int_page = event->flags; /* assumes VMBus version >= VERSION_WIN8 */
+	bool pending;
+	u32 relid;
+	int tries = 0;
+
+retry:
+	pending = false;
+	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
+		/* Special case - VMBus channel protocol messages */
+		if (relid == 0)
+			continue;
+		pending = true;
+		break;
+	}
+	if (pending && tries++ < HV_MAX_TRIES) {
+		usleep_range(10000, 20000);
+		goto retry;
+	}
+	return pending;
+}
 
 int hv_synic_cleanup(unsigned int cpu)
 {
@@ -336,6 +372,19 @@ int hv_synic_cleanup(unsigned int cpu)
 	if (channel_found && vmbus_connection.conn_state == CONNECTED)
 		return -EBUSY;
 
+	if (vmbus_proto_version >= VERSION_WIN10_V4_1) {
+		/*
+		 * channel_found == false means that any channels that were previously
+		 * assigned to the CPU have been reassigned elsewhere with a call of
+		 * vmbus_send_modifychannel().  Scan the event flags page looking for
+		 * bits that are set and waiting with a timeout for vmbus_chan_sched()
+		 * to process such bits.  If bits are still set after this operation
+		 * and VMBus is connected, fail the CPU offlining operation.
+		 */
+		if (hv_synic_event_pending() && vmbus_connection.conn_state == CONNECTED)
+			return -EBUSY;
+	}
+
 	hv_stimer_legacy_cleanup(cpu);
 
 	hv_synic_disable_regs(cpu);
-- 
2.25.1

