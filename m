Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E3392C96
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 May 2021 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhE0LYd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 May 2021 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhE0LYV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 May 2021 07:24:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC1C061760
        for <linux-hyperv@vger.kernel.org>; Thu, 27 May 2021 04:22:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q67so340182pfb.4
        for <linux-hyperv@vger.kernel.org>; Thu, 27 May 2021 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLKwR4NP2EdVfnoZCBP4JksC+Mu/sBLAGExwc+qAW8k=;
        b=U3nnWBjc/PORkfU1amlVwph+m9n8heoP4REI9pYv3zsJ70Qdk1YrbXb2fnr/Cqaf1w
         piAWaPLrqVLwxRLTNngntE2XurHnhfgQYsRK6qWCPmJtcWqOU6oh3xiTzPiNECAFmkTK
         kD3yU/6qMz6ZpXuxSfIIJus20dwXrRuf9jVx0sazTJQaRqgdyCvIxdj57HlBAPeMyqTE
         IwaVlb5OIOf78eL5hu93Mnps4wVa/Myv0Rmi4awpn2lJIuSSecC48wsp1SKjJRUYSmt3
         GrDKyW66Ug6rLzFz7UHiZ5sak0SzpSlDHY/4ZRaqJNlDfapOQkLYt/6czQgocEN4CoGn
         Bgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLKwR4NP2EdVfnoZCBP4JksC+Mu/sBLAGExwc+qAW8k=;
        b=dHrCr4uwAQKuePEyCZfxJeSgbgvEohSWeUY9taZvfKhzfymNWaHRCQ3jP4jb+4kioD
         rDG9afomkg9Fy7sgfbj56KCrPVC2yztDYbTlA7suSlok96K9HaHT/F6Br00p2afw2HSs
         XZGOjjsXaDPYp+90GnMSRtR8l7yWZiwIHNmhoCt5VhmOQ3Hdy8XwGNowo0bYRpMxsL5a
         7AgTS/VmD7hWSyt3j7C2uTqeKRwIfSewd3e7G956mwuoiuPvsepIj4TysHRObhQPhXs9
         9sIWfDsLoZRQpGez5SP4aN7J+ZlGEgGtzwiP0dB3JwaXHsLWmEh8QNp7WaAcHAEQ2F6s
         SZgA==
X-Gm-Message-State: AOAM533DZK8yOWct3gequQv+G/MJAtetgKBVhv+ieuEpdzTZSCQFcEEC
        2ZO+Tndxywlgit8kzIYyWY8=
X-Google-Smtp-Source: ABdhPJwqhUuykfOJwASvcHnKpq4PcN3fJFu1w/dycTGDZpy5LDpTKsDUvo3n5FN+nIkBddDWofA/Kg==
X-Received: by 2002:a05:6a00:1c43:b029:2e4:d188:fe38 with SMTP id s3-20020a056a001c43b02902e4d188fe38mr2960127pfw.20.1622114566742;
        Thu, 27 May 2021 04:22:46 -0700 (PDT)
Received: from arch2.localdomain ([50.47.106.83])
        by smtp.gmail.com with ESMTPSA id c11sm1730325pjr.32.2021.05.27.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 04:22:46 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v6 2/3] drm/hyperv: Handle feature change message from device
Date:   Thu, 27 May 2021 04:22:29 -0700
Message-Id: <20210527112230.1274-2-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527112230.1274-1-drawat.floss@gmail.com>
References: <20210527112230.1274-1-drawat.floss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Virtual device inform if screen update is needed or not with
SYNTHVID_FEATURE_CHANGE message. Handle this message to set dirt_needed
flag.

Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm.h       | 1 +
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c   | 2 ++
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index e1d1fdea96f2..886add4f9cd0 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -29,6 +29,7 @@ struct hyperv_drm_device {
 	struct completion wait;
 	u32 synthvid_version;
 	u32 mmio_megabytes;
+	bool dirt_needed;
 
 	u8 init_buf[VMBUS_MAX_PACKET_SIZE];
 	u8 recv_buf[VMBUS_MAX_PACKET_SIZE];
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index beb53068fa0d..eb06c92c4bfd 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -198,6 +198,8 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	if (ret)
 		drm_warn(dev, "Failed to update vram location.\n");
 
+	hv->dirt_needed = true;
+
 	ret = hyperv_mode_config_init(hv);
 	if (ret)
 		goto err_vmbus_close;
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 00c4cc2db605..6d4bdccfbd1a 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -301,8 +301,12 @@ int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
 
 int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
 {
+	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg msg;
 
+	if (!hv->dirt_needed)
+		return 0;
+
 	memset(&msg, 0, sizeof(struct synthvid_msg));
 
 	msg.vid_hdr.type = SYNTHVID_DIRT;
@@ -387,6 +391,9 @@ static void hyperv_receive_sub(struct hv_device *hdev)
 		complete(&hv->wait);
 		return;
 	}
+
+	if (msg->vid_hdr.type == SYNTHVID_FEATURE_CHANGE)
+		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 }
 
 static void hyperv_receive(void *ctx)
-- 
2.31.1

