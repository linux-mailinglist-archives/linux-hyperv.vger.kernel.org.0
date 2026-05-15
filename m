Return-Path: <linux-hyperv+bounces-10914-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFYNF0IpB2ppsQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10914-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:10:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2775510A3
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8275F3044A7F
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5A48A2A6;
	Fri, 15 May 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RUlk2BUj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF4481FBF;
	Fri, 15 May 2026 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853594; cv=none; b=Yg36O3IRj9bOLAMpGgc0SWdxETREez/IDqMwoE5SHpld3fNvLygmfs9mf1g/qJHv1EBsLgWDtoDWNY76kUbUSGmnPg8YuB3idKFd+8oaccyZQr7NA6U+PZlGQFuNT1QctDoBFIpgh4XozNmzrf2QGlzM/eygQdwTGo/d6xaLdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853594; c=relaxed/simple;
	bh=9rDbrWH7oI+P9+B0sgevRg+4GvHw9Scqucfl4kTVo6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olrXg9XSDMqWZG3jqMP/Hp2Q/51JxKmZZELmQPBlGdfRtGxp3bn8jaNPyVDGAlFDvAUFf9m2VEYZV3Qe+pIjuNGjKvvFIUHNVeJk7w4EoQ6pOYafWtH++Ooe3ioZiEiG91A1XQSTR5OGRSS0WbWhXF8+O22Suy6PNiryPebPdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RUlk2BUj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA1CE20B7167;
	Fri, 15 May 2026 06:59:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA1CE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778853580;
	bh=u15DL1s7QBEMCZ16Cu+IWH6vivivK8AOVw81EtZOwgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUlk2BUjK6Nouh3n8f1vbfFriyXcIWjDcAo4UwRmHSij7wgRI9s8l8rBsi4BUquRm
	 E6nrKj7n6SXIHHf51r5G616fCdQWalEVC1EsuBq66/wT4g6iHKN2UHfJ1mTCI1Z5PT
	 1WxwJqBLeD25DbUOPEfOSBU8rDjNafakp7gNxEwU=
Date: Fri, 15 May 2026 21:59:41 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <qeyycsdnejwrqle4zwrvkjvkvrpjifeanwxjaa7i7y2ab7rnt2@b6gvugqayarg>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: AF2775510A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-10914-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 06:13:24PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:24 AM
> > 
> > Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> > This driver implements stage-1 IO translation within the guest OS.
> > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > for:
> >  - Capability discovery
> >  - Domain allocation, configuration, and deallocation
> >  - Device attachment and detachment
> >  - IOTLB invalidation
> > 
> > The driver constructs x86-compatible stage-1 IO page tables in the
> > guest memory using consolidated IO page table helpers. This allows
> > the guest to manage stage-1 translations independently of vendor-
> > specific drivers (like Intel VT-d or AMD IOMMU).
> > 
> > Hyper-V consumes this stage-1 IO page table when a device domain is
> > created and configured, and nests it with the host's stage-2 IO page
> > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > operations. For unmapping operations, VM exits to perform the IOTLB
> > flush are still unavoidable.
> > 
> > Hyper-V identifies each PCI pass-thru device by a logical device ID
> > in its hypercall interface. The vPCI driver (pci-hyperv) registers the
> > per-bus portion of this ID with the pvIOMMU driver during bus probe.
> > The pvIOMMU driver stores this mapping and combines it with the function
> > number of the endpoint PCI device to form the complete ID for hypercalls.
> 
> As you are probably aware, Mukesh's patch series to support PCI
> pass-thru devices also needs to get the logical device ID. Maybe the
> registration mechanism needs to move somewhere that can be shared
> with his code.
> 

Thank you so much for the review, Michael!

Yes, I looked at Mukesh's series and noticed his hv_pci_vmbus_device_id()
in pci-hyperv.c has the same dev_instance byte manipulation. We do need
a common registration mechanism.

Any suggestion on where to put it? drivers/hv/hv_common.c seems like a
natural place, but the register/lookup functions are currently only
meaningful when CONFIG_HYPERV_PVIOMMU is set. If Mukesh's pass-thru
code also needs them, we might need a new shared Kconfig option that
both can select. Open to better ideas.

Adding Mukesh to the loop. :)

