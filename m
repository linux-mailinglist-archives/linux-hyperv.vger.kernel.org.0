Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4F511911
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Apr 2022 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiD0NvL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Apr 2022 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiD0NvJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Apr 2022 09:51:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 731C3766A;
        Wed, 27 Apr 2022 06:47:58 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1C85520E97B0;
        Wed, 27 Apr 2022 06:47:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C85520E97B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1651067278;
        bh=s71BKG69g523heKe1yEo9VKmSL/5EGLlD50AE/SchRU=;
        h=From:To:Subject:Date:From;
        b=ifbwO0m7s/jATQqceeCrnmVeEIvhHzX2cXKpEfhAwiCd74/M8VzUv42AlybCLlOns
         rXoAQoxBIm3S8+db/8ujimleKpMTVlNzlj3vui3OcfDgu45PD4JteeDG+oO42hHoVq
         pFFnzL2EG/CJS60yxHsd3dFozwBleudDIoiEp79k=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        deller@gmx.de, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: hyperv_fb: Allow resolutions with size > 64 MB for Gen1
Date:   Wed, 27 Apr 2022 06:47:53 -0700
Message-Id: <1651067273-6635-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch fixes a bug where GEN1 VMs doesn't allow resolutions greater
than 64 MB size (eg 7680x4320). Unnecessary PCI check limits Gen1 VRAM
to legacy PCI BAR size only (ie 64MB). Thus any, resolution requesting
greater then 64MB (eg 7680x4320) would fail. MMIO region assigning this
memory shouldn't be limited by PCI bar size.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/video/fbdev/hyperv_fb.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index c8e0ea2..58c304a 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1009,7 +1009,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	struct pci_dev *pdev  = NULL;
 	void __iomem *fb_virt;
 	int gen2vm = efi_enabled(EFI_BOOT);
-	resource_size_t pot_start, pot_end;
 	phys_addr_t paddr;
 	int ret;
 
@@ -1060,23 +1059,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	dio_fb_size =
 		screen_width * screen_height * screen_depth / 8;
 
-	if (gen2vm) {
-		pot_start = 0;
-		pot_end = -1;
-	} else {
-		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
-		    pci_resource_len(pdev, 0) < screen_fb_size) {
-			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
-			       (unsigned long) pci_resource_len(pdev, 0),
-			       (unsigned long) screen_fb_size);
-			goto err1;
-		}
-
-		pot_end = pci_resource_end(pdev, 0);
-		pot_start = pot_end - screen_fb_size + 1;
-	}
-
-	ret = vmbus_allocate_mmio(&par->mem, hdev, pot_start, pot_end,
+	ret = vmbus_allocate_mmio(&par->mem, hdev, 0, -1,
 				  screen_fb_size, 0x100000, true);
 	if (ret != 0) {
 		pr_err("Unable to allocate framebuffer memory\n");
-- 
1.8.3.1

