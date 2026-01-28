Return-Path: <linux-hyperv+bounces-8576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIzyFN6Vemku8QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8576-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 00:03:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56CA9D26
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 00:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B1FE300E71A
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78C2FFF90;
	Wed, 28 Jan 2026 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a4qUx1Ot"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730F2DF134;
	Wed, 28 Jan 2026 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641435; cv=none; b=JkZ5AgPAN9KJfFtCWTu2NbLIgSltjSllTQYohJmgLNhgr7KWbfp798Db7oEeDD+iJm6nSvBA4yvh/PDrMs2SoX4SeubsmB1xechNIXRqXAAEOouNtaToeuEuWpenxdxO29Xr2ckJTl4enpiqbfnvR4B6ApFgE2WFVog/J5vzxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641435; c=relaxed/simple;
	bh=UDb7cq9ZL71GKBbeQ4DM8sItqgPpcO14OocrFEST9Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf40cW42P6AktkTnOgArizuPzAGlg+mRFvCBM9bTKRcezOr+YB7UkJCvjimjbdkG57w5VME8nblEsXFzq6FG7UFT2Bjo3OuQvDUz3f4y1dghFPISMp/GCbvtcJKKqFYBoiOIQV+52X5AGpa+H9PS6wM59f2XvtoW8+//UwZ9G/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a4qUx1Ot; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D27E20B7165;
	Wed, 28 Jan 2026 15:03:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D27E20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769641433;
	bh=d6CMwaSEj4O7SHP+o7sQH+mP8QB4iMitkOUTWU8CKtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4qUx1OtjZF5MBb6Jw7QdczK7tey3GeGfNo4d+QSXbuyt1Q/Y5IJbpEgyCnFziXf+
	 Ue2Kg02HAPiyXKMuwj5DKoUr/WtrClBJlRuWCiNY29/0JVfuN8kd4/VarDmevJpzTY
	 NYu43eMU/Z8No19KkVzMum3u7DWBJFb7MJPv3GnE=
Date: Wed, 28 Jan 2026 15:03:51 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aXqV127NzazbDkau@skinsburskii.localdomain>
References: <20260128160437.3342167-1-anirudh@anirudhrb.com>
 <20260128160437.3342167-3-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128160437.3342167-3-anirudh@anirudhrb.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8576-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AF56CA9D26
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:04:37PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> There is no such vector reserved for arm64.
> 
> On arm64, the INTID for SINTs should be in the SGI or PPI range. The
> hypervisor exposes a virtual device in the ACPI that reserves a
> PPI for this use. Introduce a platform_driver that binds to this ACPI
> device and obtains the interrupt vector that can be used for SINTs.
> 
> To better unify x86 and arm64 paths, introduce mshv_sint_irq_init() that

Where is mshv_sint_irq_init?

> either registers the platform_driver and obtains the INTID (arm64) or
> just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_root.h      |   2 +
>  drivers/hv/mshv_root_main.c |  11 ++-
>  drivers/hv/mshv_synic.c     | 152 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 158 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index c02513f75429..c2d1e8d7452c 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -332,5 +332,7 @@ int mshv_region_get(struct mshv_mem_region *region);
>  bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
>  void mshv_region_movable_fini(struct mshv_mem_region *region);
>  bool mshv_region_movable_init(struct mshv_mem_region *region);
> +int mshv_synic_init(void);
> +void mshv_synic_cleanup(void);
>  
>  #endif /* _MSHV_ROOT_H_ */
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index abb34b37d552..6c2d4a80dbe3 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2276,11 +2276,17 @@ static int __init mshv_parent_partition_init(void)
>  			MSHV_HV_MAX_VERSION);
>  	}
>  
> +	ret = mshv_synic_init();
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize synic: %i\n", ret);
> +		goto device_deregister;
> +	}
> +
>  	mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
>  	if (!mshv_root.synic_pages) {
>  		dev_err(dev, "Failed to allocate percpu synic page\n");
>  		ret = -ENOMEM;
> -		goto device_deregister;
> +		goto synic_cleanup;
>  	}

Should this become a part of mshv_synic_init()?

>  
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> @@ -2322,6 +2328,8 @@ static int __init mshv_parent_partition_init(void)
>  	cpuhp_remove_state(mshv_cpuhp_online);
>  free_synic_pages:
>  	free_percpu(mshv_root.synic_pages);
> +synic_cleanup:
> +	mshv_synic_cleanup();
>  device_deregister:
>  	misc_deregister(&mshv_dev);
>  	return ret;
> @@ -2337,6 +2345,7 @@ static void __exit mshv_parent_partition_exit(void)
>  		mshv_root_partition_exit();
>  	cpuhp_remove_state(mshv_cpuhp_online);
>  	free_percpu(mshv_root.synic_pages);
> +	mshv_synic_cleanup();

Please, follow the common convention where cleaup path is the reverse of
init path.

>  }
>  
>  module_init(mshv_parent_partition_init);
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index ba89655b0910..b7860a75b97e 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -10,13 +10,19 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
>  #include <asm/mshyperv.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
>  
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>  
> +static int mshv_interrupt = -1;

The name is a bit too short. What about mshv_callback_vector or
mshv_irq_vector?

> +static int mshv_irq = -1;
> +

