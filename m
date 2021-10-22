Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392D24377ED
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Oct 2021 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJVNbB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Oct 2021 09:31:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhJVNaw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Oct 2021 09:30:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 11FAA1FD60;
        Fri, 22 Oct 2021 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634909314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A15WdQC65kq41kCK0mYIBkfPHvThrjPCntu7z8A7dlM=;
        b=oingm/Sw3lSBkNMXOM31DaedqQeKyTN7tVHimc75URcwFxG/NY5gkHaxnJV+kkzEiRQGQi
        1NV4vdrspCEQNoPMTJxtW0zJH5Yj7lTyfaUy4FmBnX9zPAQiZL1tZW+BJAXVYs4wAImT1b
        5RR9HDhU/bIQXclJgDa2OfRXZrm/zQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634909314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A15WdQC65kq41kCK0mYIBkfPHvThrjPCntu7z8A7dlM=;
        b=kjNhry8+KE/CRxyGyECTq6Wf6L2hRGdOsHOqXCr8KNcKtyuYa3J3VaZPNI+hTvs+nJFbZg
        bwm84hmAX3WaraAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A36ED13CDA;
        Fri, 22 Oct 2021 13:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EMrgJoG8cmEwXgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 22 Oct 2021 13:28:33 +0000
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
Subject: [PATCH 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
Date:   Fri, 22 Oct 2021 15:28:27 +0200
Message-Id: <20211022132829.7697-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022132829.7697-1-tzimmermann@suse.de>
References: <20211022132829.7697-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Enable the FB_DAMAGE_CLIPS property to reduce display-update
overhead. Also fixes a warning in the kernel log.

  simple-framebuffer simple-framebuffer.0: [drm] drm_plane_enable_fb_damage_clips() not called

Fix the computation of the blit rectangle. This wasn't an issue so
far, as simpledrm always blitted the full framebuffer. The code now
supports damage clipping and virtual screen sizes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/simpledrm.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 571f716ff427..e872121e9fb0 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -642,7 +642,7 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
 	struct drm_device *dev = &sdev->dev;
 	void __iomem *dst = sdev->screen_base;
-	struct drm_rect clip;
+	struct drm_rect src_clip, dst_clip;
 	int idx;
 
 	if (!fb)
@@ -651,10 +651,14 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	if (!drm_dev_enter(dev, &idx))
 		return;
 
-	drm_rect_init(&clip, 0, 0, fb->width, fb->height);
+	drm_rect_fp_to_int(&src_clip, &plane_state->src);
 
-	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &clip);
-	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &clip);
+	dst_clip = plane_state->dst;
+	if (!drm_rect_intersect(&dst_clip, &src_clip))
+		return;
+
+	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip);
+	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &src_clip);
 
 	drm_dev_exit(idx);
 }
@@ -686,20 +690,28 @@ simpledrm_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_device *dev = &sdev->dev;
 	void __iomem *dst = sdev->screen_base;
-	struct drm_rect clip;
+	struct drm_rect damage_clip, src_clip, dst_clip;
 	int idx;
 
 	if (!fb)
 		return;
 
-	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &clip))
+	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage_clip))
+		return;
+
+	drm_rect_fp_to_int(&src_clip, &plane_state->src);
+	if (!drm_rect_intersect(&src_clip, &damage_clip))
+		return;
+
+	dst_clip = plane_state->dst;
+	if (!drm_rect_intersect(&dst_clip, &src_clip))
 		return;
 
 	if (!drm_dev_enter(dev, &idx))
 		return;
 
-	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &clip);
-	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &clip);
+	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip);
+	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &src_clip);
 
 	drm_dev_exit(idx);
 }
@@ -794,6 +806,8 @@ static int simpledrm_device_init_modeset(struct simpledrm_device *sdev)
 	if (ret)
 		return ret;
 
+	drm_plane_enable_fb_damage_clips(&pipe->plane);
+
 	drm_mode_config_reset(dev);
 
 	return 0;
-- 
2.33.0

