Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD28F3DF4E0
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhHCSlF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 14:41:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34654 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbhHCSlF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 14:41:05 -0400
Received: from [192.168.1.115] (unknown [223.178.56.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED6F4208AB1A;
        Tue,  3 Aug 2021 11:40:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED6F4208AB1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628016054;
        bh=HCe3GshWTF7vPJaEOofUaKnKzeINHIBZgPnnV5jC2+0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mHZgfl1Q5lJPQVPX9SoXjFNffyQd154C3GYng+WnVdmQuXOaOWJ+wjQ/17TCrJkBn
         az9me95RrkjyJ9knQ6lP/rPHR20eA2rCcm05E2fBci6t9URSfPF27JouSoZjYuDWaP
         IWxiJRtYcxk+787gLGL0VPqkWFJNWb1jw2rIPYh0=
Subject: Re: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-6-wei.liu@kernel.org>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 00:10:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-6-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 09-07-2021 17:13, Wei Liu wrote:
> +static void hv_iommu_domain_free(struct iommu_domain *d)
> +{
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	unsigned long flags;
> +	u64 status;
> +	struct hv_input_delete_device_domain *input;
> +
> +	if (is_identity_domain(domain) || is_null_domain(domain))
> +		return;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain= domain->device_domain;
> +
> +	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);

Is it OK to deallocate the resources, if hypercall has failed ?
Do we have any specific error code EBUSY (kind of) which we need to wait upon ?

> +
> +	ida_free(&domain->hv_iommu->domain_ids, domain->device_domain.domain_id.id);
> +
> +	iommu_put_dma_cookie(d);
> +
> +	kfree(domain);
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *d, struct device *dev)
> +{
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_attach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	/* Only allow PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	dev_dbg(dev, "Attaching (%strusted) to %d\n", pdev->untrusted ? "un" : "",
> +		domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain = domain->device_domain;
> +	input->device_id = hv_build_pci_dev_id(pdev);
> +
> +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);

Does it make sense to vdev->domain = NULL ?

> +	else
> +		vdev->domain = domain;
> +
> +	return hv_status_to_errno(status);
> +}
> +
> +static void hv_iommu_detach_dev(struct iommu_domain *d, struct device *dev)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_detach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	/* See the attach function, only PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	dev_dbg(dev, "Detaching from %d\n", domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	input->device_id = hv_build_pci_dev_id(pdev);
> +
> +	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	vdev->domain = NULL;
> +}
> +
> +static int hv_iommu_add_mapping(struct hv_iommu_domain *domain, unsigned long iova,
> +		phys_addr_t paddr, size_t size, u32 flags)
> +{
> +	unsigned long irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_ATOMIC);
> +	if (!mapping)
> +		return -ENOMEM;
> +
> +	mapping->paddr = paddr;
> +	mapping->iova.start = iova;
> +	mapping->iova.last = iova + size - 1;
> +	mapping->flags = flags;
> +
> +	spin_lock_irqsave(&domain->mappings_lock, irqflags);
> +	interval_tree_insert(&mapping->iova, &domain->mappings);
> +	spin_unlock_irqrestore(&domain->mappings_lock, irqflags);
> +
> +	return 0;
> +}
> +
> +static size_t hv_iommu_del_mappings(struct hv_iommu_domain *domain,
> +		unsigned long iova, size_t size)
> +{
> +	unsigned long flags;
> +	size_t unmapped = 0;
> +	unsigned long last = iova + size - 1;
> +	struct hv_iommu_mapping *mapping = NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&domain->mappings_lock, flags);
> +	next = interval_tree_iter_first(&domain->mappings, iova, last);
> +	while (next) {
> +		node = next;
> +		mapping = container_of(node, struct hv_iommu_mapping, iova);
> +		next = interval_tree_iter_next(node, iova, last);
> +
> +		/* Trying to split a mapping? Not supported for now. */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		unmapped += mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &domain->mappings);
> +		kfree(mapping);
> +	}
> +	spin_unlock_irqrestore(&domain->mappings_lock, flags);
> +
> +	return unmapped;
> +}
> +
> +static int hv_iommu_map(struct iommu_domain *d, unsigned long iova,
> +			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +	u32 map_flags;
> +	unsigned long flags, pfn, npages;
> +	int ret, i;
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	struct hv_input_map_device_gpa_pages *input;
> +	u64 status;
> +
> +	/* Reject size that's not a whole page */
> +	if (size & ~HV_HYP_PAGE_MASK)
> +		return -EINVAL;
> +
> +	map_flags = HV_MAP_GPA_READABLE; /* Always required */
> +	map_flags |= prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
> +
> +	ret = hv_iommu_add_mapping(domain, iova, paddr, size, flags);
> +	if (ret)
> +		return ret;
> +
> +	npages = size >> HV_HYP_PAGE_SHIFT;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain = domain->device_domain;
> +	input->map_flags = map_flags;
> +	input->target_device_va_base = iova;
> +
> +	pfn = paddr >> HV_HYP_PAGE_SHIFT;
> +	for (i = 0; i < npages; i++) {
> +		input->gpa_page_list[i] = pfn;
> +		pfn += 1;
> +	}
> +
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_GPA_PAGES, npages, 0,
> +			input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +		hv_iommu_del_mappings(domain, iova, size);
> +	}
> +
> +	return hv_status_to_errno(status);
> +}
> +
> +static size_t hv_iommu_unmap(struct iommu_domain *d, unsigned long iova,
> +			   size_t size, struct iommu_iotlb_gather *gather)
> +{
> +	size_t unmapped;
> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> +	unsigned long flags, npages;
> +	struct hv_input_unmap_device_gpa_pages *input;
> +	u64 status;
> +
> +	unmapped = hv_iommu_del_mappings(domain, iova, size);
> +	if (unmapped < size)
> +		return 0;

Is there a case where unmapped > 0 && unmapped < size ?

> +
> +	npages = size >> HV_HYP_PAGE_SHIFT;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain = domain->device_domain;
> +	input->target_device_va_base = iova;
> +
> +	/* Unmap `npages` pages starting from VA base */
> +	status = hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_GPA_PAGES, npages,
> +			0, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	return hv_result_success(status) ? unmapped : 0;
> +}
> +

Regards,

~Praveen.
