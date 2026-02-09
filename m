Return-Path: <linux-hyperv+bounces-8769-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAoVIZ6GiWkn+gQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8769-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Feb 2026 08:02:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51FE10C4D4
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Feb 2026 08:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69EC530071F8
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Feb 2026 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A922FF16F;
	Mon,  9 Feb 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKLkCP04"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB002FD66D
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Feb 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620548; cv=none; b=mcJSWXgMYOR4heFVxADIXetxDn+F7qAp15eIETgpq+Y+vioXNVIDIsF1ECdZi2u9DRrilG2DH28mNbBQhEEXFQYi/nTZ0orfUxzhi2LzSnFMXWyxNNpIFB+RlzAtZAGdsYEhDNDtj9+IAytCwmNPpxAXI/y82pIDIFQa3jub7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620548; c=relaxed/simple;
	bh=0U9KcwIjyOYkXhdi8jwJRDF3PFzQKfnn0/XIDK7rvfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkOJmWQceBGubILeaN+lww465TMRD4emgIW1O+ZdxwW3DozUsb2RQem4Azw/+CXmBCHU5hifu8bTdx18qJLLf/4fxUDr+kIMd4v9JmrjlRlkmUQ+iY5PfW+HN6iGm4oNK3UgU2B+c1K7Itb+2x2Ey143myU/SS+hlrzHMvLAxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKLkCP04; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1270adc5121so2302914c88.0
        for <linux-hyperv@vger.kernel.org>; Sun, 08 Feb 2026 23:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770620547; x=1771225347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XaEjjnb5CXUgt55Cq6lrOTPEGYspEf0Y+Ywm9+lE9sY=;
        b=SKLkCP043KM+9MXaSMpbJWF0og+fGMysAIL87EH7UXvqoaCqGOL2uGTxvH0j26oQJN
         CbSdZK8e+uPwbBWAA9ffeoxAXdZzvdzozuJAkXX1TihiGQzarDCyODDUZE5HVgC7QaLm
         Uhh3tsff7oC9K8FTndCZSvG+ZIYJcZq4YSJztLIIGzMv3m8OBRDOjr35IqwTbdVebY4h
         gg0xKo8hdglTogo8BztUPvQoSH/LxjeksNhLNH3iBoEXQOxFbsHQgNmbDxsjVlycQWUd
         mrEy4K+/toq+ODe/h6nUX103LlGx/vpAdw/BSoTBe8BZJOpcBb76ssEyryKzNciADmKc
         8x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770620547; x=1771225347;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaEjjnb5CXUgt55Cq6lrOTPEGYspEf0Y+Ywm9+lE9sY=;
        b=orru+WXHDGf+WxFUZtuVw/iR+MNOjtnNjKd7vWBlDDXNfTSk36m/flzAmiGB1VGAJS
         2jFZhqKW99ap5pHOGBQ15pLXLYnXOuzlnypAkT8S5vw7VZ7UPxbTpotsu9PkRoefvqtX
         bFNT51QlkvGo398cqLSnsyYCvgdNrJ5KAL+40GJaNm5wJ2fECv5BgPcXM08TJSh+SIzG
         hZTs3cHWG4Gkl1KdB3SB8RpZN67bo8cP2l3qJUSb8mRVWH0gaEbUsJVN2kybqWUUqJTK
         x1KHBfFjslkZ1vhyNUDdc3wb/F0A3loe5n/0K9UJ4PSO0P9k5YMC6TKepei6l6VWMp3P
         3PPw==
X-Forwarded-Encrypted: i=1; AJvYcCWAz3BGTyUqQE56frChEUoP5u/MY13yr20Uiiey+hbJpnwgqWqSFGgXTrM5z81mxcAKKE7bzPfGb3hJHGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmXYud6OZesnHEUFUy+PX0CO7YhRBzoVa88kQ6hsCKifu0lfr
	U7H4rcO/4LKwNnr3pYK1+wzur5c/oDRq3nuzIiHhF77T+W/HvoH7wdKu
X-Gm-Gg: AZuq6aIXHWre9EJuIUKLKpqcKjeRZBCpUWNeOTIt56OmZJ/lNAMEz9ExYJlNM2TG08j
	E24ZIt96bmk/bxrK1k5Ab6JPLzw+4YiYV9uIDEJwlWQuRMLDJNtqphv1yWyKgzRmOZaYFX5XfyR
	ItJFXS4ubARMszfiuPZQ+8xu7yb7Wo9GoQMYw6bH4Y2kAMCz5j/64cpgpQE1YiJ702g7/PcRKbd
	2Uo7RhLkT58BP5IUMznZ8Q33XJyJg80ySVo44z7RpoTZXKDYe8p1Pgz5PNEKtnH/uF0QZiRMO+c
	hA6ymw0ijQYlCzM6FOE8qnRiERMZCCzYdkAKnHey1ZpwXDBHw95RqFP7dcHi/N1StsFi/QDpLJq
	tqNDNiBJhyLQv+wu6UcOSb3JKgUbFWm5flLdOD21rKujz23seqRY5u6lrznNb5VwngbsgH146oQ
	Ui610NSaQfu4LOmem+nOyBUls1QtKl1Q==
X-Received: by 2002:a05:7022:6293:b0:11a:335d:80d2 with SMTP id a92af1059eb24-1270405aa57mr5370472c88.35.1770620547355;
        Sun, 08 Feb 2026 23:02:27 -0800 (PST)
Received: from mhkubun.search.charter.net ([66.91.163.55])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12706faa047sm6966305c88.14.2026.02.08.23.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 23:02:27 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
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
Subject: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame buffer is flushed
Date: Sun,  8 Feb 2026 23:02:01 -0800
Message-Id: <20260209070201.1492-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260209070201.1492-1-mhklinux@outlook.com>
References: <20260209070201.1492-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM_DOM(3.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8769-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhkelley58@gmail.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:replyto,outlook.com:email,outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D51FE10C4D4
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
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 15 ++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 06b5d96e6eaf..79e51643be67 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -150,6 +150,9 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 		goto err_free_mmio;
 	}
 
+	/* If DRM panic path is stubbed out VMBus code must do the unload */
+	if (IS_ENABLED(CONFIG_DRM_PANIC) && IS_ENABLED(CONFIG_PRINTK))
+		vmbus_set_skip_unload(true);
 	drm_client_setup(dev, NULL);
 
 	return 0;
@@ -169,6 +172,7 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
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


