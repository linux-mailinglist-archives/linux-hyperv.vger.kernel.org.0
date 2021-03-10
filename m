Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698443347F5
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Mar 2021 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhCJTaI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Mar 2021 14:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233342AbhCJTaA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Mar 2021 14:30:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FA3F64EF6;
        Wed, 10 Mar 2021 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615404600;
        bh=e2Z2DQoJIeiblci+Xk9crwWl1In7MRqs54LMBzkItlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OnEKcfxiVfKnmrYB3LuZNSCzCJ5RObqvWa5z7S7UYzXT41zckhszQZK3URD5ZROrS
         mr/AK9os9EhYoQ7PyJyRNqsjKNmTWZueZLoSXevk8tn+f21HuOQRWzC1bNzJKdX9nD
         xlDbOAIJD6HeE8dQ1olV1H+X8urrhTauCwhKyfJV7cp/WWE5k1qMKvLUm08+e568+c
         +Yu/chwpdBMmupaC0y+yM2u2jEZuFDM8RVe1Z32xuNAghxpQwKdrVXV5hygXNaa3yy
         Xxq3HE2lNWKLQJ0FBFojwrg61Orlx6meI5fCKFT2m5ULbr+j0awHh8vAGTAKVnTtuB
         brXStsZQ/nJvQ==
Date:   Wed, 10 Mar 2021 13:29:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 00/13] PCI: MSI: Getting rid of msi_controller, and other
 cleanups
Message-ID: <20210310192958.GA2032926@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225151023.3642391-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 25, 2021 at 03:10:10PM +0000, Marc Zyngier wrote:
> The msi_controller data structure was the first attempt at treating
> MSIs like any other interrupt. We replaced it a few years ago with the
> generic MSI framework, but as it turns out, some older drivers are
> still using it.
> 
> This series aims at converting these stragglers, drop msi_controller,
> and fix some other nits such as having ways for a host bridge to
> advertise whether it supports MSIs or not.
> 
> A few notes:
> 
> - The Tegra patch is the result of back and forth work with Thierry: I
>   wrote the initial patch, which didn't work (I didn't have any HW at
>   the time). Thierry made it work, and I subsequently fixed a couple
>   of bugs/cleanups. I'm responsible for the result, so don't blame
>   Thierry for any of it! FWIW, I'm now running a Jetson TX2 with its
>   root fs over NVME, and MSIs are OK.
> 
> - RCAR is totally untested, though Marek had a go at a previous
>   version. More testing required.
> 
> - The xilinx stuff is *really* untested. Paul, if you have a RISC-V
>   board that uses it, could you please give it a go? Michal, same
>   thing for the stuff you have at hand...
> 
> - hyperv: I don't have access to such hypervisor, and no way to test
>   it. Help welcomed.
> 
> - The patches dealing with the advertising of MSI handling are the
>   result of a long discussion that took place here[1]. I took the
>   liberty to rejig Thomas' initial patches, and add what I needed for
>   the MSI domain stuff. Again, blame me if something is wrong, and not
>   Thomas.
> 
> Feedback welcome.
> 
> 	M.
> 
> [1] https://lore.kernel.org/r/20201031140330.83768-1-linux@fw-web.de
> 
> Marc Zyngier (11):
>   PCI: tegra: Convert to MSI domains
>   PCI: rcar: Convert to MSI domains
>   PCI: xilinx: Convert to MSI domains
>   PCI: hyperv: Drop msi_controller structure
>   PCI: MSI: Drop use of msi_controller from core code
>   PCI: MSI: Kill msi_controller structure
>   PCI: MSI: Kill default_teardown_msi_irqs()
>   PCI: MSI: Let PCI host bridges declare their reliance on MSI domains
>   PCI: Make pci_host_common_probe() declare its reliance on MSI domains
>   PCI: MSI: Document the various ways of ending up with NO_MSI
>   PCI: quirks: Refactor advertising of the NO_MSI flag
> 
> Thomas Gleixner (2):
>   PCI: MSI: Let PCI host bridges declare their lack of MSI handling
>   PCI: mediatek: Advertise lack of MSI handling

All looks good to me; I'm guessing Lorenzo will want to apply it or at
least take a look since the bulk of this is in the native host
drivers.

s|PCI: MSI:|PCI/MSI:| above (I use "PCI/<FEATURE>:" and "PCI: <driver>:")
s|PCI: hyperv:|PCI: hv:| to match previous practice

Maybe:

  PCI: Refactor HT advertising of NO_MSI flag

since "HT" contains more information than "quirks"?

In the 03/13 commit log, s/appaling/appalling/ :)
In the patch, it sounds like the MSI capture address change might be
separable into its own patch?  If it were separate, it would be easier
to see the problem/fix and watch for it elsewhere.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  drivers/pci/controller/Kconfig           |   4 +-
>  drivers/pci/controller/pci-host-common.c |   1 +
>  drivers/pci/controller/pci-hyperv.c      |   4 -
>  drivers/pci/controller/pci-tegra.c       | 343 ++++++++++++-----------
>  drivers/pci/controller/pcie-mediatek.c   |   4 +
>  drivers/pci/controller/pcie-rcar-host.c  | 342 +++++++++++-----------
>  drivers/pci/controller/pcie-xilinx.c     | 238 +++++++---------
>  drivers/pci/msi.c                        |  46 +--
>  drivers/pci/probe.c                      |   4 +-
>  drivers/pci/quirks.c                     |  15 +-
>  include/linux/msi.h                      |  17 +-
>  include/linux/pci.h                      |   4 +-
>  12 files changed, 463 insertions(+), 559 deletions(-)
> 
> -- 
> 2.29.2
> 
