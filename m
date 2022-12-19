Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD463650F9F
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiLSQFZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLSQFV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10842DE3;
        Mon, 19 Dec 2022 08:05:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F84F38145;
        Mon, 19 Dec 2022 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUg69Q6qEszR/WHAWAwnkSfcltjIyOVm1DIp4dya8uM=;
        b=2NgbyN6O+VYVJ9thzpCsCEsN9zlWzf/ypUilGv03NfFWXKz+WRkP/GFeL9JXyLcUcJ85F9
        MXjuAupX9a44GRRVja5B7dkPStf+Aq1ZNLoGq3q5ImeZI4FPJIXjitvUsN0YVBjf9Z1NI2
        RgIR4imKcr2rZ+/rX3NLJISzxvCaCug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUg69Q6qEszR/WHAWAwnkSfcltjIyOVm1DIp4dya8uM=;
        b=I6xUkz4ToabEbnD4TGTMJ5I4iz49ya5BZg2GGspLCu77K9rPJL8erbwLZJZn/2/m4ivwGY
        TVAFwwfP0OSenYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 489E513910;
        Mon, 19 Dec 2022 16:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kCHPEL+LoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:19 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 04/18] drm/i915: Do not set struct fb_info.apertures
Date:   Mon, 19 Dec 2022 17:05:02 +0100
Message-Id: <20221219160516.23436-5-tzimmermann@suse.de>
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

Generic fbdev drivers use the apertures field in struct fb_info to
control ownership of the framebuffer memory and graphics device. Do
not set the values in i915.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/i915/display/intel_fbdev.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 03ed4607a46d..bbdb98d7c96e 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -267,23 +267,16 @@ static int intelfb_create(struct drm_fb_helper *helper,
 
 	info->fbops = &intelfb_ops;
 
-	/* setup aperture base/size for vesafb takeover */
 	obj = intel_fb_obj(&intel_fb->base);
 	if (i915_gem_object_is_lmem(obj)) {
 		struct intel_memory_region *mem = obj->mm.region;
 
-		info->apertures->ranges[0].base = mem->io_start;
-		info->apertures->ranges[0].size = mem->io_size;
-
 		/* Use fbdev's framebuffer from lmem for discrete */
 		info->fix.smem_start =
 			(unsigned long)(mem->io_start +
 					i915_gem_object_get_dma_address(obj, 0));
 		info->fix.smem_len = obj->base.size;
 	} else {
-		info->apertures->ranges[0].base = ggtt->gmadr.start;
-		info->apertures->ranges[0].size = ggtt->mappable_end;
-
 		/* Our framebuffer is the entirety of fbdev's system memory */
 		info->fix.smem_start =
 			(unsigned long)(ggtt->gmadr.start + i915_ggtt_offset(vma));
-- 
2.39.0

