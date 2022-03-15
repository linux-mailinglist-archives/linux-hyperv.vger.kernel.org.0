Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A974DA46D
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Mar 2022 22:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiCOVSP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Mar 2022 17:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbiCOVSO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Mar 2022 17:18:14 -0400
X-Greylist: delayed 2453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 14:17:01 PDT
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6135B3FE
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Mar 2022 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9wfYpRIxqhqCYPRg8TvYW6wG+Ti7pfXBrfgtDGGJ0/w=; b=dp7Wk4wKZQaAkMGjbdGfzA+dyy
        vvG6VAZPlYU0vXO2gfVLwswDY/fcY3qzNJI54saO0mqZ4qx8gMTyAplnEJ6+sAeLrh0ZDjh9cWBSJ
        JiivDyJi7qKX2biSTMs1RzStSQhr9KEILdS0zEJtcU34KcVmqPIXmwqoUHZogk6gz4CMGzVMo6U/5
        o41TviNoEimejPjc5GtFQu1plfIN93t4E6SQ/8jZ3Wv3brpzg8m/bwk52N2x0YHlDoo4WQwx82dVv
        0/aJaF4WCM+8eAuzMQEkBkOecVyouB/AYz5lSw5zatjTOCmvQmG/GXVLy69/oZwXBQDAfkNukhCaJ
        iAOJluWg==;
Received: from [179.98.65.182] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nUDth-00017J-9l; Tue, 15 Mar 2022 21:36:02 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-hyperv@vger.kernel.org
Cc:     kexec@lists.infradead.org, gpiccoli@igalia.com,
        kernel@gpiccoli.net, mikelley@microsoft.com,
        Tianyu.Lan@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com
Subject: [PATCH] Drivers: hv: vmbus: Fix potential crash on module unload
Date:   Tue, 15 Mar 2022 17:35:35 -0300
Message-Id: <20220315203535.682306-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The vmbus driver relies on the panic notifier infrastructure to perform
some operations when a panic event is detected. Since vmbus can be built
as module, it is required that the driver handles both registering and
unregistering such panic notifier callback.

After commit 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
though, the panic notifier registration is done unconditionally in the module
initialization routine whereas the unregistering procedure is conditionally
guarded and executes only if HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE capability
is set.

This patch fixes that by unconditionally unregistering the panic notifier
in the module's exit routine as well.

Fixes: 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hi folks, thanks in advance for any reviews! This was build-tested
with Debian config, on 5.17-rc7.

This patch is a result of code analysis - I didn't experience this
issue but seems a valid/feasible case.

Also, this is part of an ongoing effort of clearing/refactoring the panic
notifiers, more will be done soon, but I prefer to send the simple bug
fixes quickly, or else it might take a while since the next steps are more
complex and subject to many iterations I expect.

Cheers,

Guilherme


 drivers/hv/vmbus_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37e87f3..12585324cc4a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2780,10 +2780,15 @@ static void __exit vmbus_exit(void)
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		kmsg_dump_unregister(&hv_kmsg_dumper);
 		unregister_die_notifier(&hyperv_die_block);
-		atomic_notifier_chain_unregister(&panic_notifier_list,
-						 &hyperv_panic_block);
 	}
 
+	/*
+	 * The panic notifier is always registered, hence we should
+	 * also unconditionally unregister it here as well.
+	 */
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &hyperv_panic_block);
+
 	free_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
-- 
2.35.1

