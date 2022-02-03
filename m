Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCD4A8A0E
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Feb 2022 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352843AbiBCRaV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 12:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiBCRaT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 12:30:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1334C061714;
        Thu,  3 Feb 2022 09:30:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3706088pjb.1;
        Thu, 03 Feb 2022 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oES1qt7p4xJNj9uCFaojfCQlhj+gIHLL0zedpK668Cs=;
        b=MOa1Ytiw0Y7blR1rd5wpWwlracRhndX8Shu1sZMKhfUXXquTav6+xZxKzf4WvXoQ+C
         RAIFbTh6/4dCmhajPft0skEfGQvqXMXgaqEYMDUHxMI0ToPBHhNoCP2uESAl3Dk22CgH
         81A1AlzbjxFo/xZMnYq3lGtotIrg2hmgBjzVQQc8vp0YV7mpcdRZ97Buwp9onXcwBmnf
         d4cCy2hStL/ARCcRq8Gi1rZuqFuOpY2l8NeLxc48UgLtMK18qpdRT3zr170N2Bv0B1fH
         JXBiqdl5gPCdqvBTNNpxHpKjGsUX6bA87bLgu5XYu5iPleRAKmIGjkGFANJ/vcatP07T
         hJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oES1qt7p4xJNj9uCFaojfCQlhj+gIHLL0zedpK668Cs=;
        b=0TF2vZfOXPKmKzWxNDmQIK7c/xeeAyQVVl65staCklZeuvrWaFyHHn/1qUAlWDUl7e
         c1vQjHd5TQfF+ZARegbIb2nYPdNx2eN1oMWJ/1XNTbIr6wOxpsSYQ6FhYMxJjaPF8Z2n
         Q4SkWpe8yZotBxHDwYPU0ijS9mbqh0EOB/8KdP0JUqhyK26GOTlBVF5uePI3bHoB7yCn
         pihfD0qjKM9p7AAfAXdPcjJ/cd+aLeWKoIOVAEmzyUpS6ET3cHDVyvCIQKpfd9X6vIAu
         wvive5H8T3BmZeKNv43QL5PO+ZLn1bAcUFBcgXckW6O6gqrauqaK2QPJYoIMsZnGf422
         Cyzw==
X-Gm-Message-State: AOAM532ycjRYsmVJG/fv93Iq6XURlfKDlNgiTNko7FmwHgFm4mOCDjoC
        DYms9fnpJNGNKHn8xnjqzww=
X-Google-Smtp-Source: ABdhPJwnsKzVdaDlIYSFNgBPHSyWdJ9x4IZ0f4Ndh/H/b4/pnv+LbSuwFFgNLbHRgFHjQMDNZu7cvA==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17mr36584032plo.154.1643909419163;
        Thu, 03 Feb 2022 09:30:19 -0800 (PST)
Received: from localhost.localdomain ([122.112.200.238])
        by smtp.googlemail.com with ESMTPSA id ms14sm10651241pjb.15.2022.02.03.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:30:18 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     juvazq@linux.microsoft.com
Cc:     decui@microsoft.com, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, kys@microsoft.com, linmq006@gmail.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        sthemmin@microsoft.com, wei.liu@kernel.org
Subject: [PATCH v2] Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj
Date:   Fri,  4 Feb 2022 01:30:08 +0800
Message-Id: <20220203173008.43480-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128215604.xuqdpnnn4yjqfaoy@surface>
References: <20220128215604.xuqdpnnn4yjqfaoy@surface>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()：

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix memory leak by calling kobject_put().

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- Add cleanup when sysfs_create_group() fails

kobject_uevent() is used for notifying userspace by sending an uevent,
I don't think we need to do error handling for it.
---
 drivers/hv/vmbus_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55fe3169..34a4fd21bdf5 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2028,8 +2028,10 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	kobj->kset = dev->channels_kset;
 	ret = kobject_init_and_add(kobj, &vmbus_chan_ktype, NULL,
 				   "%u", relid);
-	if (ret)
+	if (ret) {
+		kobject_put(kobj);
 		return ret;
+	}
 
 	ret = sysfs_create_group(kobj, &vmbus_chan_group);
 
@@ -2038,6 +2040,7 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 		 * The calling functions' error handling paths will cleanup the
 		 * empty channel directory.
 		 */
+		kobject_put(kobj);
 		dev_err(device, "Unable to set up channel sysfs files\n");
 		return ret;
 	}
-- 
2.25.1

