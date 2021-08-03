Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75C73DEE7F
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhHCM7r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 08:59:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38756 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhHCM7q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 08:59:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E153200CD;
        Tue,  3 Aug 2021 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627995575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwMrprOEshldFA5MZJDSVCnYE/kuxkA8HL3ps9QmON8=;
        b=OBz8KvsLPi2UsZvLqdeC+Isrtp3T8zww3rq3X4Kruipr1RqlhtDkQO+0Oyq6A4PjyqmN+h
        4jiO01/e+PSIxDtsdn4q/epnxZXftVOM6Ul8eBd/TMfdrDIztmQWwM1MwagUXEiHqB1Ewc
        3PMZoIBvvLB4bR+Cv1bJqO6L083IUt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627995575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwMrprOEshldFA5MZJDSVCnYE/kuxkA8HL3ps9QmON8=;
        b=eNyKwYY2AcoRszMzwCSJAw0O8/EKhXnozHeNf2d8AGXgXJOEIUmvv+L0EbYZa9iAEzgami
        x8rOpkU+OiWLCnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C6A513CEF;
        Tue,  3 Aug 2021 12:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wK7oILY9CWExZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 03 Aug 2021 12:59:34 +0000
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
Subject: [PATCH 08/11] drm/simpledrm: Use offset-adjusted shadow-plane mapping
Date:   Tue,  3 Aug 2021 14:59:25 +0200
Message-Id: <20210803125928.27780-9-tzimmermann@suse.de>
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
simpledrm.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/simpledrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 08ae66b1e6f5..481b48bde047 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -639,7 +639,7 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	struct simpledrm_device *sdev = simpledrm_device_of_dev(pipe->crtc.dev);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	void *vmap = shadow_plane_state->map[0].vaddr; /* TODO: Use mapping abstraction properly */
+	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
 	struct drm_device *dev = &sdev->dev;
 	int idx;
 
@@ -677,7 +677,7 @@ simpledrm_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct simpledrm_device *sdev = simpledrm_device_of_dev(pipe->crtc.dev);
 	struct drm_plane_state *plane_state = pipe->plane.state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	void *vmap = shadow_plane_state->map[0].vaddr; /* TODO: Use mapping abstraction properly */
+	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_device *dev = &sdev->dev;
 	struct drm_rect clip;
-- 
2.32.0

