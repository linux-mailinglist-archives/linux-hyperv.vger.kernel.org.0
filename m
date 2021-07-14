Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9629A3C9114
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbhGNT5s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 15:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241080AbhGNTuW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 15:50:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 889A8613CA;
        Wed, 14 Jul 2021 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626292006;
        bh=8qRBxphBatvbhZhhB7xXPoJR7ipkIeRYImlsAsgH3UE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uLDQholbw39gQGez83hc0Sb5Xt6rJzkYrHJwgyEtrRq04FtUGalzuRmdtJ2hVsLl8
         ycKT8paFjpnCMquRqRsamNSPeikMuZ9/EZ6ihIWt3GTIvxRczkHlP9IcC/MAiXzhHn
         x7sHAOUz4Yvvzxgx+Y8cyj5vu4vSq4hL/n79cQHtkSd55iWTwZR2SbX3oeHkCskzob
         iUMhwYjZwrYoiryYW+4Lwt0JUGwWC+eavGZOTh14XTPYjClNTL6wgO2n/FzXD8etoD
         f5seRlVErs48dQyXQjgOaBLQuiXr2rH7GGsgQ7LTKJroslTIuxTVy4pi/aK+v5KaJW
         WIJEuZZF9cCyA==
Date:   Wed, 14 Jul 2021 14:46:45 -0500
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
Subject: Re: [RFC v4 3/7] arm64: PCI: Support root bridge preparation for
 Hyper-V PCI
Message-ID: <20210714194645.GA1869525@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714102737.198432-4-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 14, 2021 at 06:27:33PM +0800, Boqun Feng wrote:
> Currently at root bridge preparation, the corresponding ACPI device will
> be set as the companion, however for a Hyper-V virtual PCI root bridge,
> there is no corresponding ACPI device, because a Hyper-V virtual PCI
> root bridge is discovered via VMBus rather than ACPI table. In order to
> support this, we need to make pcibios_root_bridge_prepare() work with
> cfg->parent being NULL.

It would be nice to have a hint about why we don't actually need the
ACPI companion device in this case.

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/arm64/kernel/pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..3b81ac42bc1f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -84,7 +84,13 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
>  	if (!acpi_disabled) {
>  		struct pci_config_window *cfg = bridge->bus->sysdata;
> -		struct acpi_device *adev = to_acpi_device(cfg->parent);
> +		/*
> +		 * On Hyper-V there is no corresponding APCI device for a root
> +		 * bridge, therefore ->parent is set as NULL by the driver. And
> +		 * set 'adev` as NULL in this case because there is no proper
> +		 * ACPI device.
> +		 */
> +		struct acpi_device *adev = cfg->parent ? to_acpi_device(cfg->parent) : NULL;
>  		struct device *bus_dev = &bridge->bus->dev;
>  
>  		ACPI_COMPANION_SET(&bridge->dev, adev);

s/APCI/ACPI/ above.

I think this would be more readable like this:

  struct pci_config_window *cfg = bridge->bus->sysdata;
  ...

  if (acpi_disabled)
    return 0;

  /*
   * On Hyper-V there is no corresponding ACPI device for a root
   * ...
   */
  cfg = bridge->bus->sysdata;
  if (!cfg->parent)
    return 0;

  adev = to_acpi_device(cfg->parent);
  bus_dev = &bridge->bus->dev;
  ACPI_COMPANION_SET(&bridge->dev, adev);
  ...

This could be done in two steps: the first to restructure the code
without making any functional change, and a second to return when
there's no cfg->parent.  If you do it in one step, the patch will be
much harder to read.

Bjorn
