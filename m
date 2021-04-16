Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E151F362264
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbhDPOfr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhDPOfp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 10:35:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798AC061574;
        Fri, 16 Apr 2021 07:35:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v6so41172076ejo.6;
        Fri, 16 Apr 2021 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08Ke92PsXl2lpjQ/kVmpRFIVEllRlEf3n85ec+SCu08=;
        b=dg/Z172XQo5E6RjNYV6XO/oS9Ls/YSHZO+X9EmoD6s0a6xvt3trLaSqmKOkuah+7uq
         mJAbB+cVXwo/WTxSDL8dKwvZdnyeC5BrjtkrivH8fPdIEXhLMYAV/qHx/Ui2JHr05L+t
         is6c1Rwo0EMaPSK9z1T7nuwk436LrkDPyoEtkWfvbD1g3ztr9p9cpX8PGkOE3w0yZCtc
         Vfw8nrrgC78KQmIY9onyQLviTb5CgCTcfgNIzj6W5Fsr481fiT23ENfhLwg+8/mgAuZB
         NneDu/7ZMCTFa395bXWMlMuXtxpUCNvSTphWc3D29oSlZKLICWxe9k629T01E+nIldpB
         rMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08Ke92PsXl2lpjQ/kVmpRFIVEllRlEf3n85ec+SCu08=;
        b=s/QyrndeRfnXJF7TqqCvYwrJQhN5pdhQkihRZcmAAjKws9/XyrEJPjrtOVLOIHD6jt
         aJRrYgwAqyEr34wfd0+tlJEZhlVPAAxBLnl9Bv2A6wo4CtPcbDIZsRK8bgGv5iZqQrwt
         UqN9eI7Fb4IxE8dNXLkNdjpx8QNEB8xj5aCe0y2eC+6/MdenoPHihsljwBYZ5BIlXjg2
         +NE9SdUUt6cKJmLUUmpvLm7+VEXfarNdYqrXAKJXBC9WIBZC1WEyBlS+L0ZrkPmhiaWM
         xA9RMNEVpjpQ789C9+yy0sbqQeotidoAz9PFstsk9osQjRzKqJaewhcxcU5VTyWZUHbn
         0Kew==
X-Gm-Message-State: AOAM531p8G7NRHNCxqBz2v2X3XZWdV/DWFRl9/SuJKJBZ/zGZFAGfoOV
        0XQ2raduhoLC/mxxvHEn3YDJhoMdtAkK0A==
X-Google-Smtp-Source: ABdhPJxtY27iPu1m5vpilJmDWaN7FdGCI5bFsAYre2AJgyOVtQf/MGvyjwjWLBSQOVaKyiCU1tOJGA==
X-Received: by 2002:a17:906:c04:: with SMTP id s4mr1942568ejf.410.1618583718980;
        Fri, 16 Apr 2021 07:35:18 -0700 (PDT)
Received: from anparri.mshome.net (mob-176-243-167-64.net.vodafone.it. [176.243.167.64])
        by smtp.gmail.com with ESMTPSA id x4sm5399472edd.58.2021.04.16.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:35:18 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 3/3] Drivers: hv: vmbus: Check for pending channel interrupts before taking a CPU offline
Date:   Fri, 16 Apr 2021 16:34:49 +0200
Message-Id: <20210416143449.16185-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416143449.16185-1-parri.andrea@gmail.com>
References: <20210416143449.16185-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Check that enough time has passed such that the modify channel message
has been processed before taking a CPU offline.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/hv.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 3e6ff83adff42..e0c522d143a37 100644
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
@@ -292,12 +293,50 @@ void hv_synic_disable_regs(unsigned int cpu)
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
 	struct vmbus_channel *channel, *sc;
 	bool channel_found = false;
 
+	if (vmbus_connection.conn_state != CONNECTED)
+		goto always_cleanup;
+
 	/*
 	 * Hyper-V does not provide a way to change the connect CPU once
 	 * it is set; we must prevent the connect CPU from going offline
@@ -305,8 +344,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	 * path where the vmbus is already disconnected, the CPU must be
 	 * allowed to shut down.
 	 */
-	if (cpu == VMBUS_CONNECT_CPU &&
-	    vmbus_connection.conn_state == CONNECTED)
+	if (cpu == VMBUS_CONNECT_CPU)
 		return -EBUSY;
 
 	/*
@@ -333,9 +371,21 @@ int hv_synic_cleanup(unsigned int cpu)
 	}
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
-	if (channel_found && vmbus_connection.conn_state == CONNECTED)
+	if (channel_found)
+		return -EBUSY;
+
+	/*
+	 * channel_found == false means that any channels that were previously
+	 * assigned to the CPU have been reassigned elsewhere with a call of
+	 * vmbus_send_modifychannel().  Scan the event flags page looking for
+	 * bits that are set and waiting with a timeout for vmbus_chan_sched()
+	 * to process such bits.  If bits are still set after this operation
+	 * and VMBus is connected, fail the CPU offlining operation.
+	 */
+	if (vmbus_proto_version >= VERSION_WIN10_V4_1 && hv_synic_event_pending())
 		return -EBUSY;
 
+always_cleanup:
 	hv_stimer_legacy_cleanup(cpu);
 
 	hv_synic_disable_regs(cpu);
-- 
2.25.1

