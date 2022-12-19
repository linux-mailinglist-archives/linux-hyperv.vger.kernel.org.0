Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55933650FB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLSQFe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiLSQFY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124A10E6;
        Mon, 19 Dec 2022 08:05:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A86561070;
        Mon, 19 Dec 2022 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tODQtTMeTfmKegWRuyf0irbV/Qbn+oauEz8jBZiC7ks=;
        b=XpXjQRx/afBB9uzeaqHmLbQZsK0h0uK8PfVRDOwPtHMSnlzEzAXsh8+2aZmFXzLlZgRfi4
        LkiEm+eKrL7VSjXepbfTzWk7RikH1cmcfbSyzYQZpoRgH1lOK2D4DDdsbQEC7FAqf8FOXi
        WlKFj+y5xs6yqC43EiAaoWjsF3G2iFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tODQtTMeTfmKegWRuyf0irbV/Qbn+oauEz8jBZiC7ks=;
        b=w/EFAXWRWb+AjGEDlRJ7PJ13k1pIXyqXpAJi+uiD2/Eat9uBrrFWupWfUTlsKR17J2ZpVR
        UNulA9cvw7oIpjBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65D0313911;
        Mon, 19 Dec 2022 16:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oAgDGMKLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:22 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 17/18] fbdev/vga16fb: Do not use struct fb_info.apertures
Date:   Mon, 19 Dec 2022 17:05:15 +0100
Message-Id: <20221219160516.23436-18-tzimmermann@suse.de>
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
 drivers/video/fbdev/vga16fb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index af47f8217095..1a8ffdb2be26 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -10,6 +10,7 @@
  * archive for more details.
  */
 
+#include <linux/aperture.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -1324,11 +1325,6 @@ static int vga16fb_probe(struct platform_device *dev)
 		ret = -ENOMEM;
 		goto err_fb_alloc;
 	}
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures) {
-		ret = -ENOMEM;
-		goto err_ioremap;
-	}
 
 	/* XXX share VGA_FB_PHYS_BASE and I/O region with vgacon and others */
 	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS_BASE, 0);
@@ -1363,8 +1359,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	info->fix = vga16fb_fix;
 	/* supports rectangles with widths of multiples of 8 */
 	info->pixmap.blit_x = 1 << 7 | 1 << 15 | 1 << 23 | 1 << 31;
-	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE |
-		FBINFO_HWACCEL_YPAN;
+	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_HWACCEL_YPAN;
 
 	i = (info->var.bits_per_pixel == 8) ? 256 : 16;
 	ret = fb_alloc_cmap(&info->cmap, i, 0);
@@ -1382,9 +1377,9 @@ static int vga16fb_probe(struct platform_device *dev)
 
 	vga16fb_update_fix(info);
 
-	info->apertures->ranges[0].base = VGA_FB_PHYS_BASE;
-	info->apertures->ranges[0].size = VGA_FB_PHYS_SIZE;
-
+	ret = devm_aperture_acquire_for_platform_device(dev, VGA_FB_PHYS_BASE, VGA_FB_PHYS_SIZE);
+	if (ret)
+		goto err_check_var;
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
 		ret = -EINVAL;
-- 
2.39.0

