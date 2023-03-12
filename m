Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CF6B68D5
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Mar 2023 18:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCLRjh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Mar 2023 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCLRjh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Mar 2023 13:39:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D565D3A98;
        Sun, 12 Mar 2023 10:39:35 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id EB31D20C56BB; Sun, 12 Mar 2023 10:39:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB31D20C56BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678642774;
        bh=Tgiw+sidUqBaEVObKi6x2FEJj/MiSGaWlJc+aPcKHhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2t6SkW9varvhF8aHA0IDcgMe9SNSJsGevu+rssAyDtVxTvBbQlLVSSqb7ZuuVlI8
         9E7BbvnvZXsC3E21ngMkovLUaSVqjrow12S7DvrcVF0BdJ+rNxKipqMGMSOnLrhtNI
         FC7fswKNpPfWa29Osx5fbk7uMVOGIxtgxX2xPkc8=
Date:   Sun, 12 Mar 2023 10:39:34 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Message-ID: <20230312173934.GA32212@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
 <ZApMqWPWgWXIju/g@liuwe-devbox-debian-v2>
 <20230310053451.GA9705@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <BYAPR21MB1688FD8EA30E876F22560645D7B89@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688FD8EA30E876F22560645D7B89@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On Sun, Mar 12, 2023 at 01:08:02PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, March 9, 2023 9:35 PM
> > 
> > On Thu, Mar 09, 2023 at 09:16:25PM +0000, Wei Liu wrote:
> > > On Thu, Feb 23, 2023 at 03:29:05AM -0800, Saurabh Sengar wrote:
> 
> [snip]
> 
> > > >
> > > >  static int vmbus_platform_driver_probe(struct platform_device *pdev)
> > > >  {
> > > > +#ifdef CONFIG_ACPI
> > > >  	return vmbus_acpi_add(pdev);
> > > > +#endif
> > >
> > > Please use #else here.
> > >
> > > > +	return vmbus_device_add(pdev);
> > >
> > > Is there going to be a configuration that ACPI and OF are available at
> > > the same time? I don't see they are marked as mutually exclusive in the
> > > proposed KConfig.
> > 
> > Initially, the device tree functions was included in "#else" section after
> > the "#ifdef CONFIG_ACPI" section. However, it was subsequently removed to
> > increase the coverage for CI builds.
> > 
> > Ref: https://lkml.org/lkml/2023/2/7/910
> > 
> 
> I think the point here is that it is possible (and even likely on ARM64?) to
> build a kernel where CONFIG_ACPI and CONFIG_OF are both "Y".   So the
> code for ACPI and OF is compiled and present in the kernel image.  However,
> for a particular Linux boot on a particular hardware or virtual platform,
> only one of the two will be enabled.   I specifically mention a particular Linux
> kernel boot because there's a kernel boot line option that can force disabling
> ACPI.  Ideally, the VMBus code should work if both CONFIG_ACPI and
> CONFIG_OF are enabled in the kernel image, and it would determine at
> runtime which to use. This approach meets the goals Rob spells out.
> 
> There's an exported global variable "acpi_disabled" that is set correctly
> depending on CONFIG_ACPI and the kernel boot line option (and perhaps if
> ACPI is not detected at runtime during boot -- I didn't check all the details).
> So the above could be written as:
> 
> 	if (!acpi_disabled)
> 		return vmbus_acpi_add(pdev); 
> 	else
> 		return vmbus_device_add(pdev);
> 
> This avoids the weird "two return statements in a row" while preferring
> ACPI over OF if ACPI is enabled for a particular boot of Linux.
> 
> I'm not sure if you'll need a stub for vmbus_acpi_add() when CONFIG_ACPI=n.
> In that case, acpi_disabled is #defined to be 1, so the compiler should just
> drop the call to vmbus_acpi_add() entirely and no stub will be needed.  But
> you'll need to confirm.

Thanks for suggesting acpi_disabled, definitely this looks better. However,
we need a dummy stub for vmbus_acpi_add in case of CONFIG_ACPI=n, as compiler
doesn't take out vmbus_acpi_add reference completely for CONFIG_ACPI=n.

> 
> Also just confirming, it looks like vmbus_device_add() compiles correctly if
> CONFIG_OF=n.  There are enough stubs in places so that you don't need an
> #ifdef CONFIG_OF around vmbus_device_add() like is needed for
> vmbus_acpi_add().

Yes, I tested this scenario.

> 
> > > >
> > > > +static const __maybe_unused struct of_device_id vmbus_of_match[] = {
> > > > +	{
> > > > +		.compatible = "microsoft,vmbus",
> > > > +	},
> > > > +	{
> > > > +		/* sentinel */
> > > > +	},
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> > > > +
> > > > +#ifdef CONFIG_ACPI
> > > >  static const struct acpi_device_id vmbus_acpi_device_ids[] = {
> > > >  	{"VMBUS", 0},
> > > >  	{"VMBus", 0},
> > > >  	{"", 0},
> > > >  };
> > > >  MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
> > > > +#endif
> 
> Couldn't the bracketing #ifdef be dropped and add __maybe_unused, just
> as you've done with vmbus_of_match?   ACPI_PTR() is defined to return NULL
> if CONFIG_ACPI=n, just like with of_match_ptr() and CONFIG_OF.

I kept #ifdef so that all the acpi code is treated equally. However, I am
fine to use __maybe_unused, will fix this in next version.

Regards,
Saurabh

> 
> > > >
> > > >  /*
> > > >   * Note: we must use the "no_irq" ops, otherwise hibernation can not work with
> > > > @@ -2677,6 +2729,7 @@ static struct platform_driver vmbus_platform_driver = {
> > > >  	.driver = {
> > > >  		.name = "vmbus",
> > > >  		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> > > > +		.of_match_table = of_match_ptr(vmbus_of_match),
> > > >  		.pm = &vmbus_bus_pm,
> > > >  		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> > > >  	}
> > > > --
> > > > 2.34.1
> > > >
