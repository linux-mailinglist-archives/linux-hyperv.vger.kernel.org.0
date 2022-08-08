Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9458C8C6
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiHHMy3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243136AbiHHMyQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 08:54:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA08E0D2
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 05:54:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4DF120151;
        Mon,  8 Aug 2022 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659963252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFXqeXMCjOIzRuAW0efdzTsJGAtE6HoIZolFGg9ljp4=;
        b=dYbqAGXCsweRAl/b9d+bzfpxghXv3IGVq2SbdafHZIYiG56QzU/eYWGY5TnkwG/lXhNUyk
        aTR4uyeQ7wW4dP/Kk2UGdgY6YCTWVxvi3UD0RPu2C4sVbcIdpzbHAnxkXkZ+29vBDtO4Cj
        tGTklpWOIH/Jn4k+hVG0yp/3M/ph9Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659963252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFXqeXMCjOIzRuAW0efdzTsJGAtE6HoIZolFGg9ljp4=;
        b=0TzwT1kf1deleVIMPdYdo/SPS6FFnmyoQgiD4M/kb4m4JoDaJeUGNt401hIgVvhBNIrHmf
        1KhMUzN6E4PqY3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6783613A7C;
        Mon,  8 Aug 2022 12:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eL8yGHQH8WLHUgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:12 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 11/14] drm/format-helper: Rework XRGB8888-to-GRAY8 conversion
Date:   Mon,  8 Aug 2022 14:54:03 +0200
Message-Id: <20220808125406.20752-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125406.20752-1-tzimmermann@suse.de>
References: <20220808125406.20752-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Update XRGB8888-to-GRAY8 conversion to support struct iosys_map
and convert all users. Although these are single-plane color formats,
the new interface supports multi-plane formats for consistency with
drm_fb_blit().

v2:
	* update documentation (Sam)
	* add TODO on vaddr location (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/drm_format_helper.c | 46 +++++++++++++++++++++--------
 drivers/gpu/drm/gud/gud_pipe.c      |  7 +++--
 drivers/gpu/drm/tiny/st7586.c       |  5 +++-
 include/drm/drm_format_helper.h     |  5 ++--
 4 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 795d845c7e53..890370c0424f 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -613,25 +613,47 @@ static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, unsigned
 
 /**
  * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
- * @dst: 8-bit grayscale destination buffer
- * @dst_pitch: Number of bytes between two consecutive scanlines within dst
- * @vaddr: XRGB8888 source buffer
+ * @dst: Array of 8-bit grayscale destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @vmap: Array of XRGB8888 source buffers
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
- * Drm doesn't have native monochrome or grayscale support.
- * Such drivers can announce the commonly supported XR24 format to userspace
- * and use this function to convert to the native format.
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. Destination and framebuffer formats must match. The
+ * parameters @dst, @dst_pitch and @vmap refer to arrays. Each array must have at
+ * least as many entries as there are planes in @fb's format. Each entry stores the
+ * value for the format's respective color plane at the same index.
  *
- * Monochrome drivers will use the most significant bit,
- * where 1 means foreground color and 0 background color.
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
  *
- * ITU BT.601 is used for the RGB -> luma (brightness) conversion.
+ * DRM doesn't have native monochrome or grayscale support. Drivers can use this
+ * function for grayscale devices that don't support XRGB8888 natively.Such
+ * drivers can announce the commonly supported XR24 format to userspace and use
+ * this function to convert to the native format. Monochrome drivers will use the
+ * most significant bit, where 1 means foreground color and 0 background color.
+ * ITU BT.601 is being used for the RGB -> luma (brightness) conversion.
  */
-void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
-			      const struct drm_framebuffer *fb, const struct drm_rect *clip)
+void drm_fb_xrgb8888_to_gray8(struct iosys_map *dst, const unsigned int *dst_pitch,
+			      const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+			      const struct drm_rect *clip)
 {
-	drm_fb_xfrm(dst, dst_pitch, 1, vaddr, fb, clip, false, drm_fb_xrgb8888_to_gray8_line);
+	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+		0, 0, 0, 0
+	};
+
+	if (!dst_pitch)
+		dst_pitch = default_dst_pitch;
+
+	/* TODO: handle vmap in I/O memory here */
+	if (dst[0].is_iomem)
+		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 1, vmap[0].vaddr, fb,
+				 clip, false, drm_fb_xrgb8888_to_gray8_line);
+	else
+		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 1, vmap[0].vaddr, fb,
+			    clip, false, drm_fb_xrgb8888_to_gray8_line);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
 
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 0caa228f736d..7c6dc2bcd14a 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -59,6 +59,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
 	unsigned int bits_per_pixel = 8 / block_width;
 	unsigned int x, y, width, height;
 	u8 pix, *pix8, *block = dst; /* Assign to silence compiler warning */
