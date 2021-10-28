Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2674C43DF1B
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Oct 2021 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1KoL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhJ1KoL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 06:44:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B175C061570;
        Thu, 28 Oct 2021 03:41:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id r5so4159124pls.1;
        Thu, 28 Oct 2021 03:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6k9H+1esaoJxBW+jGH+iFBTYa8xXJVNGvttUpb0vAA=;
        b=p/MMYZS0qb/MTwTrJCxDlKpcr0zH2nLUjiN9uBzJBhL528nG7w22f6msCb2cDXrhvZ
         8uLOy9KPfe+3a8Hc5FWanAaal+6QebSzmN9yw0T8GyswDtstcQVxdMfVRJOV/4B4dS8m
         JrGViro03YC7AbS3SwmMIQ7V+8iT/qd8tBe/JG2JgZu8OsekRpZMDzQm2a0hK7+jmDRN
         ozMNQFxez27lWKEkn3hwjX1C1dOb5AcEa2veunmuTx/yDx5ZyC59syKyJ0UXZC9YYWJY
         jFJ9HrWx9HTnrereqo6UzdUrh8XcNV+f0WplbdZtuO3zVKcbHUF/AUCvwl13k1Z4aPiy
         foKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6k9H+1esaoJxBW+jGH+iFBTYa8xXJVNGvttUpb0vAA=;
        b=myPVmdLvX841My1b4dzn8MXWs9e40L2nVnAlBioPmGXK/LVbM0GG6E2ZNw7t0NhZsT
         gMb37WHd46cirS3mz0+UAipKFQHbeNTOMxrWN3y6k/y+imJJwbZFOmS/lBBhkhpw6pHB
         wwOvhCwtMCSA3+LDcJuVUeBZj6Rm1QQrcm1bbomh8w3o5kKezjp3GG+7yRx10u5Di/Nj
         07XFDtFHX26LUbkxbUO6JRXM7KWKdqHk0S5dWi0fP6N0SN4bGkmBZ7iqk//O8RaByahr
         DYtNVBhRN40lyfR1kfNNPH7uR/TuZ7pscuaKUqk94V5YKAj1Unsmwz51+aoj8r68paLt
         CnTA==
X-Gm-Message-State: AOAM5315kDooLcCk8h0hfE/672tYgOTwoqRnecdzGvJT9K+WiTgu8D4h
        GYOjTalsplP7uTg9x7NqEHM=
X-Google-Smtp-Source: ABdhPJxsMdagnYkbRdTL2wc2y+3Wv16EBbaG5YyXFaVi+jC7TREqmiezh1mOd4j44a918ipYRJc7Ug==
X-Received: by 2002:a17:90a:4d44:: with SMTP id l4mr3665230pjh.58.1635417703907;
        Thu, 28 Oct 2021 03:41:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h2sm2519462pjk.44.2021.10.28.03.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:41:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Drivers: hv : vmbus: Adding NULL pointer check
Date:   Thu, 28 Oct 2021 10:41:38 +0000
Message-Id: <20211028104138.14576-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

This patch fixes the following Coccinelle warning:
drivers/hv/ring_buffer.c:223: alloc with no test

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/hv/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 931802ae985c..4ef5c3771079 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -223,6 +223,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		pages_wraparound = kcalloc(page_cnt * 2 - 1,
 					   sizeof(struct page *),
 					   GFP_KERNEL);
+		if (!pages_wraparound)
+			return -ENOMEM;
 
 		pages_wraparound[0] = pages;
 		for (i = 0; i < 2 * (page_cnt - 1); i++)
-- 
2.25.1

