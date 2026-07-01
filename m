Return-Path: <linux-hyperv+bounces-11725-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WPBSGGpJRWph+AoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11725-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:07:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 210726F02A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:07:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=Ve3RFksn;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11725-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11725-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9B41308E0CA
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAB388886;
	Wed,  1 Jul 2026 17:05:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2238C426
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 17:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925545; cv=none; b=B8IwRXUKUMv5QTu9Hwl3E54lmLuGf494P3gXoUcsmns45g7OWOuZYRDI4daD2cT84vemcR4rIIRu2b4IFbNqgIV6kwY+BsOyq4bdaoTFYdGNoQ64KEvcNW7U62jqKvNRCEb3WdWxhFMejpcQOhB6MuY2V975D241iAVfZy58oMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925545; c=relaxed/simple;
	bh=0q1aVpO7t7+n6WZEaQyJdycCY7xEiMVwH6qz19u0bq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUBnzX+u2wrTIM5AGVgojxktuQSLcArLqR2ZoUJZgNkYtC2wayykobta6MGT5Sikt0UHNuzv1qI3OUsALpHsssoTsgXt/+Ao2iEvUoydeAV09a3MZZ9rIBL1qpuVLaTBgBX1wCjwmGlj1nsbNtfGgo0skaT/iHL/eLJOfQzSDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ve3RFksn; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c486f012so623695e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782925543; x=1783530343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wswMVKIXyDkyPIt8Lte8A6zKftNJ6+VttcmMWxl5NiI=;
        b=Ve3RFksnG64cHS2lkkNzOdsNxT55BSHuY6YzXYpPEuLC7fdIyPFeeX9clZKaDwPK9O
         Q8A8R2K9lu/EvJenjx8DDxHSnpQzJBvzPf67nBsc/qdKk7J1qo3k5SxCYkGQr2k8lgka
         o/04JhK4nupceBJQhwWUPByAgOgsXugDnxQwXzIKOz2orl75c/Tj5Pu7lfaxWLKErxF6
         +KJT+i6Lc9/u5ZFT5q6vYK9UP0wgxKqAxZoHmW9g5ChZ8SMQrxNITYm8zA6isGo73tj9
         sG63+nUS7mEK/0mHSPseE1bOnBi+vLH73awVjirFW55b+DNLhgAoJ/pD6x9dwCbCa41H
         B6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925543; x=1783530343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wswMVKIXyDkyPIt8Lte8A6zKftNJ6+VttcmMWxl5NiI=;
        b=iud7hAlRFWRsnuwsgeZ9D3YyEYSoL1ZAlm2cBnKqI9AQi2URHIuWAziM+XSycOo+qE
         a2PVUws+xW1bZXN9N85LRAUtzkFBLUeDFAZCf/X+IsQS7jpgYKqczyqrjcn4xxjiUg6y
         PqRs0NeJMwSB8cl0Sxxd9Zf9yXsX0bHlphw0WonOQ9Qa1IdycJ6vYzHZAiLG13Tdd2eM
         5fBj1i3B9t5TzP+SBSN+I0iO5wbv6E7jWYyABua7eL8TBRrVzwsEE8v0vUnPUr1SptJ9
         hhr9jWwSeTUJvgeOPLb+vAAMtZ9hECnfeM95csYBvt+S0OQxMnE3tckoay4dueGrxijq
         cwBA==
X-Gm-Message-State: AOJu0YzYzNwssxN1M66TsjmBz4Ty2lIlJimqUl+wFVUl9sNLRc06j0+I
	PoRqV1MR/B97vhC+NUVuo5ZmmuRYfi2J51GbljwmkRX5V3Q3uGc1hFH0hjs4TZCDcMk=
