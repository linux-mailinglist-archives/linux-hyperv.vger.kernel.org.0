Return-Path: <linux-hyperv+bounces-8582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ2IIPrjemn5/AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8582-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 05:37:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25490ABB32
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 05:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A9D83004631
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 04:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F0627B357;
	Thu, 29 Jan 2026 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="p7beqqdu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1A26ED2A;
	Thu, 29 Jan 2026 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769661431; cv=pass; b=eJ96J9wo5g2RN3fDBeh1FQjnSyyaF+kMiY5mHue2UpWd/VRErrB1koULzv2Z/4Tcm8isx8EbE/EXLAzmU0gGWvWg3iNWaB0FYkvxaXZv0zFVJ8hbATPI0plpo8WFMWBsIU0ouPKvn2xLT+n6SaD3X4M00ri+w88H2racVJPOnO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769661431; c=relaxed/simple;
	bh=F6E9k7UAiOLFE5b5L4OXWO2mXPs4f2aEc1xvxJbaBWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuCKeczbhr2xu3/GRa1XerxuU48dIaHiikMsfMUZazhVVDKtA6RfkN1+MAgMyLodqexjvzTMcjEi7D9cDyWQ1Ibwf8hJ/J52B2/67mSlF96mpKeZv/GnR8iALGeDrVJH0/x+lgxXXxDlW2Pul3+7fbRyeiUg/apkWGP7AQsKLD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=p7beqqdu; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769661420; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NTesVd6yJTmDTmdxNM1glIStC4PSkTg/RveAnSLppJXEdRgnoTb/r5U07sEYYXCJm1CUCmybCPPHtSciBZyAhy4b7WMZcsWuat4BnTiZTlKKclnrOEQuuzdS3qhaEJpADoOfQz8qvhLIV+izz3cgR/F5yWhtsJjmp598IQamEbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769661420; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LtDpMtwjGblqNyIE4SLdAAwYTriC/igvU7B6WXLHIP0=; 
	b=cDtpcWmfKaLx+HNaXyqcJcCWopITzXouFywTx+LgCeDpKyYswrD+AxhufKN3jwqq72YL5AVCHbV9t/dTXxVRysYkasdMx5LYt+6X0MLmIYGx6oAz3W3U9nYS7cYR2l2mgKwz7PkfX1Kf0QvBg6vBhDANSRY66ZcLG4wIEjfJfXM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769661420;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=LtDpMtwjGblqNyIE4SLdAAwYTriC/igvU7B6WXLHIP0=;
	b=p7beqqduziHLXf0m8I83yYqNivDTykben99dYC1Q1C872f5CQAGltBCRiVXy3/ck
	oX92+831eucraCPM/JR4HHggiXMnP2ZCAZdRiKopWG30CV/naXLvXUM5t21wEOiHefi
	W/rMqA2PC9rZ6ZB+XSbrV9SjujylClFnjbsZQP7A=
Received: by mx.zohomail.com with SMTPS id 1769661416953309.5866630388397;
	Wed, 28 Jan 2026 20:36:56 -0800 (PST)
Date: Thu, 29 Jan 2026 04:36:51 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aXrj4-KAxYfuK7k0@anirudh-surface.localdomain>
References: <20260128160437.3342167-1-anirudh@anirudhrb.com>
 <20260128160437.3342167-3-anirudh@anirudhrb.com>
 <aXqV127NzazbDkau@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXqV127NzazbDkau@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8582-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[anirudhrb.com:+]
X-Rspamd-Queue-Id: 25490ABB32
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 03:03:51PM -0800, Stanislav Kinsburskii wrote:
> On Wed, Jan 28, 2026 at 04:04:37PM +0000, Anirudh Rayabharam wrote:
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> > interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> > There is no such vector reserved for arm64.
> > 
> > On arm64, the INTID for SINTs should be in the SGI or PPI range. The
> > hypervisor exposes a virtual device in the ACPI that reserves a
> > PPI for this use. Introduce a platform_driver that binds to this ACPI
> > device and obtains the interrupt vector that can be used for SINTs.
> > 
> > To better unify x86 and arm64 paths, introduce mshv_sint_irq_init() that
> 
> Where is mshv_sint_irq_init?

Oops, this should be mshv_synic_init(). Leftover from previous
development version of this patch :)

Will fix in the next version.

