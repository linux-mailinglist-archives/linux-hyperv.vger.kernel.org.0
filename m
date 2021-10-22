Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62C04377E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Oct 2021 15:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJVNa5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Oct 2021 09:30:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55388 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhJVNaw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Oct 2021 09:30:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D26321983;
        Fri, 22 Oct 2021 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634909313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1egcDJYU3bQO2P2QpH+ZMeZ9e+pt8zaA3Pt5lZa8ls=;
        b=hSBIcbJruHpA4UIlg7EC6diAnXO3aPWcYLh+xMSX1NaitCxafBPyKQvlsjfM2paV6yAHIM
        D0nHMRGMOKJ+/nJJhLcvX7RTqmDlcWjQtcOHK+EppwNnuPI35Mdz+p6nMzQWaqCS3OBKvo
        sosFQLwZqT+1srw440ToZtmFbsIggw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634909313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1egcDJYU3bQO2P2QpH+ZMeZ9e+pt8zaA3Pt5lZa8ls=;
        b=TnIQYKCMDi9tovcx2dgU+ZB9rxn+RhLETwpHAsnkBshw74ypyAE87NLwiaJ57CahmU3KoO
        nc6U+yEhUHoDQAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AF3913CDA;
        Fri, 22 Oct 2021 13:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KGJjDYG8cmEwXgAAMHmgww
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
Subject: [PATCH 6/9] drm/fb-helper: Allocate shadow buffer of surface height
Date:   Fri, 22 Oct 2021 15:28:26 +0200
Message-Id: <20211022132829.7697-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022132829.7697-1-tzimmermann@suse.de>
References: <20211022132829.7697-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Allocating a shadow buffer of the height of the buffer object does
not support fbdev overallocation. Use surface height instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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
2.33.0

