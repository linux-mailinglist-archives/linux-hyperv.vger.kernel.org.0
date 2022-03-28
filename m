Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAB4E9B64
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Mar 2022 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiC1Pr3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Mar 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbiC1PrX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Mar 2022 11:47:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B062C96;
        Mon, 28 Mar 2022 08:45:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a17so17417177edm.9;
        Mon, 28 Mar 2022 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exQYqA0enL+9Ts/1r+j7oGaQ8SoaMtPVWOjEy/JoIMM=;
        b=QOAyM4Pxqb0tH3qU6BwyPmH6SEmiVBH3I94IaSVTpTAoONc65nD4cQ6zpO2/+7c7HL
         kyKmLr1Fs7kIhHMMW8dmpsQ1qBatqjQm4CumOdg7UTbx8VyqUYNoHHfDcXCKX74K8Oio
         Wzxtp9xkLGbKRgn6WENzKR8aM36qvLPYQUJKhBOW9HCkpfTOxz1k5ZVuy/zr23IipvgA
         Aw5Des+3qMXPK4WXSnOZNovV3P1Q/v+Mk+S2jA1OKH8IFWclVFS7KhnukRmM6os/9znZ
         WqvT81MoBx43DjmqA2/HeQiDSHmyhsS7gryr6yoIXRwft0HAGqpNUm45GBOlFjfBj/3g
         3R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exQYqA0enL+9Ts/1r+j7oGaQ8SoaMtPVWOjEy/JoIMM=;
        b=P7zaNAVu2PU+LDzSpoaiZLlcftHckaFJiHpCZ3BS1NicmYrrs6VGl5R3ptUwQGmudS
         YSPuq0FF6m5vTehcVTGxObtry7JmyMrhj7ErP9AWadMRsCLufc02pIYL+XeDQ+JlgcGi
         hObmjmEjZVSLWxEvA8Z8ptHCI+SKxFCGxf2kOSHZnDKXpVvE+zygm3Tlg8OIoxwgmVS8
         CLukr5fTO8RKTH6A8++CIYtfbzuv8MHNEoqaTYzdpPBIhMk3eMRxeapQ2TjEV3kIYlSO
         miFE/cXEtJGoA647MiBE+iJsw//9C9ZAWljIxFqKVaSLgxqb50U4o7r6c1v0rZalbj5k
         anMQ==
X-Gm-Message-State: AOAM533Gg3KjdrGjiZ7u0fB3d2nCfrPon3rq7kpYxMIsQGfpjcLfr0MO
        qZP8sYgFGMugFVVgD9esz6y6zA+SmMBqGkJN
X-Google-Smtp-Source: ABdhPJykenhnDOei8/V17X9dvlK3a4xTZaHrOGW9xnoo057/Gn6KaqXira+Y4/0WR4xi51fWIunTeA==
X-Received: by 2002:a05:6402:909:b0:416:6f3c:5c1d with SMTP id g9-20020a056402090900b004166f3c5c1dmr16917791edz.108.1648482306061;
        Mon, 28 Mar 2022 08:45:06 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm6991102edu.96.2022.03.28.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 08:45:05 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH] Drivers: hv: vmbus: Replace smp_store_mb() with virt_store_mb()
Date:   Mon, 28 Mar 2022 17:44:57 +0200
Message-Id: <20220328154457.100872-1-parri.andrea@gmail.com>
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

Following the recommendation in Documentation/memory-barriers.txt for
virtual machine guests.

Fixes: 8b6a877c060ed ("Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels")
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 60375879612f3..67be81208a2d9 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -380,7 +380,7 @@ void vmbus_channel_map_relid(struct vmbus_channel *channel)
 	 * execute:
 	 *
 	 *  (a) In the "normal (i.e., not resuming from hibernation)" path,
-	 *      the full barrier in smp_store_mb() guarantees that the store
+	 *      the full barrier in virt_store_mb() guarantees that the store
 	 *      is propagated to all CPUs before the add_channel_work work
 	 *      is queued.  In turn, add_channel_work is queued before the
 	 *      channel's ring buffer is allocated/initialized and the
@@ -392,14 +392,14 @@ void vmbus_channel_map_relid(struct vmbus_channel *channel)
 	 *      recv_int_page before retrieving the channel pointer from the
 	 *      array of channels.
 	 *
-	 *  (b) In the "resuming from hibernation" path, the smp_store_mb()
+	 *  (b) In the "resuming from hibernation" path, the virt_store_mb()
 	 *      guarantees that the store is propagated to all CPUs before
 	 *      the VMBus connection is marked as ready for the resume event
 	 *      (cf. check_ready_for_resume_event()).  The interrupt handler
 	 *      of the VMBus driver and vmbus_chan_sched() can not run before
 	 *      vmbus_bus_resume() has completed execution (cf. resume_noirq).
 	 */
-	smp_store_mb(
+	virt_store_mb(
 		vmbus_connection.channels[channel->offermsg.child_relid],
 		channel);
 }
-- 
2.25.1

