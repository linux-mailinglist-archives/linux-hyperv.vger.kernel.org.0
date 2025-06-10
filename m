Return-Path: <linux-hyperv+bounces-5841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9292CAD4712
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 01:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4033A7A34
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0528C5C1;
	Tue, 10 Jun 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qMlakPqv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728228BA88;
	Tue, 10 Jun 2025 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599531; cv=none; b=bOyan/twZm1mUBGo1vZu6CZWKy6QCWY16yCfv03jCvTy5HQP15um8b8g1rKXaI4duYVpiwqLlzkIfi36u4N2Gubv3Fc6/4RisyhK36xuDAKejjzWTOOdUkuCXQXrwqhm5afBvqcVHP+/PLmpInvp1SwXD0EUeQtHra/EZEPc4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599531; c=relaxed/simple;
	bh=wVLWn8Voi27o4oS3F360XZyMfrh+Z5cexYK+WZ766KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lrHxMKsLFMyUHcmMmtMHqZQl6Xe6R7gi54KoNCwtAbM0KWXjTZOOKw5IjWqW0xy1V1xU5pFhM0CdgeGrhR52Lm1bcTLou4DupkkpAaXIMTDr2dewIJNPbNTJgs8TY5Uc6wzQ0Rep6d1zRWSXnO78KG/ZXZ8h44aUY03Kg9UG6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qMlakPqv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 809222115188; Tue, 10 Jun 2025 16:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 809222115188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749599529;
	bh=2OIurZZU+W8LJhjgQv4K7OiVx/Za0G2uLpi0IQWvRSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMlakPqvE+vQ1DebGap+Ye6OBZa6NnUYPh3gXIJV7wyy7Wjk7E1Cby06xj9ViXuCJ
	 oWIWOHbtX2mEHM+Kc12WmLboZfDbNWLapRNElVyOCZ2qrYhpvJbUbDfFnqL7VbO365
	 a4iZJmfff5uYK258r9c3RW8w5crRqmbPT7Af8CBY=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 4/4] PCI: hv: Use the correct hypercall for unmasking interrupts on nested
Date: Tue, 10 Jun 2025 16:52:06 -0700
Message-Id: <1749599526-19963-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
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
RETARGET hypercall, we should issue the MAP_DEVICE_INTERRUPT
hypercall to L1 to complete the setup.

Rename hv_arch_irq_unmask() to hv_irq_retarget_interrupt().

Co-developed-by: Jinank Jain <jinankjain@linux.microsoft.com>
Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 4d25754dfe2f..0f491c802fb9 100644
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
+	if (hv_nested && hv_root_partition())
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


