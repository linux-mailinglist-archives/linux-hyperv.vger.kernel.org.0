Return-Path: <linux-hyperv+bounces-11221-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCJFLxn1Fmo6ygcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11221-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:43:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4022C5E53ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3486D305EA68
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2541323C;
	Wed, 27 May 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MYaQyBqz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kh8H3Z5y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MYaQyBqz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kh8H3Z5y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B293EDAD3
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889171; cv=none; b=qHeXC7sUU86EVS4bHQ+k2hGCi06MEjyh0aH2wPfV50mo2BBpFRHhR/GY5PKxM2YKfPtpDUFCh9RX44LS6W/g5MuZXNpTursA7lE4LqRjWVMcODgcxj8ZBOk295RkSG+7r54FXnJ7cA7Bw5bV5kwtpKEp/iwh+Sc9MgcsHhKXmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889171; c=relaxed/simple;
	bh=kIXoXq3gYCeLYkYOvUsKlv7nZ3Gk00tErWaKGrTCzvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dta4DJbWpxkOrpwPJZMML9G6oE5N0R0gsa7J468gXIiTnp5UJLom7w94v/eqqGfukmy+rr1KIRV0t0PKs5K1MokXBMqEkFYcAagHucoNs1gw6a9rw1lEwJsdu8JUL/plmu79dBTvqXAHCEIhvQIIo+s3TU77ccZdvqsHq7DwMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MYaQyBqz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kh8H3Z5y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MYaQyBqz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kh8H3Z5y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A6366AEAB;
	Wed, 27 May 2026 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkFzuG/sYYx6WIe7zLxbB3YnbN+OJD7lXRTEH4WXPnA=;
	b=MYaQyBqzpd7dr1BQLUQfF4gNJKdpVp3rlZWAJY/x4zpGq/JpmzHCPcazxI8Wlc3UTLD8qF
	PF2LTLMER0uZiuYRuB/hTT1fV3bjgxX9JxjstaAM6KiAmJKI/HBGBKfTF6Np+mSVhU8ErD
	2LRlUhexd1cuSITBab6CjEjkdm6hvRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkFzuG/sYYx6WIe7zLxbB3YnbN+OJD7lXRTEH4WXPnA=;
	b=kh8H3Z5yRkETWTuzy/00wtvHqYaQjF53nFyOvGspaCvrfYcv89CdAlx5Xi9OD+aKAFb85G
	DhLQyJkTBeenIEBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkFzuG/sYYx6WIe7zLxbB3YnbN+OJD7lXRTEH4WXPnA=;
	b=MYaQyBqzpd7dr1BQLUQfF4gNJKdpVp3rlZWAJY/x4zpGq/JpmzHCPcazxI8Wlc3UTLD8qF
	PF2LTLMER0uZiuYRuB/hTT1fV3bjgxX9JxjstaAM6KiAmJKI/HBGBKfTF6Np+mSVhU8ErD
	2LRlUhexd1cuSITBab6CjEjkdm6hvRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkFzuG/sYYx6WIe7zLxbB3YnbN+OJD7lXRTEH4WXPnA=;
	b=kh8H3Z5yRkETWTuzy/00wtvHqYaQjF53nFyOvGspaCvrfYcv89CdAlx5Xi9OD+aKAFb85G
	DhLQyJkTBeenIEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCBBB5A863;
	Wed, 27 May 2026 13:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YD7HMAv0FmrpMQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 13:39:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	mdaenzer@redhat.com,
	pekka.paalanen@collabora.com,
	jadahl@gmail.com,
	contact@emersion.fr,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	mhklinux@outlook.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	wayland-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/9] drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
Date: Wed, 27 May 2026 15:32:42 +0200
Message-ID: <20260527133917.207150-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527133917.207150-1-tzimmermann@suse.de>
References: <20260527133917.207150-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11221-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org,outlook.com];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4022C5E53ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename drm_vblank_init() to drmm_vblank_init(). As the initializer
function sets up managed cleanup, it should use the drmm prefix. Keep
the old name around until all callers have been converted.

Also add a flags argument to the function. The first use of the flags
will be to distinguish between hardware vblank interrupts and simulated
vblank timeouts.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c        | 16 +++++++++-------
 drivers/gpu/drm/drm_vblank_helper.c |  2 +-
 include/drm/drm_crtc.h              |  2 +-
 include/drm/drm_device.h            |  2 +-
 include/drm/drm_vblank.h            | 10 +++++++++-
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..21ca91b4c014 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -117,7 +117,7 @@
  * optionally provide a hardware vertical blanking counter.
  *
  * Drivers must initialize the vertical blanking handling core with a call to
- * drm_vblank_init(). Minimally, a driver needs to implement
+ * drmm_vblank_init(). Minimally, a driver needs to implement
  * &drm_crtc_funcs.enable_vblank and &drm_crtc_funcs.disable_vblank plus call
  * drm_crtc_handle_vblank() in its vblank interrupt handler for working vblank
  * support.
