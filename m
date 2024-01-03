Return-Path: <linux-hyperv+bounces-1370-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE31822B52
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB9B1F229C5
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838F18B0B;
	Wed,  3 Jan 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HtU/LYl/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gif3NOEV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HtU/LYl/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gif3NOEV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695918ED9;
	Wed,  3 Jan 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2AFC621CE4;
	Wed,  3 Jan 2024 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704277602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=abc6UaxFIPj+xDBAAYtizVyMNL31WYzON1HiYHlhgYw=;
	b=HtU/LYl/ChOnzFQqbwrYRYELAX0Ik+t55F7j6Wr67fPTV3u61BkfcPkdYjw+RbhxfpFsqq
	g+BRrbKmMa8xqtnWD5e9xfGRPcXfnHOQg7zTCBqpbvVdMuyQ7S4cKALDA7ux9mqOmYuBGJ
	6AM3XD6acRpgKqelRHjspwtAE3xQvDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704277602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=abc6UaxFIPj+xDBAAYtizVyMNL31WYzON1HiYHlhgYw=;
	b=Gif3NOEViHGIs3VobpDcfVsmyzB+o2QJvT/zyR9yW5F5bYTdie0tBHsGd4PEemCz7Bhd1Y
	VlX4KhJzvVWUeFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704277602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=abc6UaxFIPj+xDBAAYtizVyMNL31WYzON1HiYHlhgYw=;
	b=HtU/LYl/ChOnzFQqbwrYRYELAX0Ik+t55F7j6Wr67fPTV3u61BkfcPkdYjw+RbhxfpFsqq
	g+BRrbKmMa8xqtnWD5e9xfGRPcXfnHOQg7zTCBqpbvVdMuyQ7S4cKALDA7ux9mqOmYuBGJ
	6AM3XD6acRpgKqelRHjspwtAE3xQvDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704277602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=abc6UaxFIPj+xDBAAYtizVyMNL31WYzON1HiYHlhgYw=;
	b=Gif3NOEViHGIs3VobpDcfVsmyzB+o2QJvT/zyR9yW5F5bYTdie0tBHsGd4PEemCz7Bhd1Y
	VlX4KhJzvVWUeFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBD491340C;
	Wed,  3 Jan 2024 10:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2y2GMGE2lWWmfgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Jan 2024 10:26:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: drawat.floss@gmail.com,
	javierm@redhat.com,
	deller@gmx.de,
	decui@microsoft.com,
	wei.liu@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] hyperv, sysfb: Do not use screen_info in drivers
Date: Wed,  3 Jan 2024 11:15:08 +0100
Message-ID: <20240103102640.31751-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *****
X-Spam-Score: 5.20
X-Spamd-Result: default: False [5.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[30.08%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com,redhat.com,gmx.de,microsoft.com,kernel.org,ffwll.ch];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

The global screen_info state is only meant for architecture and
firmware code. Replace its use in hyperv graphics drivers with the
correct aperture helpers.

Patches 1 and 2 update hyperv-drm and hyperv-fb to use the correct
aperture helpers instead of screen_info for removing existing firmware
framebuffers.

Hyperv-fb also modifies screen_info for better use with kexec. While
that update makes sense, it's not supposed to be done by the driver.
Patch 3 adds similar code to sysfb and patch 4 removes the code from
the driver.

An intented side effect of this patchset is that all systems now
benefit from better kexec support. After rebooting with kexec, the
kernel operated on stale settings on screen_info. Patch 3 fixes this
and the kexec kernel will use screen_info in any meaningful way.

Thomas Zimmermann (4):
  drm/hyperv: Remove firmware framebuffers with aperture helper
  fbdev/hyperv_fb: Remove firmware framebuffers with aperture helpers
  firmware/sysfb: Clear screen_info state after consuming it
  fbdev/hyperv_fb: Do not clear global screen_info

 drivers/firmware/sysfb.c                | 14 +++++++++++++-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c |  8 ++------
 drivers/video/fbdev/hyperv_fb.c         | 20 +++++++-------------
 3 files changed, 22 insertions(+), 20 deletions(-)


base-commit: 25232eb8a9ac7fa0dac7e846a4bf7fba2b6db39a
-- 
2.43.0


