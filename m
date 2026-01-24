Return-Path: <linux-hyperv+bounces-8507-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OSBD+UVdGk32AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8507-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:44:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D10747BC55
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39E5F300645C
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 00:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C381CAA79;
	Sat, 24 Jan 2026 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fHMkUJRd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA38635D;
	Sat, 24 Jan 2026 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215456; cv=none; b=EEMk+k7Meec4r0KeLRDk6HDbCW+b509vnjS3dIhXSeyVokIHegSQgzlMiVqp1il45rZZG8LoXPeND4zLlZv7FTIy6RoeLUO6/QEcZWp5msZMh6Fdp6dSM09MRIg2OjDRuJZ2Tso+QCjcGMPy9pbyiSQYYGFnXR1pTXaJkJ676ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215456; c=relaxed/simple;
	bh=XyKtovemWRCdqyaftcm1jG5cLugQpSmjILheeX8WD8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOQlWmoqle5euG11LCShzDVRYRdHmB5rqYOQocPfjH/bKRHthVjOXeld39LrHaVrB0+yX1jl1vM5Y0sL7SbBsfpbKWKy88693UW2bW8IJ+H1IctlwLGvMNRSONSDNkqSlugBkTPj5FXUykcta6zcG1lBVbiG2z9AeeW6f70DfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fHMkUJRd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 463CC20B7167;
	Fri, 23 Jan 2026 16:44:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 463CC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769215443;
	bh=/jlW+NHyTvf60QbY7cZWvOxIhSju/A15jcdqLApHKow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHMkUJRdkFe3V3sABlZHyFtoAfYiThgCmtTel/KJ7P4D5K/tdme/GrXTsp57AM7MU
	 dS8KBvYoFiTDkGEVI6YttPyGqkOY6sYxAJFsDxY8WF5O1HtkAwtXhyDUBMoRl3CiJJ
	 8/32edQIN5vJ0CED3gQ02lJtQxYkUg7ZP57LE0KU=
Message-ID: <8302b48c-bd78-6348-eef2-be957d0e8bc4@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:44:01 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 11/15] x86/hyperv: Build logical device ids for PCI
 passthru hcalls
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-12-mrathor@linux.microsoft.com>
 <aXABVTS6xDb2GB2s@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXABVTS6xDb2GB2s@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8507-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: D10747BC55
X-Rspamd-Action: no action

