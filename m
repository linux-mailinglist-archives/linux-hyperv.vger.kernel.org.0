Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ADD6FF586
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 May 2023 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjEKPJD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 May 2023 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbjEKPJC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 May 2023 11:09:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B1EF3A8C;
        Thu, 11 May 2023 08:08:52 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8601420EAB68;
        Thu, 11 May 2023 07:55:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8601420EAB68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683816900;
        bh=yPkGjv6ed/fR0LYuHkAbjAvBuGZ9KC73Q4xkdpS6J4U=;
        h=From:To:Cc:Subject:Date:From;
        b=IYosbuCT9JurD1ivRhMVFDjjzAm+9Jv3zwmDhlxO8ZRT90nvglRA9mq9h30SDo0KW
         x6LGTDoHVEx/Ex4ba/KEGMEWN9HIZ7Hw96e5RTStfVltZR2Y1BKOGfw8yQXadopSXe
         N/Npk2vxZBUw/dLbex5bsDGzdHqQ0ZVmnwaMatuc=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     ssengar@microsoft.com
Subject: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE disable for OF platforms
Date:   Thu, 11 May 2023 07:54:36 -0700
Message-Id: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
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

X86_MPPARSE is only selectable when ACPI is enabled. However,
on Devicetree platforms where ACPI is disabled, it is always
enabled. Allow X86_MPPARSE to be selected by OF platforms as
well.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..e60315397399 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -469,7 +469,7 @@ config X86_X2APIC
 	  If you don't know what to do here, say N.
 
 config X86_MPPARSE
-	bool "Enable MPS table" if ACPI
+	bool "Enable MPS table" if ACPI || OF
 	default y
 	depends on X86_LOCAL_APIC
 	help
-- 
2.34.1

