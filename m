Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8851D1FD296
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFQQr5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgFQQr4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:47:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC50C06174E;
        Wed, 17 Jun 2020 09:47:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so2762500wmc.1;
        Wed, 17 Jun 2020 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVhmxQFIFClqMGdzVtOb6Jbh/xq4f9D9vI2PHG/g/+c=;
        b=jyieeRfQpE8EHRM/R2i+3nUJ4FYKCu5/yHXrTi79yTAA51GM2AH0HoA5GipmmOXQE6
         sLSqJn+jP7chgvl93Bklkai4T3d7pI1/ziRIdXYT7kzVPp6+xPXzivbxL2MBWyClPCsX
         0i+ySWpKwZvF599veqjre9Y1opQ8W6/zD7TEKMT4o8WIwWwYN889czHXCyCWKGJDA2oV
         hf0YfZCk36zK5C0dvqqC7CpJcGkywSSDxHDeM5g9nyFqNH/D9NdrNWoNGbuVYGeNevE2
         HxOEGpW4TSXuHV5WsTqI9sOnKRnk1KjDZU55yzvb17hYaVvdubOptIvLqQMEA5sYAf5K
         PccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVhmxQFIFClqMGdzVtOb6Jbh/xq4f9D9vI2PHG/g/+c=;
        b=l5jBhoM1M6ipdi0aFq0kV8BiDtYDBT+IdT/liseqyzMAFGuWP3NLf9E+zVlDhzpbMG
         JtnyENbz2Y9BeZcWWCnP6DErK0C8FYUvS0t91Q2azCBGR39rBbo14XlkRgO/SDE6zqgC
         rT06Ta7gYaLkJ9jkVzIlsLpK+ADtjd/B6ARnQ5Hh+PyezXMaSGiNtGLdRAW1wpqQ4Za9
         48uiPZrV8ABvEejIps/iJjTfhxLNCOT1keorhXUksZwAOpt5vrz1xZl4cBH1W/azeFsm
         +bOKPZfnpgDZyvHh6FqyPT5Y/+13aV9fQBW10kdFoZdKraW1WJKL9hSE0asdqO7Yt0HO
         L6PQ==
X-Gm-Message-State: AOAM532lsfL8Ei9APqBpnryRPs3GGKXgl6OXlj/9WqzHXEmlV0Ms62wY
        EVYZDR9I/jKWM93TEJC2M0g=
X-Google-Smtp-Source: ABdhPJwpFr1lV1s6gM0gvMq5aYT6qZyCrxbVg5gighFnKTD/gPodBaHaYk+qI6UdRQzbAPwe2si88w==
X-Received: by 2002:a1c:b654:: with SMTP id g81mr9321392wmf.128.1592412474438;
        Wed, 17 Jun 2020 09:47:54 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:47:53 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 3/8] Drivers: hv: vmbus: Replace cpumask_test_cpu(, cpu_online_mask) with cpu_online()
Date:   Wed, 17 Jun 2020 18:46:37 +0200
Message-Id: <20200617164642.37393-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A slight improvement in readability, and this does also remove one
memory access when NR_CPUS == 1!  ;-)

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c3205f40d1415..452c14c656e2a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1702,7 +1702,7 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	/* No CPUs should come up or down during this. */
 	cpus_read_lock();
 
-	if (!cpumask_test_cpu(target_cpu, cpu_online_mask)) {
+	if (!cpu_online(target_cpu)) {
 		cpus_read_unlock();
 		return -EINVAL;
 	}
-- 
2.25.1

