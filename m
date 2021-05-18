Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8206D3870EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbhEREaQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 May 2021 00:30:16 -0400
Received: from foss.arm.com ([217.140.110.172]:40698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235926AbhEREaQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 May 2021 00:30:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AECA31B;
        Mon, 17 May 2021 21:28:58 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185D53F73D;
        Mon, 17 May 2021 21:28:57 -0700 (PDT)
Subject: Re: [PATCH v3 13/14] PCI/MSI: Document the various ways of ending up
 with NO_MSI
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, kernel-team@android.com
References: <20210330151145.997953-1-maz@kernel.org>
 <20210330151145.997953-14-maz@kernel.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <b5a5a6d8-6ffc-8c5c-c5b1-fb4f5616069f@arm.com>
Date:   Mon, 17 May 2021 23:28:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210330151145.997953-14-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,


On 3/30/21 10:11 AM, Marc Zyngier wrote:
> We have now three ways of ending up with NO_MSI being set.
> Document them.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/pci/msi.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d9c73c173c14..217dc9f0231f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -871,8 +871,15 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
>   	 * Any bridge which does NOT route MSI transactions from its
>   	 * secondary bus to its primary bus must set NO_MSI flag on
>   	 * the secondary pci_bus.
> -	 * We expect only arch-specific PCI host bus controller driver
> -	 * or quirks for specific PCI bridges to be setting NO_MSI.
> +	 *
> +	 * The NO_MSI flag can either be set directly by:
> +	 * - arch-specific PCI host bus controller drivers (deprecated)
> +	 * - quirks for specific PCI bridges
> +	 *
> +	 * or indirectly by platform-specific PCI host bridge drivers by
> +	 * advertising the 'msi_domain' property, which results in
> +	 * the NO_MSI flag when no MSI domain is found for this bridge
> +	 * at probe time.

I have an ACPI machine with a gicv2 (no m), and a MSI region that isn't 
described by ACPI because its non-standard. In the past this tended to 
work because PCIe device drivers would fall back to legacy pci intx 
silently. But, with 5.13, it seems this series now triggers the 
WARN_ON_ONCE() in arch_setup_msi_irq, because duh, no MSI support.

Everything of course continues to work, it just gets this ugly splat on 
bootup telling me basically the machine doesn't support MSIs. So, I 
considered a few patches, including just basically setting nomsi if 
gicv2 && acpi, or eek a host bridge quirk.

None of these seem great, so how can this be fixed?

Thanks,




>   	 */
>   	for (bus = dev->bus; bus; bus = bus->parent)
>   		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> 

