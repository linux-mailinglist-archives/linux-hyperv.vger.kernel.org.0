Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D826B361D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Mar 2023 06:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCJFe6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Mar 2023 00:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCJFe5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Mar 2023 00:34:57 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E662E3CFF;
        Thu,  9 Mar 2023 21:34:52 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 3FF782057662; Thu,  9 Mar 2023 21:34:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FF782057662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678426491;
        bh=RYAtr5AItIk0C9/lG/qyF6GRmWRU77CYa4oa7R3ouTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPoDWeoXafskvnthBqHWlyDs2sdEug8p1Wg6HIknr1ITib/yu3RQhUgGIlCCLPBed
         38koamXI28BB9SuuTT0yN3FDi1YSsZlzoZdLFPEdTgqFcYLA/74wCbNDG+x4D7RmZw
         HNU6uyOobPvzENVomoq5UafOwbb4K7e6GCQUTOsM=
Date:   Thu, 9 Mar 2023 21:34:51 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Message-ID: <20230310053451.GA9705@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
 <ZApMqWPWgWXIju/g@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZApMqWPWgWXIju/g@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 09, 2023 at 09:16:25PM +0000, Wei Liu wrote:
> On Thu, Feb 23, 2023 at 03:29:05AM -0800, Saurabh Sengar wrote:
> [...]
> > +#ifdef CONFIG_ACPI
> >  static int vmbus_acpi_add(struct platform_device *pdev)
> >  {
> >  	acpi_status result;
> > @@ -2494,10 +2497,47 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> >  		vmbus_mmio_remove();
> >  	return ret_val;
> >  }
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
> > +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> 
> Why GFP_ATOMIC here? I don't think this function will be called in
> atomic context, right?

Thanks for pointing this. I will fix this in next version.
Moreover, although there is a similar flag in the ACPI flow,
I am contemplating whether that also requires fixing.

> 
> > +		if (!res)
> > +			return -ENOMEM;
> > +
> > +		res->name = "hyperv mmio";
> > +		res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> 
> Are you sure IORESOURCE_MEM_64 is correct or required? The ACPI method
> does not set this flag.

Yes IORESOURCE_MEM_64 is required as there are cases where we are mapping
64 bit resources. But now I realize its better to fetch this info from range
struct only (range.flags), as for_each_of_range populates this flag.
I will fix this up as well.

> 
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
> > +#ifdef CONFIG_ACPI
> >  	return vmbus_acpi_add(pdev);
> > +#endif
> 
> Please use #else here.
> 
> > +	return vmbus_device_add(pdev);
> 
> Is there going to be a configuration that ACPI and OF are available at
> the same time? I don't see they are marked as mutually exclusive in the
> proposed KConfig.

Initially, the device tree functions was included in "#else" section after
the "#ifdef CONFIG_ACPI" section. However, it was subsequently removed to
increase the coverage for CI builds.

Ref: https://lkml.org/lkml/2023/2/7/910

Regards,
Saurabh

> 
> Thanks,
> Wei.
> 
> >  }
> >  
> >  static int vmbus_platform_driver_remove(struct platform_device *pdev)
> > @@ -2643,12 +2683,24 @@ static int vmbus_bus_resume(struct device *dev)
> >  #define vmbus_bus_resume NULL
> >  #endif /* CONFIG_PM_SLEEP */
> >  
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
> > +#ifdef CONFIG_ACPI
> >  static const struct acpi_device_id vmbus_acpi_device_ids[] = {
> >  	{"VMBUS", 0},
> >  	{"VMBus", 0},
> >  	{"", 0},
> >  };
> >  MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
> > +#endif
> >  
> >  /*
> >   * Note: we must use the "no_irq" ops, otherwise hibernation can not work with
> > @@ -2677,6 +2729,7 @@ static struct platform_driver vmbus_platform_driver = {
> >  	.driver = {
> >  		.name = "vmbus",
> >  		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> > +		.of_match_table = of_match_ptr(vmbus_of_match),
> >  		.pm = &vmbus_bus_pm,
> >  		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> >  	}
> > -- 
> > 2.34.1
> > 
