Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7468C535
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Feb 2023 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBFRyc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Feb 2023 12:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBFRy3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Feb 2023 12:54:29 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0701023131;
        Mon,  6 Feb 2023 09:54:28 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 72FA120C7E06;
        Mon,  6 Feb 2023 09:54:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72FA120C7E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675706068;
        bh=6TOzOHNuOYRZLgJ5e6g2o3t3C9KRoSgljHBsyQDtJMk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lodkqHyuni3tPNzCPMJpHVI1J0cnsu1xkx/H/vTzwv+HumRYwh1Rdwh3ibVImprup
         BhNg3A7QEr91JSQzQvEHOJpnOIy9FCuvyz3rzfwWPCVjYZymfOEq1YkmYjybTJ4s5R
         UCH9v6OQUvVCQPE2WEpZX6himCENNXWojjagOP/4=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v3 2/6] Drivers: hv: allow non ACPI compilation for hv_is_hibernation_supported
Date:   Mon,  6 Feb 2023 09:54:16 -0800
Message-Id: <1675706060-22361-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675706060-22361-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675706060-22361-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

acpi_sleep_state_supported API is only define for CONFIG_ACPI flag and
thus it can't be used for non-ACPI builds. Initially there won't be
hibernation support for non ACPI builds.

This change will help adding device tree support in subsequent commits.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V3]
- Typos fix: s/Initaly/Initially/ and s/hibernate/hibernation/.

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
2.25.1