> > 
> > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c           |   4 +
> >  arch/x86/include/asm/mshyperv.h     |   4 +
> >  drivers/iommu/hyperv/Kconfig        |  17 +
> >  drivers/iommu/hyperv/Makefile       |   1 +
> >  drivers/iommu/hyperv/iommu.c        | 705 ++++++++++++++++++++++++++++
> >  drivers/iommu/hyperv/iommu.h        |  54 +++
> >  drivers/pci/controller/pci-hyperv.c |  19 +-
> >  include/asm-generic/mshyperv.h      |  12 +
> >  8 files changed, 815 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/iommu/hyperv/iommu.c
> >  create mode 100644 drivers/iommu/hyperv/iommu.h
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 323adc93f2dc..2c8ff8e06249 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -578,6 +578,10 @@ void __init hyperv_init(void)
> >  	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
> >  	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +	x86_init.iommu.iommu_init = hv_iommu_init;
> > +#endif
> > +
> >  	hv_apic_init();
> > 
> >  	x86_init.pci.arch_init = hv_pci_init;
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index f64393e853ee..20d947c2c758 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -313,6 +313,10 @@ static inline void mshv_vtl_return_hypercall(void) {}
> >  static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
> >  #endif
> > 
> > +#ifdef CONFIG_HYPERV_PVIOMMU
> > +int __init hv_iommu_init(void);
> > +#endif
> > +
> >  #include <asm-generic/mshyperv.h>
> > 
> >  #endif
> > diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> > index 30f40d867036..9e658d5c9a77 100644
> > --- a/drivers/iommu/hyperv/Kconfig
> > +++ b/drivers/iommu/hyperv/Kconfig
> > @@ -8,3 +8,20 @@ config HYPERV_IOMMU
> >  	help
> >  	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> >  	  guest and root partitions.
> > +
> > +if HYPERV_IOMMU
> > +config HYPERV_PVIOMMU
> > +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> > +	depends on X86 && HYPERV
> 
> What is the intent w.r.t. 32-bit builds? Using X86 instead of X86_64
> allows it. I did a 32-bit build and didn't get any build failures, which is
> good. But I can't run it to see if the pvIOMMU actually works in a
> 32-bit build. I don't know how building X86_64 generic PT entries
> would fare.
> 

Sorry, no intent to support 32-bit. I'll change to `depends on X86_64 && HYPERV`

[...]

> > +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_flush_device_domain *input;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->device_domain = hv_domain->device_domain;
> 
> The previous version of this patch had code to set several other fields in
> the input. I wanted to confirm that not setting them in this version is
> intentional. Were they not needed?
> 

Oh. The RFC v1 set partition_id, owner_vtl, domain_id.type, and domain_id.id
individually. In this version, I just simplified it to a struct assignment.
No functional change.

> > +	status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN failed, status %lld\n", status);
> > +}
> > +
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
> 
> Are these sanity checks necessary? The only caller is hv_iommu_attach_dev()
> and it has already done the checks.

You're right, they're redundant. 

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
> 
> As Sashiko and Jacob Pan pointed out, doing the lookup while interrupts are disabled
> is problematic. My suggestion would be to just do the lookup into a local variable
> before disabling interrupts (rather than using a raw spin lock as Jacob suggested).
> 
> Same situation occurs in hv_iommu_attach_dev() and
> hv_iommu_get_logical_device_property().
> 

Thanks! I would also prefer to look up before disabling interrupts.

> > +		local_irq_restore(flags);
> > +		dev_warn(&pdev->dev, "no IOMMU registration for vPCI bus on detach\n");
> > +		return;
> > +	}
> > +	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_DETACH_DEVICE_DOMAIN failed, status %lld\n", status);
> > +
> > +	hv_flush_device_domain(hv_domain);
> > +
> > +	vdev->hv_domain = NULL;
> > +}
> > +

[...]

> > +static int hv_iommu_get_logical_device_property(struct device *dev,
> > +					u32 code,
> > +					struct hv_output_get_logical_device_property *property)
> > +{
> > +	u64 status, lid;
> > +	unsigned long flags;
> > +	int ret;
> > +	struct hv_input_get_logical_device_property *input;
> > +	struct hv_output_get_logical_device_property *output;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*input);
> 
> Nit: The other way to set output is:
> 
> 	output = input + 1;
> 
> I think this produces slightly better code because of not needing to
> reference the per-cpu variable hyperv_pcpu_input_arg a 2nd time.
> 
> 

Indeed! It's more elegant. :)

> > +	memset(input, 0, sizeof(*input));
> > +	input->partition_id = HV_PARTITION_ID_SELF;
> > +	ret = hv_iommu_lookup_logical_dev_id(to_pci_dev(dev), &lid);
> > +	if (ret) {
> > +		local_irq_restore(flags);
> > +		return ret;
> > +	}
> > +	input->logical_device_id = lid;
> > +	input->code = code;
> > +	status = hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, output);
> > +	*property = *output;
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_GET_LOGICAL_DEVICE_PROPERTY failed, status %lld\n", status);
> > +
> > +	return hv_result_to_errno(status);
> > +}
> > +

[...]

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
> Previous versions of this function did hv_iommu_detach_dev(). With that call
> removed from here, hv_iommu_detach_dev() is only called when attaching a
> domain to a device that already has a domain attached. Is it the case that
> Hyper-V doesn't require the detach as a cleanup step?
> 

The IOMMU core attaches the device to release_domain (our blocking domain)
before calling release_device(), so I believe the explicit detach in the RFC
was redundant. I simply didn't realize that at the time.

Sorry I forgot to mention this in the changelog.

