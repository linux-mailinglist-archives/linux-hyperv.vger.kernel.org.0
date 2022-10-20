Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFF605D3C
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJTKiX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Oct 2022 06:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiJTKiM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Oct 2022 06:38:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8361D375B;
        Thu, 20 Oct 2022 03:38:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F340E22B43;
        Thu, 20 Oct 2022 10:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666262284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLtdoFG3t9K/FkdzkuKNiHmWsCp4LPOGp2v06LJpDy0=;
        b=sHTEeO1Y9+cHrfBx3UESomI73p/bN7rJhCUC7qstDFGgOJkYmiBC/5iC3zX0hjtkXXwdx7
        ie0hJ1xGvxp/6eBxsSVHzLhsbctqCp7ByzKv23cgX6u+/8KTymAKwkoMHuReGIBlcWtWlb
        0W5E2/LM9daulasM5xn8FKh+61AAKRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666262284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLtdoFG3t9K/FkdzkuKNiHmWsCp4LPOGp2v06LJpDy0=;
        b=FZ0V7FeanFp6ft5Hzqg9CG7S9/Lqslb4mBOhrccx6y8atx81z1HdxAaBVdh/yh08UZ8maA
        rfSrCSsJYHNaDEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85D4813AF5;
        Thu, 20 Oct 2022 10:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IJPwHwslUWPPYwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 20 Oct 2022 10:38:03 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, sam@ravnborg.org,
        javierm@redhat.com, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 13/21] drm/fb-helper: Rename drm_fb_helper_alloc_fbi() to use _info postfix
