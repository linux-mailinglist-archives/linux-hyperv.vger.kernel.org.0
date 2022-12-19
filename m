Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA1650FA7
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiLSQF3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLSQFW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB610E6;
        Mon, 19 Dec 2022 08:05:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F2E2738149;
        Mon, 19 Dec 2022 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obTd6Vm1en8QYigHEu9RhDcL5tb/CmpPkDgnKAoQ5jE=;
        b=b4K4FAar1WgYMZX5pfZnzCVcF80GxF/BuZdANPvIPGZthi5DRao3/arOXSSrCzmw+/YfIu
        DkFh6mfpuAErsioiYMFs06ZKz2+V2DVmkQA/tHWYwslk5m/ZgqIWKw4b6LELWED4hBlVJq
        1O/aqwBiAkBpVH844qCWXsHTJU1MG4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obTd6Vm1en8QYigHEu9RhDcL5tb/CmpPkDgnKAoQ5jE=;
        b=472H4JvHPod2/eeTkuU93yA7QE5pwbZ5rhmYSoL7HgEUeRiKO1eB//pWB5b5OYjMvvrDAE
        xRpEqrP5VJVl4uAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7D6213911;
        Mon, 19 Dec 2022 16:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SMr4K8CLoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:20 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/18] fbdev/efifb: Add struct efifb_par for driver data
Date:   Mon, 19 Dec 2022 17:05:08 +0100
Message-Id: <20221219160516.23436-11-tzimmermann@suse.de>
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

The efifb_par structure holds the palette for efifb. It will also
be useful for storing the device's aperture range.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/efifb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 16c1aaae9afa..694013f62781 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -49,6 +49,10 @@ static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
 
 static struct pci_dev *efifb_pci_dev;	/* dev with BAR covering the efifb */
 
+struct efifb_par {
+	u32 pseudo_palette[16];
+};
+
 static struct fb_var_screeninfo efifb_defined = {
 	.activate		= FB_ACTIVATE_NOW,
 	.height			= -1,
@@ -351,6 +355,7 @@ static u64 bar_offset;
 static int efifb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
+	struct efifb_par *par;
 	int err, orientation;
 	unsigned int size_vmode;
 	unsigned int size_remap;
@@ -447,14 +452,14 @@ static int efifb_probe(struct platform_device *dev)
 			efifb_fix.smem_start);
 	}
 
-	info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
+	info = framebuffer_alloc(sizeof(*par), &dev->dev);
 	if (!info) {
 		err = -ENOMEM;
 		goto err_release_mem;
 	}
 	platform_set_drvdata(dev, info);
-	info->pseudo_palette = info->par;
-	info->par = NULL;
+	par = info->par;
+	info->pseudo_palette = par->pseudo_palette;
 
 	info->apertures = alloc_apertures(1);
 	if (!info->apertures) {
-- 
2.39.0

