Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972426B7918
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Mar 2023 14:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCMNh3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Mar 2023 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCMNh2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Mar 2023 09:37:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BE85618B6;
        Mon, 13 Mar 2023 06:37:27 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 05B2D204DE9D; Mon, 13 Mar 2023 06:37:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05B2D204DE9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678714647;
        bh=mu87N414716r7lGE+91jVsaK9HmE6dXBcZU9c+oht9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aba7oqVGnjYnYppobv7WDRrE6mLzhXvx4Oqhb4+K0C7ncTNJMa+PJSK/Ay37fLVNx
         UjC0tWAQN978AhfSAWWcDK1mZ8ALQYRpZ2xAuzsH+OE1LjWJJGKEcB8lThPpdMI3vB
         VRTgEq6JOfa4nkI5VHqd7bQcf9jwn1dM5bjWy5k0=
Date:   Mon, 13 Mar 2023 06:37:26 -0700
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
Subject: Re: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Message-ID: <20230313133726.GA10298@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688B84E25DD2173B6023737D7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230313061603.GA8934@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <BYAPR21MB16888AD9A473CF15250B59C7D7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16888AD9A473CF15250B59C7D7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On Mon, Mar 13, 2023 at 12:26:56PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Sunday, March 12, 2023 11:16 PM
> > 
> > On Mon, Mar 13, 2023 at 02:33:53AM +0000, Michael Kelley (LINUX) wrote:
> > > From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, February 23,
> > 2023 3:29 AM
> > > >
> > > > Update the driver to support Devicetree boot as well along with ACPI.
> > > > At present the Devicetree parsing only provides the mmio region info
> > > > and is not the exact copy of ACPI parsing. This is sufficient to cater
> > > > all the current Devicetree usecases for VMBus.
> > > >
> > > > Currently Devicetree is supported only for x86 systems.
> > > >
> > > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > ---
> > > > [V7]
> > > > - Use cpu_addr instead of bus_addr
> > > >
> > > >  drivers/hv/Kconfig     |  6 +++--
> > > >  drivers/hv/vmbus_drv.c | 57 ++++++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 59 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > index 0747a8f1fcee..1a55bf32d195 100644
> > > > --- a/drivers/hv/Kconfig
> > > > +++ b/drivers/hv/Kconfig
> > > > @@ -4,11 +4,13 @@ menu "Microsoft Hyper-V guest support"
> > > >
> > > >  config HYPERV
> > > >  	tristate "Microsoft Hyper-V client drivers"
> > > > -	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > > > -		|| (ARM64 && !CPU_BIG_ENDIAN))
> > > > +	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > > > +		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> > > >  	select PARAVIRT
> > > >  	select X86_HV_CALLBACK_VECTOR if X86
> > > >  	select VMAP_PFN
> > > > +	select OF if !ACPI
> > > > +	select OF_EARLY_FLATTREE if !ACPI
> > > >  	help
> > > >  	  Select this option to run Linux as a Hyper-V client operating
> > > >  	  system.
> > >
> > > One further thing occurred to me.  OF_EARLY_FLATTREE really depends
> > > on OF instead of ACPI.   The ACPI dependency is indirect through OF.  So
> > > I'd suggest doing
> > >
> > > 	select OF_EARLY_FLATTRE if OF
> > >
> > > to express the direct dependency.
> > 
> > As you pointed out OF_EARLY_FLATTRE is anyway dependent on OF, and thus I
> > feel this check is redundant. I see all the Kconfig options which enables
> > both of these flags don't explicitly mention this dependency.
> > 
> > >
> > > Separately, I wonder if the "select OF if !ACPI" is even needed.  It doesn't
> > > hurt anything to leave it, but it seems like any config that doesn't
> > > independently select either ACPI or OF is broken for reasons unrelated
> > > to Hyper-V.  I'm OK with leaving the select of OF if you want, so I'm
> > > more just wondering than asserting it should be removed.   I didn't
> > > see "select OF if !ACPI" anywhere else in the Kconfig files, and it
> > > seems like Hyper-V would not be the only environment where this
> > > is the expectation.
> > 
> > Ok I can remove the !ACPI dependency. Hope kernel size increase due to both
> > the code compiled in shouldn't be problem for ACPI systems.
> > And here if config doesn't select ACPI or OF it will assume OF, which is
> > better then selecting none of them.
> > 
> > 
> > To address both of your comments I feel below will be sufficient:
> > select OF
> > select OF_EARLY_FLATTRE
> 
> Actually, that's not what I was thinking. :-)   I was thinking for the Hyper-V
> Kconfig to be silent on selecting OF, just like it is silent on selecting ACPI.
> Whoever is configuring the kernel build would separately be selecting
> ACPI, or OF, or both, depending on their needs.   I don't think the Hyper-V
> Kconfig should always be selecting OF, because of the reason you noted --
> it drags in code that is not needed for normal VTL 0 usage.  If you take
> that approach, then
> 
> 	select OF_EARLY_FLATTREE if OF
> 
> is appropriate.

Thanks for clarifying, I will fix this in next vesrion.

Regards,
Saurabh

> 
> Michael
> 
> 
> 
> > 
> > 
> > Regards,
> > Saurabh
> > 
> > >
> > > Michael
