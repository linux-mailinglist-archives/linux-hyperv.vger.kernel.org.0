Return-Path: <linux-hyperv+bounces-10739-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id b2sODYPKAWqfjwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10739-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 14:24:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6150D9B7
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 14:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6741F300B584
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD453815DB;
	Mon, 11 May 2026 12:24:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC6381B13
	for <linux-hyperv@vger.kernel.org>; Mon, 11 May 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502268; cv=none; b=O92bpwzholFAhWE4KU9PhCcfq4HfhYQAHu5eUx5Xmx2w7h4CWs2v2Lng+CJAmxu2Ff4Ll082cmUmkW0yiFCQ+nWnkqCK4kIqrD+V7Fm1z85st/pFEchDOxLpqZFnNrxvxGPqt6zhlA16SmGXYmELQSuOf6QoG+0+iPzg54DEbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502268; c=relaxed/simple;
	bh=vgXgXSdpI+xZJol1wTJrs7iKPy6do+eSKGAMHUANbeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW5Xsl7NfxRUKsZXVm/pd0v58ds+HZGOz567hcz5ZhCn3//ST9cR7UIph2N2oZ/x8z0CNGbzNAWLE6NQ9JjQ//Wq9RLkZ5JE+TrO6IMnSay+eGXABeCNMI5Q4EAPwjJuyp3hpabkjrqsIQSKZK2lcnikZaYExZ52kCqxIGyn/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27DA05C69C;
	Mon, 11 May 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1FFB593A9;
	Mon, 11 May 2026 12:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELhOKnjKAWolYwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 12:24:24 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/10] drm/damage-helper: Do not alter damage clips on modeset, but ignore them
Date: Mon, 11 May 2026 14:22:25 +0200
Message-ID: <20260511122421.114014-2-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 5FE6150D9B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10739-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.549];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,suse.de:mid,lists.freedesktop.org:email]
X-Rspamd-Action: no action

User space supplies rectangles for damage clipping in a plane property.
For full mode sets, we still require a full plane update. In this case,
leave the information as-is and set the ignore_damage_clips flag instead.
The damage iterator will later ignore any damage information.

Also fixes a bug where ignore_damage_clips was not cleared across plane
duplications.

Leaving the damage information as-is might be helpful to drivers that
benefit from it even on full modesets (e.g., for cache management). It
will also help with consolidating the damage-handling logic.

Also add a new unit test that evaluates the ignore_damage_clips flag. It
sets two damage clips plus the flag and tests if the reported damage
covers the entire framebuffer.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/drm_atomic_state_helper.c     |  1 +
 drivers/gpu/drm/drm_damage_helper.c           |  6 ++--
 .../gpu/drm/tests/drm_damage_helper_test.c    | 28 +++++++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index cc70508d4fdb..84d5231ccac1 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -359,6 +359,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 	state->fence = NULL;
 	state->commit = NULL;
 	state->fb_damage_clips = NULL;
+	state->ignore_damage_clips = false;
 	state->color_mgmt_changed = false;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index 74a7f4252ecf..945fac8dc27b 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
 		if (WARN_ON(!crtc_state))
 			return;
 
-		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
-			drm_property_blob_put(plane_state->fb_damage_clips);
-			plane_state->fb_damage_clips = NULL;
-		}
+		if (drm_atomic_crtc_needs_modeset(crtc_state))
+			plane_state->ignore_damage_clips = true;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_plane_damage);
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index 0df2e1a54b0d..64f038a62ffe 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -603,6 +603,33 @@ static void drm_test_damage_iter_damage_not_visible(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should not return any damage.");
 }
 
+static void drm_test_damage_iter_damage_ignore(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	u32 num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* 2 damage clips, but ignore them. */
+	set_damage_clip(&damage[0], 20, 30, 200, 180);
+	set_damage_clip(&damage[1], 240, 200, 280, 250);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	mock->state.ignore_damage_clips = true;
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip) {
+		if (num_hits == 0)
+			check_damage_clip(test, &clip, 0, 0, 1024, 768);
+		num_hits++;
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return full-framebuffer damage.");
+}
+
 static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_no_damage),
 	KUNIT_CASE(drm_test_damage_iter_no_damage_fractional_src),
@@ -625,6 +652,7 @@ static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_damage_one_outside),
 	KUNIT_CASE(drm_test_damage_iter_damage_src_moved),
 	KUNIT_CASE(drm_test_damage_iter_damage_not_visible),
+	KUNIT_CASE(drm_test_damage_iter_damage_ignore),
 	{ }
 };
 
-- 
2.54.0


