Return-Path: <linux-hyperv+bounces-1372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C3822B5A
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 11:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D420B235F1
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB618C11;
	Wed,  3 Jan 2024 10:26:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C518EDB;
	Wed,  3 Jan 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D63C521F9A;
	Wed,  3 Jan 2024 10:26:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86D951340C;
	Wed,  3 Jan 2024 10:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4PjFH2I2lWWmfgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Jan 2024 10:26:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: drawat.floss@gmail.com,
	javierm@redhat.com,
	deller@gmx.de,
	decui@microsoft.com,
	wei.liu@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] fbdev/hyperv_fb: Remove firmware framebuffers with aperture helpers
Date: Wed,  3 Jan 2024 11:15:10 +0100
Message-ID: <20240103102640.31751-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103102640.31751-1-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D63C521F9A

Replace use of screen_info state with the correct interfaces from
the aperture helpers. The state is only for architecture and firmware
code. It is not guaranteed to contain valid data. Drivers are thus
not allowed to use it.

For removing conflicting firmware framebuffers, there are aperture
helpers. Hence replace screen_info with the correct functions that will
remove conflicting framebuffers for the hypervfb driver. For GEN1 PCI
devices, the driver reads the framebuffer base and size from the PCI
BAR, and uses the range for removing the firmware framebuffer. For
GEN2 VMBUS devices no range can be detected, so the driver clears all
firmware framebuffers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/hyperv_fb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index a80939fe2ee6..76c956b9a321 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -975,7 +975,8 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	struct pci_dev *pdev  = NULL;
 	void __iomem *fb_virt;
 	int gen2vm = efi_enabled(EFI_BOOT);
-	resource_size_t base, size;
+	resource_size_t base = 0;
+	resource_size_t size = 0;
 	phys_addr_t paddr;
 	int ret;
 
@@ -1010,9 +1011,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 			goto getmem_done;
 		}
 		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
-	} else if (IS_ENABLED(CONFIG_SYSFB)) {
-		base = screen_info.lfb_base;
-		size = screen_info.lfb_size;
 	} else {
 		goto err1;
 	}
@@ -1056,7 +1054,10 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	info->screen_size = dio_fb_size;
 
 getmem_done:
-	aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
+	if (base && size)
+		aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
+	else
+		aperture_remove_all_conflicting_devices(KBUILD_MODNAME);
 
 	if (!gen2vm) {
 		pci_dev_put(pdev);
-- 
2.43.0


