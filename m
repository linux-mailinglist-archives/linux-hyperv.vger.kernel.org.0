Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB72FBE75
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Jan 2021 19:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404381AbhASSBf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Jan 2021 13:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392203AbhASSBS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Jan 2021 13:01:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599DCC0613C1;
        Tue, 19 Jan 2021 09:59:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j18so602974wmi.3;
        Tue, 19 Jan 2021 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKyiOVu1lUGnIzkFzoezEMEbPX1Dmz80P0s5OoHICRo=;
        b=svE+XgcC9I1FWOwS+48oj5yMbH8l7YvxTqtS7LzgakFOjD1nQ+m8U+m2kL46gsxhC6
         t9JONxDOaCdaxapUk6VpAu/QB5nV0eghmGcjPeouJFqq6IMFCjA3yYzkLUhFwqOg45Dp
         V77yIlLlxoEAjC1xy0TMSRDCFhb8nAb9/r7LYx615NbVBn5USGRbXjluakBmicyrXBUl
         M/k87S2R4u8NmI2dIjswjLAEUWescpGZTEQyHJIeET/2S6u2ByI4jnhnFNrVGO+jk5DO
         nzqYvmbW89N65ig9FQSCmpE8RDZYB3sxTa+P9MbXWaSFUkMh6oZlO1l41JqY7KKUpsYt
         6EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKyiOVu1lUGnIzkFzoezEMEbPX1Dmz80P0s5OoHICRo=;
        b=nafx3tJZiUEyO/YScaq2yVXAP2Z03xWrO50gUFFSEd1TDZ6sMdwf6ZQmXl6wCdSw+O
         GB5tJx/8a+Fa7IaK2kqo76bIvA4zpwPT144ijwHObIyAZb/mqFOxJBmAkmMhwvEJrYvx
         V5TKOlQUnapFsFRt716ohOuZjAIVvY6mS/ixcbceDtPzMUqLdujzJHy57PUvQvGi+TGk
         yV/Q0AK1p9O6WqYOG/Us/L/d3Ciw8iS8kighsCEN/H0uhTBaAFpUV01gecpMAnUDYiZk
         68MwTlzqoP52Gqi30lKYXYqJ47YNkehqN/KymDIDVwGPbKrRdFqoXN5PODF7HqXzuEOu
         VK8A==
X-Gm-Message-State: AOAM530boB8fq3h7f4t1SDXTmY1zyquy+U0OX1vT1T36GE6X7+2EF9Rx
        bgx/LZl9D0tOfWlEFaxUATGDeGdCuxUma4LQ
X-Google-Smtp-Source: ABdhPJxWaMm5DCQ2+tvDCZB3utO9wQOiXzzJoNhHAQnOzn4yRCV1E+u1kvWqoKae8Ai6KiamQi+waQ==
X-Received: by 2002:a05:600c:3548:: with SMTP id i8mr748559wmq.104.1611079155636;
        Tue, 19 Jan 2021 09:59:15 -0800 (PST)
Received: from anparri.mshome.net (host-79-50-177-118.retail.telecomitalia.it. [79.50.177.118])
        by smtp.gmail.com with ESMTPSA id h125sm5899312wmh.16.2021.01.19.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 09:59:15 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 3/4] Drivers: hv: vmbus: Enforce 'VMBus version >= 5.2' on isolated guests
Date:   Tue, 19 Jan 2021 18:58:40 +0100
Message-Id: <20210119175841.22248-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119175841.22248-1-parri.andrea@gmail.com>
References: <20210119175841.22248-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Restrict the protocol version(s) that will be negotiated with the host
to be 5.2 or greater if the guest is running isolated.  This reduces the
footprint of the code that will be exercised by Confidential VMs and
hence the exposure to bugs and vulnerabilities.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/connection.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 11170d9a2e1a5..bcf4d7def6838 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -66,6 +66,13 @@ module_param(max_version, uint, S_IRUGO);
 MODULE_PARM_DESC(max_version,
 		 "Maximal VMBus protocol version which can be negotiated");
 
+static bool vmbus_is_valid_version(u32 version)
+{
+	if (hv_is_isolation_supported())
+		return version >= VERSION_WIN10_V5_2;
+	return true;
+}
+
 int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 {
 	int ret = 0;
@@ -233,6 +240,12 @@ int vmbus_connect(void)
 			goto cleanup;
 
 		version = vmbus_versions[i];
+
+		if (!vmbus_is_valid_version(version)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
 		if (version > max_version)
 			continue;
 
-- 
2.25.1

