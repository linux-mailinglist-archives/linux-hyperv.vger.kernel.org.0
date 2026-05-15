Return-Path: <linux-hyperv+bounces-10907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIJdCBESB2rgrQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10907-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8254F969
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09EC330DDD3E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0011C3FE363;
	Fri, 15 May 2026 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b7UmgMVB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ub2Rk0CE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b7UmgMVB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ub2Rk0CE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AE46AF06
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846975; cv=none; b=iojc4Jy8LgejRpSvQcduOfYHXEUuWfMwqi84w2zd6zo/pxmjVqaay44VfSGdJCMI5q+xs4VAOzeiI/51/AurZ2oA89eTtOXNJB7jGs5fugyqTPpZ43ivE1wSDrHyiRVMGpZ52SVrIb06U7JqIs2IvFR8yyTM6oi8O/FPAP4STrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846975; c=relaxed/simple;
	bh=CI7ErrHUU6fMHMVh+Ms6Ut/EGY0uqQxW4HphgWonYVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crW2qTTQUU9x3VMTo38wI2t5g9lRqc01eE3lcEWC0iIX9jasxqxrbnQQ5rRz23W+afyd1F4gk2Zgux28PfquncbllCvIyoNkPoUrWWbtEAii4nq4TEkFT2R1LY7VcHis+i+CYXX1gWbhgTKqBbZOMlB7IWOoDs2NjPWfAKNEoRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b7UmgMVB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ub2Rk0CE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b7UmgMVB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ub2Rk0CE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2FF05D8ED;
	Fri, 15 May 2026 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8pSUm8J0v9gfIXRCX3I0dmvyzfzl9Y3YNSekhnH4aI=;
	b=b7UmgMVBTHr8J1HPciOowZ27ySF6NHXKRYhv5aP1o+nB1WYZhJXmUmeslc6wLJDRrnBVrI
	nJBQpXTuGUVdJ+6cO5zE5GvMHIfodcGYPKxzZU7hH7vOG/LHS5ZXeUYWhrQIuwKDOX3a67
	ubMDjtL92tff+3dLGAA0c0roJgBR5sI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8pSUm8J0v9gfIXRCX3I0dmvyzfzl9Y3YNSekhnH4aI=;
	b=Ub2Rk0CEJ5rw69oCheXMq60tjy9r1BIAdAYYjcAMOgWcVssZhsXmBaOx8e3osAjXLosumP
	e8AALsn4UhaXXZAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8pSUm8J0v9gfIXRCX3I0dmvyzfzl9Y3YNSekhnH4aI=;
	b=b7UmgMVBTHr8J1HPciOowZ27ySF6NHXKRYhv5aP1o+nB1WYZhJXmUmeslc6wLJDRrnBVrI
	nJBQpXTuGUVdJ+6cO5zE5GvMHIfodcGYPKxzZU7hH7vOG/LHS5ZXeUYWhrQIuwKDOX3a67
	ubMDjtL92tff+3dLGAA0c0roJgBR5sI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8pSUm8J0v9gfIXRCX3I0dmvyzfzl9Y3YNSekhnH4aI=;
	b=Ub2Rk0CEJ5rw69oCheXMq60tjy9r1BIAdAYYjcAMOgWcVssZhsXmBaOx8e3osAjXLosumP
	e8AALsn4UhaXXZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C60D593A9;
	Fri, 15 May 2026 12:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4DtNGfIMB2rQFwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 15 May 2026 12:09:22 +0000
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
Subject: [PATCH 6/9] drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
Date: Fri, 15 May 2026 13:55:11 +0200
Message-ID: <20260515120916.333614-7-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 85B8254F969
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10907-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Mark the vblank event on hypervdrm as simulated, so that the WAIT_VBLANK
ioctl fails with an error. The ioctl should not be supported because the
output is not synchronized to a display refresh.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 1bbb7de5ab49..24bed31c35e7 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -329,7 +329,7 @@ int hyperv_mode_config_init(struct hyperv_drm_device *hv)
 		return ret;
 	}
 
-	ret = drm_vblank_init(dev, 1);
+	ret = drmm_vblank_init(dev, 1, DRM_VBLANK_FLAG_SIMULATED);
 	if (ret)
 		return ret;
 
-- 
2.54.0


