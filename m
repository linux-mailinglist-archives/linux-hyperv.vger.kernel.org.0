Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755B149C35F
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jan 2022 06:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiAZFwy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jan 2022 00:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiAZFwy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jan 2022 00:52:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E7C06161C;
        Tue, 25 Jan 2022 21:52:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so2521560pjy.1;
        Tue, 25 Jan 2022 21:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6ekZ+mtLISqWzTceMfJVHEWoaa9M02nRqzOWevYuvw=;
        b=pSTTxtEcr/vwhnKyTzeqvHDDtd8SaOaqFzeWyj96kgH3aGdgEjhntHlTrISobyLf4X
         0M87rGF1L0aPvOs17ocqNCXahykJDmo8qOaMN5cMivGi7FmypwnB906c9DKAysbLtFTI
         FCLh9OhniL0bvFx5Asy8/TNCVNrM1ERWBfhS8q0c+DYWE+wRQAiXZz2dYXCP3OGIhC4U
         gJamxxYcjJkaaaAvJvxWqHypMvnwzvgJgHdHgnAvQUxrHjPz1RxCZh6tqpQAlVAMte8A
         Njy9sp5VEBZkqY71lJf9x34ix1KYVkxvS6FJqYH015+UjDMvLiiJgedJYqy9q0qp2odR
         c5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6ekZ+mtLISqWzTceMfJVHEWoaa9M02nRqzOWevYuvw=;
        b=T2oFyH+hi2Xk9vXKgR7S2A5ywIoD83M7rrAvmu0P8UyobrwGvTQk2eGx5BC3oW1CQ7
         SU6K3YHHwBMp9667bjnqqtEixuV4inm1Hv7/7f2FVNiX1WD0cdgVfnh4KxArXCtenw4n
         epYbIlxImLOi6pm60Nqr0F8EXuJUms7WHfNq2oYN/oMCmdQUADQU46Sr794bVrjR+u6B
         KFoihnQs42Ae7bE0cvhGUFfuZTHD8NA/SRDPxds6Axsv+wVfcbIJZvvfYM/v5RRVIobi
         ExtQCQgHAp9eD10PNSfJAqzCq6wxrIkN2jP1NWtzLW6vZJOgaJpcUUvQhbzkGu9lAoEM
         +gWA==
X-Gm-Message-State: AOAM5313GZZXUgqPbUbBa5UDqiK0ud0Get5bb6dKg1v3QuqjogieXf8U
        pEY04qA5nvNVdkuIESiDCaNFd+2lmVsNWD/d
X-Google-Smtp-Source: ABdhPJwhu9h8vWxNoN00CImMjZajcHj3KKS1BkZQPvWMU5RDuGCGtDrk4pjRNHwjSewczVoIIQJy+A==
X-Received: by 2002:a17:902:f550:b0:14b:53c9:da14 with SMTP id h16-20020a170902f55000b0014b53c9da14mr11759262plf.70.1643176373236;
        Tue, 25 Jan 2022 21:52:53 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 20sm15561537pgz.59.2022.01.25.21.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 21:52:52 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj
Date:   Wed, 26 Jan 2022 05:52:46 +0000
Message-Id: <20220126055247.8125-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/hv/vmbus_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55fe3169..9e055697783b 100644
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
 
-- 
2.17.1

