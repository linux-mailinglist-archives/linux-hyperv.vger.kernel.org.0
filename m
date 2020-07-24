Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0B22CB52
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jul 2020 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGXQqP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Jul 2020 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXQqO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Jul 2020 12:46:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A9C0619D3;
        Fri, 24 Jul 2020 09:46:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n5so5550959pgf.7;
        Fri, 24 Jul 2020 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tx5YX2IOPcV4RJbsivodmqYOOqUKOFaQmDzrxOXFXCY=;
        b=EodzYYagBDt5iwRKdDssPxz/3J9e6QclydtGwFuZ1WCfyv+7cJifUgZetYyZ+K8YQP
         Q7M4Ka3evjRn+yTb3d562wChMBrQnLb/RQG7KVWDWx0L8JcJdwTCmXTBQf+KS5xFAl14
         5ES60RkY8tdjBRMIX2jhenXTXMalpUUgEKeBEj/6jKXsNk3Sa5OSlVcG2SGivZWr4smR
         ahoFB526nNw1XBGexjwdgvFOjCR8VIK8pclJm8MqwNiWq9JZm24/g+hLGYFQxr/aM37s
         cgbZQCRHoN0AjSbVqGaOB7Khvd0kGuDOQ03RQmOSnRDQ2Vr74auIdqqGcc2DApdJv07O
         ZvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tx5YX2IOPcV4RJbsivodmqYOOqUKOFaQmDzrxOXFXCY=;
        b=WbBfiry/CNfvuuFTHkYXnBAoMo1dMrhQtqFG4/hv2knAsknoeTAdE8CGqUeyvu+1fq
         T/DlksRBTzD0JiWz8rMHb/VIt46Jc+zss/ahbuLQlYFqrFF8/EHfcxeVTbErZ7lC/Nma
         IEW9poQJM0ro+CN2EUspLM9tm/4yLMGXxpqifvj1dgBQeTuoRX/Rit9lykZ4ZycyLM/Q
         KNCbZ7hLAdn2Wwg7MaUB5L5m9S6P8agqX/txuxAdsrSc8dnGGd067OlhpbJa0WmWyjz8
         j3bv3FmfFKlYN4NA97SrFuNgRgNH7WPvgne002c7c1YXLS33oMYckhBwJMdpOeBWshC+
         rqSg==
X-Gm-Message-State: AOAM530v7MBQJnE6ZeEImQv8PICw2uCWnt1lVqMA9tEy4FYDh/4IoESE
        SYOFDfV8olD40PrudPuWR64=
X-Google-Smtp-Source: ABdhPJzSkzdvzW43LGvtO5zkWGvKc86Thv3nh35W1vcfnETJG+JZz/6QXcDWyJnsJ/5/27wrIo0Evw==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr9169217pga.24.1595609173638;
        Fri, 24 Jul 2020 09:46:13 -0700 (PDT)
Received: from localhost.localdomain ([131.107.159.194])
        by smtp.gmail.com with ESMTPSA id y27sm7161734pgc.56.2020.07.24.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:46:13 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        skarade@microsoft.com, Andres Beltran <lkmlabelt@gmail.com>
Subject: [PATCH] Drivers: hv: vmbus: Fix variable assignments in hv_ringbuffer_read()
Date:   Fri, 24 Jul 2020 12:46:06 -0400
Message-Id: <20200724164606.43699-1-lkmlabelt@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Assignments to buffer_actual_len and requestid happen before packetlen
is checked to be within buflen. If this condition is true,
hv_ringbuffer_read() returns with these variables already set to some
value even though no data is actually read. This might create
inconsistencies in any routine calling hv_ringbuffer_read(). Assign values
to such pointers after the packetlen check.

Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
---
 drivers/hv/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 356e22159e83..e277ce7372a4 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -350,12 +350,13 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 
 	offset = raw ? 0 : (desc->offset8 << 3);
 	packetlen = (desc->len8 << 3) - offset;
-	*buffer_actual_len = packetlen;
-	*requestid = desc->trans_id;
 
 	if (unlikely(packetlen > buflen))
 		return -ENOBUFS;
 
+	*buffer_actual_len = packetlen;
+	*requestid = desc->trans_id;
+
 	/* since ring is double mapped, only one copy is necessary */
 	memcpy(buffer, (const char *)desc + offset, packetlen);
 
-- 
2.25.1

