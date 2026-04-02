Return-Path: <linux-hyperv+bounces-9898-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNq4MO84zmmAmAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9898-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:37:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E053D38709D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E141830B8885
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F838F639;
	Thu,  2 Apr 2026 09:23:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819938F630
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Apr 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121826; cv=none; b=e9scZNw/G41SRgd+bt+W0Xa8d2H9udHtO05homKy1J+Cof1sC0S0KPlh7PFZI9ppliREwApKGVB0HqjwuJee9DdB9jybtoHsq/hXKKxJsJ1Nn66O9JUlV59EaBzOrS1ULiz4UOoA2fSih33gXIhmD/tIZp352NIv4NxNfR10AxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121826; c=relaxed/simple;
	bh=CiP0OdZqOpeWaimweMzVRCCuHLI9ZqRCyAIc8yp0WbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdD7K5OFKgv8NTiYhn0LSZoEW4z/UevyeDFSddRdWdnhOVGY6hXDQeovvF0hxxyxyk0emIxzBNha1a23acfYkWFZWUyGVWcS2YXXi4yL2ccuOyOG4P+RIFZfA2fpay0RLu5PpXGbuWxSNdLF7mZU/dKfGXJjBEu5dBT+LUhJERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84A0D5BD9A;
	Thu,  2 Apr 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC1F84A0B1;
	Thu,  2 Apr 2026 09:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UGM3OH81zmlVYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:11 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	arnd@arndb.de,
	ardb@kernel.org,
	ilias.apalodimas@linaro.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	deller@gmx.de
Cc: linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable option
Date: Thu,  2 Apr 2026 11:09:17 +0200
Message-ID: <20260402092305.208728-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402092305.208728-1-tzimmermann@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9898-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.911];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E053D38709D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a descriptive string and help text to CONFIG_SYSFB, so that users
can modify it. Flip all implicit selects in the Kconfig options into
dependencies. This avoids cyclic dependencies in the config.

Enabling CONFIG_SYSFB makes the kernel provide a device for the firmware
framebuffer. As this can (slightly) affect system behavior, having a
user-facing option seems preferable. Some users might also want to set
every detail of their kernel config.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/Kconfig      | 18 ++++++++++++++++--
 drivers/gpu/drm/sysfb/Kconfig |  4 ++--
 drivers/hv/Kconfig            |  2 +-
 drivers/video/fbdev/Kconfig   |  5 +++--
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..52f8253a46b1 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -179,14 +179,28 @@ config MTK_ADSP_IPC
 	  Client might use shared memory to exchange information with ADSP.
 
 config SYSFB
-	bool
+	bool "Enable system framebuffer provided by boot loader"
 	select BOOT_VESA_SUPPORT
 	select SCREEN_INFO
+	help
+	  Use the system framebuffer provided by the boot loader. This will
+	  create a device representing the framebuffer. The output depends on
+	  EFI, VESA, VGA, or some other firmware-based interface.
+
+	  The firmware or boot loader sets the display resolution and color
+	  mode. See your boot loader's documentation on how to do this. On
+	  some systems the display can also be configured during boot with
+	  the kernel's video= or vga= parameters.
+
+	  Besides this option, you also have to enable a compatible graphics
+	  driver, such as efidrm or vesadrm.
+
+	  If unsure, say Y.
 
 config SYSFB_SIMPLEFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
+	depends on SYSFB
 	depends on X86 || EFI
-	select SYSFB
 	help
 	  Firmwares often provide initial graphics framebuffers so the BIOS,
 	  bootloader or kernel can show basic video-output during boot for
diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index 2559ead6cf1f..74be3c8e6657 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -26,12 +26,12 @@ config DRM_COREBOOTDRM
 config DRM_EFIDRM
 	tristate "EFI framebuffer driver"
 	depends on DRM && MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
 	select DRM_SYSFB_HELPER
-	select SYSFB
 	help
 	  DRM driver for EFI framebuffers.
 
@@ -76,12 +76,12 @@ config DRM_SIMPLEDRM
 config DRM_VESADRM
 	tristate "VESA framebuffer driver"
 	depends on DRM && MMU && X86 && (!SYSFB_SIMPLEFB || COMPILE_TEST)
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
 	select DRM_SYSFB_HELPER
-	select SYSFB
 	help
 	  DRM driver for VESA framebuffers.
 
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 2d0b3fcb0ff8..af0ac6516159 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -60,8 +60,8 @@ config HYPERV_BALLOON
 config HYPERV_VMBUS
 	tristate "Microsoft Hyper-V VMBus driver"
 	depends on HYPERV
+	depends on SYSFB if EFI && !HYPERV_VTL_MODE
 	default HYPERV
-	select SYSFB if EFI && !HYPERV_VTL_MODE
 	help
 	  Select this option to enable Hyper-V Vmbus driver.
 
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ac9ac4287c6a..6f55bec8c207 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -333,6 +333,7 @@ config FB_IMSTT
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
 	depends on FB && X86
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -424,9 +425,9 @@ config FB_UVESA
 config FB_VESA
 	bool "VESA VGA graphics support"
 	depends on (FB = y) && X86
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select FB_IOMEM_HELPERS
-	select SYSFB
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -436,10 +437,10 @@ config FB_VESA
 config FB_EFI
 	bool "EFI-based Framebuffer Support"
 	depends on (FB = y) && EFI
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select DRM_PANEL_ORIENTATION_QUIRKS
 	select FB_IOMEM_HELPERS
-	select SYSFB
 	help
 	  This is the EFI frame buffer device driver. If the firmware on
 	  your platform is EFI 1.10 or UEFI 2.0, select Y to add support for
-- 
2.53.0


