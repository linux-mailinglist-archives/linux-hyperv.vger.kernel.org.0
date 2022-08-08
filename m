Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3232358C8BB
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiHHMyY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 08:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbiHHMyO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 08:54:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6172F5B9
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 05:54:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18C8C37ADC;
        Mon,  8 Aug 2022 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659963250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nKy/KcFmyLoe7VZEs7xE1xUNFmk0Tq60jicMOf63GE=;
        b=M5kXIg0KY3K1mXsK4x9HQPpIvzAr3MLcwzYOjVxD8yzqcOLBfLt08aCE7/QmEdiQVHRIMG
        6wudoAXmJkVMI8nnxedo9dlKmSDTyoJvpO3spjjybf4dCXpNbjTV0Ruemo536LHPDRrMKS
        QRPEpDGylJvT8chIxDd5WfqUnE5sB5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659963250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nKy/KcFmyLoe7VZEs7xE1xUNFmk0Tq60jicMOf63GE=;
        b=N/sSYRAX5HY9OezDaAjD7x3MuvSzptujhL9Jo06IyNtNvoCl06/86bLEnEdwsKxdJeeWVd
        yvKEQdJ347uB3jDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B65A713ADE;
        Mon,  8 Aug 2022 12:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iPg6K3EH8WLHUgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:09 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 04/14] drm/format-helper: Convert drm_fb_swab() to struct iosys_map
Date:   Mon,  8 Aug 2022 14:53:56 +0200
Message-Id: <20220808125406.20752-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125406.20752-1-tzimmermann@suse.de>
References: <20220808125406.20752-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Convert drm_fb_swab() to use struct iosys_map() and convert users. The
new interface supports multi-plane color formats, but implementation
only supports a single plane for now.

v2:
	* use drm_format_info_bpp() (Sam)
	* update documentation (Sam)
	* add TODO on vaddr location (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c | 53 +++++++++++++++++++++--------
 drivers/gpu/drm/drm_mipi_dbi.c      |  2 +-
 drivers/gpu/drm/gud/gud_pipe.c      |  2 +-
 include/drm/drm_format_helper.h     |  6 ++--
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 7489c665a47c..b5ed058984ae 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -205,37 +205,62 @@ static void drm_fb_swab32_line(void *dbuf, const void *sbuf, unsigned int pixels
 
 /**
  * drm_fb_swab - Swap bytes into clip buffer
- * @dst: Destination buffer
- * @dst_pitch: Number of bytes between two consecutive scanlines within dst
- * @src: Source buffer
+ * @dst: Array of destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @vmap: Array of source buffers
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  * @cached: Source buffer is mapped cached (eg. not write-combined)
  *
- * If @cached is false a temporary buffer is used to cache one pixel line at a
- * time to speed up slow uncached reads.
+ * This function copies parts of a framebuffer to display memory and swaps per-pixel
+ * bytes during the process. Destination and framebuffer formats must match. The
+ * parameters @dst, @dst_pitch and @vmap refer to arrays. Each array must have at
+ * least as many entries as there are planes in @fb's format. Each entry stores the
+ * value for the format's respective color plane at the same index. If @cached is
+ * false a temporary buffer is used to cache one pixel line at a time to speed up
+ * slow uncached reads.
  *
- * This function does not apply clipping on dst, i.e. the destination
- * is at the top-left corner.
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
  */
-void drm_fb_swab(void *dst, unsigned int dst_pitch, const void *src,
-		 const struct drm_framebuffer *fb, const struct drm_rect *clip,
-		 bool cached)
+void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
+		 const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+		 const struct drm_rect *clip, bool cached)
 {
-	u8 cpp = fb->format->cpp[0];
+	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+		0, 0, 0, 0
+	};
+	const struct drm_format_info *format = fb->format;
+	u8 cpp = DIV_ROUND_UP(drm_format_info_bpp(format, 0), 8);
+	void (*swab_line)(void *dbuf, const void *sbuf, unsigned int npixels);
 
 	switch (cpp) {
 	case 4:
-		drm_fb_xfrm(dst, dst_pitch, cpp, src, fb, clip, cached, drm_fb_swab32_line);
+		swab_line = drm_fb_swab32_line;
 		break;
 	case 2:
-		drm_fb_xfrm(dst, dst_pitch, cpp, src, fb, clip, cached, drm_fb_swab16_line);
+		swab_line = drm_fb_swab16_line;
 		break;
 	default:
 		drm_warn_once(fb->dev, "Format %p4cc has unsupported pixel size.\n",
-			      &fb->format->format);
+			      &format->format);
+		swab_line = NULL;
 		break;
 	}
+	if (!swab_line)
+		return;
+
+	if (!dst_pitch)
+		dst_pitch = default_dst_pitch;
+
+	/* TODO: handle vmap in I/O memory here */
+	if (dst->is_iomem)
+		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], cpp,
+				 vmap[0].vaddr, fb, clip, cached, swab_line);
+	else
+		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], cpp, vmap[0].vaddr, fb,
+			    clip, cached, swab_line);
 }
 EXPORT_SYMBOL(drm_fb_swab);
 
diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 1ba506ca83e1..a44b7d6ae06c 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -221,7 +221,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 	switch (fb->format->format) {
 	case DRM_FORMAT_RGB565:
 		if (swap)
-			drm_fb_swab(dst, 0, src, fb, clip, !gem->import_attach);
+			drm_fb_swab(&dst_map, NULL, data, fb, clip, !gem->import_attach);
 		else
 			drm_fb_memcpy(&dst_map, NULL, data, fb, clip);
 		break;
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 449c95a4aee0..a15cda9ba058 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -205,7 +205,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
 			len = gud_xrgb8888_to_color(buf, format, vaddr, fb, rect);
 		}
 	} else if (gud_is_big_endian() && format->cpp[0] > 1) {
-		drm_fb_swab(buf, 0, vaddr, fb, rect, !import_attach);
+		drm_fb_swab(&dst, NULL, map_data, fb, rect, !import_attach);
 	} else if (compression && !import_attach && pitch == fb->pitches[0]) {
 		/* can compress directly from the framebuffer */
 		buf = vaddr + rect->y1 * pitch;
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 8af6a2717bc9..60944feaa936 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -17,9 +17,9 @@ unsigned int drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info
 void drm_fb_memcpy(struct iosys_map *dst, const unsigned int *dst_pitch,
 		   const struct iosys_map *vmap, const struct drm_framebuffer *fb,
 		   const struct drm_rect *clip);
-void drm_fb_swab(void *dst, unsigned int dst_pitch, const void *src,
-		 const struct drm_framebuffer *fb, const struct drm_rect *clip,
-		 bool cached);
+void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
+		 const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+		 const struct drm_rect *clip, bool cached);
 void drm_fb_xrgb8888_to_rgb332(void *dst, unsigned int dst_pitch, const void *vaddr,
 			       const struct drm_framebuffer *fb, const struct drm_rect *clip);
 void drm_fb_xrgb8888_to_rgb565(void *dst, unsigned int dst_pitch, const void *vaddr,
-- 
2.37.1

