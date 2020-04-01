Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8732F19A9AA
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2020 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgDAKgy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Apr 2020 06:36:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54198 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732175AbgDAKgs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTMAdqU+ugzMWvGlDNrRAiYz9yYUyPqvJDeNn6ohk+E=;
        b=DRJkwakrd+RROmASXKWjALseMUVDtO4lQ2YGSZoHJQB08yrNUKCg0lyCU/OnPYgPsKxl/l
        4AzahETWDjIkPGLcO7hVR5I7+MSOuou/v6LJSiUj7fLfncHRBOCISioRb8NYN1fHV0FwuG
        7usVX6DRoeuDgy1ib0guEOIjICr279o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-C1Nrr7oeO3S7WF-upeGb1Q-1; Wed, 01 Apr 2020 06:36:44 -0400
X-MC-Unique: C1Nrr7oeO3S7WF-upeGb1Q-1
Received: by mail-wm1-f69.google.com with SMTP id f8so2281572wmh.4
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Apr 2020 03:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTMAdqU+ugzMWvGlDNrRAiYz9yYUyPqvJDeNn6ohk+E=;
        b=tmcdAVk38AllZAqY1CG3C55w5aHTrpWDUNR3EM1L5sL7MxFpBxeWjVa/q0BS7Ljv3s
         z3cOwsLLg0kVqJJAaD8Nz9DvL7QcZsldVTvbHkmGmJ0qpwqhHKb7HaIX9Vh44jQUqdR1
         dHu1AHRSYJQjFM7tTUAIVg7qQVqYtr9+swckPiLMoCwV0CWdsGSv7KmUYOjk/7fPkpUs
         jQ9bJbkiLjrSejLKzlr4l0wHVPAVetal8b1VcjJ/Obb92eogiY3ITslEbdiBNaBMe3CB
         LRROgAUgWC1zWQ5c6BHOfDwUUj+c4JbFDQGRkXzUdRWYkCZ0mCmdJpwPzz8JsKbZC5n5
         DAdQ==
X-Gm-Message-State: ANhLgQ22WT6YJbE6FMgMGS/9TATz8tMmPSAdvk86GYLTkRZeRVqgjgVn
        kSLhLmiHxqN8OmBw8e0+f5uGhY0VxlbWuHJeNkPKJ2TG1W76igOdf8Rz9CwEcYvcLgV08OmSD8b
        y30zy1gucDF8YHsZbML3EuL1N
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr25360961wrx.228.1585737403126;
        Wed, 01 Apr 2020 03:36:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvAMOV86AAHVFcAO0uJb1VAvbbzxIEVyPp1fjfHoIulN0RBiry0OhOybZEb+BNwNyvFyAm+9w==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr25360940wrx.228.1585737402886;
        Wed, 01 Apr 2020 03:36:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 1/5] Drivers: hv: copy from message page only what's needed
Date:   Wed,  1 Apr 2020 12:36:34 +0200
Message-Id: <20200401103638.1406431-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
messages. Each message comes with a header (16 bytes) which specifies the
payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
look at the real message length and copies the whole slot to a temporary
buffer before passing it to message handlers. This is potentially dangerous
as hypervisor doesn't have to clean the whole slot when putting a new
message there and a message handler can get access to some data which
belongs to a previous message.

Note, this is not currently a problem because all message handlers are
in-kernel but eventually we may e.g. get this exported to userspace.

Note also, that this is not a performance critical path: messages (unlike
events) represent rare events so it doesn't really matter (from performance
point of view) if we copy too much.

Fix the issue by taking into account the real message length. The temporary
buffer allocated by vmbus_on_msg_dpc() remains fixed size for now.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/vmbus_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c27421..2b5572146358 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1043,7 +1043,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(*msg));
+		memcpy(&ctx->msg, msg, sizeof(msg->header) +
+		       msg->header.payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.25.1

