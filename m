Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E869087A
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 13:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIMQy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 07:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBIMQt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 07:16:49 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBE19EB4A;
        Thu,  9 Feb 2023 04:16:30 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B424120C8AEE;
        Thu,  9 Feb 2023 04:15:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B424120C8AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675944943;
        bh=i1p50TI+7fOgk4LW62buuCzlHOInl+oROOTdYyM1xe0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R45l2RjlJuLHuNwf4WONyHHr7T+kRK6l5zCqx/yYfKrb1R2/eigbHgmD6zqWhOFl3
         sltSm2pidcN4VNi6j9iT4lMkklpiK8zqstWEO2chSL6SL81tbs+zK7SGDPP26hnxc/
         UIl+MdjWxFPHmIu87aPIgyFILzzgSdHJk7YU2erI=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@linux.microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v5 2/5] Drivers: hv: allow non ACPI compilation for hv_is_hibernation_supported
Date:   Thu,  9 Feb 2023 04:15:36 -0800
Message-Id: <1675944939-22631-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

acpi_sleep_state_supported() currently is defined only when
CONFIG_ACPI=y.  For future work to enable device tree builds, put this
function under #ifdef CONFIG_ACPI.  Otherwise, return 'false' from
hv_is_hibernation_supported() as Hyper-V guest configs using device
tree don't support hibernation.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/hv_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 52a6f89ccdbd..370ec20d1993 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -234,7 +234,11 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
 
 bool hv_is_hibernation_supported(void)
 {
+#ifdef CONFIG_ACPI
 	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
+#else
+	return false;
+#endif
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
 
-- 
2.34.1

