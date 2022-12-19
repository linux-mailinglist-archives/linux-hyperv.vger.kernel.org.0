Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84F650FB9
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiLSQFf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiLSQFY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC626468;
        Mon, 19 Dec 2022 08:05:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27ADF6106E;
        Mon, 19 Dec 2022 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hk5EKSUL389KsnsC/G3K1wHJayEh/SOXo4ItcALV1Ag=;
        b=QmXXYlFXdG0dSdHbUVlQ1pBn85w1xRlIeCKDPeIEgqjXvs9YOQpLfBrcpQai8KNTcUgWWE
        PhIZo4ftOUK/WV/kScRCmMUM/wzhlqRxZSS0oh9/O6QLc4EoED4y2IwV5NvvdrWTzneA+p
        zWJeSck1MA+ahx+UzXdP+LnA8VopBMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hk5EKSUL389KsnsC/G3K1wHJayEh/SOXo4ItcALV1Ag=;
        b=mqL6Vjk4YynhjeMTYPsc0SkyQ4Rtk3Ol/IUTDWJgY23ZYs3AxewUZ0B4rQn6Omkf8Dyedl
        Ch6EJrXpKWzqEsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E89FB13911;
        Mon, 19 Dec 2022 16:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MDD0N8GLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:21 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 15/18] fbdev/vesafb: Remove trailing whitespaces
Date:   Mon, 19 Dec 2022 17:05:13 +0100
Message-Id: <20221219160516.23436-16-tzimmermann@suse.de>
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

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/vesafb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index 929d4775cb4b..47ce244e4bb8 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -140,7 +140,7 @@ static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	 *  (according to the entries in the `var' structure). Return
 	 *  != 0 for invalid regno.
 	 */
-	
+
 	if (regno >= info->cmap.len)
 		return 1;
 
@@ -209,13 +209,13 @@ static struct fb_ops vesafb_ops = {
 static int vesafb_setup(char *options)
 {
 	char *this_opt;
-	
+
 	if (!options || !*options)
 		return 0;
-	
+
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
-		
+
 		if (! strcmp(this_opt, "inverse"))
 			inverse=1;
 		else if (! strcmp(this_opt, "redraw"))
@@ -381,7 +381,7 @@ static int vesafb_probe(struct platform_device *dev)
 	vesafb_defined.pixclock     = 10000000 / vesafb_defined.xres * 1000 / vesafb_defined.yres;
 	vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;
 	vesafb_defined.hsync_len    = (vesafb_defined.xres / 8) & 0xf8;
-	
+
 	vesafb_defined.red.offset    = screen_info.red_pos;
 	vesafb_defined.red.length    = screen_info.red_size;
 	vesafb_defined.green.offset  = screen_info.green_pos;
-- 
2.39.0

