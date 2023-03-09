Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635DC6B2F68
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Mar 2023 22:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCIVQf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Mar 2023 16:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjCIVQe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Mar 2023 16:16:34 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC6F9D04;
        Thu,  9 Mar 2023 13:16:33 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id h11so3248510wrm.5;
        Thu, 09 Mar 2023 13:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678396591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spuAz/D/2gjibtqyeZd9Pa/cQy0mMO2RnLxbt9UDOmc=;
        b=QP8eVrKAR038W7bR45jQNpursR6M5YHWxc1seVJa3tJk+OLLUHeAOKqN/0J+Azb268
         kPcEet+G2VtxE2B0iZ/VDUvWPghYUZW4IpuzJf5oVdcJLp+3g+KnOQ3wXSnuvnTSOCzh
         0NKE/YeAnPWLr4J+ewgb+zdUHR9Atflmlor26eZ5UzUsV1FrkqULZWVMEmHGiNvUENBw
         foRRNhQEG2lhdUwrq5/jTEJRWyA1awnHdPh6rSEaRpaOL7Nj19CCFFlDUBY8pI0TdUsM
         Zqs2xQo17QwWbqTENPlCSUn4w1BDCp0ITgYHf4rMMDsJog5mQ9SU/7Na04UZrTbXpv0N
         SxaA==
X-Gm-Message-State: AO0yUKUbUfsYUkqAnHdZ/uRsUWuLVPKY14Lxf9DBu1+iXdaSizS4VSq2
        npgZhgKwoYd9jJ5t6qnBvho=
X-Google-Smtp-Source: AK7set9pxUBrjqufXVK26H2B7tEkbEgAZjbqWdPzgFFFDJIC74mNBMCvti0sl2eKWp72fUbhk67FQA==
X-Received: by 2002:a5d:6108:0:b0:2c5:4c9f:cf3b with SMTP id v8-20020a5d6108000000b002c54c9fcf3bmr61188wrt.7.1678396591357;
        Thu, 09 Mar 2023 13:16:31 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b002c71d206329sm369584wrw.55.2023.03.09.13.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:16:30 -0800 (PST)
Date:   Thu, 9 Mar 2023 21:16:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Message-ID: <ZApMqWPWgWXIju/g@liuwe-devbox-debian-v2>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 23, 2023 at 03:29:05AM -0800, Saurabh Sengar wrote:
[...]
> +#ifdef CONFIG_ACPI
>  static int vmbus_acpi_add(struct platform_device *pdev)
>  {
>  	acpi_status result;
> @@ -2494,10 +2497,47 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>  		vmbus_mmio_remove();
>  	return ret_val;
>  }
> +#endif
> +
> +static int vmbus_device_add(struct platform_device *pdev)
> +{
> +	struct resource **cur_res = &hyperv_mmio;
> +	struct of_range range;
> +	struct of_range_parser parser;
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	hv_dev = &pdev->dev;
> +
> +	ret = of_range_parser_init(&parser, np);
> +	if (ret)
> +		return ret;
> +
> +	for_each_of_range(&parser, &range) {
> +		struct resource *res;
> +
> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);

Why GFP_ATOMIC here? I don't think this function will be called in
atomic context, right?

> +		if (!res)
> +			return -ENOMEM;
> +
> +		res->name = "hyperv mmio";
> +		res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;

Are you sure IORESOURCE_MEM_64 is correct or required? The ACPI method
does not set this flag.

> +		res->start = range.cpu_addr;
> +		res->end = range.cpu_addr + range.size;
> +
> +		*cur_res = res;
> +		cur_res = &res->sibling;
> +	}
> +
> +	return ret;
> +}
>  
>  static int vmbus_platform_driver_probe(struct platform_device *pdev)
>  {
> +#ifdef CONFIG_ACPI
>  	return vmbus_acpi_add(pdev);
> +#endif

Please use #else here.

> +	return vmbus_device_add(pdev);

Is there going to be a configuration that ACPI and OF are available at
the same time? I don't see they are marked as mutually exclusive in the
proposed KConfig.

Thanks,
Wei.

>  }
>  
>  static int vmbus_platform_driver_remove(struct platform_device *pdev)
> @@ -2643,12 +2683,24 @@ static int vmbus_bus_resume(struct device *dev)
>  #define vmbus_bus_resume NULL
>  #endif /* CONFIG_PM_SLEEP */
>  
> +static const __maybe_unused struct of_device_id vmbus_of_match[] = {
> +	{
> +		.compatible = "microsoft,vmbus",
> +	},
> +	{
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> +
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id vmbus_acpi_device_ids[] = {
>  	{"VMBUS", 0},
>  	{"VMBus", 0},
>  	{"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
> +#endif
>  
>  /*
>   * Note: we must use the "no_irq" ops, otherwise hibernation can not work with
> @@ -2677,6 +2729,7 @@ static struct platform_driver vmbus_platform_driver = {
>  	.driver = {
>  		.name = "vmbus",
>  		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> +		.of_match_table = of_match_ptr(vmbus_of_match),
>  		.pm = &vmbus_bus_pm,
>  		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  	}
> -- 
> 2.34.1
> 
