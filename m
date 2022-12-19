Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6A650FAE
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiLSQFb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiLSQFX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1EC2BDB;
        Mon, 19 Dec 2022 08:05:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B36CB6089B;
        Mon, 19 Dec 2022 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVYvLsFG6f+exAHX9YV2exCISsylgNZMOA5W08XvPSQ=;
        b=WDWo93d+J2PYNjBpbcWDD3AL8nfm2we1M6PNPvbJFxhIjK1TbLS+wJRRCLoSGIgT7jjL0q
        5+iemEoD93yfLjOoycJUnrNs4iF1NUfDrs2VAHOfs9H3zg648rJKWhktVvEmKweAj5YHIM
        SrHlgeZZTrHu84SnOlEaP7pQr2HGb54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVYvLsFG6f+exAHX9YV2exCISsylgNZMOA5W08XvPSQ=;
        b=+xrS6xZIUrSmCMlgO66EWNJJ3CEPP+VBlznk8HddOxqlBDznZvrjsXBPed+3YaY1zpA5oU
        H04kQ+iuTDU1GcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E2D713910;
        Mon, 19 Dec 2022 16:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OEPfHcCLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:20 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 09/18] vfio-mdev/mdpy-fb: Do not set struct fb_info.apertures
Date:   Mon, 19 Dec 2022 17:05:07 +0100
Message-Id: <20221219160516.23436-10-tzimmermann@suse.de>
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
not set the values in mdpy-fb.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 samples/vfio-mdev/mdpy-fb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
index 9ec93d90e8a5..1de5801cd2e8 100644
--- a/samples/vfio-mdev/mdpy-fb.c
+++ b/samples/vfio-mdev/mdpy-fb.c
@@ -161,14 +161,6 @@ static int mdpy_fb_probe(struct pci_dev *pdev,
 		goto err_release_fb;
 	}
 
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures) {
-		ret = -ENOMEM;
-		goto err_unmap;
-	}
-	info->apertures->ranges[0].base = info->fix.smem_start;
-	info->apertures->ranges[0].size = info->fix.smem_len;
-
 	info->fbops = &mdpy_fb_ops;
 	info->flags = FBINFO_DEFAULT;
 	info->pseudo_palette = par->palette;
-- 
2.39.0

