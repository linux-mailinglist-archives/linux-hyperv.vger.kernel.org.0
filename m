Return-Path: <linux-hyperv+bounces-8089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B058DCE8422
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Dec 2025 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B80304ED8A
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Dec 2025 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187C731195A;
	Mon, 29 Dec 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gDQIf74g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6B310644
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Dec 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045589; cv=none; b=KySnR5DZBdXEWLUx/d6GioHmvJ+5dnZp0ZLmXhVb9BySPvF00l6P3rGqop1QtZSAjsGsPtCSSHz0NlgGPuiBEe6XsxCqpZq4Lkipei0BeNAQioDL704cZXpvMIjL8QQD2u9zjG5feSwFos9Gt1MMEjzAHhrPpb1zqYOj9f33v/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045589; c=relaxed/simple;
	bh=dQpvv6P8rpsc9VhbHXErM++gAE6dp88Qa5WuWmijx9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7CdEjQT8ek45vzzVKpI9a4MO4k96Ih9mo2yn/22+JIu67P8cZRqZUHBYnjdCg2WoZmqFv3k3w2hwn48UhMO6oNJYenx0rrLUnCKOnd5JJa7/gw/qZdRxIt+cjAiuStb8faj80DqRlRjv2lEtP/GWMgw0i5xJBH864+G79g0jXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gDQIf74g; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3ec4d494383so6713620fac.3
        for <linux-hyperv@vger.kernel.org>; Mon, 29 Dec 2025 13:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045584; x=1767650384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cjHGpdx5LLmnDfUfy3cg6m+WR+7JCISjjlWlDNw0F4=;
        b=NomkfwWOGKF7WWqyyFLSTPzYWOcz/4EmWuVxImS2PsD+NkZ7/RrL4WJrn0NghrQajf
         +UE9UCr+Fh3WstJvMGqemY7/Ceyh+1IINT4NJwa8pm6wLTdu0SO/9Ln/E1/tYB8CDpWr
         2XUKJvf8Po9vk6FZGQ1QPin0GRJGL4OPBdkuWwEvuHHTPHz26P9/lDDgEk3eFsdaaaaZ
         qYaPw5NNTM5LN+GAoFhbV10S5eaMZMR32hjCNmRkb0xMlZYh5QK5UTWk+GCxIqc0Zu8z
         AK+HlN8ZkeRhSXoLaRADBqQiKS6Zl2MinbYqeUU9wUDhLKar63Ld4pk0MBlLaTYVkfuX
         nHTA==
X-Forwarded-Encrypted: i=1; AJvYcCVUGkeRILsTEq8FcAicA/50kEqKGQqqmNliu8CYg35GH4eir9S4CkVWctOIqwCsWtHL+I27um13+ocQykU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkHiXntoS7nev1U+6uxGZ1tJgZIqCTq4GGJeW9dibCEu3MOHK
	wWbwTQSqGa6tLMteId+6NfMAYpavSufIJldebw7gvvRWflzMCtjAtQpnFgkhXY6ZYwzoI/ULROi
	xnVSq/N5g6sgS+/je5cRRk112J0lhaaDRD9Hfn0OgcZmekR8tavCf/18hrl2eA9CUdA6T8Dqkxu
	/D3jslguvrs2X4wm5ciF0fDCmh07N+5VQHtEXZook1/ofzpunuJJr6hvJXpRrgY70QRSXnvME+3
	rgGq0KudNiiCKJl
X-Gm-Gg: AY/fxX4OT6BEDq99oTLZ1ZmPHVvLyf0iSNUxvNqlpizxZ9R0lEJ84ftwB5vHfNYbMBR
	kZ8vFkR6wnh+Hs0uPPsTBU2ZW7Q05rUUXHvJH/FDsJywKS7Ls3JG3XL/YJah2gWoGTZWh7LLjyr
	94RgJC1KdUBvUNnGqWPxCFVmJJaKiywcs0Db+cciEw03PKuvBsV+27VReSMxTcyMSHYLuOxzSom
	TpseYQ2mKTIZ+PVF6EFoGDSxJZ6ZjWcU+3B9IKzQNKpBWN7dVW6a8qKG0E03Uuxt5KvMHmlTubW
	WHSlCCnkwU8gTsY8UmDXGbcZMtQESF/9rBQEa2jTp8LBK7UZzRcyCkfydZrnDll3Q+DDvXO8TYU
	nBD1Sdn6qaBQDdWjK5MvTO4cq1jJjFrxF/ZKcdW91AwHisEyqZqn+73PxQ1pKEDFSMatK7zvywr
	BYX3A4IPmYZUYOcn/LGNUkIclmnuryiksEe+jl1I0jnzYz
