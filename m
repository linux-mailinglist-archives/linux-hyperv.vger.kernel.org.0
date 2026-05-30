Return-Path: <linux-hyperv+bounces-11400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGCtI2szG2rIAAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11400-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 20:58:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BBC612E63
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3102A300B5B6
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5025B0B0;
	Sat, 30 May 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="imll6nq9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qzfhjNjM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="imll6nq9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qzfhjNjM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21F2343BE
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167448; cv=none; b=miY2QP8uLlK/WqecLM5Y97iym3kq3JcgELXm4/mMVH+UJGCk2twjNJE3bMVbanMSWV6PCEZXkcY5Sydh++Y+qtGRl6JCoMlLrtiONPxwKoIuuPSgNiazf83TWGVvrXRFfXOrh9uU5cjgUt4NZVsHb+q+ElurrbMIM5ErGOjp+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167448; c=relaxed/simple;
	bh=ruV4fru7ad3IAU7zY7Va5FoMpdOE8RhlSdOHA8LZNX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXddKCpg6shicriLq88sKAUL08E0PrBGfcmH6OilzOsZStAQauNhG+31+mWfAfvDtIDKW6RAXkB9nAgf0voYxMA38xHoBekUKPIYjdazjEciXugz03+/R3iu+x55Q72ooQQlyqWuGimPFrqsjlVmW4GfEJKAHNWPIPO4ewEnA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=imll6nq9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qzfhjNjM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=imll6nq9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qzfhjNjM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 915E967348;
	Sat, 30 May 2026 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780167439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiyPaKF5ymwdGlXfSy/ZAjCSAiQcNXVhYvJrDcELBSw=;
	b=imll6nq9QaRr2mI4iwHHHX8N3DD0fVjDgfFtAZD7R1v3URi7mwvsmgiMEaX9FTT6UQt6R1
	v7zouSuD8hVr0ItZ6VctRaahLRlXY2b46lhX3wm/Mp06irdAd+BamyT+gUtQ0NOl6UFYRv
	NBcr2iANQQv4zF6GBjYP+pP57ZsQHUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780167439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiyPaKF5ymwdGlXfSy/ZAjCSAiQcNXVhYvJrDcELBSw=;
	b=qzfhjNjM2vxJI4YetuJ6DP4pxO05Bwc5Kpt0r4ex3yS28jUACEoR0fJAkDMz19ZDLLMNRG
	PhEkOgboOTTiDLAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780167439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiyPaKF5ymwdGlXfSy/ZAjCSAiQcNXVhYvJrDcELBSw=;
	b=imll6nq9QaRr2mI4iwHHHX8N3DD0fVjDgfFtAZD7R1v3URi7mwvsmgiMEaX9FTT6UQt6R1
	v7zouSuD8hVr0ItZ6VctRaahLRlXY2b46lhX3wm/Mp06irdAd+BamyT+gUtQ0NOl6UFYRv
	NBcr2iANQQv4zF6GBjYP+pP57ZsQHUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780167439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiyPaKF5ymwdGlXfSy/ZAjCSAiQcNXVhYvJrDcELBSw=;
	b=qzfhjNjM2vxJI4YetuJ6DP4pxO05Bwc5Kpt0r4ex3yS28jUACEoR0fJAkDMz19ZDLLMNRG
	PhEkOgboOTTiDLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FBBA779A9;
	Sat, 30 May 2026 18:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJCcAg8zG2rXUwAAD6G6ig
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
Subject: [PATCH v4 02/10] drm/atomic-helpers: Evaluate plane damage after atomic_check
Date: Sat, 30 May 2026 20:53:15 +0200
Message-ID: <20260530185716.65688-3-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11400-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 38BBC612E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Each plane's and CRTC's atomic_check might trigger a full modeset. As
this affects the plane's damage handling, evaluate damage clips after
running the atomic_check helpers.

Examples can be found in a number of drivers, such as ast, gud, ingenic,
mgag200 or vmwgfx, which all set mode_changed in the CRTC state to true.
Ingenic even re-evaluates damage information in its plane's atomic_check.
Doing this after the atomic_check helpers ran benefits all drivers.

There's already a damage evaluation before the calls to atomic_check.
With a few fixes to drivers, this can be removed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 51f39edc31ed..4c37299e8ccb 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1065,6 +1065,10 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 		}
 	}
 
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
+		drm_atomic_helper_check_plane_damage(state, new_plane_state);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_planes);
-- 
2.54.0


