Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EAA1906DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCXH53 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:57:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34969 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXH53 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7so8647697pgr.2;
        Tue, 24 Mar 2020 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qNSw0t43yl8OfGIcV0+3jFhgZPDe/GWtbRMmZXFX2BM=;
        b=thMsXv5PIel7RqJ29r33Vwiyqa/yDyRY/cO2kfdMAeaJcALlihfBdiTdCvRuy65Sbw
         0cEAgEB0KxvVinH2WgemxF13Q2E9lvWBD4xa/PvRQMuFqhnGKXFBoaXkNPsa2KRLapcC
         YUN9UTTbQquPnaa3TO1NbxQHXOcLjrk8GACJolfzvQSSFPx8RHFXjiU2baAUTHsiGVJ9
         ba2hLCgw5o31v9uvCymPKyFikq9JIDMRG6AFGY4jpEbx6NuKa81xICOOeV1/J4nxlFYA
         3clW2DeQUqEez+SdBhsMOsaiwwrAceOB+NXa9/lO3lIFur2OdpPRdNpl57GXtz/f+4kk
         219w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qNSw0t43yl8OfGIcV0+3jFhgZPDe/GWtbRMmZXFX2BM=;
        b=g1UOhmKeAIpwb+nSQQbl49qR4O2oLISXda73dV4sujeMuVvewxLp9lhRw3oREYXYf2
         yUawQTbiwhiGCjVqpTSGCUv3dEe7UW4srbcM2t0J0Ltc03NA6VR8mVXj/wR4Lh5RQkKO
         AzgWyuJaE0nKLB1IyAYyj4UPQGacYGg9J6joI61hUl1rZS0mDMjkZAVxHQeAPRnRoVrL
         /e3qUl89DdY5iHYRY/Bceir7y//EEnS5IN90mGzuNIooztdaY4WJ8jBeRSe3nw2wyVgn
         PCvuwdWjyCmTJ+ySMp9407T0QEjDJNmSZsMHG3G3JM0BFQANSP2OZ9FDaXE+B6k0T6v4
         CDbA==
X-Gm-Message-State: ANhLgQ1hFZO7Zn/w5MghR8++IOHIVlb/JbGGE8Ao3EujYioNKmhzuVJH
        2WNeZbfNlst20MYUbK5KYxU=
X-Google-Smtp-Source: ADFU+vt2LokCHfy3Xj0kM+7egmxN9M9cxcz7Wn09cSMi5iRm4d6XlQY4kB16BYBjgXZVAT4RtiBRUg==
X-Received: by 2002:a63:f141:: with SMTP id o1mr24906174pgk.92.1585036648060;
        Tue, 24 Mar 2020 00:57:28 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id x71sm15452076pfd.129.2020.03.24.00.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 00:57:27 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 1/6] x86/Hyper-V: Unload vmbus channel in hv panic callback
Date:   Tue, 24 Mar 2020 00:57:15 -0700
Message-Id: <20200324075720.9462-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
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
	- Update change log
	- Use xchg() to change vmbus connection status
Change since v2:
	- Update comment of registering panic callback.
---
 drivers/hv/channel_mgmt.c |  3 +++
 drivers/hv/vmbus_drv.c    | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

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
index 029378c27421..6478240d11ab 100644
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
 
@@ -1391,10 +1394,16 @@ static int vmbus_bus_init(void)
 		}
 
 		register_die_notifier(&hyperv_die_block);
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &hyperv_panic_block);
 	}
 
+	/*
+	 * Always register the panic notifier because we need to unload
+	 * the VMbus channel connection to prevent any VMbus
+	 * activity after the VM panics.
+	 */
+	atomic_notifier_chain_register(&panic_notifier_list,
+			       &hyperv_panic_block);
+
 	vmbus_request_offers();
 
 	return 0;
@@ -2204,8 +2213,6 @@ static int vmbus_bus_suspend(struct device *dev)
 
 	vmbus_initiate_unload(false);
 
-	vmbus_connection.conn_state = DISCONNECTED;
-
 	/* Reset the event for the next resume. */
 	reinit_completion(&vmbus_connection.ready_for_resume_event);
 
@@ -2289,7 +2296,6 @@ static void hv_kexec_handler(void)
 {
 	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
-	vmbus_connection.conn_state = DISCONNECTED;
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
 	cpuhp_remove_state(hyperv_cpuhp_online);
@@ -2306,7 +2312,6 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 * doing the cleanup for current CPU only. This should be sufficient
 	 * for kdump.
 	 */
-	vmbus_connection.conn_state = DISCONNECTED;
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
 	hv_synic_disable_regs(cpu);
-- 
2.14.5