X-Google-Smtp-Source: AGHT+IFlBP9i2ua3qJjsetn0/kZWWw3DnLUQCQyMRQdkYQTvz2OztLw2bHGQx2Cokjz9PH4msi14HIzT6iss
X-Received: by 2002:a05:6870:e181:b0:332:1b00:6d5 with SMTP id 586e51a60fabf-3fda58cf74bmr15826984fac.39.1767045584269;
        Mon, 29 Dec 2025 13:59:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3fdaab62235sm3141197fac.9.2025.12.29.13.59.40
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 13:59:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a360b8096so245148536d6.0
        for <linux-hyperv@vger.kernel.org>; Mon, 29 Dec 2025 13:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045579; x=1767650379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cjHGpdx5LLmnDfUfy3cg6m+WR+7JCISjjlWlDNw0F4=;
        b=gDQIf74g0f4XN814wGOEeni7K74zctudEumOwUwtDut0irXYw8qeKDbeygAknuCbjW
         TXPFwcAJhveCNs5mBxBt9XOqkWHPnqycUegmsVGP/0IVTgvWXjUlRARmNSF9neLrlUbf
         fVA4cOKJgsQW1IvzVSMY0Qa5XLoI3dBhQ4eGg=
X-Forwarded-Encrypted: i=1; AJvYcCUNE+veyrEjqMq4ABQxg7+YqNb9YxJa4iBWrxPJlVQpthlvfioA1Uy1s848BAyJH5LnsTC11GdVzWi03fQ=@vger.kernel.org
X-Received: by 2002:a05:6214:458b:b0:882:437d:282d with SMTP id 6a1803df08f44-88d82de8226mr482656316d6.30.1767045579112;
        Mon, 29 Dec 2025 13:59:39 -0800 (PST)
X-Received: by 2002:a05:6214:458b:b0:882:437d:282d with SMTP id 6a1803df08f44-88d82de8226mr482656146d6.30.1767045578716;
        Mon, 29 Dec 2025 13:59:38 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:36 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Deepak Rawat <drawat.floss@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] drm/hyperv: Add sysfb restore on probe failure
Date: Mon, 29 Dec 2025 16:58:15 -0500
Message-ID: <20251229215906.3688205-10-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251229215906.3688205-1-zack.rusin@broadcom.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Register a devm action on the vmbus device to restore the system
framebuffer (efifb/simpledrm) if the driver's probe fails after
removing the firmware framebuffer.

Unlike PCI drivers, hyperv cannot use the
devm_aperture_remove_conflicting_pci_devices() helper because this
is a vmbus device, not a PCI device. Instead, register the sysfb
restore action on the hv device (&hdev->device) which will be
released if probe fails. Cancel the action after successful probe
since the driver is now responsible for display output.

This ensures users don't lose display output if the hyperv driver
fails to probe after removing the firmware framebuffer.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Deepak Rawat <drawat.floss@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 06b5d96e6eaf..6d66cd243bab 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -8,6 +8,7 @@
 #include <linux/hyperv.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/sysfb.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
@@ -102,6 +103,11 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 	return ret;
 }
 
+static void hyperv_restore_sysfb(void *unused)
+{
+	sysfb_restore();
+}
+
 static int hyperv_vmbus_probe(struct hv_device *hdev,
 			      const struct hv_vmbus_device_id *dev_id)
 {
@@ -127,6 +133,17 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 
 	aperture_remove_all_conflicting_devices(hyperv_driver.name);
 
+	/*
+	 * Register sysfb restore on the hv device. We can't use
+	 * devm_aperture_remove_conflicting_pci_devices() because this
+	 * is a vmbus device, not a PCI device. Register on &hdev->device
+	 * so it fires if our probe fails after removing firmware FB.
+	 */
+	ret = devm_add_action_or_reset(&hdev->device, hyperv_restore_sysfb,
+				       NULL);
+	if (ret)
+		goto err_vmbus_close;
+
 	ret = hyperv_setup_vram(hv, hdev);
 	if (ret)
 		goto err_vmbus_close;
@@ -152,6 +169,12 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 
 	drm_client_setup(dev, NULL);
 
+	/*
+	 * Probe succeeded - cancel sysfb restore. We're now responsible
+	 * for display output.
+	 */
+	devm_remove_action(&hdev->device, hyperv_restore_sysfb, NULL);
+
 	return 0;
 
 err_free_mmio:
-- 
2.48.1


