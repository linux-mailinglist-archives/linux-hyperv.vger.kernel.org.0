Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0B602499
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Oct 2022 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJRGkH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 02:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRGkG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 02:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEE895D4;
        Mon, 17 Oct 2022 23:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8A0861467;
        Tue, 18 Oct 2022 06:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A898C433C1;
        Tue, 18 Oct 2022 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666075203;
        bh=wYl2NOWLFpKyeJIP7HY0aSHHpiLhhDASuVT5WZN2kNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqqs7BJ+wXMo5Jlqva46S6bG6VAQnOt3IgJxjrgwb9kxfvrmGzc1k5g/XTqzU5/ZB
         yhqCrU9/5qtVJd9DfCHdsyiV2wXkrPgKotd5m6skOyv27Yh7OQ8TEaqs75eS2/axoN
         8K8LhgzL9mcOGXuqWsB9/8gCslZ1HO8icR6+zOH8=
Date:   Tue, 18 Oct 2022 08:40:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Message-ID: <Y05KQFQUR5Is3RuC@kroah.com>
References: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0kRIcXG+wNbcGx0@kroah.com>
 <PH7PR21MB32633D172133A769357BD97ECE289@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB32633D172133A769357BD97ECE289@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 18, 2022 at 06:31:16AM +0000, Long Li wrote:
> > Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
> > devices
> > 
> > On Thu, Oct 13, 2022 at 11:29:14AM -0700, Saurabh Sengar wrote:
> > > Hyper-V is adding some "specialty" synthetic devices.
> > 
> > What devices are those specifically?
> > 
> > > Instead of writing new kernel-level VMBus drivers for these devices,
> > > the devices will be presented to user space via this existing Hyper-V
> > > generic UIO driver, so that a user space driver can handle the device.
> > > Since these new synthetic devices are low speed devices, they don't
> > > support monitor bits and we must use vmbus_setevent() to enable
> > > interrupts from the host.
> > 
> > That is not what the UIO interface is for.  Please write real drivers so that
> > they tie into the specific user/kernel apis for those device types.
> > 
> > Without a specific list of what these devices are, I can not recommend that
> > anyone use the UIO api for them as that's probably not a good idea.
> 
> There are some VMBUS drivers currently not implemented in Linux. Out of all
> VMBUS drivers, two use "monitored bits": they are network and storage drivers.
> All the rest VMBUS drivers use hypercall for host notification and signal for next
> interrupt. One example of such driver is to collect process level crash information
> for diagnostic purposes.
> 
> Also, we want to move some existing kernel mode VMBUS drivers to user-space,
> such as hv_kvp and hv_filecopy. They don't really fit into an existing kernel API, and
> they create their own devices under /dev and communicates with a user-mode
> daemon to do most of the work. It's a better model that we can move those drivers
> entirely into user-mode.

How are you going to be able to remove drivers that export an existing
user/kernel api and not break current systems?

> > Also, if you do do this, you need to list where the source for that userspace
> > code is so that users can get it and have their distros package it up for them.  I
> > do not see that here at all.
> > 
> > 
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/uio/uio_hv_generic.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/uio/uio_hv_generic.c
> > > b/drivers/uio/uio_hv_generic.c index c08a6cfd119f..8e5aa4a1247f 100644
> > > --- a/drivers/uio/uio_hv_generic.c
> > > +++ b/drivers/uio/uio_hv_generic.c
> > > @@ -84,6 +84,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
> > >  	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
> > >  	virt_mb();
> > >
> > > +	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> > > +		vmbus_setevent(dev->channel);
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -239,12 +242,6 @@ hv_uio_probe(struct hv_device *dev,
> > >  	void *ring_buffer;
> > >  	int ret;
> > >
> > > -	/* Communicating with host has to be via shared memory not
> > hypercall */
> > > -	if (!channel->offermsg.monitor_allocated) {
> > > -		dev_err(&dev->device, "vmbus channel requires
> > hypercall\n");
> > 
> > I do not understand, why is this check not made anymore here?  Why
> > constantly make the call above in the irq handler instead?  Isn't that going to
> > be massively slow?
> 
> Some VMBUS devices exposed by the Hyper-V are not modeled as high speed, 
> they use hypercall, not monitored bits. Because they don't fit into other kernel
> API (as explained above), can we use UIO for those devices?

UIO is for mmaped memory regions, like PCI devices, how is this a valid
Hyper-V api at all?

confused,

greg k-h
