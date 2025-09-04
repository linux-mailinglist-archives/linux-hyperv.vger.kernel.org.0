Return-Path: <linux-hyperv+bounces-6726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE64B43FD6
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 17:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317B11BC2956
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810FB1339B1;
	Thu,  4 Sep 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z0l7YGVo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S5RON2O7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7BiomZ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hDRKjKfZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3C1EEA54
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Sep 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998066; cv=none; b=o9SAq+SWYfRIYGlWsd1pjhx6mRk97aUCkTZNcYImqE09UDPDWzrYlyg5Ac9vUz4oxjTewhmmMPvNURnBNv4kIpLqb2JUzpIksNu5oZrVNbnlzaHPwU4mCnFYWQE9bD2gqh7D69/+m8uZSGR5KCRbq78UazYoQPddjvDZaYpM8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998066; c=relaxed/simple;
	bh=45y+iLj7zvfbQj85uZXC+766pv917bKPtbCkrPNXrQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nsj5bsKdb7RQ4T3FEsDYu3vWoJJVlPFHYn6Vjm/pa1gG54HJdG7w06z1PWNPQsjC1HkIs+fsyMUpDKDN6g3898tNvKOZzbW6YayI0t44Ml9QCu8okoHFLiStd1d37/tdVg5PV5g5763HRPc0gzuRyq8KG3H8mY0kye73zWJ8cYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z0l7YGVo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S5RON2O7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7BiomZ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hDRKjKfZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D457137457;
	Thu,  4 Sep 2025 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756998058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVOyssyqCjzuKmMjy5Hn5aXW20u0ho/52xA+ZbAwX/g=;
	b=z0l7YGVo9Al/ZCc9Y2YbCjKxyD592gnVcQ4FEy1zRx/NFWn7+/yFFMR4ICX+8hsnN177pk
	yUuFxMzGLFRv8sd1sRqntQFfW+ykPs9u9aO9Ju9tWyxlNu0pq6uz85apBoQE1BIal3ICcJ
	9F/z+mpa3tjFMxYFS9W4o1EOsyBl+rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756998058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVOyssyqCjzuKmMjy5Hn5aXW20u0ho/52xA+ZbAwX/g=;
	b=S5RON2O7evW8NfKQegErfUfszDSSkRl+kWHokDKSSk7QKfVhDXjsd7uyXUykYWEq7pSbvm
	35CxIpL6wzMJGqCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756998052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVOyssyqCjzuKmMjy5Hn5aXW20u0ho/52xA+ZbAwX/g=;
	b=W7BiomZ0CT+eXaDokaHU5/mVhsvKEGZJCX/4ki4RDkaA15sJ7xqcNxVImqoonEozOAScda
	1Baxy7/7nBWWdYKUx+Kct6S8/59uBy6faEPJHbV5mB3Z8g5+M/YP9yre1wdbLByFZUbQtY
	wWa2Uxiz5HhlDKjSjZrwl708VKxCNnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756998052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gVOyssyqCjzuKmMjy5Hn5aXW20u0ho/52xA+ZbAwX/g=;
	b=hDRKjKfZWhsCDDIJQLA+0CxSzVWazy8CrPD4fzQ0numUjaB5vgMQvGEnOlcydbUI0yqiBM
	Dy6qMpGfCfZ2C4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 783E713675;
	Thu,  4 Sep 2025 15:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h57vG6SpuWgcBAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 04 Sep 2025 15:00:52 +0000
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
Subject: [PATCH v3 0/4] drm: Add vblank timers for devices without interrupts
Date: Thu,  4 Sep 2025 16:56:21 +0200
Message-ID: <20250904145806.430568-1-tzimmermann@suse.de>
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kde.org:url,suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,outlook.com,ffwll.ch,linux.intel.com,redhat.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLgb6padn6wcu17bxtda1k7h6p)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

v3:
- fix deadlock (Ville, Lyude)
v2:
- rework interfaces

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
 drivers/gpu/drm/drm_vblank.c                | 161 +++++++++++++++++-
 drivers/gpu/drm/drm_vblank_helper.c         | 176 ++++++++++++++++++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  11 ++
 drivers/gpu/drm/vkms/vkms_crtc.c            |  83 +--------
 drivers/gpu/drm/vkms/vkms_drv.h             |   2 -
 include/drm/drm_modeset_helper_vtables.h    |  12 ++
 include/drm/drm_vblank.h                    |  32 ++++
 include/drm/drm_vblank_helper.h             |  56 +++++++
 10 files changed, 467 insertions(+), 81 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_vblank_helper.c
 create mode 100644 include/drm/drm_vblank_helper.h

-- 
2.50.1


