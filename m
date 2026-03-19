Return-Path: <linux-hyperv+bounces-9610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIqmH2BdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9610-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:32:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F030A2D22FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A6B930A7396
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425113FF8BD;
	Thu, 19 Mar 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj4x5gkF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723333FEB19
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951963; cv=none; b=EChi4by/oWm7K0merLb7euCigg5cK2/Lh7xA5oOcO/ZLrrrOkuCRDONRxB/mlMQqx6vDgMCZonoI0CU94WlHUZxpzBA44/vNadTgcNVN4xFFRbmmZHbE+LQckSMIGu5RYBzwAM32mmw3H8OddWcEBheRK/Y7onmTYTlxw/JP0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951963; c=relaxed/simple;
	bh=YAI3oxAVt3oTr3r4AmayAs+BzXpkJkmninzM6NStvCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWka7z/v5DzhyLTjTEu2efWAvWSsVE3+Lz4F4Fz2cGNacWK40EYWYpLzd0WYqh7N2jLgUk5uwo9+Htf70gD5XMyi2ZnTsV5CYk0EUUdrcQBqokcepH+5YOugeesmMRPnFzfqIeYmknRL9VQlr1iho+m+GqrEoOoDzFiND7GGfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj4x5gkF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b9b1900bso859138f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951958; x=1774556758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOG7RwxCRsOgk4hVW4tWFSrS7iXDUAIOM5CTFXqelFw=;
        b=dj4x5gkFMBLraEybzDmGsG5oR6bWFn7VzpOG4sHsA+HoRTco6dmxL5wg8jvRSquV46
         cfOtLb3D5dnNdrfPdoSHK94tyfQHA/WKXFAIGc8kvEdpzYLMTjE/qhbUtO8k1esDj5j+
         OZGT1XXuGoyscQ/AtjVds9gqPWnTG5Ph01GNvgAd+zJMRqquy6212t6PVTOEoLdwHS3U
         r5ktqKCYtA12dAO1Q1xU2HQcy/J9vyfL3mp2eyY9YkcB5BD12Ed8tNzd21BVoKFqaSJm
         nq0/mktlAgcVW9NNv5YHHV/agsW+QBrWApE01BylH+QyMm9B8S0S/f7YWABYHRC3UzjD
         BBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951958; x=1774556758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOG7RwxCRsOgk4hVW4tWFSrS7iXDUAIOM5CTFXqelFw=;
        b=Ffz5Z8FkrSeIkoOLfCp4iZYyp/J1W49RGvFgTHIliB+jG5DYqwZGHX1WMX675dYs+s
         p95pnn7rZ2bqzmFZ4Teehy7fpv/n1MjupviJ1NdebIfQWIpLH4saVGVBTqBCi/yKjext
         VLwiWrSFT9NAtM1bNTf9fyraTNZCYTYLX+r4IwfimXkt+pcnti/OiXpi9O+VblidRr1B
         1msEZW5ZmVAwUWTYl3oUaTTVLxL+7OICTBT4kaVdYraUE8ti8P4bB+uwThn2SnsGxiul
         QkbPlIQQNHNH6RtHzfsPodVvtMO09IzohWDSS663gHcMI0qLOJH+x7yFi58vz3NQWF/M
         m5dg==
X-Gm-Message-State: AOJu0Yydpv4WXoKDusOkHZOEMe+WxlwYGUS3uo6jbNuE2Nmx/XwK99YK
	aP3cBqx0+boSxMANl1LjvlVWijLYgl1zqwIrY+yhmPYF0k2QTs6eO+5MtYIyFEftBMY=
