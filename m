Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA346C538
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 21:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhLGVAb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 16:00:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35018 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhLGVAP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 16:00:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9AD1CCE1E7B;
        Tue,  7 Dec 2021 20:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AAEC341D4;
        Tue,  7 Dec 2021 20:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910600;
        bh=X61QYWzbqgFgrJlTqRQwH4PzFugFcu0Hpdp1pU5hHmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TML4f1uO3yO7J1wXBUU1oQjNt9/b0tQSXkYs2daEjd6lCOMWhRgOOQmmhRvjFabJ3
         9h4M51LOkpLjoMpzciB7fXRHDXdxUdlhZ3Aemx080ANSrhGUtq9NVnPE9kyq7JreQZ
         69r46bVEHr3HumIzzDX+mCI5CvOzsce9BFylUxhc0op/FhDozgZd9q7vNUPGRHOKiz
         0v6FB4uodoDiEkYP4It3XFe2w/ExGM5DEHBBtGIWKGQp3WF3TRfW1TOup7wqcpjylA
         oKHUl1krlMjN39awAPgFfxZ1ZPXQNfrhVlJOUUJaBUxpnxRoh6ePoBBZEog88alfDM
         GgmzqmgApIP1Q==
Date:   Tue, 7 Dec 2021 14:56:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [patch V2 12/23] PCI/MSI: Make arch_restore_msi_irqs() less
 horrible.
Message-ID: <20211207205639.GA76751@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.485668098@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:42PM +0100, Thomas Gleixner wrote:
> Make arch_restore_msi_irqs() return a boolean which indicates whether the
> core code should restore the MSI message or not. Get rid of the indirection
> in x86.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: x86@kernel.org
> Cc: xen-devel@lists.xenproject.org
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI

