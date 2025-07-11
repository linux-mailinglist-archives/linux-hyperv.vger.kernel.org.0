Return-Path: <linux-hyperv+bounces-6195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CDB0246C
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 21:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA294A1D8D
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AC2F3636;
	Fri, 11 Jul 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wrwsu6LN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F81DF25C;
	Fri, 11 Jul 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261543; cv=none; b=bgf+2dYFsJtAArrroNt30JfATepsXYz3DfTZTQ+FdaqlNrEx2qA/ouuJ/9SJu0pqUJk85MO5I+2CRyfKHBvVZdSo0lSrtC4v92DvabPjd/+gfTolYUoGaHXPJ8wFeYQ+6fBmYK625HvJ3MTrFCP1ZoM9Z1Z+WG4ACRCcM/aOU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261543; c=relaxed/simple;
	bh=QUkbyCON0VpeI8tP5sCHWjm7eT5setVQNd21DT2Y+IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PUKH55OY7JDhJlStmBVLBSWmJXC2TQdUfQsMpKkI6JYhHNc6XncstJeIkGuWZk6Ldu1L9XO4t6XEswdwswVuji0zluawUD1IIyino5R0m5BWWkUoxKmM+i3l9UJ6Rjwfha4eIB+oh5+3tTIyZbhjiPlKZ1Io5inTZ+toxbnoLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wrwsu6LN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id B270A2115816; Fri, 11 Jul 2025 12:18:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B270A2115816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752261535;
	bh=IIMcAZzl2wgTkbzBnokzygglawosdc5xNO3bETXTgVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wrwsu6LNTCgtIS5fpawoc7PvXv78sQHf5s9fm0lCrHe58ADwkI5aYuQFp0uNenWyv
	 M/QtuJG8oiPtOM0vx+QCZxs7jrN83E8RiRtkK150ACtIvOJLYeD3MvzVE4ItKLKGV9
	 i5GNj9anAUvJS4lX3UBRbAbROt63hvOeDxIznpa8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3 3/3] PCI: hv: Use the correct hypercall for unmasking interrupts on nested
Date: Fri, 11 Jul 2025 12:18:52 -0700
Message-Id: <1752261532-7225-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Running as nested root on MSHV imposes a different requirement
for the pci-hyperv controller.

In this setup, the interrupt will first come to the L1 (nested) hypervisor,
which will deliver it to the appropriate root CPU. Instead of issuing the
RETARGET hypercall, issue the MAP_DEVICE_INTERRUPT hypercall to L1 to
complete the setup.

Rename hv_arch_irq_unmask() to hv_irq_retarget_interrupt().

Co-developed-by: Jinank Jain <jinankjain@linux.microsoft.com>
Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-hyperv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 275b23af3de2..13680363ff19 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -600,7 +600,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
 #define hv_msi_prepare		pci_msi_prepare
 
 /**
- * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
+ * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
  * affinity.
  * @data:	Describes the IRQ
  *
@@ -609,7 +609,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
  * is built out of this PCI bus's instance GUID and the function
  * number of the device.
  */
-static void hv_arch_irq_unmask(struct irq_data *data)
+static void hv_irq_retarget_interrupt(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
 	struct hv_retarget_device_interrupt *params;
@@ -714,6 +714,20 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
 }
+
+static void hv_arch_irq_unmask(struct irq_data *data)
+{
+	if (hv_root_partition())
+		/*
+		 * In case of the nested root partition, the nested hypervisor
+		 * is taking care of interrupt remapping and thus the
+		 * MAP_DEVICE_INTERRUPT hypercall is required instead of
+		 * RETARGET_INTERRUPT.
+		 */
+		(void)hv_map_msi_interrupt(data, NULL);
+	else
+		hv_irq_retarget_interrupt(data);
+}
 #elif defined(CONFIG_ARM64)
 /*
  * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leaving a bit
-- 
2.34.1


