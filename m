Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E368A075
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Feb 2023 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjBCRhG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Feb 2023 12:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjBCRg6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Feb 2023 12:36:58 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED276A7791;
        Fri,  3 Feb 2023 09:36:37 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id D159620B9D4D; Fri,  3 Feb 2023 09:36:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D159620B9D4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675445776;
        bh=I186YXZBNTwbb+x2CGlrvHeiFrnugfFalBVK34vPTtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l46ORs0hXJZU0c9gbLIiFwdzFA4vrKUzsSETy135ijchV7lAtH/ahcokRR7l7FzYb
         GV4eZLt8uT33rPwJWA5qIJAvfhKQAyCvoPONYr1gnO/8dXIp5bhXUccgpgm2KWf97v
         uP2mohocfcDTg5Voy6vhxVRmaDqn92gAI8QYWN64=
Date:   Fri, 3 Feb 2023 09:36:16 -0800
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
Message-ID: <20230203173616.GA8582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
 <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201174638.GA3872117-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> > > > Update the driver to support device tree boot as well along with ACPI.
> > > > At present the device tree parsing only provides the mmio region info
> > > > and is not the exact copy of ACPI parsing. This is sufficient to cater
> > > > all the current device tree usecases for VMBus.
> > > >
> > > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > ---
> > > >  drivers/hv/vmbus_drv.c | 75 ++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 73 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > > index 49030e756b9f..1741f1348f9f 100644
> > > > --- a/drivers/hv/vmbus_drv.c
> > > > +++ b/drivers/hv/vmbus_drv.c
> > > > @@ -2152,7 +2152,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> > > >         device_unregister(&device_obj->device);
> > > >  }
(...)
> > > >         struct pci_dev *pdev;
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
>

I tried removing #ifdef CONFIG_ACPI and use C's if(!IS_ENABLED(CONFIG_ACPI)) but looks
compiler is not optimizing out the rest of function, it still throwing errors
for acpi functions. This doesn't look 1:1 replacement to me.
Please let me know if I have missunderstood any of your suggestion.

drivers/hv/vmbus_drv.c:2175:8: error: implicit declaration of function ‘acpi_dev_resource_interrupt’ [-Werror=implicit-function-
> > 
> > > 
> > > >  static int vmbus_acpi_add(struct platform_device *pdev)
> > > >  {
> > > >         acpi_status result;
> > > > @@ -2496,10 +2498,68 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> 
> [1] https://lwn.net/Articles/443531/
