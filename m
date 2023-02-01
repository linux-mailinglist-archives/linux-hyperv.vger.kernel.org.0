Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE3686C15
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 17:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBAQvf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 11:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBAQvf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 11:51:35 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5CB95DC1A;
        Wed,  1 Feb 2023 08:51:33 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 97AB020B7102; Wed,  1 Feb 2023 08:51:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97AB020B7102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675270293;
        bh=KJbAwCn0TGn9+iQ2/tVx4JONaQBj9mJvNHGMDGM632U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9+xi+rv2I/V3tvdmJwTYKVfNxwHXrhk3YuFjRx9VmV1lc+o1A9Wu+cOUOX6Iwt4w
         qWbJ0+X0KIq3CtjGHl5FYFxixRmdGMvV2Cg828Y6P7R6uOVC5mS0IIHIsKt7uR60/B
         23Hq+dq0qXf7mxfRScckrGtO4KqjHpYAcUEiu/XI=
Date:   Wed, 1 Feb 2023 08:51:33 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
Message-ID: <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 02:12:53PM -0600, Rob Herring wrote:
> On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> <ssengar@linux.microsoft.com> wrote:
> >
> > Update the driver to support device tree boot as well along with ACPI.
> > At present the device tree parsing only provides the mmio region info
> > and is not the exact copy of ACPI parsing. This is sufficient to cater
> > all the current device tree usecases for VMBus.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 75 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 49030e756b9f..1741f1348f9f 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2152,7 +2152,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> >         device_unregister(&device_obj->device);
> >  }
> >
> > -
> > +#ifdef CONFIG_ACPI
> >  /*
> >   * VMBUS is an acpi enumerated device. Get the information we
> >   * need from DSDT.
> > @@ -2262,6 +2262,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
> >
> >         return AE_OK;
> >  }
> > +#endif
> >
> >  static void vmbus_mmio_remove(void)
> >  {
> > @@ -2282,7 +2283,7 @@ static void vmbus_mmio_remove(void)
> >         }
> >  }
> >
> > -static void vmbus_reserve_fb(void)
> > +static void __maybe_unused vmbus_reserve_fb(void)
> >  {
> >         resource_size_t start = 0, size;
> >         struct pci_dev *pdev;
> > @@ -2442,6 +2443,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> >
> > +#ifdef CONFIG_ACPI
> 
> It's better to put C 'if (!IS_ENABLED(CONFIG_ACPI)' code in the

I wanted to have separate function for ACPI and device tree flow, which
can be easily maintained with #ifdef. Please let me know if its fine.

> 
> >  static int vmbus_acpi_add(struct platform_device *pdev)
> >  {
> >         acpi_status result;
> > @@ -2496,10 +2498,68 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> >                 vmbus_mmio_remove();
> >         return ret_val;
> >  }
> > +#else
> > +
> > +static int vmbus_device_add(struct platform_device *pdev)
> > +{
> > +       struct resource **cur_res = &hyperv_mmio;
> > +       struct device_node *np;
> > +       u32 *ranges, len;
> > +       u64 start;
> > +       int nr_ranges, child_cells = 2, cur_cell = 0, ret = 0;
> > +
> > +       hv_dev = pdev;
> > +       np = pdev->dev.of_node;
> > +
> > +       nr_ranges = device_property_count_u32(&pdev->dev, "ranges");
> 
> Parsing ranges yourself is a bad sign. It's a standard property and we
> have functions which handle it. If those don't work, then something is
> wrong with your DT or they need to be fixed/expanded.

I find all the  standard functions which parse "ranges" property are doing
much more then I need. Our requirement is to only pass the mmio memory range
and size, I couldn't find any standard API doing this.

I see some of the drivers are using these APIs to parse ranges property hence
I follwed those examples. I will be happy to improve it if I get any better
alternative.

> 
> > +       if (nr_ranges < 0)
> > +               return nr_ranges;
> > +       ranges = kcalloc(nr_ranges, sizeof(u32), GFP_KERNEL);
> > +       if (!ranges)
> > +               return -ENOMEM;
> > +
> > +       if (device_property_read_u32_array(&pdev->dev, "ranges", ranges, nr_ranges)) {
> > +               ret =  -EINVAL;
> > +               goto free_ranges;
> > +       }
> > +
> > +       while (cur_cell < nr_ranges) {
> > +               struct resource *res;
> > +
> > +               /* The first u64 in the ranges description isn't used currently. */
> > +               cur_cell = cur_cell + child_cells;
> > +               start = ranges[cur_cell++];
> > +               start = (start << 32) | ranges[cur_cell++];
> > +               len = ranges[cur_cell++];
> 
> To expand my last point, the format of ranges is <child_addr
> parent_addr length>. That's not what your 'ranges' has. You've also
> just ignored '#address-cells' and '#size-cells'.

Got it. However I need to check if there is any standard API which can
give me these values, otherwise I may have to parse these as well :(

Regards,
Saurabh

> 
> > +
> > +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
> > +               if (!res) {
> > +                       ret = -ENOMEM;
> > +                       goto free_ranges;
> > +               }
> > +
> > +               res->name = "hyperv mmio";
> > +               res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> > +               res->start = start;
> > +               res->end = start + len;
> > +
> > +               *cur_res = res;
> > +               cur_res = &res->sibling;
> > +       }
> > +
> > +free_ranges:
> > +       kfree(ranges);
> > +       return ret;
> > +}
> > +#endif
> >
> >  static int vmbus_platform_driver_probe(struct platform_device *pdev)
> >  {
> > +#ifdef CONFIG_ACPI
> >         return vmbus_acpi_add(pdev);
> > +#else
> > +       return vmbus_device_add(pdev);
> > +#endif
> >  }
> >
> >  static int vmbus_platform_driver_remove(struct platform_device *pdev)
> > @@ -2645,6 +2705,16 @@ static int vmbus_bus_resume(struct device *dev)
> >  #define vmbus_bus_resume NULL
> >  #endif /* CONFIG_PM_SLEEP */
> >
> > +static const struct of_device_id vmbus_of_match[] = {
> > +       {
> > +               .compatible = "msft,vmbus",
> > +       },
> > +       {
> > +               /* sentinel */
> > +       },
> > +};
> > +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> > +
> >  static const struct acpi_device_id vmbus_acpi_device_ids[] = {
> >         {"VMBUS", 0},
> >         {"VMBus", 0},
> > @@ -2679,6 +2749,7 @@ static struct platform_driver vmbus_platform_driver = {
> >         .driver = {
> >                 .name = "vmbus",
> >                 .acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> > +               .of_match_table = of_match_ptr(vmbus_of_match),
> >                 .pm = &vmbus_bus_pm,
> >                 .probe_type = PROBE_FORCE_SYNCHRONOUS,
> >         }
> > --
> > 2.25.1
> >
