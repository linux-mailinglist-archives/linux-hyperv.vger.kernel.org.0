Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE066CF19
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jan 2023 19:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjAPSsd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 13:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjAPSsc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 13:48:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD82101
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Jan 2023 10:48:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so70063285ejm.8
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Jan 2023 10:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZE+8MYQrjdRkni9CMrPof04JvabBhs1EK300893KfU=;
        b=fqsIqYbPigzjiGuSVFqs+xq0BA1XZI29jPn1XAei8lRLFQuO/bC9jGNiRFI2xiyhMx
         fnHcYbU2m9EC5kkQg0gXUnRckKi6a8RgFDBuFpdbPXxej2USKE1nWaNlTxR1w0FwUqGH
         BqeG7u5L6yhEX3rQA1ERHVb5z3a35wIlgQENZAv0GjQxn/JVnfFrUr1vT8OatnFhG24l
         euFPObtBTzuf9qaaD/prufJCmgm4sPRLO5Vxz/AxTzEmEUn6hNncVu054ijWmmepkiq+
         xfJujSqC/zmsbEhWzGTt9LgWZkwrFsQk3fnR90w9EEyGvSzK1BykTAL3N4eGBVnFkbd7
         Aatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZE+8MYQrjdRkni9CMrPof04JvabBhs1EK300893KfU=;
        b=scbTx89RCD4sdPVBUE8v2GsAhKTBfzzjRujTrage4ng0ThRLSPO+5dpnQ+9qPYEfIJ
         XNI7/I+0aOf7NC5Qbv/B6bBuz5GQ8vpYAISFX0uDSo1aVhgBM+LgPMFJOKAal0V1vS4W
         vAdPwnB/A0EIgWvJoJSFqxhg5DHLoxYqj36kZ/eFC7xZeg7KI+HYwu+DAGxRff432csN
         Ns2eKSUoojo2o1LA3geAd3Hn+IvcrGzQGA3d9TT5rimw1MXdwk7KYkXs8LxcGOTlQbp3
         iP+4dymj+TWnfzrpbCoKK1lMfx/zrqs46J+aqiT8o+WJscGzA6ptVORqsrJ95Vx2AeFp
         dp1A==
X-Gm-Message-State: AFqh2ko0EVl6bStff042gUlt1rfNC46Q1e3i/MmwFJhgip+ZFb96JPEF
        AKD6DR8kaX1+DbaH9CtOIvBgPg==
X-Google-Smtp-Source: AMrXdXvpwCBM5sWlVdlSCT+/l/6Eg0FleVnZs7Wc7WrQOI8UkmuhqgOMe3pqMx7xn9t6VvyZWR9Y6w==
X-Received: by 2002:a17:906:99ce:b0:871:89ac:decb with SMTP id s14-20020a17090699ce00b0087189acdecbmr2609614ejn.76.1673894907834;
        Mon, 16 Jan 2023 10:48:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b0084cc87c03ebsm12053451ejh.110.2023.01.16.10.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:48:27 -0800 (PST)
Message-ID: <23b4ecbd-f7af-b1fd-6cc0-d23622a4115f@linaro.org>
Date:   Mon, 16 Jan 2023 19:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] Drivers: hv: vmbus: Device Tree support
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-4-git-send-email-ssengar@linux.microsoft.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673887688-19151-4-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 16/01/2023 17:48, Saurabh Sengar wrote:
> Update the driver to use vmbus_root_dev device instead of acpi_device,
> which can be assigned to either ACPI or OF device, making VMBus agnostic
> to whether the device is using ACPI or device tree.
> 

(...)

>  
>  static void vmbus_reserve_fb(void)
> @@ -2319,8 +2322,9 @@ static void vmbus_reserve_fb(void)
>  	 * reserving a larger area and make it smaller until it succeeds.
>  	 */
>  	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
> -		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
> +		fb_mmio = __request_region(hyperv_mmio, start, size, "fb_range", 0);

Your patch is doing much more than just adding OF. Adding OF is usually
just few lines, so this means you are refactoring driver and all this
work should be split to self-contained patches.

>  }
> +#endif /* CONFIG_ACPI */
>  
>  /**
>   * vmbus_allocate_mmio() - Pick a memory-mapped I/O range.
> @@ -2441,13 +2445,14 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
>  
> +#ifdef CONFIG_ACPI
>  static int vmbus_acpi_add(struct acpi_device *device)
>  {
>  	acpi_status result;
>  	int ret_val = -ENODEV;
>  	struct acpi_device *ancestor;
>  
> -	hv_acpi_dev = device;
> +	vmbus_root_dev = &device->dev;
>  
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2492,6 +2497,72 @@ static int vmbus_acpi_add(struct acpi_device *device)
>  		vmbus_acpi_remove(device);
>  	return ret_val;
>  }
> +#endif
> +
> +#ifdef CONFIG_OF
> +static int vmbus_of_driver_probe(struct platform_device *dev)
> +{
> +	struct resource **cur_res = &hyperv_mmio;
> +	struct device_node *np;
> +	const __be32 *ranges;
> +	u32 nr_addr, nr_size, nr_parent_addr_cells, nr_ranges;
> +	u32 range_len, range_size;
> +	int i;
> +
> +	vmbus_root_dev = &dev->dev;
> +	np = vmbus_root_dev->of_node;
> +
> +	if (of_property_read_u32(np, "#address-cells", &nr_addr))
> +		return -ENOENT;
> +	if (of_property_read_u32(np, "#size-cells", &nr_size))
> +		return -ENOENT;
> +	nr_parent_addr_cells = of_n_addr_cells(np);
> +
> +	if (nr_parent_addr_cells != 2 || nr_addr != 2 || nr_size != 1) {
> +		pr_err("Address format is not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	ranges = of_get_property(np, "ranges", &range_len);
> +	if (!ranges)
> +		return -ENOENT;
> +
> +	range_size = nr_parent_addr_cells + nr_addr + nr_size; // in cells
> +	nr_ranges = range_len / sizeof(__be32) / range_size;
> +
> +	for (i = 0; i < nr_ranges; ++i, ranges += range_size) {
> +		struct resource *res;
> +		/*
> +		 * The first u64 in the ranges description isn't used currently.
> +		 * u64 _ = of_read_number(ranges, nr_parent_addr_cells);
> +		 */
> +		u64 start = of_read_number(ranges + nr_parent_addr_cells, nr_addr);
> +		u32 len = of_read_number(ranges + nr_parent_addr_cells + nr_addr, nr_size);
> +
> +		pr_debug("VMBUS DeviceTree MMIO region start %#llx, %#x\n", start, len);

