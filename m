Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73F2725193
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jun 2023 03:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjFGBgD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Jun 2023 21:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbjFGBgB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Jun 2023 21:36:01 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A57AC1984;
        Tue,  6 Jun 2023 18:36:00 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1159)
        id 13CD120BE499; Tue,  6 Jun 2023 18:36:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13CD120BE499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686101760;
        bh=lly0SJj2u+pRh0HVxmkj8xN/oGXK4TlaG54X0J3Z6HE=;
        h=From:To:Cc:Subject:Date:From;
        b=hcFpLQt8xaweFX7lTiSWlVfwW4Gk5GcMySVi/wWFvQc08LdkvrH8ByBM7jlkGv+Tv
         IWq2fqPUFKptd7xAZzLYv+qXNjExxzOh+88HTq45aoPmk0a7V1KMBqsGutphjChHop
         cXricizgrJP7e/eVua6ntgaK2hwemLbjESHTd+/M=
From:   Nischala Yelchuri <niyelchu@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tyler Hicks <code@tyhicks.com>, boqun.feng@gmail.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nischala Yelchuri <niyelchu@microsoft.com>,
        Nischala Yelchuri <niyelchu@linux.microsoft.com>
Subject: [PATCH] x86/hyperv: Trace hv_set_register()
Date:   Tue,  6 Jun 2023 18:35:57 -0700
Message-Id: <1686101757-23985-1-git-send-email-niyelchu@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add a new trace point trace_hyperv_set_register()
to capture register address and its value in hv_set_register().

Signed-off-by: Nischala Yelchuri <niyelchu@linux.microsoft.com>
---
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++++++++
 arch/x86/kernel/cpu/mshyperv.c      |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index a8e5a7a2b..54b2f69f5 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -86,6 +86,20 @@ TRACE_EVENT(hyperv_send_ipi_one,
 		      __entry->cpu, __entry->vector)
 	);
 
+TRACE_EVENT(hyperv_set_register,
+	    TP_PROTO(unsigned int reg,
+		     u64 value),
+	    TP_ARGS(reg, value),
+	    TP_STRUCT__entry(
+		    __field(unsigned int, reg)
+		    __field(u64, value)
+		    ),
+	    TP_fast_assign(__entry->reg = reg;
+		    __entry->value = value;
+		    ),
+	    TP_printk("reg %u value %llu",
+		    __entry->reg, __entry->value)
+	);
 #endif /* CONFIG_HYPERV */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c7969e806..d4ef63f4e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/trace/hyperv.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -98,6 +99,8 @@ EXPORT_SYMBOL_GPL(hv_get_register);
 
 void hv_set_register(unsigned int reg, u64 value)
 {
+	trace_hyperv_set_register(reg, value);
+
 	if (hv_nested)
 		reg = hv_get_nested_reg(reg);
 
-- 
2.25.1

