Return-Path: <linux-hyperv+bounces-5440-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D6AB1011
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 12:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE029E7E10
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4AF28EA72;
	Fri,  9 May 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uhvy36Lo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63FC28DF5C;
	Fri,  9 May 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785571; cv=none; b=b/k1vgo8kjjvmeZ7ByzULfhdPka0HKeprzJPnct8BYTLQQ7gPiD1as2Ri9RiBMJGG7kgabhGA6ypDoDRFmKCSPpTDv4xzLZlkSWSKDsPzrlc2P5Q1WLfYTcyEghl2+zkeTnsJh3NtDOyKj4J2k0qpArwu5Te5f3IIlQ8/Dfri70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785571; c=relaxed/simple;
	bh=M0yJLi3YltfIlr+h+JY5iRrqytF1C8+FeHZfC+leV/8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=chF0aD8DwxRudho0S8vJ4iB+omO3dpnJV6AwfZWOpldd92knBE68pTN92xmA1PAehjkMtgKyXo8WMkv9GqIqU10ismXJv8ODDBcIUISENt3sqUg1oga3fgJpOi1CGGJ7fVVc+eWF/HHps6ZUaBpIxu02URf4QQExGqXwYuT/ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uhvy36Lo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 1C4AF2098462; Fri,  9 May 2025 03:12:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C4AF2098462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746785569;
	bh=e/tm+t3vcAkUXIvSagvF7PotT61S98sNQtc1m6Q+83g=;
	h=From:To:Cc:Subject:Date:From;
	b=Uhvy36Lowt7migeLLbpUOqA5gwxEeVXpC6AqBqo3BVEP4Wat/qlwAK1nXZnIIoXR0
	 u6+DwI4ljiKEOOv1Q/4fvRv7i29zPARyW6z+WtfIwjtpiKgEf3aFEa8ZmVtVVd3oBS
	 8o8gOMydUHgKVsz6Q4oHrx7ewqn3XgGbvs/mM/CU=
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
Subject: [PATCH v3 0/4] Allow dyn MSI-X vector allocation of MANA
Date: Fri,  9 May 2025 03:12:46 -0700
Message-Id: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In this patchset we want to enable the MANA driver to be able to
allocate MSI-X vectors in PCI dynamically

The first patch exports pci_msix_prepare_desc() in PCI to be able to
correctly prepare descriptors for dynamically added MSI-X vectors

The second patch adds the support of dynamic vector allocation in
pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
flag and using the pci_msix_prepare_desc() exported in first patch.

The third patch is a preparation patch for mana changes to support
dynamic IRQ allocation. It contains changes in irq_setup() to allow
skipping first sibling CPU sets, in case certain IRQs are already
affinitized to them.

The fourth patch has the changes in MANA driver to be able to allocate
MSI-X vectors dynamically. If the support does not exist it defaults to
older behavior.

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
  PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X alloc
  PCI: hv: Allow dynamic MSI-X vector allocation
  net: mana: Allow irq_setup() to skip cpus for affinity
  net: mana: Allocate MSI-X vectors dynamically

 .../net/ethernet/microsoft/mana/gdma_main.c   | 264 +++++++++++++++---
 drivers/pci/controller/pci-hyperv.c           |   7 +-
 drivers/pci/msi/irqdomain.c                   |   5 +-
 include/linux/msi.h                           |   2 +
 include/net/mana/gdma.h                       |   8 +-
 5 files changed, 235 insertions(+), 51 deletions(-)

-- 
2.34.1


