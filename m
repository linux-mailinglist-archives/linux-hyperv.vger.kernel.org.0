Return-Path: <linux-hyperv+bounces-10904-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHENHCASB2rgrQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10904-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C3B54F98C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0F413096A16
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA752DB7B8;
	Fri, 15 May 2026 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMDhHC+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/PkUx1qH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMDhHC+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/PkUx1qH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67D45BD57
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846969; cv=none; b=Pe05OtO+WNmHUAngDzWFHhguKzsyKcF5TuagtGnQY5oUGAq3Ql52Lu06UP44F+OcPv1S5ExjL/v59Fiz5MoxmaVp67xwZ4UlkSlndOQ5rKHLeI1H66qXFSSEc1TqV5HB2FOcyNyy3CNA2AG3cKY8gdErNT7fE6Dq5G+ttku1pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846969; c=relaxed/simple;
	bh=MMqIITohrF63clYkWEBwbJkovubjnu8Wx6YY2pswrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq4zKY6rVaNj0073rS6ngIeYxGuxy600ru+w+1M7EssbH5GTjejyM0NyI4LzFUQMLzsok1xEDTjox+bdX8GOlF4qwPDBuj1PWfVB1444tNpEg2ICvmnQ5fDivDhqaEbUWCTMhRnjha50nH2zSnjowwfpKVVeTKCcu6XqEorX76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tMDhHC+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/PkUx1qH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tMDhHC+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/PkUx1qH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34F3D5EC2F;
	Fri, 15 May 2026 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
	b=tMDhHC+Px+7xZudl9MIGD6453Uz+9h+yujT/CJU0S8G91N42SbXuNF9dt9ZimCrKU87FRc
	rZDAELJoDKNxgUX0myB567JxAhTtlEftGHcbdz/fSXBHiUtMG2CX/MKS5aJn4JQ8AbZRmX
	axE94ANuxdSPTBbXHJwHClch+xjXpJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
	b=/PkUx1qHQohCyNBYWmgAwrPANSdmc+9pKHeul5qJXkcrQosaxzu0e/LnQ+C9cYTt21zZH3
	nJvskb6AmumpDVCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
	b=tMDhHC+Px+7xZudl9MIGD6453Uz+9h+yujT/CJU0S8G91N42SbXuNF9dt9ZimCrKU87FRc
	rZDAELJoDKNxgUX0myB567JxAhTtlEftGHcbdz/fSXBHiUtMG2CX/MKS5aJn4JQ8AbZRmX
	axE94ANuxdSPTBbXHJwHClch+xjXpJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
	b=/PkUx1qHQohCyNBYWmgAwrPANSdmc+9pKHeul5qJXkcrQosaxzu0e/LnQ+C9cYTt21zZH3
	nJvskb6AmumpDVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D30AA593A9;
	Fri, 15 May 2026 12:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qKhUMvAMB2rQFwAAD6G6ig
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
Subject: [PATCH 2/9] drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
Date: Fri, 15 May 2026 13:55:07 +0200
Message-ID: <20260515120916.333614-3-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: E2C3B54F98C
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
	TAGGED_FROM(0.00)[bounces-10904-lists,linux-hyperv=lfdr.de];
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

Suggested-by: Simona Vetter <simona@ffwll.ch>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 3 +++
 include/drm/drm_vblank.h     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 21ca91b4c014..92b699a4e8be 100644
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


