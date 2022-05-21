Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5E52FD3C
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 May 2022 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiEUOXo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 21 May 2022 10:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiEUOXo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 21 May 2022 10:23:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A80336E28;
        Sat, 21 May 2022 07:23:43 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4554E20B6C7C;
        Sat, 21 May 2022 07:23:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4554E20B6C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653143023;
        bh=dJ9FOpSCgx5aFau9EXn3cqD6jLljJRXBBXibNoXWwbs=;
        h=From:To:Subject:Date:From;
        b=H55LDMs3ElWgyB3rRWyalm4i8ziWUCQUSXUdrPSIpXwF2uOsjuWjG09P4R57VYlL1
         VL1QFf+T/bjfjXXna3wsrvH+BLLNm3ZaugGh2Fk5ekClq+1nk2mcIlXBcA3A402qsL
         NxKsVBNnPN9f3bQX3CYuTgnF8vL3xRURRc3wfRgM=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, haiyangz@microsoft.com
Subject: [PATCH v2] drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size
Date:   Sat, 21 May 2022 07:23:39 -0700
Message-Id: <1653143019-20032-1-git-send-email-ssengar@linux.microsoft.com>
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

There were two different approaches getting used in this driver to
allocate vram:
	1. VRAM allocation from PCI region for Gen1
	2. VRAM alloaction from MMIO region for Gen2
First approach limilts the vram to PCI BAR size, which is 64 MB in most
legacy systems. This limits the maximum resolution to be restricted to
64 MB size, and with recent conclusion on fbdev issue its concluded to have
similar allocation strategy for both Gen1 and Gen2. This patch unifies
the Gen1 and Gen2 vram allocation strategy.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 74 ++-------------------------------
 1 file changed, 3 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 4a8941f..6d11e79 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -69,56 +69,7 @@ static void hyperv_pci_remove(struct pci_dev *pdev)
 	.remove =	hyperv_pci_remove,
 };
 
-static int hyperv_setup_gen1(struct hyperv_drm_device *hv)
-{
-	struct drm_device *dev = &hv->dev;
-	struct pci_dev *pdev;
-	int ret;
-
-	pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
-			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
-	if (!pdev) {
-		drm_err(dev, "Unable to find PCI Hyper-V video\n");
-		return -ENODEV;
-	}
-
-	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &hyperv_driver);
-	if (ret) {
-		drm_err(dev, "Not able to remove boot fb\n");
-		return ret;
-	}
-
-	if (pci_request_region(pdev, 0, DRIVER_NAME) != 0)
-		drm_warn(dev, "Cannot request framebuffer, boot fb still active?\n");
-
-	if ((pdev->resource[0].flags & IORESOURCE_MEM) == 0) {
-		drm_err(dev, "Resource at bar 0 is not IORESOURCE_MEM\n");
-		ret = -ENODEV;
-		goto error;
-	}
-
-	hv->fb_base = pci_resource_start(pdev, 0);
-	hv->fb_size = pci_resource_len(pdev, 0);
-	if (!hv->fb_base) {
-		drm_err(dev, "Resource not available\n");
-		ret = -ENODEV;
-		goto error;
-	}
-
-	hv->fb_size = min(hv->fb_size,
-			  (unsigned long)(hv->mmio_megabytes * 1024 * 1024));
-	hv->vram = devm_ioremap(&pdev->dev, hv->fb_base, hv->fb_size);
-	if (!hv->vram) {
-		drm_err(dev, "Failed to map vram\n");
-		ret = -ENOMEM;
-	}
-
-error:
-	pci_dev_put(pdev);
-	return ret;
-}
-
-static int hyperv_setup_gen2(struct hyperv_drm_device *hv,
+static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 			     struct hv_device *hdev)
 {
 	struct drm_device *dev = &hv->dev;
@@ -181,10 +132,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 		goto err_hv_set_drv_data;
 	}
 
-	if (efi_enabled(EFI_BOOT))
-		ret = hyperv_setup_gen2(hv, hdev);
-	else
-		ret = hyperv_setup_gen1(hv);
+	ret = hyperv_setup_vram(hv, hdev);
 
 	if (ret)
 		goto err_vmbus_close;
@@ -225,29 +173,13 @@ static int hyperv_vmbus_remove(struct hv_device *hdev)
 {
 	struct drm_device *dev = hv_get_drvdata(hdev);
 	struct hyperv_drm_device *hv = to_hv(dev);
-	struct pci_dev *pdev;
 
 	drm_dev_unplug(dev);
 	drm_atomic_helper_shutdown(dev);
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	/*
-	 * Free allocated MMIO memory only on Gen2 VMs.
-	 * On Gen1 VMs, release the PCI device
-	 */
-	if (efi_enabled(EFI_BOOT)) {
-		vmbus_free_mmio(hv->mem->start, hv->fb_size);
-	} else {
-		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
-				      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
-		if (!pdev) {
-			drm_err(dev, "Unable to find PCI Hyper-V video\n");
-			return -ENODEV;
-		}
-		pci_release_region(pdev, 0);
-		pci_dev_put(pdev);
-	}
+	vmbus_free_mmio(hv->mem->start, hv->fb_size);
 
 	return 0;
 }
-- 
1.8.3.1