Should this be a path of mshv_root structure?

>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
>  	struct hv_synic_event_ring_page **event_ring_page;
> @@ -446,14 +452,144 @@ void mshv_isr(void)
>  	}
>  }
>  
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +#ifdef CONFIG_ACPI
> +static long __percpu *mshv_evt;
> +
> +static acpi_status mshv_walk_resources(struct acpi_resource *res, void *ctx)
> +{
> +	struct resource r;
> +
> +	switch (res->type) {
> +	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> +		if (!acpi_dev_resource_interrupt(res, 0, &r)) {
> +			pr_err("Unable to parse MSHV ACPI interrupt\n");
> +			return AE_ERROR;
> +		}
> +		/* ARM64 INTID */
> +		mshv_interrupt = res->data.extended_irq.interrupts[0];
> +		/* Linux IRQ number */
> +		mshv_irq = r.start;
> +		pr_info("MSHV SINT INTID %d, IRQ %d\n",
> +			mshv_interrupt, mshv_irq);
> +		return AE_OK;
> +	default:
> +		/* Unused resource type */
> +		return AE_OK;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> +{
> +	mshv_isr();
> +	add_interrupt_randomness(irq);
> +	return IRQ_HANDLED;
> +}
> +
> +static int mshv_sint_probe(struct platform_device *pdev)
> +{
> +	acpi_status result;
> +	int ret = 0;
> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +
> +	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +					mshv_walk_resources, NULL);
> +
> +	if (ACPI_FAILURE(result)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	mshv_evt = alloc_percpu(long);
> +	if (!mshv_evt) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = request_percpu_irq(mshv_irq, mshv_percpu_isr, "MSHV", mshv_evt);
> +out:
> +	return ret;
> +}
> +
> +static void mshv_sint_remove(struct platform_device *pdev)
> +{
> +	free_percpu_irq(mshv_irq, mshv_evt);
> +	free_percpu(mshv_evt);
> +}
> +#else
> +static int mshv_sint_probe(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
> +
> +static void mshv_sint_remove(struct platform_device *pdev)
> +{
> +	return;
> +}
> +#endif
> +

Is this all x86-compatible?
The commit message says it's introduced for arm64.
If it's incompatible, please, wrap it into #ifdefs and compile out for
x86_64.

> +
> +static const __maybe_unused struct acpi_device_id mshv_sint_device_ids[] = {
> +	{"MSFT1003", 0},
> +	{"", 0},
> +};
> +
> +static struct platform_driver mshv_sint_drv = {
> +	.probe = mshv_sint_probe,
> +	.remove = mshv_sint_remove,
> +	.driver = {
> +		.name = "mshv_sint",
> +		.acpi_match_table = ACPI_PTR(mshv_sint_device_ids),
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> +	},
> +};
> +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> +
> +int mshv_synic_init(void)
> +{
> +#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	mshv_interrupt = HYPERVISOR_CALLBACK_VECTOR;
> +	mshv_irq = -1;
> +	return 0;
> +#else
> +	int ret;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	ret = platform_driver_register(&mshv_sint_drv);
> +	if (ret)
> +		return ret;
> +
> +	if (mshv_interrupt == -1 || mshv_irq == -1) {
> +		ret = -ENODEV;
> +		goto out_unregister;
> +	}
> +
> +	return 0;
> +
> +out_unregister:
> +	platform_driver_unregister(&mshv_sint_drv);
> +	return ret;
> +#endif
> +}
> +
> +void mshv_synic_cleanup(void)
> +{
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	if (!acpi_disabled)
> +		platform_driver_unregister(&mshv_sint_drv);
> +#endif
> +}
> +
>  int mshv_synic_cpu_init(unsigned int cpu)
>  {
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
> -#endif
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> @@ -496,10 +632,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
>  
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>  
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	if (mshv_irq != -1)
> +		enable_percpu_irq(mshv_irq, 0);
> +

It's better to explicitly separate x86 and arm64 paths with #ifdefs.
For example:

#ifdef CONFIG_X86_64
int setup_cpu_sint() {
  	/* Enable intercepts */
  	sint.as_uint64 = 0;
	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
	....
}
#endif
#ifdef CONFIG_ARM64
int setup_cpu_sint() {
	enable_percpu_irq(mshv_irq, 0);

  	/* Enable intercepts */
  	sint.as_uint64 = 0;
	sint.vector = mshv_interrupt;
	....
}
#endif

Thanks,
Stanislav

>  	/* Enable intercepts */
>  	sint.as_uint64 = 0;
> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector = mshv_interrupt;
>  	sint.masked = false;
>  	sint.auto_eoi = hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> @@ -507,13 +645,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
>  
>  	/* Doorbell SINT */
>  	sint.as_uint64 = 0;
> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector = mshv_interrupt;
>  	sint.masked = false;
>  	sint.as_intercept = 1;
>  	sint.auto_eoi = hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
> -#endif
>  
>  	/* Enable global synic bit */
>  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> @@ -568,6 +705,9 @@ int mshv_synic_cpu_exit(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>  
> +	if (mshv_irq != -1)
> +		disable_percpu_irq(mshv_irq);
> +
>  	/* Disable Synic's event ring page */
>  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled = false;
> -- 
> 2.34.1
> 

