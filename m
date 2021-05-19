Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C33893E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 May 2021 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355273AbhESQjV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 May 2021 12:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhESQjU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 May 2021 12:39:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFCC06175F
        for <linux-hyperv@vger.kernel.org>; Wed, 19 May 2021 09:38:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m190so9862838pga.2
        for <linux-hyperv@vger.kernel.org>; Wed, 19 May 2021 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWAvNwu70yGi0piG77zI81vixdJghKqkkTMOfFNChiI=;
        b=bAj0WCRFddjma1o2wG/8OaQv3rH6Vvbm8G4hloglgISNVznmFxyUSWnj5xsUqdyIzU
         26BpAMftuvWgbeFaX7McXsMDe06c2Ura8txQhwAUaf/lfQiaEvx6sjSKV4g4mmeUWE03
         xkKgpmfKa4hKXZoQXF/pOqm+86GfGoXxY+zvFFT8HYzwzGfS5iaJLoVBxCeeF74q2a8R
         OXc+5mqLzPaKwzbRFc3e4T93nsukzOvTXFxPPusXWPqBIKz+95knEvJuOJH4nC/MenQH
         AFrMPtYI5v1+lEP+kT3ZFBC8kfMqBq46fswU2hldtZ1yyaOHPanu4nLaCDXniYxDi4GU
         B4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWAvNwu70yGi0piG77zI81vixdJghKqkkTMOfFNChiI=;
        b=DpBFfta+0rzWNlCbckHLXKwenWDOvAjc3pA+ro4mqTqdTdMMXBhLqcmy+jdvaHhojp
         +f4fi3Bn+Ddfrl2xTY3Sq7gYdk5aC/8DjrQ5jQusJuoP4DECDv84onr/U1oLo4WUCr84
         sYL0p0B4cdiwCCH51RnOpjjSMQhiQ+xsNpnPMFyd+AK41k3q+AIkOa6qiI790Ip84hb2
         AE+Y36V07D4N+jMb8QFGW+9SZ7sFSMMnJ4GZ0MQdLBlyNxdFwzvDhbzYyIG/+5NBuQ0w
         CcVtaFV8Ta0+FBh72R+N/fS0GEGVoqRi3CEToIeeU50BTKqrHuuJHdoUUju87WGVnzrk
         cWfw==
X-Gm-Message-State: AOAM533+vM2ZuM2B6objR1Du7mVGr2SEByMknf86vsz/vU+6k+xeqwE6
        J7GCVG4o5G+jLx3hI7fTh5k=
X-Google-Smtp-Source: ABdhPJxmdAmiWNmDS4LnfZSvXA+4JygIuZmMW4NBbMR321aD/VzJRT7H733KHeb17RDRKDjIPNre7Q==
X-Received: by 2002:a63:f74b:: with SMTP id f11mr11731566pgk.327.1621442280677;
        Wed, 19 May 2021 09:38:00 -0700 (PDT)
Received: from arch2.localdomain ([182.68.112.122])
        by smtp.gmail.com with ESMTPSA id y1sm1442606pfn.13.2021.05.19.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:38:00 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v5 2/3] drm/hyperv: Handle feature change message from device
Date:   Wed, 19 May 2021 09:37:38 -0700
Message-Id: <20210519163739.1312-2-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519163739.1312-1-drawat.floss@gmail.com>
References: <20210519163739.1312-1-drawat.floss@gmail.com>
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
index c346dc7544aa..878b48a186c2 100644
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