X-Gm-Gg: ATEYQzxtsGtgqPun0TVcUoCWc2aKvD86IYmPUPUNepu+Bs4CaM4jpb/OElYUnKOtC+8
	ZLoiwT582g9Q4sxPhdGRWoLKjyLD6vHHvYTlXUiC/y6BCFyRGwRUzfu0puPWIryuO2TdfhEmCds
	wLki0FbOjrUPFvL6Hup0ydK6CXIzyiWykw0i2q/J7/LCyjsmpw8aS0EjyiXlO2j6VQuO9DVLfjW
	hnP6kGxNbOQN8146gz6+pQdpaDJ6ZBN57SeXTxfptjsXVUVUr8q5auzedq7Jzqy6HUmJ0Hbs/eY
	bCBCSDe2gZ/+egn3LcKXRKWjVeyB8s+sgV6VZSdNCl3k7uv/eCp2PpLoU3xXMQbbO0nfi9wxsam
	trP239Z7vJMYZiKj9npKsYr28p+afpNeVFFMfRmm8NzNA8rFIGsjldhSTxL4YSdCA1b55aREDVg
	a/9Qh9XZUZufHRpXa2vKzON9Q8yOg2vl5k3zzoOBgxV8rYisJ6
X-Received: by 2002:a5d:588f:0:b0:439:b3a3:7239 with SMTP id ffacd0b85a97d-43b6423fb3dmr1307686f8f.5.1773951957610;
        Thu, 19 Mar 2026 13:25:57 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:57 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 39/55] drivers: hv: dxgkrnl: Added support for compute only adapters
Date: Thu, 19 Mar 2026 20:24:53 +0000
Message-ID: <20260319202509.63802-40-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9610-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F030A2D22FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h   |  1 +
 drivers/hv/dxgkrnl/dxgmodule.c | 11 ++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c  |  1 +
 drivers/hv/dxgkrnl/ioctl.c     |  4 ++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index c5ed23cb90df..d20489317c0b 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -478,6 +478,7 @@ struct dxgadapter {
 	struct winluid		luid;	/* VM bus channel luid */
 	u16			device_description[80];
 	u16			device_instance_id[WIN_MAX_PATH];
+	bool			compute_only;
 	bool			stopping_adapter;
 };
 
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index f419597f711a..0fafb6167229 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -20,6 +20,7 @@
 
 #define PCI_VENDOR_ID_MICROSOFT		0x1414
 #define PCI_DEVICE_ID_VIRTUAL_RENDER	0x008E
+#define PCI_DEVICE_ID_COMPUTE_ACCELERATOR	0x008A
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"dxgk: " fmt
@@ -270,6 +271,8 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 
 	adapter->adapter_state = DXGADAPTER_STATE_WAITING_VMBUS;
 	adapter->host_vgpu_luid = host_vgpu_luid;
+	if (dev->device == PCI_DEVICE_ID_COMPUTE_ACCELERATOR)
+		adapter->compute_only = true;
 	kref_init(&adapter->adapter_kref);
 	init_rwsem(&adapter->core_lock);
 	mutex_init(&adapter->device_creation_lock);
@@ -622,6 +625,12 @@ static struct pci_device_id dxg_pci_id_table[] = {
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID
 	},
+	{
+		.vendor = PCI_VENDOR_ID_MICROSOFT,
+		.device = PCI_DEVICE_ID_COMPUTE_ACCELERATOR,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID
+	},
 	{ 0 }
 };
 
@@ -962,4 +971,4 @@ module_exit(dxg_drv_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual compute device Driver");
-MODULE_VERSION("2.0.1");
+MODULE_VERSION("2.0.2");
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index eb3f4c5153a6..5f17efc937c3 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -3774,6 +3774,7 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 			adapter_type->indirect_display_device = 0;
 			adapter_type->acg_supported = 0;
 			adapter_type->support_set_timings_from_vidpn = 0;
+			adapter_type->compute_only = !!adapter->compute_only;
 			break;
 		}
 	default:
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 98350583943e..f735b18fcc14 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -254,6 +254,8 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 
 	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
 			    adapter_list_entry) {
+		if (entry->compute_only && !filter.include_compute_only)
+			continue;
 		if (dxgadapter_acquire_lock_shared(entry) == 0) {
 			struct d3dkmt_adapterinfo *inf = &info[adapter_count];
 
@@ -474,6 +476,8 @@ dxgkio_enum_adapters(struct dxgprocess *process, void *__user inargs)
 
 	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
 			    adapter_list_entry) {
+		if (entry->compute_only)
+			continue;
 		if (dxgadapter_acquire_lock_shared(entry) == 0) {
 			struct d3dkmt_adapterinfo *inf = &info[adapter_count];
 

