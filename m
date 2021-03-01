Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508D9328DC5
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 20:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbhCATRA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbhCATOz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 14:14:55 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABFC061756;
        Mon,  1 Mar 2021 11:14:11 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p8so3976588ejb.10;
        Mon, 01 Mar 2021 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGzwacio6TQrd2no8NECottCDjSUp0tClCQWQdwKG74=;
        b=ULEV4U7dUr9cMk3ljViSiN0B+MScMY+lpVKpNDWFFwdWPT7rROgmvh9uILKxpTTfOf
         T64tiIeh0ggqw4wlaBppjluM74PGVj+VsMInWA3lc7ifB/tYk8Zp3K7wIgfmj5cH0dsM
         DtJ5hw7gEvqFCDqd7vJT1ICRFpkDZRUllN3D2ZA/sqlKu9rQp1QjJUQ0DOH+zCn4mP6A
         vUWLoNUKaWYwDTBgXTOI7GZCOascIPRvKazNrZ+lxdCiCDpFhop5HnBzvzUd0u8+mzmt
         +LqyizrthJjicesEsgfMcMF0n9MGKH3Hy/EN33ZH29KsEZDmD6SGa7/7YsPk8psr5YlA
         AOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGzwacio6TQrd2no8NECottCDjSUp0tClCQWQdwKG74=;
        b=BrokVXQcoslghCOMd1yAUzk2ggnyHNIzRbyevASpcqZ8uRmEuI50RxXwqzjeEpMV/u
         svDbEsP9CFw4T3zmFC0dqWtCowFToQ6o3lrMsg33sTUm/4Sd9tKt+rZPIP2kPn1LxA0p
         c6Rsl01XpT8UZ9QmYov20ZsFXnVZ1RFLeSzdjJQCffjRFex0i0ehwElsnkkqXo4H7UFN
         yEzHpZdW/u6y016h/pKRLMJcZUb82142hyVho2X6v1UkAkS5Tcccc5gAIDdx4H6r4UCQ
         7AjQ6yGl8S1+c2B/LaTFjxpMfHiEOIzfxQWSD40sX0JaYtVzcukr2MPyIcbCuXjwGinU
         AtBQ==
X-Gm-Message-State: AOAM530u0C2XVF8PeTTrhvtfOlYbqIxHeDucMKyxqfvXCc5arEcBDR45
        f/qQpVEMSniMszhX4n5uqHWUskf20oZxKw==
X-Google-Smtp-Source: ABdhPJx2Pdbhkl0LZlGPDjYRE2NP858HrQEYx40BX8D/F80jlyyOVD8rYQCyShrnta9OU/M3CHYynQ==
X-Received: by 2002:a17:906:8a65:: with SMTP id hy5mr11547802ejc.250.1614626050198;
        Mon, 01 Mar 2021 11:14:10 -0800 (PST)
Received: from anparri.mshome.net (host-79-55-37-174.retail.telecomitalia.it. [79.55.37.174])
        by smtp.gmail.com with ESMTPSA id e18sm14549093eji.111.2021.03.01.11.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 11:14:09 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH] Drivers: hv: vmbus: Drop error message when 'No request id available'
Date:   Mon,  1 Mar 2021 20:13:48 +0100
Message-Id: <20210301191348.196485-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Running out of request IDs on a channel essentially produces the same
effect as running out of space in the ring buffer, in that -EAGAIN is
returned.  The error message in hv_ringbuffer_write() should either be
dropped (since we don't output a message when the ring buffer is full)
or be made conditional/debug-only.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Fixes: e8b7db38449ac ("Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening")
---
 drivers/hv/ring_buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 35833d4d1a1dc..ecd82ebfd5bc4 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -313,7 +313,6 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
 		if (rqst_id == VMBUS_RQST_ERROR) {
 			spin_unlock_irqrestore(&outring_info->ring_lock, flags);
-			pr_err("No request id available\n");
 			return -EAGAIN;
 		}
 	}
-- 
2.25.1

