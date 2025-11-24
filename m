Return-Path: <linux-hyperv+bounces-7810-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C3C821BB
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 19:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AFE3A87C1
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220673176E4;
	Mon, 24 Nov 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHhbsp4x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807F314D28
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008968; cv=none; b=oTdkx6mMxtmOF88W7FzyWTJhmt+cTrWqlobE+qH0buC2R+U9KUI1F9RvASL87odbhEUf3zqfZHgW4z4iwQ1ZWauTkQ43c2XO0aY2yD/ObXOnFWLeMM4chOcsaMx1r33AfqSlrS3eRtSot/MHI3jFTLJIfS2H7K7/PllzhLKvoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008968; c=relaxed/simple;
	bh=vsh6gCZNT2fH6DetQwFBewFmmMxYo5Aysy5llP/krFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rbOySjdPJpjbic0t6VTWHsycHC7Up3ssdJ0Cpy66X0URfwGwTwiwszx5TqWgfoHd+RypHmzUX5uFzYLHsnGxUxq4MvKlwYe7ufpMllrhX4DQKD8F3/NeutBr/0wFR2duu1+L/Jfi7FqchpRgNOdIfNt8tIVuvEg1NzIiaHmDggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHhbsp4x; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29555b384acso57447035ad.1
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Nov 2025 10:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764008966; x=1764613766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7g4YApcxeWn1QV0962fcWmEJsVfTz87ip5iTpRI8ow=;
        b=IHhbsp4xhKyUOXbaOao2NTnD52FQgcCC0UmoZ+P2oBqwdJj0u9S4bEdJnwi+t310qa
         hzWXhbgw/I8dbG3HXKKQNOV0sav8cDNEvkvYCMWzdl8vfyss0a0WZoE5kdw+Pk8+9Lco
         C5bxjfO08V1loS4SjFhjJ0szimTW0oD6h8oM7Clnddua8pLn045wzh8TNNg3Xui2kxFz
         SYY396aECshhbmKtpW0hOBo3WpQFFmi2bl4/oOnTlSYXa2kJ3msnkwtICOOjXrwtDr8f
         vlQ80HG91NA0eyFvW95yuReAQhagJEeWpEXaYt/TiFOUfREiQCH4Qx2uk9JNnldABt9i
         58rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008966; x=1764613766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7g4YApcxeWn1QV0962fcWmEJsVfTz87ip5iTpRI8ow=;
        b=hhksDClUX7fORH8wN9bHZFFvmEwFmylkhbLJOCotDf72oVaexkbuCv8zQKPOD2fea0
         2TGkiE21QFUPXvg7g6AzArkuob2mYKYRaowpThaYjA+2uM3DKWD7KgMjMU7gy8RGmvQ0
         11uty3a3WR9aH36WQg7yDFh6QVxEf/iGyBkoZxBAEzJ9dgIJ93illZc/iwbMgbQM4K+/
         EFm9qMdGIKniyASapm9USqo39rWsf6i8Nwen26teusTpLSY1VPN6PrvfBY0G2vEEJxnh
         wCqqUb9+3cH/1h17PmlmhrU4aQ5Fx6L8zirtnejRN1D5wKeeAXdj0c7whVkGhacXa7uO
         cNGA==
X-Forwarded-Encrypted: i=1; AJvYcCXhMB5g1Gwz1wecd5AGthtxVjICVOPx6f3qNStb6EolTVxNMY1IOUwS+CyCt8K8Rd9C3tG8W+03p6bLyIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlYc+Et38+ELD6Z2dno6dTE+C0NajwlGI3smfHldlAwSSdKFt
	9E2dWLsthS9M0BDHgHAwAHXjU7jkfcZqLcpE8Dl63FNGYwl/Z+TOAmJ0
X-Gm-Gg: ASbGnctrg73AIWExYDHt6NtG6YOcvSvz2CP2mLk71cJUBP0waZMIUIEqai9SectcwBq
	Hyuce0dGEHW3pdUH+fsa9APrIuhwPzvGFJgIoHnQgrRcJpK9KChy/HLJkRdrxLCh9rlO3cNffmF
	8gqkMUL7zfxckFF/+UC702LmviOv1R42fGIjQ6yLA2zBv/3ATWROY6U3Tuoj7mJ9Er9sLv0Vd/y
	oM7e3VwBHCdCIefhovkUNHa96hDLelKnndYOjbYTKGfZfsdQfAafoC8R6wSDhCxcyL4sTmEE+xb
	uOpcutdT09oAtmQb+RLy1U87Gk0VDhDboFzDk2l1kAUY2PG6xob/7NXfVj8nQ2BBr6+AS/217qc
	aG4dMTFYsKkHLBWIRBU839fwttiZNzwBLXRY36R2uISF1XgB24coCNWTk6ajxlFYUU1rGSCj6k8
	aQURk7WwAWLIdJLw97T+H0N6RXAyO5I9UYdto=
