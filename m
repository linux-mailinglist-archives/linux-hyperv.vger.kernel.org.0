Return-Path: <linux-hyperv+bounces-1373-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E851822B58
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 11:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC4B1C231C6
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jan 2024 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7490318C21;
	Wed,  3 Jan 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RvAGn8cW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rIqwVG2m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RvAGn8cW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rIqwVG2m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3118EDC;
	Wed,  3 Jan 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3847321FB3;
	Wed,  3 Jan 2024 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704277603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip26D6/xZyFRPOtQBkMkdGmk89Sh8EzMfHAG4F0eATE=;
	b=RvAGn8cWh/TU0KTImyUahi+Opyp2xt7CiYufxLnQdZflRjQOzP4vnSpRBAaxlphxO4Rx8+
	c5pkSP3I83UegVMSjB4C2/JRNRN0SSi9EXJ113mImYrpFe4wbAUa6o6AcJ7slp6BiTzFCN
	nUtDNBCVPCGrWix/tn8+sW+1031S/fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704277603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip26D6/xZyFRPOtQBkMkdGmk89Sh8EzMfHAG4F0eATE=;
	b=rIqwVG2mSK2r7Z+3RwvbsJKt74kI0Ha02bWY+LQdmNYRfdA9FItVTeQa+OKB4UbH3ewYRl
	UCHaAYm3Fyihe5Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704277603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip26D6/xZyFRPOtQBkMkdGmk89Sh8EzMfHAG4F0eATE=;
	b=RvAGn8cWh/TU0KTImyUahi+Opyp2xt7CiYufxLnQdZflRjQOzP4vnSpRBAaxlphxO4Rx8+
	c5pkSP3I83UegVMSjB4C2/JRNRN0SSi9EXJ113mImYrpFe4wbAUa6o6AcJ7slp6BiTzFCN
	nUtDNBCVPCGrWix/tn8+sW+1031S/fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704277603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip26D6/xZyFRPOtQBkMkdGmk89Sh8EzMfHAG4F0eATE=;
	b=rIqwVG2mSK2r7Z+3RwvbsJKt74kI0Ha02bWY+LQdmNYRfdA9FItVTeQa+OKB4UbH3ewYRl
	UCHaAYm3Fyihe5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCD481340C;
	Wed,  3 Jan 2024 10:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GAK7NGI2lWWmfgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Jan 2024 10:26:42 +0000
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
Subject: [PATCH 3/4] firmware/sysfb: Clear screen_info state after consuming it
Date: Wed,  3 Jan 2024 11:15:11 +0100
Message-ID: <20240103102640.31751-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103102640.31751-1-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLw9gjjhh8cousxs3wi4trssza)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com,redhat.com,gmx.de,microsoft.com,kernel.org,ffwll.ch];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[10.82%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

After consuming the global screen_info_state in sysfb_init(), the
created platform device maintains the firmware framebuffer. Clear
screen_info to avoid conflicting access. Subsequent kexec reboots
now ignore the firmware framebuffer.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/sysfb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 82fcfd29bc4d..19706bd2642a 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL_GPL(sysfb_disable);
 
 static __init int sysfb_init(void)
 {
-	struct screen_info *si = &screen_info;
+	const struct screen_info *si = &screen_info;
 	struct simplefb_platform_data mode;
 	const char *name;
 	bool compatible;
@@ -119,6 +119,18 @@ static __init int sysfb_init(void)
 	if (ret)
 		goto err;
 
+	/*
+	 * The firmware framebuffer is now maintained by the created
+	 * device. Disable screen_info after we've consumed it. Prevents
+	 * invalid access during kexec reboots.
+	 *
+	 * TODO: Vgacon still relies on the global screen_info. Make
+	 *       vgacon work with the platform device, so we can clear
+	 *       the screen_info unconditionally.
+	 */
+	if (strcmp(name, "platform-framebuffer"))
+		screen_info.orig_video_isVGA = 0;
+
 	goto unlock_mutex;
 err:
 	platform_device_put(pd);
-- 
2.43.0


