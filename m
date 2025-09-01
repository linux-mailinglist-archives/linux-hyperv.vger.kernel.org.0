Return-Path: <linux-hyperv+bounces-6683-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812DB3E14A
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Sep 2025 13:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F43B8119
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Sep 2025 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4CD1DFE09;
	Mon,  1 Sep 2025 11:15:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3D212574
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Sep 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725339; cv=none; b=IkE1zchxIbnEFj6ATrPG3gxvQ5AZ0AQzOh5nfQfWg1mkCDn4rpSF95n6MUxfabQeYxkYlTuxoLkdqyewW9pbEJxNBdbW/8Il6DD7wGiKryKQ9PgV4Gt/r791GmprzEEeZx02hPN7AxD6FHpPoN0adNXfx3j5ihM4XpVm+mms7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725339; c=relaxed/simple;
	bh=+D26bFuFus/cDnq9rct8lljHFLfytboQ3QYPS1jyEhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwWFhPJoJLAq1l1J/xDXiL3lBaABNTiPyr65WzxYiovrFFjpUIFeOS72WFql+4EKCcs+UpurtYBe+ZJXMwtTrVMjJrwKKX/TyzBLA6sb2nJm4zmqTZcLgmzaHHkjCgXn4kSIZAdp9gl1ryWuJ/KPKlmCNd0j3NMdE3/Fj1v4Nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCB1F2118F;
	Mon,  1 Sep 2025 11:15:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39DE613A31;
	Mon,  1 Sep 2025 11:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2GjuDFKAtWj8EAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Sep 2025 11:15:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: louis.chauvet@bootlin.com,
	drawat.floss@gmail.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	mhklinux@outlook.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/4] drm/vkms: Convert to DRM's vblank timer
Date: Mon,  1 Sep 2025 13:07:00 +0200
Message-ID: <20250901111241.233875-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901111241.233875-1-tzimmermann@suse.de>
References: <20250901111241.233875-1-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: CCB1F2118F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Replace vkms' vblank timer with the DRM implementation. The DRM
code is identical in concept, but differs in implementation.

Vblank timers are covered in vblank helpers and initializer macros,
so remove the corresponding hrtimer in struct vkms_output. The
vblank timer calls vkms' custom timeout code via handle_vblank_timeout
in struct drm_crtc_helper_funcs.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 83 +++-----------------------------
 drivers/gpu/drm/vkms/vkms_drv.h  |  2 -
 2 files changed, 7 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index e60573e0f3e9..bd79f24686dc 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -7,25 +7,18 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_vblank_helper.h>
 
 #include "vkms_drv.h"
 
-static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
+static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 {
-	struct vkms_output *output = container_of(timer, struct vkms_output,
-						  vblank_hrtimer);
-	struct drm_crtc *crtc = &output->crtc;
+	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
 	struct vkms_crtc_state *state;
-	u64 ret_overrun;
 	bool ret, fence_cookie;
 
 	fence_cookie = dma_fence_begin_signalling();
 
-	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
-					  output->period_ns);
-	if (ret_overrun != 1)
-		pr_warn("%s: vblank timer overrun\n", __func__);
-
 	spin_lock(&output->lock);
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
@@ -57,55 +50,6 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	dma_fence_end_signalling(fence_cookie);
 
-	return HRTIMER_RESTART;
-}
-
-static int vkms_enable_vblank(struct drm_crtc *crtc)
-{
-	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-
-	hrtimer_setup(&out->vblank_hrtimer, &vkms_vblank_simulate, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
-	out->period_ns = ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
-
-	return 0;
-}
-
-static void vkms_disable_vblank(struct drm_crtc *crtc)
-{
-	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-
-	hrtimer_cancel(&out->vblank_hrtimer);
-}
-
-static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
-				      int *max_error, ktime_t *vblank_time,
-				      bool in_vblank_irq)
-{
-	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
-	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-
-	if (!READ_ONCE(vblank->enabled)) {
-		*vblank_time = ktime_get();
-		return true;
-	}
-
-	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
-
-	if (WARN_ON(*vblank_time == vblank->time))
-		return true;
-
-	/*
-	 * To prevent races we roll the hrtimer forward before we do any
-	 * interrupt processing - this is how real hw works (the interrupt is
-	 * only generated after all the vblank registers are updated) and what
-	 * the vblank core expects. Therefore we need to always correct the
-	 * timestampe by one frame.
-	 */
-	*vblank_time -= output->period_ns;
-
 	return true;
 }
 
@@ -159,9 +103,7 @@ static const struct drm_crtc_funcs vkms_crtc_funcs = {
 	.reset                  = vkms_atomic_crtc_reset,
 	.atomic_duplicate_state = vkms_atomic_crtc_duplicate_state,
 	.atomic_destroy_state   = vkms_atomic_crtc_destroy_state,
-	.enable_vblank		= vkms_enable_vblank,
-	.disable_vblank		= vkms_disable_vblank,
-	.get_vblank_timestamp	= vkms_get_vblank_timestamp,
+	DRM_CRTC_VBLANK_TIMER_FUNCS,
 	.get_crc_sources	= vkms_get_crc_sources,
 	.set_crc_source		= vkms_set_crc_source,
 	.verify_crc_source	= vkms_verify_crc_source,
@@ -213,18 +155,6 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 	return 0;
 }
 
-static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
-				    struct drm_atomic_state *state)
-{
-	drm_crtc_vblank_on(crtc);
-}
-
-static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
-				     struct drm_atomic_state *state)
-{
-	drm_crtc_vblank_off(crtc);
-}
-
 static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
 	__acquires(&vkms_output->lock)
@@ -265,8 +195,9 @@ static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
 	.atomic_check	= vkms_crtc_atomic_check,
 	.atomic_begin	= vkms_crtc_atomic_begin,
 	.atomic_flush	= vkms_crtc_atomic_flush,
-	.atomic_enable	= vkms_crtc_atomic_enable,
-	.atomic_disable	= vkms_crtc_atomic_disable,
+	.atomic_enable	= drm_crtc_vblank_atomic_enable,
+	.atomic_disable	= drm_crtc_vblank_atomic_disable,
+	.handle_vblank_timeout = vkms_crtc_handle_vblank_timeout,
 };
 
 struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *primary,
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8013c31efe3b..fb9711e1c6fb 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -215,8 +215,6 @@ struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_writeback_connector wb_connector;
 	struct drm_encoder wb_encoder;
-	struct hrtimer vblank_hrtimer;
-	ktime_t period_ns;
 	struct workqueue_struct *composer_workq;
 	spinlock_t lock;
 
-- 
2.50.1


