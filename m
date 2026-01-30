Return-Path: <linux-hyperv+bounces-8625-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOD4MXBCfWnIRAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8625-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jan 2026 00:44:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F30BF6EC
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jan 2026 00:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91A2B3007A78
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 23:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C838B7C1;
	Fri, 30 Jan 2026 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GrK1bcOM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F638A9C3;
	Fri, 30 Jan 2026 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816683; cv=none; b=g7hhRZ+dqNMgJenrd9IAZo+LT6mQRIrT110/MVbOmOJ6PftLABjoDR1WmijpuY+I+KIpO5UpMT3S/t3Spsns6EieXgPamQSWi5F0uwiGVL+qFuKcXCiYd/k6AXpORjeYOv3gKL5tCLFUUUqyHHd3K5RXDcQ/IAWkM54iFjmqVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816683; c=relaxed/simple;
	bh=6Z40ptQy3+7sgVpHB2UepNZjIc6ChCy6z4IK6lMGdLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWAkJOqDW4K4b07OJmdK7iEzbRgKmkkeQpKyUg8GgRTg7FXuR0c5kQn+Ge/oIHtOUufdxTo5p8jOR6lwJfEgXWq0X9dnjOvPF0j/keZSwhDTSJkfHffuwid3W2O6cRgDyjd/HvkDI57iurIzi9PYaUV/kmlcALz9ZJ0cATYN9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GrK1bcOM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9520420B7167;
	Fri, 30 Jan 2026 15:44:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9520420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769816679;
	bh=B5EEmhhSYF9QgYtGd4E35ssKhysrSZbo9WdMOKGphtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GrK1bcOMVvqUzWvDQ46Bob4NI5kSYJyxgbZNemn/UQng5zjRh4tybiradz0p5yYkC
	 FdkVZpHMOnwkqhSxWdep/rIXWHRyPXAvYR1c4wBlRcWkCQ0tYPTyjq3pVAJ0dI/6d5
	 eAE2S/RJi0+PYEPWQu7ptPRVI74kf8FnourreZU4=
Message-ID: <77bb8175-e893-116d-d076-6c906bbe372d@linux.microsoft.com>
Date: Fri, 30 Jan 2026 15:44:37 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 12/15] x86/hyperv: Implement hyperv virtual iommu
Content-Language: en-US
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-13-mrathor@linux.microsoft.com>
 <20260121211806.000006aa@linux.microsoft.com>
 <34de2049-912e-fc9e-9fc1-727fade0480f@linux.microsoft.com>
 <20260127112144.00002991@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260127112144.00002991@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8625-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: E4F30BF6EC
X-Rspamd-Action: no action

