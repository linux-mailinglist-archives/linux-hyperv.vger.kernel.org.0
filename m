Return-Path: <linux-hyperv+bounces-10661-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD99JBZG/Gn9NgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10661-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 09:58:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 187BB4E45EF
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 09:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6362302DF77
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36036D500;
	Thu,  7 May 2026 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QeStYHZy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvbIYvx9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QeStYHZy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LvbIYvx9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBD379ECF
	for <linux-hyperv@vger.kernel.org>; Thu,  7 May 2026 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140654; cv=none; b=lEc1vMjpbnQYlN+WR2eCjFSzJpogKeh68CkdUpakpxjmEsB3q+le22WkyFVHRbN9UYPoV+KaMBS5Bn3Bv5W3Zv+TKHn0U7AtCLTl4+Iv85saZBXMrWssYK/SZqdJXaNadpmrPeHLdIY4sPq2XBhvc2fQLMiafbz28TpS68vBa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140654; c=relaxed/simple;
	bh=w9la6TZErJCN0l/zP93BWkX4NhKErLvskA9oeVkBqQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVLlAgHkQ7oSHmpiLLus2RaysXVZZDhiNdz6SlJQ/v2F7tDcVnxzxyuwN+oI4rDX9ztuZItTCufhfOk35RQIHG1AN+Ko8MEjOwppWzYqwpMnB7prMX+dTyYPgbhB/QpFc1OMl8vbG50tgMibJz1CJQF1IsRZtKesXesdugVcol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QeStYHZy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LvbIYvx9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QeStYHZy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LvbIYvx9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5C9D5D353;
	Thu,  7 May 2026 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778140650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
	b=QeStYHZyp/H5Ko8Krujwf0knkinfngRwsv1mMqjT05b5Rzomv+4TJ4XBrOIJL1wapVkoNj
	FBF0pESzDNn2B33xGtdVlQP22ZcmFM94TG78vgN/xpt8SH4nFQ8Wo8Hs3aZTSwHdDCECLT
	A6vMqhRp7d8XNMwSihOYLDO9KZA9N1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778140650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
	b=LvbIYvx9YHmaVd4psSMAwuszlLK/Q2dhFNNWfsuFVOf97agWCKNcXZQJWTUSdd/9wiJh3I
	pKgwRwFXSrX/jeAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778140650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
	b=QeStYHZyp/H5Ko8Krujwf0knkinfngRwsv1mMqjT05b5Rzomv+4TJ4XBrOIJL1wapVkoNj
	FBF0pESzDNn2B33xGtdVlQP22ZcmFM94TG78vgN/xpt8SH4nFQ8Wo8Hs3aZTSwHdDCECLT
	A6vMqhRp7d8XNMwSihOYLDO9KZA9N1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778140650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6pllsNOZ2gawk2OziatCgyMCSrtk5u8hHJAp8POW0M=;
	b=LvbIYvx9YHmaVd4psSMAwuszlLK/Q2dhFNNWfsuFVOf97agWCKNcXZQJWTUSdd/9wiJh3I
	pKgwRwFXSrX/jeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CBED593A8;
	Thu,  7 May 2026 07:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDxoDepF/GnZJAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 07 May 2026 07:57:30 +0000
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
Subject: [PATCH 01/10] drm/damage-helper: Do not alter damage clips on modeset, but ignore them
Date: Thu,  7 May 2026 09:12:20 +0200
Message-ID: <20260507075725.29738-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507075725.29738-1-tzimmermann@suse.de>
References: <20260507075725.29738-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Rspamd-Queue-Id: 187BB4E45EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10661-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,broadcom.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
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
index 76746ad4a1bb..42f25b273dac 100644
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
index 1b6850aa1688..85e20f83f757 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_atomic_state *state,
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


