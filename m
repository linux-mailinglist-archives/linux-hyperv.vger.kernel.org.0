Return-Path: <linux-hyperv+bounces-11401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIuSF5M0G2qqAAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11401-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:03:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF230612F42
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D32B3023FAC
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E4A261B91;
	Sat, 30 May 2026 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSPs9c7E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H1ebBEtX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSPs9c7E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H1ebBEtX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7F233943
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167454; cv=none; b=rLeUzAk6yxCWd38FUlWDTGvTU95AvqXXQ7F5WnA7IN4FX5FCEju/DWaObPfqmrd2pgyxR4KpgNh9ucBtcD8mmay9c/yfkpHpGfV1MRk0GjXvFQzMbim9JdbBBOGGwCwsw4yuPFEdjMyADiVtS0+m95uy+1iaJ5S/pnK4gZt+zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167454; c=relaxed/simple;
	bh=T91+3azt+x6IL4IQTKcsljEPpyqZjofHBpvSJw4wivI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaJeB4R+J6YrBFhS0+QTq/k/4QYFStin0KxLwFLSDj86L6u71OUOFs6icxJIleveGtHj6sfh70cExJvLkBDFUUCzfvhb7cgBqPMD1cQG+FXKCwAg/LGLQB3dCNw8O000Z1dZw/s7GQl1EJab+jUjvQMyiLMJPyJdqXD5mTQ4JVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSPs9c7E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H1ebBEtX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSPs9c7E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H1ebBEtX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1299E6B545;
	Sat, 30 May 2026 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780167440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4ALwnmXQD3hgZLLwxHl2QgSChfXg6YwrRrxOOG5n/s=;
	b=zSPs9c7EiSC+FhLxRGSfkTK1M4/Xy0stqICiH6nvUKtm5cDJehleauIhZwOT++s/dl+iPu
	Q4F+1nezpoa5LZunCfKuNGBzQEgmRdCkF5uAYDnfduAqX3kXUWIMdZZnR3nUQiR/Tp5ZWH
	hiSiSif5TXwTvLlhFJ3AQmr+kaO7mIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780167440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4ALwnmXQD3hgZLLwxHl2QgSChfXg6YwrRrxOOG5n/s=;
	b=H1ebBEtX1aLWBDfZAakh/FN40Ej+SU54DB3T+sf8SkxwArkWzRlo3TaHzcaKZCT4/V96oW
	NzFDk5TEHPiiJYCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780167440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4ALwnmXQD3hgZLLwxHl2QgSChfXg6YwrRrxOOG5n/s=;
	b=zSPs9c7EiSC+FhLxRGSfkTK1M4/Xy0stqICiH6nvUKtm5cDJehleauIhZwOT++s/dl+iPu
	Q4F+1nezpoa5LZunCfKuNGBzQEgmRdCkF5uAYDnfduAqX3kXUWIMdZZnR3nUQiR/Tp5ZWH
	hiSiSif5TXwTvLlhFJ3AQmr+kaO7mIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780167440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4ALwnmXQD3hgZLLwxHl2QgSChfXg6YwrRrxOOG5n/s=;
	b=H1ebBEtX1aLWBDfZAakh/FN40Ej+SU54DB3T+sf8SkxwArkWzRlo3TaHzcaKZCT4/V96oW
	NzFDk5TEHPiiJYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94730779AA;
	Sat, 30 May 2026 18:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GInSIg8zG2rXUwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Sat, 30 May 2026 18:57:19 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	jani.nikula@linux.intel.com,
	mhklinux@outlook.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 03/10] drm/ingenic: Remove calls to drm_atomic_helper_check_plane_damage()
Date: Sat, 30 May 2026 20:53:16 +0200
Message-ID: <20260530185716.65688-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530185716.65688-1-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -6.79
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11401-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,broadcom.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF230612F42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Atomic helpers call drm_atomic_helper_check_plane_damage() after the
atomic_check anyway. See atomic_helper_check_planes(). Remove the calls
from the planes' atomic_check.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 3 ---
 drivers/gpu/drm/ingenic/ingenic-ipu.c     | 8 ++------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66..e99b44e3ac92 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -519,9 +519,6 @@ static int ingenic_drm_plane_atomic_check(struct drm_plane *plane,
 	     old_plane_state->fb->format->format != new_plane_state->fb->format->format))
 		crtc_state->mode_changed = true;
 
-	if (priv->soc_info->map_noncoherent)
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 56143a191f36..fd17c642c7ac 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -594,7 +594,7 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 
 	if (!new_plane_state->crtc ||
 	    !crtc_state->mode.hdisplay || !crtc_state->mode.vdisplay)
-		goto out_check_damage;
+		return 0;
 
 	/* Plane must be fully visible */
 	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0 ||
@@ -611,7 +611,7 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 
 	if (!osd_changed(new_plane_state, old_plane_state))
-		goto out_check_damage;
+		return 0;
 
 	crtc_state->mode_changed = true;
 
@@ -645,10 +645,6 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 	ipu_state->denom_w = denom_w;
 	ipu_state->denom_h = denom_h;
 
-out_check_damage:
-	if (ingenic_drm_map_noncoherent(ipu->master))
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
-
 	return 0;
 }
 
-- 
2.54.0


