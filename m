Return-Path: <linux-hyperv+bounces-5670-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E940AC5279
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278308A0CE1
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FBC27CCC8;
	Tue, 27 May 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gTF4MeJv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62D2741DC;
	Tue, 27 May 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361492; cv=none; b=p7LJCRN4cQjCB1JHl8pFan5BVIVautOUfNQuyYvUR1dwAgj9808qZ8Rc0aqm7gFta2HvxGwAbsfDvL5K247kl0rQjgfcP1Q19CDuGtRjxZpZ6SCwyuecfxyW68fN2/jRGoL8hpS2eicMURAZNeNadh+pZN/gukFnrwJLrbw1n2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361492; c=relaxed/simple;
	bh=6zLPd0/W1bzf98poY04UCdVCM4Eyy10eh4IQwBNNFa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Lmco//o0q3CzeZ+FvnJx5MFKGXhy4yDzeVRp0Znusq4GRRVdlo50n52AVBHzY4FwBHDxmjgLNEaKYI1I0SkTaBvPO8l88O37X0OU7vrR5pMtBL74QbA29pR1/q0Iw2lXjfOe1ama6F8ieIc9O63iiY8xkVq71a6b+qaboPcGZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gTF4MeJv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id B03CA206B778; Tue, 27 May 2025 08:58:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B03CA206B778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748361490;
	bh=9vyIcw/j3U4kYU223Umd1U4i7224+q4yAjNPR7hv21M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTF4MeJvTwM0N9ergIk0aMrAHEOtQ8gQLJFYc3V+UNQnjvwOyzfYTPu8cu7L6XxsK
	 RZ2zCkrdMGwETayH0nfr3n2T8ITiaO8s0v6AGOKfXDPwdBlmiSnpGY/832FwL/h00f
	 y6p/ocCpbZAfSnfbCuc0vwW9ue9c1qGeeZXtD6PU=
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
Subject: [PATCH v4 2/5] PCI: hv: Allow dynamic MSI-X vector allocation
Date: Tue, 27 May 2025 08:58:09 -0700
Message-Id: <1748361489-25415-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
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
 1 file changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ac27bda5ba26..0c790f35ad0e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2063,6 +2063,7 @@ static struct irq_chip hv_msi_irq_chip = {
 static struct msi_domain_ops hv_msi_ops = {
 	.msi_prepare	= hv_msi_prepare,
 	.msi_free	= hv_msi_free,
+	.prepare_desc	= pci_msix_prepare_desc,
 };
 
 /**
@@ -2084,7 +2085,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
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


