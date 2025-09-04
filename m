Return-Path: <linux-hyperv+bounces-6728-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C96B43FE0
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7687AAB13
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32451DF75A;
	Thu,  4 Sep 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kN0XA2ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="abfdL6BD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GeV59Jki";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NNb/KPi/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55991339B1
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Sep 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998078; cv=none; b=F3pB4/9MNvAckrvrkhPUxJdVUZUXZjYnBAI05x7EBGIUy3ZEd4ZjCRrW3ZzXv9Np3sUQ5zwf4WTXDPJVWm6gbJtOGFSogmc+d0/CfmStkdS3ShssUAvN/1gQ7U3v8KfAbX+iWyB566kjVe75qL6BXVONaYtt5qQ8f+655Pl6TC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998078; c=relaxed/simple;
	bh=GEj1HLWSruD7wUKst8/on3hmWN9W1VV4Z0cKgU5+9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwOE4S7YE3aMyQiGkc8lYBm0hB/SDxf1RSL87Pg7iutVKHYNWDwZlHE8bZeBmE5LdsLGe6wu/ioNnWLxIag80MautHMvrfINmjtZ31cR4sqXc0XIgpiqOQ7Q5J3qQYCYBKMvx5/bUz4p8iWySubOLby0DyP9f/Iub4jYSAo7fyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kN0XA2ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=abfdL6BD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GeV59Jki; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NNb/KPi/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A38E2340A2;
	Thu,  4 Sep 2025 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756998058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyWrQ6B8DWTbwM5mFn/f0XsoV2ScrlR4qmru6PdI3MU=;
	b=kN0XA2ft3tg3DbqCfbdL0sKe9FlcFFj1BalHgONxE8vgAP/q/PJnhreLvvtI+2cs3LMzrG
	HvUoRej+R7ycDJR9BeJ+A+8Ss4L0KvNydwl4O0MYZ2sZoIbqlbXVGP3G7sxQq1M3B8pZzc
	jxlC3S85XuJquyc7lsfZwFHOrUK7hOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756998058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyWrQ6B8DWTbwM5mFn/f0XsoV2ScrlR4qmru6PdI3MU=;
	b=abfdL6BDEs3AjJDzmi0+3LHAu22hmpKC4gucb06PxWSxfuo11iiW5kf/aOhAf/8Q3u5/Xg
	eCpNO/oBY7soYUBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756998053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyWrQ6B8DWTbwM5mFn/f0XsoV2ScrlR4qmru6PdI3MU=;
	b=GeV59Jki+/nx3uaOmYYhNRHbhygNPjzTRR0cwyHu36CZ3y6xGeg621uNaD8JOuafGeEjal
	bRaSONPXeEf19syc7+wuB510mPAQqcFC1d+AIpQdaAywxjhzU1y+QwXaNV4qa7Stg5Sz2z
	1Ib8/WuY6B+VSRs92OTgkMObTbm3whw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756998053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyWrQ6B8DWTbwM5mFn/f0XsoV2ScrlR4qmru6PdI3MU=;
	b=NNb/KPi/78zGrfzTMXUtFN6gYiLgkWfFmumhf8Xdk4h/2OWpHR7OUjBeXoHKZJURrD1TLg
	VuUvCHimblO1QLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 485DA13ABF;
	Thu,  4 Sep 2025 15:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +HY6EKWpuWgcBAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 04 Sep 2025 15:00:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: louis.chauvet@bootlin.com,
	drawat.floss@gmail.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	mhklinux@outlook.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	maarten.lankhorst@linux.intel.com,
	ville.syrjala@linux.intel.com,
	lyude@redhat.com,
	javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 2/4] drm/vblank: Add CRTC helpers for simple use cases
Date: Thu,  4 Sep 2025 16:56:23 +0200
Message-ID: <20250904145806.430568-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904145806.430568-1-tzimmermann@suse.de>
References: <20250904145806.430568-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[tzimmermann.suse.de:query timed out];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,outlook.com,ffwll.ch,linux.intel.com,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30

Implement atomic_flush, atomic_enable and atomic_disable of struct
drm_crtc_helper_funcs for vblank handling. Driver with no further
requirements can use these functions instead of adding their own.
Also simplifies the use of vblank timers.

