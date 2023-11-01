Return-Path: <linux-hyperv+bounces-652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEEC7DE45A
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Nov 2023 17:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AAE1F2146E
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Nov 2023 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111987480;
	Wed,  1 Nov 2023 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Yj+KLdDW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A2442E
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Nov 2023 16:02:20 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0EB4E4;
	Wed,  1 Nov 2023 09:02:18 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1159)
	id 6738C20B74C0; Wed,  1 Nov 2023 09:02:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6738C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1698854538;
	bh=JjKagOQc7XVCsOzjX5mQZCyIjlKEf/+UGuI8XDR24n4=;
	h=From:To:Cc:Subject:Date:From;
	b=Yj+KLdDWCXSntyvw2Ee6orRF9hr+VRDlMQZ0OP7j+7KKotau1/PdptyJC7tbAC0MA
	 T9ZzO0RudXLO3xp7WDdEZPcm7CXEFHNzDzi0YWOig14lgfEgoK0FBK91M7ed/LS1OM
	 VdWEZh1X7+XnzywI3maf4YfsadR90ULFkZIIVd/8=
From: Nischala Yelchuri <niyelchu@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	deller@gmx.de
Cc: mhklinux@outlook.com,
	mhkelley@outlook.com,
	singhabhinav9051571833@gmail.com,
	niyelchu@microsoft.com
Subject: [PATCH] Replace ioremap_cache() with memremap()
Date: Wed,  1 Nov 2023 09:01:48 -0700
Message-Id: <1698854508-23036-1-git-send-email-niyelchu@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Current Hyper-V code for CoCo VMs uses ioremap_cache() to map normal memory as decrypted.
ioremap_cache() is ideally used to map I/O device memory when it has the characteristics
of normal memory. It should not be used to map normal memory as the returned pointer
has the __iomem attribute.

Fix current code by replacing ioremap_cache() with memremap().

No functional change intended.

Signed-off-by: Nischala Yelchuri <niyelchu@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c               |  6 +++---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c |  2 +-
 drivers/hv/hv.c                         | 13 +++++++------
 drivers/video/fbdev/hyperv_fb.c         |  6 +++---
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 21556ad87..fae43c040 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -68,9 +68,9 @@ static int hyperv_init_ghcb(void)
 	 */
 	rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
 
-	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+	/* Mask out vTOM bit. memremap() maps decrypted with MEMREMAP_DEC */
 	ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
-	ghcb_va = (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+	ghcb_va = memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
 	if (!ghcb_va)
 		return -ENOMEM;
 
@@ -238,7 +238,7 @@ static int hv_cpu_die(unsigned int cpu)
 	if (hv_ghcb_pg) {
 		ghcb_va = (void **)this_cpu_ptr(hv_ghcb_pg);
 		if (*ghcb_va)
-			iounmap(*ghcb_va);
+			memunmap(*ghcb_va);
 		*ghcb_va = NULL;
 	}
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index d511d17c5..d6fec9bd3 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -92,7 +92,7 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 	 * connect to display properly for ARM64 Linux VM, as the host also maps
 	 * the VRAM cacheable.
 	 */
-	hv->vram = ioremap_cache(hv->mem->start, hv->fb_size);
+	hv->vram = memremap(hv->mem->start, hv->fb_size, MEMREMAP_WB | MEMREMAP_DEC);
 	if (!hv->vram) {
 		drm_err(dev, "Failed to map vram\n");
 		ret = -ENOMEM;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 51e5018ac..399bfa392 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -274,11 +274,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.simp_enabled = 1;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition) {
-		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+		/* Mask out vTOM bit. memremap() maps decrypted with MEMREMAP_DEC */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
 		hv_cpu->synic_message_page
-			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+			= memremap(base,
+				   HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
 		if (!hv_cpu->synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
@@ -293,11 +294,11 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 1;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition) {
-		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+		/* Mask out vTOM bit. memremap() maps decrypted with MEMREMAP_DEC */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
 		hv_cpu->synic_event_page
-			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+			= memremap(base, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
 		if (!hv_cpu->synic_event_page)
 			pr_err("Fail to map synic event page.\n");
 	} else {
@@ -376,7 +377,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 */
 	simp.simp_enabled = 0;
 	if (ms_hyperv.paravisor_present || hv_root_partition) {
-		iounmap(hv_cpu->synic_message_page);
+		memunmap(hv_cpu->synic_message_page);
 		hv_cpu->synic_message_page = NULL;
 	} else {
 		simp.base_simp_gpa = 0;
@@ -388,7 +389,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 0;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition) {
-		iounmap(hv_cpu->synic_event_page);
+		memunmap(hv_cpu->synic_event_page);
 		hv_cpu->synic_event_page = NULL;
 	} else {
 		siefp.base_siefp_gpa = 0;
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index bf59daf86..cd9ec1f6c 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1034,7 +1034,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	 * VM Connect to display properly for ARM64 Linux VM, as the host also
 	 * maps the VRAM cacheable.
 	 */
-	fb_virt = ioremap_cache(par->mem->start, screen_fb_size);
+	fb_virt = memremap(par->mem->start, screen_fb_size, MEMREMAP_WB | MEMREMAP_DEC);
 	if (!fb_virt)
 		goto err2;
 
@@ -1068,7 +1068,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	return 0;
 
 err3:
-	iounmap(fb_virt);
+	memunmap(fb_virt);
 err2:
 	vmbus_free_mmio(par->mem->start, screen_fb_size);
 	par->mem = NULL;
@@ -1086,7 +1086,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 
 	if (par->need_docopy) {
 		vfree(par->dio_vp);
-		iounmap(info->screen_base);
+		memunmap(info->screen_base);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
 		hvfb_release_phymem(hdev, info->fix.smem_start,
-- 
2.34.1