Date:   Thu, 20 Oct 2022 12:37:47 +0200
Message-Id: <20221020103755.24058-14-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221020103755.24058-1-tzimmermann@suse.de>
References: <20221020103755.24058-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Rename drm_fb_helper_alloc_fbi() to drm_fb_helper_alloc_info() as
part of unifying the naming within fbdev helpers. Adapt drivers. No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/armada/armada_fbdev.c      | 2 +-
 drivers/gpu/drm/drm_fb_helper.c            | 8 ++++----
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c  | 2 +-
 drivers/gpu/drm/gma500/framebuffer.c       | 2 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c | 2 +-
 drivers/gpu/drm/msm/msm_fbdev.c            | 2 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c    | 2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c       | 2 +-
 drivers/gpu/drm/radeon/radeon_fb.c         | 2 +-
 drivers/gpu/drm/tegra/fb.c                 | 2 +-
 include/drm/drm_fb_helper.h                | 4 ++--
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 38f5170c0fea6..eaae98d9377ae 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -72,7 +72,7 @@ static int armada_fbdev_create(struct drm_fb_helper *fbh,
 	if (IS_ERR(dfb))
 		return PTR_ERR(dfb);
 
-	info = drm_fb_helper_alloc_fbi(fbh);
+	info = drm_fb_helper_alloc_info(fbh);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
 		goto err_fballoc;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 480bf4f568b7b..881e6a04fa706 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -558,7 +558,7 @@ int drm_fb_helper_init(struct drm_device *dev,
 EXPORT_SYMBOL(drm_fb_helper_init);
 
 /**
- * drm_fb_helper_alloc_fbi - allocate fb_info and some of its members
+ * drm_fb_helper_alloc_info - allocate fb_info and some of its members
  * @fb_helper: driver-allocated fbdev helper
  *
  * A helper to alloc fb_info and the members cmap and apertures. Called
@@ -570,7 +570,7 @@ EXPORT_SYMBOL(drm_fb_helper_init);
  * fb_info pointer if things went okay, pointer containing error code
  * otherwise
  */
-struct fb_info *drm_fb_helper_alloc_fbi(struct drm_fb_helper *fb_helper)
+struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 {
 	struct device *dev = fb_helper->dev->dev;
 	struct fb_info *info;
@@ -609,7 +609,7 @@ struct fb_info *drm_fb_helper_alloc_fbi(struct drm_fb_helper *fb_helper)
 	framebuffer_release(info);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(drm_fb_helper_alloc_fbi);
+EXPORT_SYMBOL(drm_fb_helper_alloc_info);
 
 /**
  * drm_fb_helper_unregister_fbi - unregister fb_info framebuffer device
@@ -2440,7 +2440,7 @@ static int drm_fb_helper_generic_probe(struct drm_fb_helper *fb_helper,
 	fb_helper->fb = buffer->fb;
 	fb = buffer->fb;
 
-	fbi = drm_fb_helper_alloc_fbi(fb_helper);
+	fbi = drm_fb_helper_alloc_info(fb_helper);
 	if (IS_ERR(fbi))
 		return PTR_ERR(fbi);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 767afd2bfa822..8741eb0b1b604 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -63,7 +63,7 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 	unsigned int size = fb->width * fb->height * fb->format->cpp[0];
 	unsigned long offset;
 
-	fbi = drm_fb_helper_alloc_fbi(helper);
+	fbi = drm_fb_helper_alloc_info(helper);
 	if (IS_ERR(fbi)) {
 		DRM_DEV_ERROR(to_dma_dev(helper->dev),
 			      "failed to allocate fb info.\n");
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index aa3ecf771fd36..a5fad2483fa3a 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -268,7 +268,7 @@ static int psbfb_create(struct drm_fb_helper *fb_helper,
 
 	memset(dev_priv->vram_addr + backing->offset, 0, size);
 
-	info = drm_fb_helper_alloc_fbi(fb_helper);
+	info = drm_fb_helper_alloc_info(fb_helper);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
 		goto err_drm_gem_object_put;
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index b73c6a16f46a0..a1357acb5a1c6 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -254,7 +254,7 @@ static int intelfb_create(struct drm_fb_helper *helper,
 		goto out_unlock;
 	}
 
-	info = drm_fb_helper_alloc_fbi(helper);
+	info = drm_fb_helper_alloc_info(helper);
 	if (IS_ERR(info)) {
 		drm_err(&dev_priv->drm, "Failed to allocate fb_info\n");
 		ret = PTR_ERR(info);
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 46168eccfac4a..3de661730a8bb 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -93,7 +93,7 @@ static int msm_fbdev_create(struct drm_fb_helper *helper,
 		goto fail;
 	}
 
-	fbi = drm_fb_helper_alloc_fbi(helper);
+	fbi = drm_fb_helper_alloc_info(helper);
 	if (IS_ERR(fbi)) {
 		DRM_DEV_ERROR(dev->dev, "failed to allocate fb info\n");
 		ret = PTR_ERR(fbi);
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index ac4bd529ae2e8..fca40124fc17c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -362,7 +362,7 @@ nouveau_fbcon_create(struct drm_fb_helper *helper,
 		}
 	}
 
-	info = drm_fb_helper_alloc_fbi(helper);
+	info = drm_fb_helper_alloc_info(helper);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
 		goto out_unlock;
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index f30aed64f6e20..b21ead9aca2d5 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -161,7 +161,7 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 		goto fail;
 	}
 
-	fbi = drm_fb_helper_alloc_fbi(helper);
+	fbi = drm_fb_helper_alloc_info(helper);
 	if (IS_ERR(fbi)) {
 		dev_err(dev->dev, "failed to allocate fb info\n");
 		ret = PTR_ERR(fbi);
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 6ccea51d40722..2dc96fdd35f9f 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -243,7 +243,7 @@ static int radeonfb_create(struct drm_fb_helper *helper,
 	rbo = gem_to_radeon_bo(gobj);
 
 	/* okay we have an object now allocate the framebuffer */
-	info = drm_fb_helper_alloc_fbi(helper);
+	info = drm_fb_helper_alloc_info(helper);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
 		goto out;
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index e652ea6ec85df..d5a9c800ef829 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -243,7 +243,7 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
-	info = drm_fb_helper_alloc_fbi(helper);
+	info = drm_fb_helper_alloc_info(helper);
 	if (IS_ERR(info)) {
 		dev_err(drm->dev, "failed to allocate framebuffer info\n");
 		drm_gem_object_put(&bo->gem);
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index d83e2d8e92eb9..5ec9d9c68d144 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -222,7 +222,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 
 int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper);
 
-struct fb_info *drm_fb_helper_alloc_fbi(struct drm_fb_helper *fb_helper);
+struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper);
 void drm_fb_helper_unregister_fbi(struct drm_fb_helper *fb_helper);
 void drm_fb_helper_fill_info(struct fb_info *info,
 			     struct drm_fb_helper *fb_helper,
@@ -320,7 +320,7 @@ drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper)
 }
 
 static inline struct fb_info *
-drm_fb_helper_alloc_fbi(struct drm_fb_helper *fb_helper)
+drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 {
 	return NULL;
 }
-- 
2.38.0

