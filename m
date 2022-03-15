Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510F44D9D04
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Mar 2022 15:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiCOOMS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Mar 2022 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiCOOMR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Mar 2022 10:12:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A992541B2;
        Tue, 15 Mar 2022 07:11:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e22so1646253edc.13;
        Tue, 15 Mar 2022 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wwoCRPMrcefnBxbhZufeA3EJ3zRm94AskzkPjHqZb0=;
        b=JiyouzBDg6UKek4lVS6yHdf8Q77dRiUBL42JWQOg5giG74Wch/tpCg1gkMFjcgOR/+
         iqTRt2YUlNgmZQ7L5kgXCXVwc3bbjEfqN/cepmrZvk9j/n491GCBvKBtaHixy7TRpF21
         SdXfUXKicgTDdF2syes4+2vAeNolVUnItYArd78PPSewhwvEpp0hnHs7Rh0kGfctnneM
         b8BdGqw65BIdNrSC1+d9jsp+qjAuwEA0fVNsKpT7rlYYQUp6mFDkh2X20WPCM6GTzXkC
         HuukOJzhHwwr4IQ/KTll4AGJj6exerE4jNLBiD7os3OP+N/tSYb50B6mZjIvm/p+uaG9
         534Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wwoCRPMrcefnBxbhZufeA3EJ3zRm94AskzkPjHqZb0=;
        b=ZQvGqlajoxITpFwzowsIL0vbtd0Pm+RpJ2l/wvndiUVaHx7kAKeFjIKIJOJ4l4+06P
         ku80Qkf3bEev7BUR8lmCcpikcJHkBjz/A2sZZfv6fTw/uxA8NkSwVn8VmDEVfJmqUgaA
         nymRD5bMlpOBsJgbUi50d7K6Jpujy9tN7EtSO/9gYqXCFBs6PhidLdfN+Lc4Rwrd8k6p
         zO2preEOon6rzrtRJWG1mAG3hcNTCxsu6hU7n+8MyAoL8IdS52cbrBWySU3acB7orgi3
         QdJZtzoM5FpPyj6M64kURnRnsD97szlARS9OS9WAov2aai6kHmDovvtffh9a2xG7/HH5
         mWUw==
X-Gm-Message-State: AOAM530Y3J4+1N8H0pduXdgbueBuqPAdUIpbSHkQDOekyAjEAUIOcqCY
        8CYrcqA2+Lb9jOh1CHPBdU0=
X-Google-Smtp-Source: ABdhPJyzhsAjQazH4iW/NLPVt2rf1hLMXLkOYAeJULuZGaA/3xdTroEXvmHt5f8BHxV6kgaeF7Bwdg==
X-Received: by 2002:aa7:c5d7:0:b0:415:ee77:d6f2 with SMTP id h23-20020aa7c5d7000000b00415ee77d6f2mr25400516eds.208.1647353463560;
        Tue, 15 Mar 2022 07:11:03 -0700 (PDT)
Received: from anparri.mshome.net (host-87-21-70-217.retail.telecomitalia.it. [87.21.70.217])
        by smtp.gmail.com with ESMTPSA id kb28-20020a1709070f9c00b006d5d8bf1b72sm8165152ejc.78.2022.03.15.07.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:11:03 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2] Drivers: hv: vmbus: Fix initialization of device object in vmbus_device_register()
Date:   Tue, 15 Mar 2022 15:10:53 +0100
Message-Id: <20220315141053.3223-1-parri.andrea@gmail.com>
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

Initialize the device's dma_{mask,parms} pointers and the device's
dma_mask value before invoking device_register().  Address the
following trace with 5.17-rc7:

[   49.646839] WARNING: CPU: 0 PID: 189 at include/linux/dma-mapping.h:543
	netvsc_probe+0x37a/0x3a0 [hv_netvsc]
[   49.646928] Call Trace:
[   49.646930]  <TASK>
[   49.646935]  vmbus_probe+0x40/0x60 [hv_vmbus]
[   49.646942]  really_probe+0x1ce/0x3b0
[   49.646948]  __driver_probe_device+0x109/0x180
[   49.646952]  driver_probe_device+0x23/0xa0
[   49.646955]  __device_attach_driver+0x76/0xe0
[   49.646958]  ? driver_allows_async_probing+0x50/0x50
[   49.646961]  bus_for_each_drv+0x84/0xd0
[   49.646964]  __device_attach+0xed/0x170
[   49.646967]  device_initial_probe+0x13/0x20
[   49.646970]  bus_probe_device+0x8f/0xa0
[   49.646973]  device_add+0x41a/0x8e0
[   49.646975]  ? hrtimer_init+0x28/0x80
[   49.646981]  device_register+0x1b/0x20
[   49.646983]  vmbus_device_register+0x5e/0xf0 [hv_vmbus]
[   49.646991]  vmbus_add_channel_work+0x12d/0x190 [hv_vmbus]
[   49.646999]  process_one_work+0x21d/0x3f0
[   49.647002]  worker_thread+0x4a/0x3b0
[   49.647005]  ? process_one_work+0x3f0/0x3f0
[   49.647007]  kthread+0xff/0x130
[   49.647011]  ? kthread_complete_and_exit+0x20/0x20
[   49.647015]  ret_from_fork+0x22/0x30
[   49.647020]  </TASK>
[   49.647021] ---[ end trace 0000000000000000 ]---

Fixes: 743b237c3a7b0 ("scsi: storvsc: Add Isolation VM support for storvsc driver")
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
Changes since v1[1]:
  - Move dma_set_mask() as well (Michael)

[1] https://lkml.kernel.org/r/20220311133738.38649-1-parri.andrea@gmail.com

 drivers/hv/vmbus_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37e87f30..0a05e10ab36c7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2097,6 +2097,10 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.parent = &hv_acpi_dev->dev;
 	child_device_obj->device.release = vmbus_device_release;
 
+	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
+	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
+	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
+
 	/*
 	 * Register with the LDM. This will kick off the driver/device
 	 * binding...which will eventually call vmbus_match() and vmbus_probe()
@@ -2122,9 +2126,6 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	}
 	hv_debug_add_dev_dir(child_device_obj);
 
-	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
-	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
-	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 	return 0;
 
 err_kset_unregister:
-- 
2.25.1

