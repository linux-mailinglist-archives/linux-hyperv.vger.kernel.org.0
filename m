Return-Path: <linux-hyperv+bounces-10903-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFSQIR0SB2rgrQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10903-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A254F97E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F43630CB43D
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C28478E2C;
	Fri, 15 May 2026 12:09:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8245BD57
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846963; cv=none; b=V/b7G3PwS0nGk2YdTzcbYe9GG4Au7W0KJtHBseBmGA26FJ/KggheOgsMzNdEEyiy2PdFKORTZh6hsegJrjMIhOmiZ40CuHQ5zuPddnq2XICGPfOSK2s2KG4lOZJdbNi+sgGklnVbRtfedK24bTh1RiSdBVoLN5UHdXonEBZr6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846963; c=relaxed/simple;
	bh=bTbMayO97fLF9jJJGsmW7NsgDvl0qGTrmk3SIbQZsvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFsScf1L4/PiEG386wXX5bqUyZ8LL7JLz0gOafJ5PFYsNXea08LVDyXyPgTGN0oftFbM7OtO4EuqyrS48+nuUI+vu0xLbwOp++Z2qCzB4CT09+bWh56pmwjgretH/RQMYXwOOYpKHDR/Q62hfftKKzye4pu+aB7ETZntPFrzzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD2DC66D05;
	Fri, 15 May 2026 12:09:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73584593AA;
	Fri, 15 May 2026 12:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OCv1GvAMB2rQFwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 15 May 2026 12:09:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	mdaenzer@redhat.com,
	pekka.paalanen@collabora.com,
	jadahl@gmail.com,
	contact@emersion.fr,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/9] drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
Date: Fri, 15 May 2026 13:55:06 +0200
Message-ID: <20260515120916.333614-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515120916.333614-1-tzimmermann@suse.de>
References: <20260515120916.333614-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: F35A254F97E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10903-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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
index bc78fb77cc27..381417c6b6f5 100644
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


