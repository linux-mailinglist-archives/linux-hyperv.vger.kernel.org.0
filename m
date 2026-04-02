Return-Path: <linux-hyperv+bounces-9901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IPAOf84zmmAmAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9901-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:38:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D77773870AB
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EB8A30BAB94
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAED1386567;
	Thu,  2 Apr 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0js1rDWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tyx81et7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0js1rDWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tyx81et7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C238B7DB
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Apr 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121836; cv=none; b=GPVX4vcqtK/Apx0QbuakTu92i6iJFNmTd/tZxq/HDB7D7ik82cM3psiSg+h6CRWFwy3zkq7y6KPqv5hm+xP3iPwrhuTnNmDE3DyFfnIK+TzfMW9+Mkisl2Fk4zbxQ0cASAPG2UeISK5WEz+hisujOGQQ1aKo1JRox/cPfc7tsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121836; c=relaxed/simple;
	bh=LY8tDdfC9tmW4VeQ+wRrAf1JhUIqvuwytx+ZFRGtaQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhNoz21aaxET07p8YxfMmsBLveEZ6SCeYKGA4LOq8qxg2A4aMk/gRm80IjVouwFOJPVlfUrHxBOEg7jfqo940ZbSyLJnBHzmcZ8RX/niuAdju6WY5p32oIQ6pqkMPrrHf2r1f1ViwKd32uLAB/dGVhq6bulE5G+b7yvHoB259Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0js1rDWn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tyx81et7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0js1rDWn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tyx81et7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCFC65BDAC;
	Thu,  2 Apr 2026 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775121793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPCEYbiGOCpx2zUalDos08LGZhiPvMU5VsFjS8QK76U=;
	b=0js1rDWnH9smqDqLDvIAKHV8/eXXpqQLMMmO2TI8gDpO96XoYOJ31GNYVGDIhbudXFZi9G
	RQ/O7aJULE82Ey6TA6L6DSH8P2yEi8bpC87AmYkQUvPUMU9qrvfDUU3Q8uptTAtDg3jYPP
	Io9AeuySbfgnMZqPfHt6jtJYVMlHoo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775121793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPCEYbiGOCpx2zUalDos08LGZhiPvMU5VsFjS8QK76U=;
	b=Tyx81et7F7PdaU5+qsAtZ653DbZ7+SrFuesp7ACsEj//SHAzWobwR7Yrj7KdApo1hOLQaG
	JiNq8qBG9bZiwyDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775121793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPCEYbiGOCpx2zUalDos08LGZhiPvMU5VsFjS8QK76U=;
	b=0js1rDWnH9smqDqLDvIAKHV8/eXXpqQLMMmO2TI8gDpO96XoYOJ31GNYVGDIhbudXFZi9G
	RQ/O7aJULE82Ey6TA6L6DSH8P2yEi8bpC87AmYkQUvPUMU9qrvfDUU3Q8uptTAtDg3jYPP
	Io9AeuySbfgnMZqPfHt6jtJYVMlHoo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775121793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPCEYbiGOCpx2zUalDos08LGZhiPvMU5VsFjS8QK76U=;
	b=Tyx81et7F7PdaU5+qsAtZ653DbZ7+SrFuesp7ACsEj//SHAzWobwR7Yrj7KdApo1hOLQaG
	JiNq8qBG9bZiwyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C4C74A0B1;
	Thu,  2 Apr 2026 09:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oLbDCIE1zmlVYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:13 +0000
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
Subject: [PATCH 5/8] firmware: sysfb: Implement screen_info relocation for primary display
Date: Thu,  2 Apr 2026 11:09:19 +0200
Message-ID: <20260402092305.208728-6-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9901-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D77773870AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the relocation tracking for screen_info from the screen_info
helpers to sysfb. The relocation code operates on sysfb_primary_display,
which belongs to sysfb. The remaining screen_info helpers are now free
from global state.

Adapt some symbol names. Now prefer early returns in the helper
sysfb_apply_screen_info_fixup() over nested branching. Also return an
errno code from sysfb_apply_screen_info_fixup() if the relocation
failed. In this case, do not create a device for the framebuffer.
The original code advertised this behavior in a comment but never
implemented it.

Framebuffer aperture relocation can happen during boot if the PCI
graphics device is located behind a PCI bridge. If the bridge's sub-
bus gets relocated, the framebuffer aperture moves accordingly. The
helper for tracking these relocations fixes up the values stored in
sysfb_primary_display so that they refer to the correct address range
again. Generic system-framebuffer drivers would not work otherwise.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/sysfb.h         |   5 ++
 drivers/firmware/sysfb_pci.c     | 111 +++++++++++++++++++++++++++++++
 drivers/firmware/sysfb_primary.c |   9 ++-
 drivers/video/screen_info_pci.c  | 110 ------------------------------
 include/linux/screen_info.h      |   3 -
 5 files changed, 123 insertions(+), 115 deletions(-)

