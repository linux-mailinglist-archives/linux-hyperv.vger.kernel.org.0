Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6972024B
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjFBMl6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBMl5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 08:41:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 022DB13D;
        Fri,  2 Jun 2023 05:41:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 73F1220FCD4F;
        Fri,  2 Jun 2023 05:41:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73F1220FCD4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685709716;
        bh=CYFJLeDTCw3IfeJbOMeEsgxwh59MLlV9KXPjuDvd634=;
        h=From:To:Subject:Date:From;
        b=QNWh05LZTGEW/x9oPwlqDErkIN87ieDHA0LavFn/+ysV5pa9mqnXGeiY9QcALniin
         thoDpCsIDq4pYx0+uHtHYoCxpyFTSS2icS6cpyTFCW601u+SpVA3C2Sbx/Xa1A6gAJ
         fzztPhIbkib/hQggouVdJSaT64T1HCwGtFE/2/HE=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
Subject: [PATCH] x86/hyperv: add noop functions to x86_init mpparse functions
Date:   Fri,  2 Jun 2023 05:41:52 -0700
Message-Id: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
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

In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE.
When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel will
scan low memory looking for MP tables. Don't allow this, because
low memory is controlled by VTL0 and may contain actual valid
tables for VTL0, which can confuse the VTL2 kernel.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 1ba5d3b99b16..ea21d897b5da 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -23,6 +23,10 @@ void __init hv_vtl_init_platform(void)
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 
+	/* Avoid searching for BIOS MP tables */
+	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
+
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
 	x86_platform.get_nmi_reason = hv_get_nmi_reason;
-- 
2.34.1

