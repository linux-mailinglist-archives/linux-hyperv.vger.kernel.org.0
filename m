Return-Path: <linux-hyperv+bounces-6685-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDFCB3E14D
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Sep 2025 13:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904323B9A6D
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Sep 2025 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A02C20DD48;
	Mon,  1 Sep 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VrJvExIt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hgtevAuw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VrJvExIt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hgtevAuw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F961DFE09
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Sep 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725345; cv=none; b=lGkMoq70MWjEwM9WtjaCoLPP8+Tq4FOpdMGNLpvlo4pR25JjwPV1AkKzFENuAzRYikv7r+9qQgaQzBcUeJ7Z9NKRNcclUcLxAOjrvf+fmYRt754fIs5c2LIpfrWBUntNS+8uLWIN1Yn0PfrJk/elS4ssFJ0qhrTqhHcxVR4e3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725345; c=relaxed/simple;
	bh=0iKZvNO9UVasoNxnA879UcIKfh0PuShdMZxs7KUzVhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjBBmHt8Wi/gw+lgKoBogwoGIV4YQHQrNBo+K7MQXEnOFv/vQrBZ+0q7GC8umWEADOg8AXpOP+pr35kwgGdSLm8RH5Q9BpBWfMUVo+RqwPY1puiGv4yTSEvIe6KXN9FDLDnXMb9IR7sF+mcr4IhBdHEGsp2j+444MG0wda8prWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VrJvExIt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hgtevAuw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VrJvExIt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hgtevAuw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B93021180;
	Mon,  1 Sep 2025 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756725331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNlEKjcas2C79/RY/7iuhPMbmhP/3pGikTSlrwaP5q4=;
	b=VrJvExItl86CxZ5YHtsd8GgZTr/sfmbMHjsT9Og5zeccHpROn6WX9HKeh0b5jNmk1YkIgI
	KZZud7wRGjRQIEmzPYFJK/ih4Dy/IcT42QPjeXiLKaYqN+/QI/ADK0fMueJXSPUnPGIjJd
	G1FVZW1Ilm0HmGnfIC3qN3QIsxQDaJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756725331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNlEKjcas2C79/RY/7iuhPMbmhP/3pGikTSlrwaP5q4=;
	b=hgtevAuwmanFC0094z/i6K1XRCLtFz3Q+of3Wjzq6C1V3srxUlAwsz3+wyAWfhC7cIz5aW
	ehd4DDSW3WRxOUAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756725331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNlEKjcas2C79/RY/7iuhPMbmhP/3pGikTSlrwaP5q4=;
	b=VrJvExItl86CxZ5YHtsd8GgZTr/sfmbMHjsT9Og5zeccHpROn6WX9HKeh0b5jNmk1YkIgI
	KZZud7wRGjRQIEmzPYFJK/ih4Dy/IcT42QPjeXiLKaYqN+/QI/ADK0fMueJXSPUnPGIjJd
	G1FVZW1Ilm0HmGnfIC3qN3QIsxQDaJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756725331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNlEKjcas2C79/RY/7iuhPMbmhP/3pGikTSlrwaP5q4=;
	b=hgtevAuwmanFC0094z/i6K1XRCLtFz3Q+of3Wjzq6C1V3srxUlAwsz3+wyAWfhC7cIz5aW
	ehd4DDSW3WRxOUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 063BD1378C;
	Mon,  1 Sep 2025 11:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MPpSAFOAtWj8EAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Sep 2025 11:15:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: louis.chauvet@bootlin.com,
	drawat.floss@gmail.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	mhklinux@outlook.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/4] drm/hypervdrm: Use vblank timer
Date: Mon,  1 Sep 2025 13:07:01 +0200
Message-ID: <20250901111241.233875-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901111241.233875-1-tzimmermann@suse.de>
References: <20250901111241.233875-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_RATELIMIT(0.00)[to_ip_from(RLgb6padn6wcu17bxtda1k7h6p)];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,outlook.com,ffwll.ch,linux.intel.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

HyperV's virtual hardware does not provide vblank interrupts. Use a
vblank timer to simulate the interrupt. Rate-limits the display's
update frequency to the display-mode settings. Avoids excessive CPU
overhead with compositors that do not rate-limit their output.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 945b9482bcb3..6e6eb1c12a68 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -19,6 +19,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_panic.h>
 #include <drm/drm_plane.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_vblank_helper.h>
 
 #include "hyperv_drm.h"
 
@@ -111,11 +113,15 @@ static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 				crtc_state->mode.hdisplay,
 				crtc_state->mode.vdisplay,
 				plane_state->fb->pitches[0]);
+
+	drm_crtc_vblank_on(crtc);
 }
 
 static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
 	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_flush = drm_crtc_vblank_atomic_flush,
 	.atomic_enable = hyperv_crtc_helper_atomic_enable,
+	.atomic_disable = drm_crtc_vblank_atomic_disable,
 };
 
 static const struct drm_crtc_funcs hyperv_crtc_funcs = {
@@ -125,6 +131,7 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 
 static int hyperv_plane_atomic_check(struct drm_plane *plane,
@@ -321,6 +328,10 @@ int hyperv_mode_config_init(struct hyperv_drm_device *hv)
 		return ret;
 	}
 
+	ret = drm_vblank_init(dev, 1);
+	if (ret)
+		return ret;
+
 	drm_mode_config_reset(dev);
 
 	return 0;
-- 
2.50.1


