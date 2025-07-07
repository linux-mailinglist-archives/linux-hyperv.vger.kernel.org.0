Return-Path: <linux-hyperv+bounces-6122-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4BAFABC5
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 08:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A735F17C51B
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 06:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25493279792;
	Mon,  7 Jul 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+QSi6mV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79282586EA;
	Mon,  7 Jul 2025 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869244; cv=none; b=I7rIjQTD0KurgshK1vAUBK1jaGainpYazmzglkVQ8wZBY7RmvjY3kp0Ka+IeSVcTrXapOLcTHgajET/XliUvAgUYa5EjdkIdYbZ8e9L8MG4VDDSdLga8aj0B8jqqyye4trnRgQFgbKVkuK21NexpsPR/Co/0iwlnEpJSbEIUATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869244; c=relaxed/simple;
	bh=IJAq2PfQObnW6djmQ2Dn7nC/QiKTJAuTfPAiQ+HmqUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo2ngWJpp7KT7NzbZGIdESv9YHv/sODFnST6sEWaN5Y0bGl5qfipmWPoOzpRx4it5R9dX/Qa4WRo6Kqfov3ma3wC7TmtDZKkeOKudlMCfTlQjamqkrhgVs8mbP64XMJ2OfoVGR067tQIxo6lTHep6MpzY04go5ry8LtVeSQLdp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+QSi6mV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EACC4CEE3;
	Mon,  7 Jul 2025 06:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751869243;
	bh=IJAq2PfQObnW6djmQ2Dn7nC/QiKTJAuTfPAiQ+HmqUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+QSi6mVE3+RjRIFYSr3Hg8Nz4FOiR65HQCzs89hgfLQp5zI5mS5pqQ+LBmW/lPaB
	 wlFGeFGAjxEzQt47UFAYMGyh/x1rEHYE9mxhxtod5uKBJ7Sdm3deCFEAFcBBUGk/Ti
	 kVl2yFB6eVRNxouJnOtBXZwB8E64GEMx96or66Os2jTNeMMZqVYQldoX2b2JqCKRtf
	 x2ntWAzxFhSPFundBgQWzekNuyzjlNlr9nFIx1cZZug/vvJ6yAlSTyvZ3kwwlduI60
	 IV3BlW6x4Zv1m5d+GZZjJR42JOmzSHlGu4X2wCEIstFcpNtOHlnncPDkDAfkEgLXR9
	 bs8y6hmZ97f+g==
Date: Mon, 7 Jul 2025 11:50:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
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
Message-ID: <etrzv5627z5k4i2fbhkoqsmegukm7f6zbxunazipkokyctlfpd@epewaygdyxkq>
References: <cover.1750858083.git.namcao@linutronix.de>
 <20250703172801.GA1934994@bhelgaas>
 <20250704044806.7wtcOlGB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704044806.7wtcOlGB@linutronix.de>

On Fri, Jul 04, 2025 at 06:48:06AM GMT, Nam Cao wrote:
> On Thu, Jul 03, 2025 at 12:28:01PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 26, 2025 at 04:47:50PM +0200, Nam Cao wrote:
> > > The initial implementation of PCI/MSI interrupt domains in the hierarchical
> > > interrupt domain model used a shortcut by providing a global PCI/MSI
> > > domain.
> > > 
> > > This works because the PCI/MSI[X] hardware is standardized and uniform, but
> > > it violates the basic design principle of hierarchical interrupt domains:
> > > Each hardware block involved in the interrupt delivery chain should have a
> > > separate interrupt domain.
> > > 
> > > For PCI/MSI[X], the interrupt controller is per PCI device and not a global
> > > made-up entity.
> > > 
> > > Unsurprisingly, the shortcut turned out to have downsides as it does not
> > > allow dynamic allocation of interrupt vectors after initialization and it
> > > prevents supporting IMS on PCI. For further details, see:
> > > 
> > > https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/
> > > 
> > > The solution is implementing per device MSI domains, this means the
> > > entities which provide global PCI/MSI domain so far have to implement MSI
> > > parent domain functionality instead.
> > > 
> > > This series converts the PCI controller drivers to implement MSI parent
> > > domain.
> > > 
> > >  drivers/pci/Kconfig                           |   1 +
> > >  drivers/pci/controller/Kconfig                |  11 +
> > >  drivers/pci/controller/dwc/Kconfig            |   1 +
> > >  .../pci/controller/dwc/pcie-designware-host.c |  68 ++----
> > >  drivers/pci/controller/dwc/pcie-designware.h  |   1 -
> > >  drivers/pci/controller/mobiveil/Kconfig       |   1 +
> > >  .../controller/mobiveil/pcie-mobiveil-host.c  |  42 ++--
> > >  .../pci/controller/mobiveil/pcie-mobiveil.h   |   1 -
> > >  drivers/pci/controller/pci-aardvark.c         |  59 ++---
> > >  drivers/pci/controller/pci-hyperv.c           |  98 ++++++--
> > >  drivers/pci/controller/pcie-altera-msi.c      |  44 ++--
> > >  drivers/pci/controller/pcie-brcmstb.c         |  44 ++--
> > >  drivers/pci/controller/pcie-iproc-msi.c       |  45 ++--
> > >  drivers/pci/controller/pcie-mediatek-gen3.c   |  67 ++---
> > >  drivers/pci/controller/pcie-mediatek.c        |  46 ++--
> > >  drivers/pci/controller/pcie-rcar-host.c       |  69 ++----
> > >  drivers/pci/controller/pcie-xilinx-dma-pl.c   |  48 ++--
> > >  drivers/pci/controller/pcie-xilinx-nwl.c      |  45 ++--
> > >  drivers/pci/controller/pcie-xilinx.c          |  55 +++--
> > >  drivers/pci/controller/plda/Kconfig           |   1 +
> > >  drivers/pci/controller/plda/pcie-plda-host.c  |  44 ++--
> > >  drivers/pci/controller/plda/pcie-plda.h       |   1 -
> > >  drivers/pci/controller/vmd.c                  | 229 +++++++++---------
> > >  23 files changed, 504 insertions(+), 517 deletions(-)
> > 
> > Looks good to me, thanks!  I think Mani will probably pick this up.
> > 
> > I might have included the specific "legacy MSI domain" thing you're
> > replacing.  It looks like you're replacing pci_msi_create_irq_domain()
> > with msi_create_parent_irq_domain()?
> 
> Yes, pci_msi_create_irq_domain() is legacy. We will delete it once
> everything is converted.
> 

I'll amend the commit message to include pci_msi_create_irq_domain().

> > Minor merge conflict in pcie-mediatek-gen3.c with dcbea1c7e94e ("PCI:
> > mediatek-gen3: Use dev_fwnode() for irq_domain_create_linear()").  No
> > problem, we can easily fix that up.
> 
> Thanks!
> 
> > The "++i" in vmd.c stuck out to me since "i++" is so much more common.
> 
> I always do "++i", maybe I'm the weird one..
> 

Just for the sake of uniformity, I'll do 's/++i/i++' while applying.

And based on the discussion on patch 14/16, I'll drop it to be applied through
netdev and apply the rest of the series through PCI tree.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

