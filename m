Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F796441C5E
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Nov 2021 15:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhKAOSM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Nov 2021 10:18:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49066 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhKAOSL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Nov 2021 10:18:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93B2B1FD78;
        Mon,  1 Nov 2021 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635776137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yL9iUo+cpHCBnWyGlHHHPSxiHK+OVWp0KrZFxkiGU90=;
        b=efEtoZ2G9rgoTkKw2OTTxBJ6t5bpyv8hsZdZu5GUG+bbGevXP6EWolOHsMgtxpmIdE6fC0
        EEEfNLM3HSBqMYYsyITvrPbNou1q0SrecWaVRd0MRAZAkean/ZUxxmbNz4k9YgcZRcqO3U
        F6Cx11vEGG/PmfjqbKgvn9xf+S2EfI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635776137;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yL9iUo+cpHCBnWyGlHHHPSxiHK+OVWp0KrZFxkiGU90=;
        b=140EXOse9yf2CQEbTdtMD42oaH/2VxBKzbUPN3zOjsDMrNS7HIX1sp2STJHJj3578vw98n
        ovnBk0Hyoc7MgeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CB9C1342A;
        Mon,  1 Nov 2021 14:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2EbcCYn2f2GlHwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:37 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
        drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
        david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
        kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
        michael+lkml@stapelberg.ch, aros@gmx.com,
        joshua@stroblindustries.com, arnd@arndb.de
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 8/9] drm/simpledrm: Support virtual screen sizes
Date:   Mon,  1 Nov 2021 15:15:31 +0100
Message-Id: <20211101141532.26655-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101141532.26655-1-tzimmermann@suse.de>
References: <20211101141532.26655-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add constants for the maximum size of the shadow-plane surface
size. Useful for shadow planes with virtual screen sizes. The
current sizes are 4096 scanlines with 4096 pixels each. This
seems reasonable for current hardware, but can be increased as
necessary.

In simpledrm, set the maximum framebuffer size from the constants
for shadow planes. Implements support for virtual screen sizes and
page flipping on the fbdev console.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/simpledrm.c    |  9 +++++++--
 include/drm/drm_gem_atomic_helper.h | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index e872121e9fb0..e42ae1c6ebcd 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -2,6 +2,7 @@
 
 #include <linux/clk.h>
 #include <linux/of_clk.h>
+#include <linux/minmax.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
@@ -776,6 +777,7 @@ static int simpledrm_device_init_modeset(struct simpledrm_device *sdev)
 	struct drm_display_mode *mode = &sdev->mode;
 	struct drm_connector *connector = &sdev->connector;
 	struct drm_simple_display_pipe *pipe = &sdev->pipe;
+	unsigned long max_width, max_height;
 	const uint32_t *formats;
 	size_t nformats;
 	int ret;
@@ -784,10 +786,13 @@ static int simpledrm_device_init_modeset(struct simpledrm_device *sdev)
 	if (ret)
 		return ret;
 
+	max_width = max_t(unsigned long, mode->hdisplay, DRM_SHADOW_PLANE_MAX_WIDTH);
+	max_height = max_t(unsigned long, mode->vdisplay, DRM_SHADOW_PLANE_MAX_HEIGHT);
+
 	dev->mode_config.min_width = mode->hdisplay;
-	dev->mode_config.max_width = mode->hdisplay;
+	dev->mode_config.max_width = max_width;
 	dev->mode_config.min_height = mode->vdisplay;
-	dev->mode_config.max_height = mode->vdisplay;
+	dev->mode_config.max_height = max_height;
 	dev->mode_config.prefer_shadow_fbdev = true;
 	dev->mode_config.preferred_depth = sdev->format->cpp[0] * 8;
 	dev->mode_config.funcs = &simpledrm_mode_config_funcs;
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 48222a107873..54983ecf641a 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -22,6 +22,24 @@ int drm_gem_simple_display_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
  * Helpers for planes with shadow buffers
  */
 
+/**
+ * DRM_SHADOW_PLANE_MAX_WIDTH - Maximum width of a plane's shadow buffer in pixels
+ *
+ * For drivers with shadow planes, the maximum width of the framebuffer is
+ * usually independent from hardware limitations. Drivers can initialize struct
+ * drm_mode_config.max_width from DRM_SHADOW_PLANE_MAX_WIDTH.
+ */
+#define DRM_SHADOW_PLANE_MAX_WIDTH	(1ul << 12)
+
+/**
+ * DRM_SHADOW_PLANE_MAX_HEIGHT - Maximum height of a plane's shadow buffer in scanlines
+ *
+ * For drivers with shadow planes, the maximum height of the framebuffer is
+ * usually independent from hardware limitations. Drivers can initialize struct
+ * drm_mode_config.max_height from DRM_SHADOW_PLANE_MAX_HEIGHT.
+ */
+#define DRM_SHADOW_PLANE_MAX_HEIGHT	(1ul << 12)
+
 /**
  * struct drm_shadow_plane_state - plane state for planes with shadow buffers
  *
-- 
2.33.1

