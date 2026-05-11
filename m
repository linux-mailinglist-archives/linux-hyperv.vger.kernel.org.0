Return-Path: <linux-hyperv+bounces-10745-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CTsHOHLAWqgjwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10745-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 14:30:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8550DD10
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86DD63045B2B
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C43815DB;
	Mon, 11 May 2026 12:24:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34637B3F6
	for <linux-hyperv@vger.kernel.org>; Mon, 11 May 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502293; cv=none; b=lZw1MMGQnRbOAFhLYVdCABA3jbSH5Qqbbxys3EHtFcVWuyqyp7hddDGuw0DiT0u6bHbjDEZhf7VRTmKiGQRcaGRYlcX8CZfRR72SjRi0SeYN83ATNrZDy3CAqDqI2WrDAAzJ2I6H5zj6wHUhLo3qtrXA2vvykmKe/a+uyGYiqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502293; c=relaxed/simple;
	bh=emp1O+1eumklG0nlJJb7JWTwtgdqDsW3MLIzIyE8lAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QirTxvQ8WJ5cTbf4n+38hTnI6YfqRsdeS+OwFXWlI83I6VbxRO9WxBNm1HVjpRaZfBMc2GKyJrnrl8j03ODnUvBYmJ/LpfMHUj9T7MbeZr/KmEpT1X1zwDuzuqC9prC/zkLQk56iikBGRmpcEbjggqfuGYuypnr+pnAGD96nrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC76667E05;
	Mon, 11 May 2026 12:24:27 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E316593A9;
	Mon, 11 May 2026 12:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UKekHXvKAWolYwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 12:24:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 07/10] drm/damage-helper: Remove old state from drm_atomic_helper_damage_merged()
Date: Mon, 11 May 2026 14:22:31 +0200
Message-ID: <20260511122421.114014-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511122421.114014-1-tzimmermann@suse.de>
References: <20260511122421.114014-1-tzimmermann@suse.de>
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
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 34F8550DD10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10745-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.663];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Nothing in drm_atomic_helper_damage_merged() requires the old
plane state. Remove the parameter and mass-convert callers.

Most callers now no longer require the old plane state in their plane's
atomic_update helper. Remove it as well.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_cursor.c           |  3 +--
 drivers/gpu/drm/drm_damage_helper.c        |  4 +---
 drivers/gpu/drm/drm_mipi_dbi.c             |  3 +--
 drivers/gpu/drm/i915/display/intel_plane.c | 11 ++---------
 drivers/gpu/drm/i915/display/intel_psr.c   |  3 +--
 drivers/gpu/drm/sitronix/st7586.c          |  3 +--
 drivers/gpu/drm/tiny/gm12u320.c            |  2 +-
 drivers/gpu/drm/tiny/ili9225.c             |  3 +--
 drivers/gpu/drm/tiny/repaper.c             |  2 +-
 drivers/gpu/drm/tiny/sharp-memory.c        |  3 +--
 drivers/gpu/drm/virtio/virtgpu_plane.c     |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c       |  4 +---
 include/drm/drm_damage_helper.h            |  3 +--
 13 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index fd19c45f2abe..12d5f93eec5f 100644
--- a/drivers/gpu/drm/ast/ast_cursor.c
+++ b/drivers/gpu/drm/ast/ast_cursor.c
@@ -251,7 +251,6 @@ static void ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct ast_device *ast = to_ast_device(plane->dev);
 	struct drm_rect damage;
 	u64 dst_off = ast_plane->offset;
@@ -266,7 +265,7 @@ static void ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
 	 * engine to the offset.
 	 */
 
