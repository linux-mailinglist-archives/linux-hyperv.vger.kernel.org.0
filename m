Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731F0665F59
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jan 2023 16:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjAKPlb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Jan 2023 10:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjAKPl2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A05BAD
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Jan 2023 07:41:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so12970415wms.4
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Jan 2023 07:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiMQ8+piQ8nAgiaXcZRE7LWfuFHPuL/LU3O06mzJvSM=;
        b=Iqzt7IQv9xkXzUobpL7j4FC6H3jn7vKZFofcLajEyVyyq/l3TjSTkDPJ7LQPaPPDVt
         DntP9I7yBTDr40b9uovHZl3T7CjuutDn8i98wswT9A6TAH/6BuhCaihmhopNbBlY+BL0
         AFmkupIYCR64BDSjc1bNduosHCeaOjzn2kdCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiMQ8+piQ8nAgiaXcZRE7LWfuFHPuL/LU3O06mzJvSM=;
        b=FKuD4hYmOkUiQM5MkLsWz4g/CisL5lw8tpLV2AOTTUdccUSVNoW/GU7VDhfXeQFYWL
         05N4Naks8966CK90xCLEHjGUBT3nubVR7kPUBgdNfCZ+0TbFDzvV2YMm8tUshkWP4vBw
         1wS645UuvR6IwzUhEDwF6PqDpwGnqEv1+suoCu0ePB73DQDf/r5pCph2/fiJPrFPlJqG
         hc/iUV8AKchzKmMHTw0yPgBM1eoYoczHenjjIeQnFqqqMSuJEGOOc1fxl/XCp2i27KJn
         6zNnh9TiJHXtRoqzIZIQv2M2yx/V9doMqEp92Mz3EybO9W5IAp+wWqx7PFvWjJP/z7O7
         qV0w==
X-Gm-Message-State: AFqh2komH2pyS/sozTabKEA0JmdNekb2NaY7ljBA3zrwtevgk/Na3BV7
        tr+YDtXEkAdT4ta5hgaaBy6oRw==
X-Google-Smtp-Source: AMrXdXu3UeZctJ8MnxWU/fsHLCSabTz80sVbl+2h0N8DpYvBCpXYEeKLv628G0HDyhB9RlzPqXUboQ==
X-Received: by 2002:a05:600c:4496:b0:3d3:47b7:569e with SMTP id e22-20020a05600c449600b003d347b7569emr51728355wmo.2.1673451684207;
        Wed, 11 Jan 2023 07:41:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:23 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Emma Anholt <emma@anholt.net>, Helge Deller <deller@gmx.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-hyperv@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 03/11] drm/aperture: Remove primary argument
Date:   Wed, 11 Jan 2023 16:41:04 +0100
Message-Id: <20230111154112.90575-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Only really pci devices have a business setting this - it's for
figuring out whether the legacy vga stuff should be nuked too. And
with the preceeding two patches those are all using the pci version of
this.

Which means for all other callers primary == false and we can remove
it now.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Deepak Rawat <drawat.floss@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Emma Anholt <emma@anholt.net>
Cc: Helge Deller <deller@gmx.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/gpu/drm/arm/hdlcd_drv.c             |  2 +-
 drivers/gpu/drm/armada/armada_drv.c         |  2 +-
 drivers/gpu/drm/drm_aperture.c              | 11 +++--------
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  1 -
 drivers/gpu/drm/meson/meson_drv.c           |  2 +-
 drivers/gpu/drm/msm/msm_fbdev.c             |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  2 +-
 drivers/gpu/drm/stm/drv.c                   |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c           |  2 +-
 drivers/gpu/drm/tegra/drm.c                 |  2 +-
 drivers/gpu/drm/vc4/vc4_drv.c               |  2 +-
 include/drm/drm_aperture.h                  |  7 +++----
 12 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 7043d1c9ed8f..98267e355918 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -297,7 +297,7 @@ static int hdlcd_drm_bind(struct device *dev)
 	 */
 	if (hdlcd_read(hdlcd, HDLCD_REG_COMMAND)) {
 		hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
-		drm_aperture_remove_framebuffers(false, &hdlcd_driver);
+		drm_aperture_remove_framebuffers(&hdlcd_driver);
 	}
 
 	drm_mode_config_reset(drm);
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 0643887800b4..c99ec7078301 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -95,7 +95,7 @@ static int armada_drm_bind(struct device *dev)
 	}
 
 	/* Remove early framebuffers */