> 
> > either registers the platform_driver and obtains the INTID (arm64) or
> > just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  drivers/hv/mshv_root.h      |   2 +
> >  drivers/hv/mshv_root_main.c |  11 ++-
> >  drivers/hv/mshv_synic.c     | 152 ++++++++++++++++++++++++++++++++++--
> >  3 files changed, 158 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index c02513f75429..c2d1e8d7452c 100644
> > --- a/drivers/hv/mshv_root.h
> > +++ b/drivers/hv/mshv_root.h
> > @@ -332,5 +332,7 @@ int mshv_region_get(struct mshv_mem_region *region);
> >  bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
> >  void mshv_region_movable_fini(struct mshv_mem_region *region);
> >  bool mshv_region_movable_init(struct mshv_mem_region *region);
> > +int mshv_synic_init(void);
> > +void mshv_synic_cleanup(void);
> >  
> >  #endif /* _MSHV_ROOT_H_ */
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index abb34b37d552..6c2d4a80dbe3 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -2276,11 +2276,17 @@ static int __init mshv_parent_partition_init(void)
> >  			MSHV_HV_MAX_VERSION);
> >  	}
> >  
> > +	ret = mshv_synic_init();
> > +	if (ret) {
> > +		dev_err(dev, "Failed to initialize synic: %i\n", ret);
> > +		goto device_deregister;
> > +	}
> > +
> >  	mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
> >  	if (!mshv_root.synic_pages) {
> >  		dev_err(dev, "Failed to allocate percpu synic page\n");
> >  		ret = -ENOMEM;
> > -		goto device_deregister;
> > +		goto synic_cleanup;
> >  	}
> 
> Should this become a part of mshv_synic_init()?

Yeah, good idea. Maybe even the below cpuhp_setup_state can be moved.

> 
> >  
> >  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> > @@ -2322,6 +2328,8 @@ static int __init mshv_parent_partition_init(void)
> >  	cpuhp_remove_state(mshv_cpuhp_online);
> >  free_synic_pages:
> >  	free_percpu(mshv_root.synic_pages);
> > +synic_cleanup:
> > +	mshv_synic_cleanup();
> >  device_deregister:
> >  	misc_deregister(&mshv_dev);
> >  	return ret;
> > @@ -2337,6 +2345,7 @@ static void __exit mshv_parent_partition_exit(void)
> >  		mshv_root_partition_exit();
> >  	cpuhp_remove_state(mshv_cpuhp_online);
> >  	free_percpu(mshv_root.synic_pages);
> > +	mshv_synic_cleanup();
> 
> Please, follow the common convention where cleaup path is the reverse of
> init path.

Right, will fix this.

> 
> >  }
> >  
> >  module_init(mshv_parent_partition_init);
> > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > index ba89655b0910..b7860a75b97e 100644
> > --- a/drivers/hv/mshv_synic.c
> > +++ b/drivers/hv/mshv_synic.c
> > @@ -10,13 +10,19 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/mm.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/random.h>
> >  #include <asm/mshyperv.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/acpi.h>
> >  
> >  #include "mshv_eventfd.h"
> >  #include "mshv.h"
> >  
> > +static int mshv_interrupt = -1;
> 
> The name is a bit too short. What about mshv_callback_vector or
> mshv_irq_vector?

I like mshv_callback_vector. I'll change to that in the next version
unless someone else comes up with a better suggestion.

> 
> > +static int mshv_irq = -1;
> > +
> 
> Should this be a path of mshv_root structure?

This doesn't need to be globally accessible. It is only used in this file.
So I guess it doesn't need to be in mshv_root. What do you think?

