Return-Path: <linux-hyperv+bounces-8870-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MRdCFWylGlbGgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8870-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 19:24:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F914F110
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 19:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8CDC3012D0E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD09372B21;
	Tue, 17 Feb 2026 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="BDkZPA5e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25F36E497;
	Tue, 17 Feb 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352658; cv=pass; b=HHWjvXscHPnPHgjSh20eVpLndF830AsGYdrPhNur3KylE6nuXKYtZ0N1EklghO+vkVbHtefgbKj39bQA8DLudjv4yZS833vw6M3E/E6wcNLEJHYt+VWqV3xyP45HeG+uqYjK+cJNTuac/37Tq1XnV+x35PbzOSZiNIhtzDFXrhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352658; c=relaxed/simple;
	bh=pKCsoNOv/f/NOPnO2Qgo0722N1Z6pyM7pQbWeWRVcFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRdVfB7uuVPZ4XRfrHBHkpoDV3F800hUw7w/THOZfl8j15CIaERKQRKphq8llZST63GdtgpRS5ogh8Hs6tPN76211xH5QIGcFS5/KwQzFqlkq10wI6Addo4dpP8cVLjAyLh6CHQYD07S89FIr8s1gnKI+DxZVH7gZFOCoowky3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=BDkZPA5e; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1771352626; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=elYPn0Vr4RsE0bGjcitHsOdQN16Q+v3K63PxWAitrUR9vjmro/DjYCWRX/gB4z+NPBLHHiV9jp09oPT4VyA78HsblZQi9nfEt3qmajM8F05WnSNpq2QhL8LWYZrUNE5/3JwrY4eTwXCmJ+/NWwqnki+Wh4JxJi+5ZB3o2ZUFLKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771352626; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Reply-To:References:Subject:Subject:To:To:Message-Id; 
	bh=bCbocMqgUYFnJ+oYDgGHoTYrgPMBZlnF95h5ckvogTc=; 
	b=Xzwl2HRyIlgivVwG9d5uR7Zln+XtbHKKYYgCthhSZ1Z4ltHiglA6acM7mP9i44yLV8vMROYf0MwESSL4KiCIg0A8L/Yqb1Wj/ewdBmq4TRcAltPZ4dCY6FxxkFm59JEtwnIuXVClKEUV7aF8wtkiB3L5vpcZfrgFkw4dUA/rPxg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771352626;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=bCbocMqgUYFnJ+oYDgGHoTYrgPMBZlnF95h5ckvogTc=;
	b=BDkZPA5eqeBJQZ9hfSejXzc4Ssff0BgcpM4EteApGsJ49atosvnHoFi6HQUqDj2m
	mN/mFVQRUzGRo7befhRhY3VzjdqiGVMwU+ZaGyUunlmbnQrQWKN81IhWPFnV/bm7MbW
	aMVX1BhP2CepPOaizmY8Z5J19MubOg1aNy+ZwfEI=
Received: by mx.zohomail.com with SMTPS id 1771352623819939.9981858150902;
	Tue, 17 Feb 2026 10:23:43 -0800 (PST)
From: Michael Kelley <mhklkml@zohomail.com>
To: drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	ryasuoka@redhat.com,
	jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/hyperv: During panic do VMBus unload after frame buffer is flushed
Date: Tue, 17 Feb 2026 10:23:35 -0800
Message-Id: <20260217182335.265585-2-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260217182335.265585-1-mhklkml@zohomail.com>
References: <20260217182335.265585-1-mhklkml@zohomail.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227b2401215a7bf2b8306f9898d000025434cf800c0383b4465d5f9756fcc758ae3994a376c0510ac:zu08011227b23318a12f7d079f4eda8acf000022701c04a2c86e6073d06bac3e2f27ba60d6a0fac42dd94141:rf08011226056746b3e97faaae845a475700004e492f8612d1d2d6af5354727a3ac0c9b7a183b60a6beecc:ZohoMail
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8870-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:replyto,outlook.com:email,zohomail.com:mid,zohomail.com:dkim]
X-Rspamd-Queue-Id: 9C1F914F110
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

In a VM, Linux panic information (reason for the panic, stack trace,
etc.) may be written to a serial console and/or a virtual frame buffer
for a graphics console. The latter may need to be flushed back to the
host hypervisor for display.

The current Hyper-V DRM driver for the frame buffer does the flushing
*after* the VMBus connection has been unloaded, such that panic messages
are not displayed on the graphics console. A user with a Hyper-V graphics
console is left with just a hung empty screen after a panic. The enhanced
control that DRM provides over the panic display in the graphics console
is similarly non-functional.

Commit 3671f3777758 ("drm/hyperv: Add support for drm_panic") added
the Hyper-V DRM driver support to flush the virtual frame buffer. It
provided necessary functionality but did not handle the sequencing
problem with VMBus unload.

Fix the full problem by using VMBus functions to suppress the VMBus
unload that is normally done by the VMBus driver in the panic path. Then
after the frame buffer has been flushed, do the VMBus unload so that a
kdump kernel can start cleanly. As expected, CONFIG_DRM_PANIC must be
selected for these changes to have effect. As a side benefit, the
enhanced features of the DRM panic path are also functional.

Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2: Removed test of CONFIG_PRINTK in deciding whether
   to have VMBus skip the unload. A separate patch by Jocelyn Falempe
   incorporates the CONFIG_PRINTK dependency into CONFIG_DRM_PANIC.

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  5 +++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 15 ++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 06b5d96e6eaf..b6bf6412ae34 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -150,6 +150,10 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 		goto err_free_mmio;
 	}
 
+	/* If DRM panic path is stubbed out VMBus code must do the unload */
+	if (IS_ENABLED(CONFIG_DRM_PANIC))
+		vmbus_set_skip_unload(true);
+
 	drm_client_setup(dev, NULL);
 
 	return 0;
@@ -169,6 +173,7 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
 	struct drm_device *dev = hv_get_drvdata(hdev);
 	struct hyperv_drm_device *hv = to_hv(dev);
 
+	vmbus_set_skip_unload(false);
 	drm_dev_unplug(dev);
 	drm_atomic_helper_shutdown(dev);
 	vmbus_close(hdev->channel);
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 7978f8c8108c..d48ca6c23b7c 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -212,15 +212,16 @@ static void hyperv_plane_panic_flush(struct drm_plane *plane)
 	struct hyperv_drm_device *hv = to_hv(plane->dev);
 	struct drm_rect rect;
 
-	if (!plane->state || !plane->state->fb)
-		return;
+	if (plane->state && plane->state->fb) {
+		rect.x1 = 0;
+		rect.y1 = 0;
+		rect.x2 = plane->state->fb->width;
+		rect.y2 = plane->state->fb->height;
 
-	rect.x1 = 0;
-	rect.y1 = 0;
-	rect.x2 = plane->state->fb->width;
-	rect.y2 = plane->state->fb->height;
+		hyperv_update_dirt(hv->hdev, &rect);
+	}
 
-	hyperv_update_dirt(hv->hdev, &rect);
+	vmbus_initiate_unload(true);
 }
 
 static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
-- 
2.25.1