[...]

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
> > +	hv_domain->pt_iommu.nid = dev_to_node(dev);
> > +
> > +	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
> > +	cfg.common.hw_max_oasz_lg2 = 52;
> > +	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
> > +
> > +	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
> > +	if (ret) {
> > +		hv_delete_device_domain(hv_domain);
> > +		kfree(hv_domain);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	/* Constrain to page sizes the hypervisor supports */
> > +	hv_domain->domain.pgsize_bitmap &= hv_iommu_device->pgsize_bitmap;
> > +
> > +	hv_domain->domain.ops = &hv_iommu_paging_domain_ops;
> > +
> > +	ret = hv_configure_device_domain(hv_domain, __IOMMU_DOMAIN_PAGING);
> > +	if (ret) {
> > +		pt_iommu_deinit(&hv_domain->pt_iommu);
> > +		hv_delete_device_domain(hv_domain);
> > +		kfree(hv_domain);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return &hv_domain->domain;
> 
> I think this function would be better if the error paths did "goto"
> a cascading set of error labels. That's the typical pattern, and it's what you
> use in hv_iommu_init(), for example.
> 

Good point. Will restructure to use goto-based error labels

> > +}
> > +
> > +static struct iommu_ops hv_iommu_ops = {
> > +	.capable		  = hv_iommu_capable,
> > +	.domain_alloc_paging	  = hv_iommu_domain_alloc_paging,
> > +	.probe_device		  = hv_iommu_probe_device,
> > +	.release_device		  = hv_iommu_release_device,
> > +	.device_group		  = hv_iommu_device_group,
> > +	.get_resv_regions	  = hv_iommu_get_resv_regions,
> > +	.owner			  = THIS_MODULE,
> > +	.identity_domain	  = &hv_identity_domain.domain,
> > +	.blocked_domain		  = &hv_blocking_domain.domain,
> > +	.release_domain		  = &hv_blocking_domain.domain,
> > +};
> > +
> > +static int hv_iommu_detect(struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_get_iommu_capabilities *input;
> > +	struct hv_output_get_iommu_capabilities *output;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*input);
> 
> Potentially use "output = input + 1" here as well.
> 

Yes. Thanks!

[...]

> > @@ -3857,13 +3858,25 @@ static int hv_pci_probe(struct hv_device *hdev,
> > 
> >  	hbus->state = hv_pcibus_probed;
> > 
> > -	ret = create_root_hv_pci_bus(hbus);
> > +	/* Notify pvIOMMU before any device on the bus is scanned. */
> > +	prefix = (hdev->dev_instance.b[5] << 24) |
> > +		 (hdev->dev_instance.b[4] << 16) |
> > +		 (hdev->dev_instance.b[7] <<  8) |
> > +		 (hdev->dev_instance.b[6] & 0xf8);
> 
> This assembling of the logical device id prefix duplicates the
> code in hv_irq_retarget_interrupt(). Could this code save the
> prefix in struct hv_pcibus_device, and then have
> hv_irq_retarget_interrupt() use it?  Then it would be clear
> that HVCALL_RETARGET_INTERRUPT is using exactly the same
> logical device id as the IOMMU hypercalls.
> 

Good point. I think we can do it. :)

> > +
> > +	ret = hv_iommu_register_pci_bus(dom, prefix);
> >  	if (ret)
> >  		goto free_windows;
> > 
> > +	ret = create_root_hv_pci_bus(hbus);
> > +	if (ret)
> > +		goto unregister_pviommu;
> > +
> >  	mutex_unlock(&hbus->state_lock);
> >  	return 0;
> > 
> > +unregister_pviommu:
> > +	hv_iommu_unregister_pci_bus(dom);
> >  free_windows:
> >  	hv_pci_free_bridge_windows(hbus);
> >  exit_d0:
> > @@ -3974,8 +3987,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool
> > keep_devs)
> >  static void hv_pci_remove(struct hv_device *hdev)
> >  {
> >  	struct hv_pcibus_device *hbus;
> > +	int dom;
> > 
> >  	hbus = hv_get_drvdata(hdev);
> > +	dom = hbus->bridge->domain_nr;
> 
> Nit: Setting "dom" here feels a little weird because the value is only needed
> under the "if" statement. The value must be read before the root bus is
> removed, but even so moving it under the "if" statement would make more
> sense to me.
> 

Sure. Thanks!

> >  	if (hbus->state == hv_pcibus_installed) {
> >  		tasklet_disable(&hdev->channel->callback_event);
> >  		hbus->state = hv_pcibus_removing;
> > @@ -3994,6 +4009,8 @@ static void hv_pci_remove(struct hv_device *hdev)
> >  		hv_pci_remove_slots(hbus);
> >  		pci_remove_root_bus(hbus->bridge->bus);
> >  		pci_unlock_rescan_remove();
> > +
> > +		hv_iommu_unregister_pci_bus(dom);
> >  	}
> > 
> >  	hv_pci_bus_exit(hdev, false);

B.R.
Yu

