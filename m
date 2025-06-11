Return-Path: <linux-hyperv+bounces-5868-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74453AD5829
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225611BC2EA9
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AAB298CDA;
	Wed, 11 Jun 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dtUnNw9I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A01288C1C;
	Wed, 11 Jun 2025 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651020; cv=none; b=WmuqqZ9QZXR3qokRctXk5wDTYtJNPPRvBANEpU8GWdfVNCWiyFQH6zYD2r7JyI1OSeeRQp7+vfYgij1nc5khQrZFa4KW+YAYddgIjZGyjLi5farERad1k01Uz2t6/kAHTuMUKSlHGWQ3PgT2SPt35mZT0/8C3Y4XKE5zMTfr9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651020; c=relaxed/simple;
	bh=e90K+htOBMVQUgftdB0okBepiyRdEJAgEpLGNhKRD14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NxZ4ozphh30FCCpCd8NRs8TEYPdSCq/Yv6ScY5/dIHaTFtTgLQ55SPKQMqw442GOTF4LhgNFMx6aIXjgTISs/oT9vJjVSA2dUq7YfUokT1ybJxJrmlit+kFOAKEJ5NRJbr9nbZGR6xEvhxenlj/CyViC17GGFwOMU/wA2RQMiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dtUnNw9I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 141D62115191; Wed, 11 Jun 2025 07:10:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 141D62115191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749651017;
	bh=FxKchsvLCIryqIeiA0+j0+BapXh7RHG9bqOb6DuAAEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtUnNw9I4s6UlqQJUdqjfw8g2l/lH573+y0cNpRIiNwZFhpIABmrQr/lf2x0nefgE
	 xFoXAJH/9UvvCr5L7SFdqkHqJr2+c9lIJASQaf7giy7wh6+ynW8M9BWWs9INzhlHRN
	 3MYN4UVxRC/Q4IJpjdP32UCRyIJN02X0YIMsDFMQ=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=EF=BF=BD=7EDski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v6 2/5] PCI: hv: Allow dynamic MSI-X vector allocation
Date: Wed, 11 Jun 2025 07:10:15 -0700
Message-Id: <1749651015-9668-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
pci_msix_prepare_desc() to prepare the MSI-X descriptors.

Feature support added for both x86 and ARM64

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 Changes in v4:
 * use the same prepare_desc() callback for arm and x86
---
 Changes in v3:
 * Add arm64 support
---
 Changes in v2:
 * split the patch to keep changes in PCI and pci_hyperv controller
   seperate
 * replace strings "pci vectors" by "MSI-X vectors"
---
 drivers/pci/controller/pci-hyperv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ef5d655a0052..86ca041bf74a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2119,6 +2119,7 @@ static struct irq_chip hv_msi_irq_chip = {
 static struct msi_domain_ops hv_msi_ops = {
 	.msi_prepare	= hv_msi_prepare,
 	.msi_free	= hv_msi_free,
+	.prepare_desc	= pci_msix_prepare_desc,
 };
 
 /**
@@ -2140,7 +2141,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 	hbus->msi_info.ops = &hv_msi_ops;
 	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
 		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
-		MSI_FLAG_PCI_MSIX);
+		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
 	hbus->msi_info.handler = FLOW_HANDLER;
 	hbus->msi_info.handler_name = FLOW_NAME;
 	hbus->msi_info.data = hbus;
-- 
2.34.1


