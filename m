Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E675973BC88
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jun 2023 18:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjFWQ2Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Jun 2023 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjFWQ2Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Jun 2023 12:28:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E73E2710;
        Fri, 23 Jun 2023 09:28:15 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8FD8D21C2534;
        Fri, 23 Jun 2023 09:28:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FD8D21C2534
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687537694;
        bh=uUfUVqQEgw+ilqrVChAV82J5lEYGJvj7rlgWsv6YSw4=;
        h=From:To:Subject:Date:From;
        b=cqHRvziEAvf0RxzqcfNW+exJH4CcnrVS1eBGZD39s6fAfgq3ftupa+o/VlRst20Sm
         jeNNVPXTHHDXiUcvLVk9cuosBriMbnXql3akrDHZNRcSnm5G8EdmkF3XnPdDV8WxM8
         QGpjZW9Zf6aUmU9/1zP/rGKjQL1YmxORyyDuV2yM=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
Subject: [PATCH v3] x86/hyperv: add noop functions to x86_init mpparse functions
Date:   Fri, 23 Jun 2023 09:28:08 -0700
Message-Id: <1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com>
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

Hyper-V can run VMs at different privilege "levels" known as Virtual
Trust Levels (VTL). Sometimes, it chooses to run two different VMs
at different levels but they share some of their address space. In
such setups VTL2 (higher level VM) has visibility of all of the
VTL0 (level 0) memory space.

When the CONFIG_X86_MPPARSE is enabled for VTL2, the VTL2 kernel
performs a search within the low memory to locate MP tables. However,
in systems where VTL0 manages the low memory and may contain valid
tables, this scanning can result in incorrect MP table information
being provided to the VTL2 kernel, mistakenly considering VTL0's MP
table as its own

Add noop functions to avoid MP parse scan by VTL2.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V3]
 - modify commit message.

 arch/x86/hyperv/hv_vtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 85d38b9f3586..db5d2ea39fc0 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -25,6 +25,10 @@ void __init hv_vtl_init_platform(void)
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

