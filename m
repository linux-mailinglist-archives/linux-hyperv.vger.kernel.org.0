Return-Path: <linux-hyperv+bounces-10747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCtcB+7LAWrRjwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10747-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 14:30:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD650DD34
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AE07305AF16
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CEB377550;
	Mon, 11 May 2026 12:25:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4B3358D6
	for <linux-hyperv@vger.kernel.org>; Mon, 11 May 2026 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502304; cv=none; b=u/4U3G1H2ZvY2Oj66gIW16sVm/prehr5J8ktFalSE1TZVh0OCT0qKDQW+BbOnteK2mD9Q26eWhQ08pEyt6GIWs5MiiRWZnwNgwU25SO7uy8DoYO7QT5cKgqIMc6D5Fc0GE9TD0Pfbe/4yAhceRSc7Eg9ZwmU3a3KRwGwoPDjZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502304; c=relaxed/simple;
	bh=uUuzusAcvbUGM9ED8sqIt6tHHSnhjfiHr0IBQqQknFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1CFbal+iRWo+o2V/vRObGUVs0F4ur394C84YEfozNVLKgyGg+hDgeyuk9tI9lT4rsGWxgu+SwUutQRMjXeHh1ThD/zuu8N/VBEcVW70V2nZkb7vZdHhFZbrgsoPZO+uSGIvU7WU6xs3fmkiRqAsNHEkD89JL8dc6a4JOWJVT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7FAC67E93;
	Mon, 11 May 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D95A593A9;
	Mon, 11 May 2026 12:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBiSGXzKAWolYwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 12:24:28 +0000
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
Subject: [PATCH v2 09/10] drm/damage-helper: Rename state parameters in damage helpers
Date: Mon, 11 May 2026 14:22:33 +0200
Message-ID: <20260511122421.114014-10-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C3CD650DD34
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
	TAGGED_FROM(0.00)[bounces-10747-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.654];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Rename some of the state parameters of the damage-helper functions to
align them with each other and other helpers. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_damage_helper.c | 20 ++++++++++----------
 include/drm/drm_damage_helper.h     |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index 28b847636253..23701e5c51b7 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -209,7 +209,7 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
 /**
  * drm_atomic_helper_damage_iter_init - Initialize the damage iterator.
  * @iter: The iterator to initialize.
- * @state: Plane state from which to iterate the damage clips.
+ * @plane_state: Plane state from which to iterate the damage clips.
  *
  * Initialize an iterator, which clips plane damage
  * &drm_plane_state.fb_damage_clips to plane &drm_plane_state.src. This iterator
@@ -225,26 +225,26 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
  */
 void
 drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
-				   const struct drm_plane_state *state)
+				   const struct drm_plane_state *plane_state)
 {
 	struct drm_rect src;
 	memset(iter, 0, sizeof(*iter));
 
-	if (!state || !state->crtc || !state->fb || !state->visible)
+	if (!plane_state || !plane_state->crtc || !plane_state->fb || !plane_state->visible)
 		return;
 
-	iter->clips = (struct drm_rect *)drm_plane_get_damage_clips(state);
-	iter->num_clips = drm_plane_get_damage_clips_count(state);
+	iter->clips = (struct drm_rect *)drm_plane_get_damage_clips(plane_state);
+	iter->num_clips = drm_plane_get_damage_clips_count(plane_state);
 
 	/* Round down for x1/y1 and round up for x2/y2 to catch all pixels */
-	src = drm_plane_state_src(state);
+	src = drm_plane_state_src(plane_state);
 
 	iter->plane_src.x1 = src.x1 >> 16;
 	iter->plane_src.y1 = src.y1 >> 16;
 	iter->plane_src.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF);
 	iter->plane_src.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF);
 
-	if (!iter->clips || state->ignore_damage_clips) {
+	if (!iter->clips || plane_state->ignore_damage_clips) {
 		iter->clips = NULL;
 		iter->num_clips = 0;
 		iter->full_update = true;
@@ -296,7 +296,7 @@ EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
 
 /**
  * drm_atomic_helper_damage_merged - Merged plane damage
- * @state: Plane state from which to iterate the damage clips.
+ * @plane_state: Plane state from which to iterate the damage clips.
  * @rect: Returns the merged damage rectangle
  *
  * This function merges any valid plane damage clips into one rectangle and
@@ -308,7 +308,7 @@ EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
  * Returns:
  * True if there is valid plane damage otherwise false.
  */
-bool drm_atomic_helper_damage_merged(const struct drm_plane_state *state,
+bool drm_atomic_helper_damage_merged(const struct drm_plane_state *plane_state,
 				     struct drm_rect *rect)
 {
 	struct drm_atomic_helper_damage_iter iter;
@@ -320,7 +320,7 @@ bool drm_atomic_helper_damage_merged(const struct drm_plane_state *state,
 	rect->x2 = 0;
 	rect->y2 = 0;
 
-	drm_atomic_helper_damage_iter_init(&iter, state);
+	drm_atomic_helper_damage_iter_init(&iter, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		rect->x1 = min(rect->x1, clip.x1);
 		rect->y1 = min(rect->y1, clip.y1);
diff --git a/include/drm/drm_damage_helper.h b/include/drm/drm_damage_helper.h
index b5a4de779db6..4a1ac47b9051 100644
--- a/include/drm/drm_damage_helper.h
+++ b/include/drm/drm_damage_helper.h
@@ -73,11 +73,11 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
 			      unsigned int num_clips);
 void
 drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
-				   const struct drm_plane_state *state);
+				   const struct drm_plane_state *plane_state);
 bool
 drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
 				   struct drm_rect *rect);
-bool drm_atomic_helper_damage_merged(const struct drm_plane_state *state,
+bool drm_atomic_helper_damage_merged(const struct drm_plane_state *plane_state,
 				     struct drm_rect *rect);
 
 #endif
-- 
2.54.0


