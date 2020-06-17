Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1B1FD298
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgFQQsA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgFQQr7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:47:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C0C06174E;
        Wed, 17 Jun 2020 09:47:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so2518278wme.3;
        Wed, 17 Jun 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ORuyjMnnXwMLSIeDovz3YoY1V6fNCALDgeCEXg6SIA=;
        b=SJuPROnlqweOFqWO6PVnR52VAPAIj0jUathvBUvgDVqrvlf2WhZP64Wd36soN1tC3B
         3OMwEviDhXUavoHBuLFfpAYTFOYABZIBupQpzb8iXEn6zwiKxtrmTajue+h+JAFCOcwX
         8NgF7gAqsHN7KR8RtJ6X6C6M5gJ8Sfm5V5jxHWL+LXcmV1XuH4e1nY/y5GMdFBDniIDq
         zyeYYsUeNWF1xDPzw/Yl8mtg7pDZxjXdpBFh4Iodb1AOWWW7s2DJxsze/9pnXZuBqD2c
         D78Xn1grxqnOKipMXkIFNQ4GafvgQAx0nXcNJAwhpcIHVkcUHu/LIuzOSBxaDO0lgQfJ
         f0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ORuyjMnnXwMLSIeDovz3YoY1V6fNCALDgeCEXg6SIA=;
        b=c9yWsd+7yR6uZJo6AHo8TzEyOmxezj9ReocKVXjmXC0hs3rmJwWXfFDmHVi9fIitlO
         cnG3bl9taqeo7r2hmxcRYttImrxLh/FiTp6tofr8ZpjpoNY424CwVwyG0+DbR/2C4+jm
         7+suVfc+khcLlNkdmw8LUMzjcDD1OgxpGmCHWW+TfFaAfczOJbz5A3zG71slDDjbWqBT
         jlHSUK0oCu23PAnfZhYhgLV0LMcDw/HV3XOMD7xTj/wp6GQVMheRvQT+5Z8nC1gfo95F
         xDXCBpbPtPiPAft18qMkt+p0V/yUCM/fXSxQruzeDJUQvMXxvTb8Ti4g71bu63kHOgM9
         WAwQ==
X-Gm-Message-State: AOAM532deZ6Bl3nGCDqPW+F/nepdKeum54Gw4te8Il8Hj+CHjckVsGZZ
        8lZ00IHYmEDrOHdqzwDrKow=
X-Google-Smtp-Source: ABdhPJzNFfEVcnQLQBRuM6dGcwercrxnx82rnUzzm88FPvuKJQ+0n57jPloqxR0HqKha9e+IhFGYCQ==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr9141632wms.109.1592412476855;
        Wed, 17 Jun 2020 09:47:56 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:47:56 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 4/8] Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections (sc_list readers)
Date:   Wed, 17 Jun 2020 18:46:38 +0200
Message-Id: <20200617164642.37393-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Additions/deletions to/from sc_list (as well as modifications of
target_cpu(s)) are protected by channel_mutex, which hv_synic_cleanup()
and vmbus_bus_suspend() own for the duration of the channel->lock
critical section in question.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/hv.c        | 3 ---
 drivers/hv/vmbus_drv.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 188b42b07f07b..0c637111e7c70 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -245,7 +245,6 @@ int hv_synic_cleanup(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
 	bool channel_found = false;
-	unsigned long flags;
 
 	/*
 	 * Hyper-V does not provide a way to change the connect CPU once
@@ -267,14 +266,12 @@ int hv_synic_cleanup(unsigned int cpu)
 			channel_found = true;
 			break;
 		}
-		spin_lock_irqsave(&channel->lock, flags);
 		list_for_each_entry(sc, &channel->sc_list, sc_list) {
 			if (sc->target_cpu == cpu) {
 				channel_found = true;
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&channel->lock, flags);
 		if (channel_found)
 			break;
 	}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 452c14c656e2a..b5ae45eb8aef7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2330,7 +2330,6 @@ static int vmbus_acpi_add(struct acpi_device *device)
 static int vmbus_bus_suspend(struct device *dev)
 {
 	struct vmbus_channel *channel, *sc;
-	unsigned long flags;
 
 	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
 		/*
@@ -2388,12 +2387,10 @@ static int vmbus_bus_suspend(struct device *dev)
 			continue;
 		}
 
-		spin_lock_irqsave(&channel->lock, flags);
 		list_for_each_entry(sc, &channel->sc_list, sc_list) {
 			pr_err("Sub-channel not deleted!\n");
 			WARN_ON_ONCE(1);
 		}
-		spin_unlock_irqrestore(&channel->lock, flags);
 
 		atomic_inc(&vmbus_connection.nr_chan_fixup_on_resume);
 	}
-- 
2.25.1

