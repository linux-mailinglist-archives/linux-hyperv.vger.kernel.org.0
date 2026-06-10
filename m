Return-Path: <linux-hyperv+bounces-11583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t2pSO6aDKWqSYQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11583-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 17:32:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0066AD0E
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 17:32:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ofbw+I8E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZadUv3kr;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ofbw+I8E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZadUv3kr;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11583-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11583-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 832D9304F4CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7D425CD2;
	Wed, 10 Jun 2026 15:25:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF38425CF5
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 15:25:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105120; cv=none; b=HIh/9GYZmqr1hYzJY7iV7dkZ8zfFq4rsJidwLiIuF0gCxtrIIxCao1wB9CTQMamf5hPi2O57gzRidJG69XJV9KNlioNHzd/CIb1E1lX/N6jj6KLWS3KqPfIu1hJybnnvZUjzyIhsCRWzBqGR7DKomiqH76F+iK8eWeIctZ5FbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105120; c=relaxed/simple;
	bh=ezZlOCs6+qWQPNVBdVwNz5GRAzgapegSr0qDJIr12ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boJ2f+AK8CJ/U33XdBTgFyLR98XwXe6svStiRwqdRoCshM/KoN39hx8DiG6cXcGPtIPYVigcEuCF9DPgheyUuazryQ9WQyCPjmG0AS4vZhXJV3ijoeMq+y0+hRJ5sud8QnI0vj6s4SfhBroaRzHMXHTY4yEzkJaXJ0SLWioy7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ofbw+I8E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZadUv3kr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ofbw+I8E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZadUv3kr; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB13F6AE85;
	Wed, 10 Jun 2026 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cbSdKO0RWgsTw4xxGPpPidtmybVhhY9oAG7VyTdwfbk=;
	b=Ofbw+I8EpjdWA54MBoZwLZ9EVyh3w0VJaMvVmdK7iNgf0aXC1yxt84HNEqXK8w0no4erFc
	cLoDCcIS6uO9Pn4ARImm5VZjqYxRvFPP+LxmrozXMiwRbabdK+F0i/yeQiCKY09hcDwytF
	UY0fA2Qdo6nl3dEUT+7SqIGAXFAHBI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cbSdKO0RWgsTw4xxGPpPidtmybVhhY9oAG7VyTdwfbk=;
	b=ZadUv3krn4Ug1Qrz9RDVscZKfDdsRoZELhTayY9Rp+vE4ldXvG3TBN+tP0r0EmNHX2u512
	6t4n71EsbnrsizCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cbSdKO0RWgsTw4xxGPpPidtmybVhhY9oAG7VyTdwfbk=;
	b=Ofbw+I8EpjdWA54MBoZwLZ9EVyh3w0VJaMvVmdK7iNgf0aXC1yxt84HNEqXK8w0no4erFc
	cLoDCcIS6uO9Pn4ARImm5VZjqYxRvFPP+LxmrozXMiwRbabdK+F0i/yeQiCKY09hcDwytF
	UY0fA2Qdo6nl3dEUT+7SqIGAXFAHBI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cbSdKO0RWgsTw4xxGPpPidtmybVhhY9oAG7VyTdwfbk=;
	b=ZadUv3krn4Ug1Qrz9RDVscZKfDdsRoZELhTayY9Rp+vE4ldXvG3TBN+tP0r0EmNHX2u512
	6t4n71EsbnrsizCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DD44779A7;
	Wed, 10 Jun 2026 15:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RjDtAdeBKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:11 +0000
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
	mhklkml@zohomail.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	javierm@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 00/15] drm: Improve logic behind damage handling
Date: Wed, 10 Jun 2026 17:18:16 +0200
Message-ID: <20260610152505.260172-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.79
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-11583-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mripard@kernel.org,m:maarten.lankhorst@linux.intel.com,m:airlied@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:admin@kodeit.net,m:gargaditya08@proton.me,m:paul@crapouillou.net,m:jani.nikula@linux.intel.com,m:mhklkml@zohomail.com,m:zack.rusin@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:javierm@redhat.com,m:dmitry.osipenko@collabora.com,m:gurchetansingh@chromium.org,m:olvaffe@gmail.com,m:dri-devel@lists.freedesktop.org,m:linux-hyperv@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:linux-mips@vger.kernel.org,m:virtualization@lists.linux.dev,m:amd-gfx@lists.freedesktop.org,m:tzimmermann@suse.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4C0066AD0E

DRM clients can supply information on framebuffer areas to update as
part of each page flip, called damage-clipping rectangles. But DRM's
processing of this information is inconsistent and prone to errors.

- There are multiple fields and tests that decide if damage clips
should be taken or ignored.

- Sometimes damage clips are removed behind the back of the DRM client.

- Atomic helpers evaluate damage clipping in the middle of the atomic
check: after connectors and encoders, but before planes and CRTCs. Hence
pipeline stages have an inconsistent view.

