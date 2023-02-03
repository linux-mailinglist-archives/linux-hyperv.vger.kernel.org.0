Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E2688EFC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Feb 2023 06:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBCFc1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Feb 2023 00:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBCFc0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Feb 2023 00:32:26 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D999E2B2A4;
        Thu,  2 Feb 2023 21:32:24 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 70BB520B74F9; Thu,  2 Feb 2023 21:32:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70BB520B74F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675402344;
        bh=h5wQJLQB/g7tGVzdSJdGiPKml6oH5lii4nP9Bv8SEwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNqGozZuOBaTlji6yI7ghbU0m0TAKQs3uR1R6F/nJXJJoBW7HIOyX/soIZHsacUBd
         gr90Ej4dcChkUBiihY4iyJS3AFuANNncjENkvxLspiUa3aSDcSBG/i7CuTh18e94YV
         kbrCTpxjPyag7ahkgG5OzA9/ekaOt7j6OPywLqH0=
Date:   Thu, 2 Feb 2023 21:32:24 -0800
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
Subject: Re: [PATCH v2 3/6] Drivers: hv: vmbus: Convert acpi_device to
 platform_device
Message-ID: <20230203053224.GA1834@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-4-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688C6978F68D904ABC00911D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688C6978F68D904ABC00911D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
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

On Wed, Feb 01, 2023 at 06:32:29PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, January 31, 2023 10:10 AM
> > 
> > Use more generic platform device instead of acpi device. Also rename the
> > function vmbus_acpi_remove to more generic name vmbus_mmio_remove.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 78 +++++++++++++++++++++++++-----------------
> >  1 file changed, 46 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index d24dd65b33d4..49030e756b9f 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/device.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/sysctl.h>
> >  #include <linux/slab.h>
> > @@ -44,7 +45,7 @@ struct vmbus_dynid {
> >  	struct hv_vmbus_device_id id;
> >  };
> > 
> > -static struct acpi_device  *hv_acpi_dev;
> > +static struct platform_device  *hv_dev;
> > 
> >  static int hyperv_cpuhp_online;
> > 
> > @@ -143,7 +144,7 @@ static DEFINE_MUTEX(hyperv_mmio_lock);
> > 
> >  static int vmbus_exists(void)
> >  {
> > -	if (hv_acpi_dev == NULL)
> > +	if (hv_dev == NULL)
> >  		return -ENODEV;
> > 
> >  	return 0;
> > @@ -932,7 +933,7 @@ static int vmbus_dma_configure(struct device *child_device)
> >  	 * On x86/x64 coherence is assumed and these calls have no effect.
> >  	 */
> >  	hv_setup_dma_ops(child_device,
> > -		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
> > +		device_get_dma_attr(&hv_dev->dev) == DEV_DMA_COHERENT);
> >  	return 0;
> >  }
> > 
> > @@ -2090,7 +2091,7 @@ int vmbus_device_register(struct hv_device
> > *child_device_obj)
> >  		     &child_device_obj->channel->offermsg.offer.if_instance);
> > 
> >  	child_device_obj->device.bus = &hv_bus;
> > -	child_device_obj->device.parent = &hv_acpi_dev->dev;
> > +	child_device_obj->device.parent = &hv_dev->dev;
> >  	child_device_obj->device.release = vmbus_device_release;
> > 
> >  	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> > @@ -2262,7 +2263,7 @@ static acpi_status vmbus_walk_resources(struct
> > acpi_resource *res, void *ctx)
> >  	return AE_OK;
> >  }
> > 
> > -static void vmbus_acpi_remove(struct acpi_device *device)
> > +static void vmbus_mmio_remove(void)
> >  {
> >  	struct resource *cur_res;
> >  	struct resource *next_res;
> > @@ -2441,13 +2442,15 @@ void vmbus_free_mmio(resource_size_t start,
> > resource_size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> > 
> > -static int vmbus_acpi_add(struct acpi_device *device)
> > +static int vmbus_acpi_add(struct platform_device *pdev)
> >  {
> >  	acpi_status result;
> >  	int ret_val = -ENODEV;
> > -	struct acpi_device *ancestor;
> > +	struct platform_device *ancestor;
> > +	struct acpi_device *adev = to_acpi_device(&pdev->dev);
> 
> This doesn't work.  The argument to vmbus_acpi_add() is a struct
> platform_device, which has a struct device embedded in it (not a
> pointer).   to_acpi_device() takes a struct device as an argument,
> assuming that the struct device is embedded in a struct
> acpi_device, which is not the case here.  The resulting local
> variable adev is actually pointing to some (perhaps negative)
> offset within the struct platform_device, and uses of adev are
> getting unknown random data from within (or before) the
> struct platform_device.

Please discard my earlier reply on this. I will fix it in V3.
Thanks for pointing this.

> 
> > 
> > -	hv_acpi_dev = device;
> > +	hv_dev = pdev;
> > +	adev->fwnode.dev = &pdev->dev;
> > 
> >  	/*
> >  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> > @@ -2456,15 +2459,16 @@ static int vmbus_acpi_add(struct acpi_device *device)
> >  	 * up the ACPI device to behave as if _CCA is present and indicates
> >  	 * hardware coherence.
> >  	 */
> > -	ACPI_COMPANION_SET(&device->dev, device);
> > +	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pdev->dev));
> 
> This statement seems tautological.  If ACPI_COMPANION(&pdev->dev)
> returns a valid result,  why would the ACPI companion for &pdev->dev
> need to be set?  The original code was setting the ACPI companion for the
> embedded struct device to be the struct acpi_device.   I forget why this
> wasn't already done for the VMBus device when it was originally parsed
> from the ACPI DSDT ... 

This need to be changed to:
ACPI_COMPANION_SET(&adev_node->dev, adev_node)
will fix this as well.

> 
> >  	if (IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) &&
> > -	    device_get_dma_attr(&device->dev) == DEV_DMA_NOT_SUPPORTED) {
> > +	    device_get_dma_attr(&pdev->dev) == DEV_DMA_NOT_SUPPORTED) {
> > +		struct acpi_device *adev_node = ACPI_COMPANION(&pdev->dev);
> 
> If earlier code in this function can get a correct pointer to the struct acpi_device,
> then this statement shouldn't be necessary.  You already have it.

agree, will fix

> 
> >  		pr_info("No ACPI _CCA found; assuming coherent device I/O\n");
> > -		device->flags.cca_seen = true;
> > -		device->flags.coherent_dma = true;
> > +		adev_node->flags.cca_seen = true;
> > +		adev_node->flags.coherent_dma = true;
> >  	}
> > 
> > -	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> > +	result = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), METHOD_NAME__CRS,
> 
> Again, if you have a correct pointer to the struct acpi_device, then adev->handle
> (like the original code) should be simpler than looking it up again with ACPI_HANDLE().  

