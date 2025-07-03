Return-Path: <linux-hyperv+bounces-6087-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0840AF7ED8
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE03B7EE0
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5B28A725;
	Thu,  3 Jul 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5ZftxTx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F928A707;
	Thu,  3 Jul 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563683; cv=none; b=OBhw60c+fGe2F0NnP+Kd6hu3DE6bfONyV9TuFDtah8KivbbQVMWnwivw1UIuQSRDBw6B4K75086xVGV9ueEWFgN2IJxMxeum7Wv3/hXF7Dly9o+aZNm6q1s+Y1z0qgrS52lJXDjBtcQD6Tz4lCSouFpWM3NbHQPM+o3OItCjhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563683; c=relaxed/simple;
	bh=7DItQyd/iDiXcaQ1oEjOGACHtzfWw4WzefkYn8OTkwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hnYtamYZ6Rom7VXsv5WnDz0aO7USCzhCLuy9BVHiNYsfezZnmKPRzRZYWzohmcVWylLtANiXHgBTNUjr3UzVrvUH6QnvPvV25W9EKu9RI2fC9UtVYPTP6qHU0Ei3t0b8n8pW7WlfWcbeieBfoc0bFrjaHu681/4dYkq8Z2c0vFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5ZftxTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D73C4CEE3;
	Thu,  3 Jul 2025 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751563683;
	bh=7DItQyd/iDiXcaQ1oEjOGACHtzfWw4WzefkYn8OTkwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H5ZftxTxWMfwxHZ+Pz3upY30k01iBoXdImqR+W/HMOoyYzD3f9V7nCF4lK/kiNDZk
	 Iv/a4u5MSqT8IyVdWMKt/77YNztWhnMVkI9jWlOVKXqlAoxQpMObMsOsZNgt3mrBzd
	 azBm0mh/xpH1TaR6W097mqBwLGUYZw+hfLFuqmy0dHTsMlEx3NfczGuOn3DQJBYmTs
	 rmwl0RQjoupydZDcb1P37q76NVU3kFSi5kZwkrCDNvz1ducn1Tc2kKbXh0JmDQBSVI
	 hQjavWGtQqoz8VzpB9ZusWsjtax/P5fIQ0C+xaskpPdNwILfdXtRyVYmu4AXYp6DXJ
	 eN5ZOW0iYQJgA==
Date: Thu, 3 Jul 2025 12:28:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
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
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 00/16] PCI: MSI parent domain conversion
Message-ID: <20250703172801.GA1934994@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750858083.git.namcao@linutronix.de>

On Thu, Jun 26, 2025 at 04:47:50PM +0200, Nam Cao wrote:
> The initial implementation of PCI/MSI interrupt domains in the hierarchical
> interrupt domain model used a shortcut by providing a global PCI/MSI
> domain.
> 
> This works because the PCI/MSI[X] hardware is standardized and uniform, but
> it violates the basic design principle of hierarchical interrupt domains:
> Each hardware block involved in the interrupt delivery chain should have a
> separate interrupt domain.
> 
> For PCI/MSI[X], the interrupt controller is per PCI device and not a global
> made-up entity.
> 
> Unsurprisingly, the shortcut turned out to have downsides as it does not
> allow dynamic allocation of interrupt vectors after initialization and it
> prevents supporting IMS on PCI. For further details, see:
> 
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/
> 
> The solution is implementing per device MSI domains, this means the
> entities which provide global PCI/MSI domain so far have to implement MSI
> parent domain functionality instead.
> 
> This series converts the PCI controller drivers to implement MSI parent
> domain.
> 
>  drivers/pci/Kconfig                           |   1 +
>  drivers/pci/controller/Kconfig                |  11 +
>  drivers/pci/controller/dwc/Kconfig            |   1 +
>  .../pci/controller/dwc/pcie-designware-host.c |  68 ++----
>  drivers/pci/controller/dwc/pcie-designware.h  |   1 -
>  drivers/pci/controller/mobiveil/Kconfig       |   1 +
>  .../controller/mobiveil/pcie-mobiveil-host.c  |  42 ++--
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |   1 -
>  drivers/pci/controller/pci-aardvark.c         |  59 ++---
>  drivers/pci/controller/pci-hyperv.c           |  98 ++++++--
>  drivers/pci/controller/pcie-altera-msi.c      |  44 ++--
>  drivers/pci/controller/pcie-brcmstb.c         |  44 ++--
>  drivers/pci/controller/pcie-iproc-msi.c       |  45 ++--
>  drivers/pci/controller/pcie-mediatek-gen3.c   |  67 ++---
>  drivers/pci/controller/pcie-mediatek.c        |  46 ++--
>  drivers/pci/controller/pcie-rcar-host.c       |  69 ++----
>  drivers/pci/controller/pcie-xilinx-dma-pl.c   |  48 ++--
>  drivers/pci/controller/pcie-xilinx-nwl.c      |  45 ++--
>  drivers/pci/controller/pcie-xilinx.c          |  55 +++--
>  drivers/pci/controller/plda/Kconfig           |   1 +
>  drivers/pci/controller/plda/pcie-plda-host.c  |  44 ++--
>  drivers/pci/controller/plda/pcie-plda.h       |   1 -
>  drivers/pci/controller/vmd.c                  | 229 +++++++++---------
>  23 files changed, 504 insertions(+), 517 deletions(-)

Looks good to me, thanks!  I think Mani will probably pick this up.

I might have included the specific "legacy MSI domain" thing you're
replacing.  It looks like you're replacing pci_msi_create_irq_domain()
with msi_create_parent_irq_domain()?

Minor merge conflict in pcie-mediatek-gen3.c with dcbea1c7e94e ("PCI:
mediatek-gen3: Use dev_fwnode() for irq_domain_create_linear()").  No
problem, we can easily fix that up.

The "++i" in vmd.c stuck out to me since "i++" is so much more common.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

