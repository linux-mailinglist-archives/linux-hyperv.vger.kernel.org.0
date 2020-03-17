Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC82D18856E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 14:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgCQNZe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 09:25:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34916 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgCQNZd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 09:25:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so11755277pgr.2;
        Tue, 17 Mar 2020 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLtKq4xksFgvbkDc7E/eB2bEShCwgMcQKAt0wU9luks=;
        b=FNCpzZpOR1UsdrwoyWu2WUKEJ8FXofnOS4GbJB78F7O/MIri8uDbo20tpWYPUwwhmu
         eNrw91fnbdY/YzVNHWTftBtATMIizY/rJgm4P3srrOEHnmcCepBSztsiwR3a0U0CosxE
         jTAUnOniMrSjcmab1f61MNGCTcKX+22hfU1nhe9HknpJEp0tBHzBAi0Acu1QzMSG+D3C
         WvWR5gGvtFb1NFBywbttidx8/Ss/etGzKYuTerBIiz4VRXycXhOzNTU6dvg8oZTOdcIr
         nyqPPqKy/Jc9hDl8xTsKBCvJFrR7hTWHOXAKR669IYE5npURUSt7rIDB9FkD0OtJ/KQN
         8Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLtKq4xksFgvbkDc7E/eB2bEShCwgMcQKAt0wU9luks=;
        b=HBQ866RniAW83gMX3qB4193WFNoEQDBhpYpM8hqmFVb/sbkIDN6BAOiTBNUOY8COcJ
         ZGJ+akJR8fBOdSGhdeqGuRp5jZL4tj4zb1CnzyEJgbIrUiUkFCmfrJMvl7ts+651g8N0
         5wvkQprjpbgEnqFX0P3bmmDlUM990yqAsCfe11v8xglskemenKuYTKIb1sClNUJAWh5u
         eUMhG3xxMrV46WxaCeDoYd0Xi8ojNd3cyEpIa0F6SwvY8mb82618w2zROvbk01fnYD4m
         7fe+s8MMbQ9YkYWroIC7L3+N5yKvVEzk39HRhADlHK8fFHeuO9lKZg8ftptvbmB2oJ45
         zjRQ==
X-Gm-Message-State: ANhLgQ1Mf2dE39UHtBSgM6CM+4Jo9VRkOXkWJkKYvSQzjpS7YA27npw7
        1mZuQDejYz5qZSQEt39yvQY=
X-Google-Smtp-Source: ADFU+vv9q5L0xmTgC1EZdGf6rrvQyrq1mpzQfTjNsYWGwB5zQWcUvQVS/7sDRUyptMvHSFlOhJxDsg==
X-Received: by 2002:a63:ef41:: with SMTP id c1mr4954868pgk.195.1584451530527;
        Tue, 17 Mar 2020 06:25:30 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id e30sm2910902pga.6.2020.03.17.06.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:25:29 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic callback
Date:   Tue, 17 Mar 2020 06:25:20 -0700
Message-Id: <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Customer reported Hyper-V VM still responded network traffic
ack packets after kernel panic with kernel parameter "panic=0”.
This becauses vmbus driver interrupt handler still works
on the panic cpu after kernel panic. Panic cpu falls into
infinite loop of panic() with interrupt enabled at that point.
Vmbus driver can still handle network traffic.

This confuses remote service that the panic system is still
alive when it gets ack packets. Unload vmbus channel in hv panic
callback and fix it.

vmbus_initiate_unload() maybe double called during panic process
(e.g, hyperv_panic_event() and hv_crash_handler()). So check
and set connection state in vmbus_initiate_unload() to resolve
reenter issue.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/channel_mgmt.c |  5 +++++
 drivers/hv/vmbus_drv.c    | 17 +++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0370364169c4..893493f2b420 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
 {
 	struct vmbus_channel_message_header hdr;
 
+	if (vmbus_connection.conn_state == DISCONNECTED)
+		return;
+
 	/* Pre-Win2012R2 hosts don't support reconnect */
 	if (vmbus_proto_version < VERSION_WIN8_1)
 		return;
@@ -857,6 +860,8 @@ void vmbus_initiate_unload(bool crash)
 		wait_for_completion(&vmbus_connection.unload_event);
 	else
 		vmbus_wait_for_unload();
+
+	vmbus_connection.conn_state = DISCONNECTED;
 }
 
 static void check_ready_for_resume_event(void)
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c27421..b56b9fb9bd90 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 {
 	struct pt_regs *regs;
 
-	regs = current_pt_regs();
+	vmbus_initiate_unload(true);
 
-	hyperv_report_panic(regs, val);
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		regs = current_pt_regs();
+		hyperv_report_panic(regs, val);
+	}
 	return NOTIFY_DONE;
 }
 
@@ -1391,10 +1394,12 @@ static int vmbus_bus_init(void)
 		}
 
 		register_die_notifier(&hyperv_die_block);
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &hyperv_panic_block);
 	}
 
+	/* Vmbus channel is unloaded in panic callback when panic happens.*/
+	atomic_notifier_chain_register(&panic_notifier_list,
+			       &hyperv_panic_block);
+
 	vmbus_request_offers();
 
 	return 0;
@@ -2204,8 +2209,6 @@ static int vmbus_bus_suspend(struct device *dev)
 
 	vmbus_initiate_unload(false);
 
-	vmbus_connection.conn_state = DISCONNECTED;
-
 	/* Reset the event for the next resume. */
 	reinit_completion(&vmbus_connection.ready_for_resume_event);
 
@@ -2289,7 +2292,6 @@ static void hv_kexec_handler(void)
 {
 	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
-	vmbus_connection.conn_state = DISCONNECTED;
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
 	cpuhp_remove_state(hyperv_cpuhp_online);
@@ -2306,7 +2308,6 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 * doing the cleanup for current CPU only. This should be sufficient
 	 * for kdump.
 	 */
-	vmbus_connection.conn_state = DISCONNECTED;
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
 	hv_synic_disable_regs(cpu);
-- 
2.14.5

