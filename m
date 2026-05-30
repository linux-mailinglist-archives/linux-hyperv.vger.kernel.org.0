Return-Path: <linux-hyperv+bounces-11398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLJ/AV0zG2qqAAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11398-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 20:58:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3A5612E46
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 452A63006B5E
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2625B0B5;
	Sat, 30 May 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YuIGeCEa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WFiXfchG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YuIGeCEa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WFiXfchG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF86233943
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167442; cv=none; b=UT6Se/Xw4vo/IpRoBLKaiZmejdaSCWH/NjqnhmWX2mitnkuOb8RrB0BNQadDof0ZoDIm41bZVi7R8ItwZjo4xzPK5NeelFodRPhTxgY7x4HOx4jPP5GwEn9U7RgJRSyeKIqMZ48jSRcDQtTGUV3ZW/2kxkmVXxbAtn2JrlwHuk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167442; c=relaxed/simple;
	bh=OMdq6DcdL40XMgkjllqdLF0EynRVjgvdLMAsdwSKI9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNKaVRArGM8FTBm1UCs2FxjsmfZcDL69qCoa9kEee9UI2DKKPWikobbooS6PHB/rKYd1Ow3O2YCH9+1PQbMgGGZuPe1aEC6I/QuZyLbCNsiTM0gUZmJc40SAcgrVLfqRIKF3L8DlcJCcxhEvj0lID8MJrBZeA7ly5Ly1UkLTImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YuIGeCEa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WFiXfchG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YuIGeCEa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WFiXfchG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E9516B4BB;
	Sat, 30 May 2026 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780167439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl/6Hzud/qMAEKC5HoBcZ2QJGJfPgZbaNL6g80kRCHI=;
	b=YuIGeCEaAF6DXSEV9p+bzu2xWrP2fbBeqfMTGFC0z1xqwdcnrNCpHQQ0dynNqZ40HMJxe1
	iFoHKN+LmX3eNKz9U+yt7f8JxG6T0fXu01BdkE9Wor7twmfxxg9TkFgbrd+M+capiHBkFN
	903mZE+p0Fz+J3SdAEyf76HqZLeGpYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780167439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl/6Hzud/qMAEKC5HoBcZ2QJGJfPgZbaNL6g80kRCHI=;
	b=WFiXfchGAIswK0jbtZnq+9xxyJg0fco5nwMZHi7HeaVnHZckbpLnn5SXtCErvLrwm22/Hs
	0+aEDGqU24vSJlAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780167439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl/6Hzud/qMAEKC5HoBcZ2QJGJfPgZbaNL6g80kRCHI=;
	b=YuIGeCEaAF6DXSEV9p+bzu2xWrP2fbBeqfMTGFC0z1xqwdcnrNCpHQQ0dynNqZ40HMJxe1
	iFoHKN+LmX3eNKz9U+yt7f8JxG6T0fXu01BdkE9Wor7twmfxxg9TkFgbrd+M+capiHBkFN
	903mZE+p0Fz+J3SdAEyf76HqZLeGpYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780167439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl/6Hzud/qMAEKC5HoBcZ2QJGJfPgZbaNL6g80kRCHI=;
	b=WFiXfchGAIswK0jbtZnq+9xxyJg0fco5nwMZHi7HeaVnHZckbpLnn5SXtCErvLrwm22/Hs
	0+aEDGqU24vSJlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DF6F779A8;
	Sat, 30 May 2026 18:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iOCSHQ4zG2rXUwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Sat, 30 May 2026 18:57:18 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v4 01/10] drm/damage-helper: Do not alter damage clips on modeset, but ignore them
Date: Sat, 30 May 2026 20:53:14 +0200
Message-ID: <20260530185716.65688-2-tzimmermann@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-11398-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 9D3A5612E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

User space supplies rectangles for damage clipping in a plane property.
For full mode sets, drivers still require a full plane update. In this
case, leave the information as-is and set the ignore_damage_clips flag
instead. The damage iterator will later ignore any damage information.

Also fixes a bug where ignore_damage_clips was not cleared across plane-
state duplications.

Leaving the damage information as-is might be helpful to drivers that
benefit from this information even on full modesets (e.g., for cache
management). It will also help with consolidating the damage-handling
logic.

Also add a new unit test that evaluates the ignore_damage_clips flag. It
sets two damage clips plus the flag and tests if the reported damage
covers the entire framebuffer.

v4:
- slightly reword the commit description

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
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


