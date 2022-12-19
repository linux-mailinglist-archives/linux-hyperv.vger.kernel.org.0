Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048F650FBB
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiLSQFi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLSQFZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC72BDB;
        Mon, 19 Dec 2022 08:05:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D43293814D;
        Mon, 19 Dec 2022 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7h0EXkUAVrRAP/PStW6XTr3++6xPsY6KDln6r0Rw7E=;
        b=u7ZYAWmY4Z+/LC6wlTezBTokc/XIEsHEjQ0W0RANZpeMnaZT6GB8YMAcYXr0BPDL7bvS4k
        s22o5XlBct47Iv4s8tcy2yfhv3zHzbqhQoxxkCRodTHaJfHYgYRtIbCq0z7lgLgd9RnnBc
        /a8jRAX7O8tgFDgmnQc2P2eBtggVyXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7h0EXkUAVrRAP/PStW6XTr3++6xPsY6KDln6r0Rw7E=;
        b=BJX4LNDRHzlZuDQdhKAJdNuaEUMNlnC8x6UTj+YQKrfJXdrFTqCnUrzFA23uDEl5GEt0la
        5U6oHMHbA4uvxZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E74313910;
        Mon, 19 Dec 2022 16:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cAPGJcKLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:22 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 18/18] drm/fbdev: Remove aperture handling and FBINFO_MISC_FIRMWARE
Date:   Mon, 19 Dec 2022 17:05:16 +0100
Message-Id: <20221219160516.23436-19-tzimmermann@suse.de>
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

There are no users left of struct fb_info.apertures and the flag
FBINFO_MISC_FIRMWARE. Remove both and the aperture-ownership code
in the fbdev core. All code for aperture ownership is now located
in the fbdev drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c   | 33 ------------------------------
 drivers/video/fbdev/core/fbsysfs.c |  1 -
 include/linux/fb.h                 | 22 --------------------
 3 files changed, 56 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 3a6c8458eb8d..02217c33d152 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -13,7 +13,6 @@
 
 #include <linux/module.h>
 
-#include <linux/aperture.h>
 #include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -1653,32 +1652,6 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	put_fb_info(fb_info);
 }
 
-static int fb_aperture_acquire_for_platform_device(struct fb_info *fb_info)
-{
-	struct apertures_struct *ap = fb_info->apertures;
-	struct device *dev = fb_info->device;
-	struct platform_device *pdev;
-	unsigned int i;
-	int ret;
-
-	if (!ap)
-		return 0;
-
-	if (!dev_is_platform(dev))
-		return 0;
-
-	pdev = to_platform_device(dev);
-
-	for (ret = 0, i = 0; i < ap->count; ++i) {
-		ret = devm_aperture_acquire_for_platform_device(pdev, ap->ranges[i].base,
-								ap->ranges[i].size);
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1693,12 +1666,6 @@ register_framebuffer(struct fb_info *fb_info)
 {
 	int ret;
 
-	if (fb_info->flags & FBINFO_MISC_FIRMWARE) {
-		ret = fb_aperture_acquire_for_platform_device(fb_info);
-		if (ret)
-			return ret;
-	}
-
 	mutex_lock(&registration_lock);
 	ret = do_register_framebuffer(fb_info);
 	mutex_unlock(&registration_lock);
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 4d7f63892dcc..0c33c4adcd79 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -88,7 +88,6 @@ void framebuffer_release(struct fb_info *info)
 	mutex_destroy(&info->bl_curve_mutex);
 #endif
 
-	kfree(info->apertures);
 	kfree(info);
 }
 EXPORT_SYMBOL(framebuffer_release);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 96b96323e9cb..30183fd259ae 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -423,8 +423,6 @@ struct fb_tile_ops {
  */
 #define FBINFO_MISC_ALWAYS_SETPAR   0x40000
 
-/* where the fb is a firmware driver, and can be replaced with a proper one */
-#define FBINFO_MISC_FIRMWARE        0x80000
 /*
  * Host and GPU endianness differ.
  */
@@ -499,30 +497,10 @@ struct fb_info {
 	void *fbcon_par;                /* fbcon use-only private area */
 	/* From here on everything is device dependent */
 	void *par;
-	/* we need the PCI or similar aperture base/size not
-	   smem_start/size as smem_start may just be an object
-	   allocated inside the aperture so may not actually overlap */
-	struct apertures_struct {
-		unsigned int count;
-		struct aperture {
-			resource_size_t base;
-			resource_size_t size;
-		} ranges[0];
-	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
 };
 
-static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-	struct apertures_struct *a;
-
-	a = kzalloc(struct_size(a, ranges, max_num), GFP_KERNEL);
-	if (!a)
-		return NULL;
-	a->count = max_num;
-	return a;
-}
-
 #define FBINFO_FLAG_DEFAULT	FBINFO_DEFAULT
 
 /* This will go away
-- 
2.39.0

