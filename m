Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B221344BECF
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Nov 2021 11:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhKJKj4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Nov 2021 05:39:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34460 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhKJKjy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Nov 2021 05:39:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EC0B21B1F;
        Wed, 10 Nov 2021 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636540626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBHgiHuqCfBFiBqdtgPNsgJGdnZyaBZsccEznn1hKBw=;
        b=rf8ivSq1SHp46/kL25egK5q5pkVrxXL+tceKviPPSoyaES2RFJrmL5mGFDBHHprb+iJmf3
        GI9sf79+TbExAHaygp7GsZw1lJ7I0jfsmAHPBvzueuJt8jJcXjmbY+GKNRdwiZgscBlCq6
        K7B7T2nJDWfU9fQAjFHSbByHugoO/o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636540626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBHgiHuqCfBFiBqdtgPNsgJGdnZyaBZsccEznn1hKBw=;
        b=OwSyyupumV2ZJysBOrL4DXt/KXdf1kDttRQCcN5VAuKqRlYGS/xxgy0nf5FzO/qyXsiTd9
        crJ3Q8omiqAnaLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE9B113BEA;
        Wed, 10 Nov 2021 10:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WM4YOdGgi2EnPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 10 Nov 2021 10:37:05 +0000
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
Subject: [PATCH v3 6/9] drm/fb-helper: Allocate shadow buffer of surface height
Date:   Wed, 10 Nov 2021 11:36:59 +0100
Message-Id: <20211110103702.374-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110103702.374-1-tzimmermann@suse.de>
References: <20211110103702.374-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Allocating a shadow buffer of the height of the buffer object does
not support fbdev overallocation. Use surface height instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 8e7a124d6c5a..9727a59d35fd 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2338,7 +2338,7 @@ static int drm_fb_helper_generic_probe(struct drm_fb_helper *fb_helper,
 		return PTR_ERR(fbi);
 
 	fbi->fbops = &drm_fbdev_fb_ops;
-	fbi->screen_size = fb->height * fb->pitches[0];
+	fbi->screen_size = sizes->surface_height * fb->pitches[0];
 	fbi->fix.smem_len = fbi->screen_size;
 
 	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
-- 
2.33.1

