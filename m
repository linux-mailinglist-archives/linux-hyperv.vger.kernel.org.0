Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C63D7AB7
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhG0QOd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 12:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhG0QOd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 12:14:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC4E661B7C;
        Tue, 27 Jul 2021 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627402473;
        bh=QtgOoB9l9cTt54Ke4pcqbiOYoSYZ30ZDlwTKxMdh9Bk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WsMICcmPMJy6ahbt4KsB7HzhNmWBjuOD49tW3sLQ7zYca6ihf+3Wp7hktwgcWEz2X
         thbQLoSKabk4c9MoD5A4S+YePzfIgdEPNzCDekr6EmOOlE7DhFMNH7XYtTqq5+J5j0
         Ex9Ut0AAJvdLmYmRmND/VYktwF5cjXsfqarzi+AHifVa7O7Fn0Wj2K02Ej1iAFEiYR
         SLwj9iOgsq4BazOb3J23e+whmvKjrPR4aVywvVyySSKbRn3rEohI9ncLYrhNzYT2x1
         tJYLn2xlEugdiWg9DqsJWhVxBKRllp/zC1XykcU1ThRw6UroY5z9re/tStBB5XUydx
         CiOq/V459Nnpg==
Date:   Tue, 27 Jul 2021 11:14:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 2/8] PCI: Support populating MSI domains of root buses
 via bridges
Message-ID: <20210727161431.GA718548@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726180657.142727-3-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 02:06:51AM +0800, Boqun Feng wrote:
> Currently, at probing time, the MSI domains of root buses are populated
> if either the information of MSI domain is available from firmware (DT
> or ACPI), or arch-specific sysdata is used to pass the fwnode of the MSI
> domain. These two conditions don't cover all, e.g. Hyper-V virtual PCI
> on ARM64, which doesn't have the MSI information in the firmware and
> couldn't use arch-specific sysdata because running on an architecture
> with PCI_DOMAINS_GENERIC=y.
> 
> To support populating MSI domains of the root buses at the probing when
> neither of the above condition is true, the ->msi_domain of the
> corresponding bridge device is used: in pci_host_bridge_msi_domain(),
> which should return the MSI domain of the root bus, the ->msi_domain of
> the corresponding bridge is fetched first as a potential value of the
> MSI domain of the root bus.
> 
> In order to use the approach to populate MSI domains, the driver needs
> to dev_set_msi_domain() on the bridge before calling
> pci_register_host_bridge(), and makes sure GENERIC_MSI_IRQ_DOMAIN=y.
> 
> Another advantage of this new approach is providing an arch-independent
> way to populate MSI domains, which allows sharing the driver code as
> much as possible between architectures.
> 
> Originally-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 60c50d4f156f..ea7f2a57e2f5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -829,11 +829,15 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>  {
>  	struct irq_domain *d;
>  
> +	/* If the host bridge driver sets a MSI domain of the bridge, use it */
> +	d = dev_get_msi_domain(bus->bridge);
> +
>  	/*
>  	 * Any firmware interface that can resolve the msi_domain
>  	 * should be called from here.
>  	 */
> -	d = pci_host_bridge_of_msi_domain(bus);
> +	if (!d)
> +		d = pci_host_bridge_of_msi_domain(bus);
>  	if (!d)
>  		d = pci_host_bridge_acpi_msi_domain(bus);
>  
> -- 
> 2.32.0
> 
