Return-Path: <linux-hyperv+bounces-11590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4dLKHVmGKWq6YgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11590-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 17:44:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D616766AF52
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 17:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11590-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11590-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE6333089C8F
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0A428470;
	Wed, 10 Jun 2026 15:25:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7A42846D
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 15:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105145; cv=none; b=HuF/Pl1DRn28bFId8IYY7pQDgSij5aG0nQlA6Ux70zifnpc/gC8NrpP4uyv6IGahwhEX4GuZG0NvxhfyTtO6PLUwNKqN5PsFv/RqkiRNLchalKX89FysVY8CF1A7fR51VJwMQtyDsDAJ9LyCKgsEm4uQ++HiEam6TGxEadSsA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105145; c=relaxed/simple;
	bh=q/iZn3VdBpBI5R8nWbzmBp4ROWGf16+CLt3rxNOf02c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoFeNHFQZSjc9425WlKaHnyfzDobqZZ4GOCSndVd+hQTeiX3SROeL5q+cij7PRoA39v8avjZRVREBn8qjDYTbSy+hc1oXEPZs8Wv58+pt1WFn5ccxE2si926bIukzX0/E4y1LA6M2/m5Ds9qvxmQOA0kbdpv3rz05U+5t5Mp3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88C45759E7;
	Wed, 10 Jun 2026 15:25:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A917B779A7;
	Wed, 10 Jun 2026 15:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAUPKOGBKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:21 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH v5 12/15] drm/damage-helper: Remove old state from drm_atomic_helper_damage_iter_init()
Date: Wed, 10 Jun 2026 17:18:28 +0200
Message-ID: <20260610152505.260172-13-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11590-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:mripard@kernel.org,m:maarten.lankhorst@linux.intel.com,m:airlied@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:admin@kodeit.net,m:gargaditya08@proton.me,m:paul@crapouillou.net,m:jani.nikula@linux.intel.com,m:mhklkml@zohomail.com,m:zack.rusin@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:javierm@redhat.com,m:dmitry.osipenko@collabora.com,m:gurchetansingh@chromium.org,m:olvaffe@gmail.com,m:dri-devel@lists.freedesktop.org,m:linux-hyperv@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:linux-mips@vger.kernel.org,m:virtualization@lists.linux.dev,m:amd-gfx@lists.freedesktop.org,m:tzimmermann@suse.de,m:hamzamahfooz@linux.microsoft.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:email,suse.de:mid,suse.de:from_mime,broadcom.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D616766AF52

Nothing in drm_atomic_helper_damage_iter_init() requires the old
plane state. Remove the parameter and mass-convert callers.