On 1/20/26 14:27, Stanislav Kinsburskii wrote:
> On Mon, Jan 19, 2026 at 10:42:26PM -0800, Mukesh R wrote:
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>
>> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
>> interrupts, etc need a device id as a parameter. A device id refers
>> to a specific device. A device id is of two types:
>>     o Logical: used for direct attach (see below) hypercalls. A logical
>>                device id is a unique 62bit value that is created and
>>                sent during the initial device attach. Then all further
>>                communications (for interrupt remaps etc) must use this
>>                logical id.
>>     o PCI: used for device domain hypercalls such as map, unmap, etc.
>>            This is built using actual device BDF info.
>>
>>     PS: Since an L1VH only supports direct attaches, a logical device id
>>         on an L1VH VM is always a VMBus device id. For non-L1VH cases,
>>         we just use PCI BDF info, altho not strictly needed, to build the
>>         logical device id.
>>
>> At a high level, Hyper-V supports two ways to do PCI passthru:
>>    1. Device Domain: root must create a device domain in the hypervisor,
>>       and do map/unmap hypercalls for mapping and unmapping guest RAM.
>>       All hypervisor communications use device id of type PCI for
>>       identifying and referencing the device.
>>
>>    2. Direct Attach: the hypervisor will simply use the guest's HW
>>       page table for mappings, thus the host need not do map/unmap
>>       hypercalls. A direct attached device must be referenced
>>       via logical device id and never via the PCI device id. For an
>>       L1VH root/parent, Hyper-V only supports direct attaches.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/irqdomain.c     | 60 ++++++++++++++++++++++++++++++---
>>   arch/x86/include/asm/mshyperv.h | 14 ++++++++
>>   2 files changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index ccbe5848a28f..33017aa0caa4 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -137,7 +137,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
>>   	return 0;
>>   }
>>   
>> -static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
>> +static u64 hv_build_devid_type_pci(struct pci_dev *pdev)
>>   {
>>   	int pos;
>>   	union hv_device_id hv_devid;
>> @@ -197,7 +197,58 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
>>   	}
>>   
>>   out:
>> -	return hv_devid;
>> +	return hv_devid.as_uint64;
>> +}
>> +
>> +/* Build device id for direct attached devices */
>> +static u64 hv_build_devid_type_logical(struct pci_dev *pdev)
>> +{
>> +	hv_pci_segment segment;
>> +	union hv_device_id hv_devid;
>> +	union hv_pci_bdf bdf = {.as_uint16 = 0};
>> +	struct rid_data data = {
>> +		.bridge = NULL,
>> +		.rid = PCI_DEVID(pdev->bus->number, pdev->devfn)
>> +	};
>> +
>> +	segment = pci_domain_nr(pdev->bus);
>> +	bdf.bus = PCI_BUS_NUM(data.rid);
>> +	bdf.device = PCI_SLOT(data.rid);
>> +	bdf.function = PCI_FUNC(data.rid);
>> +
>> +	hv_devid.as_uint64 = 0;
>> +	hv_devid.device_type = HV_DEVICE_TYPE_LOGICAL;
>> +	hv_devid.logical.id = (u64)segment << 16 | bdf.as_uint16;
>> +
>> +	return hv_devid.as_uint64;
>> +}
>> +
>> +/* Build device id after the device has been attached */
>> +u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type)
>> +{
>> +	if (type == HV_DEVICE_TYPE_LOGICAL) {
>> +		if (hv_l1vh_partition())
>> +			return hv_pci_vmbus_device_id(pdev);
> 
> Should this one be renamed into hv_build_devid_type_vmbus() to align
> with the other two function names?

No, because hyperv only defines two types of device ids, and it would
unnecessary at to confusion. vmbus uses one the two types of device
ids.


> Thanks,
> Stanislav
> 
>> +		else
>> +			return hv_build_devid_type_logical(pdev);
>> +	} else if (type == HV_DEVICE_TYPE_PCI)
>> +		return hv_build_devid_type_pci(pdev);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_build_devid_oftype);
>> +
>> +/* Build device id for the interrupt path */
>> +static u64 hv_build_irq_devid(struct pci_dev *pdev)
>> +{
>> +	enum hv_device_type dev_type;
>> +
>> +	if (hv_pcidev_is_attached_dev(pdev) || hv_l1vh_partition())
>> +		dev_type = HV_DEVICE_TYPE_LOGICAL;
>> +	else
>> +		dev_type = HV_DEVICE_TYPE_PCI;
>> +
>> +	return hv_build_devid_oftype(pdev, dev_type);
>>   }
>>   
>>   /*
>> @@ -221,7 +272,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
>>   
>>   	msidesc = irq_data_get_msi_desc(data);
>>   	pdev = msi_desc_to_pci_dev(msidesc);
>> -	hv_devid = hv_build_devid_type_pci(pdev);
>> +	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
>>   	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
>>   
>>   	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
>> @@ -296,7 +347,8 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>>   {
>>   	union hv_device_id hv_devid;
>>   
>> -	hv_devid = hv_build_devid_type_pci(pdev);
>> +	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
>> +
>>   	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
>>   }
>>   
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 0d7fdfb25e76..97477c5a8487 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -188,6 +188,20 @@ bool hv_vcpu_is_preempted(int vcpu);
>>   static inline void hv_apic_init(void) {}
>>   #endif
>>   
>> +#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
>> +static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
>> +{ return false; }       /* temporary */
>> +u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type);
>> +#else	/* CONFIG_HYPERV_IOMMU */
>> +static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
>> +{ return false; }
>> +
>> +static inline u64 hv_build_devid_oftype(struct pci_dev *pdev,
>> +				       enum hv_device_type type)
>> +{ return 0; }
>> +
>> +#endif	/* CONFIG_HYPERV_IOMMU */
>> +
>>   u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
>>   
>>   struct irq_domain *hv_create_pci_msi_domain(void);
>> -- 
>> 2.51.2.vfs.0.1
>>
> 
> 
> 
> 
> 
> 
> 
> 


