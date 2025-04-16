Return-Path: <linux-hyperv+bounces-4941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA504A907D0
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060C74476EA
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDC1F8676;
	Wed, 16 Apr 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jtGNqh76"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60376189902;
	Wed, 16 Apr 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817757; cv=none; b=Th99U2ezDpkov50QUjRBo/TapyCC/oi+nk+iuoa4B4BjKhhnHQSgMMEvAm0il4EAGnf+fiGed/Ds7WuOyzhr0CTU2a0EUyIJRj8P5cLIiTzuXTgs1pnzBXoxWKg7+dKe29AVjGHGege1/qSmO8+ZFWWepHRlnobXvSO8F/8otVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817757; c=relaxed/simple;
	bh=JuEVssO1nsnSG71fT+jjxB8w61QctSPWv+X+S7oa01A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VHifu5FZpZyGqNfc+QRDMXBpFiBA/rYEVfE3WJsvOpO72hWaDYWYBCM1zfF2+ybu7IXiK5Xpp2ZUwQi9pjAUvQBC14Xw7yh8tMZyQArNkKdzZrXjBA6awvWJeIrTFJq20u9hS7Lv0GEx7FtYQbYsXRYRkVcTCsS9sOmtDBkohg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jtGNqh76; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 7C07E2052505; Wed, 16 Apr 2025 08:35:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C07E2052505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744817750;
	bh=lPCxQ8v6UmwaVy+HeTlmUTdMwGvPgruYycjzZSiroFo=;
	h=From:To:Cc:Subject:Date:From;
	b=jtGNqh76jbdSDUmZ8slcNzOY2TbqEd6MhszwTr0tAOYaj+3Sq6sPO39UGkKUTEQ9h
	 uAT+pPIRxFbBttcytPj5ZHNxE1tmmtaKDAMtdGTvYXlYNfzgjSRPpqveWV750U+RPE
	 /PutSWbwwQQ5ZJvGqs/ONqYnXZKO+8ecih6ZLZ2g=
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
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
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
Subject: [PATCH 0/2] Allow dyn pci vector allocation of MANA
Date: Wed, 16 Apr 2025 08:35:47 -0700
Message-Id: <1744817747-2920-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In this patchset we want to enable the MANA driver to be able to
allocate MSI vectors in PCI dynamically

The first patch targets the changes required for enabling the support
of dyn vector allocation in pci-hyperv PCI controller. It also consists
of changes in the PCI tree to allow clean support for dynamic allocation
of IRQ vectors for PCI controllers.

The second patch has the changes in MANA driver to be able to allocate
pci vectors dynamically if it is supported by the infra. If the support
does not exist it defaults to older behavior.

For this submission, I wasn't sure if we should specify net-next or pci
tree. Please let me know what the recommendation is.

Shradha Gupta (2):
  PCI: hv: enable pci_hyperv to allow dynamic vector allocation
  net: mana: Allow MANA driver to allocate PCI vector dynamically

 .../net/ethernet/microsoft/mana/gdma_main.c   | 306 ++++++++++++++----
 drivers/pci/controller/pci-hyperv.c           |   7 +-
 drivers/pci/msi/irqdomain.c                   |   5 +-
 include/linux/msi.h                           |   2 +
 include/net/mana/gdma.h                       |   5 +-
 5 files changed, 260 insertions(+), 65 deletions(-)

-- 
2.34.1