On 1/27/26 11:21, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Fri, 23 Jan 2026 18:01:29 -0800
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
>> On 1/21/26 21:18, Jacob Pan wrote:
>>> Hi Mukesh,
>>>
>>> On Mon, 19 Jan 2026 22:42:27 -0800
>>> Mukesh R <mrathor@linux.microsoft.com> wrote:
>>>    
>>>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>>>
>>>> Add a new file to implement management of device domains, mapping
>>>> and unmapping of iommu memory, and other iommu_ops to fit within
>>>> the VFIO framework for PCI passthru on Hyper-V running Linux as
>>>> root or L1VH parent. This also implements direct attach mechanism
>>>> for PCI passthru, and it is also made to work within the VFIO
>>>> framework.
>>>>
>>>> At a high level, during boot the hypervisor creates a default
>>>> identity domain and attaches all devices to it. This nicely maps
>>>> to Linux iommu subsystem IOMMU_DOMAIN_IDENTITY domain. As a
>>>> result, Linux does not need to explicitly ask Hyper-V to attach
>>>> devices and do maps/unmaps during boot. As mentioned previously,
>>>> Hyper-V supports two ways to do PCI passthru:
>>>>
>>>>     1. Device Domain: root must create a device domain in the
>>>> hypervisor, and do map/unmap hypercalls for mapping and unmapping
>>>> guest RAM. All hypervisor communications use device id of type PCI
>>>> for identifying and referencing the device.
>>>>
>>>>     2. Direct Attach: the hypervisor will simply use the guest's HW
>>>>        page table for mappings, thus the host need not do map/unmap
>>>>        device memory hypercalls. As such, direct attach passthru
>>>> setup during guest boot is extremely fast. A direct attached device
>>>>        must be referenced via logical device id and not via the PCI
>>>>        device id.
>>>>
>>>> At present, L1VH root/parent only supports direct attaches. Also
>>>> direct attach is default in non-L1VH cases because there are some
>>>> significant performance issues with device domain implementation
>>>> currently for guests with higher RAM (say more than 8GB), and that
>>>> unfortunately cannot be addressed in the short term.
>>>>
>>>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>>>> ---
>>>>    MAINTAINERS                     |   1 +
>>>>    arch/x86/include/asm/mshyperv.h |   7 +-
>>>>    arch/x86/kernel/pci-dma.c       |   2 +
>>>>    drivers/iommu/Makefile          |   2 +-
>>>>    drivers/iommu/hyperv-iommu.c    | 876
>>>> ++++++++++++++++++++++++++++++++ include/linux/hyperv.h          |
>>>> 6 + 6 files changed, 890 insertions(+), 4 deletions(-)
>>>>    create mode 100644 drivers/iommu/hyperv-iommu.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 381a0e086382..63160cee942c 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -11741,6 +11741,7 @@ F:	drivers/hid/hid-hyperv.c
>>>>    F:	drivers/hv/
>>>>    F:	drivers/infiniband/hw/mana/
>>>>    F:	drivers/input/serio/hyperv-keyboard.c
>>>> +F:	drivers/iommu/hyperv-iommu.c
>>> Given we are also developing a guest iommu driver on hyperv, I
>>> think it is more clear to name them accordingly. Perhaps,
>>> hyperv-iommu-root.c?
>>
>> well, l1vh is not quite root, more like a parent. But we've been using
>> l1vh root loosely to mean l1vh parent. so probably ok to rename it
>> to hyperv-iommu-root.c. I prefer not calling it parent or something
>> like that.
> yeah, something specific and different than the guest driver will do.
> 
>>>>    F:	drivers/iommu/hyperv-irq.c
>>>>    F:	drivers/net/ethernet/microsoft/
>>>>    F:	drivers/net/hyperv/
>>>> diff --git a/arch/x86/include/asm/mshyperv.h
>>>> b/arch/x86/include/asm/mshyperv.h index 97477c5a8487..e4ccdbbf1d12
>>>> 100644 --- a/arch/x86/include/asm/mshyperv.h
>>>> +++ b/arch/x86/include/asm/mshyperv.h
>>>> @@ -189,16 +189,17 @@ static inline void hv_apic_init(void) {}
>>>>    #endif
>>>>    
>>>>    #if IS_ENABLED(CONFIG_HYPERV_IOMMU)
>>>> -static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
>>>> -{ return false; }       /* temporary */
>>>> +bool hv_pcidev_is_attached_dev(struct pci_dev *pdev);
>>>>    u64 hv_build_devid_oftype(struct pci_dev *pdev, enum
>>>> hv_device_type type); +u64 hv_iommu_get_curr_partid(void);
>>>>    #else	/* CONFIG_HYPERV_IOMMU */
>>>>    static inline bool hv_pcidev_is_attached_dev(struct pci_dev
>>>> *pdev) { return false; }
>>>> -
>>>>    static inline u64 hv_build_devid_oftype(struct pci_dev *pdev,
>>>>    				       enum hv_device_type type)
>>>>    { return 0; }
>>>> +static inline u64 hv_iommu_get_curr_partid(void)
>>>> +{ return HV_PARTITION_ID_INVALID; }
>>>>    
>>>>    #endif	/* CONFIG_HYPERV_IOMMU */
>>>>    
>>>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>>>> index 6267363e0189..cfeee6505e17 100644
>>>> --- a/arch/x86/kernel/pci-dma.c
>>>> +++ b/arch/x86/kernel/pci-dma.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <linux/gfp.h>
>>>>    #include <linux/pci.h>
>>>>    #include <linux/amd-iommu.h>
>>>> +#include <linux/hyperv.h>
>>>>    
>>>>    #include <asm/proto.h>
>>>>    #include <asm/dma.h>
>>>> @@ -105,6 +106,7 @@ void __init pci_iommu_alloc(void)
>>>>    	gart_iommu_hole_init();
>>>>    	amd_iommu_detect();
>>>>    	detect_intel_iommu();
>>>> +	hv_iommu_detect();
>> j
>>> Will this driver be x86 only?
>> Yes for now.
> If there is nothing x86 specific in this driver (assuming the
> hypercalls here are not x86 only), maybe you can move to the generic
> startup code.