The code has been adopted from vkms, which added the funtionality
in commit 3a0709928b17 ("drm/vkms: Add vblank events simulated by
hrtimers").

v3:
- mention vkms (Javier)
v2:
- fix docs

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/drm_vblank_helper.c | 80 +++++++++++++++++++++++++++++
 include/drm/drm_vblank_helper.h     | 23 +++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank_helper.c b/drivers/gpu/drm/drm_vblank_helper.c
index f94d1e706191..a04a6ba1b0ca 100644
--- a/drivers/gpu/drm/drm_vblank_helper.c
+++ b/drivers/gpu/drm/drm_vblank_helper.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: MIT
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
@@ -17,6 +18,12 @@
  * Drivers enable support for vblank timers by setting the vblank callbacks
  * in struct &drm_crtc_funcs to the helpers provided by this library. The
  * initializer macro DRM_CRTC_VBLANK_TIMER_FUNCS does this conveniently.
+ * The driver further has to send the VBLANK event from its atomic_flush
+ * callback and control vblank from the CRTC's atomic_enable and atomic_disable
+ * callbacks. The callbacks are located in struct &drm_crtc_helper_funcs.
+ * The vblank helper library provides implementations of these callbacks
+ * for drivers without further requirements. The initializer macro
+ * DRM_CRTC_HELPER_VBLANK_FUNCS sets them coveniently.
  *
  * Once the driver enables vblank support with drm_vblank_init(), each
  * CRTC's vblank timer fires according to the programmed display mode. By
@@ -25,6 +32,79 @@
  * struct &drm_crtc_helper_funcs.handle_vblank_timeout.
  */
 
+/*
+ * VBLANK helpers
+ */
+
+/**
+ * drm_crtc_vblank_atomic_flush -
+ *	Implements struct &drm_crtc_helper_funcs.atomic_flush
+ * @crtc: The CRTC
+ * @state: The atomic state to apply
+ *
+ * The helper drm_crtc_vblank_atomic_flush() implements atomic_flush of
+ * struct drm_crtc_helper_funcs for CRTCs that only need to send out a
+ * VBLANK event.
+ *
+ * See also struct &drm_crtc_helper_funcs.atomic_flush.
+ */
+void drm_crtc_vblank_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_atomic_state *state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_pending_vblank_event *event;
+
+	spin_lock_irq(&dev->event_lock);
+
+	event = crtc_state->event;
+	crtc_state->event = NULL;
+
+	if (event) {
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+	}
+
+	spin_unlock_irq(&dev->event_lock);
+}
+EXPORT_SYMBOL(drm_crtc_vblank_atomic_flush);
+
+/**
+ * drm_crtc_vblank_atomic_enable - Implements struct &drm_crtc_helper_funcs.atomic_enable
+ * @crtc: The CRTC
+ * @state: The atomic state
+ *
+ * The helper drm_crtc_vblank_atomic_enable() implements atomic_enable
+ * of struct drm_crtc_helper_funcs for CRTCs the only need to enable VBLANKs.
+ *
+ * See also struct &drm_crtc_helper_funcs.atomic_enable.
+ */
+void drm_crtc_vblank_atomic_enable(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state)
+{
+	drm_crtc_vblank_on(crtc);
+}
+EXPORT_SYMBOL(drm_crtc_vblank_atomic_enable);
+
+/**
+ * drm_crtc_vblank_atomic_disable - Implements struct &drm_crtc_helper_funcs.atomic_disable
+ * @crtc: The CRTC
+ * @state: The atomic state
+ *
+ * The helper drm_crtc_vblank_atomic_disable() implements atomic_disable
+ * of struct drm_crtc_helper_funcs for CRTCs the only need to disable VBLANKs.
+ *
+ * See also struct &drm_crtc_funcs.atomic_disable.
+ */
+void drm_crtc_vblank_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_atomic_state *state)
+{
+	drm_crtc_vblank_off(crtc);
+}
+EXPORT_SYMBOL(drm_crtc_vblank_atomic_disable);
+
 /*
  * VBLANK timer
  */
diff --git a/include/drm/drm_vblank_helper.h b/include/drm/drm_vblank_helper.h
index 74a971d0cfba..fcd8a9b35846 100644
--- a/include/drm/drm_vblank_helper.h
+++ b/include/drm/drm_vblank_helper.h
@@ -6,8 +6,31 @@
 #include <linux/hrtimer_types.h>
 #include <linux/types.h>
 
+struct drm_atomic_state;
 struct drm_crtc;
 
+/*
+ * VBLANK helpers
+ */
+
+void drm_crtc_vblank_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_atomic_state *state);
+void drm_crtc_vblank_atomic_enable(struct drm_crtc *crtc,
+				   struct drm_atomic_state *state);
+void drm_crtc_vblank_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_atomic_state *crtc_state);
+
+/**
+ * DRM_CRTC_HELPER_VBLANK_FUNCS - Default implementation for VBLANK helpers
+ *
+ * This macro initializes struct &drm_crtc_helper_funcs to default helpers
+ * for VBLANK handling.
+ */
+#define DRM_CRTC_HELPER_VBLANK_FUNCS \
+	.atomic_flush = drm_crtc_vblank_atomic_flush, \
+	.atomic_enable = drm_crtc_vblank_atomic_enable, \
+	.atomic_disable = drm_crtc_vblank_atomic_disable
+
 /*
  * VBLANK timer
  */
-- 
2.50.1


