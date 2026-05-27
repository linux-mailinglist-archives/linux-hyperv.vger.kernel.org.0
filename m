Return-Path: <linux-hyperv+bounces-11222-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKzRDSX1FmrUywcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11222-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:44:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FE5E5414
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611043006B59
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C793F164D;
	Wed, 27 May 2026 13:39:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8730F80C
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889179; cv=none; b=gSu7qrdOLqDhqTU4crD55nYCUY+CnxeLPBHBYrGvtSsV/U5teIC+cjYcVrlRSYqBTcPVX93ar9jyafvVOfZq6BmlSMyPsLzTaXekIHEThwhlWK9mMIp+et3T7092voB6vd/H1LnJvJnC2aZB1i8YkZK5gtE/A+fJ8RIrqwvc1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889179; c=relaxed/simple;
	bh=AOB3jdrJgU94euS3KTCgpwCuGtR85fB9/bXpxCAa3ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAN8vWMCIDX8Ea/cMVLnpeP0S6L4Er0aXZCCtRf5ZSDUCVKBWPVikBiGjosphlS1pRS1qe8PQoPGwU2YcCd6Jr7VL/yzBQigBumlJYvI1aGVebc/zFA7koMNpwJIpNyCy+tYr7ekdoQHxCU8FXnIJms6oTJ7uTXh3tca7r4+a3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9B6A676DD;
	Wed, 27 May 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D495A861;
	Wed, 27 May 2026 13:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +EXgDgz0FmrpMQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 13:39:24 +0000
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
Subject: [PATCH v2 2/9] drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
Date: Wed, 27 May 2026 15:32:43 +0200
Message-ID: <20260527133917.207150-3-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11222-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.886];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ffwll.ch:email]
X-Rspamd-Queue-Id: 824FE5E5414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add DRM_VBLANK_FLAG_SIMULATED for CRTCs that do not have a hardware
vblank interrupt. Setting the flag tells DRM to not report vblank
capabilities from the WAIT_VBLANK ioctl.

DRM_IOCTL_WAIT_VBLANK queries timestamps from a vblank event or waits
for the next vblank event to occur. DRM clients use this functionality
to synchronize their output with the display's vblank phase. Hence this
is only supported for hardware implementations.

Software implementations are not synchronized to the display and merely
act as a rate limiter for page-flip events. The WAIT_VBLANK ioctl thus
should fail with an error.

v2:
- add filter in CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)

Suggested-by: Simona Vetter <simona@ffwll.ch>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 10 ++++++++++
 include/drm/drm_vblank.h     |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 21ca91b4c014..3ef4ed08e7f6 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1794,6 +1794,9 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 
 	vblank = drm_vblank_crtc(dev, pipe);
 
+	if (vblank->flags & DRM_VBLANK_FLAG_SIMULATED)
+		return -EOPNOTSUPP;
+
 	/* If the counter is currently enabled and accurate, short-circuit
 	 * queries to return the cached timestamp of the last vblank.
 	 */
@@ -2035,6 +2038,10 @@ int drm_crtc_get_sequence_ioctl(struct drm_device *dev, void *data,
 	pipe = drm_crtc_index(crtc);
 
 	vblank = drm_crtc_vblank_crtc(crtc);
+
+	if (vblank->flags & DRM_VBLANK_FLAG_SIMULATED)
+		return -EOPNOTSUPP;
+
 	vblank_enabled = READ_ONCE(vblank->config.disable_immediate) &&
 		READ_ONCE(vblank->enabled);
 
@@ -2102,6 +2109,9 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 
 	vblank = drm_crtc_vblank_crtc(crtc);
 
+	if (vblank->flags & DRM_VBLANK_FLAG_SIMULATED)
+		return -EOPNOTSUPP;
+
 	e = kzalloc_obj(*e);
 	if (e == NULL)
 		return -ENOMEM;
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 39a201b83781..03fa7259b6ac 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -37,6 +37,11 @@ struct drm_device;
 struct drm_crtc;
 struct drm_vblank_work;
 
+/**
+ * DRM_VBLANK_FLAG_SIMULATED - vblank uses a software timer
+ */
+#define DRM_VBLANK_FLAG_SIMULATED	BIT(1)
+
 /**
  * struct drm_pending_vblank_event - pending vblank event tracking
  */
-- 
2.54.0


