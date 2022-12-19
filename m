Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E530650FAF
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiLSQFb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiLSQFX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B542DE3;
        Mon, 19 Dec 2022 08:05:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38E023814A;
        Mon, 19 Dec 2022 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqquY0vRF4j2TZClbWT3UuEK0xCY+Dj3YMKH6n7ha14=;
        b=1oqZO6f7Z/UK84n1HDTBt6BQhym72ZyWuk2ESMExKZbV8MO0N7rtVzJ880pZ0h6s477vjm
        f9tqz07CfPWKgPKXZ9ychqFwzTUaKY2zhWShDBXxPZ836suqvL/KOpUsA00a2nmsiIu5Ql
        xeA4F2VVY2hIft7Hu7z5lm10b9phdhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqquY0vRF4j2TZClbWT3UuEK0xCY+Dj3YMKH6n7ha14=;
        b=1ANZjnO6UjrMzIpnHT3KrA22LyztidJt0BlWk2ZQ5LJVf4lyUGmVU4NfBdvaaZnfa8RMRW
        0zl4uWZWKK6zEKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 025F113910;
        Mon, 19 Dec 2022 16:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CCZGO8CLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:20 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 11/18] fbdev/efifb: Do not use struct fb_info.apertures
Date:   Mon, 19 Dec 2022 17:05:09 +0100
Message-Id: <20221219160516.23436-12-tzimmermann@suse.de>
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
 drivers/video/fbdev/efifb.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 694013f62781..a5779fb453a2 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/aperture.h>
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/efi-bgrt.h>
@@ -51,6 +52,8 @@ static struct pci_dev *efifb_pci_dev;	/* dev with BAR covering the efifb */
 
 struct efifb_par {
 	u32 pseudo_palette[16];
+	resource_size_t base;
+	resource_size_t size;
 };
 
 static struct fb_var_screeninfo efifb_defined = {
@@ -253,6 +256,8 @@ static inline void efifb_show_boot_graphics(struct fb_info *info) {}
  */
 static void efifb_destroy(struct fb_info *info)
 {
+	struct efifb_par *par = info->par;
+
 	if (efifb_pci_dev)
 		pm_runtime_put(&efifb_pci_dev->dev);
 
@@ -264,8 +269,7 @@ static void efifb_destroy(struct fb_info *info)
 	}
 
 	if (request_mem_succeeded)
-		release_mem_region(info->apertures->ranges[0].base,
-				   info->apertures->ranges[0].size);
+		release_mem_region(par->base, par->size);
 	fb_dealloc_cmap(&info->cmap);
 
 	framebuffer_release(info);
@@ -461,13 +465,8 @@ static int efifb_probe(struct platform_device *dev)
 	par = info->par;
 	info->pseudo_palette = par->pseudo_palette;
 
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures) {
-		err = -ENOMEM;
-		goto err_release_fb;
-	}
-	info->apertures->ranges[0].base = efifb_fix.smem_start;
-	info->apertures->ranges[0].size = size_remap;
+	par->base = efifb_fix.smem_start;
+	par->size = size_remap;
 
 	if (efi_enabled(EFI_MEMMAP) &&
 	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
@@ -556,7 +555,7 @@ static int efifb_probe(struct platform_device *dev)
 	info->fbops = &efifb_ops;
 	info->var = efifb_defined;
 	info->fix = efifb_fix;
-	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
+	info->flags = FBINFO_FLAG_DEFAULT;
 
 	orientation = drm_get_panel_orientation_quirk(efifb_defined.xres,
 						      efifb_defined.yres);
@@ -589,6 +588,11 @@ static int efifb_probe(struct platform_device *dev)
 	if (efifb_pci_dev)
 		WARN_ON(pm_runtime_get_sync(&efifb_pci_dev->dev) < 0);
 
+	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
+	if (err) {
+		pr_err("efifb: cannot acquire aperture\n");
+		goto err_put_rpm_ref;
+	}
 	err = register_framebuffer(info);
 	if (err < 0) {
 		pr_err("efifb: cannot register framebuffer\n");
-- 
2.39.0

