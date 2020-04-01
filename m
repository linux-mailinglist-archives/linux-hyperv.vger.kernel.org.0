Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962EF19A9B1
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2020 12:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgDAKiW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Apr 2020 06:38:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgDAKiW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Apr 2020 06:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3l08e3NHHUaDqXrk79908dgZMwgH9sXBM13wiaRDo4=;
        b=BlD9w5V7d94xSoTkhMAzE8FRP3gqfR0Ab2DBVxWVGtAvLjPYVrnJ7DtFEmfvwVgkTCiWev
        1O20XXlRPElMEV70DaYCx2wA0KYPukeMpKtycpa1zZ/7YyzM8j2mQP1yHBKbW6qX5NXtHC
        GS2oQfG65l7Fqmh4zLm7fQDm8mjxCXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-_Ag8TIitPD2j7fTmLFj0JA-1; Wed, 01 Apr 2020 06:38:20 -0400
X-MC-Unique: _Ag8TIitPD2j7fTmLFj0JA-1
Received: by mail-wr1-f69.google.com with SMTP id b2so13898159wrq.8
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Apr 2020 03:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3l08e3NHHUaDqXrk79908dgZMwgH9sXBM13wiaRDo4=;
        b=DfXV8hT/2SOhfgCqqVxyLv/JYu2kww8Z4Oz9fFnqOFuDMN8v7nknj1FIpThVEDSFuW
         zuXv7rw3NuzkCzKcFbZVTO3TOZns89sNG9YYofiENGrk7/+suyVjTE1jKwcSbpKa6Fsz
         87JoAHeZ2V8JRxnmmSOf8yrHP39WG8uW4Nl/+CXUYbSP69xltyno4Lep5fHobXX93rPC
         FxnV4zXCeKfJoOm+ygNvLPRJ5TULL2ayco2f2MKwYCPeOqWIDqkOInRxzIHTT62qM4O7
         MLEdQDPc0paS83PqQ4P3w90/+0U8XxXIcxYhRXFKQQSjZ10V11B572wbdfcjfLMUzmqQ
         kiyA==
X-Gm-Message-State: AGi0PubDDOtPA70Xeaz6zovUYfhCK664B0muuGppX9By6mg7xN9cYW9G
        80EAXb+dqqFk4xN1Mh3nPb0/3mHGWtzEqs3AfaTKzJAJlU8+kzfHBt1c+OltmXgZH1NS8wEh3Lw
        hbPt0AlYNh4UyesTSxjVBb4Tg
X-Received: by 2002:a5d:544b:: with SMTP id w11mr3134803wrv.37.1585737498645;
        Wed, 01 Apr 2020 03:38:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLN7G4Aa0czWFigGqcuI9gJgdp31NcwN9McEtnJE8lGgECyLcFLZeBMfZYUSqBHvzZV6+uT1g==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr3134790wrv.37.1585737498476;
        Wed, 01 Apr 2020 03:38:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm2380098wrm.35.2020.04.01.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:38:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 4/5] Drivers: hv: make sure that 'struct vmbus_channel_message_header' compiles correctly
Date:   Wed,  1 Apr 2020 12:38:15 +0200
Message-Id: <20200401103816.1406642-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Strictly speaking, compiler is free to use something different from 'u32'
for 'enum vmbus_channel_message_type' (e.g. char) but it doesn't happen in
real life, just add a BUILD_BUG_ON() guardian.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/vmbus_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0f7bbf952d89..d684cbee7ae6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1023,6 +1023,13 @@ void vmbus_on_msg_dpc(unsigned long data)
 	struct onmessage_work_context *ctx;
 	u32 message_type = msg->header.message_type;
 
+	/*
+	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
+	 * it is being used in 'struct vmbus_channel_message_header' definition
+	 * which is supposed to match hypervisor ABI.
+	 */
+	BUILD_BUG_ON(sizeof(enum vmbus_channel_message_type) != sizeof(u32));
+
 	if (message_type == HVMSG_NONE)
 		/* no msg */
 		return;
-- 
2.25.1