> ---
>  arch/s390/pci/pci_irq.c               |    4 +-
>  arch/x86/include/asm/x86_init.h       |    6 ---
>  arch/x86/include/asm/xen/hypervisor.h |    8 +++++
>  arch/x86/kernel/apic/msi.c            |    6 +++
>  arch/x86/kernel/x86_init.c            |   12 -------
>  arch/x86/pci/xen.c                    |   13 ++++----
>  drivers/pci/msi.c                     |   54 +++++++++++-----------------------
>  include/linux/msi.h                   |    7 +---
>  8 files changed, 45 insertions(+), 65 deletions(-)
> 
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -387,13 +387,13 @@ void arch_teardown_msi_irqs(struct pci_d
>  		airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
>  }
>  
> -void arch_restore_msi_irqs(struct pci_dev *pdev)
> +bool arch_restore_msi_irqs(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(pdev);
>  
>  	if (!zdev->irqs_registered)
>  		zpci_set_irq(zdev);
> -	default_restore_msi_irqs(pdev);
> +	return true;
>  }
>  
>  static struct airq_struct zpci_airq = {
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -289,12 +289,6 @@ struct x86_platform_ops {
>  	struct x86_hyper_runtime hyper;
>  };
>  
> -struct pci_dev;
> -
> -struct x86_msi_ops {
> -	void (*restore_msi_irqs)(struct pci_dev *dev);
> -};
> -
>  struct x86_apic_ops {
>  	unsigned int	(*io_apic_read)   (unsigned int apic, unsigned int reg);
>  	void		(*restore)(void);
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -57,6 +57,14 @@ static inline bool __init xen_x2apic_par
>  }
>  #endif
>  
> +struct pci_dev;
> +
> +#ifdef CONFIG_XEN_DOM0
> +bool xen_initdom_restore_msi(struct pci_dev *dev);
> +#else
> +static inline bool xen_initdom_restore_msi(struct pci_dev *dev) { return true; }
> +#endif
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  void xen_arch_register_cpu(int num);
>  void xen_arch_unregister_cpu(int num);
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -19,6 +19,7 @@
>  #include <asm/hw_irq.h>
>  #include <asm/apic.h>
>  #include <asm/irq_remapping.h>
> +#include <asm/xen/hypervisor.h>
>  
>  struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
>  
> @@ -345,3 +346,8 @@ void dmar_free_hwirq(int irq)
>  	irq_domain_free_irqs(irq, 1);
>  }
>  #endif
> +
> +bool arch_restore_msi_irqs(struct pci_dev *dev)
> +{
> +	return xen_initdom_restore_msi(dev);
> +}
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -145,18 +145,6 @@ struct x86_platform_ops x86_platform __r
>  
>  EXPORT_SYMBOL_GPL(x86_platform);
>  
> -#if defined(CONFIG_PCI_MSI)
> -struct x86_msi_ops x86_msi __ro_after_init = {
> -	.restore_msi_irqs	= default_restore_msi_irqs,
> -};
> -
> -/* MSI arch specific hooks */
> -void arch_restore_msi_irqs(struct pci_dev *dev)
> -{
> -	x86_msi.restore_msi_irqs(dev);
> -}
> -#endif
> -
>  struct x86_apic_ops x86_apic_ops __ro_after_init = {
>  	.io_apic_read	= native_io_apic_read,
>  	.restore	= native_restore_boot_irq_mode,
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -351,10 +351,13 @@ static int xen_initdom_setup_msi_irqs(st
>  	return ret;
>  }
>  
> -static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
> +bool xen_initdom_restore_msi(struct pci_dev *dev)
>  {
>  	int ret = 0;
>  
> +	if (!xen_initial_domain())
> +		return true;
> +
>  	if (pci_seg_supported) {
>  		struct physdev_pci_device restore_ext;
>  
> @@ -375,10 +378,10 @@ static void xen_initdom_restore_msi_irqs
>  		ret = HYPERVISOR_physdev_op(PHYSDEVOP_restore_msi, &restore);
>  		WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
>  	}
> +	return false;
>  }
>  #else /* CONFIG_XEN_PV_DOM0 */
>  #define xen_initdom_setup_msi_irqs	NULL
> -#define xen_initdom_restore_msi_irqs	NULL
>  #endif /* !CONFIG_XEN_PV_DOM0 */
>  
>  static void xen_teardown_msi_irqs(struct pci_dev *dev)
> @@ -466,12 +469,10 @@ static __init struct irq_domain *xen_cre
>  static __init void xen_setup_pci_msi(void)
>  {
>  	if (xen_pv_domain()) {
> -		if (xen_initial_domain()) {
> +		if (xen_initial_domain())
>  			xen_msi_ops.setup_msi_irqs = xen_initdom_setup_msi_irqs;
> -			x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
> -		} else {
> +		else
>  			xen_msi_ops.setup_msi_irqs = xen_setup_msi_irqs;
> -		}
>  		xen_msi_ops.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
>  		pci_msi_ignore_mask = 1;
>  	} else if (xen_hvm_domain()) {
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -106,29 +106,6 @@ void __weak arch_teardown_msi_irqs(struc
>  }
>  #endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
>  
> -static void default_restore_msi_irq(struct pci_dev *dev, int irq)
> -{
> -	struct msi_desc *entry;
> -
> -	entry = NULL;
> -	if (dev->msix_enabled) {
> -		for_each_pci_msi_entry(entry, dev) {
> -			if (irq == entry->irq)
> -				break;
> -		}
> -	} else if (dev->msi_enabled)  {
> -		entry = irq_get_msi_desc(irq);
> -	}
> -
> -	if (entry)
> -		__pci_write_msi_msg(entry, &entry->msg);
> -}
> -
> -void __weak arch_restore_msi_irqs(struct pci_dev *dev)
> -{
> -	return default_restore_msi_irqs(dev);
> -}
> -
>  /*
>   * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
>   * mask all MSI interrupts by clearing the MSI enable bit does not work
> @@ -242,14 +219,6 @@ void pci_msi_unmask_irq(struct irq_data
>  }
>  EXPORT_SYMBOL_GPL(pci_msi_unmask_irq);
>  
> -void default_restore_msi_irqs(struct pci_dev *dev)
> -{
> -	struct msi_desc *entry;
> -
> -	for_each_pci_msi_entry(entry, dev)
> -		default_restore_msi_irq(dev, entry->irq);
> -}
> -
>  void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
>  	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
> @@ -403,10 +372,19 @@ static void pci_msi_set_enable(struct pc
>  	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
>  }
>  
> +/*
> + * Architecture override returns true when the PCI MSI message should be
> + * written by the generic restore function.
> + */
> +bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
> +{
> +	return true;
> +}
> +
>  static void __pci_restore_msi_state(struct pci_dev *dev)
>  {
> -	u16 control;
>  	struct msi_desc *entry;
> +	u16 control;
>  
>  	if (!dev->msi_enabled)
>  		return;
> @@ -415,7 +393,8 @@ static void __pci_restore_msi_state(stru
>  
>  	pci_intx_for_msi(dev, 0);
>  	pci_msi_set_enable(dev, 0);
> -	arch_restore_msi_irqs(dev);
> +	if (arch_restore_msi_irqs(dev))
> +		__pci_write_msi_msg(entry, &entry->msg);
>  
>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>  	pci_msi_update_mask(entry, 0, 0);
> @@ -437,6 +416,7 @@ static void pci_msix_clear_and_set_ctrl(
>  static void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
> +	bool write_msg;
>  
>  	if (!dev->msix_enabled)
>  		return;
> @@ -447,9 +427,13 @@ static void __pci_restore_msix_state(str
>  	pci_msix_clear_and_set_ctrl(dev, 0,
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>  
> -	arch_restore_msi_irqs(dev);
> -	for_each_pci_msi_entry(entry, dev)
> +	write_msg = arch_restore_msi_irqs(dev);
> +
> +	for_each_pci_msi_entry(entry, dev) {
> +		if (write_msg)
> +			__pci_write_msi_msg(entry, &entry->msg);
>  		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
> +	}
>  
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -273,11 +273,10 @@ static inline void arch_teardown_msi_irq
>  #endif
>  
>  /*
> - * The restore hooks are still available as they are useful even
> - * for fully irq domain based setups. Courtesy to XEN/X86.
> + * The restore hook is still available even for fully irq domain based
> + * setups. Courtesy to XEN/X86.
>   */
> -void arch_restore_msi_irqs(struct pci_dev *dev);
> -void default_restore_msi_irqs(struct pci_dev *dev);
> +bool arch_restore_msi_irqs(struct pci_dev *dev);
>  
>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>  
> 
