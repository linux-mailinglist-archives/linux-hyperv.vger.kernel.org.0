Return-Path: <linux-hyperv+bounces-9900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD80AFw2zmmAmAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9900-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:26:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C8386E67
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F5183030B1D
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1A38F249;
	Thu,  2 Apr 2026 09:23:55 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21327E07E
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Apr 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121835; cv=none; b=Uk0GZLwH4CMxS2wbv8DwAJtGZt0PtJmhzX4EPFbN2NubqqzwExfdaxLBZCBaPvLvFDTRnBBNYKqtgzy63OaHmf4bW33CXWDu3NSPE4avjPgyhbSyOzxJqYjleHTJj23m1OIVxzZheQwPw6p0hfSgrB6f099i0Krj12PaIXFe7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121835; c=relaxed/simple;
	bh=+Nz4+367ERAXaJqDOSnA3deCZDRPDfPJ+Ksy9zSVM0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjgwNeCF8D4zMLzUtQ0eVqDDTUnKuet0Hllg9wzRPhtyBZ3pzOCTbskFIIFVyAri8fuezHaiYzgpXeYk45zo94Go5wjzpUP9QcrWB0GD94IIgd6JgPnWCieEvNMpuRwx0NqIWY6uXMo4mE18N6yc49apWSo1p8LAtfI0e5v+DA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 831024D322;
	Thu,  2 Apr 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE2D64A0B0;
	Thu,  2 Apr 2026 09:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wEq8OII1zmlVYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:14 +0000
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
Subject: [PATCH 8/8] firmware: sysfb: Move CONFIG_FIRMWARE_EDID to firmware options
Date: Thu,  2 Apr 2026 11:09:22 +0200
Message-ID: <20260402092305.208728-9-tzimmermann@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9900-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9B3C8386E67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the Kconfig option for CONFIG_FIRMWARE_EDID to the firmware
subsystem. The option controls architecture and firmware code, so
it fits here better than in video.

Also make it depend on CONFIG_SYSFB. The EDID data is stored in
sysfb_primary_display and only useful with a sysfb framebuffer. This
further allows for removing an explicit test for CONFIG_FIRMWARE_EDID
from the EFI init code. For loongson, select CONFIG_SYSFB in the
defconfig files.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/loongarch/configs/loongson32_defconfig |  1 +
 arch/loongarch/configs/loongson64_defconfig |  1 +
 drivers/firmware/Kconfig                    | 20 ++++++++++++++++++++
 drivers/firmware/efi/efi-init.c             |  2 +-
 drivers/video/Kconfig                       | 19 -------------------
 5 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
index 276b1577e0be..1c0897723247 100644
--- a/arch/loongarch/configs/loongson32_defconfig
+++ b/arch/loongarch/configs/loongson32_defconfig
@@ -786,6 +786,7 @@ CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_DRM_LOONGSON=y
 CONFIG_FB=y
 CONFIG_FB_RADEON=y
+CONFIG_SYSFB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
index a14db1a95e7e..38340537dfd4 100644
--- a/arch/loongarch/configs/loongson64_defconfig
+++ b/arch/loongarch/configs/loongson64_defconfig
@@ -816,6 +816,7 @@ CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_DRM_LOONGSON=y
 CONFIG_FB=y
 CONFIG_FB_RADEON=y
+CONFIG_SYSFB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 52f8253a46b1..edfb171d9eab 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -225,6 +225,26 @@ config SYSFB_SIMPLEFB
 
 	  If unsure, say Y.
 
+config FIRMWARE_EDID
+	bool "Enable firmware EDID"
+	depends on SYSFB
+	depends on EFI_GENERIC_STUB || X86
+	help
+	  This enables access to the EDID transferred from the firmware.
+	  On EFI systems, the EDID comes from the same device as the
+	  primary GOP. On x86 with BIOS, it comes from the VESA BIOS.
+	  DRM display drivers will be able to export the information
+	  to userspace.
+
+	  Also enable this if DDC/I2C transfers do not work for your driver
+	  and if you are using nvidiafb, i810fb or savagefb.
+
+	  In general, choosing Y for this option is safe.  If you
+	  experience extremely long delays while booting before you get
+	  something on your display, try setting this to N.  Matrox cards in
+	  combination with certain motherboards and monitors are known to
+	  suffer from this problem.
+
 config TH1520_AON_PROTOCOL
 	tristate "Always-On firmware protocol"
 	depends on ARCH_THEAD || COMPILE_TEST
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 002518b642ed..c4088fb8482b 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -60,7 +60,7 @@ extern __weak const efi_config_table_type_t efi_arch_tables[];
  * x86 defines its own instance of sysfb_primary_display and uses
  * it even without EFI, everything else can get them from here.
  */
-#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_FIRMWARE_EDID))
+#if !defined(CONFIG_X86) && defined(CONFIG_SYSFB)
 struct sysfb_display_info sysfb_primary_display __section(".data");
 EXPORT_SYMBOL_GPL(sysfb_primary_display);
 #endif
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a7144d275f54..1c9ac3b029a7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -62,25 +62,6 @@ config HDMI
 
 endif # HAS_IOMEM
 
-config FIRMWARE_EDID
-	bool "Enable firmware EDID"
-	depends on EFI_GENERIC_STUB || X86
-	help
-	  This enables access to the EDID transferred from the firmware.
-	  On EFI systems, the EDID comes from the same device as the
-	  primary GOP. On x86 with BIOS, it comes from the VESA BIOS.
-	  DRM display drivers will be able to export the information
-	  to userspace.
-
-	  Also enable this if DDC/I2C transfers do not work for your driver
-	  and if you are using nvidiafb, i810fb or savagefb.
-
-	  In general, choosing Y for this option is safe.  If you
-	  experience extremely long delays while booting before you get
-	  something on your display, try setting this to N.  Matrox cards in
-	  combination with certain motherboards and monitors are known to
-	  suffer from this problem.
-
 if VT
 	source "drivers/video/console/Kconfig"
 endif
-- 
2.53.0


