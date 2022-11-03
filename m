Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47404618294
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 16:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKCPYO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKCPYM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 11:24:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DF0515827;
        Thu,  3 Nov 2022 08:24:12 -0700 (PDT)
Received: from anrayabh-desk.corp.microsoft.com (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id B9FFF20C3338;
        Thu,  3 Nov 2022 08:24:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9FFF20C3338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667489051;
        bh=B+nihbaQ/cnO5MxH1a/EyI4K5Rm5LqSQzIW/65Ge7UA=;
        h=From:To:Cc:Subject:Date:From;
        b=cM3AdOan+ajzCyLXooGLGKHwUEZIAU5YSidnAn8uAj9qdv3Ry2lJzGgf6ttx8JbTS
         MChjTJhNln27fqvWY8o9qk/GZg0h3Pt2EMb/ZIpvC28LjcWjO9TDWAkd2BnOTwoMeb
         BmpVrkawEqJ/kO2M6/zC7PcA0OozgXcUTkanBgfs=
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mail@anirudhrb.com, kumarpraveen@linux.microsoft.com,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/hyperv: use Hyper-V's page size to calculate PFN
Date:   Thu,  3 Nov 2022 20:53:37 +0530
Message-Id: <20221103152338.2926983-1-anrayabh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__phys_to_pfn() will return a PFN based on the guest page size, which might
be different from Hyper-V's page size that is always 4K. The PFN for the
TSC page always needs to be a Hyper-V PFN.

Use HVPFN_DOWN() to calculate the PFN of the TSC page from the physical
address.

Reported-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 11332c82d1af..18de1f439ffd 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/acpi.h>
+#include <linux/hyperv.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -412,7 +413,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	/* Re-enable the TSC page */
 	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
 	tsc_msr.enable = 1;
-	tsc_msr.pfn = __phys_to_pfn(phys_addr);
+	tsc_msr.pfn = HVPFN_DOWN(phys_addr);
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
@@ -532,7 +533,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	 */
 	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
 	tsc_msr.enable = 1;
-	tsc_msr.pfn = __phys_to_pfn(phys_addr);
+	tsc_msr.pfn = HVPFN_DOWN(phys_addr);
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
-- 
2.34.1

