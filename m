Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93E6BA715
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Mar 2023 06:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCOF3i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Mar 2023 01:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCOF3h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Mar 2023 01:29:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2603234CC;
        Tue, 14 Mar 2023 22:29:00 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 5C13F2057010; Tue, 14 Mar 2023 22:27:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C13F2057010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678858062;
        bh=QxvQUVNnhLTuqBxADNo5TTbNZEOLG7Nm2goh3OWfNMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOjqZSPQfEvXIfQk1vJY6ri2b84OqqnMx3icSVtl85aD/N/ZxBJHsOEzE/+nRoF2V
         Sp8ncYG8vJUqpGjRn004n+AWQg5QqBaVStTUOdO4bvjhkCEdnh6cPjojKsrfYC8mlq
         Ljq9OuaYgD/qJZ8qL53fVWbB/a4STufnz/OkUEQk=
Date:   Tue, 14 Mar 2023 22:27:42 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 5/5] Driver: VMBus: Add Devicetree support
Message-ID: <20230315052742.GA30684@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
 <1678785350-20400-6-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688962642EBF09FA8C7FAEBD7BE9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688962642EBF09FA8C7FAEBD7BE9@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 14, 2023 at 09:21:32PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, March 14, 2023 2:16 AM
> > 
> > Update the driver to support Devicetree boot as well along with ACPI.
> > At present the Devicetree parsing only provides the mmio region info
> > and is not the exact copy of ACPI parsing. This is sufficient to cater
> > all the current Devicetree usecases for VMBus.
> > 
> > Currently Devicetree is supported only for x86 systems.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > [V8]
> > - Remove the auto select of CONFIG_OF
> > - Remove the dependency on !ACPI for OF_EARLY_FLATTREE
> > - Used acpi_disabled instead of #ifdef and hence added a dummy function
> >   for vmbus_acpi_add
> > - GFP_ATOMIC -> GFP_KERNEL
> > - used range.flags instead of hard coding flags
> > - used __maybe_unused for acpi device id, removed #ifdef
> > 
> >  drivers/hv/Kconfig     |  5 ++--
> >  drivers/hv/vmbus_drv.c | 64 +++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 63 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 0747a8f1fcee..47132b30b7ee 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -4,11 +4,12 @@ menu "Microsoft Hyper-V guest support"
> > 
> >  config HYPERV
> >  	tristate "Microsoft Hyper-V client drivers"
> > -	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > -		|| (ARM64 && !CPU_BIG_ENDIAN))
> > +	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > +		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> >  	select PARAVIRT
> >  	select X86_HV_CALLBACK_VECTOR if X86
> >  	select VMAP_PFN
> > +	select OF_EARLY_FLATTREE if OF
> >  	help
> >  	  Select this option to run Linux as a Hyper-V client operating
> >  	  system.
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 3ad2fa2b92e7..15097e1f3f2b 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/completion.h>
> >  #include <linux/hyperv.h>
> >  #include <linux/kernel_stat.h>
> > +#include <linux/of_address.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/cpu.h>
> >  #include <linux/sched/isolation.h>
> > @@ -2143,7 +2144,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> >  	device_unregister(&device_obj->device);
> >  }
> > 
> > -
> > +#ifdef CONFIG_ACPI
> >  /*
> >   * VMBUS is an acpi enumerated device. Get the information we
> >   * need from DSDT.
> > @@ -2253,6 +2254,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource
> > *res, void *ctx)
> > 
> >  	return AE_OK;
> >  }
> > +#endif
> > 
> >  static void vmbus_mmio_remove(void)
> >  {
> > @@ -2273,7 +2275,7 @@ static void vmbus_mmio_remove(void)
> >  	}
> >  }
> > 
> > -static void vmbus_reserve_fb(void)
> > +static void __maybe_unused vmbus_reserve_fb(void)
> >  {
> >  	resource_size_t start = 0, size;
> >  	struct pci_dev *pdev;
> > @@ -2433,6 +2435,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t
> > size)
> >  }
> >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> > 
> > +#ifdef CONFIG_ACPI
> >  static int vmbus_acpi_add(struct platform_device *pdev)
> >  {
> >  	acpi_status result;
> > @@ -2485,10 +2488,52 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> >  		vmbus_mmio_remove();
> >  	return ret_val;
> >  }
> > +#else
> > +static int vmbus_acpi_add(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static int vmbus_device_add(struct platform_device *pdev)
> > +{
> > +	struct resource **cur_res = &hyperv_mmio;
> > +	struct of_range range;
> > +	struct of_range_parser parser;
> > +	struct device_node *np = pdev->dev.of_node;
> > +	int ret;
> > +
> > +	hv_dev = &pdev->dev;
> > +
> > +	ret = of_range_parser_init(&parser, np);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for_each_of_range(&parser, &range) {
> > +		struct resource *res;
> > +
> > +		res = kzalloc(sizeof(*res), GFP_KERNEL);
> > +		if (!res)
> > +			return -ENOMEM;
> 
> I should have looked at this more closely in the previous
> revision.  But if this error path is taken, does any cleanup
> need to be done of 'res' entries that were allocated in
> previous iterations of the for_each_of_range() loop?  It
> seems like the cleanup and releasing of previously allocated
> memory should be done.

No problem, thanks for pointing this.
For now we have only one range in device tree so this case may not occur,
but for completeness I agree we should add that, in future we might
have multiple ranges supported.

I will add vmbus_mmio_remove() in case of error here, I guess that
should be sufficient.

> 
> > +
> > +		res->name = "hyperv mmio";
> > +		res->flags = range.flags;
> > +		res->start = range.cpu_addr;
> > +		res->end = range.cpu_addr + range.size;
> > +
> > +		*cur_res = res;
> > +		cur_res = &res->sibling;
> > +	}
> > +
> > +	return ret;
> > +}
> > 
> >  static int vmbus_platform_driver_probe(struct platform_device *pdev)
> >  {
> > -	return vmbus_acpi_add(pdev);
> > +	if (!acpi_disabled)
> > +		return vmbus_acpi_add(pdev);
> > +	else
> > +		return vmbus_device_add(pdev);
> 
> Nit: Usually when there's a negated test with if/else, it's best to flip the
> if and else clauses so as to eliminate the negation.  It's just slightly less
> semantic load for the human reader to parse through.  So:
> 
> 	if (acpi_disabled)
> 		return vmbus_device_add(pdev);
> 	else
> 		return vmbus_acpi_add(pdev);
> 
> Everything else looks good to me.

Sure will fix.

Regards,
Saurabh

> 
> Michael
> 
> >  }
> > 
> >  static int vmbus_platform_driver_remove(struct platform_device *pdev)
> > @@ -2634,7 +2679,17 @@ static int vmbus_bus_resume(struct device *dev)
> >  #define vmbus_bus_resume NULL
> >  #endif /* CONFIG_PM_SLEEP */
> > 
> > -static const struct acpi_device_id vmbus_acpi_device_ids[] = {
> > +static const __maybe_unused struct of_device_id vmbus_of_match[] = {
> > +	{
> > +		.compatible = "microsoft,vmbus",
> > +	},
> > +	{
> > +		/* sentinel */
> > +	},
> > +};
> > +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> > +
> > +static const __maybe_unused struct acpi_device_id vmbus_acpi_device_ids[] = {
> >  	{"VMBUS", 0},
> >  	{"VMBus", 0},
> >  	{"", 0},
> > @@ -2668,6 +2723,7 @@ static struct platform_driver vmbus_platform_driver = {
> >  	.driver = {
> >  		.name = "vmbus",
> >  		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> > +		.of_match_table = of_match_ptr(vmbus_of_match),
> >  		.pm = &vmbus_bus_pm,
> >  		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> >  	}
> > --
> > 2.34.1
