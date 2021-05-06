Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9B2375D29
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 May 2021 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhEFW0c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 May 2021 18:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhEFW0b (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 May 2021 18:26:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCDCB61057;
        Thu,  6 May 2021 22:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620339932;
        bh=NJ1s9KsbTwMRkgcGjSh2NdaFzXd0HMKRyslD8lM2WzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LWAvu+8wVKwzJctAgyb0KBP9FpGjbaiAGHrbf/xOuUPL6BB0y03P/zGOVzk4Pk025
         mqDHIzAHE4eWFQm4/0iDxcv5x9Y/GpdHc3XEQc03uxPZBKiEtYXG8XfPxZn7/2W5YS
         Z6mdJIlofH0c5Ery0WW4yLEDrMdYM4asO8IiuONBhlwzCGWJ4jFTxjV+SVCzTaFlch
         7f7OOi95dFSrU15AV9UhdBLvQlkoLLNVkFJ0ys7u4+caYQacDfP5tmiSoKG4eAEXa7
         0dhIeyzRhBhjQe7TN4FSABaHKOEYu/vUdfUscvGWZEAdMI5RaFlhugXJLNKI3J6N8g
         Jtl95d53f3V8Q==
Date:   Thu, 6 May 2021 17:25:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [RFC v2 6/7] PCI: arm64: Allow pci_config_window::parent to be
 NULL
Message-ID: <20210506222530.GA1441653@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503144635.2297386-7-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Make your subject something like this so it matches previous practice:

  arm64: PCI: ...

The "::" notation probably comes from C++, but doesn't really apply in
C.  In C, we would say "cfg.parent" or "cfg->parent".

But pci_config_window and cfg->parent are probably too low-level for
the subject anyway.  Seems like it should mention Hyper-V, for
instance.

On Mon, May 03, 2021 at 10:46:34PM +0800, Boqun Feng wrote:
> This is purely a hack, for ARM64 Hyper-V guest, there is no
> corresponding ACPI device for the root bridge, so the best we can
> provide is an all-zeroed pci_config_window, and in this case make
> pcibios_root_bridge_prepare() act as the ACPI device is NULL.

Why is there no ACPI device?  Is this a needless arch dependency?  Or
is this related to using DT instead of ACPI?

The cover letter hints that this might be related to
PCI_DOMAINS_GENERIC=y, but that doesn't sound like a very convincing
reason (and the cover letter can provide an overview, but the commit
logs of individual patches shouldn't assume knowledge of the cover
letter).

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/arm64/kernel/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index e9a6eeb6a694..f159df903ccb 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -83,7 +83,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
>  	if (!acpi_disabled) {
>  		struct pci_config_window *cfg = bridge->bus->sysdata;
> -		struct acpi_device *adev = to_acpi_device(cfg->parent);
> +		struct acpi_device *adev = cfg->parent ? to_acpi_device(cfg->parent) : NULL;
>  		struct device *bus_dev = &bridge->bus->dev;
>  
>  		ACPI_COMPANION_SET(&bridge->dev, adev);
> -- 
> 2.30.2
> 
