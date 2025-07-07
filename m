Return-Path: <linux-hyperv+bounces-6123-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6323FAFAD75
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE918162D5A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612121FF5C;
	Mon,  7 Jul 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQwE1vX/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245013A3F7;
	Mon,  7 Jul 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874253; cv=none; b=HudFdaNrVw93y90C0+/HQzqxFe0X5N6QwDiRVGhyPn3zNKMzOjxJAPpP2d0Ot3nrr4oU4O707/NHZfICABNF7w75RLDpHq+kkq2TJIl1oRdtkCFcVPi1Sc8a63Nms8HQt5rDBPIdiVFK+p+gKWC/puJdFgEjeQQprwuBRtUZCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874253; c=relaxed/simple;
	bh=/jD354R592s4zJMZWD0+ePhWTUfRC108q7YO8NMu23U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHfzpuBb/TUqzHxoYBxLfhupnw59OQseb5lPjxYHeMdVIEct/0Br+GbBoMKCI1QPe6WIxlG6LuxMkxdGkJDkMaKQsnKUt4u86TNoPBwUCC06lCatFYoTJ9ueA3UYr8gaIobj/mfB+8zgR9QPY3Xyrpix8P3y41z3ODVG4g83MT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQwE1vX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05302C4CEE3;
	Mon,  7 Jul 2025 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751874253;
	bh=/jD354R592s4zJMZWD0+ePhWTUfRC108q7YO8NMu23U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQwE1vX/yXNQiTs0tbmqSybnQiotd/y2C054/icFvOPoTd/5CYEyCj/rNejwoLLg8
	 Wo7F3vCp2rjnfLbqI5rlb2kmjuOp1AZK+41hek1e/EokISgDLMYScJ1e8dY8dL6SF6
	 qHa42qLz8g1OahyZjW91CYPx2KTc83LjTClaojuVRIaaDOMCGD5w3FcNc+YZyenALM
	 XLO1gBN6b5LU/hLRqWOb/iyqOnOOhTDijfAuZbR8lQLgaFUZy3ZxUfN6klJ29K1XUe
	 B/Z7yJ1NABIxdnpYMxJ/0g05uE0aPdkmfB9rx71B6nuIS7Z2S0XZ0taQ+pTLBiwTD2
	 Em3J3a8sKeZ9w==
Date: Mon, 7 Jul 2025 13:13:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Michal Simek <michal.simek@amd.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 00/16] PCI: MSI parent domain conversion
Message-ID: <zkjevl46rosm276lirw5vzdhogeug4cpjnvhcgkcwzxm4s4rfj@gcxaexfotlsr>
References: <cover.1750858083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1750858083.git.namcao@linutronix.de>

On Thu, Jun 26, 2025 at 04:47:50PM GMT, Nam Cao wrote:
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

Applied the series except patch 14/16 to pci/controller/msi-parent, thanks!

- Mani

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
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

