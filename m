Return-Path: <linux-hyperv+bounces-8394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ATgNncEcGmUUgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8394-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 23:40:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 848804D1E9
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 23:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 554F39496A2
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 22:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE747ECD1;
	Tue, 20 Jan 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LR/P3vCX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA8329E43;
	Tue, 20 Jan 2026 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948076; cv=none; b=Mb2LyHlrWkAYWHKfUcF07H7nZoHhS3zbaqv0za/wZUpCEHUsOm9O5DbDFafMNkHgVapt+Sld6CU81NpcVJN1R2UlI3qv+6dgnxneth14e1h+LfsXPnaPg4FOHzinzUl44D0NeSe/QQ3Q66ULGb0qWG8iydBeV2y6SmzvgdCBQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948076; c=relaxed/simple;
	bh=meBHf+PRAy3RVYIIvJwzRqHHYWt1bKNjploxW9YFjFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2zVul4RjuUSzT1mtmTBvG0VWgSG0auSBDJF+x3OTbixdsMOPIt7j2xhQoJ7fZHYIfXLGY+Z6CgbuF8xdOhgAKVy8EXQ7nNAVYFxP+DeK+1kh1h/8QShgq4cpiVRidkgvIwN+Vb0LLZYXVNguxz9iQmvKIhionwDn6CE3NF2MTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LR/P3vCX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 96EF920B7167;
	Tue, 20 Jan 2026 14:27:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96EF920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768948055;
	bh=TtQ2QoYLJn1s3uHte30pNr+WHXuCyKS2txAnzP8/+HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LR/P3vCX7xx8DrCzcPc++LOlapP4HKNSuldXE0UBzrxPMGofDX924TfgdmPc+ywVP
	 d9tvKFbY3fAV7eFuRUBoG4HnEtZuxP5pCMeyEkS/5Cmn8OyH6MRx4SYrBQulX7Z+e0
	 UXW3pctUG9dDqf2MqdXnnpmCFzK3mLQJYhMhM5to=
Date: Tue, 20 Jan 2026 14:27:33 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 11/15] x86/hyperv: Build logical device ids for PCI
 passthru hcalls
Message-ID: <aXABVTS6xDb2GB2s@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-12-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-12-mrathor@linux.microsoft.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-8394-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 848804D1E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:42:26PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device id as a parameter. A device id refers
> to a specific device. A device id is of two types:
>    o Logical: used for direct attach (see below) hypercalls. A logical
>               device id is a unique 62bit value that is created and
>               sent during the initial device attach. Then all further
>               communications (for interrupt remaps etc) must use this
>               logical id.
>    o PCI: used for device domain hypercalls such as map, unmap, etc.
>           This is built using actual device BDF info.
> 
>    PS: Since an L1VH only supports direct attaches, a logical device id
>        on an L1VH VM is always a VMBus device id. For non-L1VH cases,
>        we just use PCI BDF info, altho not strictly needed, to build the
>        logical device id.
> 
> At a high level, Hyper-V supports two ways to do PCI passthru:
>   1. Device Domain: root must create a device domain in the hypervisor,
>      and do map/unmap hypercalls for mapping and unmapping guest RAM.
>      All hypervisor communications use device id of type PCI for
>      identifying and referencing the device.
> 
>   2. Direct Attach: the hypervisor will simply use the guest's HW
>      page table for mappings, thus the host need not do map/unmap
>      hypercalls. A direct attached device must be referenced
>      via logical device id and never via the PCI device id. For an
>      L1VH root/parent, Hyper-V only supports direct attaches.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 60 ++++++++++++++++++++++++++++++---
>  arch/x86/include/asm/mshyperv.h | 14 ++++++++
>  2 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index ccbe5848a28f..33017aa0caa4 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -137,7 +137,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
>  	return 0;
>  }
>  
> -static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
> +static u64 hv_build_devid_type_pci(struct pci_dev *pdev)
>  {
>  	int pos;
>  	union hv_device_id hv_devid;
> @@ -197,7 +197,58 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
>  	}
>  
>  out:
> -	return hv_devid;
> +	return hv_devid.as_uint64;
> +}
> +
> +/* Build device id for direct attached devices */
> +static u64 hv_build_devid_type_logical(struct pci_dev *pdev)
> +{
> +	hv_pci_segment segment;
> +	union hv_device_id hv_devid;
> +	union hv_pci_bdf bdf = {.as_uint16 = 0};
> +	struct rid_data data = {
> +		.bridge = NULL,
> +		.rid = PCI_DEVID(pdev->bus->number, pdev->devfn)
> +	};
> +
> +	segment = pci_domain_nr(pdev->bus);
> +	bdf.bus = PCI_BUS_NUM(data.rid);
> +	bdf.device = PCI_SLOT(data.rid);
> +	bdf.function = PCI_FUNC(data.rid);
> +
> +	hv_devid.as_uint64 = 0;
> +	hv_devid.device_type = HV_DEVICE_TYPE_LOGICAL;
> +	hv_devid.logical.id = (u64)segment << 16 | bdf.as_uint16;
> +
> +	return hv_devid.as_uint64;
> +}
> +
> +/* Build device id after the device has been attached */
> +u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type)
> +{
> +	if (type == HV_DEVICE_TYPE_LOGICAL) {
> +		if (hv_l1vh_partition())
> +			return hv_pci_vmbus_device_id(pdev);

Should this one be renamed into hv_build_devid_type_vmbus() to align
with the other two function names?

Thanks,
Stanislav

> +		else
> +			return hv_build_devid_type_logical(pdev);
> +	} else if (type == HV_DEVICE_TYPE_PCI)
> +		return hv_build_devid_type_pci(pdev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_build_devid_oftype);
> +
> +/* Build device id for the interrupt path */
> +static u64 hv_build_irq_devid(struct pci_dev *pdev)
> +{
> +	enum hv_device_type dev_type;
> +
> +	if (hv_pcidev_is_attached_dev(pdev) || hv_l1vh_partition())
> +		dev_type = HV_DEVICE_TYPE_LOGICAL;
> +	else
> +		dev_type = HV_DEVICE_TYPE_PCI;
> +
> +	return hv_build_devid_oftype(pdev, dev_type);
>  }
>  
>  /*
> @@ -221,7 +272,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
>  
>  	msidesc = irq_data_get_msi_desc(data);
>  	pdev = msi_desc_to_pci_dev(msidesc);
> -	hv_devid = hv_build_devid_type_pci(pdev);
> +	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
>  	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
>  
>  	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
> @@ -296,7 +347,8 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>  {
>  	union hv_device_id hv_devid;
>  
> -	hv_devid = hv_build_devid_type_pci(pdev);
> +	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
> +
>  	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
>  }
>  
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 0d7fdfb25e76..97477c5a8487 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -188,6 +188,20 @@ bool hv_vcpu_is_preempted(int vcpu);
>  static inline void hv_apic_init(void) {}
>  #endif
>  
> +#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
> +static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
> +{ return false; }       /* temporary */
> +u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type);
> +#else	/* CONFIG_HYPERV_IOMMU */
> +static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
> +{ return false; }
> +
> +static inline u64 hv_build_devid_oftype(struct pci_dev *pdev,
> +				       enum hv_device_type type)
> +{ return 0; }
> +
> +#endif	/* CONFIG_HYPERV_IOMMU */
> +
>  u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
>  
>  struct irq_domain *hv_create_pci_msi_domain(void);
> -- 
> 2.51.2.vfs.0.1
> 