X-Gm-Gg: AfdE7cl/SBMl/DbQ8VE3lEZoEOagSwlcOgHRHwfwUPk5rFHOlC8a5ghtws8Cw2SGW65
	VGK+lpHYEeoey3+9YaRzMC+2cp+FJY9s2UpIoLT6ZVaCIQunwVxp2VcPhgYawwvRO+b2JhN2c4j
	msi7hU//r2wBhalC7SekozHU+jQVa3N3dsB7804Tcito2fYpa7kZFX+F6xhw7g5UD1O2VW7VgK+
	0zr9q6zV0LAA0/388h1DNVI8FHn+dzyO9rf7lskd+OZhehMoFDQ1ve01EM4wB7b34lEUQTXQEvb
	IfqLuYLwVsFI/W+6aITZuyzVBiTtlDk+KEprfFDIg6qAC8Q1tE2RK8nfCTLlAOkEW4O/vX9je2V
	3Eg1ba/H55h3IaYMR3ol2Yrh0eal8aEZipfE1eWSUNRWGuiVfWJ4q4mJS8+fUOFDgbRhoAIExcT
	faRYHO05xsN8hM0hm42fgAj/NUshFkThfcQ93ikoFnHzschcx0TXMlYh9+a6Rc0wKVWgHM15jhP
	qGT
X-Received: by 2002:a05:600c:63c9:b0:493:bc80:69f with SMTP id 5b1f17b1804b1-493c2b85658mr30786155e9.19.1782925542795;
        Wed, 01 Jul 2026 10:05:42 -0700 (PDT)
Received: from localhost (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-477de3dd53fsm1210419f8f.37.2026.07.01.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:05:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id arrays
Date: Wed,  1 Jul 2026 19:05:22 +0200
Message-ID:  <7f9d4a239c76b6bb384048ea5591a21ed87d9b0e.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=0q1aVpO7t7+n6WZEaQyJdycCY7xEiMVwH6qz19u0bq8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhixXjxtTJ/x9kq8pr3fnV8O9Lu9MyfSC3qnHGt4cWms4y /F/84fmTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmEiXOwbDh6t5X01XsfhqZ nD08SfaFg0h2l3JhiOO99/dnOMQUX7cs7y+v5ZDUtLpeePH4X/UdGQtW7rJc4R213cFVIr3qdDX /7LafCk1B791kFnEtstsa2b57c98+xvz3WuULF5dlGE30NmYQ+z45pcYj4krELjvHlyJuzEp3dr vOdW4xFf/x9V2G03lT115P727tWt8v5VPz42pdziRwrnO8vnptuPcTY15Pvg85T7XmR7lmOIt3S Ipde5Yr0r+NcXHEbMWowq2u0rOv2kee/ff5AvPZ3gmHfjgb7+OMTfvh9MRie7TW5Wyz0FSuvjv3 tN+Fbdxt9cKZK3nlhz6vgrObU7Sriu/sbL76tDRr3zcbAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-11725-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 210726F02A6

It matches the usual coding style to have the MODULE_DEVICE_TABLE macro
directly after the respective arrays.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index e3f41336a831..6a28048f687b 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -52,6 +52,7 @@ static const struct pci_device_id hv_drm_pci_tbl[] = {
 	},
 	{ /* end of list */ }
 };
+MODULE_DEVICE_TABLE(pci, hv_drm_pci_tbl);
 
 /*
  * PCI stub to support gen1 VM.
@@ -219,6 +220,7 @@ static const struct hv_vmbus_device_id hv_drm_vmbus_tbl[] = {
 	{HV_SYNTHVID_GUID},
 	{}
 };
+MODULE_DEVICE_TABLE(vmbus, hv_drm_vmbus_tbl);
 
 static struct hv_driver hv_drm_hv_driver = {
 	.name = KBUILD_MODNAME,
@@ -260,8 +262,6 @@ static void __exit hv_drm_exit(void)
 module_init(hv_drm_init);
 module_exit(hv_drm_exit);
 
-MODULE_DEVICE_TABLE(pci, hv_drm_pci_tbl);
-MODULE_DEVICE_TABLE(vmbus, hv_drm_vmbus_tbl);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Deepak Rawat <drawat.floss@gmail.com>");
 MODULE_DESCRIPTION("DRM driver for Hyper-V synthetic video device");
-- 
2.55.0.11.g153666a7d9bb


