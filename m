Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A796024F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Oct 2022 09:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJRHFK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 03:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJRHFB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 03:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E85C341;
        Tue, 18 Oct 2022 00:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95DB561488;
        Tue, 18 Oct 2022 07:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9233C433C1;
        Tue, 18 Oct 2022 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666076699;
        bh=iGNsRA8td5VnSldmVTeh32Adr/l+fdhF5KrC+Q6jKpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/gIVIjx55gOOrC5O6DF4M/L2SFRXc9NHokBzVG90UlKOJNOkQa1ClHrhfm4hX0K1
         WH7nmxfW5RJk6WbZKcIZN9s+LqvrfUUEy1A1CIVbMtiUDJZFZBVPzDQrhJmJbh8m0/
         CMmW4IHShI2Uh7Dr0XnTakpl5VvOUdjxMZVq9ErA=
Date:   Tue, 18 Oct 2022 09:04:56 +0200
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
Message-ID: <Y05QGBml/sj0ZFAG@kroah.com>
References: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0kRIcXG+wNbcGx0@kroah.com>
 <PH7PR21MB32633D172133A769357BD97ECE289@PH7PR21MB3263.namprd21.prod.outlook.com>
 <Y05KQFQUR5Is3RuC@kroah.com>
 <PH7PR21MB3263ECBE949C7F0858075F3FCE289@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263ECBE949C7F0858075F3FCE289@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 18, 2022 at 06:57:33AM +0000, Long Li wrote:
> > Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
> > devices
> > 
> > On Tue, Oct 18, 2022 at 06:31:16AM +0000, Long Li wrote:
> > > > Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed
> > > > VMBus devices
> > > >
> > > > On Thu, Oct 13, 2022 at 11:29:14AM -0700, Saurabh Sengar wrote:
> > > > > Hyper-V is adding some "specialty" synthetic devices.
> > > >
> > > > What devices are those specifically?
> > > >
> > > > > Instead of writing new kernel-level VMBus drivers for these
> > > > > devices, the devices will be presented to user space via this
> > > > > existing Hyper-V generic UIO driver, so that a user space driver can
> > handle the device.
> > > > > Since these new synthetic devices are low speed devices, they
> > > > > don't support monitor bits and we must use vmbus_setevent() to
> > > > > enable interrupts from the host.
> > > >
> > > > That is not what the UIO interface is for.  Please write real
> > > > drivers so that they tie into the specific user/kernel apis for those device
> > types.
> > > >
> > > > Without a specific list of what these devices are, I can not
> > > > recommend that anyone use the UIO api for them as that's probably not
> > a good idea.
> > >
> > > There are some VMBUS drivers currently not implemented in Linux. Out
> > > of all VMBUS drivers, two use "monitored bits": they are network and
> > storage drivers.
> > > All the rest VMBUS drivers use hypercall for host notification and
> > > signal for next interrupt. One example of such driver is to collect
> > > process level crash information for diagnostic purposes.
> > >
> > > Also, we want to move some existing kernel mode VMBUS drivers to
> > > user-space, such as hv_kvp and hv_filecopy. They don't really fit into
> > > an existing kernel API, and they create their own devices under /dev
> > > and communicates with a user-mode daemon to do most of the work. It's
> > > a better model that we can move those drivers entirely into user-mode.
> > 
> > How are you going to be able to remove drivers that export an existing
> > user/kernel api and not break current systems?
> 
> It will be some configuration challenges, but it's doable.

How exactly?

We can not break userspace when you upgrade a kernel version.

> Newer Linux
> VMs can be configured in a way to use the UIO interfaces. This doesn't break
> any existing VMs because the old model will continue to work when UIO is not
> used. Also, this doesn't require any Hyper-V changes.

Hyper-v changes are not the issue here :)

Again, you have to support the situation where a system upgrades to a
new kernel and all the same functionality must be there.  How will you
do that if you remove drivers from a newer kernel?

> > UIO is for mmaped memory regions, like PCI devices, how is this a valid
> > Hyper-V api at all?
> 
> Currently uio_hv_generic is used to mmap VMBUS ring buffers to user-mode.
> The primary use case is for DPDK. However, the same mmap model can be
> used for all other VMBUS devices, as they all use the same ring buffers model.

Ok, that feels like overkill...

You need to also post the source for these new userspace drivers
somewhere for us to review.  I don't see a link to them in the changelog
text :(

thanks,

greg k-h
