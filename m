Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC8351421
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Apr 2021 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhDALDh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Apr 2021 07:03:37 -0400
Received: from foss.arm.com ([217.140.110.172]:36788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhDALDL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Apr 2021 07:03:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A88BD6E;
        Thu,  1 Apr 2021 04:03:10 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A619F3F694;
        Thu,  1 Apr 2021 04:03:06 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:03:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
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
Subject: Re: [PATCH v3 03/14] PCI: rcar: Convert to MSI domains
Message-ID: <20210401110301.GA31407@lpieralisi>
References: <20210330151145.997953-1-maz@kernel.org>
 <20210330151145.997953-4-maz@kernel.org>
 <20210401101957.GA30653@lpieralisi>
 <87y2e2p9wk.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2e2p9wk.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 01, 2021 at 11:38:19AM +0100, Marc Zyngier wrote:
> On Thu, 01 Apr 2021 11:19:57 +0100,
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > 
> > On Tue, Mar 30, 2021 at 04:11:34PM +0100, Marc Zyngier wrote:
> > 
> > [...]
> > 
> > > +static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > > +{
> > > +	struct rcar_msi *msi = irq_data_get_irq_chip_data(data);
> > > +	unsigned long pa = virt_to_phys(msi);
> > >  
> > > -	hwirq = rcar_msi_alloc_region(msi, nvec);
> > > -	if (hwirq < 0)
> > > -		return -ENOSPC;
> > > +	/* Use the msi structure as the PA for the MSI doorbell */
> > > +	msg->address_lo = lower_32_bits(pa);
> > > +	msg->address_hi = upper_32_bits(pa);
> > 
> > I don't think this change is aligned with the previous patch (is it ?),
> > the PA address we are using here is different from the one programmed
> > into the controller registers - either that or I am missing something,
> > please let me know.
> 
> Err. You are right. This looks like a bad case of broken conflict
> resolution on my part.
> 
> The following snippet should fix it. Let me know if you want me to
> resend the whole thing or whether you are OK with applying this by
> hand.

I will apply it and merge the whole series into -next, thanks for
implementing it !

Lorenzo

> Thanks,
> 
> 	M.
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index f7331ad0d6dc..765cf2b45e24 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -573,11 +573,10 @@ static int rcar_msi_set_affinity(struct irq_data *d, const struct cpumask *mask,
>  static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  	struct rcar_msi *msi = irq_data_get_irq_chip_data(data);
> -	unsigned long pa = virt_to_phys(msi);
> +	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
>  
> -	/* Use the msi structure as the PA for the MSI doorbell */
> -	msg->address_lo = lower_32_bits(pa);
> -	msg->address_hi = upper_32_bits(pa);
> +	msg->address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
> +	msg->address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
>  	msg->data = data->hwirq;
>  }
>  
> 
> -- 
> Without deviation from the norm, progress is not possible.
