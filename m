Return-Path: <linux-hyperv+bounces-2092-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F38C287C
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439E9B22645
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6731172BD4;
	Fri, 10 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JEsp25bu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C0172796;
	Fri, 10 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357189; cv=none; b=kMMj35b0wZ7hKtawtO6/9p/RYO3koCkjs6w2Pke37NsNEj/rdRz4h1xfec73qEWR2WJvHj76UwtnCejjOXKh9XJNh8k6ovTHIt6mt/nzMqs7BwZN1iw6Zm4HV1ZHBK9b2VmTyQqdTbmT5oSSPH5tnHq9gwwHDukN4R0pYzetnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357189; c=relaxed/simple;
	bh=GE5tLHN9OT+uWRNNqUExw+u/b0/lJKng9dDqqJYdNds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWR4WYsaFsGee4+XNDq1bhvgPN2wILGS6RKYpbuRt9TfHi0pUO/bR+2XpKGiXpNnfVR6nbbDr0gwpWFKqp1oUeuqvTxVcYXgI7EqWgO2ZBSfScCcqlTeJzWqi94qy8fzSOp/aa5g2Cz3DCfPCn827Ap/mP9Yg4CPfWc/MAD1fmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JEsp25bu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B1FC20B2C89;
	Fri, 10 May 2024 09:06:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B1FC20B2C89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715357181;
	bh=LXs8J2ZnHM4aNGPgsOLCUM2M1nDXtO2ZATnKq4lTGJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEsp25buXL/eu6noVCZeqa+pgVEbi+bxNHCUVYCludbleCn/LBBAPI5/pookttIQZ
	 2Am6wmKVDXb+pCVNUtyLfSbVCuLI7qj3ytRsE4UxGxmE1laIh6AFbvdkpZsx6poyk4
	 E5wi5P4c/TM730HDuNsd7yFHGV9iVWv13tP6Ct54=
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
Subject: [PATCH 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from DT
Date: Fri, 10 May 2024 09:05:05 -0700
Message-ID: <20240510160602.1311352-7-romank@linux.microsoft.com>
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

This change allows Hyper-V PCI to be enabled on arm64
via DT when booting in a Virtual Trust Level.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
 include/linux/acpi.h                | 10 ++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1eaffff40b8d..ccc2b54206f4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -906,9 +906,16 @@ static int hv_pci_irqchip_init(void)
 	 * way to ensure that all the corresponding devices are also gone and
 	 * no interrupts will be generated.
 	 */
-	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
-							  fn, &hv_pci_domain_ops,
-							  chip_data);
+	if (acpi_disabled)
+		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
+			irq_find_matching_fwnode(fn, DOMAIN_BUS_ANY),
+			0, HV_PCI_MSI_SPI_NR,
+			fn, &hv_pci_domain_ops,
+			chip_data);
+	else
+		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
+			fn, &hv_pci_domain_ops,
+			chip_data);
 
 	if (!hv_msi_gic_irq_domain) {
 		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..eb93d355bb6d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1077,6 +1077,16 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
 	return false;
 }
 
+
+static inline struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
+					     unsigned int size,
+					     struct fwnode_handle *fwnode,
+					     const struct irq_domain_ops *ops,
+					     void *host_data)
+{
+	return NULL;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 extern void arch_post_acpi_subsys_init(void);
-- 
2.45.0


