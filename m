Return-Path: <linux-hyperv+bounces-11226-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OMqL2j1FmrUywcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11226-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:45:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF55E544F
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864443084AC2
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBD403150;
	Wed, 27 May 2026 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZuOGIY27";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a0FY+x5j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZuOGIY27";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a0FY+x5j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C95421898
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889197; cv=none; b=bDFcyrGlN1lU1aWzpuMqHWK7yGNWOUb/L7bISyLGnmxF3l6mgH8//5weMZv03NGC/k4viba2u9SuphahmrSSlqXXAvq4jk8iE8/lLr51ZZ/Yl1mJwXh9iywJglkq/kR4GxbeZYkx1BvbdCgSl5Ivn70mGnPk4xMWdn+WPeb/s2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889197; c=relaxed/simple;
	bh=kJ9KSuZ2jDdAiuT+D6uahLzHbzwO1HHxXQrB0F8zBDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpFtKBRyRhvoKybvqxt26ScZNpE5zE+adoAO9r6tO984gaDI1/TG8iiJrdNh6LBb/rktdbFpMWklPcTFEoTU2qv5dFSyTzVdMSax037s8/CFFEHmVQhuH0Nao1hgekSrTnxltEbVaEjSCbcuhf2VdOZeZcYmt/GOFP/orRLfHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZuOGIY27; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a0FY+x5j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZuOGIY27; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a0FY+x5j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C56916787A;
	Wed, 27 May 2026 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYQL44Q722k2hIk897RtDzxRSZ9J5NycjtA+xblyFt0=;
	b=ZuOGIY27+zd+IbOlRLULJ6va8B/GSdM2fFcGwN4Tf4hY1eq6hs0RJjb6i8CXiOsaPX06lX
	Bzlwy7SLQjyWgkgw4SQfkkoYTqSXUvHScWgXi/gqSE//O3ktHFKq0G9gwAYlRspU4KLM70
	z6iJvXv1cWQ3KjkUf1lnpLK2udlHuno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYQL44Q722k2hIk897RtDzxRSZ9J5NycjtA+xblyFt0=;
	b=a0FY+x5jILdC4cvF66CGmneNv3I3u6CqY112DaQKUgmky7v9KH3Ccbj7cFYnch7wwO2MZ+
	ZlL27qf9hKPdPqBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779889167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYQL44Q722k2hIk897RtDzxRSZ9J5NycjtA+xblyFt0=;
	b=ZuOGIY27+zd+IbOlRLULJ6va8B/GSdM2fFcGwN4Tf4hY1eq6hs0RJjb6i8CXiOsaPX06lX
	Bzlwy7SLQjyWgkgw4SQfkkoYTqSXUvHScWgXi/gqSE//O3ktHFKq0G9gwAYlRspU4KLM70
	z6iJvXv1cWQ3KjkUf1lnpLK2udlHuno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779889167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYQL44Q722k2hIk897RtDzxRSZ9J5NycjtA+xblyFt0=;
	b=a0FY+x5jILdC4cvF66CGmneNv3I3u6CqY112DaQKUgmky7v9KH3Ccbj7cFYnch7wwO2MZ+
	ZlL27qf9hKPdPqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 641535A861;
	Wed, 27 May 2026 13:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wN8HFw/0FmrpMQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 13:39:27 +0000
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
Subject: [PATCH v2 9/9] drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
Date: Wed, 27 May 2026 15:32:50 +0200
Message-ID: <20260527133917.207150-10-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11226-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org,outlook.com];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 51BF55E544F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mark the vblank event on vkms as simulated, so that the WAIT_VBLANK
ioctl fails with an error. The ioctl should not be supported because
the output is not synchronized to a display refresh.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..c4cfa1e5ab01 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -192,8 +192,8 @@ int vkms_create(struct vkms_config *config)
 		goto out_devres;
 	}
 
-	ret = drm_vblank_init(&vkms_device->drm,
-			      vkms_config_get_num_crtcs(config));
+	ret = drmm_vblank_init(&vkms_device->drm, vkms_config_get_num_crtcs(config),
+			       DRM_VBLANK_FLAG_SIMULATED);
 	if (ret) {
 		DRM_ERROR("Failed to vblank\n");
 		goto out_devres;
-- 
2.54.0


