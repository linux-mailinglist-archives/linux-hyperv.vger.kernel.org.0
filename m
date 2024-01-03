Return-Path: <linux-hyperv+bounces-1371-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FD7822B54
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3301C2325D
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F4D18B1E;
	Wed,  3 Jan 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHcGWhpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NNYLc3QI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHcGWhpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NNYLc3QI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B018ED1;
	Wed,  3 Jan 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8032921DC0;
	Wed,  3 Jan 2024 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704277602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZpgFua4U9Ebp6zBiIKyNXqSZj9M9qSoxsIA6dLryrk=;
	b=tHcGWhpgXEVBY4f2OPfK/OGgGqEn6pzyAf4ldBC5JLFyHpMhs3u+9Hz1TGCwIbQWYLuR33
	LPdbYqYhiUgnbM8rDuPfRF8fX5gM0vruPNpwG8zEK+tbw8iPN7jFZ5YdDL4aKaOnzjDYIR
	pHFgm5hvrw8qxTJ/9U96u/WJ/tiPVO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704277602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZpgFua4U9Ebp6zBiIKyNXqSZj9M9qSoxsIA6dLryrk=;
	b=NNYLc3QIeiz+NADlDIrFBFwQ7p4Taht5Y56r9mMZ7DeNQ9k7adVDOPSpwVGadp/dCRaBv+
	BtvAXgGufdWw0BBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704277602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZpgFua4U9Ebp6zBiIKyNXqSZj9M9qSoxsIA6dLryrk=;
	b=tHcGWhpgXEVBY4f2OPfK/OGgGqEn6pzyAf4ldBC5JLFyHpMhs3u+9Hz1TGCwIbQWYLuR33
	LPdbYqYhiUgnbM8rDuPfRF8fX5gM0vruPNpwG8zEK+tbw8iPN7jFZ5YdDL4aKaOnzjDYIR
	pHFgm5hvrw8qxTJ/9U96u/WJ/tiPVO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704277602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZpgFua4U9Ebp6zBiIKyNXqSZj9M9qSoxsIA6dLryrk=;
	b=NNYLc3QIeiz+NADlDIrFBFwQ7p4Taht5Y56r9mMZ7DeNQ9k7adVDOPSpwVGadp/dCRaBv+
	BtvAXgGufdWw0BBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3125D13C90;
	Wed,  3 Jan 2024 10:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MP3RCmI2lWWmfgAAD6G6ig
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
Subject: [PATCH 1/4] drm/hyperv: Remove firmware framebuffers with aperture helper
Date: Wed,  3 Jan 2024 11:15:09 +0100
Message-ID: <20240103102640.31751-2-tzimmermann@suse.de>
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
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.79
X-Spamd-Result: default: False [0.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com,redhat.com,gmx.de,microsoft.com,kernel.org,ffwll.ch];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.41)[77.98%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Replace use of screen_info state with the correct interface from
the aperture helpers. The state is only for architecture and firmware
code. It is not guaranteed to contain valid data. Drivers are thus
not allowed to use it.

For removing conflicting firmware framebuffers, there are aperture
helpers. Hence replace screen_info with the correct function that will
remove conflicting framebuffers for the hyperv-drm driver. Also
move the call to the correct place within the driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index d511d17c5bdf..cff85086f2d6 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -7,7 +7,6 @@
 #include <linux/hyperv.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/screen_info.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -73,11 +72,6 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 	struct drm_device *dev = &hv->dev;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SYSFB))
-		drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
-							     screen_info.lfb_size,
-							     &hyperv_driver);
-
 	hv->fb_size = (unsigned long)hv->mmio_megabytes * 1024 * 1024;
 
 	ret = vmbus_allocate_mmio(&hv->mem, hdev, 0, -1, hv->fb_size, 0x100000,
@@ -130,6 +124,8 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 		goto err_hv_set_drv_data;
 	}
 
+	drm_aperture_remove_framebuffers(&hyperv_driver);
+
 	ret = hyperv_setup_vram(hv, hdev);
 	if (ret)
 		goto err_vmbus_close;
-- 
2.43.0


