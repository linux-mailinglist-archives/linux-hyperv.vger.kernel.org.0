Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10627DC66
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 01:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgI2XDl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Sep 2020 19:03:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:10333 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgI2XDk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Sep 2020 19:03:40 -0400
IronPort-SDR: EBRQmec69HmFndigoTAFu7WE33tZrKGqC326f/cSeP39TZSh5fr/exhUBw9lmjjlfeTAWhfPFX
 0rXI6mxioBHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="223908294"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="223908294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 16:03:38 -0700
IronPort-SDR: /EvObaL5A0efO+V3yWJ7n6DgRY4Jfn26hfbu0C8T5O1RjfwKjT7pd78ZVG7iKsEJ0UgybKhTke
 epnaRxRgrjvA==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="415545172"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.209.163.104]) ([10.209.163.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 16:03:36 -0700
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
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
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
        ravi.v.shankar@intel.com
References: <20200826111628.794979401@linutronix.de>
From:   "Dey, Megha" <megha.dey@intel.com>
Message-ID: <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
Date:   Tue, 29 Sep 2020 16:03:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826111628.794979401@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
> This is the second version of providing a base to support device MSI (non
> PCI based) and on top of that support for IMS (Interrupt Message Storm)
> based devices in a halfways architecture independent way.
>
> The first version can be found here:
>
>      https://lore.kernel.org/r/20200821002424.119492231@linutronix.de
>
> It's still a mixed bag of bug fixes, cleanups and general improvements
> which are worthwhile independent of device MSI.
>
> There are quite a bunch of issues to solve:
>
>    - X86 does not use the device::msi_domain pointer for historical reasons
>      and due to XEN, which makes it impossible to create an architecture
>      agnostic device MSI infrastructure.
>
>    - X86 has it's own msi_alloc_info data type which is pointlessly
>      different from the generic version and does not allow to share code.
>
>    - The logic of composing MSI messages in an hierarchy is busted at the
>      core level and of course some (x86) drivers depend on that.
>
>    - A few minor shortcomings as usual
>
> This series addresses that in several steps:
>
>   1) Accidental bug fixes
>
>        iommu/amd: Prevent NULL pointer dereference
>
>   2) Janitoring
>
>        x86/init: Remove unused init ops
>        PCI: vmd: Dont abuse vector irqomain as parent
>        x86/msi: Remove pointless vcpu_affinity callback
>
>   3) Sanitizing the composition of MSI messages in a hierarchy
>   
>        genirq/chip: Use the first chip in irq_chip_compose_msi_msg()
>        x86/msi: Move compose message callback where it belongs
>
>   4) Simplification of the x86 specific interrupt allocation mechanism
>
>        x86/irq: Rename X86_IRQ_ALLOC_TYPE_MSI* to reflect PCI dependency
>        x86/irq: Add allocation type for parent domain retrieval
>        iommu/vt-d: Consolidate irq domain getter
>        iommu/amd: Consolidate irq domain getter
>        iommu/irq_remapping: Consolidate irq domain lookup
>
>   5) Consolidation of the X86 specific interrupt allocation mechanism to be as close
>      as possible to the generic MSI allocation mechanism which allows to get rid
>      of quite a bunch of x86'isms which are pointless
>
>        x86/irq: Prepare consolidation of irq_alloc_info
>        x86/msi: Consolidate HPET allocation
>        x86/ioapic: Consolidate IOAPIC allocation
>        x86/irq: Consolidate DMAR irq allocation
>        x86/irq: Consolidate UV domain allocation
>        PCI/MSI: Rework pci_msi_domain_calc_hwirq()
>        x86/msi: Consolidate MSI allocation
>        x86/msi: Use generic MSI domain ops
>
>    6) x86 specific cleanups to remove the dependency on arch_*_msi_irqs()
>
>        x86/irq: Move apic_post_init() invocation to one place
>        x86/pci: Reducde #ifdeffery in PCI init code
>        x86/irq: Initialize PCI/MSI domain at PCI init time
>        irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
>        PCI: vmd: Mark VMD irqdomain with DOMAIN_BUS_VMD_MSI
>        PCI/MSI: Provide pci_dev_has_special_msi_domain() helper
>        x86/xen: Make xen_msi_init() static and rename it to xen_hvm_msi_init()
>        x86/xen: Rework MSI teardown
>        x86/xen: Consolidate XEN-MSI init
>        irqdomain/msi: Allow to override msi_domain_alloc/free_irqs()
>        x86/xen: Wrap XEN MSI management into irqdomain
>        iommm/vt-d: Store irq domain in struct device
>        iommm/amd: Store irq domain in struct device
>        x86/pci: Set default irq domain in pcibios_add_device()
>        PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
>        x86/irq: Cleanup the arch_*_msi_irqs() leftovers
>        x86/irq: Make most MSI ops XEN private
>        iommu/vt-d: Remove domain search for PCI/MSI[X]
>        iommu/amd: Remove domain search for PCI/MSI
>
>    7) X86 specific preparation for device MSI
>
>        x86/irq: Add DEV_MSI allocation type
>        x86/msi: Rename and rework pci_msi_prepare() to cover non-PCI MSI
>
>    8) Generic device MSI infrastructure
>        platform-msi: Provide default irq_chip:: Ack
>        genirq/proc: Take buslock on affinity write
>        genirq/msi: Provide and use msi_domain_set_default_info_flags()
>        platform-msi: Add device MSI infrastructure
>        irqdomain/msi: Provide msi_alloc/free_store() callbacks
>
>    9) POC of IMS (Interrupt Message Storm) irq domain and irqchip
>       implementations for both device array and queue storage.
>
>        irqchip: Add IMS (Interrupt Message Storm) driver - NOT FOR MERGING
>
> Changes vs. V1:
>
>     - Addressed various review comments and addressed the 0day fallout.
>       - Corrected the XEN logic (Jürgen)
>       - Make the arch fallback in PCI/MSI opt-in not opt-out (Bjorn)
>
>     - Fixed the compose MSI message inconsistency
>
>     - Ensure that the necessary flags are set for device SMI
>
>     - Make the irq bus logic work for affinity setting to prepare
>       support for IMS storage in queue memory. It turned out to be
>       less scary than I feared.
>
>     - Remove leftovers in iommu/intel|amd
>
>     - Reworked the IMS POC driver to cover queue storage so Jason can have a
>       look whether that fits the needs of MLX devices.
>
> The whole lot is also available from git:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git device-msi
>
> This has been tested on Intel/AMD/KVM but lacks testing on:
>
>      - HYPERV (-ENODEV)
>      - VMD enabled systems (-ENODEV)
>      - XEN (-ENOCLUE)
>      - IMS (-ENODEV)
>
>      - Any non-X86 code which might depend on the broken compose MSI message
>        logic. Marc excpects not much fallout, but agrees that we need to fix
>        it anyway.
>
> #1 - #3 should be applied unconditionally for obvious reasons
> #4 - #6 are wortwhile cleanups which should be done independent of device MSI
>
> #7 - #8 look promising to cleanup the platform MSI implementation
>       	independent of #8, but I neither had cycles nor the stomach to
>       	tackle that.
>
> #9	is obviously just for the folks interested in IMS
>
> Thanks,
>
> 	tglx

I see that the tip tree (as of 9/29) has most of these patches but 
notice that the DEV_MSI related patches

haven't made it. I have tested the tip tree(x86/irq branch) with your 
DEV_MSI infra patches and our IMS

patches with the IDXD driver and was wondering if we should push out 
those patches as part of our patchset?

Thanks,

Megha

