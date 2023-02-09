Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579FC6912EE
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 23:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBIWC7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 17:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIWC6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 17:02:58 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 157AA26AD;
        Thu,  9 Feb 2023 14:02:58 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 66C2920C8AF4;
        Thu,  9 Feb 2023 14:02:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66C2920C8AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675980177;
        bh=EK/+vo/FmUepqV7P4sor2Z8FWweETZJ9bVLMsQHPKiI=;
        h=From:To:Cc:Subject:Date:From;
        b=APMDTzvkDgMkIwMf4dXfumunuOJPFgopxxev8Va8UXR4D/cPVZlLQWKviXqdOv44k
         NwPvrQrHpuOMnnfwsNT2dIvDZbK7r9sb1VCu9TwTghZNk1Z9HH7YZJDqZRhUuchepH
         OlQtgMNiMcVIFholHb2J0qF/t614522a7ZCvSSRo=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, wei.liu@kernel.org, jinankjain@linux.microsoft.com
Cc:     mikelley@microsoft.com, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Subject: [PATCH] x86/hyperv: Fix hv_get/set_register for nested bringup
Date:   Thu,  9 Feb 2023 14:02:52 -0800
Message-Id: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

hv_get_nested_reg only translates SINT0, resulting in the wrong sint
being registered by nested vmbus.
Fix the issue with new utility function hv_is_sint_reg.
While at it, improve clarity of hv_set_non_nested_register and hv_is_synic_reg.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 11 +++++++----
 arch/x86/kernel/cpu/mshyperv.c  |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 9ae1a344536b..684c547c1cca 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -225,10 +225,13 @@ extern bool hv_isolation_type_snp(void);
 
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
-	if ((reg >= HV_REGISTER_SCONTROL) &&
-	    (reg <= HV_REGISTER_SINT15))
-		return true;
-	return false;
+	return (reg >= HV_REGISTER_SCONTROL) &&
+	       (reg <= HV_REGISTER_SINT15);
+}
+static inline bool hv_is_sint_reg(unsigned int reg)
+{
+	return (reg >= HV_REGISTER_SINT0) &&
+	       (reg <= HV_REGISTER_SINT15);
 }
 
 u64 hv_get_register(unsigned int reg);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 0ceb6d1f9c3c..6bd344e1200f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -44,6 +44,9 @@ struct ms_hyperv_info ms_hyperv;
 #if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_reg(unsigned int reg)
 {
+	if (hv_is_sint_reg(reg))
+		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
+
 	switch (reg) {
 	case HV_REGISTER_SIMP:
 		return HV_REGISTER_NESTED_SIMP;
@@ -53,8 +56,6 @@ static inline unsigned int hv_get_nested_reg(unsigned int reg)
 		return HV_REGISTER_NESTED_SVERSION;
 	case HV_REGISTER_SCONTROL:
 		return HV_REGISTER_NESTED_SCONTROL;
-	case HV_REGISTER_SINT0:
-		return HV_REGISTER_NESTED_SINT0;
 	case HV_REGISTER_EOM:
 		return HV_REGISTER_NESTED_EOM;
 	default:
@@ -80,8 +81,7 @@ void hv_set_non_nested_register(unsigned int reg, u64 value)
 		hv_ghcb_msr_write(reg, value);
 
 		/* Write proxy bit via wrmsl instruction */
-		if (reg >= HV_REGISTER_SINT0 &&
-		    reg <= HV_REGISTER_SINT15)
+		if (hv_is_sint_reg(reg))
 			wrmsrl(reg, value | 1 << 20);
 	} else {
 		wrmsrl(reg, value);
-- 
2.25.1