You must not print kernel or IO space addresses. You could use some
printk formats to hide the address, if this is really needed.

> +
> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +		if (!res)
> +			return -ENOMEM;
> +
> +		res->name = "hyperv mmio";
> +		res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> +		res->start = start;
> +		res->end = start + len;
> +
> +		*cur_res = res;
> +		cur_res = &res->sibling;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vmbus_of_driver_remove(struct platform_device *dev)
> +{
> +	vmbus_remove_mmio();
> +	return 0;
> +}
> +#endif
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int vmbus_bus_suspend(struct device *dev)
> @@ -2630,6 +2701,9 @@ static int vmbus_bus_resume(struct device *dev)
>  #define vmbus_bus_resume NULL
>  #endif /* CONFIG_PM_SLEEP */
>  
> +#define DRV_NAME "vmbus"
> +
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id vmbus_acpi_device_ids[] = {
>  	{"VMBUS", 0},
>  	{"VMBus", 0},
> @@ -2659,7 +2733,7 @@ static int vmbus_bus_resume(struct device *dev)
>  };
>  
>  static struct acpi_driver vmbus_acpi_driver = {
> -	.name = "vmbus",
> +	.name = DRV_NAME,

How this is related?

>  	.ids = vmbus_acpi_device_ids,
>  	.ops = {
>  		.add = vmbus_acpi_add,
> @@ -2669,6 +2743,7 @@ static int vmbus_bus_resume(struct device *dev)
>  	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  };
>  
> +#endif
>  static void hv_kexec_handler(void)
>  {
>  	hv_stimer_global_cleanup();
> @@ -2737,7 +2812,32 @@ static void hv_synic_resume(void)
>  	.resume = hv_synic_resume,
>  };
>  
> -static int __init hv_acpi_init(void)
> +#ifdef CONFIG_OF
> +static const struct of_device_id vmbus_of_match[] = {
> +	{
> +		.name = "msft,vmbus",

Why do you need name?

> +		.compatible = "msft,vmbus",
> +		.data = NULL

Why do you need data field?

> +	},
> +	{
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> +
> +static struct platform_driver vmbus_platform_driver = {
> +	.probe = vmbus_of_driver_probe,
> +	.remove = vmbus_of_driver_remove,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(vmbus_of_match),
> +		.pm = &vmbus_pm,
> +		.bus = &hv_bus,
> +	}
> +};
> +#endif

Why platform driver is hidden by CONFIG_OF? It should not be the case.
The interface - ACPI or OF - should not differ for driver
infrastructure. Even one probe could be used - just drop all of_...
methods and use generic device_property_
> +
> +static int __init vmbus_init(void)
>  {
>  	int ret;
>  
> @@ -2747,18 +2847,27 @@ static int __init hv_acpi_init(void)
>  	if (hv_root_partition && !hv_nested)
>  		return 0;
>  
> +#ifdef CONFIG_ACPI
>  	/*
> -	 * Get ACPI resources first.
> +	 * Request ACPI resources and wait for the completion
>  	 */
>  	ret = acpi_bus_register_driver(&vmbus_acpi_driver);
>  
>  	if (ret)
>  		return ret;
>  
> -	if (!hv_acpi_dev) {
> -		ret = -ENODEV;
> +	if (!vmbus_root_dev) {
> +		ret = -ETIMEDOUT;
>  		goto cleanup;
>  	}
> +#endif
> +#ifdef CONFIG_OF
> +	ret = platform_driver_register(&vmbus_platform_driver);
> +	if (ret) {
> +		pr_err("Error registering platform resources: %d\n", ret);
> +		goto cleanup;
> +	}
> +#endif
>  
>  	/*
>  	 * If we're on an architecture with a hardcoded hypervisor
> @@ -2785,8 +2894,14 @@ static int __init hv_acpi_init(void)
>  	return 0;
>  
>  cleanup:
> +#ifdef CONFIG_ACPI
>  	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> -	hv_acpi_dev = NULL;
> +#endif
> +#ifdef CONFIG_OF
> +	platform_driver_unregister(&vmbus_platform_driver);
> +#endif
> +	vmbus_root_dev = NULL;
> +
>  	return ret;
>  }
>  
> @@ -2839,12 +2954,17 @@ static void __exit vmbus_exit(void)
>  
>  	cpuhp_remove_state(hyperv_cpuhp_online);
>  	hv_synic_free();
> +#ifdef CONFIG_ACPI
>  	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> +#endif
> +#ifdef CONFIG_OF
> +	platform_driver_unregister(&vmbus_platform_driver);
> +#endif
> +	vmbus_root_dev = NULL;
>  }
>  
> -

This is really a messy patch...

>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V VMBus Driver");
>  
> -subsys_initcall(hv_acpi_init);
> +subsys_initcall(vmbus_init);
>  module_exit(vmbus_exit);

Best regards,
Krzysztof

