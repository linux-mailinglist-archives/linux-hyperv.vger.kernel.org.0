Return-Path: <linux-hyperv+bounces-11220-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBnPLAr1Fmo6ygcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11220-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:43:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF25E53D6
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3761730182B0
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A840FDB6;
	Wed, 27 May 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hHXXBoRc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g53jZ74E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hHXXBoRc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g53jZ74E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA605413241
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889169; cv=none; b=i6lOhQTedrXw2c/TsV2TJlzIJ3DDzT79xtpJ46UsCrKmixdRsTNdzjYBzdvc/Gd09iBGpvNwi65XViaa3SkuNvKPUHWC0busQDNB5UlR8DgrYQslRIfBumfrVgsMi+CVYul5Cx09ej9kFpEX9H7u5xLDAD3qWhVar0ZrIRI5F14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889169; c=relaxed/simple;
	bh=sypgsYPyZsWe/30bnD/zrSVMZ9Ym1NDb0SWEy19+I68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQQZG0SbDt7Tmse67FMNnBFKcn4ned25PZw6LCY1R+BC1A07L0uY/ShyICyXh47QZ7RiIoszx5ATVGfv4AmI5rC+vnUvyI8CgQnlj7ZJ1a1cd/C7E0We8cvAxQyhYYSts+lmOEMIQQJRjU1kNXvcD5DK3tDDDy5Gb0zOMxcQ6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hHXXBoRc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g53jZ74E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hHXXBoRc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g53jZ74E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6B016784D;
	Wed, 27 May 2026 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fa0o4L+TiUfl080fZj4IepoONTx3k67eL9eyn26jL/c=;
	b=hHXXBoRcv8gGLDPL0F0NUH/5J59nDKYKfoG7WlM/ETObnMyc3ZFxqnkBP67cnI51tI7EM+
	K1RaDQN4dKCLCqADoJLTA1h5WdQ6h6cPO5jvMzStrWQ2KI/r7APxaqfBmXFLBqa8rerfKS
	dfdAHAf1anUIVw0l9XQBQSaQs7LI/XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fa0o4L+TiUfl080fZj4IepoONTx3k67eL9eyn26jL/c=;
	b=g53jZ74EkZ0EWI19n7aGAebipKUr9weLM8EJdVqsppQbSZd7Je1bqWAQDeOwlUXHDAaIVn
	Qfl0VHISJwPDxMDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fa0o4L+TiUfl080fZj4IepoONTx3k67eL9eyn26jL/c=;
	b=hHXXBoRcv8gGLDPL0F0NUH/5J59nDKYKfoG7WlM/ETObnMyc3ZFxqnkBP67cnI51tI7EM+
	K1RaDQN4dKCLCqADoJLTA1h5WdQ6h6cPO5jvMzStrWQ2KI/r7APxaqfBmXFLBqa8rerfKS
	dfdAHAf1anUIVw0l9XQBQSaQs7LI/XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fa0o4L+TiUfl080fZj4IepoONTx3k67eL9eyn26jL/c=;
	b=g53jZ74EkZ0EWI19n7aGAebipKUr9weLM8EJdVqsppQbSZd7Je1bqWAQDeOwlUXHDAaIVn
	Qfl0VHISJwPDxMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6036C5A861;
	Wed, 27 May 2026 13:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xvcOFgv0FmrpMQAAD6G6ig
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
Subject: [PATCH v2 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
Date: Wed, 27 May 2026 15:32:41 +0200
Message-ID: <20260527133917.207150-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	TAGGED_FROM(0.00)[bounces-11220-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,people.freedesktop.org:url]
X-Rspamd-Queue-Id: 16DF25E53D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
refresh. This is meaningless with vblank timers, which run unrelated
to the hardware's vblank.

Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
for CRTCs with simulated vblank events in all such drivers. The vblank
timers of these devices still rate-limit the number of page-flip events
to match the display refresh.

According to maintainers, user-space compositors do not require the ioctl
for rate-limitting display output. Weston, Kwin and Mutter rely on completion
events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize the
time from input to output.

When testing with mutter and weston, the page-flip rate appears correct
with the patch set applied.

This change has been discussed at length on IRC recently.

https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-08&show_html=true
https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-12&show_html=true
https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-13&show_html=true
https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-15&show_html=true

v2:
- add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)
- clarify Mutter's behavior in cover letter (Michel)

Thomas Zimmermann (9):
  drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
  drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
  drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
  drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
  drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
  drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
  drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
  drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
  drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
 drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++------
 drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
 drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
 drivers/gpu/drm/tiny/bochs.c                |  2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
 include/drm/drm_crtc.h                      |  2 +-
 include/drm/drm_device.h                    |  2 +-
 include/drm/drm_vblank.h                    | 15 +++++++++++-
 12 files changed, 45 insertions(+), 19 deletions(-)


base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
-- 
2.54.0