@@ -146,7 +146,7 @@
  * See also DRM vblank helpers for more information.
  *
  * Drivers without support for vertical-blanking interrupts nor timers must
- * not call drm_vblank_init(). For these drivers, atomic helpers will
+ * not call drmm_vblank_init(). For these drivers, atomic helpers will
  * automatically generate fake vblank events as part of the display update.
  * This functionality also can be controlled by the driver by enabling and
  * disabling struct drm_crtc_state.no_vblank.
@@ -519,7 +519,7 @@ static void vblank_disable_fn(struct timer_list *t)
 	spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
 }
 
-static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
+static void drmm_vblank_init_release(struct drm_device *dev, void *ptr)
 {
 	struct drm_vblank_crtc *vblank = ptr;
 
@@ -534,9 +534,10 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 }
 
 /**
- * drm_vblank_init - initialize vblank support
+ * drmm_vblank_init - initialize vblank support
  * @dev: DRM device
  * @num_crtcs: number of CRTCs supported by @dev
+ * @flags: flags for vblank handling
  *
  * This function initializes vblank support for @num_crtcs display pipelines.
  * Cleanup is handled automatically through a cleanup function added with
@@ -545,7 +546,7 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
  * Returns:
  * Zero on success or a negative error code on failure.
  */
-int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
+int drmm_vblank_init(struct drm_device *dev, unsigned int num_crtcs, unsigned int flags)
 {
 	int ret;
 	unsigned int i;
@@ -564,11 +565,12 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 
 		vblank->dev = dev;
 		vblank->pipe = i;
+		vblank->flags = flags;
 		init_waitqueue_head(&vblank->queue);
 		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
 		seqlock_init(&vblank->seqlock);
 
-		ret = drmm_add_action_or_reset(dev, drm_vblank_init_release,
+		ret = drmm_add_action_or_reset(dev, drmm_vblank_init_release,
 					       vblank);
 		if (ret)
 			return ret;
@@ -580,7 +582,7 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_vblank_init);
+EXPORT_SYMBOL(drmm_vblank_init);
 
 /**
  * drm_dev_has_vblank - test if vblanking has been initialized for
diff --git a/drivers/gpu/drm/drm_vblank_helper.c b/drivers/gpu/drm/drm_vblank_helper.c
index d3f8147ecdc1..5b05ab72e133 100644
--- a/drivers/gpu/drm/drm_vblank_helper.c
+++ b/drivers/gpu/drm/drm_vblank_helper.c
@@ -25,7 +25,7 @@
  * for drivers without further requirements. The initializer macro
  * DRM_CRTC_HELPER_VBLANK_FUNCS sets them coveniently.
  *
- * Once the driver enables vblank support with drm_vblank_init(), each
+ * Once the driver enables vblank support with drmm_vblank_init(), each
  * CRTC's vblank timer fires according to the programmed display mode. By
  * default, the vblank timer invokes drm_crtc_handle_vblank(). Drivers with
  * more specific requirements can set their own handler function in
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index c6dbe8b7db9e..f981468d9a00 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -163,7 +163,7 @@ struct drm_crtc_state {
 	 *
 	 * One usage is for drivers and/or hardware without support for VBLANK
 	 * interrupts. Such drivers typically do not initialize vblanking
-	 * (i.e., call drm_vblank_init() with the number of CRTCs). For CRTCs
+	 * (i.e., call drmm_vblank_init() with the number of CRTCs). For CRTCs
 	 * without initialized vblanking, this field is set to true in
 	 * drm_atomic_helper_check_modeset(), and a fake VBLANK event will be
 	 * send out on each update of the display pipeline by
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 768a8dae83c5..742996576313 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -283,7 +283,7 @@ struct drm_device {
 	 * Array of vblank tracking structures, one per &struct drm_crtc. For
 	 * historical reasons (vblank support predates kernel modesetting) this
 	 * is free-standing and not part of &struct drm_crtc itself. It must be
-	 * initialized explicitly by calling drm_vblank_init().
+	 * initialized explicitly by calling drmm_vblank_init().
 	 */
 	struct drm_vblank_crtc *vblank;
 
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f5b1..39a201b83781 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -282,10 +282,12 @@ struct drm_vblank_crtc {
 	 * @vblank_timer: Holds the state of the vblank timer
 	 */
 	struct drm_vblank_crtc_timer vblank_timer;
+
+	unsigned int flags;
 };
 
 struct drm_vblank_crtc *drm_crtc_vblank_crtc(struct drm_crtc *crtc);
-int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
+int drmm_vblank_init(struct drm_device *dev, unsigned int num_crtcs, unsigned int flags);
 bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
 u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
@@ -321,6 +323,12 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc);
 void drm_crtc_vblank_cancel_timer(struct drm_crtc *crtc);
 void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_time);
 
+/* deprecated; use drmm_vblank_init() instead */
+static inline int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
+{
+	return drmm_vblank_init(dev, num_crtcs, 0);
+}
+
 /*
  * Helpers for struct drm_crtc_funcs
  */
-- 
2.54.0


