Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F6857C605
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Jul 2022 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiGUIRa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiGUIRH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 04:17:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A23B7D7AE;
        Thu, 21 Jul 2022 01:17:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1BEA38067;
        Thu, 21 Jul 2022 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658391420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8ntRyJQOuCH/ZNpGGGI9D+0VGk+On2gEgjRPWLFPoIw=;
        b=sorsLmkWTcP5lCSiP8j9Qi6f8pACqyyACCdoQTiNHRSb8AM2nH9XgDbYmrF6vnhALyuFrY
        eqRv2aKoD0se6AdWCWO4pab9ZXr7k8rPM/MqsGg3j+OL5xEo9AZxUKIw7nWiAuyoejsdKh
        HUgwP/UERpKdbXoYfpQJVyQjuxWAXPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658391420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8ntRyJQOuCH/ZNpGGGI9D+0VGk+On2gEgjRPWLFPoIw=;
        b=0BySPmGmJWKHiRXKhFSUHmVpnnlbls2PzD24JQ6kcn5SWqMuARItGD1wvMD8ZAStatyWkv
        9lpJZlHZeSW1MkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5244A13A89;
        Thu, 21 Jul 2022 08:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oV0iE3wL2WKoFwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 21 Jul 2022 08:17:00 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, javierm@redhat.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH] fbdev: Fix order of arguments to aperture_remove_conflicting_devices()
Date:   Thu, 21 Jul 2022 10:16:55 +0200
Message-Id: <20220721081655.16128-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
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

Reverse the order of the final two arguments when calling
aperture_remove_conflicting_devices(). An error report is available
at [1].

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 8d69d008f44c ("fbdev: Convert drivers to aperture helpers")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Link: https://lore.kernel.org/lkml/202207202040.jS1WcTzN-lkp@intel.com/ # 1
---
 drivers/video/fbdev/aty/radeon_base.c | 2 +-
 drivers/video/fbdev/hyperv_fb.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index e5e362b8c9da..0a8199985d52 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2243,7 +2243,7 @@ static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
 	resource_size_t base = pci_resource_start(pdev, 0);
 	resource_size_t size = pci_resource_len(pdev, 0);
 
-	return aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME, false);
+	return aperture_remove_conflicting_devices(base, size, false, KBUILD_MODNAME);
 }
 
 static int radeonfb_pci_register(struct pci_dev *pdev,
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index a944a6620527..a0e1d70b90d7 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1077,7 +1077,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 getmem_done:
 	aperture_remove_conflicting_devices(info->apertures->ranges[0].base,
 					    info->apertures->ranges[0].size,
-					    KBUILD_MODNAME, false);
+					    false, KBUILD_MODNAME);
 
 	if (gen2vm) {
 		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
-- 
2.36.1

