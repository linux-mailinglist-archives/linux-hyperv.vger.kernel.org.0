Return-Path: <linux-hyperv+bounces-10902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BmhBSgSB2rgrQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10902-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559D54F995
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE46D30C805B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E207477998;
	Fri, 15 May 2026 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DsHqrlw3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/sWfupLr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DsHqrlw3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/sWfupLr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5721EFFA1
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846963; cv=none; b=M36Oo1oUzCqq/0V7XhadWPWJU1CfTXc4injy8oqgUSt884JN2d9pz2reehUCIbu1On1qNG1KNJVjY91HTHY0j9uho+IPA2aryJpkohfud4Jj+muRnuHE04EKaHGrwdhoGblMQ0euvCAz6W9MDi7m6plFbtlr/TuZpzy/O+oCYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846963; c=relaxed/simple;
	bh=vgmCpCy5Q5Hw5Fbo3KB8oajCbeSwiJ1H/lAyB+0qNkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/c7tv4k2qiFnoOfv206O0lFSH9cJGp7tUSNH3pcHIoHRt+a4TcaSxAfWYpt/pthsEd0HWvTBT6B2PKLWa4ayu7iDR0u4GYzzF/UL2n8pN1EW7huOMSK6s2DM/45Y/A3GhZla/yO4TCvBM1rO0cU6u/NU5AkGP8OV1Lm1ACfIlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DsHqrlw3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/sWfupLr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DsHqrlw3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/sWfupLr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DD435EBEE;
	Fri, 15 May 2026 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rkfFGa7sf/Wst/1mgTnUI7HKTMZ3j+MGrZJ1N7mWRJY=;
	b=DsHqrlw3LPqBkDyOKNcKjhODiuj6HGpBREyYlkyaMDkFOc2hp3GkpwJEQk9YuFLUZY5VZ6
	+QMDTp0g8FOu8440+2JFk42OFNI3jeFZBwpsTyfPjtMDvtj3CpVf33232HUvCWrCOGum9P
	vucQ9BXUSeGVQnWfR81VJOVwKL2KsO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rkfFGa7sf/Wst/1mgTnUI7HKTMZ3j+MGrZJ1N7mWRJY=;
	b=/sWfupLr7k8cocl4GxzpYQFvhyBhXUdiZdEsfiTCb39jShbm+0amxOOxQs2tbK5mLBOyec
	EhxOE+WKKGT2gFDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rkfFGa7sf/Wst/1mgTnUI7HKTMZ3j+MGrZJ1N7mWRJY=;
	b=DsHqrlw3LPqBkDyOKNcKjhODiuj6HGpBREyYlkyaMDkFOc2hp3GkpwJEQk9YuFLUZY5VZ6
	+QMDTp0g8FOu8440+2JFk42OFNI3jeFZBwpsTyfPjtMDvtj3CpVf33232HUvCWrCOGum9P
	vucQ9BXUSeGVQnWfR81VJOVwKL2KsO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rkfFGa7sf/Wst/1mgTnUI7HKTMZ3j+MGrZJ1N7mWRJY=;
	b=/sWfupLr7k8cocl4GxzpYQFvhyBhXUdiZdEsfiTCb39jShbm+0amxOOxQs2tbK5mLBOyec
	EhxOE+WKKGT2gFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FBCF593A9;
	Fri, 15 May 2026 12:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1KOhAvAMB2rQFwAAD6G6ig
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
Subject: [PATCH 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
Date: Fri, 15 May 2026 13:55:05 +0200
Message-ID: <20260515120916.333614-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 8559D54F995
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10902-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
refresh. This is meaningless with vblank timers, which run unrelated
to the hardware's vblank.

Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
for CRTCs with simulated vblank events in all such drivers. The vblank
timers of these devices still rate-limit the number of page-flip events
to match the display refresh.

According to maintainers, user-space compositors do not require the ioctl
for rate-limitting display output. Weston and Kwin rely on page-flip
events. Mutter uses and internal timer to limit the number of display
updates per second.

When testing with mutter and weston, the page-flip rate appears correct
with the patch set applied.

This change has been discussed at length on IRC recently.

https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-08&show_html=true
https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-12&show_html=true
https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-13&show_html=true

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
 drivers/gpu/drm/drm_vblank.c                | 19 ++++++++++++-------
 drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
 drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
 drivers/gpu/drm/tiny/bochs.c                |  2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
 include/drm/drm_crtc.h                      |  2 +-
 include/drm/drm_device.h                    |  2 +-
 include/drm/drm_vblank.h                    | 15 ++++++++++++++-
 12 files changed, 38 insertions(+), 19 deletions(-)


base-commit: 121c16f9d8c56ea07263df84ab971cc10870fe88
-- 
2.54.0


