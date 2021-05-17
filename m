Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86463382BA5
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 May 2021 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhEQMBG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 May 2021 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbhEQMBF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 May 2021 08:01:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4488C061573
        for <linux-hyperv@vger.kernel.org>; Mon, 17 May 2021 04:59:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a11so3006041plh.3
        for <linux-hyperv@vger.kernel.org>; Mon, 17 May 2021 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlWtfnuOca00MfVWO0P9k8vYMaH+QS6fPyffjiCe0/Y=;
        b=mTUq43MPPJ/c+xNZNdt3a1iSdzJtnYbp1Wby/LtlzyS4dd3DO5tnqAx8fZIy/vsYSQ
         sEDQrwD5926YNrrVaGifBXENezGFSxyoRHB58A90SacWuMzc6scb9vnKMqL7gF4nIEyR
         rF+UmopHwbq8H4WmCvZtO/fxI11ZGTeroxZFlzMfujntSkLXNd0fMl87pKeYeWrAAW5N
         Lt+x9/bYa+xwCcAuj5/88aPRg4qzxdmvrWwwQWuvO8NqLdG1+7BLcq6ximh6eoTJBFAP
         GQr8ZpJvcvOVpDk2jNroKH6s4y0nMN1Xyn2AD6g7q42KYBpfSdpBSy8plTk2ZsRJHPFE
         JHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlWtfnuOca00MfVWO0P9k8vYMaH+QS6fPyffjiCe0/Y=;
        b=JySB5245w1ypNBvuoBPWKLeqmNX/eHy3L/u+ttPdRMw2MPDuaiBj8ylGmNvMm8fxPM
         tKD2vus4oQgmYALX3m/Kon4ZRtjXPbFdS4XIVURzaNntyUUXTMv9zL6XChsj+0oY3UyR
         Jyw9dHw44kdv551FtIUp4uKobmx7FJeg/kO/cVR5ARfbIDDvGJ5pdLD/A0c1lrJTE2ZD
         Kg+A/Dnc7rnFpW7H6ty4S7BxWx/cHY4ni6fqDQ0040GwRtkCMaJPeCr588ALptKVLRRy
         6MUUCbQm2eK9EwJzZnw3Kqw8ni1678hvtH5xPbryqikITf+4b2w4j48sGmJMmjg9B3rc
         y8Gg==
X-Gm-Message-State: AOAM530UwZnqZvpksgUPwwRuKMxTUkgVdH9lpnC1A446BZjEWNux5uYo
        V6+AUOEfn3m8d9+VNwfQTKw=
X-Google-Smtp-Source: ABdhPJwCP7o0wwgn45c/6fp08TB49Tc4xmA6HankyathivWYWxsNdCbZ8YjsVBxt70sSkLsKO5vX+g==
X-Received: by 2002:a17:90a:ec03:: with SMTP id l3mr4087941pjy.194.1621252788469;
        Mon, 17 May 2021 04:59:48 -0700 (PDT)
Received: from arch2.localdomain ([106.212.13.216])
        by smtp.gmail.com with ESMTPSA id q24sm10211393pgb.19.2021.05.17.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:59:48 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v4 2/3] drm/hyperv: Handle feature change message from device
Date:   Mon, 17 May 2021 04:59:21 -0700
Message-Id: <20210517115922.8033-2-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517115922.8033-1-drawat.floss@gmail.com>
References: <20210517115922.8033-1-drawat.floss@gmail.com>
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
index 68a6ba91a486..8e6ff86c471a 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -201,6 +201,8 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	if (ret)
 		drm_warn(dev, "Failed to update vram location.\n");
 
+	hv->dirt_needed = true;
+
 	ret = hyperv_mode_config_init(hv);
 	if (ret)
 		goto err_vmbus_close;
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 700870b243fe..6fff24b40974 100644
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

