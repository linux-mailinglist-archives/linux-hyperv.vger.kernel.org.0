Return-Path: <linux-hyperv+bounces-5668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F06AC526E
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FC91BA2734
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389E27C17E;
	Tue, 27 May 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UlzknXOq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACFE17C211;
	Tue, 27 May 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361458; cv=none; b=GF2KmrpsLd46YWqo/zlnUYDOM06QXkSrLJDqtpkUwog+YYgrdRX33Y1S5Z9XUpIJ/+qZ/NBtvdSWL3JtGu1Kn3sZlvq2R4Epo3uRnrjLqkiNYFqpVLvGy4ss2nYSw3Tgwd6SNoGOQGdKGxLNR++V7WsRW3nhMU8f+oYZj7eB2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361458; c=relaxed/simple;
	bh=Q0upW2MgUAlLSl7j1DYmGhG7iF+PDf28Zfc2BqZQyKY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BGmSMxWS5v4fxr/6CPuIbWdCHCTkG/RUjdfvxm7ekBLaTRn+HBQomK13BEywXyLI/6TirVcy0Y1eDh1Z8fkklKuJvdf0FX6b/y7DzNOuwNgZQYqtvbCTH1uWXFldIj7Cb8nny56+otGdaQnDIgNhFs7PGlcqE6u2n0jgCUIQ1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UlzknXOq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E5D8A206B777; Tue, 27 May 2025 08:57:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5D8A206B777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748361455;
	bh=JH1E9Bklt4LVBdscDmCNneQkD0i97h9Q61pIEzzDQhY=;
	h=From:To:Cc:Subject:Date:From;
	b=UlzknXOqRG7NQgSHOJgt8ZTtGtcR+GKwQITawsfWJDPB6f9OcsExOlYxs6tUG22hm
	 m19qBZS3e3f+4fppKD5ePhMrYCr4Dern3Tjw4ztcFAYVLUUz/yVl7sBV4mdb+OulMs
	 xK4EHtz81dsfKvHDF98MfdCYS+U7QTWePxBB9a0Y=
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
Subject: [PATCH v4 0/5] Allow dyn MSI-X vector allocation of MANA
Date: Tue, 27 May 2025 08:57:33 -0700
Message-Id: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
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

Shradha Gupta (5):
  PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
  PCI: hv: Allow dynamic MSI-X vector allocation
  net: mana: explain irq_setup() algorithm
  net: mana: Allow irq_setup() to skip cpus for affinity
  net: mana: Allocate MSI-X vectors dynamically

 .../net/ethernet/microsoft/mana/gdma_main.c   | 356 ++++++++++++++----
 drivers/pci/controller/pci-hyperv.c           |   5 +-
 drivers/pci/msi/irqdomain.c                   |   5 +-
 include/linux/msi.h                           |   2 +
 include/net/mana/gdma.h                       |   8 +-
 5 files changed, 293 insertions(+), 83 deletions(-)

-- 
2.34.1


