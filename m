Return-Path: <linux-hyperv+bounces-8669-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lixOBE58gWnBGgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8669-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 05:40:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54489D4720
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 05:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D829F3058093
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 04:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34A2264AD;
	Tue,  3 Feb 2026 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="WsWD1EIS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255421146C;
	Tue,  3 Feb 2026 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770093643; cv=pass; b=R2l2/MlLAgbdXRM/NX/Lzr50AFEkVL5vnLC88b2uFUTN96237tFnl8g6kCFqRR5CdA0k8/JDCdibD5Ung6P+720ZQfXBtvtZtlG9TsDZdxpCvABjfO+rdfq2RAseaT3Ir+GSyILezQ65MPtEitAm7ZhhkkLq8Fj7CGeYe2dGJ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770093643; c=relaxed/simple;
	bh=S73mfpX47+eyII+dNBVH9Wj3oc2xVTTr3SEHw0l4pws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQk81UiyFZSb+lVTkyIz/hrqwx7vDDKQQKOvYLUdiPX6jMKe3QMBeJPGIh+W8IECvA7rJVBj62MaU6as5HAbY5HDueNUUYukX+A4SSTQ7bWgQR7YYpU6OdMqVP04RI5I1Oy+I+8//5U6a+OpWtQYH+7GchN82zD9ANOV60xBP2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=WsWD1EIS; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770093628; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ju5cPW+9/jM0c2ClDEqC2RvUD0d3Oloa4ndUpndebDJnVSJdDz6gJxD7V5zWvvXK5lXyJQLrcEpTMTTUCiuvKWfI7qdbNAVRsjcjJGoR4oJZaa0wDggKSnjdz1o6RYotyVwmTCYA5PSF/31x9ST2ZulSIzVSfrub8UNtKDZhOYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770093628; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ISYEJsNb9Scwsh8FMtu9JO9I5uyja3lGTXiwOjsj5Ys=; 
	b=gmNH5zbjowiJaoflsOxPXiEC+ItyoyU9k6SnmENdqwFq9uix/dYPQ1mv3j74bxqDzRcGDZR0toD5acAopcYBVXJbGTt637annRp/9J+xJhZkbYu2ZHX9xasGfGB38x+X5vz04dX3MYUP4cHAMW+9RZ6CPrDLPp4gYAAWb/YKFkQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770093628;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ISYEJsNb9Scwsh8FMtu9JO9I5uyja3lGTXiwOjsj5Ys=;
	b=WsWD1EISAklTbluvmrYbt0mt78NRL9rpNJgOUE3vA07YX/cdOplt3S5kdsGwkHmj
	Xhl3eOcB+GoeHNvOr7omqpzqsBPqN9MuWl4bICuGZ9rpwLxRjK6kPbaak/CjvyaEl8b
	ZWk6b8w7/CB1HvENlqNDxVj0lzTp25cbti6YdJI4=
Received: by mx.zohomail.com with SMTPS id 1770093624902107.21881822180205;
	Mon, 2 Feb 2026 20:40:24 -0800 (PST)
