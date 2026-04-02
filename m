Return-Path: <linux-hyperv+bounces-9896-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MChVL+I4zmmAmAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9896-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:37:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C438707D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 113FE30B69B5
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D40338F93C;
	Thu,  2 Apr 2026 09:23:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F003890FA
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Apr 2026 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121814; cv=none; b=vEvINesQNR8Y2i7UfGgcgMu6IVd8H9VszntChp2LAFk0WsqB0nEMrv+MucUJf+uzgpKZCq1YlfiBcN4qZXfGdge0ycNmqYs/WoU7r5CDEMwEIOuvE7mPEvY067vkNtBpWegCcfco4FXhfuQtwXOBWFq2viuwSP20mkmws0CBZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121814; c=relaxed/simple;
	bh=3/fmNuSAg0tNAaUlz1dcAL+EW3NxRusvodSTFauSPcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVc0PYvVTvPHn9iT26LCkLto9rgXtBnzPjxKWq/x0oGGqpshOZPZYxlcCB3NDUKdIS+UV7x7h0Tm8DQ6HtMBvuZW4U9PM+qbhAIO5YQFQNyHeV2g5fovuWBkuH5gCFon+zcn7I5/mD35I1Oa9uMVhe0JcV4VTQqM5254BHGCbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5654A4D321;
	Thu,  2 Apr 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C21D64A0B0;
	Thu,  2 Apr 2026 09:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mNc0LoE1zmlVYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	arnd@arndb.de,
	ardb@kernel.org,
	ilias.apalodimas@linaro.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	deller@gmx.de
Cc: linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/8] firmware: sysfb: Avoid forward-declaring sysfb_parent_dev()
Date: Thu,  2 Apr 2026 11:09:20 +0200
Message-ID: <20260402092305.208728-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402092305.208728-1-tzimmermann@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9896-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D51C438707D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move sysfb_parent_dev() to the top of the source file to avoid
the extra declaration. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/sysfb_primary.c | 36 +++++++++++++++-----------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/sysfb_primary.c b/drivers/firmware/sysfb_primary.c
index 298f87a43a7e..a7f8cede60ad 100644
--- a/drivers/firmware/sysfb_primary.c
+++ b/drivers/firmware/sysfb_primary.c
@@ -42,7 +42,23 @@ static struct platform_device *pd;
 static DEFINE_MUTEX(disable_lock);
 static bool disabled;
 
-static struct device *sysfb_parent_dev(const struct screen_info *si);
+static struct device *sysfb_parent_dev(const struct screen_info *si)
+{
+	struct pci_dev *pdev;
+
+	pdev = screen_info_pci_dev(si);
+	if (IS_ERR(pdev)) {
+		return ERR_CAST(pdev);
+	} else if (pdev) {
+		if (!sysfb_pci_dev_is_enabled(pdev)) {
+			pci_dev_put(pdev);
+			return ERR_PTR(-ENODEV);
+		}
+		return &pdev->dev;
+	}
+
+	return NULL;
+}
 
 static bool sysfb_unregister(void)
 {
@@ -101,24 +117,6 @@ bool sysfb_handles_screen_info(void)
 }
 EXPORT_SYMBOL_GPL(sysfb_handles_screen_info);
 
-static struct device *sysfb_parent_dev(const struct screen_info *si)
-{
-	struct pci_dev *pdev;
-
-	pdev = screen_info_pci_dev(si);
-	if (IS_ERR(pdev)) {
-		return ERR_CAST(pdev);
-	} else if (pdev) {
-		if (!sysfb_pci_dev_is_enabled(pdev)) {
-			pci_dev_put(pdev);
-			return ERR_PTR(-ENODEV);
-		}
-		return &pdev->dev;
-	}
-
-	return NULL;
-}
-
 static __init int sysfb_init(void)
 {
 	struct sysfb_display_info *dpy = &sysfb_primary_display;
-- 
2.53.0


