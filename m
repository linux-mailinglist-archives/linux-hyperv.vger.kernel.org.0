Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839E12CB8AA
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgLBJXU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgLBJXT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:19 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8BC0613D6;
        Wed,  2 Dec 2020 01:22:39 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so2713167wrs.4;
        Wed, 02 Dec 2020 01:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmfIqVNpO1qdYqld/se9wMpL7fXGnp4cSTMlbr3vWAM=;
        b=fTdyRr4TIdSKFljC0Gr4ZoDtqjbX+Dz+iJz+nbvegG+ZiyCb06gD3fFJkaCI4MCHzg
         dTue2FxhpIJzfF8jTWb3U9c2pDrtcVPPJcvPUECAaPmIvUEogQeLdiqQ7wNwtWzMFoOr
         biir7zo2nbeLrg4cgfCQGjLCSo5QB+J8QDNWUn7RByXtPSwX2SBS75KTXDdsQoiAcw7V
         tNyR7UYfIDeCNLdqkvj9trk+6BrpG6U7QLtdVtKyZqlxrTcGURgnYcS1ueObiI+LUkOd
         eMCWxN3IEzgCSDjim6KGZXnyiU53AgcFTDtmtMlrGt/Qk/OVSbBM9WufMx0JnL8em68a
         FfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmfIqVNpO1qdYqld/se9wMpL7fXGnp4cSTMlbr3vWAM=;
        b=YFAG933tVNtpaw26Y32Jh+GNgZY33wn4eQwrFLsmWHks+yjPqOcOarHAl0PzlOUfWv
         N4utA5hWPTHm7CyvMKEUpQDuSFdVcu+GM2KDlpII5UQ2H94wCwRkTWnyMDM/9rhn/Qqs
         wyIaT+/E7IJhbhIQTBTRGPj7EikMs9hQngg+e4noBO04XD/uNOE6a500E1f+VyQ9i4kp
         pX5GMhu8pr20SrVxcLCoszVJcKlOZ8SkppFsk0qaTrXN31dwgJoDwTGh0no9p+17I26D
         XOOxrfbHABobONC8vTbLg+0o4tOGlrQbVU/1/L0d6W02njAPtMnEimAQysU64lqwMpHN
         B1Tg==
X-Gm-Message-State: AOAM533pyb5oBc5aORoNxjzCjeqXUf4XML+kDhkumvGiFhy1L2aa0ox9
        sb6rZCgzVuCkxvR0KBu4yTe36rPi4wlYng==
X-Google-Smtp-Source: ABdhPJxD5AePiLX6/+NPI2C3JspLJYDOGNEM0Uu0q+QjebT56zsg8ALkqD94j0w64SMbjhykvJSyFQ==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr2259415wrn.56.1606900957760;
        Wed, 02 Dec 2020 01:22:37 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:37 -0800 (PST)
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
Subject: [PATCH v2 1/7] Drivers: hv: vmbus: Initialize memory to be sent to the host
Date:   Wed,  2 Dec 2020 10:22:08 +0100
Message-Id: <20201202092214.13520-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202092214.13520-1-parri.andrea@gmail.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__vmbus_open() and vmbus_teardown_gpadl() do not inizialite the memory
for the vmbus_channel_open_channel and the vmbus_channel_gpadl_teardown
objects they allocate respectively.  These objects contain padding bytes
and fields that are left uninitialized and that are later sent to the
host, potentially leaking guest data.  Zero initialize such fields to
avoid leaking sensitive information to the host.

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 0d63862d65518..9aa789e5f22bb 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -621,7 +621,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 		goto error_clean_ring;
 
 	/* Create and init the channel open message */
-	open_info = kmalloc(sizeof(*open_info) +
+	open_info = kzalloc(sizeof(*open_info) +
 			   sizeof(struct vmbus_channel_open_channel),
 			   GFP_KERNEL);
 	if (!open_info) {
@@ -748,7 +748,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	unsigned long flags;
 	int ret;
 
-	info = kmalloc(sizeof(*info) +
+	info = kzalloc(sizeof(*info) +
 		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.25.1