Date: Tue, 3 Feb 2026 10:10:11 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <2ea3pd2z6c5tlqfbjbzbb6a4bvd5bpytuk7fs3cywohf3lo7kf@ntwj7s75eaom>
References: <20260202182706.648192-1-anirudh@anirudhrb.com>
 <20260202182706.648192-3-anirudh@anirudhrb.com>
 <aYD3XvbrOhH3NNP_@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYD3XvbrOhH3NNP_@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8669-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54489D4720
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:13:34AM -0800, Stanislav Kinsburskii wrote:
> On Mon, Feb 02, 2026 at 06:27:06PM +0000, Anirudh Rayabharam wrote:
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
> > To better unify x86 and arm64 paths, introduce mshv_sint_vector_init() that
> > either registers the platform_driver and obtains the INTID (arm64) or
> > just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  drivers/hv/mshv_synic.c | 163 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 156 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > index 98c58755846d..de5fee6e9f29 100644
> > --- a/drivers/hv/mshv_synic.c
> > +++ b/drivers/hv/mshv_synic.c
> > @@ -10,17 +10,24 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/mm.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/random.h>
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/reboot.h>
> >  #include <asm/mshyperv.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/acpi.h>
> >  
> >  #include "mshv_eventfd.h"
> >  #include "mshv.h"
> >  
> >  static int synic_cpuhp_online;
> >  static struct hv_synic_pages __percpu *synic_pages;
> > +static int mshv_sint_vector = -1; /* hwirq for the SynIC SINTs */
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +static int mshv_sint_irq = -1; /* Linux IRQ for mshv_sint_vector */
> > +#endif
> >  
> >  static u32 synic_event_ring_get_queued_port(u32 sint_index)
> >  {
> > @@ -456,9 +463,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
> >  	union hv_synic_simp simp;
> >  	union hv_synic_siefp siefp;
> >  	union hv_synic_sirbp sirbp;
> > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> >  	union hv_synic_sint sint;
> > -#endif
> >  	union hv_synic_scontrol sctrl;
> >  	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > @@ -501,10 +506,13 @@ static int mshv_synic_cpu_init(unsigned int cpu)
> >  
> >  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> >  
> > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +	enable_percpu_irq(mshv_sint_irq, 0);
> > +#endif
> > +
> >  	/* Enable intercepts */
> >  	sint.as_uint64 = 0;
> > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > +	sint.vector = mshv_sint_vector;
> >  	sint.masked = false;
> >  	sint.auto_eoi = hv_recommend_using_aeoi();
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> > @@ -512,13 +520,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
> >  
> >  	/* Doorbell SINT */
> >  	sint.as_uint64 = 0;
> > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > +	sint.vector = mshv_sint_vector;
> >  	sint.masked = false;
> >  	sint.as_intercept = 1;
> >  	sint.auto_eoi = hv_recommend_using_aeoi();
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> >  			      sint.as_uint64);
> > -#endif
> >  
> >  	/* Enable global synic bit */
> >  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> > @@ -573,6 +580,10 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> >  			      sint.as_uint64);
> >  
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +	disable_percpu_irq(mshv_sint_irq);
> > +#endif
> > +
> >  	/* Disable Synic's event ring page */
> >  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> >  	sirbp.sirbp_enabled = false;
> > @@ -680,14 +691,149 @@ static struct notifier_block mshv_synic_reboot_nb = {
> >  	.notifier_call = mshv_synic_reboot_notify,
> >  };
> >  
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> 
> You have introduced 4 ifdef branches (one aroung the variable and three
> in mshv_synic_cpu_init) and then you still have a big ifdef branch here.

If it is ifdefs you're counting I could remove the one's around
mshv_sint_irq and then wherever it is used I could do:

	if (mshv_sint_irq != -1)
		<do something...>

This will reduce #ifdefs but will mean one more variable in the
!HYPERVISOR_CALLBACK_VECTOR case (which I believe would be optimized
away anyway).

> 
> Why is it better than simply introducing two different
> mshv_synic_cpu_init functions and have a single big ifdef instead
> (especially giving that this code is arch-specific anyway and thus won't
> bloat the binary)?

There are only two lines of code in mshv_synic_cpu_init that are inside
ifdefs. It doesn't make sense to write the exact same function twice
with just two lines different. It's not a short function, so anybody
reading it would have a pretty hard time figuring out which lines are
different.

Big ifdef here is unavoidable because the whole platform_driver part has
to be implemented.

Other ifdefs are so small that they shouldn't be jarring when reading
the code.

> 
> This will also allows to get rid of redundant mshv_sint_vector variable
> on x86.

Yeah, but the trade off (two copies of the largely same
mshv_synic_cpu_init) is horrible. And the variable would be optimized
away anyway.

Thanks,
Anirudh.

