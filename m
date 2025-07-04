Return-Path: <linux-hyperv+bounces-6104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF08AF86E5
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 06:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1397AFBC7
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 04:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295C657C9F;
	Fri,  4 Jul 2025 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H7TOs+Ge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erhRV6Hu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285415C0;
	Fri,  4 Jul 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604492; cv=none; b=hZp3wK+57h9BOan1YonUPu7wkXjONFUOw06C5d40O2nGyFfuftitaH2/HAlDoyXh3dnaZDZM96nR3EU0C55uWJFL2sWwGJTNh4qNhdO7V4J1DDCNwpQ+zrylh1yZh6kaVtHEaTC9I8cnO/Av38yq3XA5iU45P9veYrAzwAjpp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604492; c=relaxed/simple;
	bh=Lu+swMu9xDUD53d1yBMkiV3k5Okchoj2zDAG8R5xdd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L29cUHCxuZYsurcCYafevkfEnnxWnQgbJCQBtnh5spxiW1dAHX2wD742xlUrdQ6MEMGXsSuv85SjFP62R8gTI/N/W/CSeeXGeFkvwXBC0dQzJQRv8lxwPnnCL2Iiz4VrPAJqgy84Vtv80rhWiwwrgmK/JsZrJ3sAALtbwmNGc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H7TOs+Ge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erhRV6Hu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 4 Jul 2025 06:48:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751604488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bECOS5NYSuwI1Z2rPJn8KCgSIK08uaS2HV9/TPfF7qU=;
	b=H7TOs+Ges3ST3JaaZizNd5ma6LU2f7OHMOzRFZkRcC/EoJtnkp0/6c4g/TtJqqbKbJ/4KS
	QjVWOYJVlHQMm/eovn6G3n+y4dZ4vBwvZl2vuY3wAsGy2paB0Fjb1/29yEgsmrRG5cfIEG
	P+gMIFhZpLtX5JgrJZMEF4e5SjTnpjZtd7N+O47OyaRvwyaHxXwDA30rjX0ICURXquy+BE
	RDDcVO+gbUstA6UmN+VtxMcsnFGYDX0v/OKHEwpi/JF0/R3WnO/fH3wAsqS50sCwiIIguR
	KgKJjcZ+mF3nJBkc2ARbAUq9BLcoQuEqh9/6a2oGNdBS0DpteqfKIVSM0tGXZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751604488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bECOS5NYSuwI1Z2rPJn8KCgSIK08uaS2HV9/TPfF7qU=;
	b=erhRV6HukjrjeIx13k7VZwaaZcw+1YyWnPDZ+meuz0LMU8UgdnBEBWg1ifGsa4ZseUMMfD
	tnsVa8uPhZ61rqDQ==
From: Nam Cao <namcao@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Message-ID: <20250704044806.7wtcOlGB@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <20250703172801.GA1934994@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703172801.GA1934994@bhelgaas>

On Thu, Jul 03, 2025 at 12:28:01PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 26, 2025 at 04:47:50PM +0200, Nam Cao wrote:
> > The initial implementation of PCI/MSI interrupt domains in the hierarchical
> > interrupt domain model used a shortcut by providing a global PCI/MSI
> > domain.
> > 
> > This works because the PCI/MSI[X] hardware is standardized and uniform, but
> > it violates the basic design principle of hierarchical interrupt domains:
> > Each hardware block involved in the interrupt delivery chain should have a
> > separate interrupt domain.
> > 
> > For PCI/MSI[X], the interrupt controller is per PCI device and not a global
> > made-up entity.
> > 
> > Unsurprisingly, the shortcut turned out to have downsides as it does not
> > allow dynamic allocation of interrupt vectors after initialization and it
> > prevents supporting IMS on PCI. For further details, see:
> > 
> > https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/
> > 
> > The solution is implementing per device MSI domains, this means the
> > entities which provide global PCI/MSI domain so far have to implement MSI
> > parent domain functionality instead.
> > 
> > This series converts the PCI controller drivers to implement MSI parent
> > domain.
> > 
> >  drivers/pci/Kconfig                           |   1 +
> >  drivers/pci/controller/Kconfig                |  11 +
> >  drivers/pci/controller/dwc/Kconfig            |   1 +
> >  .../pci/controller/dwc/pcie-designware-host.c |  68 ++----
> >  drivers/pci/controller/dwc/pcie-designware.h  |   1 -
> >  drivers/pci/controller/mobiveil/Kconfig       |   1 +
> >  .../controller/mobiveil/pcie-mobiveil-host.c  |  42 ++--
> >  .../pci/controller/mobiveil/pcie-mobiveil.h   |   1 -
> >  drivers/pci/controller/pci-aardvark.c         |  59 ++---
> >  drivers/pci/controller/pci-hyperv.c           |  98 ++++++--
> >  drivers/pci/controller/pcie-altera-msi.c      |  44 ++--
> >  drivers/pci/controller/pcie-brcmstb.c         |  44 ++--
> >  drivers/pci/controller/pcie-iproc-msi.c       |  45 ++--
> >  drivers/pci/controller/pcie-mediatek-gen3.c   |  67 ++---
> >  drivers/pci/controller/pcie-mediatek.c        |  46 ++--
> >  drivers/pci/controller/pcie-rcar-host.c       |  69 ++----
> >  drivers/pci/controller/pcie-xilinx-dma-pl.c   |  48 ++--
> >  drivers/pci/controller/pcie-xilinx-nwl.c      |  45 ++--
> >  drivers/pci/controller/pcie-xilinx.c          |  55 +++--
> >  drivers/pci/controller/plda/Kconfig           |   1 +
> >  drivers/pci/controller/plda/pcie-plda-host.c  |  44 ++--
> >  drivers/pci/controller/plda/pcie-plda.h       |   1 -
> >  drivers/pci/controller/vmd.c                  | 229 +++++++++---------
> >  23 files changed, 504 insertions(+), 517 deletions(-)
> 
> Looks good to me, thanks!  I think Mani will probably pick this up.
> 
> I might have included the specific "legacy MSI domain" thing you're
> replacing.  It looks like you're replacing pci_msi_create_irq_domain()
> with msi_create_parent_irq_domain()?

Yes, pci_msi_create_irq_domain() is legacy. We will delete it once
everything is converted.

> Minor merge conflict in pcie-mediatek-gen3.c with dcbea1c7e94e ("PCI:
> mediatek-gen3: Use dev_fwnode() for irq_domain_create_linear()").  No
> problem, we can easily fix that up.

Thanks!

> The "++i" in vmd.c stuck out to me since "i++" is so much more common.

I always do "++i", maybe I'm the weird one..

Best regards,
Nam

