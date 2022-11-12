Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692EF626B1B
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiKLTDI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Nov 2022 14:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLTDH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Nov 2022 14:03:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690F32706;
        Sat, 12 Nov 2022 11:03:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668279784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UlPHg7oN9UJeMU3FvPvwIBheN+dHkzkfX0GVcGqmqwI=;
        b=UWKjKP7Aw9LNViF8bq4SlSEZGztBoENYR3B+xt2fLeqdlkYYzKlyMSXQ9IA5SOddDh9fSP
        Zq0FBB9wCsaZxoaq/6nPJNEoFOOAJ+bIA4Gm4f8xeptwYYZ7ydl7Wywpb97LCs0FxwQqTk
        biatQUQrZmuwResgDPFP1aS+Zg/OTi0AAtCqjUACSf0MhDHQ0DGJeHzrXe49x4CKjRL2ur
        ZwBU3NtCDu6hZpg4kSs8L5SP4ziAUwxNDc7Xowr8BHqfLajLFXTbEdrS8HmEhLM1owakfh
        zon+UbZenOssKE3dbYK3Cd6MdHXiXi0h4sRF5DN8twxaoSvnp6nNHGG7ySJY3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668279784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UlPHg7oN9UJeMU3FvPvwIBheN+dHkzkfX0GVcGqmqwI=;
        b=UhlvPMsdlaHdxfKyllnCqK/WOiyDUNsoQc0Mj8Xb0nn9NW2ve9BmOBQpHKgCMMFkR6btNT
        1q13Fd+Djka/OdCg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not
 asm/mshyperv.h
Date:   Sat, 12 Nov 2022 20:03:03 +0100
Message-ID: <87zgcwt2qg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

clocksource/hyperv_timer.h is included into the VDSO build. It includes
asm/mshyperv.h which in turn includes the world and some more.

This worked so far by chance, but any subtle change in the include chain
results in a build breakage because VDSO builds are building user space
libraries.

Include asm/hyperv-tlfs.h instead which contains everything what the VDSO
build needs and move the hv_get_raw_timer() define into the header file.

Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
asm/mshyperv.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mshyperv.h    |    2 --
 drivers/hv/vmbus_drv.c             |    1 +
 include/clocksource/hyperv_timer.h |    4 +++-
 3 files changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -19,8 +19,6 @@ typedef int (*hyperv_fill_flush_list_fun
 		struct hv_guest_mapping_flush_list *flush,
 		void *data);
 
-#define hv_get_raw_timer() rdtsc_ordered()
-
 void hyperv_vector_handler(struct pt_regs *regs);
 
 #if IS_ENABLED(CONFIG_HYPERV)
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -37,6 +37,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
 
 struct vmbus_dynid {
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -15,7 +15,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/mshyperv.h>
+#include <asm/hyperv-tlfs.h>
 
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
@@ -34,6 +34,8 @@ extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
+#define hv_get_raw_timer() rdtsc_ordered()
+
 static inline notrace u64
 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
 {
