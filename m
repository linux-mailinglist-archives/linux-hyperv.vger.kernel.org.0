Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046DB6D6DD2
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjDDUSw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Apr 2023 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjDDUSv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 16:18:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4164A4202
        for <linux-hyperv@vger.kernel.org>; Tue,  4 Apr 2023 13:18:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er13so94501773edb.9
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Apr 2023 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680639530; x=1683231530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4mnimXs1Y+A4RRGEJn/sOcyRSW8VF9evwhzPOfNqVo=;
        b=NxE1dT3n61sRwW+vJrpz+moOoXAI1qAmGpNYNXGGhqD+bLHsqdDZnnG0PoolTZ3skR
         cPdXF3OhbrqtSLxHN845/hoZ0RPDul2CgbO8q4MpdkLlnmaKn2bt7snlIK2wl09V1XWW
         mjYpLq8jxZtqnGEJpi8Uls1V223yydlQgl2pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639530; x=1683231530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4mnimXs1Y+A4RRGEJn/sOcyRSW8VF9evwhzPOfNqVo=;
        b=road/uZkwRXofXZWIoNmxCPo3FnpMrFdfBagA49yYMCaYr+PWL8cJ6Azdx331B1YAw
         JetY2H01GzKOhz6d2IwprTufW3kQiXUsWTDnpL43OGwgo0IjXL4hPNfqqUCWnKHUcjlB
         EHm92ye9C8efrgpRGqKo0HbzyeDWBuC4ztxW2NuorDvR+fjLlJiKfvLAW4M0sKp6kCg4
         YefbZ/RaKdqyDVL6yz9l4rDQqd0yYcMcuCdopQdSaanq3bE8Xy/pjF3Fnu/hVKJ2OoN/
         lnQwwNmChsVEBMYshFmaYRdOG6Zq6peWiPbXNA/8WPHnS4orivZVjxqYeDGk8TIBj9Fa
         kjIQ==
X-Gm-Message-State: AAQBX9elQH2sF9jtcaNgPtVnWdnDGNBDrJSRU0oekpY8OeS9El2QhXcM
        9oysi3MiIMjbFORkpUij5wzv3g==
X-Google-Smtp-Source: AKy350aCCszFcxCe1Z/BUGgPRWV8MnD95U/BY42Lk4zNOohhPfArL8IlC58sTRcvv5jg6En42nhF4A==
X-Received: by 2002:a05:6402:26c6:b0:502:e50:3358 with SMTP id x6-20020a05640226c600b005020e503358mr679553edd.3.1680639529764;
        Tue, 04 Apr 2023 13:18:49 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id u12-20020a50c04c000000b004d8d2735251sm6367986edd.43.2023.04.04.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:18:49 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH 6/8] video/aperture: Drop primary argument
Date:   Tue,  4 Apr 2023 22:18:40 +0200
Message-Id: <20230404201842.567344-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

With the preceeding patches it's become defunct. Also I'm about to add
a different boolean argument, so it's better to keep the confusion
down to the absolute minimum.

v2: Since the hypervfb patch got droppped (it's only a pci device for
gen1 vm, not for gen2) there is one leftover user in an actual driver
left to touch.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/gpu/drm/drm_aperture.c  | 2 +-
 drivers/video/aperture.c        | 7 +++----
 drivers/video/fbdev/hyperv_fb.c | 2 +-
 include/linux/aperture.h        | 9 ++++-----
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_aperture.c
index 697cffbfd603..5729f3bb4398 100644
--- a/drivers/gpu/drm/drm_aperture.c
+++ b/drivers/gpu/drm/drm_aperture.c
@@ -168,7 +168,7 @@ EXPORT_SYMBOL(devm_aperture_acquire_from_firmware);
 int drm_aperture_remove_conflicting_framebuffers(resource_size_t base, resource_size_t size,
 						 const struct drm_driver *req_driver)
 {
-	return aperture_remove_conflicting_devices(base, size, false, req_driver->name);
+	return aperture_remove_conflicting_devices(base, size, req_driver->name);
 }
 EXPORT_SYMBOL(drm_aperture_remove_conflicting_framebuffers);
 
diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index ec9387d94049..8f1437339e49 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -43,7 +43,7 @@
  *		base = mem->start;
  *		size = resource_size(mem);
  *
- *		ret = aperture_remove_conflicting_devices(base, size, false, "example");
+ *		ret = aperture_remove_conflicting_devices(base, size, "example");
  *		if (ret)
  *			return ret;
  *
@@ -274,7 +274,6 @@ static void aperture_detach_devices(resource_size_t base, resource_size_t size)
  * aperture_remove_conflicting_devices - remove devices in the given range
  * @base: the aperture's base address in physical memory
  * @size: aperture size in bytes
- * @primary: also kick vga16fb if present; only relevant for VGA devices
  * @name: a descriptive name of the requesting driver
  *
  * This function removes devices that own apertures within @base and @size.
@@ -283,7 +282,7 @@ static void aperture_detach_devices(resource_size_t base, resource_size_t size)
  * 0 on success, or a negative errno code otherwise
  */
 int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t size,
-					bool primary, const char *name)
+					const char *name)
 {
 	/*
 	 * If a driver asked to unregister a platform device registered by
@@ -328,7 +327,7 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 
 		base = pci_resource_start(pdev, bar);
 		size = pci_resource_len(pdev, bar);
-		ret = aperture_remove_conflicting_devices(base, size, primary, name);
+		ret = aperture_remove_conflicting_devices(base, size, name);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index ec3f6cf05f8c..54f433e09ab8 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1073,7 +1073,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	info->screen_size = dio_fb_size;
 
 getmem_done:
-	aperture_remove_conflicting_devices(base, size, false, KBUILD_MODNAME);
+	aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
 
 	if (gen2vm) {
 		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
diff --git a/include/linux/aperture.h b/include/linux/aperture.h
index 442f15a57cad..7248727753be 100644
--- a/include/linux/aperture.h
+++ b/include/linux/aperture.h
@@ -14,7 +14,7 @@ int devm_aperture_acquire_for_platform_device(struct platform_device *pdev,
 					      resource_size_t size);
 
 int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t size,
-					bool primary, const char *name);
+					const char *name);
 
 int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name);
 #else
@@ -26,7 +26,7 @@ static inline int devm_aperture_acquire_for_platform_device(struct platform_devi
 }
 
 static inline int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t size,
-						      bool primary, const char *name)
+						      const char *name)
 {
 	return 0;
 }
@@ -39,7 +39,6 @@ static inline int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
 
 /**
  * aperture_remove_all_conflicting_devices - remove all existing framebuffers
- * @primary: also kick vga16fb if present; only relevant for VGA devices
  * @name: a descriptive name of the requesting driver
  *
  * This function removes all graphics device drivers. Use this function on systems
@@ -48,9 +47,9 @@ static inline int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
  * Returns:
  * 0 on success, or a negative errno code otherwise
  */
-static inline int aperture_remove_all_conflicting_devices(bool primary, const char *name)
+static inline int aperture_remove_all_conflicting_devices(const char *name)
 {
-	return aperture_remove_conflicting_devices(0, (resource_size_t)-1, primary, name);
+	return aperture_remove_conflicting_devices(0, (resource_size_t)-1, name);
 }
 
 #endif
-- 
2.40.0

