Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30E3DEE78
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhHCM7o (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 08:59:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36498 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbhHCM7o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 08:59:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7374121FF4;
        Tue,  3 Aug 2021 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627995572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlP3QAVUEn0hR6MYhWt4oFDClq9E2sRt3OZfVbJvOyY=;
        b=xtmN1ccc+NuUUkAR5/v+u5oqKAm2V74qwTdvztPe3dI/dJfxmgKwX9aytxtJUOTIzgLYTp
        TbiPkKoXiU3anWviHy8OJWvK+Xq7QX/3q76gBIc0pNJZVW+K5ZEuOPtRubB4l4mj0Nuimk
        wcgZtFWBjViVHrOhUXnO52kzI9JZ2r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627995572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlP3QAVUEn0hR6MYhWt4oFDClq9E2sRt3OZfVbJvOyY=;
        b=JpziimiGPcM0Qgc/3/Di/FwbU40N1tmBXUzYUdO9pGoCSyH9bWlOSe1hgga2bx4WwWRY9Q
        jRO4gv1FNHtbJ+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 014AD13CEF;
        Tue,  3 Aug 2021 12:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QAywOrM9CWExZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 03 Aug 2021 12:59:31 +0000
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
Subject: [PATCH 03/11] drm/gud: Get offset-adjusted mapping from drm_gem_fb_vmap()
Date:   Tue,  3 Aug 2021 14:59:20 +0200
Message-Id: <20210803125928.27780-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803125928.27780-1-tzimmermann@suse.de>
References: <20210803125928.27780-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Pass the data parameter to drm_gem_fb_vmap() to retrieve pointers
to the data. This address is different from the mapping addresses
for framebuffers with non-zero offsets. Replaces gud's internal
computation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/gud/gud_pipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 6270a1a32a65..b9b0e435ea0f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -153,6 +153,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
 	struct dma_buf_attachment *import_attach = fb->obj[0]->import_attach;
 	u8 compression = gdrm->compression;
 	struct dma_buf_map map[DRM_FORMAT_MAX_PLANES];
+	struct dma_buf_map map_data[DRM_FORMAT_MAX_PLANES];
 	void *vaddr, *buf;
 	size_t pitch, len;
 	int ret = 0;
@@ -162,11 +163,11 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
 	if (len > gdrm->bulk_len)
 		return -E2BIG;
 
-	ret = drm_gem_fb_vmap(fb, map, NULL);
+	ret = drm_gem_fb_vmap(fb, map, map_data);
 	if (ret)
 		return ret;
 
-	vaddr = map[0].vaddr + fb->offsets[0];
+	vaddr = map_data[0].vaddr;
 
 	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
 	if (ret)
-- 
2.32.0