OK

> 
> >  					vmbus_walk_resources, NULL);
> > 
> >  	if (ACPI_FAILURE(result))
> > @@ -2473,9 +2477,9 @@ static int vmbus_acpi_add(struct acpi_device *device)
> >  	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
> >  	 * firmware) is the VMOD that has the mmio ranges. Get that.
> >  	 */
> > -	for (ancestor = acpi_dev_parent(device); ancestor;
> > -	     ancestor = acpi_dev_parent(ancestor)) {
> > -		result = acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
> > +	for (ancestor = to_platform_device(pdev->dev.parent); ancestor;
> > +	     ancestor = to_platform_device(ancestor->dev.parent)) {
> > +		result = acpi_walk_resources(ACPI_HANDLE(&ancestor->dev), METHOD_NAME__CRS,
> 
> Similarly, if you get a correct pointer to the struct acpi_device, does the above
> code need any changes?  I'm hoping not.

Will try to clean this up as well.

Regards,
Saurabh

> 
> >  					     vmbus_walk_resources, NULL);
> > 
> >  		if (ACPI_FAILURE(result))
> > @@ -2489,10 +2493,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
> > 
> >  acpi_walk_err:
> >  	if (ret_val)
> > -		vmbus_acpi_remove(device);
> > +		vmbus_mmio_remove();
> >  	return ret_val;
> >  }
> > 
> > +static int vmbus_platform_driver_probe(struct platform_device *pdev)
> > +{
> > +	return vmbus_acpi_add(pdev);
> > +}
> > +
> > +static int vmbus_platform_driver_remove(struct platform_device *pdev)
> > +{
> > +	vmbus_mmio_remove();
> > +	return 0;
> > +}
> > +
> >  #ifdef CONFIG_PM_SLEEP
> >  static int vmbus_bus_suspend(struct device *dev)
> >  {
> > @@ -2658,15 +2673,15 @@ static const struct dev_pm_ops vmbus_bus_pm = {
> >  	.restore_noirq	= vmbus_bus_resume
> >  };
> > 
> > -static struct acpi_driver vmbus_acpi_driver = {
> > -	.name = "vmbus",
> > -	.ids = vmbus_acpi_device_ids,
> > -	.ops = {
> > -		.add = vmbus_acpi_add,
> > -		.remove = vmbus_acpi_remove,
> > -	},
> > -	.drv.pm = &vmbus_bus_pm,
> > -	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
> > +static struct platform_driver vmbus_platform_driver = {
> > +	.probe = vmbus_platform_driver_probe,
> > +	.remove = vmbus_platform_driver_remove,
> > +	.driver = {
> > +		.name = "vmbus",
> > +		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> > +		.pm = &vmbus_bus_pm,
> > +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> > +	}
> >  };
> > 
> >  static void hv_kexec_handler(void)
> > @@ -2750,12 +2765,11 @@ static int __init hv_acpi_init(void)
> >  	/*
> >  	 * Get ACPI resources first.
> >  	 */
> > -	ret = acpi_bus_register_driver(&vmbus_acpi_driver);
> > -
> > +	ret = platform_driver_register(&vmbus_platform_driver);
> >  	if (ret)
> >  		return ret;
> > 
> > -	if (!hv_acpi_dev) {
> > +	if (!hv_dev) {
> >  		ret = -ENODEV;
> >  		goto cleanup;
> >  	}
> > @@ -2785,8 +2799,8 @@ static int __init hv_acpi_init(void)
> >  	return 0;
> > 
> >  cleanup:
> > -	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> > -	hv_acpi_dev = NULL;
> > +	platform_driver_unregister(&vmbus_platform_driver);
> > +	hv_dev = NULL;
> >  	return ret;
> >  }
> > 
> > @@ -2839,7 +2853,7 @@ static void __exit vmbus_exit(void)
> > 
> >  	cpuhp_remove_state(hyperv_cpuhp_online);
> >  	hv_synic_free();
> > -	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> > +	platform_driver_unregister(&vmbus_platform_driver);
> >  }
> > 
> > 
> > --
> > 2.25.1
