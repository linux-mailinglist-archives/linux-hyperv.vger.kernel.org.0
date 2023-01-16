Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBE66CAD0
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jan 2023 18:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjAPRIE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 12:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjAPRHm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 12:07:42 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B12145214;
        Mon, 16 Jan 2023 08:48:14 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id F03AB20DFE78;
        Mon, 16 Jan 2023 08:48:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F03AB20DFE78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673887693;
        bh=830ratWRS4bQzvHuTEiO0/aT5X4L/o09Ymakf+Mlji4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YZNCE0gJDenDx4coBi2dBoU62ioG8/B8kXEr26IWl72tySAGQXvv5wBWdKVFiRulw
         8xhGeDoW6NqGRHcmJ5yrLl/ETL2IkuZM7qTDTfm0qxvUxCEsw3io7jubu86hCpO2pn
         KrWIQ8h54SHQ/gNU90qW2ooMCEf8S+RYCmvQA9EI=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH 1/4] drivers/clocksource/hyper-v: non ACPI support in hyperv clock
Date:   Mon, 16 Jan 2023 08:48:05 -0800
Message-Id: <1673887688-19151-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add a placeholder function for the hv_setup_stimer0_irq API to accommodate
systems without ACPI support. Since this function is not utilized on
x86/x64 systems and non-ACPI support is only intended for x86/x64 systems,
a placeholder function is sufficient for now and can be improved upon if
necessary in the future

This change will make it easier to add device tree support for VMBus in
subsequent commits.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c0cef92..f32948c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -49,7 +49,7 @@
 
 static int stimer0_irq = -1;
 static int stimer0_message_sint;
-static DEFINE_PER_CPU(long, stimer0_evt);
+static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
 
 /*
  * Common code for stimer0 interrupts coming via Direct Mode or
@@ -68,7 +68,7 @@ void hv_stimer0_isr(void)
  * stimer0 interrupt handler for architectures that support
  * per-cpu interrupts, which also implies Direct Mode.
  */
-static irqreturn_t hv_stimer0_percpu_isr(int irq, void *dev_id)
+static irqreturn_t __maybe_unused hv_stimer0_percpu_isr(int irq, void *dev_id)
 {
 	hv_stimer0_isr();
 	return IRQ_HANDLED;
@@ -196,6 +196,7 @@ void __weak hv_remove_stimer0_handler(void)
 {
 };
 
+#ifdef CONFIG_ACPI
 /* Called only on architectures with per-cpu IRQs (i.e., not x86/x64) */
 static int hv_setup_stimer0_irq(void)
 {
@@ -230,6 +231,16 @@ static void hv_remove_stimer0_irq(void)
 		stimer0_irq = -1;
 	}
 }
+#else
+static int hv_setup_stimer0_irq(void)
+{
+	return 0;
+}
+
+static void hv_remove_stimer0_irq(void)
+{
+}
+#endif
 
 /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
 int hv_stimer_alloc(bool have_percpu_irqs)
-- 
1.8.3.1

