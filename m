Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DC650FBE
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiLSQFh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiLSQFY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF36FDE93;
        Mon, 19 Dec 2022 08:05:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62A4D6106B;
        Mon, 19 Dec 2022 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA3a5UCvu+T6cGVUv2fP+uAA75vjFZc4XwLIqHS7zss=;
        b=FNwQicw5ASnAz1j2lbGQUHsL358NMsllfeHdZm5DLNhxsOLY9lu9Stw1PHBh0VJEbxCH1Q
        nxik6kB49QPVBopQkOiTnZRRAtP+zVFL95RKZjlqvpGDbpGdOYoMCMzR8ySAhy14H0L4Ee
        /J0OXjgcfHGKJYvXOvi43e3h8hTsqbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA3a5UCvu+T6cGVUv2fP+uAA75vjFZc4XwLIqHS7zss=;
        b=2GyFGQ6UIYjZ/0fswPwJCnbqyO1wiWiMMEIGx6DNWI5pWAT1nZ+lopSVkSzPsJF0sPeBYi
        5hx2jNvDMjFsEyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BD7913910;
        Mon, 19 Dec 2022 16:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJrdCcKLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:22 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 16/18] fbdev/vesafb: Do not use struct fb_info.apertures
Date:   Mon, 19 Dec 2022 17:05:14 +0100
Message-Id: <20221219160516.23436-17-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219160516.23436-1-tzimmermann@suse.de>
References: <20221219160516.23436-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Acquire ownership of the firmware scanout buffer by calling Linux'
aperture helpers. Remove the use of struct fb_info.apertures and do
not set FBINFO_MISC_FIRMWARE; both of which previously configured
buffer ownership.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/vesafb.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index 47ce244e4bb8..3f8bdfcf51f0 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -9,6 +9,7 @@
  *
  */
 
+#include <linux/aperture.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -31,6 +32,8 @@
 
 struct vesafb_par {
 	u32 pseudo_palette[256];
+	resource_size_t base;
+	resource_size_t size;
 	int wc_cookie;
 	struct resource *region;
 };
@@ -191,7 +194,7 @@ static void vesafb_destroy(struct fb_info *info)
 	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
+	release_mem_region(par->base, par->size);
 
 	framebuffer_release(info);
 }
@@ -316,14 +319,8 @@ static int vesafb_probe(struct platform_device *dev)
 	par = info->par;
 	info->pseudo_palette = par->pseudo_palette;
 
-	/* set vesafb aperture size for generic probing */
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures) {
-		err = -ENOMEM;
-		goto err;
-	}
-	info->apertures->ranges[0].base = screen_info.lfb_base;
-	info->apertures->ranges[0].size = size_total;
+	par->base = screen_info.lfb_base;
+	par->size = size_total;
 
 	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel, vesafb_fix.line_length, screen_info.pages);
@@ -460,27 +457,29 @@ static int vesafb_probe(struct platform_device *dev)
 	info->fbops = &vesafb_ops;
 	info->var = vesafb_defined;
 	info->fix = vesafb_fix;
-	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE |
-		(ypan ? FBINFO_HWACCEL_YPAN : 0);
+	info->flags = FBINFO_FLAG_DEFAULT | (ypan ? FBINFO_HWACCEL_YPAN : 0);
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENOMEM;
 		goto err_release_region;
 	}
+	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
+	if (err)
+		goto err_fb_dealloc_cmap;
 	if (register_framebuffer(info)<0) {
 		err = -EINVAL;
-		fb_dealloc_cmap(&info->cmap);
-		goto err_release_region;
+		goto err_fb_dealloc_cmap;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
+err_fb_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
 err_release_region:
 	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	if (par->region)
 		release_region(0x3c0, 32);
-err:
 	framebuffer_release(info);
 	release_mem_region(vesafb_fix.smem_start, size_total);
 	return err;
-- 
2.39.0

