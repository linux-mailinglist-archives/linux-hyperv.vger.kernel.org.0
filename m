Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E5686DF3
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBASbp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 13:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjBASbo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 13:31:44 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22B982BF36;
        Wed,  1 Feb 2023 10:31:43 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id CD32520B74F7; Wed,  1 Feb 2023 10:31:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD32520B74F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675276301;
        bh=5l6X8n+sLaMl1oSrN2WO8DaIAyt6VmAKYZDLl+sqKbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IehjFntxghdUgdtSLPG710qlB8D8CpfRUmwLBLBKOrMcwMPSvINFYFZWbiRR0DSDh
         6L9s0i7pLY/W4IEBQ9TxWGBIp0eUIyxQjQRS8L1/MKELA8riP26DzjB2/WEP6mpD5g
         rJI+x8H6Y84GgYNVJsm7r0jHo7QdBnub6eypD92M=
Date:   Wed, 1 Feb 2023 10:31:41 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
Message-ID: <20230201183141.GA6988@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
 <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201174638.GA3872117-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201174638.GA3872117-robh@kernel.org>
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

On Wed, Feb 01, 2023 at 11:46:38AM -0600, Rob Herring wrote:
> On Wed, Feb 01, 2023 at 08:51:33AM -0800, Saurabh Singh Sengar wrote:
> > On Tue, Jan 31, 2023 at 02:12:53PM -0600, Rob Herring wrote:
> > > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > > <ssengar@linux.microsoft.com> wrote:
> > > >
(...)
> > > > @@ -2442,6 +2443,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> > > >
> > > > +#ifdef CONFIG_ACPI
> > > 
> > > It's better to put C 'if (!IS_ENABLED(CONFIG_ACPI)' code in the
> > 
> > I wanted to have separate function for ACPI and device tree flow, which
> > can be easily maintained with #ifdef. Please let me know if its fine.
> 
> Yes, you can have separate functions:
> 
> static int vmbus_acpi_add(struct platform_device *pdev)
> {
> 	if (!IS_ENABLED(CONFIG_ACPI))
> 		return -ENODEV;
> 
> 	...
> }
> 
> The compiler will throw away the function in the end if CONFIG_ACPI is 
> not enabled.
> 
> That is easier for us to maintain because it reduces the combinations to 
> build.

Thanks, Will fix this in v3.

> 
> > 
> > > 
> > > >  static int vmbus_acpi_add(struct platform_device *pdev)
> > > >  {
> > > >         acpi_status result;
> > > > @@ -2496,10 +2498,68 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> > > >                 vmbus_mmio_remove();
> > > >         return ret_val;
> > > >  }
> > > > +#else
> > > > +
> > > > +static int vmbus_device_add(struct platform_device *pdev)
> > > > +{
> > > > +       struct resource **cur_res = &hyperv_mmio;
> > > > +       struct device_node *np;
> > > > +       u32 *ranges, len;
> > > > +       u64 start;
> > > > +       int nr_ranges, child_cells = 2, cur_cell = 0, ret = 0;
> > > > +
> > > > +       hv_dev = pdev;
> > > > +       np = pdev->dev.of_node;
> > > > +
> > > > +       nr_ranges = device_property_count_u32(&pdev->dev, "ranges");
> > > 
> > > Parsing ranges yourself is a bad sign. It's a standard property and we
> > > have functions which handle it. If those don't work, then something is
> > > wrong with your DT or they need to be fixed/expanded.
> > 
> > I find all the  standard functions which parse "ranges" property are doing
> > much more then I need. Our requirement is to only pass the mmio memory range
> > and size, I couldn't find any standard API doing this.
> 
> You can't just change how standard properties work to suit your needs.
> 
> We shouldn't even be having this discussion because we have tools to 
> check all this now. dtc does some and dtschema does a lot more.
> 
> > I see some of the drivers are using these APIs to parse ranges property hence
> > I follwed those examples. I will be happy to improve it if I get any better
> > alternative.
> 
> You can always find bad examples to follow...
> 
> > > > +       if (nr_ranges < 0)
> > > > +               return nr_ranges;
> > > > +       ranges = kcalloc(nr_ranges, sizeof(u32), GFP_KERNEL);
> > > > +       if (!ranges)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       if (device_property_read_u32_array(&pdev->dev, "ranges", ranges, nr_ranges)) {
> > > > +               ret =  -EINVAL;
> > > > +               goto free_ranges;
> > > > +       }
> > > > +
> > > > +       while (cur_cell < nr_ranges) {
> > > > +               struct resource *res;
> > > > +
> > > > +               /* The first u64 in the ranges description isn't used currently. */
> > > > +               cur_cell = cur_cell + child_cells;
> > > > +               start = ranges[cur_cell++];
> > > > +               start = (start << 32) | ranges[cur_cell++];
> > > > +               len = ranges[cur_cell++];
> > > 
> > > To expand my last point, the format of ranges is <child_addr
> > > parent_addr length>. That's not what your 'ranges' has. You've also
> > > just ignored '#address-cells' and '#size-cells'.
> > 
> > Got it. However I need to check if there is any standard API which can
> > give me these values, otherwise I may have to parse these as well :(
> 
> for_each_of_range()
> 
> That is not how linux works. When the core code doesn't do what you 
> want, you adapt it to your needs. You don't work around it. Read 
> this[1].
> 
> Rob
> 
> [1] https://lwn.net/Articles/443531/

Thanks I will work on this suggestion and fix this up in next version.
