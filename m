Return-Path: <linux-hyperv+bounces-5669-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA7AC5273
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DF08A0784
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB527C877;
	Tue, 27 May 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OtDYnORi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6327A916;
	Tue, 27 May 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361480; cv=none; b=E7CI+kDV1mT+XsNDYX7aNz8ZQTaXQ1FAyEDP6oQPUlNHFQm0uy2HateS5fgrIgoXjPBLJRvid9UmurwSvbUN/JoOsjaFor4m0RCW/McJ8FrI/XA0rb0Ki21wWz8AQ54lP1rJNE3weGmQAuzcpZ/VE8PZ+hLP/bg39Txa5YfdO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361480; c=relaxed/simple;
	bh=tuhkjgggF3Izv+iUVmzHcxoIfuTJL6K3BqngzRFPa7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UgiBBCz+rv4DUE4V66P5V8OH24ydGKqjz8OZiI1FMfxOwYU5WVe4DahR9sAbXUTjfyr7MMFbfAm8bhTanT7SokaHsq21OnTGdUKhlFBf6TQ+j5H7lGzMrJl8bVaRALocFpioEz+/qyTwjolXcPkzsatEJiSx9+ymHO7mju8tpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OtDYnORi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 63A3B206834A; Tue, 27 May 2025 08:57:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63A3B206834A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748361478;
	bh=ck7OlH3iLM2zajPne9r3rXRVKyZNS5D+OnC1eJ41hxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtDYnORiFmFpoTEF+oxQe1xdCrIRWIQHvLJvUVgl6E0QIGQrpBHcPNaAYUbuoj9xu
	 wCf8YZAy/8FxSVuNaqUctBfgo/xnWXS0dKt4l1DKP4QiRUOV+ktiiugtHqtA7HQ+iz
	 B01Wu9F7O5rb5bZmkAeO7+H29qfuO5BNYrjwtxyM=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=EF=BF=BD=7EDski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
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
Subject: [PATCH v4 1/5] PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
Date: Tue, 27 May 2025 08:57:57 -0700
Message-Id: <1748361477-25244-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
to prepare the MSI descriptor is also needed.

Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
MSI-X vector allocation.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 Changes in v3
 * Improved the patch description by removing abbreviations
---
 drivers/pci/msi/irqdomain.c | 5 +++--
 include/linux/msi.h         | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index d7ba8795d60f..43129aa6d6c7 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -222,13 +222,14 @@ static void pci_irq_unmask_msix(struct irq_data *data)
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
-static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
-				  struct msi_desc *desc)
+void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+			   struct msi_desc *desc)
 {
 	/* Don't fiddle with preallocated MSI descriptors */
 	if (!desc->pci.mask_base)
 		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
 }
+EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
 
 static const struct msi_domain_template pci_msix_template = {
 	.chip = {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 86e42742fd0f..d5864d5e75c2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -691,6 +691,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+			   struct msi_desc *desc);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
-- 
2.34.1