Most callers now no longer require the old plane state in their plane's
atomic_update helper. Remove it as well.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> # hyperv
---
 drivers/gpu/drm/ast/ast_mode.c                |  2 +-
 drivers/gpu/drm/drm_damage_helper.c           |  4 +-
 drivers/gpu/drm/drm_fb_dma_helper.c           |  2 +-
 drivers/gpu/drm/gud/gud_pipe.c                |  3 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |  3 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c        |  3 +-
 drivers/gpu/drm/sitronix/st7571.c             |  3 +-
 drivers/gpu/drm/sitronix/st7920.c             |  3 +-
 drivers/gpu/drm/solomon/ssd130x.c             |  9 +--
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c     |  3 +-
 .../gpu/drm/tests/drm_damage_helper_test.c    | 55 ++++++-------------
 drivers/gpu/drm/tiny/appletbdrm.c             |  8 +--
 drivers/gpu/drm/tiny/bochs.c                  |  3 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c            |  2 +-
 drivers/gpu/drm/udl/udl_modeset.c             |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |  5 +-
 include/drm/drm_damage_helper.h               |  3 +-
 17 files changed, 37 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index d5ed8c5c7925..6fe3fda6d145 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -579,7 +579,7 @@ static void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
 
 	/* if the buffer comes from another device */
 	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) == 0) {
-		drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+		drm_atomic_helper_damage_iter_init(&iter, plane_state);
 		drm_atomic_for_each_plane_damage(&iter, &damage) {
 			ast_handle_damage(ast_plane, shadow_plane_state->data, fb, &damage,
 					  &shadow_plane_state->fmtcnv_state);
diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index f492a59edbeb..28f26234523d 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -209,7 +209,6 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
 /**
  * drm_atomic_helper_damage_iter_init - Initialize the damage iterator.
  * @iter: The iterator to initialize.
- * @old_state: Unused, pass NULL.
  * @state: Plane state from which to iterate the damage clips.
  *
  * Initialize an iterator, which clips plane damage
@@ -226,7 +225,6 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
  */
 void
 drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
-				   const struct drm_plane_state *old_state,
 				   const struct drm_plane_state *state)
 {
 	struct drm_rect src;
@@ -324,7 +322,7 @@ bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
 	rect->x2 = 0;
 	rect->y2 = 0;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
+	drm_atomic_helper_damage_iter_init(&iter, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		rect->x1 = min(rect->x1, clip.x1);
 		rect->y1 = min(rect->y1, clip.y1);
diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index fd71969d2fb1..bbad16d32b6f 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -138,7 +138,7 @@ void drm_fb_dma_sync_non_coherent(struct drm_device *drm,
 			continue;
 
 		daddr = drm_fb_dma_get_gem_addr(state->fb, state, i);
-		drm_atomic_helper_damage_iter_init(&iter, old_state, state);
+		drm_atomic_helper_damage_iter_init(&iter, state);
 
 		drm_atomic_for_each_plane_damage(&iter, &clip) {
 			/* Ignore x1/x2 values, invalidate complete lines */
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 5ef887d8485a..758990cd78aa 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -618,7 +618,6 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 {
 	struct drm_device *drm = plane->dev;
 	struct gud_device *gdrm = to_gud_device(drm);
-	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(atomic_state, plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(atomic_state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
 	struct drm_framebuffer *fb = new_state->fb;
@@ -647,7 +646,7 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 	if (ret)
 		goto out;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
+	drm_atomic_helper_damage_iter_init(&iter, new_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage)
 		gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 44425f2d7e04..ee81056e5c53 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -171,14 +171,13 @@ static void hv_drm_plane_atomic_update(struct drm_plane *plane,
 				       struct drm_atomic_commit *state)
 {
 	struct hv_drm_device *hv = to_hv_drm(plane->dev);
-	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
 	struct drm_rect damage;
 	struct drm_rect dst_clip;
 	struct drm_atomic_helper_damage_iter iter;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
+	drm_atomic_helper_damage_iter_init(&iter, new_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = new_state->dst;
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 7e07fc3f1a60..ea121428adf2 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -503,14 +503,13 @@ void mgag200_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct mga_device *mdev = to_mga_device(dev);
 	struct drm_plane_state *plane_state = plane->state;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect damage;
 
 	mgag200_set_datasiz(mdev, fb->format->format);
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		mgag200_handle_damage(mdev, shadow_plane_state->data, fb, &damage);
 	}
diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index 20954c33eca9..bc0e59c2600c 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -342,7 +342,6 @@ static int st7571_primary_plane_helper_atomic_check(struct drm_plane *plane,
 static void st7571_primary_plane_helper_atomic_update(struct drm_plane *plane,
 						      struct drm_atomic_commit *state)
 {
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
@@ -362,7 +361,7 @@ static void st7571_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		goto out_drm_gem_fb_end_cpu_access;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		st7571->pformat->prepare_buffer(st7571,
 						&shadow_plane_state->data[0],
diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index d320391801f3..7ee45a2b2d3e 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -390,7 +390,6 @@ static void st7920_primary_plane_atomic_update(struct drm_plane *plane,
 					       struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
 	struct st7920_crtc_state *st7920_crtc_state =  to_st7920_crtc_state(crtc_state);
@@ -407,7 +406,7 @@ static void st7920_primary_plane_atomic_update(struct drm_plane *plane,
 		return;
 
 	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) == 0) {
-		drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+		drm_atomic_helper_damage_iter_init(&iter, plane_state);
 		drm_atomic_for_each_plane_damage(&iter, &damage) {
 			dst_clip = plane_state->dst;
 
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index cae92a3ae8a4..4b55532da31b 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1198,7 +1198,6 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
 						struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
 	struct ssd130x_crtc_state *ssd130x_crtc_state =  to_ssd130x_crtc_state(crtc_state);
@@ -1216,7 +1215,7 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
 		goto out_drm_dev_exit;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
 
@@ -1239,7 +1238,6 @@ static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
 						struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
 	struct ssd130x_crtc_state *ssd130x_crtc_state =  to_ssd130x_crtc_state(crtc_state);
@@ -1257,7 +1255,7 @@ static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
 		goto out_drm_dev_exit;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
 
@@ -1280,7 +1278,6 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
 						struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
 	struct ssd130x_crtc_state *ssd130x_crtc_state =  to_ssd130x_crtc_state(crtc_state);
@@ -1297,7 +1294,7 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
 	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
 		goto out_drm_dev_exit;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		dst_clip = plane_state->dst;
 
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index d2de29caf89e..9f1ae5ca9a11 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -331,7 +331,6 @@ void drm_sysfb_plane_helper_atomic_update(struct drm_plane *plane, struct drm_at
 	struct drm_device *dev = plane->dev;
 	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_sysfb_plane_state *sysfb_plane_state = to_drm_sysfb_plane_state(plane_state);
 	struct drm_shadow_plane_state *shadow_plane_state = &sysfb_plane_state->base;
 	struct drm_framebuffer *fb = plane_state->fb;
@@ -351,7 +350,7 @@ void drm_sysfb_plane_helper_atomic_update(struct drm_plane *plane, struct drm_at
 	if (!drm_dev_enter(dev, &idx))
 		goto out_drm_gem_fb_end_cpu_access;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		struct iosys_map dst = sysfb->fb_addr;
 		struct drm_rect dst_clip = plane_state->dst;
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index ef931497baf9..2139ec8b0eb0 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -20,7 +20,6 @@ struct drm_damage_mock {
 	struct drm_property prop;
 	struct drm_framebuffer fb;
 	struct drm_plane_state state;
-	struct drm_plane_state old_state;
 };
 
 static int drm_damage_helper_init(struct kunit *test)
@@ -37,7 +36,6 @@ static int drm_damage_helper_init(struct kunit *test)
 	mock->state.fb = &mock->fb;
 	mock->state.visible = true;
 
-	mock->old_state.plane = &mock->plane;
 	mock->state.plane = &mock->plane;
 
 	/* just enough so that drm_plane_enable_fb_damage_clips() works */
@@ -124,9 +122,8 @@ static void drm_test_damage_iter_no_damage(struct kunit *test)
 	u32 num_hits = 0;
 
 	/* Plane src same as fb size. */
-	set_plane_src(&mock->old_state, 0, 0, mock->fb.width << 16, mock->fb.height << 16);
 	set_plane_src(&mock->state, 0, 0, mock->fb.width << 16, mock->fb.height << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -142,11 +139,9 @@ static void drm_test_damage_iter_no_damage_fractional_src(struct kunit *test)
 	u32 num_hits = 0;
 
 	/* Plane src has fractional part. */
-	set_plane_src(&mock->old_state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
 	set_plane_src(&mock->state, 0x3fffe, 0x3fffe,
 		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -164,9 +159,8 @@ static void drm_test_damage_iter_no_damage_not_visible(struct kunit *test)
 
 	mock->state.visible = false;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -182,9 +176,8 @@ static void drm_test_damage_iter_no_damage_no_crtc(struct kunit *test)
 
 	mock->state.crtc = NULL;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -200,9 +193,8 @@ static void drm_test_damage_iter_no_damage_no_fb(struct kunit *test)
 
 	mock->state.fb = NULL;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -218,13 +210,12 @@ static void drm_test_damage_iter_simple_damage(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
 	/* Damage set to plane src */
 	set_damage_clip(&damage, 0, 0, 1024, 768);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -241,12 +232,11 @@ static void drm_test_damage_iter_single_damage(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
 	set_damage_clip(&damage, 256, 192, 768, 576);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -263,13 +253,12 @@ static void drm_test_damage_iter_single_damage_intersect_src(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
 	/* Damage intersect with plane src. */
 	set_damage_clip(&damage, 256, 192, 1360, 768);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -286,13 +275,12 @@ static void drm_test_damage_iter_single_damage_outside_src(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
 	/* Damage clip outside plane src */
 	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -309,14 +297,12 @@ static void drm_test_damage_iter_single_damage_fractional_src(struct kunit *test
 	u32 num_hits = 0;
 
 	/* Plane src has fractional part. */
-	set_plane_src(&mock->old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	set_plane_src(&mock->state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	set_damage_clip(&damage, 10, 10, 256, 330);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -334,15 +320,13 @@ static void drm_test_damage_iter_single_damage_intersect_fractional_src(struct k
 	u32 num_hits = 0;
 
 	/* Plane src has fractional part. */
-	set_plane_src(&mock->old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	set_plane_src(&mock->state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	/* Damage intersect with plane src. */
 	set_damage_clip(&damage, 10, 1, 1360, 330);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -361,15 +345,13 @@ static void drm_test_damage_iter_single_damage_outside_fractional_src(struct kun
 	u32 num_hits = 0;
 
 	/* Plane src has fractional part. */
-	set_plane_src(&mock->old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	set_plane_src(&mock->state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	/* Damage clip outside plane src */
 	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
 	set_damage_blob(&damage_blob, &damage, sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -385,14 +367,13 @@ static void drm_test_damage_iter_damage(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
 	/* 2 damage clips. */
 	set_damage_clip(&damage[0], 20, 30, 200, 180);
 	set_damage_clip(&damage[1], 240, 200, 280, 250);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		if (num_hits == 0)
 			check_damage_clip(test, &clip, 20, 30, 200, 180);
@@ -413,8 +394,6 @@ static void drm_test_damage_iter_damage_one_intersect(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	set_plane_src(&mock->state, 0x40002, 0x40002,
 		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
 	/* 2 damage clips, one intersect plane src. */
@@ -422,7 +401,7 @@ static void drm_test_damage_iter_damage_one_intersect(struct kunit *test)
 	set_damage_clip(&damage[1], 2, 2, 1360, 1360);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		if (num_hits == 0)
 			check_damage_clip(test, &clip, 20, 30, 200, 180);
@@ -443,14 +422,13 @@ static void drm_test_damage_iter_damage_one_outside(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
 	/* 2 damage clips, one outside plane src. */
 	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
 	set_damage_clip(&damage[1], 240, 200, 280, 250);
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -467,7 +445,6 @@ static void drm_test_damage_iter_damage_ignore(struct kunit *test)
 	struct drm_rect clip;
 	u32 num_hits = 0;
 
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
 	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
 	/* 2 damage clips, but ignore them. */
 	set_damage_clip(&damage[0], 20, 30, 200, 180);
@@ -475,7 +452,7 @@ static void drm_test_damage_iter_damage_ignore(struct kunit *test)
 	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
 	set_plane_damage(&mock->state, &damage_blob);
 	mock->state.ignore_damage_clips = true;
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		if (num_hits == 0)
 			check_damage_clip(test, &clip, 0, 0, 1024, 768);
diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index ef71b9957961..eadc3aed7277 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -324,7 +324,7 @@ static int appletbdrm_primary_plane_helper_begin_fb_access(struct drm_plane *pla
 	struct drm_rect damage;
 	size_t request_size;
 
-	drm_atomic_helper_damage_iter_init(&iter, plane->state, new_plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, new_plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		frames_size += struct_size((struct appletbdrm_frame *)0, buf, rect_size(&damage));
 	}
@@ -376,7 +376,6 @@ static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
 }
 
 static int appletbdrm_flush_damage(struct appletbdrm_device *adev,
-				   struct drm_plane_state *old_state,
 				   struct drm_plane_state *state)
 {
 	struct appletbdrm_plane_state *appletbdrm_state = to_appletbdrm_plane_state(state);
@@ -412,7 +411,7 @@ static int appletbdrm_flush_damage(struct appletbdrm_device *adev,
 
 	frame = (struct appletbdrm_frame *)request->data;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
+	drm_atomic_helper_damage_iter_init(&iter, state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		struct drm_rect dst_clip = state->dst;
 		struct iosys_map dst = IOSYS_MAP_INIT_VADDR(frame->buf);
@@ -479,13 +478,12 @@ static void appletbdrm_primary_plane_helper_atomic_update(struct drm_plane *plan
 	struct appletbdrm_device *adev = drm_to_adev(plane->dev);
 	struct drm_device *drm = plane->dev;
 	struct drm_plane_state *plane_state = plane->state;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
 	int idx;
 
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	appletbdrm_flush_damage(adev, old_plane_state, plane_state);
+	appletbdrm_flush_damage(adev, plane_state);
 
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index e2d957e51505..1e19e98694c0 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -447,7 +447,6 @@ static void bochs_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct bochs_device *bochs = to_bochs_device(dev);
 	struct drm_plane_state *plane_state = plane->state;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_atomic_helper_damage_iter iter;
@@ -456,7 +455,7 @@ static void bochs_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (!fb || !bochs->stride)
 		return;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		struct iosys_map dst = IOSYS_MAP_INIT_VADDR_IOMEM(bochs->fb_map);
 
diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 075221b431d3..44ffce563e51 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -350,7 +350,7 @@ static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (!old_fb || old_fb->pitches[0] != fb->pitches[0])
 		cirrus_pitch_set(cirrus, fb->pitches[0]);
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		unsigned int offset = drm_fb_clip_offset(fb->pitches[0], fb->format, &damage);
 		struct iosys_map dst = IOSYS_MAP_INIT_OFFSET(&vaddr, offset);
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 289711035b67..ac981ffca5d9 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -286,7 +286,6 @@ static void udl_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect damage;
 	int ret, idx;
@@ -301,7 +300,7 @@ static void udl_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(dev, &idx))
 		goto out_drm_gem_fb_end_cpu_access;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		udl_handle_damage(fb, &shadow_plane_state->data[0], &damage);
 	}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..32617eb9538e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1733,7 +1733,6 @@ void vmw_kms_lost_device(struct drm_device *dev)
 int vmw_du_helper_plane_update(struct vmw_du_update_plane *update)
 {
 	struct drm_plane_state *state = update->plane->state;
-	struct drm_plane_state *old_state = update->old_state;
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
 	struct drm_rect bb;
@@ -1750,7 +1749,7 @@ int vmw_du_helper_plane_update(struct vmw_du_update_plane *update)
 	 * Iterate in advance to check if really need plane update and find the
 	 * number of clips that actually are in plane src for fifo allocation.
 	 */
-	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
+	drm_atomic_helper_damage_iter_init(&iter, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
@@ -1818,7 +1817,7 @@ int vmw_du_helper_plane_update(struct vmw_du_update_plane *update)
 	bb.x2 = INT_MIN;
 	bb.y2 = INT_MIN;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
+	drm_atomic_helper_damage_iter_init(&iter, state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		uint32_t fb_x = clip.x1;
 		uint32_t fb_y = clip.y1;
diff --git a/include/drm/drm_damage_helper.h b/include/drm/drm_damage_helper.h
index e93eaa0fbcb6..fafe29b50fc6 100644
--- a/include/drm/drm_damage_helper.h
+++ b/include/drm/drm_damage_helper.h
@@ -73,8 +73,7 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
 			      unsigned int num_clips);
 void
 drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
-				   const struct drm_plane_state *old_state,
-				   const struct drm_plane_state *new_state);
+				   const struct drm_plane_state *state);
 bool
 drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
 				   struct drm_rect *rect);
-- 
2.54.0


