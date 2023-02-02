Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A8688079
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Feb 2023 15:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBBOuH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Feb 2023 09:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjBBOtu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Feb 2023 09:49:50 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2E3918A6;
        Thu,  2 Feb 2023 06:48:54 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id B0F6620B7102; Thu,  2 Feb 2023 06:48:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0F6620B7102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675349323;
        bh=gjpf4tmCpJspm7R09KDz9PoxVO973A9P+dcFaqNYhig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWqOL1KUEIVforAPnG/YSYfnmeUMryD+fqy9Q57F9tkXrRfSx+Su5JWbomxYbdmcy
         CKlZgQMTBWuYSM6yg4YfewcXLiImUqk3mpjdV3RVFN3XM8db2cWP4TA0JudUTRBReR
         vxr9HDphRSm4fwZx3TBOPdSrQ7wJibPkxCfXfXao=
Date:   Thu, 2 Feb 2023 06:48:43 -0800
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
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH v2 2/6] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Message-ID: <20230202144843.GA11173@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-3-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688813B65EEDB79554E30D4D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688813B65EEDB79554E30D4D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On Wed, Feb 01, 2023 at 05:47:44PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, January 31, 2023 10:10 AM
> > 
> > acpi_sleep_state_supported API is only define for CONFIG_ACPI flag and
> > thus it can't be used for non-ACPI builds. Initaly there won't be
> 
> s/Initaly/Initially/

OK

> 
> > hibernate support for non ACPI builds.
> 
> s/hibernate/hibernation/

OK

> 
> > 
> > This change will help adding device tree support in subsequent commits.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 52a6f89ccdbd..370ec20d1993 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -234,7 +234,11 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
> > 
> >  bool hv_is_hibernation_supported(void)
> >  {
> > +#ifdef CONFIG_ACPI
> >  	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
> > +#else
> > +	return false;
> > +#endif
> 
> Is this patch needed?  If CONFIG_ACPI is not set, then per
> arch/x86/Kconfig, CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
> is not selected.  In that case, the #ifdef in include/acpi/acpi_bus.h
> provides a stub for acpi_sleep_state_supported() that returns "false".
> So it seems like the existing code should compile and correctly return
> "false" when CONFIG_ACPI is not set.

You are right, if CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT is not set
acpi_sleep_state_supported will return false, but this is applicable only
when CONFIG_ACPI is enable. If CONFIG_ACPI is not enable both these
functions are not defined.

Regards,
Saurabh


> 
> Michael
> 
> >  }
> >  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> > 
> > --
> > 2.25.1
