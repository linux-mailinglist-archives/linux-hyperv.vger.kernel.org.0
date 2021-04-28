Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700CE36D4DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Apr 2021 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhD1JgS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Apr 2021 05:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhD1JgR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Apr 2021 05:36:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7509C061574;
        Wed, 28 Apr 2021 02:35:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q2so11390956pfk.9;
        Wed, 28 Apr 2021 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=b/2x7D1/Ub2HBQrxQiDyoGrWCjSGVAtAx2/pdoUp6P8=;
        b=mXnjX8/gBTxl5HIKUkdwzbvFXvr2zfKCeu4Q4EvN74VXceRhptAu7MxkRDLb0wONKl
         d7Rp7mGgBx6OARS9daCZVtmN6H67taZfKlZSSv/YqXpyVto+KyqTejVB526zKecSvfga
         LDxGCGc+wQZGgqxvth8yKslMx4vezUmvZ98mJhPv6EtRvfbgPgGPypvDxNiClocPTal3
         gJEB2sORJ3909UqS+iK4HX8gzjj4+JZsMCi5n0V5daOkOp7XRU2SlbcEn97bE8gWM2Vd
         bP0c7r6Gbbv0ZuwLD+Pr7YJkwXdZbpw9fbnp+yavkwps+l1cX9ibzb8ODxBvpY/FtDta
         q5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=b/2x7D1/Ub2HBQrxQiDyoGrWCjSGVAtAx2/pdoUp6P8=;
        b=Ux+kBMd3Uu2+r4SCxpPkFeN8AKCZXUiVH/KleINvvKP4OQt4PQuiqaI1khoBdG7F76
         spA6Ha1heqayBRz0xHQOk8iB8WoAo0WxMsz9gEdzWDCfNsbzwM+zlDyWjKDB9dUidLD6
         0nRAyiKm8EjhOyOm0OMLPRoMbhQG4XMtEVHR2l0AICV+s7DPMS03hxZP5pYC6O/YDgAb
         ILrYmitIKt8QVur2SAeHDubjA/EZuYvRE1U3BGguOIIQCPOprM8IcAIOI5u8NHpJsutm
         R8aKihccknfpicFOi7gNVmiG/IH1teSKoOD9WB5e6zBRFJTODJC1Z+de7sGL4mTF+2NN
         jMcw==
X-Gm-Message-State: AOAM533ci8VwQsqi7vklYc6yT29a7jMdcwV6zJ/qECusxF+GmOojiMhn
        nxVvPMSfGZQrNoG9vwEFwBw=
X-Google-Smtp-Source: ABdhPJyb35Bba8lxBxGh6yYULWql+QOfgmw1NT1OkG3645iU5WMpK7+Laoq99znKLtA0QWw/SIVQvQ==
X-Received: by 2002:aa7:948b:0:b029:25c:f974:e0b4 with SMTP id z11-20020aa7948b0000b029025cf974e0b4mr27229413pfk.81.1619602531242;
        Wed, 28 Apr 2021 02:35:31 -0700 (PDT)
Received: from localhost ([115.99.221.24])
        by smtp.gmail.com with ESMTPSA id x9sm4116749pfd.66.2021.04.28.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 02:35:30 -0700 (PDT)
Date:   Wed, 28 Apr 2021 15:05:28 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove space before tabs
Message-ID: <20210428093528.cxbaukdjhvhh6lmc@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Space before tabs is removed to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 10dce9f91216..f01db0837f75 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1782,7 +1782,7 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 * UNLOCK channel_mutex		UNLOCK channel_mutex
 	 *
 	 * Forbids: r1 == r2 == CHANNEL_OPENED (i.e., CPU1's LOCK precedes
-	 * 		CPU2's LOCK) && CPU2's SEND precedes CPU1's SEND
+	 *		CPU2's LOCK) && CPU2's SEND precedes CPU1's SEND
 	 *
 	 * Note.  The host processes the channel messages "sequentially", in
 	 * the order in which they are received on a per-partition basis.
-- 
2.25.1

