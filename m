Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D85174866
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Feb 2020 18:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgB2RaS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 29 Feb 2020 12:30:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33439 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgB2RaR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 29 Feb 2020 12:30:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so11746390wmc.0;
        Sat, 29 Feb 2020 09:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNbtVJWWXNdwkkBBX0mCHINmL6VsnHitEd+p/pofHl4=;
        b=m3YC1FWjWYIZ3+zU6OFoYSGPE+ZTuLM9Ih7K/beFmjDOFYVv68JMVIqXt+kQ3GDcWJ
         m898EfVwo1Vp3Qo4hkrNlgp+px+vDEBQugV5NkULRICoz+9uyEWnORNijnRdQm75p/3K
         SFukbPwz4G4GpulwnLNEsHctLec7wZ6rhaIaRMt+hlMuAr7LGcBGLb0Z32dO2eXMybek
         KzitZX3h5Mc6/qHQLCGW1+ALoP3UXsTFSmUnx8DJos4j3t8TOCtMPx/NWOtyGa9eAJd7
         ZX1nIRhRurfT9g5XmTwIsE97zz1n7VLzcLPvAytRDa1TQAEKCPuSt2l6zIYs0w9WBlsI
         IT7w==
X-Gm-Message-State: APjAAAX8kTd+z0rmunAKpof2bO2/HZUc1P9KOlBcH1FOyoQuuEd+az3o
        O8sU2A0CLWiGlZ/xRlo5je0=
X-Google-Smtp-Source: APXvYqz7s78ZV7WZCzvmtLTRsTmO/r2E/2Mc6nKhX2CSf3o8etgGYeYfLMD9XMmYce4al1etFKoa3Q==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr10047855wmg.167.1582997415729;
        Sat, 29 Feb 2020 09:30:15 -0800 (PST)
Received: from archtop.lan ([82.7.199.117])
        by smtp.googlemail.com with ESMTPSA id j12sm18342008wrt.35.2020.02.29.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 09:30:15 -0800 (PST)
From:   Lucas Tanure <tanure@linux.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lucas Tanure <tanure@linux.com>
Subject: [PATCH] HID: hyperv: NULL check before some freeing functions is not needed.
Date:   Sat, 29 Feb 2020 17:30:07 +0000
Message-Id: <20200229173007.61838-1-tanure@linux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix below warnings reported by coccicheck:
drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing functions is not needed.
drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing functions is not needed.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/hid/hid-hyperv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index dddfca555df9..0b6ee1dee625 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -193,8 +193,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		goto cleanup;
 
 	/* The pointer is not NULL when we resume from hibernation */
-	if (input_device->hid_desc != NULL)
-		kfree(input_device->hid_desc);
+	kfree(input_device->hid_desc);
 	input_device->hid_desc = kmemdup(desc, desc->bLength, GFP_ATOMIC);
 
 	if (!input_device->hid_desc)
@@ -207,8 +206,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	}
 
 	/* The pointer is not NULL when we resume from hibernation */
-	if (input_device->report_desc != NULL)
-		kfree(input_device->report_desc);
+	kfree(input_device->report_desc);
 	input_device->report_desc = kzalloc(input_device->report_desc_size,
 					  GFP_ATOMIC);
 
-- 
2.25.1