-	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage)) {
+	if (drm_atomic_helper_damage_merged(plane_state, &damage)) {
 		const u8 *argb4444 = ast_cursor_plane_get_argb4444(ast_cursor_plane,
 								   shadow_plane_state,
 								   &damage);
diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index 28f26234523d..28b847636253 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -296,7 +296,6 @@ EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
 
 /**
  * drm_atomic_helper_damage_merged - Merged plane damage
- * @old_state: Old plane state for validation.
  * @state: Plane state from which to iterate the damage clips.
  * @rect: Returns the merged damage rectangle
  *
@@ -309,8 +308,7 @@ EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
  * Returns:
  * True if there is valid plane damage otherwise false.
  */
-bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
-				     const struct drm_plane_state *state,
+bool drm_atomic_helper_damage_merged(const struct drm_plane_state *state,
 				     struct drm_rect *rect)
 {
 	struct drm_atomic_helper_damage_iter iter;
diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 25cf04d029f7..4da201c38c93 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -380,7 +380,6 @@ void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_rect rect;
 	int idx;
 
@@ -388,7 +387,7 @@ void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
 		return;
 
 	if (drm_dev_enter(plane->dev, &idx)) {
-		if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
+		if (drm_atomic_helper_damage_merged(plane_state, &rect))
 			mipi_dbi_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
 					  &shadow_plane_state->fmtcnv_state);
 		drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index c181a7d063ec..57107cce9267 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -346,7 +346,6 @@ static void intel_plane_clear_hw_state(struct intel_plane_state *plane_state)
 
 static void
 intel_plane_copy_uapi_plane_damage(struct intel_plane_state *new_plane_state,
-				   const struct intel_plane_state *old_uapi_plane_state,
 				   const struct intel_plane_state *new_uapi_plane_state)
 {
 	struct intel_display *display = to_intel_display(new_plane_state);
@@ -356,10 +355,9 @@ intel_plane_copy_uapi_plane_damage(struct intel_plane_state *new_plane_state,
 	if (DISPLAY_VER(display) < 12)
 		return;
 
-	if (!drm_atomic_helper_damage_merged(&old_uapi_plane_state->uapi,
-					     &new_uapi_plane_state->uapi,
+	if (!drm_atomic_helper_damage_merged(&new_uapi_plane_state->uapi,
 					     damage))
-		/* Incase helper fails, mark whole plane region as damage */
+		/* In case the helper fails, mark whole plane region as damage */
 		*damage = drm_plane_state_src(&new_uapi_plane_state->uapi);
 }
 
@@ -815,7 +813,6 @@ static int plane_atomic_check(struct intel_atomic_state *state,
 	const struct intel_plane_state *old_plane_state =
 		intel_atomic_get_old_plane_state(state, plane);
 	const struct intel_plane_state *new_primary_crtc_plane_state;
-	const struct intel_plane_state *old_primary_crtc_plane_state;
 	struct intel_crtc *crtc = intel_crtc_for_pipe(display, plane->pipe);
 	const struct intel_crtc_state *old_crtc_state =
 		intel_atomic_get_old_crtc_state(state, crtc);
@@ -830,15 +827,11 @@ static int plane_atomic_check(struct intel_atomic_state *state,
 
 		new_primary_crtc_plane_state =
 			intel_atomic_get_new_plane_state(state, primary_crtc_plane);
-		old_primary_crtc_plane_state =
-			intel_atomic_get_old_plane_state(state, primary_crtc_plane);
 	} else {
 		new_primary_crtc_plane_state = new_plane_state;
-		old_primary_crtc_plane_state = old_plane_state;
 	}
 
 	intel_plane_copy_uapi_plane_damage(new_plane_state,
-					   old_primary_crtc_plane_state,
 					   new_primary_crtc_plane_state);
 
 	intel_plane_copy_uapi_to_hw_state(new_plane_state,
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 9958230a3dd9..adb936806488 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2970,8 +2970,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		src = drm_plane_state_src(&new_plane_state->uapi);
 		drm_rect_fp_to_int(&src, &src);
 
-		if (!drm_atomic_helper_damage_merged(&old_plane_state->uapi,
-						     &new_plane_state->uapi, &damaged_area))
+		if (!drm_atomic_helper_damage_merged(&new_plane_state->uapi, &damaged_area))
 			continue;
 
 		damaged_area.y1 += new_plane_state->uapi.dst.y1 - src.y1;
diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index 28b2245f6b79..2cc0312595a4 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -176,7 +176,6 @@ static void st7586_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_rect rect;
 	int idx;
 
@@ -186,7 +185,7 @@ static void st7586_plane_helper_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(plane->dev, &idx))
 		return;
 
-	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
+	if (drm_atomic_helper_damage_merged(plane_state, &rect))
 		st7586_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
 				&shadow_plane_state->fmtcnv_state);
 
diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index d73dfebb4353..880b965e283a 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -582,7 +582,7 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+	if (drm_atomic_helper_damage_merged(state, &rect))
 		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
 }
 
diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index 5bf52a8fd75b..d821a659a585 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -185,7 +185,6 @@ static void ili9225_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_rect rect;
 	int idx;
 
@@ -195,7 +194,7 @@ static void ili9225_plane_helper_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
+	if (drm_atomic_helper_damage_merged(plane_state, &rect))
 		ili9225_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
 				 &shadow_plane_state->fmtcnv_state);
 
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c8270591afc7..531831d2b73f 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -837,7 +837,7 @@ static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
 	if (!pipe->crtc.state->active)
 		return;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+	if (drm_atomic_helper_damage_merged(state, &rect))
 		repaper_fb_dirty(state->fb, shadow_plane_state->data,
 				 &shadow_plane_state->fmtcnv_state);
 }
diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 506e6432e70d..1dacd41ddbaa 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -241,7 +241,6 @@ static int sharp_memory_plane_atomic_check(struct drm_plane *plane,
 static void sharp_memory_plane_atomic_update(struct drm_plane *plane,
 					     struct drm_atomic_commit *state)
 {
-	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *plane_state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct sharp_memory_device *smd;
@@ -251,7 +250,7 @@ static void sharp_memory_plane_atomic_update(struct drm_plane *plane,
 	if (!smd->crtc.state->active)
 		return;
 
-	if (drm_atomic_helper_damage_merged(old_state, plane_state, &rect))
+	if (drm_atomic_helper_damage_merged(plane_state, &rect))
 		sharp_memory_fb_dirty(plane_state->fb, shadow_plane_state->data,
 				      &rect, &shadow_plane_state->fmtcnv_state);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 73aa70bd4231..24b786e1555e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -257,7 +257,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
-	if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
+	if (!drm_atomic_helper_damage_merged(plane->state, &rect))
 		return;
 
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 4139837f4caf..f0df2b1c8465 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -977,7 +977,6 @@ vmw_stdu_primary_plane_prepare_fb(struct drm_plane *plane,
 	enum stdu_content_type new_content_type;
 	struct vmw_framebuffer_surface *new_vfbs;
 	uint32_t hdisplay = new_state->crtc_w, vdisplay = new_state->crtc_h;
-	struct drm_plane_state *old_state = plane->state;
 	struct drm_rect rect;
 	int ret;
 
@@ -1101,8 +1100,7 @@ vmw_stdu_primary_plane_prepare_fb(struct drm_plane *plane,
 		struct vmw_surface *surf = vmw_user_object_surface(&vps->uo);
 		struct vmw_resource *res = &surf->res;
 
-		if (!res->res_dirty && drm_atomic_helper_damage_merged(old_state,
-								       new_state,
+		if (!res->res_dirty && drm_atomic_helper_damage_merged(new_state,
 								       &rect)) {
 			/*
 			 * At some point it might be useful to actually translate
diff --git a/include/drm/drm_damage_helper.h b/include/drm/drm_damage_helper.h
index fafe29b50fc6..b5a4de779db6 100644
--- a/include/drm/drm_damage_helper.h
+++ b/include/drm/drm_damage_helper.h
@@ -77,8 +77,7 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 bool
 drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
 				   struct drm_rect *rect);
-bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
-				     const struct drm_plane_state *state,
+bool drm_atomic_helper_damage_merged(const struct drm_plane_state *state,
 				     struct drm_rect *rect);
 
 #endif
-- 
2.54.0


