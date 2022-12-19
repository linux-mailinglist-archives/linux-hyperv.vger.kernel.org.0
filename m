Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04E650FB2
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiLSQFc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiLSQFX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B851E60F7;
        Mon, 19 Dec 2022 08:05:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74E9F6106C;
        Mon, 19 Dec 2022 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaoy/wsHmACEkNUPQDwCodxxk7bv39KwEjjtHvnuLPY=;
        b=zwnnLeVgu/s3egNObkVdpEXh77/XY3MobzVV5GJI1gttTfIxX9W8Q+m9TprcXlLjjw5+zk
        eYu4mOF+QvFS83FmGpyu69FfHB3eEEm8yYax1itCD+SjBRqew7QTnHV/9t85tFIVD0Q/VT
        APbe3gfOruEA6qOqZIn72uYlYQfIdv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaoy/wsHmACEkNUPQDwCodxxk7bv39KwEjjtHvnuLPY=;
        b=kus+BY2vnPzmJQDjGCUVRzdQvBFM+NEu81vfD1mSWOqYl5qrrmEPyKieCOyRumTRUCMg+9
        UvJt4LdI4sHWxXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DD7913910;
        Mon, 19 Dec 2022 16:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SH0nDsGLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:21 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 12/18] fbdev/offb: Allocate struct offb_par with framebuffer_alloc()
Date:   Mon, 19 Dec 2022 17:05:10 +0100
Message-Id: <20221219160516.23436-13-tzimmermann@suse.de>
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

Move the palette array into struct offb_par and allocate both via
framebuffer_alloc(), as intended by fbdev. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/offb.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 91001990e351..a298adcee2d9 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -53,10 +53,9 @@ struct offb_par {
 	volatile void __iomem *cmap_data;
 	int cmap_type;
 	int blanked;
+	u32 pseudo_palette[16];
 };
 
-struct offb_par default_par;
-
 #ifdef CONFIG_PPC32
 extern boot_infos_t *boot_infos;
 #endif
@@ -393,11 +392,11 @@ static void offb_init_fb(struct platform_device *parent, const char *name,
 			 int foreign_endian, struct device_node *dp)
 {
 	unsigned long res_size = pitch * height;
-	struct offb_par *par = &default_par;
 	unsigned long res_start = address;
 	struct fb_fix_screeninfo *fix;
 	struct fb_var_screeninfo *var;
 	struct fb_info *info;
+	struct offb_par *par;
 
 	if (!request_mem_region(res_start, res_size, "offb"))
 		return;
@@ -411,17 +410,15 @@ static void offb_init_fb(struct platform_device *parent, const char *name,
 		return;
 	}
 
-	info = framebuffer_alloc(sizeof(u32) * 16, &parent->dev);
-
+	info = framebuffer_alloc(sizeof(*par), &parent->dev);
 	if (!info) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
 	platform_set_drvdata(parent, info);
-
+	par = info->par;
 	fix = &info->fix;
 	var = &info->var;
-	info->par = par;
 
 	if (name) {
 		strcpy(fix->id, "OFfb ");
@@ -515,7 +512,7 @@ static void offb_init_fb(struct platform_device *parent, const char *name,
 
 	info->fbops = &offb_ops;
 	info->screen_base = ioremap(address, fix->smem_len);
-	info->pseudo_palette = (void *) (info + 1);
+	info->pseudo_palette = par->pseudo_palette;
 	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE | foreign_endian;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
-- 
2.39.0

