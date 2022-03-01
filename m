Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC74C8D67
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiCAON5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 09:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiCAONy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 09:13:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664077B546;
        Tue,  1 Mar 2022 06:13:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h15so22163121edv.7;
        Tue, 01 Mar 2022 06:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XbBh6y93WJCYOvDM+EJo5FnNHZVWpJseZ0yP8iYWZjM=;
        b=fqZEtVsw5rl7Bz7p190YAW0lU17YEGBHKeYRlulUChvlYfA9iWrdOg/S5o0HRtufm1
         2OCQfBKCTZVS948bFOJZL6d0OxZ/IzPmkHoSCQW0xXSuUaTizzmU8kUqNOepxqb1sXkw
         0ziB0E7drug+XroNZAJciOBFtw6TSpXipHhawLAihu4s/TcHC601OmEWVl96vQ6pJ+bK
         MFvhc/W74C/HKCt1mt5ujCiS6JSegf92fxZ+y8Zrif4ZYFgSZETA2mi6z7OpHY5pr33t
         CRJB4q/LpKba0PfvCjd0fRjNYrsclJCiQDYhRCVKJNgACv7FEsE5tijsdVZkV1YDjzrt
         d4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XbBh6y93WJCYOvDM+EJo5FnNHZVWpJseZ0yP8iYWZjM=;
        b=2QlmWi20FQmCmSFrJ4WBSkWWRWlCAEBcPfnx5cQZbTeoJxdeSq3JkGSwSmc4JRM5tu
         QVrcwBe2vw1mLdCJmfVCdN20GxuYxqIAU4d8hPSrF4UsOil8lks/ZKT5pwh7FbDuPH18
         8WapY6+zdoQbpwIPFYA5uuLWGkF5VIehm8IBtgQDgx1iMHVRnD1Bc0Kte1Xxg3o8Hy5j
         luGEtd/oz5WN7Bspd195fyYu3DwV5VkLY5bcaVT4hbV7yvimzwOh++c+0bKzwoCnxzgT
         AJ56et/Ak/3oL0UJkgO2FvLgdffKswBlJ7qnQXpp3AtqPt6M4VldARGW8ULTaWDm6poM
         QGTA==
X-Gm-Message-State: AOAM530P5MP4ug8VzC1afBEb+a6Q0nAxAyoEDML5CaU4rlQGf0fm9vk0
        8cFM3kj0N4EashlZU/TC7CCvKFSkVsFeJQ==
X-Google-Smtp-Source: ABdhPJw8aOpymS6iF6Ox0SQpfa+KhaPOqAMVl/aiX/VlJCy1CcCch+rEnnvQbu68VYUp7C27sUIxcg==
X-Received: by 2002:a05:6402:11ce:b0:412:f162:28e8 with SMTP id j14-20020a05640211ce00b00412f16228e8mr24577969edw.341.1646143990829;
        Tue, 01 Mar 2022 06:13:10 -0800 (PST)
Received: from anparri.mshome.net ([87.13.191.110])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm5341883eji.67.2022.03.01.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 06:13:10 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH] Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg by default in isolated guests
Date:   Tue,  1 Mar 2022 15:11:35 +0100
Message-Id: <20220301141135.2232-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

hv_panic_page might contain guest-sensitive information, do not dump it
over to Hyper-V by default in isolated guests.

While at it, update some comments in hyperv_{panic,die}_event().

Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/vmbus_drv.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37e87f30..a963b970ffb2f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -77,8 +77,8 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 
 	/*
 	 * Hyper-V should be notified only once about a panic.  If we will be
-	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
-	 * the notification here.
+	 * doing hv_kmsg_dump() with kmsg data later, don't do the notification
+	 * here.
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
 	    && hyperv_report_reg()) {
@@ -100,8 +100,8 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 
 	/*
 	 * Hyper-V should be notified only once about a panic.  If we will be
-	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
-	 * the notification here.
+	 * doing hv_kmsg_dump() with kmsg data later, don't do the notification
+	 * here.
 	 */
 	if (hyperv_report_reg())
 		hyperv_report_panic(regs, val, true);
@@ -1546,14 +1546,20 @@ static int vmbus_bus_init(void)
 	if (ret)
 		goto err_connect;
 
+	if (hv_is_isolation_supported())
+		sysctl_record_panic_msg = 0;
+
 	/*
 	 * Only register if the crash MSRs are available
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		u64 hyperv_crash_ctl;
 		/*
-		 * Sysctl registration is not fatal, since by default
-		 * reporting is enabled.
+		 * Panic message recording (sysctl_record_panic_msg)
+		 * is enabled by default in non-isolated guests and
+		 * disabled by default in isolated guests; the panic
+		 * message recording won't be available in isolated
+		 * guests should the following registration fail.
 		 */
 		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
 		if (!hv_ctl_table_hdr)
-- 
2.25.1

