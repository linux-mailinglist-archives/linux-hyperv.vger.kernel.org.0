Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD958C8BF
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiHHMy0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbiHHMyO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 08:54:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E60DFB9
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 05:54:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A9501FF77;
        Mon,  8 Aug 2022 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659963251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXya2P8aHc9k/Cq5sRA6agZRFksbUZ3N7PJvEMq7Ons=;
        b=qgEcbiMzfEuXD+ieNyWF23vAPJUEjAUVUh5mNO8J4yQXhcH4CJfwqvdmBKBmu2uQrnQ18N
        LV7cCx5cAsucxSgmSgWtWk9LbPvA9g/nKKnpTRc7JpFXrbQv/v0W+0CoLCz/E/SdnJ6M7c
        tvQiJlMObV5OB2O2Bo+URvPrGv4Y90w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659963251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXya2P8aHc9k/Cq5sRA6agZRFksbUZ3N7PJvEMq7Ons=;
        b=VK1I8528zA9G6JQTtQhprWwknHzJiE4Q+J4z9dydVRfOpXiovQ5PHpBYqvt6gI795vnprP
        yGt7SLOSzMTNLfCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D95613ADE;
        Mon,  8 Aug 2022 12:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EFgMDnMH8WLHUgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:11 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 08/14] drm/format-helper: Rework RGB565-to-XRGB8888 conversion
Date:   Mon,  8 Aug 2022 14:54:00 +0200
Message-Id: <20220808125406.20752-9-tzimmermann@suse.de>
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

Update RGB565-to-XRGB8888 conversion to support struct iosys_map
and convert all users. Although these are single-plane color formats,
the new interface supports multi-plane formats for consistency with
drm_fb_blit().

v2:
	* add TODO on vaddr location (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/drm_format_helper.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 3ee57dc8bcc5..b390d529afeb 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -478,12 +478,25 @@ static void drm_fb_rgb565_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigne
 	}
 }
 
-static void drm_fb_rgb565_to_xrgb8888_toio(void __iomem *dst, unsigned int dst_pitch,
-					   const void *vaddr, const struct drm_framebuffer *fb,
-					   const struct drm_rect *clip)
+static void drm_fb_rgb565_to_xrgb8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				      const struct iosys_map *vmap,
+				      const struct drm_framebuffer *fb,
+				      const struct drm_rect *clip)
 {
-	drm_fb_xfrm_toio(dst, dst_pitch, 4, vaddr, fb, clip, false,
-			 drm_fb_rgb565_to_xrgb8888_line);
+	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+		0, 0, 0, 0
+	};
+
+	if (!dst_pitch)
+		dst_pitch = default_dst_pitch;
+
+	/* TODO: handle vmap in I/O memory here */
+	if (dst[0].is_iomem)
+		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, fb,
+				 clip, false, drm_fb_rgb565_to_xrgb8888_line);
+	else
+		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
+			    clip, false, drm_fb_rgb565_to_xrgb8888_line);
 }
 
 static void drm_fb_rgb888_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
@@ -651,8 +664,7 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
 						       vmap[0].vaddr, fb, clip);
 			return 0;
 		} else if (fb_format == DRM_FORMAT_RGB565) {
-			drm_fb_rgb565_to_xrgb8888_toio(dst[0].vaddr_iomem, dst_pitch[0],
-						       vmap[0].vaddr, fb, clip);
+			drm_fb_rgb565_to_xrgb8888(dst, dst_pitch, vmap, fb, clip);
 			return 0;
 		}
 	} else if (dst_format == DRM_FORMAT_XRGB2101010) {
-- 
2.37.1

