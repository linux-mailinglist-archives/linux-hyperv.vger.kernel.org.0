Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB106B8E54
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Mar 2023 10:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCNJQC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Mar 2023 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNJQA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Mar 2023 05:16:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8EEF584AF;
        Tue, 14 Mar 2023 02:15:58 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6C9372056DC0;
        Tue, 14 Mar 2023 02:15:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C9372056DC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678785358;
        bh=4PRW0VI+oZvbTmFAcVbsrAFK92yD8Gwq6n0ZpwB9zPo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OyemaTHuBUQ1RokPxZUv77NtDDy7FRBP4eNqjCOn4mhmy11emceu89ZYw8j3oDJ9V
         zo6m0tVH+EgZeucJJv2D+JYPUWadBAPk2LEn71RPUpJh64Az65i9DpgPkRhUJt3Nq9
         0iv6WC/KY1ZnZhhOp2UtXqyeFapzEhPBlvkWGd8w=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v8 2/5] ACPI: bus: Add stub acpi_sleep_state_supported() in non-ACPI cases
Date:   Tue, 14 Mar 2023 02:15:47 -0700
Message-Id: <1678785350-20400-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
References: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

acpi_sleep_state_supported() is defined only when CONFIG_ACPI=y. The
function is in acpi_bus.h, and acpi_bus.h can only be used in
CONFIG_ACPI=y cases. Add the stub function to linux/acpi.h to make
compilation successful for !CONFIG_ACPI cases.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index efff750f326d..d331f76b0c19 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1075,6 +1075,11 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
 	return 0;
 }
 
+static inline bool acpi_sleep_state_supported(u8 sleep_state)
+{
+	return false;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
2.34.1

