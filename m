Return-Path: <linux-hyperv+bounces-11056-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALMTJQ7WDWrW3wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11056-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:41:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DB591166
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C47C311F862
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488B3F44CB;
	Wed, 20 May 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QDNWc/N/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4623EFFC2;
	Wed, 20 May 2026 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290749; cv=none; b=RHdWhpAwGSxbS8Q9QjYfiRPNxbAryiZxH9XvxUU57lsNU2G/04J2YtMk1yhjWIHd3B35mSo6tSJogiSAgIDEluSx3DUHm040qXcmxkjFFRIQTcGnr6zA2DIEDyNFClpxHfkkQc7x9zp1PI/837nNfHhR42eEzhhpteKY4iP7seY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290749; c=relaxed/simple;
	bh=N8v1TFwIcRepmhHw+LYodNL/Ros4EWutz27w5aCYrcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSCdB2cOlMIflO3Dusfv2+YI2x/HRpFL+DVXgyAPCb4CHHMkJJbKbg/JnL4zs6fQF3cF+6FfXOB5lWJm5uJxmEZTNApFTFA4giqJt7BYDq+cwjSbZsJjhU8uFmvUdKiMGtOk6lPB9LvHIDRLTqiPJcKUoZr+tSni5ct8o/rj5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QDNWc/N/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AC1220B7167;
	Wed, 20 May 2026 08:25:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AC1220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779290739;
	bh=fuhHbAWU/Rywr/2br9PfQtPvQkxr3+PATatPCz/45xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDNWc/N/td8GAkdHve4xy29qi1nqOsSi1dTH2agpxuaywjQKx+4/GCXhO5c5dW+xh
	 VEFRsS1BYHYGwxj901Fkt0Yhej5+0xBrJ2pqrJCIQgVifeAvpnUUmWNhgkRgz20Lo6
	 z5PlhjSt57RuLJ8Gu02vDynkkJGGqNNhn3Cd6eTI=
Date: Wed, 20 May 2026 23:25:43 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, mhklinux@outlook.com, 
	jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <yqhb6vxoovscvfafgv6i6zn7uydpfxeff7hqmvbn6z7c2tjqp6@jn2vvtxqgfef>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <20260515223139.GK7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515223139.GK7702@ziepe.ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11056-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 330DB591166
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 07:31:39PM -0300, Jason Gunthorpe wrote:
> On Tue, May 12, 2026 at 12:24:07AM +0800, Yu Zhang wrote:
> > +/*
> > + * Identity and blocking domains are static singletons: identity is a 1:1
> > + * passthrough with no page table, blocking rejects all DMA. Neither holds
> > + * per-IOMMU state, so one instance suffices even with multiple vIOMMUs.
> > + */
> > +static struct hv_iommu_domain hv_identity_domain;
> > +static struct hv_iommu_domain hv_blocking_domain;
> > +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> > +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
> 
> Please follow the format of other drivers and statically initialize
> these here instead of in C code.
> 

Thanks! Will do.

> > +static struct iommu_ops hv_iommu_ops;
> > +static LIST_HEAD(hv_iommu_pci_bus_list);
> > +static DEFINE_SPINLOCK(hv_iommu_pci_bus_lock);
> > +
> > +#define hv_iommu_present(iommu_cap) (iommu_cap & HV_IOMMU_CAP_PRESENT)
> > +#define hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1)
> > +#define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1_5LVL)
> > +#define hv_iommu_ats_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_ATS)
> 
> prefer to see static inlines
> 

Yes. Thanks.

> > +static void hv_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_detach_device_domain *input;
> > +	struct pci_dev *pdev;
> > +	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +
> > +	/* See the attach function, only PCI devices for now */
> > +	if (!dev_is_pci(dev) || vdev->hv_domain != hv_domain)
> > +		return;
> > +
> > +	pdev = to_pci_dev(dev);
> > +
> > +	dev_dbg(dev, "detaching from domain %d\n", hv_domain->device_domain.domain_id.id);
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->partition_id = HV_PARTITION_ID_SELF;
> > +	if (hv_iommu_lookup_logical_dev_id(pdev, &input->device_id.as_uint64)) {
> > +		local_irq_restore(flags);
> > +		dev_warn(&pdev->dev, "no IOMMU registration for vPCI bus on detach\n");
> > +		return;
> > +	}
> > +	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
> 
> FWIW the hypervisor cannot implement the linux attach semantics if it
> has detach/attach. It must support simply 'attach' which atomically
> changes the translation. With detach you have a confusing problem if
> errors happen in the middle of the sequence the device is left in an
> unclear state. You should at least document what state the hypervisor
> is supposed to leaave the translation iin during these failures..
> 