- Which leads to drivers (ingenic) doing a re-evaluation if necessary.

- Tests of plane source coordinates only happen during commits. At this
point, the driver should already know if damage clips are to be taken or
not. Because of this, some drivers (appletbdrm) might operate on incorrect
damage information for their internal workings. This also leads to excessive
use of the old plane state.

Therefore go through DRM helpers and drivers and fix the logic.

- Run all of the atomic checks with the damage information supplied by
DRM clients. Afterwards evaluate plane and CRTC states on whether to
take or ignore damage clips. Do all related tests in a single atomic
helper.

- Do not discard damage clips. Set ignore_damage_clips in struct
drm_plane_state instead. This includes changes to plane source-coordinates.
The damage iterator now only has to look at this flag to detect if it
should use the damage clips. 

- Go over drivers and fix the damage handling in the plane's
atomic_update helpers. Most drivers no longer need the old plane state
in their update.

- The appletbdrm driver requires a fix in how it uses damage information.
Ingenic and vmwgfx can be simplified. These changes improve the drivers'
code organization.

- Add support for ignore_damage_clips to various drivers that ignored it
until now.

- Kunit tests require some changes. Drop some obsolete tests and add a new
one for ignore_damage_flags.

Tested with bochs, mgag200, Kunit tests.

v5:
- support ignore_damage_clips in amdgpu, i915, virtgpu, vmwgfx
- reorder patches to avoid possible regressions during the series
- fix clearing ignore_damage_clips in a separate patch (Javier)
v4:
- reorder patches to avoid error-prone intermediate state
v3:
- fix error path in appletbdrm
v2:
- rebase on latest upstream

Thomas Zimmermann (15):
  drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips
  drm/i915/display: Handle struct drm_plane_state.ignore_damage_clips
  drm/vboxvideo: Handle struct drm_plane_state.ignore_damage_clips
  drm/vmwgfx: Handle struct drm_plane_state.ignore_damage_clips
  drm/appletbdrm: Allocate request/response buffers in begin_fb_access
  drm/damage-helper: Clear ignore_damage_clips in plane-state
    duplication
  drm/damage-helper: Do not alter damage clips on modeset, but ignore
    them
  drm/atomic-helpers: Evaluate plane damage after atomic_check
  drm/ingenic: Remove calls to drm_atomic_helper_check_plane_damage()
  drm/atomic_helper: Do not evaluate plane damage before atomic_check
  drm/damage-helper: Test src coord in
    drm_atomic_helper_check_plane_damage()
  drm/damage-helper: Remove old state from
    drm_atomic_helper_damage_iter_init()
  drm/damage-helper: Remove old state from
    drm_atomic_helper_damage_merged()
  drm/damage-helper: Rename state parameters in damage helpers
  drm/vmwgfx: Remove unused field struct
    vmwgfx_du_update_plane.old_state

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 +-
 drivers/gpu/drm/ast/ast_cursor.c              |   3 +-
 drivers/gpu/drm/ast/ast_mode.c                |   2 +-
 drivers/gpu/drm/drm_atomic_helper.c           |   6 +-
 drivers/gpu/drm/drm_atomic_state_helper.c     |   1 +
 drivers/gpu/drm/drm_damage_helper.c           |  44 ++--
 drivers/gpu/drm/drm_fb_dma_helper.c           |   2 +-
 drivers/gpu/drm/drm_mipi_dbi.c                |   3 +-
 drivers/gpu/drm/gud/gud_pipe.c                |   3 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |   3 +-
 drivers/gpu/drm/i915/display/intel_plane.c    |  11 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |   8 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |   3 -
 drivers/gpu/drm/ingenic/ingenic-ipu.c         |   8 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c        |   3 +-
 drivers/gpu/drm/sitronix/st7571.c             |   3 +-
 drivers/gpu/drm/sitronix/st7586.c             |   3 +-
 drivers/gpu/drm/sitronix/st7920.c             |   3 +-
 drivers/gpu/drm/solomon/ssd130x.c             |   9 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c     |   3 +-
 .../gpu/drm/tests/drm_damage_helper_test.c    | 200 +++---------------
 drivers/gpu/drm/tiny/appletbdrm.c             |  59 +++---
 drivers/gpu/drm/tiny/bochs.c                  |   3 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c            |   2 +-
 drivers/gpu/drm/tiny/gm12u320.c               |   2 +-
 drivers/gpu/drm/tiny/ili9225.c                |   3 +-
 drivers/gpu/drm/tiny/repaper.c                |   2 +-
 drivers/gpu/drm/tiny/sharp-memory.c           |   3 +-
 drivers/gpu/drm/udl/udl_modeset.c             |   3 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c         |  11 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c        |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h           |   2 -
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c           |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c          |  12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c          |  15 +-
 include/drm/drm_damage_helper.h               |   9 +-
 37 files changed, 148 insertions(+), 325 deletions(-)


base-commit: fc59f76558703febba8056be87d1c97d14f7485e
-- 
2.54.0


