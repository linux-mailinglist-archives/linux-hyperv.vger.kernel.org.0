Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BD686D55
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBARqm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 12:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBARqm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 12:46:42 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC995113C4;
        Wed,  1 Feb 2023 09:46:40 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 123-20020a4a0681000000b004faa9c6f6b9so2012719ooj.11;
        Wed, 01 Feb 2023 09:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5ieMICCVHRQ7377at7SykjLSFOGHCDvEdg4MaUlrEI=;
        b=qSgBbUBs/DD1q1iQtlukZaTlvv2fN++P+GJT96ddRAMuwV0036uDHdMrUu4ZiLOe2K
         XllIvU1SsYHY3PA+a2XhpSmsqxnfWNzSaJ5ihQb1WdiseVoQ09RPL0PnQvTeuAhdRgZX
         HuRbcvbmrUbxlmU5Lol0FYPeiyBQayMYHkmX1x8iom5+W8uzWaQj4Q0aLh3XuZlq/bgQ
         9aG+RC0em5CVEtTEsn4s5KQWAglHx3VcmP3/CYXOJZL/t+Qe55cScrkx7waH+NEXfl3q
         nQPT304sDiJ8OgloTlGiVmbGzb/4ubUetD7ymg2V8P+b7ZuvzRA8tjWSa6NDPblgLVEj
         qrAA==
X-Gm-Message-State: AO0yUKV4BfFmoJ296qHODrHQZP17XQB7/hsAEu+ohriglBlVi67RukEO
        MVRKp6+Uvv21X9t4TpAbUw==
X-Google-Smtp-Source: AK7set+96DYcWpNNDjOz3WVmZYP3qKBM36nDwTflxgqE4s8Zv/Y+Hek1aSYQygLj/tx4aDfNUN4/8A==
X-Received: by 2002:a05:6820:131:b0:517:3cd0:5505 with SMTP id i17-20020a056820013100b005173cd05505mr1635601ood.3.1675273599932;
        Wed, 01 Feb 2023 09:46:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j4-20020a4a92c4000000b004a3d98b2ccdsm7630636ooh.42.2023.02.01.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:46:39 -0800 (PST)
Received: (nullmailer pid 4050504 invoked by uid 1000);
        Wed, 01 Feb 2023 17:46:38 -0000
Date:   Wed, 1 Feb 2023 11:46:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
Message-ID: <20230201174638.GA3872117-robh@kernel.org>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
 <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 01, 2023 at 08:51:33AM -0800, Saurabh Singh Sengar wrote:
> On Tue, Jan 31, 2023 at 02:12:53PM -0600, Rob Herring wrote:
> > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > >
> > > Update the driver to support device tree boot as well along with ACPI.
> > > At present the device tree parsing only provides the mmio region info
> > > and is not the exact copy of ACPI parsing. This is sufficient to cater
> > > all the current device tree usecases for VMBus.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/hv/vmbus_drv.c | 75 ++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 73 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 49030e756b9f..1741f1348f9f 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -2152,7 +2152,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> > >         device_unregister(&device_obj->device);
> > >  }
> > >
> > > -
> > > +#ifdef CONFIG_ACPI
> > >  /*
> > >   * VMBUS is an acpi enumerated device. Get the information we
> > >   * need from DSDT.
> > > @@ -2262,6 +2262,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
> > >
> > >         return AE_OK;
> > >  }
> > > +#endif
> > >
> > >  static void vmbus_mmio_remove(void)
> > >  {
> > > @@ -2282,7 +2283,7 @@ static void vmbus_mmio_remove(void)
> > >         }
> > >  }
> > >
> > > -static void vmbus_reserve_fb(void)
> > > +static void __maybe_unused vmbus_reserve_fb(void)
> > >  {
> > >         resource_size_t start = 0, size;
> > >         struct pci_dev *pdev;
> > > @@ -2442,6 +2443,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
> > >  }
> > >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> > >
> > > +#ifdef CONFIG_ACPI
> > 
> > It's better to put C 'if (!IS_ENABLED(CONFIG_ACPI)' code in the
> 
> I wanted to have separate function for ACPI and device tree flow, which
> can be easily maintained with #ifdef. Please let me know if its fine.

Yes, you can have separate functions:

static int vmbus_acpi_add(struct platform_device *pdev)
{
	if (!IS_ENABLED(CONFIG_ACPI))
		return -ENODEV;

	...
}

The compiler will throw away the function in the end if CONFIG_ACPI is 
not enabled.

That is easier for us to maintain because it reduces the combinations to 
build.

> 
> > 
> > >  static int vmbus_acpi_add(struct platform_device *pdev)
> > >  {
> > >         acpi_status result;
> > > @@ -2496,10 +2498,68 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> > >                 vmbus_mmio_remove();
> > >         return ret_val;
> > >  }
> > > +#else
> > > +
> > > +static int vmbus_device_add(struct platform_device *pdev)
> > > +{
> > > +       struct resource **cur_res = &hyperv_mmio;
> > > +       struct device_node *np;
> > > +       u32 *ranges, len;
> > > +       u64 start;
> > > +       int nr_ranges, child_cells = 2, cur_cell = 0, ret = 0;
> > > +
> > > +       hv_dev = pdev;
> > > +       np = pdev->dev.of_node;
> > > +
> > > +       nr_ranges = device_property_count_u32(&pdev->dev, "ranges");
> > 
> > Parsing ranges yourself is a bad sign. It's a standard property and we
> > have functions which handle it. If those don't work, then something is
> > wrong with your DT or they need to be fixed/expanded.
> 
> I find all the  standard functions which parse "ranges" property are doing
> much more then I need. Our requirement is to only pass the mmio memory range
> and size, I couldn't find any standard API doing this.

You can't just change how standard properties work to suit your needs.

We shouldn't even be having this discussion because we have tools to 
check all this now. dtc does some and dtschema does a lot more.

> I see some of the drivers are using these APIs to parse ranges property hence
> I follwed those examples. I will be happy to improve it if I get any better
> alternative.

You can always find bad examples to follow...

> > > +       if (nr_ranges < 0)
> > > +               return nr_ranges;
> > > +       ranges = kcalloc(nr_ranges, sizeof(u32), GFP_KERNEL);
> > > +       if (!ranges)
> > > +               return -ENOMEM;
> > > +
> > > +       if (device_property_read_u32_array(&pdev->dev, "ranges", ranges, nr_ranges)) {
> > > +               ret =  -EINVAL;
> > > +               goto free_ranges;
> > > +       }
> > > +
> > > +       while (cur_cell < nr_ranges) {
> > > +               struct resource *res;
> > > +
> > > +               /* The first u64 in the ranges description isn't used currently. */
> > > +               cur_cell = cur_cell + child_cells;
> > > +               start = ranges[cur_cell++];
> > > +               start = (start << 32) | ranges[cur_cell++];
> > > +               len = ranges[cur_cell++];
> > 
> > To expand my last point, the format of ranges is <child_addr
> > parent_addr length>. That's not what your 'ranges' has. You've also
> > just ignored '#address-cells' and '#size-cells'.
> 
> Got it. However I need to check if there is any standard API which can
> give me these values, otherwise I may have to parse these as well :(

for_each_of_range()

That is not how linux works. When the core code doesn't do what you 
want, you adapt it to your needs. You don't work around it. Read 
this[1].

Rob

[1] https://lwn.net/Articles/443531/
