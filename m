Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702284941A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 21:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357259AbiASUVV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jan 2022 15:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiASUVU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jan 2022 15:21:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F11C061574;
        Wed, 19 Jan 2022 12:21:20 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w204so3309433pfc.7;
        Wed, 19 Jan 2022 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0IAhlKzMhVDSvOyrE7WOScz7H0kZ7M7h7y/9jjJAyo=;
        b=B8z1c8TbozA4PbYfP8freTXuYQq4JYYeVme3C4wbQqfi3tgQGH4YBUg0HdBcmKhp7o
         ofAu0L0YRVAqCRBecsdSlMI6v8ikYEelTdACKprfxmIF22aegr+b/r5RqIm79md/BrN9
         hgMDa8wMovhEKiKfAi60H1SorCA3cErxVhFtUshtKQXlrcacGz+rn3KIqoEmIgGnsTrL
         jR0ZzNyck+437UUSzTZCwxO2QRL8XSewL2UUkeOyR7BumpW4KGeibdko/uOisFMYwRtk
         YEAZ+hf1f480kpSVPK2fb52fC3h2Ny/kIPQAA6sa4izf2rnvyzVPi1LgHDu1V+4g/RL0
         8bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0IAhlKzMhVDSvOyrE7WOScz7H0kZ7M7h7y/9jjJAyo=;
        b=BbBOCVNclF6Ti9dl9ZcM9VOjGR5IyoTF1p+e0yywBz2T0Y6wE9E2DgrqrV9ZL4wi0I
         5U+u5i0uRL6bKnUrmWkOUAc4LBcSSt8QfOt90WhkYrjiXCBdaafkUV46Frb9kT8MVJs5
         Ya1H+1aKHs4w0taxbmjjSa4uNTgTRzUXjgsYBJ/i8BBY1r1bKHSJ+l20pA4HtvuFZQrq
         OB3yYUFEPt0RYCWASjS/F1vZDyo4T3eabW2plqiQraSAkRwt+U5IOOdYUxYO4Y3RUhe/
         vLQWi1Q2ylyLhq+1Wnb/hi8XXxxglGHsHcqOsockh6QO7oplmgydbeHoKcTtRY61AtBC
         M+uw==
X-Gm-Message-State: AOAM533NuX2xNZrB4Edey8y7IHxw57F4orBqY/y8XATqwjhW26I0mx5Z
        AxicK3oaaW6lx/ItV1jaRKA6xrkYd8GsYQ==
X-Google-Smtp-Source: ABdhPJwb7K3ljzxYYG9xuDS6ic4TifxN04U+qgTiqu00O06zo+J+LuOFgAPmjp3nU89lxIgf9IEuJg==
X-Received: by 2002:a63:b24e:: with SMTP id t14mr28937903pgo.381.1642623680041;
        Wed, 19 Jan 2022 12:21:20 -0800 (PST)
Received: from megumi-s.h.riat.re ([103.72.4.142])
        by smtp.gmail.com with ESMTPSA id b4sm474346pfl.106.2022.01.19.12.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:21:19 -0800 (PST)
From:   Yanming Liu <yanminglr@gmail.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Yanming Liu <yanminglr@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] Drivers: hv: balloon: account for vmbus packet header in max_pkt_size
Date:   Thu, 20 Jan 2022 04:20:52 +0800
Message-Id: <20220119202052.3006981-1-yanminglr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V
out of the ring buffer") introduced a notion of maximum packet size in
vmbus channel and used that size to initialize a buffer holding all
incoming packet along with their vmbus packet header. hv_balloon uses
the default maximum packet size VMBUS_DEFAULT_MAX_PKT_SIZE which matches
its maximum message size, however vmbus_open expects this size to also
include vmbus packet header. This leads to 4096 bytes
dm_unballoon_request messages being truncated to 4080 bytes. When the
driver tries to read next packet it starts from a wrong read_index,
receives garbage and prints a lot of "Unhandled message: type:
<garbage>" in dmesg.

Allocate the buffer with HV_HYP_PAGE_SIZE more bytes to make room for
the header.

Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Suggested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Signed-off-by: Yanming Liu <yanminglr@gmail.com>
---
The patch was "[PATCH v2] hv: account for packet descriptor in maximum
packet size". As pointed out by Michael Kelley [1], other hv drivers
already overallocate a lot, and hv_balloon is hopefully the only
remaining affected driver. It's better to just fix hv_balloon. Patch
summary is changed to reflect this new (much smaller) scope.

[1] https://lore.kernel.org/linux-hyperv/CY4PR21MB1586D30C6CEC81EFC37A9848D7599@CY4PR21MB1586.namprd21.prod.outlook.com/

 drivers/hv/hv_balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index ca873a3b98db..f2d05bff4245 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1660,6 +1660,13 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	unsigned long t;
 	int ret;
 
+	/*
+	 * max_pkt_size should be large enough for one vmbus packet header plus
+	 * our receive buffer size. Hyper-V sends messages up to
+	 * HV_HYP_PAGE_SIZE bytes long on balloon channel.
+	 */
+	dev->channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+
 	ret = vmbus_open(dev->channel, dm_ring_size, dm_ring_size, NULL, 0,
 			 balloon_onchannelcallback, dev);
 	if (ret)
-- 
2.34.1

