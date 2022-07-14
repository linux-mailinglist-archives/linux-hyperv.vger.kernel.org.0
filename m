Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE993574A94
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Jul 2022 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiGNK0k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Jul 2022 06:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiGNK0i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Jul 2022 06:26:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC247B8A;
        Thu, 14 Jul 2022 03:26:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so1948622wrv.4;
        Thu, 14 Jul 2022 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFrMj3I9fEKLl5pZ59KkM7PDh3+un+j2V5sd8WHdwXA=;
        b=Cr7goEIzRVsjKcdhoo6Jhcyv8MieqHS3qgbivPcK2pdzkUesVqq29HIfjOz44xNVa7
         bU0Toe0+X6JLI8gAahikvmEK0C3D1lsj9h4MLBLE8/8SMEK0dX8SAKxN5MZ7nyTNJG51
         JMAbBqq21z7iyJVTH81gtPkTvymsFiZOIo4aD0KAwU9Ji0nrM4FI5yA/l/9opNiPUyUE
         iikQdJlUZL09//UQahetomPutOzgyR2zxHcU2lhYWNnkAiDEvJPo7Az2VATbakvFsz5k
         n7M53i/9YHkEFRyKz0Hao6EpsCerXiyfXZ4yA9wU4eY2y/RJzbbRdiOAMeSQ3xp/MXJc
         lQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFrMj3I9fEKLl5pZ59KkM7PDh3+un+j2V5sd8WHdwXA=;
        b=52UY8YPQIKVIOrNajrRSUwDBUO+Ud7GGHUs2DZ3D498lluoXRknyALW0h9vPsVxRBS
         lQPwXMQWSBlMHUkq89AA6/G86iqidcViS217siLeE6c4BeKDjs5x5BHRzISZNSicH6Qg
         3bf/Fl73ReWmlo+0QNF7o/Ohj1h+rZzwjtGZlVzby2s4EeFEYvIKM/qDfffO5pvRPLgD
         OUvczp/A2TI9ZLwa8Sod0B6AP/Bo+q8Fo7jlgPDHb4SjW021+TtiiO21RQ+oIWmRdDCR
         pNMQ0Np++YVoc2Ox8r/mjKP/ZkFxmBqJbg2sNs5JQTLfrDTPfgiUbGOJGECqhKf8OoPw
         ql2A==
X-Gm-Message-State: AJIora+ELV59WjY4hUq7J6WQDYtuHmAbD+9mFqV7hTCHeifjOLdd8Wqu
        mtykPauIO95zx33K+ifcS7g=
X-Google-Smtp-Source: AGRyM1t6IHbW5cOG4J3Y5OSrq8ocfoOIrKcBW9byPXKZ6lAdeOX4taN+i6aFg+nQcHbbF2VdfLeK8g==
X-Received: by 2002:a5d:6da4:0:b0:21d:7e96:c040 with SMTP id u4-20020a5d6da4000000b0021d7e96c040mr7670447wrs.417.1657794396367;
        Thu, 14 Jul 2022 03:26:36 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h26-20020a05600c2cba00b003a2e5f536b3sm5402213wmc.24.2022.07.14.03.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:26:35 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-hyperv@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] Drivers: hv: Fix spelling mistake "total_pages_commited" -> "total_pages_committed"
Date:   Thu, 14 Jul 2022 11:26:34 +0100
Message-Id: <20220714102634.22184-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a seq_printf message. Fix it.

Fixes: e237eed373cc ("Drivers: hv: Create debugfs file with hyper-v balloon usage information")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index ba52d3a3e3e3..fdf6decacf06 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1892,7 +1892,7 @@ static int hv_balloon_debug_show(struct seq_file *f, void *offset)
 	/* pages we have given back to host */
 	seq_printf(f, "%-22s: %u\n", "pages_ballooned", dm->num_pages_ballooned);
 
-	seq_printf(f, "%-22s: %lu\n", "total_pages_commited",
+	seq_printf(f, "%-22s: %lu\n", "total_pages_committed",
 				get_pages_committed(dm));
 
 	seq_printf(f, "%-22s: %llu\n", "max_dynamic_page_count",
-- 
2.35.3

