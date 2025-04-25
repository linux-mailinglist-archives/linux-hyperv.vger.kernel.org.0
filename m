Return-Path: <linux-hyperv+bounces-5133-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F0A9C63B
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 12:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D3D7A46F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF5823BD02;
	Fri, 25 Apr 2025 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LZ4v2MaN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337C1FC7E7;
	Fri, 25 Apr 2025 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578422; cv=none; b=ZbwLZO6He1D+PMz7vqUNb8dzGszA0VNdnS2z1nLeqhe+iS8qsaUAPoJzVESMSU9bcVG8Rt7pmlTQaAjV99qk1Jmag3QZ3tY6iLbbAH1jVchjkFuVt9Ql47iP9nNFobtCEu08GtEgi7wSPd3/lZvx/Fmtx+aGkXzdQ8i1GCBnbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578422; c=relaxed/simple;
	bh=NRp1Wwb8++Zq8JCpLVO0QHfPKJCp21x2gI1rE46sM0I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ury0Rs0Xcc08kUE7fKMsO7CpPXBBRqQnY2HymUv3T2lc5hlPZvtdI9RCjzXFKxmSJTK3XQ4P3VpFltYs7w3tgmThdTRmggKiggOYmYnG7eKviO1d219rGfhlEEIHQD4+Cg9PGjgNwePX0Gq94tODe/AgfykpWWM81W4PKdc1ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LZ4v2MaN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 11BE22020955; Fri, 25 Apr 2025 03:53:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11BE22020955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745578420;
	bh=6MdeNB2xGOsgrbx2ovicJ6zNGUSw10EtPHw5GeW5Lsk=;
	h=From:To:Cc:Subject:Date:From;
	b=LZ4v2MaNTzQlvPC0J/PMDUUfiBJR3CROViWfTn2K9zUP7M0PPdWYET2GJQRHCnNLc
	 juqpVT5pN5fHJYrLA35YdL9vWHOuBI8IMrVztSz0FkgDbSFvxNXahsd1Abq0kPz+hd
	 j3p1zDyKpJqj9ilzo+FpLUNr/5W4x9YsXa/o9KnA=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
	Paul Rosswurm <paulros@microsoft.com>
Cc: Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v2 0/3] Allow dyn MSI-X vector allocation of MANA
Date: Fri, 25 Apr 2025 03:53:27 -0700
Message-Id: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
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

The third patch has the changes in MANA driver to be able to allocate
MSI-X vectors dynamically if it is supported by the infra. If the
support does not exist it defaults to older behavior.

---
 Changes in v2
 * split the first patch into two(exporting the preapre_desc
   func and using the function and flag in pci-hyperv)
 * replace 'pci vectors' by 'MSI-X vectors'
 * Change the cover letter description to align with changes made
---

Shradha Gupta (3):
  PCI: Export pci_msix_prepare_desc() for dynamic MSI-X alloc
  PCI: hv: Allow dynamic MSI-X vector allocation
  net: mana: Allocate MSI-X vectors dynamically as required

 .../net/ethernet/microsoft/mana/gdma_main.c   | 323 ++++++++++++++----
 drivers/pci/controller/pci-hyperv.c           |   7 +-
 drivers/pci/msi/irqdomain.c                   |   5 +-
 include/linux/msi.h                           |   2 +
 include/net/mana/gdma.h                       |  11 +-
 5 files changed, 279 insertions(+), 69 deletions(-)

-- 
2.34.1