diff --git a/drivers/firmware/sysfb.h b/drivers/firmware/sysfb.h
index 9f7fe2e03f68..1eaa3b0fa364 100644
--- a/drivers/firmware/sysfb.h
+++ b/drivers/firmware/sysfb.h
@@ -8,8 +8,13 @@
 struct pci_dev;
 
 #ifdef CONFIG_PCI
+int sysfb_apply_screen_info_fixups(void);
 bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev);
 #else
+static inline int sysfb_apply_screen_info_fixups(void)
+{
+	return 0;
+}
 static inline bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
 {
 	return false;
diff --git a/drivers/firmware/sysfb_pci.c b/drivers/firmware/sysfb_pci.c
index 8f3adeef4fb1..d972750c6bc6 100644
--- a/drivers/firmware/sysfb_pci.c
+++ b/drivers/firmware/sysfb_pci.c
@@ -1,9 +1,120 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/pci.h>
+#include <linux/printk.h>
+#include <linux/screen_info.h>
+#include <linux/sysfb.h>
 
 #include "sysfb.h"
 
+static struct pci_dev *sysfb_lfb_pdev;
+static size_t sysfb_lfb_bar;
+static resource_size_t sysfb_lfb_res_start; // original start of resource
+static resource_size_t sysfb_lfb_offset; // framebuffer offset within resource
+
+static bool __sysfb_relocation_is_valid(const struct screen_info *si, struct resource *pr)
+{
+	u64 size = __screen_info_lfb_size(si, screen_info_video_type(si));
+
+	if (sysfb_lfb_offset > resource_size(pr))
+		return false;
+	if (size > resource_size(pr))
+		return false;
+	if (resource_size(pr) - size < sysfb_lfb_offset)
+		return false;
+
+	return true;
+}
+
+int sysfb_apply_screen_info_fixups(void)
+{
+	struct screen_info *si = &sysfb_primary_display.screen;
+	struct resource *pr;
+
+	if (!sysfb_lfb_pdev)
+		return 0; /* primary display is not on a PCI device */
+
+	pr = &sysfb_lfb_pdev->resource[sysfb_lfb_bar];
+
+	if (pr->start == sysfb_lfb_res_start)
+		return 0; /* no relocation took place */
+
+	if (!__sysfb_relocation_is_valid(si, pr))
+		return -ENXIO;
+
+	/*
+	 * Only update base if we have an actual relocation to a valid I/O range.
+	 */
+	__screen_info_set_lfb_base(si, pr->start + sysfb_lfb_offset);
+	pr_info("Relocating firmware framebuffer to offset %pa[d] within %pr\n",
+		&sysfb_lfb_offset, pr);
+
+	return 0;
+}
+
+static int __screen_info_lfb_pci_bus_region(const struct screen_info *si, unsigned int type,
+					    struct pci_bus_region *r)
+{
+	u64 base, size;
+
+	base = __screen_info_lfb_base(si);
+	if (!base)
+		return -EINVAL;
+
+	size = __screen_info_lfb_size(si, type);
+	if (!size)
+		return -EINVAL;
+
+	r->start = base;
+	r->end = base + size - 1;
+
+	return 0;
+}
+
+static void sysfb_fixup_lfb(struct pci_dev *pdev)
+{
+	unsigned int type;
+	struct pci_bus_region bus_region;
+	int ret;
+	struct resource r = {
+		.flags = IORESOURCE_MEM,
+	};
+	const struct resource *pr;
+	const struct screen_info *si = &sysfb_primary_display.screen;
+
+	if (sysfb_lfb_pdev)
+		return; // already found
+
+	type = screen_info_video_type(si);
+	if (!__screen_info_has_lfb(type))
+		return; // only applies to EFI; maybe VESA
+
+	ret = __screen_info_lfb_pci_bus_region(si, type, &bus_region);
+	if (ret < 0)
+		return;
+
+	/*
+	 * Translate the PCI bus address to resource. Account for an offset if
+	 * the framebuffer is behind a PCI host bridge.
+	 */
+	pcibios_bus_to_resource(pdev->bus, &r, &bus_region);
+
+	pr = pci_find_resource(pdev, &r);
+	if (!pr)
+		return;
+
+	/*
+	 * We've found a PCI device with the framebuffer resource. Store away
+	 * the parameters to track relocation of the framebuffer aperture.
+	 */
+	sysfb_lfb_pdev = pdev;
+	sysfb_lfb_bar = pr - pdev->resource;
+	sysfb_lfb_offset = r.start - pr->start;
+	sysfb_lfb_res_start = bus_region.start;
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
+			       sysfb_fixup_lfb);
+
 bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
 {
 	/*
diff --git a/drivers/firmware/sysfb_primary.c b/drivers/firmware/sysfb_primary.c
index ab8d7fc468bb..298f87a43a7e 100644
--- a/drivers/firmware/sysfb_primary.c
+++ b/drivers/firmware/sysfb_primary.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/screen_info.h>
 #include <linux/sysfb.h>
 
@@ -127,11 +128,15 @@ static __init int sysfb_init(void)
 	struct simplefb_platform_data mode;
 	const char *name;
 	bool compatible;
-	int ret = 0;
+	int ret;
 
-	screen_info_apply_fixups();
+	ret = sysfb_apply_screen_info_fixups();
 
 	mutex_lock(&disable_lock);
+	if (ret) {
+		pr_warn("Invalid relocation, disabling system framebuffer\n");
+		disabled = true; /* screen_info relocation failed */
+	}
 	if (disabled)
 		goto unlock_mutex;
 
diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 8f34d8a74f09..d8985a54ce71 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -1,117 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/pci.h>
-#include <linux/printk.h>
 #include <linux/screen_info.h>
-#include <linux/string.h>
-#include <linux/sysfb.h>
-
-static struct pci_dev *screen_info_lfb_pdev;
-static size_t screen_info_lfb_bar;
-static resource_size_t screen_info_lfb_res_start; // original start of resource
-static resource_size_t screen_info_lfb_offset; // framebuffer offset within resource
-
-static bool __screen_info_relocation_is_valid(const struct screen_info *si, struct resource *pr)
-{
-	u64 size = __screen_info_lfb_size(si, screen_info_video_type(si));
-
-	if (screen_info_lfb_offset > resource_size(pr))
-		return false;
-	if (size > resource_size(pr))
-		return false;
-	if (resource_size(pr) - size < screen_info_lfb_offset)
-		return false;
-
-	return true;
-}
-
-void screen_info_apply_fixups(void)
-{
-	struct screen_info *si = &sysfb_primary_display.screen;
-
-	if (screen_info_lfb_pdev) {
-		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
-
-		if (pr->start != screen_info_lfb_res_start) {
-			if (__screen_info_relocation_is_valid(si, pr)) {
-				/*
-				 * Only update base if we have an actual
-				 * relocation to a valid I/O range.
-				 */
-				__screen_info_set_lfb_base(si, pr->start + screen_info_lfb_offset);
-				pr_info("Relocating firmware framebuffer to offset %pa[d] within %pr\n",
-					&screen_info_lfb_offset, pr);
-			} else {
-				pr_warn("Invalid relocating, disabling firmware framebuffer\n");
-			}
-		}
-	}
-}
-
-static int __screen_info_lfb_pci_bus_region(const struct screen_info *si, unsigned int type,
-					    struct pci_bus_region *r)
-{
-	u64 base, size;
-
-	base = __screen_info_lfb_base(si);
-	if (!base)
-		return -EINVAL;
-
-	size = __screen_info_lfb_size(si, type);
-	if (!size)
-		return -EINVAL;
-
-	r->start = base;
-	r->end = base + size - 1;
-
-	return 0;
-}
-
-static void screen_info_fixup_lfb(struct pci_dev *pdev)
-{
-	unsigned int type;
-	struct pci_bus_region bus_region;
-	int ret;
-	struct resource r = {
-		.flags = IORESOURCE_MEM,
-	};
-	const struct resource *pr;
-	const struct screen_info *si = &sysfb_primary_display.screen;
-
-	if (screen_info_lfb_pdev)
-		return; // already found
-
-	type = screen_info_video_type(si);
-	if (!__screen_info_has_lfb(type))
-		return; // only applies to EFI; maybe VESA
-
-	ret = __screen_info_lfb_pci_bus_region(si, type, &bus_region);
-	if (ret < 0)
-		return;
-
-	/*
-	 * Translate the PCI bus address to resource. Account
-	 * for an offset if the framebuffer is behind a PCI host
-	 * bridge.
-	 */
-	pcibios_bus_to_resource(pdev->bus, &r, &bus_region);
-
-	pr = pci_find_resource(pdev, &r);
-	if (!pr)
-		return;
-
-	/*
-	 * We've found a PCI device with the framebuffer
-	 * resource. Store away the parameters to track
-	 * relocation of the framebuffer aperture.
-	 */
-	screen_info_lfb_pdev = pdev;
-	screen_info_lfb_bar = pr - pdev->resource;
-	screen_info_lfb_offset = r.start - pr->start;
-	screen_info_lfb_res_start = bus_region.start;
-}
-DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
-			       screen_info_fixup_lfb);
 
 static struct pci_dev *__screen_info_pci_dev(struct resource *res)
 {
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index c022403c599a..2adbe25b88d8 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -140,11 +140,8 @@ u32 __screen_info_lfb_bits_per_pixel(const struct screen_info *si);
 int screen_info_pixel_format(const struct screen_info *si, struct pixel_format *f);
 
 #if defined(CONFIG_PCI)
-void screen_info_apply_fixups(void);
 struct pci_dev *screen_info_pci_dev(const struct screen_info *si);
 #else
-static inline void screen_info_apply_fixups(void)
-{ }
 static inline struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
 {
 	return NULL;
-- 
2.53.0


