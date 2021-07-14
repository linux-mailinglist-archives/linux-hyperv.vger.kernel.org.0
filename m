Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EC73C8CB7
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhGNTmk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 15:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhGNTmO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 15:42:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 907CB613DA;
        Wed, 14 Jul 2021 19:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291561;
        bh=3Rr6koHIQmRr8tLClangiNtlx32anz5IDP9dT1csPoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V3FiFKJYUhSvfEpC0i6gYvAdyUppbBHOrArHPVvPnGeBNubloc5ZEQjvXeYFWJSGD
         KVV3Pxi/440isDrzgF2Am6UFS+28spBz0q54e/J9+QHjX3OZQSN82f+mx8zT1LU8S4
         HLgGU6DFKDvPxYKCN8RnOHgp96MMi6P0ydHVQNvzJnegrJbPjEdQ44Ysvk5/wf5CKj
         61bk+ucv25UBWofdmPkgkITl83Kw7UeUBoQOupyhkJ9Y7cOgakr1jm6bHc7LJk8bHS
         PjmX90K6V7EGh2HjDdDjC9l5sreEdnLFh2zjz6fOxoxM7Wo9cOVpGpaRHrAnVrX4ah
         9E+dx9dafiB8Q==
Date:   Wed, 14 Jul 2021 14:39:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC v4 2/7] PCI: Allow msi domain set-up at host probing time
Message-ID: <20210714193920.GA1868875@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714102737.198432-3-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Capitalize "MSI" in subject and commit log.

On Wed, Jul 14, 2021 at 06:27:32PM +0800, Boqun Feng wrote:
> For GENERIC_MSI_IRQ_DOMAIN drivers, we can set up the msi domain via
> dev_set_msi_domain() at probing time, and drivers can use this more
> generic way to set up the msi domain for the host bridge.

This doesn't tell me what this patch *does* or why we need it.

> This is the preparation for ARM64 Hyper-V PCI support.
> 
> Originally-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  drivers/pci/probe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 60c50d4f156f..539b5139e376 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -829,11 +829,14 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>  {
>  	struct irq_domain *d;
>  
> +	/* Default set by host bridge driver */
> +	d = dev_get_msi_domain(bus->bridge);

Add blank line here between executable code and the following comment.

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
> 2.30.2
> 
