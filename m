Return-Path: <linux-hyperv+bounces-11234-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJXGCPoGF2qn1gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11234-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:00:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EBD5E6689
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F268308B2FD
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED1426D0E;
	Wed, 27 May 2026 14:51:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FA4426EA6
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893493; cv=none; b=Vcgbk2Yfs+7zkE0U/EoUiwkim7rmAMBBzcgKS88cq8dNDs2K7tbXfBkNzR5YUQUjm5ylXyZFbHMFtyj07LoFGR/BBmNSbqNE0vphlQ/KO3cghA3v4q8gTiq0vPpfS0x2PC9hG+s4wV+cp1zgWV9mOGts+VmU1pn2lU80VVHlFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893493; c=relaxed/simple;
	bh=//rpfUM3SRf3wZBiL5trrTNIwAqVvOax/VwhHds3MM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4JvkCNKsyb69/0Monmdr0/eyFvWcqW5REsY0TtPHv5W7jWrWEkAEK8O/Vp0RJGWkQ2UdlURVKIdOgyf/+PyZUGKpiuFviS/P/dNTe/Mz5J82s9u9eaw2N9BciCaJ3cfX5VN9X3SpzuFX9IDXF3F/CACLcFNbgiNxMZZS/WARf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5F7566FC5;
	Wed, 27 May 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 392195A8A8;
	Wed, 27 May 2026 14:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0MW8DOkEF2qsegAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 14:51:21 +0000
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
Subject: [PATCH v3 04/10] drm/damage-helper: Test src coord in drm_atomic_helper_check_plane_damage()
Date: Wed, 27 May 2026 16:46:23 +0200
Message-ID: <20260527145113.241595-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527145113.241595-1-tzimmermann@suse.de>
References: <20260527145113.241595-1-tzimmermann@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11234-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 58EBD5E6689
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Planes require a full update if the source coordinates change across
atomic commits. Evaluate this during the atomic-check and set the flag
ignore_damage_clips in the plane state, if so. Remove the check from
drm_atomic_helper_damage_iter_init().

This will help with removing the old state from the atomic-commit phase
and simplify atomic_update helpers a bit.

Several unit tests check against the change of the src coordinate. Drop
them as they do no longer make sense. If the src coordinate changes across
commits, atomic helpers will set the plane state's ignore_damage_clips
flag, for which a separate unit test exists.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_atomic_helper.c           |   4 +-
 drivers/gpu/drm/drm_damage_helper.c           |  20 ++-
 .../gpu/drm/tests/drm_damage_helper_test.c    | 151 ------------------
 include/drm/drm_damage_helper.h               |   3 +-
 4 files changed, 16 insertions(+), 162 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 4c37299e8ccb..823ce60d45b4 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1034,7 +1034,7 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 
 		drm_atomic_helper_plane_changed(state, old_plane_state, new_plane_state, plane);
 
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
+		drm_atomic_helper_check_plane_damage(state, old_plane_state, new_plane_state);
 
 		if (!funcs || !funcs->atomic_check)
 			continue;
@@ -1066,7 +1066,7 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 	}
 
 	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
