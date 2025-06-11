Return-Path: <linux-hyperv+bounces-5866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C591AD5812
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38513A6936
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8C28BAAB;
	Wed, 11 Jun 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BsL1rm0l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E127E7F0;
	Wed, 11 Jun 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650988; cv=none; b=g8BVUNEE7nE7QuI29Plgp9ow8uVafyESZygDGv8tkaRCQgxZBuRIbSW+qdGE7TASfb5yHdXL8n7Y8XGQp18uWESPeC8hOPaFUCF4ERk0+xT6Dr9BMygqd4gFWQT60IxFskuLdERH4Cr0RKpBUJ+q1o06jEtmZftrxhoGH+9zUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650988; c=relaxed/simple;
	bh=AK8EHYOYCq+SXbAg7Z3/UJ2hTdChIAXHjEBP1cncQwc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H9Jwxj6BFY33HERdMXY4Hr8Kf0BEApZ9TsAVs44zXx8Ly1005HI5KhCvFDb1t7uAmIcHhyO+xfkddRnOyi0Ynn+9+oAH9U+CH8eH10pYM0G56oxUB9uTktG1Va8exP8zFQU5zL1+5tnxAx+KJLjMvhu4FnQVTclefavJ/tavDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BsL1rm0l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 17C582115191; Wed, 11 Jun 2025 07:09:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17C582115191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749650986;
	bh=11QiVZcZI7HpQy9zTwvvYDXhgBE3dYR024Si5/zihXI=;
	h=From:To:Cc:Subject:Date:From;
	b=BsL1rm0lRBhLTVe8xwSQsnjJN3OAptJKwkNoU+LcAPvFp0UQcwr9aE4CbvB+1YfUw
	 5Do84Mgv9/w1ewysOpHypiSiBacjohIaaRGYkzJ1nf3a9183LZAfNgO9K6yJO/idRj
	 gom2c5DcaDfk0JpguLKUABzpU0zcYlTsalbDlgO4=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: 
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
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v6 0/5] Allow dyn MSI-X vector allocation of MANA
Date: Wed, 11 Jun 2025 07:09:44 -0700
Message-Id: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In this patchset we want to enable the MANA driver to be able to
allocate MSI-X vectors in PCI dynamically.

The first patch exports pci_msix_prepare_desc() in PCI to be able to
correctly prepare descriptors for dynamically added MSI-X vectors.

The second patch adds the support of dynamic vector allocation in
pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
flag and using the pci_msix_prepare_desc() exported in first patch.

The third patch adds a detailed description of the irq_setup(), to
help understand the function design better.

The fourth patch is a preparation patch for mana changes to support
dynamic IRQ allocation. It contains changes in irq_setup() to allow
skipping first sibling CPU sets, in case certain IRQs are already
affinitized to them.

The fifth patch has the changes in MANA driver to be able to allocate
MSI-X vectors dynamically. If the support does not exist it defaults to
older behavior.

Since this patchset has patches from PCI and net tree, I am not entirely
sure what should be the target tree. Any suggestions/recommendations on
the same are welcomed.

---
Changes in v6
 * rebased to linux-next's v6.16-rc1 as per Jakub's suggestion
---
Changes in v5
 * Added Yury as Author of the 3rd patch
 * Fixed base commit information in the cover letter
 * Correctly initialized start_irqs, so that it is cleaned properly
 * rearranged the cpu_lock to minimize the critical section
---
 Change in v4
 * add a patch describing the functionality of irq_setup() through a 
   comment
 * In irq_setup(), avoid using a label next_cpumask:
 * modify the changes in MANA patch about restructuring the error
   handling path in mana_gd_setup_dyn_irqs()
 * modify the mana_gd_setup_irqs() to simplify handling around
   start_irq_index
 * add warning if an invalid gic is returned
 * place the xa_destroy() cleanup in mana_gd_remove
---
 Changes in v3
 * split the 3rd patch into preparation patch around irq_setup() and
   changes in mana driver to allow dynamic IRQ allocation
 * Add arm64 support for dynamic MSI-X allocation in pci_hyperv
   controller
---
 Changes in v2
 * split the first patch into two(exporting the preapre_desc
   func and using the function and flag in pci-hyperv)
 * replace 'pci vectors' by 'MSI-X vectors'
 * Change the cover letter description to align with changes made
---

Shradha Gupta (4):
  PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
  PCI: hv: Allow dynamic MSI-X vector allocation
  net: mana: Allow irq_setup() to skip cpus for affinity
  net: mana: Allocate MSI-X vectors dynamically

Yury Norov (1):
  net: mana: explain irq_setup() algorithm

 .../net/ethernet/microsoft/mana/gdma_main.c   | 366 ++++++++++++++----
 drivers/pci/controller/pci-hyperv.c           |   3 +-
 drivers/pci/msi/irqdomain.c                   |   5 +-
 include/linux/msi.h                           |   2 +
 include/net/mana/gdma.h                       |   8 +-
 5 files changed, 294 insertions(+), 90 deletions(-)


base-commit: 19a60293b9925080d97f22f122aca3fc46dadaf9
-- 
2.34.1


