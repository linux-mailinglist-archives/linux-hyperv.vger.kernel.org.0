Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6182D3C01
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 08:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgLIHKU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 02:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgLIHKJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 02:10:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09975C06179C;
        Tue,  8 Dec 2020 23:09:26 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d3so471066wmb.4;
        Tue, 08 Dec 2020 23:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S63yyXOD6nq1Gp0gaAuK/Pgn7DIW2g5OZRiGxhw6wMA=;
        b=dU4b2NdKbI3u7GBO79dTKSP97MTta991wMmGSrUWbAW412dtY1CO94zD0UHDUPLzfy
         VQTV0usdwnJTLST0Hn0OHVzpO4m8JCqr/Flrqos525AYLqUIUv6tmepZFaBcF4ff1KtP
         aIWQL8wDdOwQGTGQmeqZNeCx8fatI62ZV4QDpjYsNR4J/QeUQm0topF8w2UnjSA5tt3R
         3JuMz1qO+7fnwzRVOUiNc3fAJUo0wacYaCeagX2WqLWmW5/I9ol1Ir+18+3Qc2w+C250
         y6gnfQBD3n8rtRSoPaBueNg4ICjCPTgkaHMOVMq1hRkErV+6gDUT8KHTtT5fQGJb0yvs
         Yn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S63yyXOD6nq1Gp0gaAuK/Pgn7DIW2g5OZRiGxhw6wMA=;
        b=UrMr4ScILXDlceAEXeHyCWwJn4iodKQHj91u141avTZ8JAQPmL30DdYV1ks4m7lQqd
         W4wt3jCYn9FSyHlfhqWU7ptZqo8niEBooQ/Tu/t10DMd6QoUoWjXaXJJuAXBAvljG530
         9oymgx/Fz7ld9wqqVg+ncn7DkTv+ZWdRhTdbpAUKpUkn+aJJMygVY1Srtc21u9ES0ezB
         SXzItZrUBlSmTGgPfJl4jlkZF5XFa9D55aMiT41PsYKywIzxXxTIm3y23ZEe/qvDwwYu
         Z2lz3+LyunqFlhKQeA6AAjqoLSSdA1iNIHGCy2IS7jGCdV0w87RE6NEVtKsy7FNg0tCq
         x6iQ==
X-Gm-Message-State: AOAM532o5wphy393pVK5R26dey/srFcCBb1qZGxLnEkX5tD1TFW37ox1
        NCbNJEWKek/lKAtRPDkuEvZ+0o/MkENMJA==
X-Google-Smtp-Source: ABdhPJwWZNWY/vuKc6LROxPZGf3gaqGrER2Llmg0nivDRDlW+SdAKR3WBFrGNwKk2w8f4hdQaIkfCA==
X-Received: by 2002:a1c:bdc1:: with SMTP id n184mr1136031wmf.125.1607497764482;
        Tue, 08 Dec 2020 23:09:24 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id p3sm1449122wrs.50.2020.12.08.23.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:09:24 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 4/6] Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
Date:   Wed,  9 Dec 2020 08:08:25 +0100
Message-Id: <20201209070827.29335-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209070827.29335-1-parri.andrea@gmail.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When channel->device_obj is non-NULL, vmbus_onoffer_rescind() could
invoke put_device(), that will eventually release the device and free
the channel object (cf. vmbus_device_release()).  However, a pointer
to the object is dereferenced again later to load the primary_channel.
The use-after-free can be avoided by noticing that this load/check is
redundant if device_obj is non-NULL: primary_channel must be NULL if
device_obj is non-NULL, cf. vmbus_add_channel_work().

Fixes: 54a66265d6754b ("Drivers: hv: vmbus: Fix rescind handling")
Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
Changes since v2:
  - Add Reviewed-by: tag

 drivers/hv/channel_mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 5bc5eef5da159..4072fd1f22146 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1116,8 +1116,7 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 			vmbus_device_unregister(channel->device_obj);
 			put_device(dev);
 		}
-	}
-	if (channel->primary_channel != NULL) {
+	} else if (channel->primary_channel != NULL) {
 		/*
 		 * Sub-channel is being rescinded. Following is the channel
 		 * close sequence when initiated from the driveri (refer to
-- 
2.25.1