X-Google-Smtp-Source: AGHT+IFeO+TGaMNPoLfpN+XZe55yTNMT9nF9JthEW58YFJD5Yapc9U9WPxNdIP4Ln2O8C1lyEGrbBw==
X-Received: by 2002:a17:902:fc43:b0:295:6e0:7b0d with SMTP id d9443c01a7336-29b6c6bb2f3mr142913995ad.56.1764008965654;
        Mon, 24 Nov 2025 10:29:25 -0800 (PST)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1070c3sm144760415ad.12.2025.11.24.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:29:24 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	vdso@hexbites.dev
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory support
Date: Mon, 24 Nov 2025 13:29:20 -0500
Message-Id: <20251124182920.9365-1-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In CVM(Confidential VM), system memory is encrypted
by default. Device drivers typically use the swiotlb
bounce buffer for DMA memory, which is decrypted
and shared between the guest and host. Confidential
Vmbus, however, supports a confidential channel
that employs encrypted memory for the Vmbus ring
buffer and external DMA memory. The support for
the confidential ring buffer has already been
integrated.

In CVM, device drivers usually employ the standard
DMA API to map DMA memory with the bounce buffer,
which remains transparent to the device driver.
For external DMA memory support, Hyper-V specific
DMA operations are introduced, bypassing the bounce
buffer when the confidential external memory flag
is set. These DMA operations might also be reused
for TDISP devices in the future, which also support
DMA operations with encrypted memory.

The DMA operations used are global architecture
DMA operations (for details, see get_arch_dma_ops()
and get_dma_ops()), and there is no need to set up
for each device individually.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 90 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0dc4692b411a..ca31231b2c32 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -39,6 +39,9 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
+#include "../../kernel/dma/direct.h"
+
+extern const struct dma_map_ops *dma_ops;
 
 struct vmbus_dynid {
 	struct list_head node;
@@ -1429,6 +1432,88 @@ static int vmbus_alloc_synic_and_connect(void)
 	return -ENOMEM;
 }
 
+
+static bool hyperv_private_memory_dma(struct device *dev)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+
+	if (hv_dev && hv_dev->channel && hv_dev->channel->co_external_memory)
+		return true;
+	else
+		return false;
+}
+
+static dma_addr_t hyperv_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+
+	if (hyperv_private_memory_dma(dev))
+		return __phys_to_dma(dev, phys);
+	else
+		return dma_direct_map_phys(dev, phys, size, dir, attrs);
+}
+
+static void hyperv_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!hyperv_private_memory_dma(dev))
+		dma_direct_unmap_phys(dev, dma_handle, size, dir, attrs);
+}
+
+static int hyperv_dma_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nelems, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct scatterlist *sg;
+	dma_addr_t dma_addr;
+	int i;
+
+	if (hyperv_private_memory_dma(dev)) {
+		for_each_sg(sgl, sg, nelems, i) {
+			dma_addr = __phys_to_dma(dev, sg_phys(sg));
+			sg_dma_address(sg) = dma_addr;
+			sg_dma_len(sg) = sg->length;
+		}
+
+		return nelems;
+	} else {
+		return dma_direct_map_sg(dev, sgl, nelems, dir, attrs);
+	}
+}
+
+static void hyperv_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nelems, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!hyperv_private_memory_dma(dev))
+		dma_direct_unmap_sg(dev, sgl, nelems, dir, attrs);
+}
+
+static int hyperv_dma_supported(struct device *dev, u64 mask)
+{
+	dev->coherent_dma_mask = mask;
+	return 1;
+}
+
+static size_t hyperv_dma_max_mapping_size(struct device *dev)
+{
+	if (hyperv_private_memory_dma(dev))
+		return SIZE_MAX;
+	else
+		return swiotlb_max_mapping_size(dev);
+}
+
+const struct dma_map_ops hyperv_dma_ops = {
+	.map_page               = hyperv_dma_map_page,
+	.unmap_page             = hyperv_dma_unmap_page,
+	.map_sg                 = hyperv_dma_map_sg,
+	.unmap_sg               = hyperv_dma_unmap_sg,
+	.dma_supported          = hyperv_dma_supported,
+	.max_mapping_size	= hyperv_dma_max_mapping_size,
+};
+
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
  *
@@ -1479,8 +1564,11 @@ static int vmbus_bus_init(void)
 	 * doing that on each VP while initializing SynIC's wastes time.
 	 */
 	is_confidential = ms_hyperv.confidential_vmbus_available;
-	if (is_confidential)
+	if (is_confidential) {
+		dma_ops = &hyperv_dma_ops;
 		pr_info("Establishing connection to the confidential VMBus\n");
+	}
+
 	hv_para_set_sint_proxy(!is_confidential);
 	ret = vmbus_alloc_synic_and_connect();
 	if (ret)
-- 
2.50.1


