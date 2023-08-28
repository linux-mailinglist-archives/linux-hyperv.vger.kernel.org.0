Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2B78B1B4
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 15:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjH1NWL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjH1NVn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 09:21:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C512F;
        Mon, 28 Aug 2023 06:21:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9FC2219FE;
        Mon, 28 Aug 2023 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693228896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KI96naemxlxXOb2TMpUxPDXZOCd9FJdycJdBrcM4B1w=;
        b=ikwGbibopFdXYekQhWmJu/fSNg+HTM0euU5ABmkG4VDbU+63C9ev5kJKMjctsqSYKQeWhd
        yFTRsuJ3voIE2Oft6qymCO0seCDhjAH5JUq+VCWQ1oohtmgXW9XRxpr/i+mTGZ7FMMk8YT
        ErfLfBXdB6iRB34HBfYx6jEEDix2UPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693228896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KI96naemxlxXOb2TMpUxPDXZOCd9FJdycJdBrcM4B1w=;
        b=pHuSdlTaTYkBgK4bRyXSM9DqZ6g+bFWWFc14KaIrKYUuDIfg5kyPRRSmhUHou6cku8VLVZ
        97BjJcqOJZ3cNNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4ED513A11;
        Mon, 28 Aug 2023 13:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AEcBK2Cf7GTyOAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 28 Aug 2023 13:21:36 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, sam@ravnborg.org,
        javierm@redhat.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 7/8] staging/fbtft: Initialize fb_op struct as static const
Date:   Mon, 28 Aug 2023 15:14:23 +0200
Message-ID: <20230828132131.29295-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828132131.29295-1-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
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

Replace dynamic allocation of the fb_ops instance with static
allocation. Initialize the fields at module-load time. The owner
field changes to THIS_MODULE, as in all other fbdev drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/staging/fbtft/fbtft-core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index eac1d570f437..e4a77a4e7be6 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -473,6 +473,18 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
 	return ret;
 }
 
+static const struct fb_ops fbtft_ops = {
+	.owner        = THIS_MODULE;
+	.fb_read      = fb_sys_read;
+	.fb_write     = fbtft_fb_write;
+	.fb_fillrect  = fbtft_fb_fillrect;
+	.fb_copyarea  = fbtft_fb_copyarea;
+	.fb_imageblit = fbtft_fb_imageblit;
+	.fb_setcolreg = fbtft_fb_setcolreg;
+	.fb_blank     = fbtft_fb_blank;
+	.fb_mmap      = fb_deferred_io_mmap;
+};
+
 static void fbtft_merge_fbtftops(struct fbtft_ops *dst, struct fbtft_ops *src)
 {
 	if (src->write)
@@ -521,7 +533,6 @@ static void fbtft_merge_fbtftops(struct fbtft_ops *dst, struct fbtft_ops *src)
  * Creates a new frame buffer info structure.
  *
  * Also creates and populates the following structures:
- *   info->fbops
  *   info->fbdefio
  *   info->pseudo_palette
  *   par->fbtftops
@@ -536,7 +547,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 {
 	struct fb_info *info;
 	struct fbtft_par *par;
-	struct fb_ops *fbops = NULL;
 	struct fb_deferred_io *fbdefio = NULL;
 	u8 *vmem = NULL;
 	void *txbuf = NULL;
@@ -611,10 +621,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (!vmem)
 		goto alloc_fail;
 
-	fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);
-	if (!fbops)
-		goto alloc_fail;
-
 	fbdefio = devm_kzalloc(dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
 	if (!fbdefio)
 		goto alloc_fail;
@@ -638,19 +644,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 		goto alloc_fail;
 
 	info->screen_buffer = vmem;
-	info->fbops = fbops;
+	info->fbops = &fbtft_ops;
 	info->fbdefio = fbdefio;
 
-	fbops->owner        =      dev->driver->owner;
-	fbops->fb_read      =      fb_sys_read;
-	fbops->fb_write     =      fbtft_fb_write;
-	fbops->fb_fillrect  =      fbtft_fb_fillrect;
-	fbops->fb_copyarea  =      fbtft_fb_copyarea;
-	fbops->fb_imageblit =      fbtft_fb_imageblit;
-	fbops->fb_setcolreg =      fbtft_fb_setcolreg;
-	fbops->fb_blank     =      fbtft_fb_blank;
-	fbops->fb_mmap      =      fb_deferred_io_mmap;
-
 	fbdefio->delay =            HZ / fps;
 	fbdefio->sort_pagereflist = true;
 	fbdefio->deferred_io =      fbtft_deferred_io;
-- 
2.41.0

