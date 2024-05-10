Return-Path: <linux-hyperv+bounces-2093-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E88C2879
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E5C1C2439F
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037C172BD8;
	Fri, 10 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l+uYgJ8/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307D172795;
	Fri, 10 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357189; cv=none; b=bxkZNWBF6GXxSXel1R/4/vCY70hVrouQu0wDOiBrWYshYTyt5TJBC/7EvuUYwUA99HUINxwccIqB3eYHQ77O4HnffK7YNL+50yd4/1rmFn2MfXHTt98981tGgkNmQWtLxYdoP4+jrWseo50kbjmW4ykH83mIUTXdcSKKYZyD76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357189; c=relaxed/simple;
	bh=UsbnjB4gtW5blpakM91WS9EhR6bLL6Lpgeic4mxEgKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDs4oH7nfJhukY5iBtt28HpnqN/IOJn1TL3RoxV5IPlX3QzmxSqTuKZsTrKDAc5Fy7xYLwVMDGcqvDb3p4QWHqDTAiTLHAQh7WVnppovimTNnQ6ke9Sw5Y8NruehHbgsYQIajz699XrjtYQhoPeu++HecYKb+o0aSRDOxHXVDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l+uYgJ8/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id E10C320B2C87;
	Fri, 10 May 2024 09:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E10C320B2C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715357181;
	bh=SEb/v+0tEn4l473lcXeO/Vet6aCRc4eg0h0XcwR05H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+uYgJ8/vVfn6h1kO7xgjuIKnvBevf8xe3OhJc+gLZ+G7PPvh33xPIk8HsMt8fPCE
	 VHYEP674UnmQV+8VvYXv8KDirpyOoWqiEsDI3wQSjZ1nMGUcfJQdA4mMbB3Brz96ub
	 REuYI8So3Z+FUFR9yHOaaJw91gFOQBj4MybCrf8U=
From: romank@linux.microsoft.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH 5/6] drivers/hv/vmbus: Get the irq number from DeviceTree
Date: Fri, 10 May 2024 09:05:04 -0700
Message-ID: <20240510160602.1311352-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510160602.1311352-1-romank@linux.microsoft.com>
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

When booting on arm64, one has to configure the irq
using the data from the system configuration. There
has already been support for ACPI, support DeviceTree
as booting in a Virtual Trust Level relies on DT.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e25223cee3ab..52f01bd1c947 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -36,6 +36,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
+#include <linux/of_irq.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -2316,6 +2317,34 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 }
 #endif
 
+static int __maybe_unused vmbus_of_set_irq(struct device_node *np)
+{
+	struct irq_desc *desc;
+	int irq;
+
+	irq = of_irq_get(np, 0);
+	if (irq == 0) {
+		pr_err("VMBus interrupt mapping failure\n");
+		return -EINVAL;
+	}
+	if (irq < 0) {
+		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n", irq);
+		return irq;
+	}
+
+	desc = irq_to_desc(irq);
+	if (!desc) {
+		pr_err("VMBus interrupt description can't be found for virq %d\n", irq);
+		return -ENODEV;
+	}
+
+	vmbus_irq = irq;
+	vmbus_interrupt = desc->irq_data.hwirq;
+	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);
+
+	return 0;
+}
+
 static int vmbus_device_add(struct platform_device *pdev)
 {
 	struct resource **cur_res = &hyperv_mmio;
@@ -2324,12 +2353,20 @@ static int vmbus_device_add(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
+	pr_debug("VMBus is present in DeviceTree\n");
+
 	hv_dev = &pdev->dev;
 
 	ret = of_range_parser_init(&parser, np);
 	if (ret)
 		return ret;
 
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+	ret = vmbus_of_set_irq(np);
+	if (ret)
+		return ret;
+#endif
+
 	for_each_of_range(&parser, &range) {
 		struct resource *res;
 
-- 
2.45.0


