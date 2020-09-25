Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ECF278A13
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Sep 2020 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIYNzP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Sep 2020 09:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728330AbgIYNzM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Sep 2020 09:55:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601042110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6n8qfow2srJZ/wVE5bZaW/DNL/DT/TCXXKIdMa5+xeg=;
        b=hi/TfxZ3S1Ze2cYNRtIk0TfDcLokKpGNO6WjK4yuOap0/YpYiDfwA1ItLfDE/i30GkHRFZ
        So6iVEi5Vk2dCy9mY8foO3RoQSewwKWJ86TM1EX2YwyvTVMyjPKnPHUaF5vDXJgj+8oHUt
        HkOGkygFjh8bBuN0zp3q3ljZyZ3ncR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-KKpNboZLOfasdSEOvcuo4g-1; Fri, 25 Sep 2020 09:55:05 -0400
X-MC-Unique: KKpNboZLOfasdSEOvcuo4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 525441021202;
        Fri, 25 Sep 2020 13:55:00 +0000 (UTC)
Received: from ovpn-66-87.rdu2.redhat.com (unknown [10.10.67.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E9973662;
        Fri, 25 Sep 2020 13:54:53 +0000 (UTC)
Message-ID: <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
From:   Qian Cai <cai@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Sep 2020 09:54:52 -0400
In-Reply-To: <20200826112333.992429909@linutronix.de>
References: <20200826111628.794979401@linutronix.de>
         <20200826112333.992429909@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 2020-08-26 at 13:17 +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
> requires them or not. Architectures which are fully utilizing hierarchical
> irq domains should never call into that code.
> 
> It's not only architectures which depend on that by implementing one or
> more of the weak functions, there is also a bunch of drivers which relies
> on the weak functions which invoke msi_controller::setup_irq[s] and
> msi_controller::teardown_irq.
> 
> Make the architectures and drivers which rely on them select them in Kconfig
> and if not selected replace them by stub functions which emit a warning and
> fail the PCI/MSI interrupt allocation.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Today's linux-next will have some warnings on s390x:

.config: https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config

WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - S390 [=y]

WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - S390 [=y]

> ---
> V2: Make the architectures (and drivers) which need the fallbacks select them
>     and not the other way round (Bjorn).
> ---
>  arch/ia64/Kconfig              |    1 +
>  arch/mips/Kconfig              |    1 +
>  arch/powerpc/Kconfig           |    1 +
>  arch/s390/Kconfig              |    1 +
>  arch/sparc/Kconfig             |    1 +
>  arch/x86/Kconfig               |    1 +
>  drivers/pci/Kconfig            |    3 +++
>  drivers/pci/controller/Kconfig |    3 +++
>  drivers/pci/msi.c              |    3 ++-
>  include/linux/msi.h            |   31 ++++++++++++++++++++++++++-----
>  10 files changed, 40 insertions(+), 6 deletions(-)
> 
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -56,6 +56,7 @@ config IA64
>  	select NEED_DMA_MAP_STATE
>  	select NEED_SG_DMA_LENGTH
>  	select NUMA if !FLATMEM
> +	select PCI_MSI_ARCH_FALLBACKS
>  	default y
>  	help
>  	  The Itanium Processor Family is Intel's 64-bit successor to
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -86,6 +86,7 @@ config MIPS
>  	select MODULES_USE_ELF_REL if MODULES
>  	select MODULES_USE_ELF_RELA if MODULES && 64BIT
>  	select PERF_USE_VMALLOC
> +	select PCI_MSI_ARCH_FALLBACKS
>  	select RTC_LIB
>  	select SYSCTL_EXCEPTION_TRACE
>  	select VIRT_TO_BUS
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -246,6 +246,7 @@ config PPC
>  	select OLD_SIGACTION			if PPC32
>  	select OLD_SIGSUSPEND
>  	select PCI_DOMAINS			if PCI
> +	select PCI_MSI_ARCH_FALLBACKS
>  	select PCI_SYSCALL			if PCI
>  	select PPC_DAWR				if PPC64
>  	select RTC_LIB
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -185,6 +185,7 @@ config S390
>  	select OLD_SIGSUSPEND3
>  	select PCI_DOMAINS		if PCI
>  	select PCI_MSI			if PCI
> +	select PCI_MSI_ARCH_FALLBACKS
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -43,6 +43,7 @@ config SPARC
>  	select GENERIC_STRNLEN_USER
>  	select MODULES_USE_ELF_RELA
>  	select PCI_SYSCALL if PCI
> +	select PCI_MSI_ARCH_FALLBACKS
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
>  	select CPU_NO_EFFICIENT_FFS
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -225,6 +225,7 @@ config X86
>  	select NEED_SG_DMA_LENGTH
>  	select PCI_DOMAINS			if PCI
>  	select PCI_LOCKLESS_CONFIG		if PCI
> +	select PCI_MSI_ARCH_FALLBACKS
>  	select PERF_EVENTS
>  	select RTC_LIB
>  	select RTC_MC146818_LIB
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -56,6 +56,9 @@ config PCI_MSI_IRQ_DOMAIN
>  	depends on PCI_MSI
>  	select GENERIC_MSI_IRQ_DOMAIN
>  
> +config PCI_MSI_ARCH_FALLBACKS
> +	bool
> +
>  config PCI_QUIRKS
>  	default y
>  	bool "Enable PCI quirk workarounds" if EXPERT
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -41,6 +41,7 @@ config PCI_TEGRA
>  	bool "NVIDIA Tegra PCIe controller"
>  	depends on ARCH_TEGRA || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCI_MSI_ARCH_FALLBACKS
>  	help
>  	  Say Y here if you want support for the PCIe host controller found
>  	  on NVIDIA Tegra SoCs.
> @@ -67,6 +68,7 @@ config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe host controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCI_MSI_ARCH_FALLBACKS
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car SoCs in host
>  	  mode.
> @@ -103,6 +105,7 @@ config PCIE_XILINX_CPM
>  	bool "Xilinx Versal CPM host bridge support"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>  	select PCI_HOST_COMMON
> +	select PCI_MSI_ARCH_FALLBACKS
>  	help
>  	  Say 'Y' here if you want kernel support for the
>  	  Xilinx Versal CPM host bridge.
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -58,8 +58,8 @@ static void pci_msi_teardown_msi_irqs(st
>  #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
>  #endif
>  
> +#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
>  /* Arch hooks */
> -
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
>  	struct msi_controller *chip = dev->bus->msi;
> @@ -132,6 +132,7 @@ void __weak arch_teardown_msi_irqs(struc
>  {
>  	return default_teardown_msi_irqs(dev);
>  }
> +#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
>  
>  static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  {
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *d
>  void pci_msi_unmask_irq(struct irq_data *data);
>  
>  /*
> - * The arch hooks to setup up msi irqs. Those functions are
> - * implemented as weak symbols so that they /can/ be overriden by
> - * architecture specific code if needed.
> + * The arch hooks to setup up msi irqs. Default functions are implemented
> + * as weak symbols so that they /can/ be overriden by architecture specific
> + * code if needed. These hooks must be enabled by the architecture or by
> + * drivers which depend on them via msi_controller based MSI handling.
> + *
> + * If CONFIG_PCI_MSI_ARCH_FALLBACKS is not selected they are replaced by
> + * stubs with warnings.
>   */
> +#ifdef CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS
>  int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
>  void arch_teardown_msi_irq(unsigned int irq);
>  int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  void arch_teardown_msi_irqs(struct pci_dev *dev);
> -void arch_restore_msi_irqs(struct pci_dev *dev);
> -
>  void default_teardown_msi_irqs(struct pci_dev *dev);
> +#else
> +static inline int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int
> type)
> +{
> +	WARN_ON_ONCE(1);
> +	return -ENODEV;
> +}
> +
> +static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +#endif
> +
> +/*
> + * The restore hooks are still available as they are useful even
> + * for fully irq domain based setups. Courtesy to XEN/X86.
> + */
> +void arch_restore_msi_irqs(struct pci_dev *dev);
>  void default_restore_msi_irqs(struct pci_dev *dev);
>  
>  struct msi_controller {
> 

