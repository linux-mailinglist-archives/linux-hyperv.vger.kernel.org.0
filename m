Return-Path: <linux-hyperv+bounces-11597-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vK3EAmeGKWrCYgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11597-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 17:44:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FE466AF74
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 17:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LErn801m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/gj2oqwe";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LErn801m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/gj2oqwe";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11597-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11597-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BE4A3045429
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431D40861F;
	Wed, 10 Jun 2026 15:26:22 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F474279E3
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 15:26:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105182; cv=none; b=jcflP+jw6rMg+gjY3U5PA/RT0DiEkzMuz3kg8SOR7lCjymnYZ4pQtwHyGnjE1wGk0jfYk+MDbJVCJ3dXqZjgdwQW/x1U2cu80ds74i4ywlQrbzDo7735RAgTha3z9W5h3T2jKZJWV47x1Hs0MOFtd58xefu8+TRJ6N06sqMyrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105182; c=relaxed/simple;
	bh=EtB5zUdqQxGY0QLd9me2IGQntms8ZG2oiNylF+JVeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/KTtxtrkuhpKEf4kxwaq3WZgGiNPJ0JTanOWv2HmY3lsqmzyYa1+R2Gzn7SHlOglIsqNB/mPXMtTis6fb4DaZUxBJ9kr7VDSSbsX3UqFBoHEMhJ+Ln3Szt6TeQD9s31p8xH3e0XyOyF2sq4jenH9hTKwYLN28XBbHF6dwjyXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LErn801m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gj2oqwe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LErn801m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gj2oqwe; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 344C76AED7;
	Wed, 10 Jun 2026 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
	b=LErn801mgf0Wj2MbLzMjH9WR8A2GfoXtHgvC4Kgg5XcqnGRLO4WucHIqSMIrl9LtfjaeJ3
	f9JoFG9cSP6BSKsvEq7MmOxOs7hVOJR9ECVZZWlTUHvYhFHKBFiIKfdSB3QFi9ZzPTIQis
	ulr4+xns++2oB5B/UpyPg9/sEjHHbIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
	b=/gj2oqweTBBHd8ryXjO4cluY8v9LaZrF9oBqMR+EgAOTTCUNVGdHRhxkxrt1O82U3YVqhq
	Wx/f6dDn0M5okzCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
	b=LErn801mgf0Wj2MbLzMjH9WR8A2GfoXtHgvC4Kgg5XcqnGRLO4WucHIqSMIrl9LtfjaeJ3
	f9JoFG9cSP6BSKsvEq7MmOxOs7hVOJR9ECVZZWlTUHvYhFHKBFiIKfdSB3QFi9ZzPTIQis
	ulr4+xns++2oB5B/UpyPg9/sEjHHbIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5UtJ6eV6iOSreVQ99DfSSH13XZuuKC0qy/3UHtKhSU=;
	b=/gj2oqweTBBHd8ryXjO4cluY8v9LaZrF9oBqMR+EgAOTTCUNVGdHRhxkxrt1O82U3YVqhq
	Wx/f6dDn0M5okzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6098A779A9;
	Wed, 10 Jun 2026 15:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +JMmFuSBKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:24 +0000
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
	mhklkml@zohomail.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	javierm@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 15/15] drm/vmwgfx: Remove unused field struct vmwgfx_du_update_plane.old_state
Date: Wed, 10 Jun 2026 17:18:31 +0200
Message-ID: <20260610152505.260172-16-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.79
X-Spam-Level: 
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-11597-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mripard@kernel.org,m:maarten.lankhorst@linux.intel.com,m:airlied@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:admin@kodeit.net,m:gargaditya08@proton.me,m:paul@crapouillou.net,m:jani.nikula@linux.intel.com,m:mhklkml@zohomail.com,m:zack.rusin@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:javierm@redhat.com,m:dmitry.osipenko@collabora.com,m:gurchetansingh@chromium.org,m:olvaffe@gmail.com,m:dri-devel@lists.freedesktop.org,m:linux-hyperv@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:linux-mips@vger.kernel.org,m:virtualization@lists.linux.dev,m:amd-gfx@lists.freedesktop.org,m:tzimmermann@suse.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,vger.kernel.org:from_smtp,broadcom.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02FE466AF74

