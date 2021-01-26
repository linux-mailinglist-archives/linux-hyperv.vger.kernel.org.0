Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2E303C40
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 12:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405067AbhAZL6F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 06:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405277AbhAZL6B (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 06:58:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BDDC0613ED;
        Tue, 26 Jan 2021 03:57:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j18so2204399wmi.3;
        Tue, 26 Jan 2021 03:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKyiOVu1lUGnIzkFzoezEMEbPX1Dmz80P0s5OoHICRo=;
        b=IS51B1iStUqjMVlEAhK+AL8KTJCU7Jv8XISHLzsUtIJvGWv5ZUn0yRb/AMeIlwaeAl
         nTRgEuGEjHk3Vnkl02ierXW9dbfsK+6by8eqG0FQ6e4Z7y5V+aIZQdLs5TTo2yI99i91
         toFto8g9kMahc2Jq5D3DpQfSpLLWkEYAQIcRaVVaubFcqy3MpL68d96AkFs2CR/NhCuf
         itPLrYNQWieZ1epuUqUrQoAfsg9IE8FgZKchnVicEHW7fAE7QXIVOQXL1cLMHdn6sYNo
         XAUKX74EYX3nChWvYcLtNe9v30/9BYa3zqwEO4Ss8FdtjDBmorpRPvS68VCAf1f+/1IW
         xj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKyiOVu1lUGnIzkFzoezEMEbPX1Dmz80P0s5OoHICRo=;
        b=D98a2rVv2H+SHbq5qVHIoL7OVNZk0tyf6jFDC99/Z2Zh9rG/esuCt77JejCwcjf0aA
         dh8E8grQ+DfVbEqXr8QI8YpEu6hoeKhkIZmFygFQIPGwfk4dCGOkkh/eHPk7iSDXkOFX
         cdKKw4Mtvj0CLd6tEsmKXY9K8AzExXksMuGqNA9LtLFIiy85n3ft/YQlnOjQ8wsr2c4O
         8X0XmYvmzqRDF1w9ZGGQEWmpRZQlNMOI/rl7bXlimnLSDV/LR8kHibuphLj27jublByI
         kWbu8WF+ZnYh9vXmKv70hAik2Pr5cq3+q62D3gu3sRXNJ1NmYi7SOEvsCBThj1mAGuj7
         6oKA==
X-Gm-Message-State: AOAM530pQGQs4aqNSb0AdWi3D5ax6y8OgnhGhS85cK+xPzeflPX7pxrL
        6kMkTCoklJeERJPyhrWhYigN9+tm8Y+AG+Ak
X-Google-Smtp-Source: ABdhPJxfiYLldmWLmNrDlfFsyMDOedn3+CHW47+ikxrLFKTI/OslA+Fy4RmxZTWH/0CZ7NMkZB+iWA==
X-Received: by 2002:a1c:4057:: with SMTP id n84mr4288500wma.141.1611662237906;
        Tue, 26 Jan 2021 03:57:17 -0800 (PST)
Received: from anparri.mshome.net (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id z185sm3330283wmb.0.2021.01.26.03.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 03:57:17 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 3/4] Drivers: hv: vmbus: Enforce 'VMBus version >= 5.2' on isolated guests
Date:   Tue, 26 Jan 2021 12:56:40 +0100
Message-Id: <20210126115641.2527-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126115641.2527-1-parri.andrea@gmail.com>
References: <20210126115641.2527-1-parri.andrea@gmail.com>
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

