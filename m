Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65C69AC5F
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 14:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBQN1M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Feb 2023 08:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQN1L (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Feb 2023 08:27:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F032564B1A;
        Fri, 17 Feb 2023 05:27:10 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 5D15F20B9C3D; Fri, 17 Feb 2023 05:27:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D15F20B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676640430;
        bh=1XQPwIYtARC3Ha2D1JM0GDKjkekBcLSmNRRm5xcWlKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIwNfwO0iE/wqX1tA1UBaC0L4E3QSIMrN8FjQEPY+U50gsyd/uT8bM90j+D1R/e8J
         nZnLqGcTFL5E4zXZ+PW16Uc/RH9DUVmO+1V0Kjt4Ve+7V4zcThGQIEKLMXUreSkXVu
         Cc1w2yYXuuk5lG7K4ye/nC552zkzuuFv7Mu6n1gk=
Date:   Fri, 17 Feb 2023 05:27:10 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        dphadke@linux.microsoft.com
Subject: Re: [PATCH v5 5/5] Driver: VMBus: Add device tree support
Message-ID: <20230217132710.GA4165@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
 <1675944939-22631-6-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK0WgWm-mG=fYyDVAi4uhL+fM0OD7KEF+xYYOOGNX8-oQ@mail.gmail.com>
 <20230209174641.GB1346@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_JsqK+4ecEmGyo0jVs3B-E6Rjj4Lo8vB0En6pEUR1P4cRXpA@mail.gmail.com>
 <20230213112439.GA15305@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213112439.GA15305@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On Mon, Feb 13, 2023 at 03:24:39AM -0800, Saurabh Singh Sengar wrote:
> On Fri, Feb 10, 2023 at 04:37:28PM -0600, Rob Herring wrote:
> > On Thu, Feb 9, 2023 at 11:46 AM Saurabh Singh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > >
> > > On Thu, Feb 09, 2023 at 09:50:31AM -0600, Rob Herring wrote:
> > > > On Thu, Feb 9, 2023 at 6:15 AM Saurabh Sengar
> > > > <ssengar@linux.microsoft.com> wrote:
> > > > >
> > > > > Update the driver to support device tree boot as well along with ACPI.
> > > >
> > > > Devicetree
> > 
> > [...]
> > 
> > > > > +       for_each_of_range(&parser, &range) {
> > > > > +               struct resource *res;
> > > > > +
> > > > > +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
> > > > > +               if (!res)
> > > > > +                       return -ENOMEM;
> > > > > +
> > > > > +               res->name = "hyperv mmio";
> > > > > +               res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> > > > > +               res->start = range.pci_addr;
> > > >
> > > > This is not PCI. It's a union, so use 'bus_addr' instead.
> > > >
> > > > But wait, resources and IORESOURCE_MEM are *CPU* addresses. You need
> > > > cpu_addr here. Your DT happens to do 1:1 addresses so it happens to
> > > > work either way.
> > >
> > > bus_addr works for us, will send V6
> > 
> > Sigh. bus_addr may work, but is wrong as I explained.
> > 
> > And you've already sent v6... Please slow down your pace with sending
> > new versions. 4 versions in a week is too much. Give others time to
> > comment and me to respond to discussions. Like a week...
> 
> I apologize if my actions may have come across as overly hasty. I will make
> sure to allow for more time between submissions in the future, to ensure that
> everyone has an adequate opportunity to review and provide feedback.
> 
> Regarding the use of bus_addr instead of cpu_addr, I found that cpu_addr was
> populating as OF_BAD_ADDR while bus_addr was populating correctly.  I think
> this is because I should be defining a empty ranges property in parent node
> for indicating 1:1 mapping between parent and child.
> 
> But once I add empty ranges in property I get other warnings by dt_binding_check
> tool. After fixing all I am able to come up with below device tree example, please
> let me know if there is anything to be corrected. If this is good I will send
> the next version (offcource after a week :)) using cpu_addr.
> 
>     soc {
>         #address-cells = <2>;
>         #size-cells = <1>;
>         bus {
>             compatible = "simple-bus";
>             #address-cells = <2>;
>             #size-cells = <1>;
>             ranges;
> 
>             vmbus@ff0000000 {
>                 compatible = "microsoft,vmbus";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>                 ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
>             };
>         };
>     };
> 
> > 

Rob,

If you find the above changes satisfactory, please do let me know so that
I can send the updated version.

As far as I am aware, all the pending comments and issues have been addressed
in this series. However, if there are any remaining concerns or feedback that
require attention, please let me know.

- Saurabh

> > Rob
