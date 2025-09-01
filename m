Return-Path: <linux-hyperv+bounces-6681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3FB3E146
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Sep 2025 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FDC189F34B
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Sep 2025 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473A212574;
	Mon,  1 Sep 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3ueMhwG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXj9H/pl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3ueMhwG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXj9H/pl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD11E04AD
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Sep 2025 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725332; cv=none; b=e1qgHkTqi/2faJe803FrMyWUYeXy73HzwcrbQujxfdd+55codUmnAECyOHrY6EomsV8iryRxYcRyblKCUzVl4F3ffEU/D6DYSdYXlQjGLmv74t4nVWX+Y0CvjNztS2FsgKPggslqOwuakDfVkJd374BOf7Jxuq9JZvrEC0BbF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725332; c=relaxed/simple;
	bh=rLZaPGmff/2wGsTEIN77kt7nFvTO1l5VfQxFNqJTKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFXQFnsQV2nOOZe45IdZtrgObOqaOcdZoqsP4cyox0E1vSKAOdKL0cZ4hp/4uWgkQti6s+XfPx5c5gc01qmc7wsqg6lQPOntCzdmkqaMZ+6AkK9WtOTi7bIB7vzh2HeChYp7Bbiyv8IPg7MfWNn1Zwow/8I5Bq5ne9IZSz2t0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3ueMhwG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXj9H/pl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3ueMhwG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXj9H/pl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CA481F7FD;
	Mon,  1 Sep 2025 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756725328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0tJn6Vz+3D+Iz+2Tqo9jg2TopzlQTPWlBW3ykeigvRk=;
	b=u3ueMhwGSsrD5B2VIwHEDM6NB1fSWONB/kbtf2aKkA67YM7HZMy255bGzRpKjXp6a28uE4
	KJVfm2tyZvpdj5xMkgO4zbFx3YiqPZwoSSS2/FCsSvSXkfIB+FzqD7PBmN+pKz2d4eVWSm
	BRUBQsP/f6p8AAoy0IB2kogq1qeLO+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756725328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0tJn6Vz+3D+Iz+2Tqo9jg2TopzlQTPWlBW3ykeigvRk=;
	b=pXj9H/plr5/ws6R70b5+7yVUJ7DbuRqitpulpcPHsC/tDSastV8JE7wvrB04fifXqP2LyS
	OI2O3lhOCbqwcfAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756725328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0tJn6Vz+3D+Iz+2Tqo9jg2TopzlQTPWlBW3ykeigvRk=;
	b=u3ueMhwGSsrD5B2VIwHEDM6NB1fSWONB/kbtf2aKkA67YM7HZMy255bGzRpKjXp6a28uE4
	KJVfm2tyZvpdj5xMkgO4zbFx3YiqPZwoSSS2/FCsSvSXkfIB+FzqD7PBmN+pKz2d4eVWSm
	BRUBQsP/f6p8AAoy0IB2kogq1qeLO+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756725328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0tJn6Vz+3D+Iz+2Tqo9jg2TopzlQTPWlBW3ykeigvRk=;
	b=pXj9H/plr5/ws6R70b5+7yVUJ7DbuRqitpulpcPHsC/tDSastV8JE7wvrB04fifXqP2LyS
	OI2O3lhOCbqwcfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D09BC1378C;
	Mon,  1 Sep 2025 11:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s8dyMU+AtWj8EAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Sep 2025 11:15:27 +0000
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
Subject: [PATCH v2 0/4] drm: Add vblank timers for devices without interrupts
Date: Mon,  1 Sep 2025 13:06:57 +0200
Message-ID: <20250901111241.233875-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,outlook.com,ffwll.ch,linux.intel.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

Compositors often depend on vblanks to limit their display-update
rate. Without, they see vblank events ASAP, which breaks the rate-
limit feature. This creates high CPU overhead. It is especially a
problem with virtual devices with fast framebuffer access.

The series moves vkms' vblank timer to DRM and converts the hyperv
DRM driver. An earlier version of this series contains examples of
other updated drivers. In principle, any DRM driver without vblank
hardware can use the timer.

The series has been motivated by a recent discussion about hypervdrm [1]
and other long-standing bug reports. [2][3]

[1] https://lore.kernel.org/dri-devel/20250523161522.409504-1-mhklinux@outlook.com/T/#ma2ebb52b60bfb0325879349377738fadcd7cb7ef
[2] https://bugzilla.suse.com/show_bug.cgi?id=1189174
[3] https://invent.kde.org/plasma/kwin/-/merge_requests/1229#note_284606

Thomas Zimmermann (4):
  drm/vblank: Add vblank timer
  drm/vblank: Add CRTC helpers for simple use cases
  drm/vkms: Convert to DRM's vblank timer
  drm/hypervdrm: Use vblank timer

 Documentation/gpu/drm-kms-helpers.rst       |  12 ++
 drivers/gpu/drm/Makefile                    |   3 +-
 drivers/gpu/drm/drm_vblank.c                | 122 +++++++++++++-
 drivers/gpu/drm/drm_vblank_helper.c         | 176 ++++++++++++++++++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  11 ++
 drivers/gpu/drm/vkms/vkms_crtc.c            |  83 +--------
 drivers/gpu/drm/vkms/vkms_drv.h             |   2 -
 include/drm/drm_modeset_helper_vtables.h    |  12 ++
 include/drm/drm_vblank.h                    |  28 ++++
 include/drm/drm_vblank_helper.h             |  56 +++++++
 10 files changed, 424 insertions(+), 81 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_vblank_helper.c
 create mode 100644 include/drm/drm_vblank_helper.h

-- 
2.50.1


