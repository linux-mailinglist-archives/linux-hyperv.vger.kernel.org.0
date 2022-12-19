Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0485A650FA2
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiLSQF1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiLSQFV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D76468;
        Mon, 19 Dec 2022 08:05:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0149F61068;
        Mon, 19 Dec 2022 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkPYodRrthK0KDBelPZoq1tuzpwIojBeCxchBxVgzPA=;
        b=ro9yZlUCx8QuAlERVeZyPJN9g9OhhaxO5d7ESIL3UsPNdGw0kCGUMtPWMIquXrs5/Zq79Y
        snMbSHLsZdDUKR3/Yw5wwcbpWOxxWa4CtqtesA/JV3XokIgEgYifcVD3rqy8eVC7PnKaNx
        hvtF/0cl83XF+s6EmjoBs7VoRyTwGpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkPYodRrthK0KDBelPZoq1tuzpwIojBeCxchBxVgzPA=;
        b=vUSQsDsmtdQiPYQA2ZMfMetE64EB+Un8y/dDtLEtxzGoK5WR+iCn+CoewFEIt08C57Q47e
        HHuEGJuPHO/LWTDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEA2713910;
        Mon, 19 Dec 2022 16:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UCusLb+LoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:19 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 06/18] drm/fb-helper: Do not allocate unused apertures structure
Date:   Mon, 19 Dec 2022 17:05:04 +0100
Message-Id: <20221219160516.23436-7-tzimmermann@suse.de>
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

The apertures field in struct fb_info is not used by DRM drivers. Do
not allocate it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fb_helper.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index b3a731b9170a..e8a7e8be91d9 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -473,8 +473,8 @@ EXPORT_SYMBOL(drm_fb_helper_init);
  * drm_fb_helper_alloc_info - allocate fb_info and some of its members
  * @fb_helper: driver-allocated fbdev helper
  *
- * A helper to alloc fb_info and the members cmap and apertures. Called
- * by the driver within the fb_probe fb_helper callback function. Drivers do not
+ * A helper to alloc fb_info and the member cmap. Called by the driver
+ * within the fb_probe fb_helper callback function. Drivers do not
  * need to release the allocated fb_info structure themselves, this is
  * automatically done when calling drm_fb_helper_fini().
  *
@@ -496,27 +496,11 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 	if (ret)
 		goto err_release;
 
-	/*
-	 * TODO: We really should be smarter here and alloc an aperture
-	 * for each IORESOURCE_MEM resource helper->dev->dev has and also
-	 * init the ranges of the appertures based on the resources.
-	 * Note some drivers currently count on there being only 1 empty
-	 * aperture and fill this themselves, these will need to be dealt
-	 * with somehow when fixing this.
-	 */
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures) {
-		ret = -ENOMEM;
-		goto err_free_cmap;
-	}
-
 	fb_helper->info = info;
 	info->skip_vt_switch = true;
 
 	return info;
 
-err_free_cmap:
-	fb_dealloc_cmap(&info->cmap);
 err_release:
 	framebuffer_release(info);
 	return ERR_PTR(ret);
-- 
2.39.0

