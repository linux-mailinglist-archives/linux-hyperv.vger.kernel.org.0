Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064654D6280
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Mar 2022 14:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiCKNjJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Mar 2022 08:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiCKNjI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Mar 2022 08:39:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0A56928E;
        Fri, 11 Mar 2022 05:38:05 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id dr20so19018519ejc.6;
        Fri, 11 Mar 2022 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W24BUb9PU48a1wp66lMTriy5Lf3T0UJAPs6oCNXDvpw=;
        b=NFGh7X8rrjbCfeD553z9Er6ZdE9XbXIvLN+3VXVJq5/AxYiamqUyP6v7Mf/E/wSUca
         c2+dUqq76tIfp4Dx/bkfjjX4A9hl5TtWAKu8PsIOFwwd3a7Jyn7WtDYdZZMNIP9lPs9N
         YeEtbwGuDHhniUQoEsiFP4E7kPZ4wxn/zauBw78jtWx7UrqqQqXHGTZ3DmkwpTNG0HAS
         XWvpGRGD76hyndA0iPc0FlPpTJhkVJe7zSslHBSdo2Xevu2EycNTjgVo94xiCJAGhDZ+
         iiRaX6jk2B7SLe0qcQEErH/WO4f2LGdr7P9/XNae877jfVZcytsDKD3KopcmtQmZRHF1
         H9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W24BUb9PU48a1wp66lMTriy5Lf3T0UJAPs6oCNXDvpw=;
        b=N4fRdp7ozAnWDnjSdJIBlkNZiIVjSFdepoL8zIxWgdvioEl6YQIfzOOLGfa9npWoIo
         WQg9nFLZqO8TIfglHRXCYcN5E1lq4YqU+tAyFEPYpwkYUrdwqOzYJceW4/Sr7NmrmGtz
         M6RtOXgfco3ynurZLtwbd1qbN8Pe5aWf6eRGn+Az/zv39bVZvh4Vb+S2RtLB2x5VyTQ1
         bgRsHOpdZQPKvdS9yfLSu2A8vwAe0im5/d/1zCK4VyssUdiJyrR2bqA/zqbjz1F3m4+W
         KtzpwUfKqjaWqDF1UaqaiN5ahQSo9gmM7DLMgr6wT1PMPDoc189iue1LnWYkwwbmW/hf
         BKUQ==
X-Gm-Message-State: AOAM530k71/JFWUcpKAYtCfKPmVqqIGdIF/tRZAqFvyiQScISEEF9Nf0
        dm66shVKR4rCfma+v0eIViY=
X-Google-Smtp-Source: ABdhPJyzR/2XCCslcFq83oZvvYArnNsBJq1xuioI5x8DEWChrlGM15Q638jrMv+7h5P68nDEGvYHRQ==
X-Received: by 2002:a17:906:7954:b0:6da:9ee0:2e54 with SMTP id l20-20020a170906795400b006da9ee02e54mr8943539ejo.630.1647005881918;
        Fri, 11 Mar 2022 05:38:01 -0800 (PST)
Received: from anparri.mshome.net (host-79-27-67-85.retail.telecomitalia.it. [79.27.67.85])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006db088ca6d0sm2895181ejc.126.2022.03.11.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:38:01 -0800 (PST)
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
Subject: [PATCH] Drivers: hv: vmbus: Fix initialization of device object in vmbus_device_register()
Date:   Fri, 11 Mar 2022 14:37:38 +0100
Message-Id: <20220311133738.38649-1-parri.andrea@gmail.com>
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

Initialize the device's dma_{mask,parms} pointers before invoking
device_register().  Address the following trace with 5.17-rc7:

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
 drivers/hv/vmbus_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37e87f30..65db5048b1763 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2097,6 +2097,9 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.parent = &hv_acpi_dev->dev;
 	child_device_obj->device.release = vmbus_device_release;
 
+	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
+	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
+
 	/*
 	 * Register with the LDM. This will kick off the driver/device
 	 * binding...which will eventually call vmbus_match() and vmbus_probe()
@@ -2122,8 +2125,6 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	}
 	hv_debug_add_dev_dir(child_device_obj);
 
-	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
-	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
 	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 	return 0;
 
-- 
2.25.1