> 
> Thanks,
> Stanislav
> 
> > +#ifdef CONFIG_ACPI
> > +static long __percpu *mshv_evt;
> > +
> > +static acpi_status mshv_walk_resources(struct acpi_resource *res, void *ctx)
> > +{
> > +	struct resource r;
> > +
> > +	if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
> > +		if (!acpi_dev_resource_interrupt(res, 0, &r)) {
> > +			pr_err("Unable to parse MSHV ACPI interrupt\n");
> > +			return AE_ERROR;
> > +		}
> > +		/* ARM64 INTID */
> > +		mshv_sint_vector = res->data.extended_irq.interrupts[0];
> > +		/* Linux IRQ number */
> > +		mshv_sint_irq = r.start;
> > +	}
> > +
> > +	return AE_OK;
> > +}
> > +
> > +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> > +{
> > +	mshv_isr();
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mshv_sint_probe(struct platform_device *pdev)
> > +{
> > +	acpi_status result;
> > +	int ret;
> > +	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> > +
> > +	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> > +					mshv_walk_resources, NULL);
> > +	if (ACPI_FAILURE(result)) {
> > +		ret = -ENODEV;
> > +		goto out_fail;
> > +	}
> > +
> > +	mshv_evt = alloc_percpu(long);
> > +	if (!mshv_evt) {
> > +		ret = -ENOMEM;
> > +		goto out_fail;
> > +	}
> > +
> > +	ret = request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> > +		mshv_evt);
> > +	if (ret)
> > +		goto free_evt;
> > +
> > +	return 0;
> > +
> > +free_evt:
> > +	free_percpu(mshv_evt);
> > +out_fail:
> > +	mshv_sint_vector = -1;
> > +	mshv_sint_irq = -1;
> > +	return ret;
> > +}
> > +
> > +static void mshv_sint_remove(struct platform_device *pdev)
> > +{
> > +	free_percpu_irq(mshv_sint_irq, mshv_evt);
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
> > +}
> > +#endif
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
> > +
> > +static int __init mshv_sint_vector_init(void)
> > +{
> > +	int ret;
> > +
> > +	if (acpi_disabled)
> > +		return -ENODEV;
> > +
> > +	ret = platform_driver_register(&mshv_sint_drv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (mshv_sint_vector == -1 || mshv_sint_irq == -1) {
> > +		platform_driver_unregister(&mshv_sint_drv);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void mshv_sint_vector_cleanup(void)
> > +{
> > +	platform_driver_unregister(&mshv_sint_drv);
> > +}
> > +#else /* HYPERVISOR_CALLBACK_VECTOR */
> > +static int __init mshv_sint_vector_init(void)
> > +{
> > +	mshv_sint_vector = HYPERVISOR_CALLBACK_VECTOR;
> > +	return 0;
> > +}
> > +
> > +static void mshv_sint_vector_cleanup(void)
> > +{
> > +}
> > +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> > +
> >  int __init mshv_synic_init(struct device *dev)
> >  {
> >  	int ret = 0;
> >  
> > +	ret = mshv_sint_vector_init();
> > +	if (ret) {
> > +		dev_err(dev, "Failed to get MSHV SINT vector: %i\n", ret);
> > +		return ret;
> > +	}
> > +
> >  	synic_pages = alloc_percpu(struct hv_synic_pages);
> >  	if (!synic_pages) {
> >  		dev_err(dev, "Failed to allocate percpu synic page\n");
> > -		return -ENOMEM;
> > +		ret = -ENOMEM;
> > +		goto sint_vector_cleanup;
> >  	}
> >  
> >  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> > @@ -712,6 +858,8 @@ int __init mshv_synic_init(struct device *dev)
> >  	cpuhp_remove_state(synic_cpuhp_online);
> >  free_synic_pages:
> >  	free_percpu(synic_pages);
> > +sint_vector_cleanup:
> > +	mshv_sint_vector_cleanup();
> >  	return ret;
> >  }
> >  
> > @@ -721,4 +869,5 @@ void mshv_synic_cleanup(void)
> >  		unregister_reboot_notifier(&mshv_synic_reboot_nb);
> >  	cpuhp_remove_state(synic_cpuhp_online);
> >  	free_percpu(synic_pages);
> > +	mshv_sint_vector_cleanup();
> >  }
> > -- 
> > 2.34.1
> > 