Plane updates no longer require the old plane state. Remove the field
from struct vmwgfx_du_update_plane and fix all callers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 --
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 12 ++----------
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 11 ++---------
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 2224d7d91d1b..8c2072b82062 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -19,7 +19,6 @@
 /**
  * struct vmw_du_update_plane - Closure structure for vmw_du_helper_plane_update
  * @plane: Plane which is being updated.
- * @old_state: Old state of plane.
  * @dev_priv: Device private.
  * @du: Display unit on which to update the plane.
  * @vfb: Framebuffer which is blitted to display unit.
@@ -102,7 +101,6 @@ struct vmw_du_update_plane {
 				    struct drm_rect *bb);
 
 	struct drm_plane *plane;
-	struct drm_plane_state *old_state;
 	struct vmw_private *dev_priv;
 	struct vmw_display_unit *du;
 	struct vmw_framebuffer *vfb;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index c83061cf7455..fa84bc7ab5bb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -530,7 +530,6 @@ static uint32_t vmw_stud_bo_post_clip(struct vmw_du_update_plane  *update,
  */
 static int vmw_sou_plane_update_bo(struct vmw_private *dev_priv,
 				   struct drm_plane *plane,
-				   struct drm_plane_state *old_state,
 				   struct vmw_framebuffer *vfb,
 				   struct vmw_fence_obj **out_fence)
 {
@@ -538,7 +537,6 @@ static int vmw_sou_plane_update_bo(struct vmw_private *dev_priv,
 
 	memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
 	bo_update.base.plane = plane;
-	bo_update.base.old_state = old_state;
 	bo_update.base.dev_priv = dev_priv;
 	bo_update.base.du = vmw_crtc_to_du(plane->state->crtc);
 	bo_update.base.vfb = vfb;
@@ -692,7 +690,6 @@ static uint32_t vmw_sou_surface_post_clip(struct vmw_du_update_plane *update,
  */
 static int vmw_sou_plane_update_surface(struct vmw_private *dev_priv,
 					struct drm_plane *plane,
-					struct drm_plane_state *old_state,
 					struct vmw_framebuffer *vfb,
 					struct vmw_fence_obj **out_fence)
 {
@@ -700,7 +697,6 @@ static int vmw_sou_plane_update_surface(struct vmw_private *dev_priv,
 
 	memset(&srf_update, 0, sizeof(struct vmw_du_update_plane_surface));
 	srf_update.base.plane = plane;
-	srf_update.base.old_state = old_state;
 	srf_update.base.dev_priv = dev_priv;
 	srf_update.base.du = vmw_crtc_to_du(plane->state->crtc);
 	srf_update.base.vfb = vfb;
@@ -721,7 +717,6 @@ static void
 vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_atomic_commit *state)
 {
-	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc *crtc = new_state->crtc;
 	struct vmw_fence_obj *fence = NULL;
@@ -734,12 +729,9 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 			vmw_framebuffer_to_vfb(new_state->fb);
 
 		if (vfb->bo)
-			ret = vmw_sou_plane_update_bo(dev_priv, plane,
-						      old_state, vfb, &fence);
+			ret = vmw_sou_plane_update_bo(dev_priv, plane, vfb, &fence);
 		else
-			ret = vmw_sou_plane_update_surface(dev_priv, plane,
-							   old_state, vfb,
-							   &fence);
+			ret = vmw_sou_plane_update_surface(dev_priv, plane, vfb, &fence);
 		if (ret != 0)
 			DRM_ERROR("Failed to update screen.\n");
 	} else {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index f0df2b1c8465..474e3badb80f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1240,7 +1240,6 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
  */
 static int vmw_stdu_plane_update_bo(struct vmw_private *dev_priv,
 				    struct drm_plane *plane,
-				    struct drm_plane_state *old_state,
 				    struct vmw_framebuffer *vfb,
 				    struct vmw_fence_obj **out_fence)
 {
@@ -1248,7 +1247,6 @@ static int vmw_stdu_plane_update_bo(struct vmw_private *dev_priv,
 
 	memset(&bo_update, 0, sizeof(struct vmw_du_update_plane_buffer));
 	bo_update.base.plane = plane;
-	bo_update.base.old_state = old_state;
 	bo_update.base.dev_priv = dev_priv;
 	bo_update.base.du = vmw_crtc_to_du(plane->state->crtc);
 	bo_update.base.vfb = vfb;
@@ -1350,7 +1348,6 @@ vmw_stdu_surface_populate_update(struct vmw_du_update_plane  *update, void *cmd,
  */
 static int vmw_stdu_plane_update_surface(struct vmw_private *dev_priv,
 					 struct drm_plane *plane,
-					 struct drm_plane_state *old_state,
 					 struct vmw_framebuffer *vfb,
 					 struct vmw_fence_obj **out_fence)
 {
@@ -1363,7 +1360,6 @@ static int vmw_stdu_plane_update_surface(struct vmw_private *dev_priv,
 
 	memset(&srf_update, 0, sizeof(struct vmw_du_update_plane));
 	srf_update.plane = plane;
-	srf_update.old_state = old_state;
 	srf_update.dev_priv = dev_priv;
 	srf_update.du = vmw_crtc_to_du(plane->state->crtc);
 	srf_update.vfb = vfb;
@@ -1424,12 +1420,9 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 			DRM_ERROR("Failed to bind surface to STDU.\n");
 
 		if (vfb->bo)
-			ret = vmw_stdu_plane_update_bo(dev_priv, plane,
-						       old_state, vfb, &fence);
+			ret = vmw_stdu_plane_update_bo(dev_priv, plane, vfb, &fence);
 		else
-			ret = vmw_stdu_plane_update_surface(dev_priv, plane,
-							    old_state, vfb,
-							    &fence);
+			ret = vmw_stdu_plane_update_surface(dev_priv, plane, vfb, &fence);
 		if (ret)
 			DRM_ERROR("Failed to update STDU.\n");
 	} else {
-- 
2.54.0


