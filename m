Return-Path: <linux-hyperv+bounces-6006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94104AEA160
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7463AF9A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1F2EB5AB;
	Thu, 26 Jun 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gaz8seox";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Fd2QlwC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34364289E2D;
	Thu, 26 Jun 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949319; cv=none; b=ZRO/i497b0OQw8Yqyv8Sqi7yfmEfuscA+YcIO2wedEFaRTfDgebJ8S3FEm0GUybhgG2KPmLst1XP2Az06zJwph3u04HG8+dna7lQMoaTxcZG2fDYlDFSxWYaAXY56DUlHXbgjv8cpkrVTIJTbfjDyZ+MA7Zjk/U3adWmhE5NUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949319; c=relaxed/simple;
	bh=Q6UqfwCyC3mZxxR1Ap+fUonqEOHiafoq86ph9bdqlzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dSJjbzpEVvMMQPx9mrn3v9ZIm3SAH+yNLCEGeGiRoiRTorCjw981Fd3kgjbrtYyQ0UFu6T2U+1r2MGkijLWH/6LRrdXbgAg/5aVWclg1Nhh4Hrk3vZegtXUO4QGo8Uyca88JlfKMNEpAsZT2MaPSc31KSY41Vn6nPmg5tRrynIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gaz8seox; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Fd2QlwC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rjC7u1O4n6Y4m8ek4mHKb90DC8/HUd+eWzj/alvKcAs=;
	b=gaz8seoxSEVBxG9MHSd/AdwK73Yt7mu+jsV0LollTAaxssib7A4849xAQcipwOrC0G9Uo6
	tfcpM3NA0RSjqxu0umLrggdwkuZprE9ZwTlt2NmwRBzYiIZCm08nVH+UnkZ0EnbA6P62GY
	EMXRpjYh17PCc/lq+dgoXu5/F1jNr1dlYdgHPUeTsmGcnf9w4zD+DE7HpX4cEjGptshy/p
	w4PI4JWiylFe9B7TBc5EvKJT8Mtcd9gghG+JfYB2lLP/7I3Z8AFNN3FHXBd1vOClFpd9Jf
	R/pJjIJu3RZtZRM+rgdUOc/gAlcAwUivOqN82fssj7UtXrwKa2IhcAQj3EH/0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rjC7u1O4n6Y4m8ek4mHKb90DC8/HUd+eWzj/alvKcAs=;
	b=2Fd2QlwCInXViIVIZOCcuzIq4mcR7BYBUaVg4a+xf1NiSgmL30ly5tfX4sxMHPRjXMMy7w
	sdMGjflSZJvHVtAQ==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 00/16] PCI: MSI parent domain conversion
Date: Thu, 26 Jun 2025 16:47:50 +0200
Message-Id: <cover.1750858083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The initial implementation of PCI/MSI interrupt domains in the hierarchical
interrupt domain model used a shortcut by providing a global PCI/MSI
domain.

This works because the PCI/MSI[X] hardware is standardized and uniform, but
it violates the basic design principle of hierarchical interrupt domains:
Each hardware block involved in the interrupt delivery chain should have a
separate interrupt domain.

For PCI/MSI[X], the interrupt controller is per PCI device and not a global
made-up entity.

Unsurprisingly, the shortcut turned out to have downsides as it does not
allow dynamic allocation of interrupt vectors after initialization and it
prevents supporting IMS on PCI. For further details, see:

https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/

The solution is implementing per device MSI domains, this means the
entities which provide global PCI/MSI domain so far have to implement MSI
parent domain functionality instead.

This series converts the PCI controller drivers to implement MSI parent
domain.

 drivers/pci/Kconfig                           |   1 +
 drivers/pci/controller/Kconfig                |  11 +
 drivers/pci/controller/dwc/Kconfig            |   1 +
 .../pci/controller/dwc/pcie-designware-host.c |  68 ++----
 drivers/pci/controller/dwc/pcie-designware.h  |   1 -
 drivers/pci/controller/mobiveil/Kconfig       |   1 +
 .../controller/mobiveil/pcie-mobiveil-host.c  |  42 ++--
 .../pci/controller/mobiveil/pcie-mobiveil.h   |   1 -
 drivers/pci/controller/pci-aardvark.c         |  59 ++---
 drivers/pci/controller/pci-hyperv.c           |  98 ++++++--
 drivers/pci/controller/pcie-altera-msi.c      |  44 ++--
 drivers/pci/controller/pcie-brcmstb.c         |  44 ++--
 drivers/pci/controller/pcie-iproc-msi.c       |  45 ++--
 drivers/pci/controller/pcie-mediatek-gen3.c   |  67 ++---
 drivers/pci/controller/pcie-mediatek.c        |  46 ++--
 drivers/pci/controller/pcie-rcar-host.c       |  69 ++----
 drivers/pci/controller/pcie-xilinx-dma-pl.c   |  48 ++--
 drivers/pci/controller/pcie-xilinx-nwl.c      |  45 ++--
 drivers/pci/controller/pcie-xilinx.c          |  55 +++--
 drivers/pci/controller/plda/Kconfig           |   1 +
 drivers/pci/controller/plda/pcie-plda-host.c  |  44 ++--
 drivers/pci/controller/plda/pcie-plda.h       |   1 -
 drivers/pci/controller/vmd.c                  | 229 +++++++++---------
 23 files changed, 504 insertions(+), 517 deletions(-)

--=20
2.39.5


