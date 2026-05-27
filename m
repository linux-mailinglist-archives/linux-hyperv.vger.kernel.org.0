Return-Path: <linux-hyperv+bounces-11233-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB4IKSEHF2qn1gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11233-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:00:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71C5E66FC
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 735E6306F883
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0E423178;
	Wed, 27 May 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nXwZ24Zc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OFLFTYQd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nXwZ24Zc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OFLFTYQd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5436374186
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893492; cv=none; b=VYFS6Zd3BykueBnm7O9orNgVubSr1kqalmhbGkDi1x4dgeMZpzkeQDUoaMarKM5YuDM9shvlDUm5CKdvNtJyAxWLk7b6c11AgwYZbnQ6AKH1a2bK4TNZEzb5FpwAHiBg/wctqNjxEH1eMR2U4DjBqm0j8kPpN2JWQ4QJF4MYvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893492; c=relaxed/simple;
	bh=TDJHVS4R1NqIrT42pt0tcxqGBkr7giAGgrRQfaYeCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWP4L6mGZ817X4nGri1UhsFD0ct3jnf8ZgzXDPgfXh+zUNE5bFRrd1qjLzxNzngwZXl2qiaIb+CH58IsICobltMpd/zdqTdAZEtgyv4Kc786uSojmMa1C+7cjSOgEt4IDZw0pWZlstUOwDbvlf0BxpKMN7fcxMNXLQzrGEig4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nXwZ24Zc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OFLFTYQd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nXwZ24Zc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OFLFTYQd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A60ED6AE8B;
	Wed, 27 May 2026 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779893480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMFRjX8LY1JTDZdocnlptTgPAglFO7CqHhbgK5OdqVs=;
	b=nXwZ24ZcPqW2upUUvh//EgBIGKEVwlCEuRF1QyMOoQCoQhhxxHfIXFd7mbzWUKqFfti681
	cXO6/f+o217e89KCEPImt1X3K5qCeJA+2CfQAeCZbvxHGWwe5uIUgdvXS82iBES1Y3xmeQ
	2Z8ApvjU/FwTIAa3kZmTrGuF5i9ZEzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779893480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMFRjX8LY1JTDZdocnlptTgPAglFO7CqHhbgK5OdqVs=;
	b=OFLFTYQdTRDfH1z99d71kZSZ2oCTyCH1/TE5EZZbuviTmUkB6yCWp5+rytOKfz0lNJxMdX
	kR44BbEPYdnNZtAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779893480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMFRjX8LY1JTDZdocnlptTgPAglFO7CqHhbgK5OdqVs=;
	b=nXwZ24ZcPqW2upUUvh//EgBIGKEVwlCEuRF1QyMOoQCoQhhxxHfIXFd7mbzWUKqFfti681
	cXO6/f+o217e89KCEPImt1X3K5qCeJA+2CfQAeCZbvxHGWwe5uIUgdvXS82iBES1Y3xmeQ
	2Z8ApvjU/FwTIAa3kZmTrGuF5i9ZEzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779893480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMFRjX8LY1JTDZdocnlptTgPAglFO7CqHhbgK5OdqVs=;
	b=OFLFTYQdTRDfH1z99d71kZSZ2oCTyCH1/TE5EZZbuviTmUkB6yCWp5+rytOKfz0lNJxMdX
	kR44BbEPYdnNZtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 296EF5A8A8;
	Wed, 27 May 2026 14:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBPkCOgEF2qsegAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 14:51:20 +0000
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
	mhklinux@outlook.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 02/10] drm/atomic-helpers: Evaluate plane damage after atomic_check
Date: Wed, 27 May 2026 16:46:21 +0200
Message-ID: <20260527145113.241595-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527145113.241595-1-tzimmermann@suse.de>
References: <20260527145113.241595-1-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11233-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 1F71C5E66FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Each plane's and CRTC's atomic_check might trigger a full modeset. As
this affects the plane's damage handling, evaluate damage clips after
running the atomic_check helpers.

Examples can be found in a number of drivers, such as ast, gud, ingenic,
mgag200 or vmwgfx, which all set mode_changed in the CRTC state to true.
Ingenic even reevaluates damage information in its plane's atomic_check.
Doing this after the atomic_check helpers ran benefits all drivers.

There's already a damage evaluation before the calls to atomic_check.
With a few fixes to drivers, this can be removed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 51f39edc31ed..4c37299e8ccb 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1065,6 +1065,10 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 		}
 	}
 
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
+		drm_atomic_helper_check_plane_damage(state, new_plane_state);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_planes);
-- 
2.54.0


