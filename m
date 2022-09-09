Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB72A5B3AF2
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Sep 2022 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiIIOoL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Sep 2022 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiIIOoJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Sep 2022 10:44:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 919E211779A;
        Fri,  9 Sep 2022 07:44:06 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A06C0204A5BC;
        Fri,  9 Sep 2022 07:44:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A06C0204A5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662734645;
        bh=+jd4U7/A0qtxB/62Y20V/gk1Y4XdI3jkHh2RaPiXZ/I=;
        h=From:To:Subject:Date:From;
        b=eGTMRMp8N6BQf1LZnHUksGbEsFeDg2LsXJlo2WWvaGu0g6eym7kXlAd3Nqs+Si5co
         JK4nZmY4L9WvZAVGFMaVHUfvRU2TYVnjYMhre2OLj8GcgfWC14dO2TbD4FJJn+zo1B
         DaKBbAZqGbYZYmLirrHUdVQ0Kmkd/BzmwHVXU3cM=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: [PATCH] drm/hyperv: Don't rely on screen_info.lfb_base for Gen1 VMs
Date:   Fri,  9 Sep 2022 07:43:59 -0700
Message-Id: <1662734639-27164-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

hyperv_setup_vram tries to remove conflicting framebuffer based on
'screen_info'. As observed in past due to some bug or wrong setting
in grub, the 'screen_info' fields may not be set for Gen1, and in such
cases drm_aperture_remove_conflicting_framebuffers will not do anything
useful.
For Gen1 VMs, it should always be possible to get framebuffer
conflict removed using PCI device instead.

Fixes: a0ab5abced55 ("drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 6d11e7938c83..b0cc974efa45 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -73,12 +73,28 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 			     struct hv_device *hdev)
 {
 	struct drm_device *dev = &hv->dev;
+	struct pci_dev *pdev;
 	int ret;
 
-	drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
-						     screen_info.lfb_size,
-						     false,
-						     &hyperv_driver);
+	if (efi_enabled(EFI_BOOT)) {
+		drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
+							     screen_info.lfb_size,
+							     false,
+							     &hyperv_driver);
+	} else {
+		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
+		if (!pdev) {
+			drm_err(dev, "Unable to find PCI Hyper-V video\n");
+			return -ENODEV;
+		}
+
+		ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &hyperv_driver);
+		pci_dev_put(pdev);
+		if (ret) {
+			drm_err(dev, "Not able to remove boot fb\n");
+			return ret;
+		}
+	}
 
 	hv->fb_size = (unsigned long)hv->mmio_megabytes * 1024 * 1024;
 
-- 
2.34.1

