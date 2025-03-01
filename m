Return-Path: <linux-hyperv+bounces-4190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E924FA4ACCD
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53F51897138
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BB1E5203;
	Sat,  1 Mar 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OCDTYDmQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799501B3927;
	Sat,  1 Mar 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740845801; cv=none; b=HkfFOwykI0QFCGyd9GQik12u4duif2k3NGNhcKIwfDlf83Q19CoMt/qT+ku23pFS+LDO9qrtcevYfHO97VFM5rwbv8N7HC8SPK+q3BNc6G3+Z+KQff3W2RgY4L0KW22gdFmwH7nqAZV9WKZ9UnygImsKS++CI3r19PuATS2UftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740845801; c=relaxed/simple;
	bh=4Z05X1JtZwlZOa9i4oUJAfDxj/YmcZ2tAlrv1rHdM5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SoMh4kBlvl0tP1Uj2rGZ/HzcjvD8Jwhm1Xe7tmHeZF8t/wIwAT+UcpS2Bnk/6aCK2JCyrNs+BWn6BW/3dl5dKV9Euvj8jWxfTUl5otg9ulVcfrO8WcWKWvyXXwBxhsitLOcUpjDAYqq3wzuQs/ucX9iEPS0uLwiHCVeIH2kqqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OCDTYDmQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 033702038A3F;
	Sat,  1 Mar 2025 08:16:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 033702038A3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740845799;
	bh=wvjA0okL8MAfHhqldHFyJIiqhL2lCGaRxjj4F04p+og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCDTYDmQtEjX+3EMA93BD9bpv8bd8opTo327QRfudpztplU2j0iHdfZnk0kNI5x3a
	 2bJXNWgyEzzw5/A1tc/WoY1Cd3slRWpdqCoMLqGAdfnNtU1AFwAtjfpvOwcfsUzQOJ
	 RZoiA2jMNm5vaO/STDN15zhJwGk5IKMHY/HkN3us=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	akpm@linux-foundation.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	mhklinux@outlook.com
Subject: [PATCH v3 1/2] fbdev: hyperv_fb: Simplify hvfb_putmem
Date: Sat,  1 Mar 2025 08:16:30 -0800
Message-Id: <1740845791-19977-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>
References: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The device object required in 'hvfb_release_phymem' function
for 'dma_free_coherent' can also be obtained from the 'info'
pointer, making 'hdev' parameter in 'hvfb_putmem' redundant.
Remove the unnecessary 'hdev' argument from 'hvfb_putmem'.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/video/fbdev/hyperv_fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 363e4ccfcdb7..09fb025477f7 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -952,7 +952,7 @@ static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
 }
 
 /* Release contiguous physical memory */
-static void hvfb_release_phymem(struct hv_device *hdev,
+static void hvfb_release_phymem(struct device *device,
 				phys_addr_t paddr, unsigned int size)
 {
 	unsigned int order = get_order(size);
@@ -960,7 +960,7 @@ static void hvfb_release_phymem(struct hv_device *hdev,
 	if (order <= MAX_PAGE_ORDER)
 		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
 	else
-		dma_free_coherent(&hdev->device,
+		dma_free_coherent(device,
 				  round_up(size, PAGE_SIZE),
 				  phys_to_virt(paddr),
 				  paddr);
@@ -1074,7 +1074,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 }
 
 /* Release the framebuffer */
-static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
+static void hvfb_putmem(struct fb_info *info)
 {
 	struct hvfb_par *par = info->par;
 
@@ -1083,7 +1083,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
-		hvfb_release_phymem(hdev, info->fix.smem_start,
+		hvfb_release_phymem(info->device, info->fix.smem_start,
 				    screen_fb_size);
 	}
 
@@ -1197,7 +1197,7 @@ static int hvfb_probe(struct hv_device *hdev,
 
 error:
 	fb_deferred_io_cleanup(info);
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 error2:
 	vmbus_close(hdev->channel);
 error1:
@@ -1226,7 +1226,7 @@ static void hvfb_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 	framebuffer_release(info);
 }
 
-- 
2.43.0


