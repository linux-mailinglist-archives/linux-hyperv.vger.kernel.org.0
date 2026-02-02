Return-Path: <linux-hyperv+bounces-8660-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOGIInv3gGmxDQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8660-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 20:14:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079BD06DA
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B5183045034
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AE2F532C;
	Mon,  2 Feb 2026 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h7hVxywP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329ED2F25F4;
	Mon,  2 Feb 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059616; cv=none; b=hyncK0pGei3tnl6Ab4hjaWF+udpVnXyju9VHN/na5AScviTnilB8S61eOz4HXRTE9PwCqF1QwuuEogVJAxe8S6eWLlU9++sA5VWgMZXzvFu9n7PMGvcubaFb8voz3vt0dcrIKTd5Qx58J6cfhNEBWy28NLF+RtyoifYBS6UHwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059616; c=relaxed/simple;
	bh=l6nN9jSnvdF4Uw7rACHN1Iu/YsqfL1kztRr78nOF/po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmyX43AvqDQY2A+PeBlyjeTrD/yOiNXahog4/EC9lk4eSV73IxNbSvoYBNyur0EZMnsK5RPV7/EMuGMD2AYlW8SFhRM9heam1oviUcl0xCEIU8zqMzcgTF+y771x/Eb+Z8LmlfyxFK8fG6CpntNDCHWrcz2CToYeIC5ybrpQsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h7hVxywP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82F4420B7168;
	Mon,  2 Feb 2026 11:13:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82F4420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770059614;
	bh=dmoZozFryvUNByDcHB7mBs2W+JUMGS92GOlVCeHaESA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7hVxywP+NSCMrFFF9Nxar32xbB5fUjvoQUHxqw96ERXjsq68RRJ2CxXyInsolu8r
	 xDZ1dAElYVVbQlFNG38QuySz/nPSnte15tY8fVfR92R+mNGSRPuxWT+WAW2H2GNvo4
	 AqO+M6X2/Fji70augbm7MBvMlRJM4uH/HjfRFPdE=
Date: Mon, 2 Feb 2026 11:13:34 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aYD3XvbrOhH3NNP_@skinsburskii.localdomain>
References: <20260202182706.648192-1-anirudh@anirudhrb.com>
 <20260202182706.648192-3-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202182706.648192-3-anirudh@anirudhrb.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8660-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 1079BD06DA
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:27:06PM +0000, Anirudh Rayabharam wrote:
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
> To better unify x86 and arm64 paths, introduce mshv_sint_vector_init() that
> either registers the platform_driver and obtains the INTID (arm64) or
> just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_synic.c | 163 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 156 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 98c58755846d..de5fee6e9f29 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -10,17 +10,24 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/reboot.h>
>  #include <asm/mshyperv.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
>  
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>  
>  static int synic_cpuhp_online;
>  static struct hv_synic_pages __percpu *synic_pages;
> +static int mshv_sint_vector = -1; /* hwirq for the SynIC SINTs */
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +static int mshv_sint_irq = -1; /* Linux IRQ for mshv_sint_vector */
> +#endif
>  
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
> @@ -456,9 +463,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
> -#endif
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> @@ -501,10 +506,13 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>  
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	enable_percpu_irq(mshv_sint_irq, 0);
> +#endif
> +
>  	/* Enable intercepts */
>  	sint.as_uint64 = 0;
> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector = mshv_sint_vector;
>  	sint.masked = false;
>  	sint.auto_eoi = hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> @@ -512,13 +520,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  
>  	/* Doorbell SINT */
>  	sint.as_uint64 = 0;
> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector = mshv_sint_vector;
>  	sint.masked = false;
>  	sint.as_intercept = 1;
>  	sint.auto_eoi = hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
> -#endif
>  
>  	/* Enable global synic bit */
>  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> @@ -573,6 +580,10 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>  
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	disable_percpu_irq(mshv_sint_irq);
> +#endif
> +
>  	/* Disable Synic's event ring page */
>  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled = false;
> @@ -680,14 +691,149 @@ static struct notifier_block mshv_synic_reboot_nb = {
>  	.notifier_call = mshv_synic_reboot_notify,
>  };
>  
> +#ifndef HYPERVISOR_CALLBACK_VECTOR

