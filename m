Return-Path: <linux-hyperv+bounces-6101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC61AF83CB
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 00:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6147B4BBB
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 22:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE952D1925;
	Thu,  3 Jul 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HyWsBdbT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641A2C3245;
	Thu,  3 Jul 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582695; cv=none; b=gBs9sRAb+lZD5p99uKNJWU/cxafPAKC+glospuphznESV+Ook7qxbv/aTR5v6HCaMusTAmsP21lxsHZq3M196yRrKFlZ/wiLUTJSbTNPyHW55LhIaLeO9KGFMngjz7L7c4HB/pF2/iqh2H2M4ssL0OTddXqQkK5iqZF3lqWhUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582695; c=relaxed/simple;
	bh=20MuRFf6dgkcOzbvX/wpMb7vM1FZ2s/pj2m0m5FFrIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GjP5yBOhaGx7wX2nrQTCYkGg7GUZDrDzrpBUWxZtrGpstoNrdN+DmAcZdGKlQuPWlnZ3Ppo510KWTWyAnvyBTYaaZc0fgsjxn910h+XkdWgVH6e35ogzckrZwxQGgbZ6NdE7vFhnWUUUNFuUFw2q0zHs+bEAXMpqUimokPS6v7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HyWsBdbT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 92A8821151BE; Thu,  3 Jul 2025 15:44:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92A8821151BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751582693;
	bh=32BzIHGNp0akvBK9OGz37WAORZ5C+YK3ijDeUf8UyCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyWsBdbTfYTmux2z6fic1v81c+SlXy2R+ZaRiPuCKErJfyagh+edfjNDki874GJbA
	 DzX9C/5z3IYgHEXMfOaooa9OQBw4xm9UguLkcWuqNQIiuM02DjLZOlV1VTn2P5lAkY
	 KdA4akRVLO3B4QKaiB2dfZ9etbC+Ue9S1QLiRtT8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
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
Subject: [PATCH v2 6/6] PCI: hv: Use the correct hypercall for unmasking interrupts on nested
Date: Thu,  3 Jul 2025 15:44:37 -0700
Message-Id: <1751582677-30930-7-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
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
---
 drivers/pci/controller/pci-hyperv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 4d25754dfe2f..9a8cba39ea6b 100644
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