Thanks for raising this!

My understanding is that the detach hypercall just clears the HW
IOMMU entry for the device (e.g., context table entry on VT-d, DTE
on AMD IOMMU) and flushes the IOTLB. So after detach and before the
subsequent attach, DMA from the device is blocked by the HW IOMMU
- the device is not in an unprotected state.

The detach shall not fail unless the pvIOMMU driver passes incorrect
parameters or is otherwise in a buggy state, or Hyper-V itself has
a bug. 

But making attach atomic might be a cleaner approach (drop the
explicit detach and let the hypervisor handle the domain switch
internally)? I'll look into making that work, though it needs
verification (and possibly changes) on the hypervisor side (these
hypercalls are not exclusively for Linux guest). If that doesn't
work out, I'll keep the two-step approach with comments documenting
the intermediate translation state.

> > +static void hv_iommu_release_device(struct device *dev)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> > +
> > +	dev_iommu_priv_set(dev, NULL);
> > +	set_dma_ops(dev, NULL);
> 
> Does the driver really need to mess with set_dma_ops ? I'd rather not
> see that in new iommu drivers if at all possible :|
> 

No. I should have removed it. Thanks!

> > +static int __init hv_initialize_static_domains(void)
> > +{
> > +	int ret;
> > +	struct hv_iommu_domain *hv_domain;
> > +
> > +	/* Default stage-1 identity domain */
> > +	hv_domain = &hv_identity_domain;
> > +
> > +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> > +	if (ret)
> > +		goto delete_identity_domain;
> > +
> > +	hv_domain->domain.type = IOMMU_DOMAIN_IDENTITY;
> > +	hv_domain->domain.ops = &hv_iommu_identity_domain_ops;
> > +	hv_domain->domain.owner = &hv_iommu_ops;
> > +	hv_domain->domain.geometry = hv_iommu_device->geometry;
> > +	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
> 
> identity doesn't use geometry or pgsize_bitmap
> 

Sure. Will remove it.

> > +	/* Default stage-1 blocked domain */
> > +	hv_domain = &hv_blocking_domain;
> > +
> > +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> > +	if (ret)
> > +		goto delete_identity_domain;
> > +
> > +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
> > +	if (ret)
> > +		goto delete_blocked_domain;
> > +
> > +	hv_domain->domain.type = IOMMU_DOMAIN_BLOCKED;
> > +	hv_domain->domain.ops = &hv_iommu_blocking_domain_ops;
> > +	hv_domain->domain.owner = &hv_iommu_ops;
> > +	hv_domain->domain.geometry = hv_iommu_device->geometry;
> > +	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
> 
> Nor does blocked
> 

Same. Will remove.

> > +#define INTERRUPT_RANGE_START	(0xfee00000)
> > +#define INTERRUPT_RANGE_END	(0xfeefffff)
> > +static void hv_iommu_get_resv_regions(struct device *dev,
> > +		struct list_head *head)
> > +{
> > +	struct iommu_resv_region *region;
> > +
> > +	region = iommu_alloc_resv_region(INTERRUPT_RANGE_START,
> > +				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
> > +				      0, IOMMU_RESV_MSI, GFP_KERNEL);
> 
> Surprised these constants are not discovered from the hv?
> 

Thanks. Since the pvIOMMU currently only targets x86, hardcoding
the x86 architectural MSI range should be reasonable?

If in the future we need additional reserved regions (e.g.,
RMRR-style identity-mapped ranges), those would be discovered
from the hypervisor.

> > +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> > +{
> > +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> > +}
> > +
> > +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> > +				struct iommu_iotlb_gather *iotlb_gather)
> > +{
> > +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> > +
> > +	iommu_put_pages_list(&iotlb_gather->freelist);
> > +}
> 
> Full invalidation only huh?
> 

Page-selective IOTLB flush is added in patch 4/4.

> > +static const struct iommu_domain_ops hv_iommu_identity_domain_ops = {
> > +	.attach_dev	= hv_iommu_attach_dev,
> > +};
> > +
> > +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops = {
> > +	.attach_dev	= hv_iommu_attach_dev,
> > +};
> 
> Usually I would expect these to have their own attach
> functions. blocking in particular must have an attach op that cannot
> fail. It is used to recover the device back to a known translation in
> case of cascading other errors.
> 

For blocking domain, the hypercall handler of such attach essentially
disable the translation and IOPF for the device. It should not fail
unless there is a bug in the driver or the hypervisor.
How about something like this?

	static int hv_blocking_attach_dev(domain, dev, old)
	{
		...
		status = hv_do_hypercall(HVCALL_ATTACH, blocking, dev);
		WARN_ON(!hv_result_success(status));
		vdev->hv_domain = blocking;
		return 0;
	}

For identity domain, would it be fine to keep sharing the same attach
callback with paging domain?

> > +static const struct iommu_domain_ops hv_iommu_paging_domain_ops = {
> > +	.attach_dev	= hv_iommu_attach_dev,
> > +	IOMMU_PT_DOMAIN_OPS(x86_64),
> > +	.flush_iotlb_all = hv_iommu_flush_iotlb_all,
> > +	.iotlb_sync = hv_iommu_iotlb_sync,
> > +	.free = hv_iommu_paging_domain_free,
> > +};
> > +
> > +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> > +{
> > +	int ret;
> > +	struct hv_iommu_domain *hv_domain;
> > +	struct pt_iommu_x86_64_cfg cfg = {};
> > +
> > +	hv_domain = kzalloc_obj(*hv_domain, GFP_KERNEL);
> > +	if (!hv_domain)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> > +	if (ret) {
> > +		kfree(hv_domain);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	hv_domain->domain.geometry = hv_iommu_device->geometry;
> 
> geoemtry shouldn't be set here, it is overriden by
> pt_iommu_x86_64_init() with the exact page table configuration
> 

Right. Will remove.
> > +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> > +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> > +{
> > +	ida_init(&hv_iommu->domain_ids);
> > +
> > +	hv_iommu->cap = hv_iommu_cap->iommu_cap;
> > +	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
> > +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> > +	    hv_iommu->max_iova_width > 48) {
> > +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> > +		hv_iommu->max_iova_width = 48;
> > +	}
> > +
> > +	hv_iommu->geometry = (struct iommu_domain_geometry) {
> > +		.aperture_start = 0,
> > +		.aperture_end = (((u64)1) << hv_iommu->max_iova_width) - 1,
> > +		.force_aperture = true,
> > +	};
> > +
> > +	hv_iommu->first_domain = HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> > +	hv_iommu->last_domain = HV_DEVICE_DOMAIN_ID_NULL - 1;
> > +	/* Only x86 page sizes (4K/2M/1G) are supported */
> > +	hv_iommu->pgsize_bitmap = hv_iommu_cap->pgsize_bitmap &
> > +				  (SZ_4K | SZ_2M | SZ_1G);
> > +	if (hv_iommu->pgsize_bitmap != hv_iommu_cap->pgsize_bitmap)
> > +		pr_warn("unsupported page sizes masked: 0x%llx -> 0x%llx\n",
> > +			hv_iommu_cap->pgsize_bitmap, hv_iommu->pgsize_bitmap);
> 
> IKD if you need this logic, the way the page table code is used it
> just sort of falls out naturally that other page sizes are ignored.
> 

Right, the page table code can handle 4K/2M/1G naturally. We'd like
hypervisor to be able to choose to support only a subset of {4K, 2M,
1G}. This masking filters out any unexpected page sizes and falls
back to 4K if nothing valid remains.

The if statement may be a bit paranoid perhaps, but it felt safer
to validate explicitly. Happy to drop it if you think it's unnecessary.


> > +struct hv_iommu_domain {
> > +	union {
> > +		struct iommu_domain    domain;
> > +		struct pt_iommu        pt_iommu;
> > +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> > +	};
> 
> You should retain the build assertions here
> 

Sure. Thanks!

B.R.
Yu

> Jason
> 