It's x86 specific:

         x86_init.iommu.iommu_init = hv_iommu_init


>>>>    	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
>>>>    }
>>>>    
>>>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>>> index 598c39558e7d..cc9774864b00 100644
>>>> --- a/drivers/iommu/Makefile
>>>> +++ b/drivers/iommu/Makefile
>>>> @@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>>>>    obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>>>    obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>>>>    obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>>>> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-irq.o
>>>> +obj-$(CONFIG_HYPERV_IOMMU) += hyperv-irq.o hyperv-iommu.o
>>> DMA and IRQ remapping should be separate
>>
>> not sure i follow.
> In IOMMU subsystem, DMA remapping and IRQ remapping can be turned
> on/off independently. e.g. you could have an option to turn on IRQ
> remapping w/o DMA remapping. But here you tied them together.

oh, you are talking about the config option, yeah, I will move
CONFIG_IRQ_REMAP from Kconfig to here.

>>
>>>>    obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>>>>    obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>>>>    obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
>>>> diff --git a/drivers/iommu/hyperv-iommu.c
>>>> b/drivers/iommu/hyperv-iommu.c new file mode 100644
>>>> index 000000000000..548483fec6b1
>>>> --- /dev/null
>>>> +++ b/drivers/iommu/hyperv-iommu.c
>>>> @@ -0,0 +1,876 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Hyper-V root vIOMMU driver.
>>>> + * Copyright (C) 2026, Microsoft, Inc.
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>> I don't think this is needed since this driver cannot be a module
>>>    
>>>> +#include <linux/pci.h>
>>>> +#include <linux/dmar.h>
>>> should not depend on Intel's DMAR
>>>    
>>>> +#include <linux/dma-map-ops.h>
>>>> +#include <linux/interval_tree.h>
>>>> +#include <linux/hyperv.h>
>>>> +#include "dma-iommu.h"
>>>> +#include <asm/iommu.h>
>>>> +#include <asm/mshyperv.h>
>>>> +
>>>> +/* We will not claim these PCI devices, eg hypervisor needs it for
>>>> debugger */ +static char *pci_devs_to_skip;
>>>> +static int __init hv_iommu_setup_skip(char *str)
>>>> +{
>>>> +	pci_devs_to_skip = str;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +/* hv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
>>>> +__setup("hv_iommu_skip=", hv_iommu_setup_skip);
>>>> +
>>>> +bool hv_no_attdev;	 /* disable direct device attach for
>>>> passthru */ +EXPORT_SYMBOL_GPL(hv_no_attdev);
>>>> +static int __init setup_hv_no_attdev(char *str)
>>>> +{
>>>> +	hv_no_attdev = true;
>>>> +	return 0;
>>>> +}
>>>> +__setup("hv_no_attdev", setup_hv_no_attdev);
>>>> +
>>>> +/* Iommu device that we export to the world. HyperV supports max
>>>> of one */ +static struct iommu_device hv_virt_iommu;
>>>> +
>>>> +struct hv_domain {
>>>> +	struct iommu_domain iommu_dom;
>>>> +	u32 domid_num;			      /* as opposed
>>>> to domain_id.type */
>>>> +	u32 num_attchd;		      /* number of
>>>> currently attached devices */
>>> rename to num_dev_attached?
>>>    
>>>> +	bool attached_dom;		      /* is this direct
>>>> attached dom? */
>>>> +	spinlock_t mappings_lock;	      /* protects
>>>> mappings_tree */
>>>> +	struct rb_root_cached mappings_tree;  /* iova to pa lookup
>>>> tree */ +};
>>>> +
>>>> +#define to_hv_domain(d) container_of(d, struct hv_domain,
>>>> iommu_dom) +
>>>> +struct hv_iommu_mapping {
>>>> +	phys_addr_t paddr;
>>>> +	struct interval_tree_node iova;
>>>> +	u32 flags;
>>>> +};
>>>> +
>>>> +/*
>>>> + * By default, during boot the hypervisor creates one Stage 2 (S2)
>>>> default
>>>> + * domain. Stage 2 means that the page table is controlled by the
>>>> hypervisor.
>>>> + *   S2 default: access to entire root partition memory. This for
>>>> us easily
>>>> + *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu
>>>> subsystem, and
>>>> + *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the
>>>> hypervisor.
>>>> + *
>>>> + * Device Management:
>>>> + *   There are two ways to manage device attaches to domains:
>>>> + *     1. Domain Attach: A device domain is created in the
>>>> hypervisor, the
>>>> + *			 device is attached to this domain, and
>>>> then memory
>>>> + *			 ranges are mapped in the map callbacks.
>>>> + *     2. Direct Attach: No need to create a domain in the
>>>> hypervisor for direct
>>>> + *			 attached devices. A hypercall is made
>>>> to tell the
>>>> + *			 hypervisor to attach the device to a
>>>> guest. There is
>>>> + *			 no need for explicit memory mappings
>>>> because the
>>>> + *			 hypervisor will just use the guest HW
>>>> page table.
>>>> + *
>>>> + * Since a direct attach is much faster, it is the default. This
>>>> can be
>>>> + * changed via hv_no_attdev.
>>>> + *
>>>> + * L1VH: hypervisor only supports direct attach.
>>>> + */
>>>> +
>>>> +/*
>>>> + * Create dummy domain to correspond to hypervisor prebuilt
>>>> default identity
>>>> + * domain (dummy because we do not make hypercall to create them).
>>>> + */
>>>> +static struct hv_domain hv_def_identity_dom;
>>>> +
>>>> +static bool hv_special_domain(struct hv_domain *hvdom)
>>>> +{
>>>> +	return hvdom == &hv_def_identity_dom;
>>>> +}
>>>> +
>>>> +struct iommu_domain_geometry default_geometry = (struct
>>>> iommu_domain_geometry) {
>>>> +	.aperture_start = 0,
>>>> +	.aperture_end = -1UL,
>>>> +	.force_aperture = true,
>>>> +};
>>>> +
>>>> +/*
>>>> + * Since the relevant hypercalls can only fit less than 512 PFNs
>>>> in the pfn
>>>> + * array, report 1M max.
>>>> + */
>>>> +#define HV_IOMMU_PGSIZES (SZ_4K | SZ_1M)
>>>> +
>>>> +static u32 unique_id;	      /* unique numeric id of a new
>>>> domain */ +
>>>> +static void hv_iommu_detach_dev(struct iommu_domain *immdom,
>>>> +				struct device *dev);
>>>> +static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom,
>>>> ulong iova,
>>>> +				   size_t pgsize, size_t pgcount,
>>>> +				   struct iommu_iotlb_gather
>>>> *gather); +
>>>> +/*
>>>> + * If the current thread is a VMM thread, return the partition id
>>>> of the VM it
>>>> + * is managing, else return HV_PARTITION_ID_INVALID.
>>>> + */
>>>> +u64 hv_iommu_get_curr_partid(void)
>>>> +{
>>>> +	u64 (*fn)(pid_t pid);
>>>> +	u64 partid;
>>>> +
>>>> +	fn = symbol_get(mshv_pid_to_partid);
>>>> +	if (!fn)
>>>> +		return HV_PARTITION_ID_INVALID;
>>>> +
>>>> +	partid = fn(current->tgid);
>>>> +	symbol_put(mshv_pid_to_partid);
>>>> +
>>>> +	return partid;
>>>> +}
>>> This function is not iommu specific. Maybe move it to mshv code?
>>
>> Well, it is getting the information from mshv by calling a function
>> there for iommu, and is not needed if no HYPER_IOMMU. So this is
>> probably the best place for it.
>>
> ok, maybe move it to mshv after we have a second user. But the function
> name can be just hv_get_curr_partid(void), no?

