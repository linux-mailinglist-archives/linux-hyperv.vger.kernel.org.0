Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3604A35E2AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbhDMPXD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346622AbhDMPXB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 11:23:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD44C06175F;
        Tue, 13 Apr 2021 08:22:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m18so6192333plc.13;
        Tue, 13 Apr 2021 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVkRTqUPBzQHoWP1iz19JnEvLpWiwpbLKKeUDMKlliw=;
        b=BxTMUp2Tm3RQTq4YSIMuJR/D6780D5gZyzHemutlmtyueknTeg1We2imlEqzQX+FnK
         01feR2OKBOA6cd9A6CKKn72znoP4HtNQnBzNlu3efI7Pis0eEEVHaZ8LMotJiK/1WHjb
         d6IoPQGblP1eQwP5+Rdfmu5/MapIl6Q0uv88et+TE1RdYahpCBTvfUlT+J1fHsZFXKEo
         Zc64Y2lqsNqdOlqFP+FomzSli7veeMR7LAklgVpkSZNGdzXBKBHEilCwgTluQECPfFcX
         B/n5QpDbRgnpDEHUn6toU+5VOMRKE9rh0uQgiF4Aaa77+2nxWav4DdYplVVlMgp9Qt8z
         inAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVkRTqUPBzQHoWP1iz19JnEvLpWiwpbLKKeUDMKlliw=;
        b=piNjAoIt4D6TMqDeUH+E5hPSMoI1Zya7wvfWFwyivZRyfTkrNGuXubtJ0zeOoqqaOJ
         cGSPiVq0ZlrqHhoJ3jFY+SYN+nnBHh5wQOMINoKbfaaiY+/5V6HO0eHxtIWH3D5NoLUH
         2V8CpkUiMYKsAig8Aa6lWnylvQHk7a0weDDMtuqZ34Roq6CUAfabgpY7xRo8uqn95w/B
         wUS6nXwPnd0L7uZeXsbUS4ozJt0A9LE7q86OYs6bcLPsyCyN2os2FQbbSeupye2X6XKH
         v32BvQhHA0VtMY1CBgz1fT6fFBdoXwWQKYFgi8g2LiFBpF89XAUUITMHZPpUYnmvVgMU
         sbIw==
X-Gm-Message-State: AOAM532TV2fynsySjeYhv0hC06qab39iK1vSF9w6T9CzbmlhDJHJHSdm
        w4tUKMQsW+MP4Iz6ioiFuIiD1/q1JIU7J3rq
X-Google-Smtp-Source: ABdhPJzpfpV7JLPNYjuLc6pXxs2sJiQ3wltDlDvLgyVk7Yfs2esa7665OnanlRLzGjue8Lbv00JqPQ==
X-Received: by 2002:a17:90a:7e03:: with SMTP id i3mr556228pjl.234.1618327360484;
        Tue, 13 Apr 2021 08:22:40 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:40 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC V2 PATCH 8/12] UIO/Hyper-V: Not load UIO HV driver in the isolation VM.
Date:   Tue, 13 Apr 2021 11:22:13 -0400
Message-Id: <20210413152217.3386288-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

UIO HV driver should not load in the isolation VM for security reason.
Return ENOTSUPP in the hv_uio_probe() in the isolation VM.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 0330ba99730e..678b021d66f8 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -29,6 +29,7 @@
 #include <linux/hyperv.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <asm/mshyperv.h>
 
 #include "../hv/hyperv_vmbus.h"
 
@@ -241,6 +242,10 @@ hv_uio_probe(struct hv_device *dev,
 	void *ring_buffer;
 	int ret;
 
+	/* UIO driver should not be loaded in the isolation VM.*/
+	if (hv_is_isolation_supported())
+		return -ENOTSUPP;
+		
 	/* Communicating with host has to be via shared memory not hypercall */
 	if (!channel->offermsg.monitor_allocated) {
 		dev_err(&dev->device, "vmbus channel requires hypercall\n");
-- 
2.25.1

