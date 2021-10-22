Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA804377DF
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Oct 2021 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJVNaw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Oct 2021 09:30:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55302 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhJVNat (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Oct 2021 09:30:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C3E82197C;
        Fri, 22 Oct 2021 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634909311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE48KuvIr0Z40dG14w+FVdTBhZyIJzox7nceTdSqCgU=;
        b=jdlj80Ia3bn3pIcCkQqDV1l+NtlaQTsbWrrjZListg8vCGmWQG/fi6nom4upIGuqBzkaWT
        OQjPuOmntSsLXLuj4+63b7apR5AKGewQbAQed10tgx1u1ahA/GfA0Oo6tbLl3c5tXfzKgM
        O2oREFUUjIAkWagpDY+8EbDCgEJ2+QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634909311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE48KuvIr0Z40dG14w+FVdTBhZyIJzox7nceTdSqCgU=;
        b=NuoFacvHeA39C5SYK8o3DiXSujXGaZM7N6KTNioeaKI3j+irDi+qIVuVn9Fn0Fu6XujZ8v
        c1Mdgf5U5I4mJDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB6DF13E7E;
        Fri, 22 Oct 2021 13:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uK9fOH68cmEwXgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 22 Oct 2021 13:28:30 +0000
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
Subject: [PATCH 1/9] drm/format-helper: Export drm_fb_clip_offset()
Date:   Fri, 22 Oct 2021 15:28:21 +0200
Message-Id: <20211022132829.7697-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022132829.7697-1-tzimmermann@suse.de>
References: <20211022132829.7697-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Provide a function that computes the offset into a blit destination
buffer. This will allow to move destination-buffer clipping into the
format-helper callers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c | 10 ++++++++--
 include/drm/drm_format_helper.h     |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 69fde60e36b3..28e9d0d89270 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -17,12 +17,18 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
-static unsigned int clip_offset(struct drm_rect *clip,
-				unsigned int pitch, unsigned int cpp)
+static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
 {
 	return clip->y1 * pitch + clip->x1 * cpp;
 }
 
+unsigned long drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				 const struct drm_rect *clip)
+{
+	return clip_offset(clip, pitch, format->cpp[0]);
+}
+EXPORT_SYMBOL(drm_fb_clip_offset);
+
 /**
  * drm_fb_memcpy - Copy clip buffer
  * @dst: Destination buffer
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index e86925cf07b9..90b9bd9ecb83 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -6,9 +6,13 @@
 #ifndef __LINUX_DRM_FORMAT_HELPER_H
 #define __LINUX_DRM_FORMAT_HELPER_H
 
+struct drm_format_info;
 struct drm_framebuffer;
 struct drm_rect;
 
+unsigned long drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				 const struct drm_rect *clip);
+
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
 void drm_fb_memcpy_dstclip(void __iomem *dst, unsigned int dst_pitch, void *vaddr,
-- 
2.33.0

