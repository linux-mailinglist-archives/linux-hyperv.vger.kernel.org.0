Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42331EA79
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Feb 2021 14:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhBRN3r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Feb 2021 08:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhBRLRU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Feb 2021 06:17:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD57C06178C;
        Thu, 18 Feb 2021 03:15:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d15so1076854plh.4;
        Thu, 18 Feb 2021 03:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zucq0iHfsDz/8P8FApo64pAJia/DuOTQ2Df8Tcdt9pU=;
        b=ddtmcv7wWeq1AEohMJ4T1iJmSBtnUrbid+phwaB3O0n0XUAeV+Kj0GlBAicx+i3mC5
         6hehrb2uGLn2oi1X3N8P1ozdv1LBzV82nV3puCmSmJANLgEXLX+RW+XWQoIYm/jiPuVY
         RRoouvjXM+5NgnEZdfcg8JojZ2+THhhFlr1o1MZ8QI61eKmYACLs2j9BSRHkOpzbK3c7
         jU6LyteeeTSgN0jgXKP3CldmjeZDq1CzOpFHG7FAeRVMAAnM55xx4s3+TkEDlE1s2cWI
         HLP306+vXMbELijIsufiXbG/l6Dh2flC9BKkTDw679iAOH2LvlWk+B/KvDPikgpUZ2Ny
         +clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zucq0iHfsDz/8P8FApo64pAJia/DuOTQ2Df8Tcdt9pU=;
        b=mDn2ZdfZ5BE1tUSBU6iqFliSnSrAkfms3giKt+rczqTZ/rtd0coKJ4947KN2bXdkt3
         WCZqCtvokq6GeFLUVYIdPpYXJJlmSlQluR5Cv/FQEQblaOI/TISoPAfANhf7d83XjJEl
         QKxjQgG0+EQt88Eoe+PdB9ekXAWZfZrQK4NJdi69IVR5mgXK4VSYV8Xi+WJQbYA398BQ
         J5iGRYAMJ9wYI9BeEWdMxQNsRJHU/002A3dGJuzKfoL/sHvlnDFZmRTvGenZYeJyr2pw
         H9SFdbR5r9HRCZULEiu2WDZnkscPr3+V7c6RTpfLq+oWgJwRH0l0JY62YmywMK2G5F4y
         VmHQ==
X-Gm-Message-State: AOAM531p3AI+YUmqX9fWGJBTx8TMEC2UQ7Lj+XKFUXa4eFyiTYAxPezU
        1kk+GkCYvs4KTsMW2hp7ro2M6/pAP0i+EBI8
X-Google-Smtp-Source: ABdhPJxyOmnXaFQznZL5h5uG88pRVLsVDLBNYB/kMeMZY3GMwS+00xDeQIwtLLFarxcnMEMfon8b6w==
X-Received: by 2002:a17:902:d901:b029:e3:8f73:e759 with SMTP id c1-20020a170902d901b02900e38f73e759mr3905750plz.63.1613646930773;
        Thu, 18 Feb 2021 03:15:30 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e01e:c062:6b53:27bb:36d5:ac1d])
        by smtp.gmail.com with ESMTPSA id x8sm5149429pjf.55.2021.02.18.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 03:15:30 -0800 (PST)
From:   Vasanth <vasanth3g@gmail.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasanth <vasanth3g@gmail.com>
Subject: [PATCH] drivers: hv: channel: fixed a tab having spaces before        hv: connection: fixed required space for "=" sign before.
Date:   Thu, 18 Feb 2021 16:45:22 +0530
Message-Id: <20210218111522.398170-1-vasanth3g@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixed checkpatch warning: Tab space before having normal space.

Fixed checkpatch error: Required space for "=" sign before.

Signed-off-by: Vasanth <vasanth3g@gmail.com>
---
 drivers/hv/channel.c    | 2 +-
 drivers/hv/connection.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 6fb0c76bfbf8..587234065e37 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -385,7 +385,7 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
  * @kbuffer: from kmalloc or vmalloc
  * @size: page-size multiple
  * @send_offset: the offset (in bytes) where the send ring buffer starts,
- * 		 should be 0 for BUFFER type gpadl
+ *              should be 0 for BUFFER type gpadl
  * @gpadl_handle: some funky thing
  */
 static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 11170d9a2e1a..3760cbb6ffaf 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -28,7 +28,7 @@ struct vmbus_connection vmbus_connection = {
 	.conn_state		= DISCONNECTED,
 	.next_gpadl_handle	= ATOMIC_INIT(0xE1E10),
 
-	.ready_for_suspend_event= COMPLETION_INITIALIZER(
+	.ready_for_suspend_event = COMPLETION_INITIALIZER(
 				  vmbus_connection.ready_for_suspend_event),
 	.ready_for_resume_event	= COMPLETION_INITIALIZER(
 				  vmbus_connection.ready_for_resume_event),
-- 
2.25.1