+		drm_atomic_helper_check_plane_damage(state, old_plane_state, new_plane_state);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index 945fac8dc27b..f492a59edbeb 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -55,7 +55,8 @@ static void convert_clip_rect_to_rect(const struct drm_clip_rect *src,
 /**
  * drm_atomic_helper_check_plane_damage - Verify plane damage on atomic_check.
  * @state: The driver state object.
- * @plane_state: Plane state for which to verify damage.
+ * @old_plane_state: Old plane state to verify against.
+ * @new_plane_state: Plane state for which to verify damage.
  *
  * This helper function makes sure that damage from plane state is discarded
  * for full modeset. If there are more reasons a driver would want to do a full
@@ -67,19 +68,23 @@ static void convert_clip_rect_to_rect(const struct drm_clip_rect *src,
  * &drm_plane_state.src as damage.
  */
 void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
-					  struct drm_plane_state *plane_state)
+					  const struct drm_plane_state *old_plane_state,
+					  struct drm_plane_state *new_plane_state)
 {
 	struct drm_crtc_state *crtc_state;
 
-	if (plane_state->crtc) {
+	if (!drm_rect_equals(&new_plane_state->src, &old_plane_state->src))
+		new_plane_state->ignore_damage_clips = true;
+
+	if (new_plane_state->crtc) {
 		crtc_state = drm_atomic_get_new_crtc_state(state,
-							   plane_state->crtc);
+							   new_plane_state->crtc);
 
 		if (WARN_ON(!crtc_state))
 			return;
 
 		if (drm_atomic_crtc_needs_modeset(crtc_state))
-			plane_state->ignore_damage_clips = true;
+			new_plane_state->ignore_damage_clips = true;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_plane_damage);
@@ -204,7 +209,7 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
 /**
  * drm_atomic_helper_damage_iter_init - Initialize the damage iterator.
  * @iter: The iterator to initialize.
- * @old_state: Old plane state for validation.
+ * @old_state: Unused, pass NULL.
  * @state: Plane state from which to iterate the damage clips.
  *
  * Initialize an iterator, which clips plane damage
@@ -241,8 +246,7 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 	iter->plane_src.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF);
 	iter->plane_src.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF);
 
-	if (!iter->clips || state->ignore_damage_clips ||
-	    !drm_rect_equals(&state->src, &old_state->src)) {
+	if (!iter->clips || state->ignore_damage_clips) {
 		iter->clips = NULL;
 		iter->num_clips = 0;
 		iter->full_update = true;
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index 64f038a62ffe..ef931497baf9 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -155,45 +155,6 @@ static void drm_test_damage_iter_no_damage_fractional_src(struct kunit *test)
 	check_damage_clip(test, &clip, 3, 3, 1028, 772);
 }
 
-static void drm_test_damage_iter_no_damage_src_moved(struct kunit *test)
-{
-	struct drm_damage_mock *mock = test->priv;
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	u32 num_hits = 0;
-
-	/* Plane src moved since old plane state. */
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&mock->state, 10 << 16, 10 << 16,
-		      (10 + 1024) << 16, (10 + 768) << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
-	check_damage_clip(test, &clip, 10, 10, 1034, 778);
-}
-
-static void drm_test_damage_iter_no_damage_fractional_src_moved(struct kunit *test)
-{
-	struct drm_damage_mock *mock = test->priv;
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	u32 num_hits = 0;
-
-	/* Plane src has fractional part and it moved since old plane state. */
-	set_plane_src(&mock->old_state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&mock->state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
-	check_damage_clip(test, &clip, 4, 4, 1029, 773);
-}
-
 static void drm_test_damage_iter_no_damage_not_visible(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
@@ -415,58 +376,6 @@ static void drm_test_damage_iter_single_damage_outside_fractional_src(struct kun
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-static void drm_test_damage_iter_single_damage_src_moved(struct kunit *test)
-{
-	struct drm_damage_mock *mock = test->priv;
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	u32 num_hits = 0;
-
-	/* Plane src moved since old plane state. */
-	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&mock->state, 10 << 16, 10 << 16,
-		      (10 + 1024) << 16, (10 + 768) << 16);
-	set_damage_clip(&damage, 20, 30, 256, 256);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
-			    "Should return plane src as damage.");
-	check_damage_clip(test, &clip, 10, 10, 1034, 778);
-}
-
-static void drm_test_damage_iter_single_damage_fractional_src_moved(struct kunit *test)
-{
-	struct drm_damage_mock *mock = test->priv;
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	u32 num_hits = 0;
-
-	/* Plane src with fractional part moved since old plane state. */
-	set_plane_src(&mock->old_state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&mock->state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	/* Damage intersect with plane src. */
-	set_damage_clip(&damage, 20, 30, 1360, 256);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
-			    "Should return rounded off plane as damage.");
-	check_damage_clip(test, &clip, 4, 4, 1029, 773);
-}
-
 static void drm_test_damage_iter_damage(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
@@ -549,60 +458,6 @@ static void drm_test_damage_iter_damage_one_outside(struct kunit *test)
 	check_damage_clip(test, &clip, 240, 200, 280, 250);
 }
 
-static void drm_test_damage_iter_damage_src_moved(struct kunit *test)
-{
-	struct drm_damage_mock *mock = test->priv;
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage[2];
-	struct drm_rect clip;
-	u32 num_hits = 0;
-
-	set_plane_src(&mock->old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&mock->state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	/* 2 damage clips, one outside plane src. */
-	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
-	set_damage_clip(&damage[1], 240, 200, 280, 250);
-	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
-			    "Should return round off plane src as damage.");
-	check_damage_clip(test, &clip, 3, 3, 1028, 772);
-}
-
-static void drm_test_damage_iter_damage_not_visible(struct kunit *test)
-{
-	struct drm_damage_mock *mock = test->priv;
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage[2];
-	struct drm_rect clip;
-	u32 num_hits = 0;
-
-	mock->state.visible = false;
-
-	set_plane_src(&mock->old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&mock->state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	/* 2 damage clips, one outside plane src. */
-	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
-	set_damage_clip(&damage[1], 240, 200, 280, 250);
-	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&mock->state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should not return any damage.");
-}
-
 static void drm_test_damage_iter_damage_ignore(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
@@ -633,8 +488,6 @@ static void drm_test_damage_iter_damage_ignore(struct kunit *test)
 static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_no_damage),
 	KUNIT_CASE(drm_test_damage_iter_no_damage_fractional_src),
-	KUNIT_CASE(drm_test_damage_iter_no_damage_src_moved),
-	KUNIT_CASE(drm_test_damage_iter_no_damage_fractional_src_moved),
 	KUNIT_CASE(drm_test_damage_iter_no_damage_not_visible),
 	KUNIT_CASE(drm_test_damage_iter_no_damage_no_crtc),
 	KUNIT_CASE(drm_test_damage_iter_no_damage_no_fb),
@@ -645,13 +498,9 @@ static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_single_damage_fractional_src),
 	KUNIT_CASE(drm_test_damage_iter_single_damage_intersect_fractional_src),
 	KUNIT_CASE(drm_test_damage_iter_single_damage_outside_fractional_src),
-	KUNIT_CASE(drm_test_damage_iter_single_damage_src_moved),
-	KUNIT_CASE(drm_test_damage_iter_single_damage_fractional_src_moved),
 	KUNIT_CASE(drm_test_damage_iter_damage),
 	KUNIT_CASE(drm_test_damage_iter_damage_one_intersect),
 	KUNIT_CASE(drm_test_damage_iter_damage_one_outside),
-	KUNIT_CASE(drm_test_damage_iter_damage_src_moved),
-	KUNIT_CASE(drm_test_damage_iter_damage_not_visible),
 	KUNIT_CASE(drm_test_damage_iter_damage_ignore),
 	{ }
 };
diff --git a/include/drm/drm_damage_helper.h b/include/drm/drm_damage_helper.h
index 3661aeab2cd3..e93eaa0fbcb6 100644
--- a/include/drm/drm_damage_helper.h
+++ b/include/drm/drm_damage_helper.h
@@ -65,7 +65,8 @@ struct drm_atomic_helper_damage_iter {
 };
 
 void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
-					  struct drm_plane_state *plane_state);
+					  const struct drm_plane_state *old_plane_state,
+					  struct drm_plane_state *new_plane_state);
 int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
 			      struct drm_file *file_priv, unsigned int flags,
 			      unsigned int color, struct drm_clip_rect *clips,
-- 
2.54.0


