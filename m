Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118FF3DEE79
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhHCM7p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 08:59:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36544 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhHCM7o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 08:59:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED94022006;
        Tue,  3 Aug 2021 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627995572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkfSG7zQF2VJM8MQXyDlD++OQ/zbvQZJMOAde6kqDUw=;
        b=wBopeQ8e2CtQW4o1dYssecPv12TRs19eraDuwkwMRv2RNzTVyKb3FlrH7APRTAwer0Gfxw
        JcAWhgFboIMyOWMx4O9mBzqudyiyPHSbabMmFqDKF4KMO3TqYPxdI+p01Z8CQc5iE5sJjd
        LW+26jcGTcnQvJYR6dviSE+XyHHd2cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627995572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkfSG7zQF2VJM8MQXyDlD++OQ/zbvQZJMOAde6kqDUw=;
        b=DH8k5x1NMdLYul07lD2rye7FzQ8cCQKoBp8z1222PYBykfQvclXtferHDGOwti3ReWWHc3
        07tNoIvLTy5pm2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7983613CD6;
        Tue,  3 Aug 2021 12:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oLVgHLQ9CWExZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 03 Aug 2021 12:59:32 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        noralf@tronnes.org, drawat.floss@gmail.com, kraxel@redhat.com,
        hdegoede@redhat.com, sean@poorly.run,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 04/11] drm/hyperv: Use offset-adjusted shadow-plane mappings
Date:   Tue,  3 Aug 2021 14:59:21 +0200
Message-Id: <20210803125928.27780-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803125928.27780-1-tzimmermann@suse.de>
References: <20210803125928.27780-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For framebuffers with non-zero offset fields, shadow-plane helpers
provide a pointer to the first byte of the contained data. Use it in
hyperv.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 3aaee4730ec6..6dd4717d3e1e 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -105,7 +105,7 @@ static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
 				crtc_state->mode.hdisplay,
 				crtc_state->mode.vdisplay,
 				plane_state->fb->pitches[0]);
-	hyperv_blit_to_vram_fullscreen(plane_state->fb, &shadow_plane_state->map[0]);
+	hyperv_blit_to_vram_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
 }
 
 static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
@@ -133,7 +133,7 @@ static void hyperv_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_rect rect;
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
-		hyperv_blit_to_vram_rect(state->fb, &shadow_plane_state->map[0], &rect);
+		hyperv_blit_to_vram_rect(state->fb, &shadow_plane_state->data[0], &rect);
 		hyperv_update_dirt(hv->hdev, &rect);
 	}
 }
-- 
2.32.0

