Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4F18F554
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 14:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgCWNJl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 09:09:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37451 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgCWNJk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id x1so1874937plm.4;
        Mon, 23 Mar 2020 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aM37J8K657Wv3q10MHFjXciLCyJUEUJMTeOksWFXlc=;
        b=SWIWo+Aqd79tlSi+ZxL1H7RyIXs/NZ2TWYmtGv+/luxUxaAjR22ugVkZxwcQGpEXdu
         p/Un3hsKlRi854qsA9HKgUt/Qo8AG7h70F/TN5fzs8HDTx/Q6WuMH2SQHDe1nZsw1zA9
         NWpLoarNYC/DeRH7xSsiyl2fikG1jrP5+msSK/yR4lQ+Kkw/NOjPHIodwmAmnk4szB87
         T9jbwPh6vFb4W4TFeDAO54RoDc3PAd8fy6sPNFtoNjouAMRCo9TQsM8RtVMD3MmwbsDL
         XXQM3a0SJQPa6+q2/Y7++aGt33vgxZ2Fg7oIxtrLoyygxpwlWJmHwK/Cs950WNyLVuXu
         HD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aM37J8K657Wv3q10MHFjXciLCyJUEUJMTeOksWFXlc=;
        b=mFCDtcvluA5it5WCOwYT4zSE4lZxbVVu614loHVveI1q+Y2RmK5nfUSmr7MMgi2ILY
         4U82uqchnMKZOOo8JpQBqZfWORPvrm1qPd5wMjQxQN32cHH4E40Od6+t05we7qr89RW8
         zdSNBROdS795tGxjmQevA1SBDT6OecXE6DkzljzPiSa3zYn5bwH2zBoHyuT0MDZHS717
         Cv9QqzMcz6KT7vgO3Wa2AiWeEhXquNZLyzArBuWw1l9mpm4a1AwvZAhKrcZGZlcLWfxh
         hiL5OXQvJTuy+y3Z9kUEjEv5eoMXBlrhDzZpRVVxV48T3l5J7Me7dps8YFNVOonyFfiy
         X0WQ==
X-Gm-Message-State: ANhLgQ1zKWGUNgKiRfEYlVaH16jXx/DUOU/7VjRHu3zly34yjtnAts3C
        OWQKujIr3mXkg6iMX8hM6vs=
X-Google-Smtp-Source: ADFU+vtkaSll1ZFfjJZwIv5gBFcCiPPFH3YNokXv7kzbUW0+vnBGMAd5HpAzylr14dJkHbOJfXbqNQ==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr25461188pjr.26.1584968979320;
        Mon, 23 Mar 2020 06:09:39 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id u14sm12262034pgg.67.2020.03.23.06.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:09:38 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 1/6] x86/Hyper-V: Unload vmbus channel in hv panic callback
Date:   Mon, 23 Mar 2020 06:09:19 -0700
Message-Id: <20200323130924.2968-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When kdump is not configured, a Hyper-V VM might still respond to
network traffic after a kernel panic when kernel parameter panic=0.
The panic CPU goes into an infinite loop with interrupts enabled,
and the VMbus driver interrupt handler still works because the
VMbus connection is unloaded only in the kdump path.  The network
responses make the other end of the connection think the VM is
still functional even though it has panic'ed, which could affect any
failover actions that should be taken.

Fix this by unloading the VMbus connection during the panic process.
vmbus_initiate_unload() could then be called twice (e.g., by
hyperv_panic_event() and hv_crash_handler(), so reset the connection
state in vmbus_initiate_unload() to ensure the unload is done only
once.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update chnage log
	- Use xchg() to change vmbus connection status
---
 drivers/hv/channel_mgmt.c |  3 +++
 drivers/hv/vmbus_drv.c    | 17 +++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0370364169c4..501c43c5851d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
 {
 	struct vmbus_channel_message_header hdr;
 
+	if (xchg(&vmbus_connection.conn_state, DISCONNECTED) == DISCONNECTED)
+		return;
+
 	/* Pre-Win2012R2 hosts don't support reconnect */
 	if (vmbus_proto_version < VERSION_WIN8_1)
 		return;
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

