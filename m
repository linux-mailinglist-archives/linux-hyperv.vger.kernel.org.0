Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0F66E234
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjAQPce (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 10:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjAQPca (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 10:32:30 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2D75402C4;
        Tue, 17 Jan 2023 07:32:28 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 88A4720DFE99; Tue, 17 Jan 2023 07:32:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88A4720DFE99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673969548;
        bh=tygkmqsokNx2PjpIMB5o5gt6WTG4pWSGRAfXPawVIe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShYMsly07JB+u7eOAYSKp1JdioZqydhynsFsqCO2uem3QIyKB9leSwgLlwshTcXAb
         hHXe9rUoywpWWuKJxFej94jrPr8eoBP3JwYIaPOvX8UMzQGvZSWqQZc1BhRIQ2/8ZV
         6qoxCifdLcMsQwdlfgk4+D57tb3B1/Nn+E0CVwn4=
Date:   Tue, 17 Jan 2023 07:32:28 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH 3/4] Drivers: hv: vmbus: Device Tree support
Message-ID: <20230117153228.GB9806@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-4-git-send-email-ssengar@linux.microsoft.com>
 <23b4ecbd-f7af-b1fd-6cc0-d23622a4115f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b4ecbd-f7af-b1fd-6cc0-d23622a4115f@linaro.org>
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

On Mon, Jan 16, 2023 at 07:48:25PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2023 17:48, Saurabh Sengar wrote:
> > Update the driver to use vmbus_root_dev device instead of acpi_device,
> > which can be assigned to either ACPI or OF device, making VMBus agnostic
> > to whether the device is using ACPI or device tree.
> > 
> 
> (...)
> 
> >  
> >  static void vmbus_reserve_fb(void)
> > @@ -2319,8 +2322,9 @@ static void vmbus_reserve_fb(void)
> >  	 * reserving a larger area and make it smaller until it succeeds.
> >  	 */
> >  	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
> > -		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
> > +		fb_mmio = __request_region(hyperv_mmio, start, size, "fb_range", 0);
> 
> Your patch is doing much more than just adding OF. Adding OF is usually
> just few lines, so this means you are refactoring driver and all this
> work should be split to self-contained patches.
> 
> >  }
> > +#endif /* CONFIG_ACPI */
> >  
> >  /**
> >   * vmbus_allocate_mmio() - Pick a memory-mapped I/O range.
> > @@ -2441,13 +2445,14 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> >  
> > +#ifdef CONFIG_ACPI
> >  static int vmbus_acpi_add(struct acpi_device *device)
> >  {
> >  	acpi_status result;
> >  	int ret_val = -ENODEV;
> >  	struct acpi_device *ancestor;
> >  
> > -	hv_acpi_dev = device;
> > +	vmbus_root_dev = &device->dev;
> >  
> >  	/*
> >  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> > @@ -2492,6 +2497,72 @@ static int vmbus_acpi_add(struct acpi_device *device)
> >  		vmbus_acpi_remove(device);
> >  	return ret_val;
> >  }
> > +#endif
> > +
> > +#ifdef CONFIG_OF
> > +static int vmbus_of_driver_probe(struct platform_device *dev)
> > +{
> > +	struct resource **cur_res = &hyperv_mmio;
> > +	struct device_node *np;
> > +	const __be32 *ranges;
> > +	u32 nr_addr, nr_size, nr_parent_addr_cells, nr_ranges;
> > +	u32 range_len, range_size;
> > +	int i;
> > +
> > +	vmbus_root_dev = &dev->dev;
> > +	np = vmbus_root_dev->of_node;
> > +
> > +	if (of_property_read_u32(np, "#address-cells", &nr_addr))
> > +		return -ENOENT;
> > +	if (of_property_read_u32(np, "#size-cells", &nr_size))
> > +		return -ENOENT;
> > +	nr_parent_addr_cells = of_n_addr_cells(np);
> > +
> > +	if (nr_parent_addr_cells != 2 || nr_addr != 2 || nr_size != 1) {
> > +		pr_err("Address format is not supported\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ranges = of_get_property(np, "ranges", &range_len);
> > +	if (!ranges)
> > +		return -ENOENT;
> > +
> > +	range_size = nr_parent_addr_cells + nr_addr + nr_size; // in cells
> > +	nr_ranges = range_len / sizeof(__be32) / range_size;
> > +
> > +	for (i = 0; i < nr_ranges; ++i, ranges += range_size) {
> > +		struct resource *res;
> > +		/*
> > +		 * The first u64 in the ranges description isn't used currently.
> > +		 * u64 _ = of_read_number(ranges, nr_parent_addr_cells);
> > +		 */
> > +		u64 start = of_read_number(ranges + nr_parent_addr_cells, nr_addr);
> > +		u32 len = of_read_number(ranges + nr_parent_addr_cells + nr_addr, nr_size);
> > +
> > +		pr_debug("VMBUS DeviceTree MMIO region start %#llx, %#x\n", start, len);
> 
> You must not print kernel or IO space addresses. You could use some
> printk formats to hide the address, if this is really needed.
> 
> > +
> > +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> > +		if (!res)
> > +			return -ENOMEM;
> > +
> > +		res->name = "hyperv mmio";
> > +		res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> > +		res->start = start;
> > +		res->end = start + len;
> > +
> > +		*cur_res = res;
> > +		cur_res = &res->sibling;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int vmbus_of_driver_remove(struct platform_device *dev)
> > +{
> > +	vmbus_remove_mmio();
> > +	return 0;
> > +}
> > +#endif
> >  
> >  #ifdef CONFIG_PM_SLEEP
> >  static int vmbus_bus_suspend(struct device *dev)
> > @@ -2630,6 +2701,9 @@ static int vmbus_bus_resume(struct device *dev)
> >  #define vmbus_bus_resume NULL
> >  #endif /* CONFIG_PM_SLEEP */
> >  
> > +#define DRV_NAME "vmbus"
> > +
> > +#ifdef CONFIG_ACPI
> >  static const struct acpi_device_id vmbus_acpi_device_ids[] = {
> >  	{"VMBUS", 0},
> >  	{"VMBus", 0},
> > @@ -2659,7 +2733,7 @@ static int vmbus_bus_resume(struct device *dev)
> >  };
> >  
> >  static struct acpi_driver vmbus_acpi_driver = {
> > -	.name = "vmbus",
> > +	.name = DRV_NAME,
> 
> How this is related?
> 
> >  	.ids = vmbus_acpi_device_ids,
> >  	.ops = {
> >  		.add = vmbus_acpi_add,
> > @@ -2669,6 +2743,7 @@ static int vmbus_bus_resume(struct device *dev)
> >  	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
> >  };
> >  
> > +#endif
> >  static void hv_kexec_handler(void)
> >  {
> >  	hv_stimer_global_cleanup();
> > @@ -2737,7 +2812,32 @@ static void hv_synic_resume(void)
> >  	.resume = hv_synic_resume,
> >  };
> >  
> > -static int __init hv_acpi_init(void)
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id vmbus_of_match[] = {
> > +	{
> > +		.name = "msft,vmbus",
> 
> Why do you need name?
> 
> > +		.compatible = "msft,vmbus",
> > +		.data = NULL
> 
> Why do you need data field?
> 
> > +	},
> > +	{
> > +		/* sentinel */
> > +	},
> > +};
> > +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> > +
> > +static struct platform_driver vmbus_platform_driver = {
> > +	.probe = vmbus_of_driver_probe,
> > +	.remove = vmbus_of_driver_remove,
> > +	.driver = {
> > +		.name = DRV_NAME,
> > +		.of_match_table = of_match_ptr(vmbus_of_match),
> > +		.pm = &vmbus_pm,
> > +		.bus = &hv_bus,
> > +	}
> > +};
> > +#endif
> 
> Why platform driver is hidden by CONFIG_OF? It should not be the case.
> The interface - ACPI or OF - should not differ for driver
> infrastructure. Even one probe could be used - just drop all of_...
> methods and use generic device_property_

This is a very heavily used driver with multiple drivers dependent on it
and I was reluctant to change what is working for so many years. Thus added
the OF support as minimal disturbance to existing systems. However, if this
needs to be changed I will work on evaluating what impact it will bring to
change acpi driver to platform for ACPI systems. If it all works-out, I
understand I have to send a patch to change existing acpi driver to platform
and then extend the device tree support in separate patch.

I can use device_propert_ but I am not clear how will that help parsing in
ACPI (DTSDS) flow, it will be lot simpler if we can have two separate parsing
functions for ACPI and OF. Hope having two separate parsing functions in single
probe is acceptable?

> > +
> > +static int __init vmbus_init(void)
> >  {
> >  	int ret;
> >  
> > @@ -2747,18 +2847,27 @@ static int __init hv_acpi_init(void)
> >  	if (hv_root_partition && !hv_nested)
> >  		return 0;
> >  
> > +#ifdef CONFIG_ACPI
> >  	/*
> > -	 * Get ACPI resources first.
> > +	 * Request ACPI resources and wait for the completion
> >  	 */
> >  	ret = acpi_bus_register_driver(&vmbus_acpi_driver);
> >  
> >  	if (ret)
> >  		return ret;
> >  
> > -	if (!hv_acpi_dev) {
> > -		ret = -ENODEV;
> > +	if (!vmbus_root_dev) {
> > +		ret = -ETIMEDOUT;
> >  		goto cleanup;
> >  	}
> > +#endif
> > +#ifdef CONFIG_OF
> > +	ret = platform_driver_register(&vmbus_platform_driver);
> > +	if (ret) {
> > +		pr_err("Error registering platform resources: %d\n", ret);
> > +		goto cleanup;
> > +	}
> > +#endif
> >  
> >  	/*
> >  	 * If we're on an architecture with a hardcoded hypervisor
> > @@ -2785,8 +2894,14 @@ static int __init hv_acpi_init(void)
> >  	return 0;
> >  
> >  cleanup:
> > +#ifdef CONFIG_ACPI
> >  	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> > -	hv_acpi_dev = NULL;
> > +#endif
> > +#ifdef CONFIG_OF
> > +	platform_driver_unregister(&vmbus_platform_driver);
> > +#endif
> > +	vmbus_root_dev = NULL;
> > +
> >  	return ret;
> >  }
> >  
> > @@ -2839,12 +2954,17 @@ static void __exit vmbus_exit(void)
> >  
> >  	cpuhp_remove_state(hyperv_cpuhp_online);
> >  	hv_synic_free();
> > +#ifdef CONFIG_ACPI
> >  	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> > +#endif
> > +#ifdef CONFIG_OF
> > +	platform_driver_unregister(&vmbus_platform_driver);
> > +#endif
> > +	vmbus_root_dev = NULL;
> >  }
> >  
> > -
> 
> This is really a messy patch...
> 
> >  MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("Microsoft Hyper-V VMBus Driver");
> >  
> > -subsys_initcall(hv_acpi_init);
> > +subsys_initcall(vmbus_init);
> >  module_exit(vmbus_exit);
> 
> Best regards,
> Krzysztof