-	ret = drm_aperture_remove_framebuffers(false, &armada_drm_driver);
+	ret = drm_aperture_remove_framebuffers(&armada_drm_driver);
 	if (ret) {
 		dev_err(dev, "[" DRM_NAME ":%s] can't kick out simple-fb: %d\n",
 			__func__, ret);
diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_aperture.c
index 3b8fdeeafd53..697cffbfd603 100644
--- a/drivers/gpu/drm/drm_aperture.c
+++ b/drivers/gpu/drm/drm_aperture.c
@@ -32,17 +32,13 @@
  *
  *	static int remove_conflicting_framebuffers(struct pci_dev *pdev)
  *	{
- *		bool primary = false;
  *		resource_size_t base, size;
  *		int ret;
  *
  *		base = pci_resource_start(pdev, 0);
  *		size = pci_resource_len(pdev, 0);
- *	#ifdef CONFIG_X86
- *		primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
- *	#endif
  *
- *		return drm_aperture_remove_conflicting_framebuffers(base, size, primary,
+ *		return drm_aperture_remove_conflicting_framebuffers(base, size,
  *		                                                    &example_driver);
  *	}
  *
@@ -161,7 +157,6 @@ EXPORT_SYMBOL(devm_aperture_acquire_from_firmware);
  * drm_aperture_remove_conflicting_framebuffers - remove existing framebuffers in the given range
  * @base: the aperture's base address in physical memory
  * @size: aperture size in bytes
- * @primary: also kick vga16fb if present
  * @req_driver: requesting DRM driver
  *
  * This function removes graphics device drivers which use the memory range described by
@@ -171,9 +166,9 @@ EXPORT_SYMBOL(devm_aperture_acquire_from_firmware);
  * 0 on success, or a negative errno code otherwise
  */
 int drm_aperture_remove_conflicting_framebuffers(resource_size_t base, resource_size_t size,
-						 bool primary, const struct drm_driver *req_driver)
+						 const struct drm_driver *req_driver)
 {
-	return aperture_remove_conflicting_devices(base, size, primary, req_driver->name);
+	return aperture_remove_conflicting_devices(base, size, false, req_driver->name);
 }
 EXPORT_SYMBOL(drm_aperture_remove_conflicting_framebuffers);
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 427c20ba3404..7e81d58c083f 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -74,7 +74,6 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 
 	drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
 						     screen_info.lfb_size,
-						     false,
 						     &hyperv_driver);
 
 	hv->fb_size = (unsigned long)hv->mmio_megabytes * 1024 * 1024;
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 79bfe3938d3c..c8d39809d897 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -285,7 +285,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	 * Remove early framebuffers (ie. simplefb). The framebuffer can be
 	 * located anywhere in RAM
 	 */
-	ret = drm_aperture_remove_framebuffers(false, &meson_driver);
+	ret = drm_aperture_remove_framebuffers(&meson_driver);
 	if (ret)
 		goto free_drm;
 
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 31e1e30cb52a..84dfbccb6912 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -155,7 +155,7 @@ struct drm_fb_helper *msm_fbdev_init(struct drm_device *dev)
 	}
 
 	/* the fw fb could be anywhere in memory */
-	ret = drm_aperture_remove_framebuffers(false, dev->driver);
+	ret = drm_aperture_remove_framebuffers(dev->driver);
 	if (ret)
 		goto fini;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 6e0788d14c10..d97f2edc646b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -140,7 +140,7 @@ static int rockchip_drm_bind(struct device *dev)
 	int ret;
 
 	/* Remove existing drivers that may own the framebuffer memory. */
-	ret = drm_aperture_remove_framebuffers(false, &rockchip_drm_driver);
+	ret = drm_aperture_remove_framebuffers(&rockchip_drm_driver);
 	if (ret) {
 		DRM_DEV_ERROR(dev,
 			      "Failed to remove existing framebuffers - %d.\n",
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 50410bd99dfe..354349c6e085 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -185,7 +185,7 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 
 	DRM_DEBUG("%s\n", __func__);
 
-	ret = drm_aperture_remove_framebuffers(false, &drv_driver);
+	ret = drm_aperture_remove_framebuffers(&drv_driver);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index cc94efbbf2d4..6367b89cbab1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -98,7 +98,7 @@ static int sun4i_drv_bind(struct device *dev)
 		goto cleanup_mode_config;
 
 	/* Remove early framebuffers (ie. simplefb) */
-	ret = drm_aperture_remove_framebuffers(false, &sun4i_drv_driver);
+	ret = drm_aperture_remove_framebuffers(&sun4i_drv_driver);
 	if (ret)
 		goto cleanup_mode_config;
 
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 7bd2e65c2a16..d2ff527cf6d7 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1252,7 +1252,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	drm_mode_config_reset(drm);
 
-	err = drm_aperture_remove_framebuffers(false, &tegra_drm_driver);
+	err = drm_aperture_remove_framebuffers(&tegra_drm_driver);
 	if (err < 0)
 		goto hub;
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 0ccaee57fe9a..0a9e922636b1 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -350,7 +350,7 @@ static int vc4_drm_bind(struct device *dev)
 			return -EPROBE_DEFER;
 	}
 
-	ret = drm_aperture_remove_framebuffers(false, driver);
+	ret = drm_aperture_remove_framebuffers(driver);
 	if (ret)
 		return ret;
 
diff --git a/include/drm/drm_aperture.h b/include/drm/drm_aperture.h
index 7096703c3949..cbe33b49fd5d 100644
--- a/include/drm/drm_aperture.h
+++ b/include/drm/drm_aperture.h
@@ -13,14 +13,13 @@ int devm_aperture_acquire_from_firmware(struct drm_device *dev, resource_size_t
 					resource_size_t size);
 
 int drm_aperture_remove_conflicting_framebuffers(resource_size_t base, resource_size_t size,
-						 bool primary, const struct drm_driver *req_driver);
+						 const struct drm_driver *req_driver);
 
 int drm_aperture_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 						     const struct drm_driver *req_driver);
 
 /**
  * drm_aperture_remove_framebuffers - remove all existing framebuffers
- * @primary: also kick vga16fb if present
  * @req_driver: requesting DRM driver
  *
  * This function removes all graphics device drivers. Use this function on systems
@@ -30,9 +29,9 @@ int drm_aperture_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
  * 0 on success, or a negative errno code otherwise
  */
 static inline int
-drm_aperture_remove_framebuffers(bool primary, const struct drm_driver *req_driver)
+drm_aperture_remove_framebuffers(const struct drm_driver *req_driver)
 {
-	return drm_aperture_remove_conflicting_framebuffers(0, (resource_size_t)-1, primary,
+	return drm_aperture_remove_conflicting_framebuffers(0, (resource_size_t)-1,
 							    req_driver);
 }
 
-- 
2.39.0

