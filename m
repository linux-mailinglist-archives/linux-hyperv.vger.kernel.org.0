Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0C441C5C
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Nov 2021 15:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhKAOSL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Nov 2021 10:18:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48994 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAOSK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Nov 2021 10:18:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B16421FD76;
        Mon,  1 Nov 2021 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635776136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBHgiHuqCfBFiBqdtgPNsgJGdnZyaBZsccEznn1hKBw=;
        b=vTPQCSvaDymhoWdqZUf9JycsWNvnJ+4yt2kaq8479BmSP/MiDBlcHxKsvLAybhVrWChpv8
        6C41VZ3PoD+E91tT7LHMZfkBRKhahIOpw6GfY2Qygdv0QiahpKP9M1nTVdoxBHMC4V95u8
        8sg5ppjfHxUxvxF/W/mcAMrOp/+N7gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635776136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBHgiHuqCfBFiBqdtgPNsgJGdnZyaBZsccEznn1hKBw=;
        b=xVseMeQhipMaeYqAmPZ/ASRvHWLF0kDpYs08TmvIHc1aqbH+XmCguAJnGVMCju3bGe2F9x
        p8NxjJOCxPZAhvDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AE761342A;
        Mon,  1 Nov 2021 14:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHgoEYj2f2GlHwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:36 +0000
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
Subject: [PATCH v2 6/9] drm/fb-helper: Allocate shadow buffer of surface height
Date:   Mon,  1 Nov 2021 15:15:29 +0100
Message-Id: <20211101141532.26655-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101141532.26655-1-tzimmermann@suse.de>
References: <20211101141532.26655-1-tzimmermann@suse.de>
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

