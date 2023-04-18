Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D46E5863
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 07:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDRFMs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 01:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRFMq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 01:12:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B592C40E5;
        Mon, 17 Apr 2023 22:12:45 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 233DF21C2021;
        Mon, 17 Apr 2023 22:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 233DF21C2021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681794765;
        bh=jAe5ydWTNaBvjnqbWCKOjRz2xmpIzgRM0wkNQjWgDoM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M1HbQmdkh286aS7vXOm/VGrSIsRx5j5E/wDDmJhwVROFq3SyXkAJt9KzlJWC0x1JC
         SkFi1feXV7u+TT1BZ6eex2R8bQPtnxVu6gmPqnNudI4HCfh+hWzbIYKF/JIOVzX/M9
         nY+CoQcZKYNQrf8lYZLicw7Mg0OuI9f9Otnafe0s=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tiala@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 1/2] x86/init: Remove static for get/set_rtc_noop()
Date:   Mon, 17 Apr 2023 22:12:40 -0700
Message-Id: <1681794761-13734-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
References: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove static from get/set_rtc_noop() so that it can be accessed
outside of the file.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/kernel/x86_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ecdeb0974a87..d82f4fa2f1bf 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static void get_rtc_noop(struct timespec64 *now) { }
+int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.34.1