+	struct iosys_map dst_map, vmap;
 	size_t len;
 	void *buf;
 
@@ -74,7 +75,9 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
 	if (!buf)
 		return 0;
 
-	drm_fb_xrgb8888_to_gray8(buf, 0, src, fb, rect);
+	iosys_map_set_vaddr(&dst_map, buf);
+	iosys_map_set_vaddr(&vmap, src);
+	drm_fb_xrgb8888_to_gray8(&dst_map, NULL, &vmap, fb, rect);
 	pix8 = buf;
 
 	for (y = 0; y < height; y++) {
@@ -194,7 +197,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
 				goto end_cpu_access;
 			}
 		} else if (format->format == DRM_FORMAT_R8) {
-			drm_fb_xrgb8888_to_gray8(buf, 0, vaddr, fb, rect);
+			drm_fb_xrgb8888_to_gray8(&dst, NULL, map_data, fb, rect);
 		} else if (format->format == DRM_FORMAT_RGB332) {
 			drm_fb_xrgb8888_to_rgb332(&dst, NULL, map_data, fb, rect);
 		} else if (format->format == DRM_FORMAT_RGB565) {
diff --git a/drivers/gpu/drm/tiny/st7586.c b/drivers/gpu/drm/tiny/st7586.c
index 94f55fac4295..b6f620b902e6 100644
--- a/drivers/gpu/drm/tiny/st7586.c
+++ b/drivers/gpu/drm/tiny/st7586.c
@@ -69,12 +69,15 @@ static void st7586_xrgb8888_to_gray332(u8 *dst, void *vaddr,
 	size_t len = (clip->x2 - clip->x1) * (clip->y2 - clip->y1);
 	unsigned int x, y;
 	u8 *src, *buf, val;
+	struct iosys_map dst_map, vmap;
 
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		return;
 
-	drm_fb_xrgb8888_to_gray8(buf, 0, vaddr, fb, clip);
+	iosys_map_set_vaddr(&dst_map, buf);
+	iosys_map_set_vaddr(&vmap, vaddr);
+	drm_fb_xrgb8888_to_gray8(&dst_map, NULL, &vmap, fb, clip);
 	src = buf;
 
 	for (y = clip->y1; y < clip->y2; y++) {
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 6807440ce29c..68087c982497 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -32,8 +32,9 @@ void drm_fb_xrgb8888_to_rgb888(struct iosys_map *dst, const unsigned int *dst_pi
 void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *dst_pitch,
 				    const struct iosys_map *vmap, const struct drm_framebuffer *fb,
 				    const struct drm_rect *clip);
-void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
-			      const struct drm_framebuffer *fb, const struct drm_rect *clip);
+void drm_fb_xrgb8888_to_gray8(struct iosys_map *dst, const unsigned int *dst_pitch,
+			      const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+			      const struct drm_rect *clip);
 
 int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t dst_format,
 		const struct iosys_map *vmap, const struct drm_framebuffer *fb,
-- 
2.37.1