it could, but by convention all public funcs here are hv_iommu_xxx..
and other reviewers might object... We really need virt/mshv/
sub directory... not sure if it's worth creating now for just one
function. so maybe we just live with it for now... we do have work
item to move some things from drivers/hv to virt/mshv/ .. so this
can get added to that whenever that happens.

>>>> +
>>>> +/* If this is a VMM thread, then this domain is for a guest VM */
>>>> +static bool hv_curr_thread_is_vmm(void)
>>>> +{
>>>> +	return hv_iommu_get_curr_partid() !=
>>>> HV_PARTITION_ID_INVALID; +}
>>>> +
>>>> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap
>>>> cap) +{
>>>> +	switch (cap) {
>>>> +	case IOMMU_CAP_CACHE_COHERENCY:
>>>> +		return true;
>>>> +	default:
>>>> +		return false;
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Check if given pci device is a direct attached device. Caller
>>>> must have
>>>> + * verified pdev is a valid pci device.
>>>> + */
>>>> +bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
>>>> +{
>>>> +	struct iommu_domain *iommu_domain;
>>>> +	struct hv_domain *hvdom;
>>>> +	struct device *dev = &pdev->dev;
>>>> +
>>>> +	iommu_domain = iommu_get_domain_for_dev(dev);
>>>> +	if (iommu_domain) {
>>>> +		hvdom = to_hv_domain(iommu_domain);
>>>> +		return hvdom->attached_dom;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(hv_pcidev_is_attached_dev);
>>> Attached domain can change anytime, what guarantee does the caller
>>> have?
>>
>> Not sure I understand what can change: the device moving from attached
>> to non-attached? or the domain getting deleted? In any case, this is
>> called from leaf functions, so that should not happen... and it
>> will return false if the device did somehow got removed.
>>
> I was thinking the device can be attached to a different domain type at
> runtime, e.g. via sysfs to identity or DMA. But I guess here is a static
> attachment either for l1vh or root.

That is correct. It is extra work to support that if there is a good
usecase/demand.
  
>>>> +
>>>> +/* Create a new device domain in the hypervisor */
>>>> +static int hv_iommu_create_hyp_devdom(struct hv_domain *hvdom)
>>>> +{
>>>> +	u64 status;
>>>> +	unsigned long flags;
>>>> +	struct hv_input_device_domain *ddp;
>>>> +	struct hv_input_create_device_domain *input;
>>> nit: use consistent coding style, inverse Christmas tree.
>>>    
>>>> +
>>>> +	local_irq_save(flags);
>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +	memset(input, 0, sizeof(*input));
>>>> +
>>>> +	ddp = &input->device_domain;
>>>> +	ddp->partition_id = HV_PARTITION_ID_SELF;
>>>> +	ddp->domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
>>>> +	ddp->domain_id.id = hvdom->domid_num;
>>>> +
>>>> +
>>>> input->create_device_domain_flags.forward_progress_required = 1;
>>>> +	input->create_device_domain_flags.inherit_owning_vtl = 0;
>>>> +
>>>> +	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN,
>>>> input, NULL); +
>>>> +	local_irq_restore(flags);
>>>> +
>>>> +	if (!hv_result_success(status))
>>>> +		hv_status_err(status, "\n");
>>>> +
>>>> +	return hv_result_to_errno(status);
>>>> +}
>>>> +
>>>> +/* During boot, all devices are attached to this */
>>>> +static struct iommu_domain *hv_iommu_domain_alloc_identity(struct
>>>> device *dev) +{
>>>> +	return &hv_def_identity_dom.iommu_dom;
>>>> +}
>>>> +
>>>> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct
>>>> device *dev) +{
>>>> +	struct hv_domain *hvdom;
>>>> +	int rc;
>>>> +
>>>> +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm() &&
>>>> !hv_no_attdev) {
>>>> +		pr_err("Hyper-V: l1vh iommu does not support host
>>>> devices\n");
>>> why is this an error if user input choose not to do direct attach?
>>
>> Like the error message says: on l1vh, direct attaches of host devices
>> (eg dpdk) is not supported. and l1vh only does direct attaches. IOW,
>> no host devices on l1vh.
>>
> This hv_no_attdev flag is really confusing to me, by default
> hv_no_attdev is false, which allows direct attach. And you are saying
> l1vh allows it.

Well, at the time of this design/coding, my understanding was we'd have
mapped devices on l1vh also. But now it looks like that would be bit
later than sooner .. unless AI bots start dumping code of course :) :)..

I could remove it from the if statement and add it when the support
is added, but is harmless and one less thing to remember.

> Why is this flag also controls host device attachment in l1vh? If you
> can tell the difference between direct host device attach and other
> direct attach, why don't you reject always reject host attach in l1vh?
> 
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	hvdom = kzalloc(sizeof(struct hv_domain), GFP_KERNEL);
>>>> +	if (hvdom == NULL)
>>>> +		goto out;
>>>> +
>>>> +	spin_lock_init(&hvdom->mappings_lock);
>>>> +	hvdom->mappings_tree = RB_ROOT_CACHED;
>>>> +
>>>> +	if (++unique_id == HV_DEVICE_DOMAIN_ID_S2_DEFAULT)   /*
>>>> ie, 0 */
>>> This is true only when unique_id wraps around, right? Then this
>>> driver stops working?
>>
>> Correct. It's a u32, so if my math is right, and a device is attached
>> every second, it will take 136 years to wrap! Did i get that right?
>>
> This is still a unnecessary vulnerability.

Device passthru will fail and will not cause any corruption or
data theft issues... can make it u64 if it gives extra peace. not
worth all that mumbo jumbo for almost never gonna happen case.

>>> can you use an IDR for the unique_id and free it as you detach
>>> instead of doing this cyclic allocation?
>>>    
>>>> +		goto out_free;
>>>> +
>>>> +	hvdom->domid_num = unique_id;
>>>> +	hvdom->iommu_dom.geometry = default_geometry;
>>>> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
>>>> +
>>>> +	/* For guests, by default we do direct attaches, so no
>>>> domain in hyp */
>>>> +	if (hv_curr_thread_is_vmm() && !hv_no_attdev)
>>>> +		hvdom->attached_dom = true;
>>>> +	else {
>>>> +		rc = hv_iommu_create_hyp_devdom(hvdom);
>>>> +		if (rc)
>>>> +			goto out_free_id;
>>>> +	}
>>>> +
>>>> +	return &hvdom->iommu_dom;
>>>> +
>>>> +out_free_id:
>>>> +	unique_id--;
>>>> +out_free:
>>>> +	kfree(hvdom);
>>>> +out:
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static void hv_iommu_domain_free(struct iommu_domain *immdom)
>>>> +{
>>>> +	struct hv_domain *hvdom = to_hv_domain(immdom);
>>>> +	unsigned long flags;
>>>> +	u64 status;
>>>> +	struct hv_input_delete_device_domain *input;
>>>> +
>>>> +	if (hv_special_domain(hvdom))
>>>> +		return;
>>>> +
>>>> +	if (hvdom->num_attchd) {
>>>> +		pr_err("Hyper-V: can't free busy iommu domain
>>>> (%p)\n", immdom);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (!hv_curr_thread_is_vmm() || hv_no_attdev) {
>>>> +		struct hv_input_device_domain *ddp;
>>>> +
>>>> +		local_irq_save(flags);
>>>> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +		ddp = &input->device_domain;
>>>> +		memset(input, 0, sizeof(*input));
>>>> +
>>>> +		ddp->partition_id = HV_PARTITION_ID_SELF;
>>>> +		ddp->domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
>>>> +		ddp->domain_id.id = hvdom->domid_num;
>>>> +
>>>> +		status =
>>>> hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input,
>>>> +					 NULL);
>>>> +		local_irq_restore(flags);
>>>> +
>>>> +		if (!hv_result_success(status))
>>>> +			hv_status_err(status, "\n");
>>>> +	}
>>
>>> you could free the domid here, no?
>> sorry, don't follow what you mean by domid, you mean unique_id?
>>
> yes.

no it's just a sequential number with no track of what's used.

>>>> +
>>>> +	kfree(hvdom);
>>>> +}
>>>> +
>>>> +/* Attach a device to a domain previously created in the
>>>> hypervisor */ +static int hv_iommu_att_dev2dom(struct hv_domain
>>>> *hvdom, struct pci_dev *pdev) +{
>>>> +	unsigned long flags;
>>>> +	u64 status;
>>>> +	enum hv_device_type dev_type;
>>>> +	struct hv_input_attach_device_domain *input;
>>>> +
>>>> +	local_irq_save(flags);
>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +	memset(input, 0, sizeof(*input));
>>>> +
>>>> +	input->device_domain.partition_id = HV_PARTITION_ID_SELF;
>>>> +	input->device_domain.domain_id.type =
>>>> HV_DEVICE_DOMAIN_TYPE_S2;
>>>> +	input->device_domain.domain_id.id = hvdom->domid_num;
>>>> +
>>>> +	/* NB: Upon guest shutdown, device is re-attached to the
>>>> default domain
>>>> +	 * without explicit detach.
>>>> +	 */
>>>> +	if (hv_l1vh_partition())
>>>> +		dev_type = HV_DEVICE_TYPE_LOGICAL;
>>>> +	else
>>>> +		dev_type = HV_DEVICE_TYPE_PCI;
>>>> +
>>>> +	input->device_id.as_uint64 = hv_build_devid_oftype(pdev,
>>>> dev_type); +
>>>> +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN,
>>>> input, NULL);
>>>> +	local_irq_restore(flags);
>>>> +
>>>> +	if (!hv_result_success(status))
>>>> +		hv_status_err(status, "\n");
>>>> +
>>>> +	return hv_result_to_errno(status);
>>>> +}
>>>> +
>>>> +/* Caller must have validated that dev is a valid pci dev */
>>>> +static int hv_iommu_direct_attach_device(struct pci_dev *pdev)
>>>> +{
>>>> +	struct hv_input_attach_device *input;
>>>> +	u64 status;
>>>> +	int rc;
>>>> +	unsigned long flags;
>>>> +	union hv_device_id host_devid;
>>>> +	enum hv_device_type dev_type;
>>>> +	u64 ptid = hv_iommu_get_curr_partid();
>>>> +
>>>> +	if (ptid == HV_PARTITION_ID_INVALID) {
>>>> +		pr_err("Hyper-V: Invalid partition id in direct
>>>> attach\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (hv_l1vh_partition())
>>>> +		dev_type = HV_DEVICE_TYPE_LOGICAL;
>>>> +	else
>>>> +		dev_type = HV_DEVICE_TYPE_PCI;
>>>> +
>>>> +	host_devid.as_uint64 = hv_build_devid_oftype(pdev,
>>>> dev_type); +
>>>> +	do {
>>>> +		local_irq_save(flags);
>>>> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +		memset(input, 0, sizeof(*input));
>>>> +		input->partition_id = ptid;
>>>> +		input->device_id = host_devid;
>>>> +
>>>> +		/* Hypervisor associates logical_id with this
>>>> device, and in
>>>> +		 * some hypercalls like retarget interrupts,
>>>> logical_id must be
>>>> +		 * used instead of the BDF. It is a required
>>>> parameter.
>>>> +		 */
>>>> +		input->attdev_flags.logical_id = 1;
>>>> +		input->logical_devid =
>>>> +			   hv_build_devid_oftype(pdev,
>>>> HV_DEVICE_TYPE_LOGICAL); +
>>>> +		status = hv_do_hypercall(HVCALL_ATTACH_DEVICE,
>>>> input, NULL);
>>>> +		local_irq_restore(flags);
>>>> +
>>>> +		if (hv_result(status) ==
>>>> HV_STATUS_INSUFFICIENT_MEMORY) {
>>>> +			rc = hv_call_deposit_pages(NUMA_NO_NODE,
>>>> ptid, 1);
>>>> +			if (rc)
>>>> +				break;
>>>> +		}
>>>> +	} while (hv_result(status) ==
>>>> HV_STATUS_INSUFFICIENT_MEMORY); +
>>>> +	if (!hv_result_success(status))
>>>> +		hv_status_err(status, "\n");
>>>> +
>>>> +	return hv_result_to_errno(status);
>>>> +}
>>>> +
>>>> +/* This to attach a device to both host app (like DPDK) and a
>>>> guest VM */
>>> The IOMMU driver should be agnostic to the type of consumer,
>>> whether a userspace driver or a VM. This comment is not necessary.
>>>    
>>>> +static int hv_iommu_attach_dev(struct iommu_domain *immdom,
>>>> struct device *dev,
>>>> +			       struct iommu_domain *old)
>>> This does not match upstream kernel prototype, which kernel version
>>> is this based on? I will stop here for now.
>>
>> As I mentioned in the cover letter:
>>            Based on: 8f0b4cce4481 (origin/hyperv-next)
>>
> where is this repo?

https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
branch: hyperv-next

All our hyperv/mshv related patch submissions are merged there
first by Wei.

Thanks,
-Mukesh

.. deleted ......

