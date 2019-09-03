Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF7EA63BF
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfICIWK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Sep 2019 04:22:10 -0400
Received: from foss.arm.com ([217.140.110.172]:33864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfICIWJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Sep 2019 04:22:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0694028;
        Tue,  3 Sep 2019 01:22:09 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12E03F246;
        Tue,  3 Sep 2019 01:22:03 -0700 (PDT)
Subject: Re: [PATCH] irqdomain: Add the missing assignment of domain->fwnode
 for named fwnode
To:     Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>
References: <PU1P153MB01694D9AF625AC335C600C5FBFBE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <4acd6871-ca66-b45d-50b8-8609eee0e488@kernel.org>
Date:   Tue, 3 Sep 2019 09:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PU1P153MB01694D9AF625AC335C600C5FBFBE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Dexuan,

On 03/09/2019 00:14, Dexuan Cui wrote:
> 
> Recently device pass-through stops working for Linux VM running on Hyper-V.
> 
> git-bisect shows the regression is caused by the recent commit
> 467a3bb97432 ("PCI: hv: Allocate a named fwnode ..."), but the root cause
> is that the commit d59f6617eef0 forgets to set the domain->fwnode for
> IRQCHIP_FWNODE_NAMED*, and as a result:
> 
> 1. The domain->fwnode remains to be NULL.
> 
> 2. irq_find_matching_fwspec() returns NULL since "h->fwnode == fwnode" is
> false, and pci_set_bus_msi_domain() sets the Hyper-V PCI root bus's
> msi_domain to NULL.
> 
> 3. When the device is added onto the root bus, the device's dev->msi_domain
> is set to NULL in pci_set_msi_domain().
> 
> 4. When a device driver tries to enable MSI-X, pci_msi_setup_msi_irqs()
> calls arch_setup_msi_irqs(), which uses the native MSI chip (i.e.
> arch/x86/kernel/apic/msi.c: pci_msi_controller) to set up the irqs, but
> actually pci_msi_setup_msi_irqs() is supposed to call
> msi_domain_alloc_irqs() with the hbus->irq_domain, which is created in
> hv_pcie_init_irq_domain() and is associated with the Hyper-V chip
> hv_msi_irq_chip. Consequently, the irq line is not properly set up, and
> the device driver can not receive any interrupt.
> 
> Fixes: d59f6617eef0 ("genirq: Allow fwnode to carry name information only")
> Fixes: 467a3bb97432 ("PCI: hv: Allocate a named fwnode instead of an address-based one")
> Reported-by: Lili Deng <v-lide@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Note: the commit 467a3bb97432 ("PCI: hv: Allocate a named fwnode ...") has not
> gone in Linus's tree yet (the commit is in linux-next for a while), so the commit ID
> in the changelog can change when it goes in Linus's tree.

This branch is supposed to be stable, and I try to only apply fixes to
it. This normally ensures that commit IDs are the same once they land in
Linus' tree.

> This patch works in my test, but I'm not 100% sure this is the right fix. 
> 
> Looking forward to your comment!
> 
>  kernel/irq/irqdomain.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index e7bbab149750..132672b74e4b 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -149,6 +149,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
>  		switch (fwid->type) {
>  		case IRQCHIP_FWNODE_NAMED:
>  		case IRQCHIP_FWNODE_NAMED_ID:
> +			domain->fwnode = fwnode;
>  			domain->name = kstrdup(fwid->name, GFP_KERNEL);
>  			if (!domain->name) {
>  				kfree(domain);
> 

Looks absolutely correct to me, thanks for fixing it. I've applied it on
top of irqchip-next.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
