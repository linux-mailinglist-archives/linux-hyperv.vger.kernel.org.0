Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2174B441C57
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Nov 2021 15:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhKAOSJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Nov 2021 10:18:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55284 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhKAOSI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Nov 2021 10:18:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64A7521968;
        Mon,  1 Nov 2021 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635776134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/seFr1pSoZVWTIFnRFMS/if3C+COfJP/xmAo3iraymA=;
        b=mLWwfKmplbbb5kHtx5ZBiF4CGoyNs1aIKoLlNxi1TV9ALRCNdCOTClN4yb5Y87MsAC5q9u
        QsTKS++peHMCqsvzmwqbTmHPkqk1+L9HXgVkvdGeNhXPJ9dsFOQSzl5Pa1z2eDZHLSPD11
        ayeP9K5oOgy4AeDi2PzvlVMSQO2HTuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635776134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/seFr1pSoZVWTIFnRFMS/if3C+COfJP/xmAo3iraymA=;
        b=8KhsvF+FeQz78jnPHl2Fep85FsZ/BlMeeJ70WDaVOCgrIKkZs5qKWZTg+PrRtyLYAaZCz1
        qfYY0olZ4hS9VxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 015B8139FD;
        Mon,  1 Nov 2021 14:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GNrwOoX2f2GlHwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:33 +0000
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
Subject: [PATCH v2 1/9] drm/format-helper: Export drm_fb_clip_offset()
Date:   Mon,  1 Nov 2021 15:15:24 +0100
Message-Id: <20211101141532.26655-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101141532.26655-1-tzimmermann@suse.de>
References: <20211101141532.26655-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Provide a function that computes the offset into a blit destination
buffer. This will allow to move destination-buffer clipping into the
format-helper callers.

v2:
	* provide documentation (Sam)
	* return 'unsigned int' (Sam, Noralf)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c | 19 +++++++++++++++++--
 include/drm/drm_format_helper.h     |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 69fde60e36b3..677e62e39f72 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -17,12 +17,27 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
-static unsigned int clip_offset(struct drm_rect *clip,
-				unsigned int pitch, unsigned int cpp)
+static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
 {
 	return clip->y1 * pitch + clip->x1 * cpp;
 }
 
+/**
+ * drm_fb_clip_offset - Returns the clipping rectangles byte-offset in a frambuffer
+ * pitch: Frambuffer line pitch in byte
+ * format: Frambuffer format
+ * clip: Clip rectangle
+ *
+ * Returns:
+ * The byte offset of the clip rectangle's top-left corner within the framebuffer.
+ */
+unsigned int drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				const struct drm_rect *clip)
+{
+	return clip_offset(clip, pitch, format->cpp[0]);
+}
+EXPORT_SYMBOL(drm_fb_clip_offset);
+
 /**
  * drm_fb_memcpy - Copy clip buffer
  * @dst: Destination buffer
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index e86925cf07b9..f5a8b334b18d 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -6,9 +6,13 @@
 #ifndef __LINUX_DRM_FORMAT_HELPER_H
 #define __LINUX_DRM_FORMAT_HELPER_H
 
+struct drm_format_info;
 struct drm_framebuffer;
 struct drm_rect;
 
+unsigned int drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				const struct drm_rect *clip);
+
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
 void drm_fb_memcpy_dstclip(void __iomem *dst, unsigned int dst_pitch, void *vaddr,
-- 
2.33.1