> 
> >  static u32 synic_event_ring_get_queued_port(u32 sint_index)
> >  {
> >  	struct hv_synic_event_ring_page **event_ring_page;
> > @@ -446,14 +452,144 @@ void mshv_isr(void)
> >  	}
> >  }
> >  
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +#ifdef CONFIG_ACPI
> > +static long __percpu *mshv_evt;
> > +
> > +static acpi_status mshv_walk_resources(struct acpi_resource *res, void *ctx)
> > +{
> > +	struct resource r;
> > +
> > +	switch (res->type) {
> > +	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> > +		if (!acpi_dev_resource_interrupt(res, 0, &r)) {
> > +			pr_err("Unable to parse MSHV ACPI interrupt\n");
> > +			return AE_ERROR;
> > +		}
> > +		/* ARM64 INTID */
> > +		mshv_interrupt = res->data.extended_irq.interrupts[0];
> > +		/* Linux IRQ number */
> > +		mshv_irq = r.start;
> > +		pr_info("MSHV SINT INTID %d, IRQ %d\n",
> > +			mshv_interrupt, mshv_irq);
> > +		return AE_OK;
> > +	default:
> > +		/* Unused resource type */
> > +		return AE_OK;
> > +	}
> > +
> > +	return AE_OK;
> > +}
> > +
> > +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> > +{
> > +	mshv_isr();
> > +	add_interrupt_randomness(irq);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mshv_sint_probe(struct platform_device *pdev)
> > +{
> > +	acpi_status result;
> > +	int ret = 0;
> > +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> > +
> > +	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> > +					mshv_walk_resources, NULL);
> > +
> > +	if (ACPI_FAILURE(result)) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	mshv_evt = alloc_percpu(long);
> > +	if (!mshv_evt) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	ret = request_percpu_irq(mshv_irq, mshv_percpu_isr, "MSHV", mshv_evt);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static void mshv_sint_remove(struct platform_device *pdev)
> > +{
> > +	free_percpu_irq(mshv_irq, mshv_evt);
> > +	free_percpu(mshv_evt);
> > +}
> > +#else
> > +static int mshv_sint_probe(struct platform_device *pdev)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static void mshv_sint_remove(struct platform_device *pdev)
> > +{
> > +	return;
> > +}
> > +#endif
> > +
> 
> Is this all x86-compatible?
> The commit message says it's introduced for arm64.
> If it's incompatible, please, wrap it into #ifdefs and compile out for
> x86_64.

They are wrapped in #ifndef HYPERVISOR_CALLBACK_VECTOR.

If that is defined we use the hardcoded vector. It is currently
only defined for x86 so HYPERVISOR_CALLBACK_VECTOR is effectively a proxy
for "x86 enabled". This approach is better because we're not concerned
about whether it is x86 or arm, what we really want to figure out
is whether we have a pre-defined vector or not.

The VMBus driver follows this pattern too.

> 
> > +
> > +static const __maybe_unused struct acpi_device_id mshv_sint_device_ids[] = {
> > +	{"MSFT1003", 0},
> > +	{"", 0},
> > +};
> > +
> > +static struct platform_driver mshv_sint_drv = {
> > +	.probe = mshv_sint_probe,
> > +	.remove = mshv_sint_remove,
> > +	.driver = {
> > +		.name = "mshv_sint",
> > +		.acpi_match_table = ACPI_PTR(mshv_sint_device_ids),
> > +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> > +	},
> > +};
> > +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> > +
> > +int mshv_synic_init(void)
> > +{
> > +#ifdef HYPERVISOR_CALLBACK_VECTOR
> > +	mshv_interrupt = HYPERVISOR_CALLBACK_VECTOR;
> > +	mshv_irq = -1;
> > +	return 0;
> > +#else
> > +	int ret;
> > +
> > +	if (acpi_disabled)
> > +		return -ENODEV;
> > +
> > +	ret = platform_driver_register(&mshv_sint_drv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (mshv_interrupt == -1 || mshv_irq == -1) {
> > +		ret = -ENODEV;
> > +		goto out_unregister;
> > +	}
> > +
> > +	return 0;
> > +
> > +out_unregister:
> > +	platform_driver_unregister(&mshv_sint_drv);
> > +	return ret;
> > +#endif
> > +}
> > +
> > +void mshv_synic_cleanup(void)
> > +{
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +	if (!acpi_disabled)
> > +		platform_driver_unregister(&mshv_sint_drv);
> > +#endif
> > +}
> > +
> >  int mshv_synic_cpu_init(unsigned int cpu)
> >  {
> >  	union hv_synic_simp simp;
> >  	union hv_synic_siefp siefp;
> >  	union hv_synic_sirbp sirbp;
> > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> >  	union hv_synic_sint sint;
> > -#endif
> >  	union hv_synic_scontrol sctrl;
> >  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > @@ -496,10 +632,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> >  
> >  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> >  
> > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > +	if (mshv_irq != -1)
> > +		enable_percpu_irq(mshv_irq, 0);
> > +
> 
> It's better to explicitly separate x86 and arm64 paths with #ifdefs.
> For example:
> 
> #ifdef CONFIG_X86_64
> int setup_cpu_sint() {
>   	/* Enable intercepts */
>   	sint.as_uint64 = 0;
> 	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> 	....
> }
> #endif
> #ifdef CONFIG_ARM64
> int setup_cpu_sint() {
> 	enable_percpu_irq(mshv_irq, 0);
> 
>   	/* Enable intercepts */
>   	sint.as_uint64 = 0;
> 	sint.vector = mshv_interrupt;
> 	....
> }
> #endif

This seems unnecessary. We've made the paths that determine
mshv_interrupt separate. Now we can just use that here.

There is no need to write two copies of 

	...
   	sint.as_uint64 = 0;
 	sint.vector = <whatever>;
	...

I could do the enable_percpu_irq() inside an ifdef. But do we gain
anything from it? Won't the compiler optimize the current code as well
since mshv_irq will always be -1 whenever HYPERVISOR_CALLBACK_VECTOR is
defined?

Thanks,
Anirudh.

> 
> Thanks,
> Stanislav
> 
> >  	/* Enable intercepts */
> >  	sint.as_uint64 = 0;
> > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > +	sint.vector = mshv_interrupt;
> >  	sint.masked = false;
> >  	sint.auto_eoi = hv_recommend_using_aeoi();
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> > @@ -507,13 +645,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
> >  
> >  	/* Doorbell SINT */
> >  	sint.as_uint64 = 0;
> > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > +	sint.vector = mshv_interrupt;
> >  	sint.masked = false;
> >  	sint.as_intercept = 1;
> >  	sint.auto_eoi = hv_recommend_using_aeoi();
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> >  			      sint.as_uint64);
> > -#endif
> >  
> >  	/* Enable global synic bit */
> >  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> > @@ -568,6 +705,9 @@ int mshv_synic_cpu_exit(unsigned int cpu)
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> >  			      sint.as_uint64);
> >  
> > +	if (mshv_irq != -1)
> > +		disable_percpu_irq(mshv_irq);
> > +
> >  	/* Disable Synic's event ring page */
> >  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> >  	sirbp.sirbp_enabled = false;
> > -- 
> > 2.34.1
> > 