You have introduced 4 ifdef branches (one aroung the variable and three
in mshv_synic_cpu_init) and then you still have a big ifdef branch here.

Why is it better than simply introducing two different
mshv_synic_cpu_init functions and have a single big ifdef instead
(especially giving that this code is arch-specific anyway and thus won't
bloat the binary)?

This will also allows to get rid of redundant mshv_sint_vector variable
on x86.

Thanks,
Stanislav

> +#ifdef CONFIG_ACPI
> +static long __percpu *mshv_evt;
> +
> +static acpi_status mshv_walk_resources(struct acpi_resource *res, void *ctx)
> +{
> +	struct resource r;
> +
> +	if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
> +		if (!acpi_dev_resource_interrupt(res, 0, &r)) {
> +			pr_err("Unable to parse MSHV ACPI interrupt\n");
> +			return AE_ERROR;
> +		}
> +		/* ARM64 INTID */
> +		mshv_sint_vector = res->data.extended_irq.interrupts[0];
> +		/* Linux IRQ number */
> +		mshv_sint_irq = r.start;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> +{
> +	mshv_isr();
> +	return IRQ_HANDLED;
> +}
> +
> +static int mshv_sint_probe(struct platform_device *pdev)
> +{
> +	acpi_status result;
> +	int ret;
> +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +
> +	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +					mshv_walk_resources, NULL);
> +	if (ACPI_FAILURE(result)) {
> +		ret = -ENODEV;
> +		goto out_fail;
> +	}
> +
> +	mshv_evt = alloc_percpu(long);
> +	if (!mshv_evt) {
> +		ret = -ENOMEM;
> +		goto out_fail;
> +	}
> +
> +	ret = request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> +		mshv_evt);
> +	if (ret)
> +		goto free_evt;
> +
> +	return 0;
> +
> +free_evt:
> +	free_percpu(mshv_evt);
> +out_fail:
> +	mshv_sint_vector = -1;
> +	mshv_sint_irq = -1;
> +	return ret;
> +}
> +
> +static void mshv_sint_remove(struct platform_device *pdev)
> +{
> +	free_percpu_irq(mshv_sint_irq, mshv_evt);
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
> +}
> +#endif
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
> +
> +static int __init mshv_sint_vector_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	ret = platform_driver_register(&mshv_sint_drv);
> +	if (ret)
> +		return ret;
> +
> +	if (mshv_sint_vector == -1 || mshv_sint_irq == -1) {
> +		platform_driver_unregister(&mshv_sint_drv);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +	platform_driver_unregister(&mshv_sint_drv);
> +}
> +#else /* HYPERVISOR_CALLBACK_VECTOR */
> +static int __init mshv_sint_vector_init(void)
> +{
> +	mshv_sint_vector = HYPERVISOR_CALLBACK_VECTOR;
> +	return 0;
> +}
> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +}
> +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> +
>  int __init mshv_synic_init(struct device *dev)
>  {
>  	int ret = 0;
>  
> +	ret = mshv_sint_vector_init();
> +	if (ret) {
> +		dev_err(dev, "Failed to get MSHV SINT vector: %i\n", ret);
> +		return ret;
> +	}
> +
>  	synic_pages = alloc_percpu(struct hv_synic_pages);
>  	if (!synic_pages) {
>  		dev_err(dev, "Failed to allocate percpu synic page\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto sint_vector_cleanup;
>  	}
>  
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> @@ -712,6 +858,8 @@ int __init mshv_synic_init(struct device *dev)
>  	cpuhp_remove_state(synic_cpuhp_online);
>  free_synic_pages:
>  	free_percpu(synic_pages);
> +sint_vector_cleanup:
> +	mshv_sint_vector_cleanup();
>  	return ret;
>  }
>  
> @@ -721,4 +869,5 @@ void mshv_synic_cleanup(void)
>  		unregister_reboot_notifier(&mshv_synic_reboot_nb);
>  	cpuhp_remove_state(synic_cpuhp_online);
>  	free_percpu(synic_pages);
> +	mshv_sint_vector_cleanup();
>  }
> -- 
> 2.34.1
> 

