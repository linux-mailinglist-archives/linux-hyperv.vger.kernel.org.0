Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23D58612F
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Jul 2022 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiGaUFe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 31 Jul 2022 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiGaUFd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 31 Jul 2022 16:05:33 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 Jul 2022 13:05:32 PDT
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90A1A2DCA
        for <linux-hyperv@vger.kernel.org>; Sun, 31 Jul 2022 13:05:32 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id IF4YopDbmkootIF4Zoa9NM; Sun, 31 Jul 2022 21:58:00 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 21:58:00 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] hyperv_setup_vram() calls vmbus_allocate_mmio(). This must be undone in the error handling path of the probe, as already done in the remove function.
Date:   Sun, 31 Jul 2022 21:57:57 +0200
Message-Id: <1781855facffbdba640ce2da3649cac424e76fed.1659297462.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch depends on	commit a0ab5abced55 ("drm/hyperv : Removing the
restruction of VRAM allocation with PCI bar size").
Without it, something like what is done in commit e048834c209a
("drm/hyperv: Fix device removal on Gen1 VMs") should be done.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 6d11e7938c83..fc8b4e045f5d 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -133,7 +133,6 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	}
 
 	ret = hyperv_setup_vram(hv, hdev);
-
 	if (ret)
 		goto err_vmbus_close;
 
@@ -150,18 +149,20 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 
 	ret = hyperv_mode_config_init(hv);
 	if (ret)
-		goto err_vmbus_close;
+		goto err_free_mmio;
 
 	ret = drm_dev_register(dev, 0);
 	if (ret) {
 		drm_err(dev, "Failed to register drm driver.\n");
-		goto err_vmbus_close;
+		goto err_free_mmio;
 	}
 
 	drm_fbdev_generic_setup(dev, 0);
 
 	return 0;
 
+err_free_mmio:
+	vmbus_free_mmio(hv->mem->start, hv->fb_size);
 err_vmbus_close:
 	vmbus_close(hdev->channel);
 err_hv_set_drv_data:
-- 
2.34.1

