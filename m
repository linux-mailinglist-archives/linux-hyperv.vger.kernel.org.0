Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD42784004
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjHVLtU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjHVLtS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 07:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336FBCFC;
        Tue, 22 Aug 2023 04:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55970648DB;
        Tue, 22 Aug 2023 11:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7AFC433C8;
        Tue, 22 Aug 2023 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692704886;
        bh=M+R+3pWKXJqUrPOyQ4zKrKqSO3DUrA/AmLMHVhlP3nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bjt8CupKmCYOjx7EYwRS8Rg0MHxXvf8Ogp7gd8WgjA16Iz3PGveIbCbZJ/HRZDajJ
         6sSv89VdTjgbVV1suOhrA/eIjoCBbtlbi/J4ixXRG3CfRYOtSUiRUmxA+PJpY8UKNf
         PYnPXg39d1Vi8AnWvd0A8BEHVaJ2dS2OYaytH4UQ=
Date:   Tue, 22 Aug 2023 13:48:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V
 devices
Message-ID: <2023082246-lumping-rebate-4142@gregkh>
References: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
 <2023081215-canine-fragile-0a69@gregkh>
 <PUZP153MB06350DAEA2384B996519E07EBE1EA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZP153MB06350DAEA2384B996519E07EBE1EA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 21, 2023 at 07:36:18AM +0000, Saurabh Singh Sengar wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Saturday, August 12, 2023 4:45 PM
> > To: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> > corbet@lwn.net; linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > linux-doc@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V
> > devices
> > 
> > On Fri, Aug 04, 2023 at 12:09:53AM -0700, Saurabh Sengar wrote:
> > > Hyper-V is adding multiple low speed "speciality" synthetic devices.
> > > Instead of writing a new kernel-level VMBus driver for each device,
> > > make the devices accessible to user space through a UIO-based
> > > hv_vmbus_client driver. Each device can then be supported by a user
> > > space driver. This approach optimizes the development process and
> > > provides flexibility to user space applications to control the key
> > > interactions with the VMBus ring buffer.
> > 
> > Why is it faster to write userspace drivers here?  Where are those new drivers,
> > and why can't they be proper kernel drivers?  Are all hyper-v drivers going to
> > move to userspace now?
> 
> Hi Greg,
> 
> You are correct; it isn't faster. However, the developers working on these userspace
> drivers can concentrate entirely on the business logic of these devices. The more
> intricate aspects of the kernel, such as interrupt management and host communication,
> can be encapsulated within the uio driver.

Yes, kernel drivers are hard, we all know that.

But if you do it right, it doesn't have to be, saying "it's too hard for
our programmers to write good code for our platform" isn't exactly a
good endorcement of either your programmers, or your platform :)

> The quantity of Hyper-V devices is substantial, and their numbers are consistently
> increasing. Presently, all of these drivers are in a development/planning phase and
> rely significantly on the acceptance of this UIO driver as a prerequisite.

Don't make my acceptance of something that you haven't submitted before
a business decision that I need to make, that's disenginous.

> Not all hyper-v drivers will move to userspace, but many a new slow Hyperv-V
> devices will use this framework and will avoid introducing a new kernel driver. We
> will also plan to remove some of the existing drivers like kvp/vss.

Define "slow" please.

> > > The new synthetic devices are low speed devices that don't support
> > > VMBus monitor bits, and so they must use vmbus_setevent() to notify
> > > the host of ring buffer updates. The new driver provides this
> > > functionality along with a configurable ring buffer size.
> > >
> > > Moreover, this series of patches incorporates an update to the fcopy
> > > application, enabling it to seamlessly utilize the new interface. The
> > > older fcopy driver and application will be phased out gradually.
> > > Development of other similar userspace drivers is still underway.
> > >
> > > Moreover, this patch series adds a new implementation of the fcopy
> > > application that uses the new UIO driver. The older fcopy driver and
> > > application will be phased out gradually. Development of other similar
> > > userspace drivers is still underway.
> > 
> > You are adding a new user api with the "ring buffer" size api, which is odd for
> > normal UIO drivers as that's not something that UIO was designed for.
> > 
> > Why not just make you own generic type uiofs type kernel api if you really
> > want to do all of this type of thing in userspace instead of in the kernel?
> 
> Could you please elaborate more on this suggestion. I couldn't understand it
> completely.

Why is uio the requirement here?  Why not make your own framework to
write hv drivers in userspace that fits in better with the overall goal?
Call it "hvfs" or something like that, much like we have usbfs for
writing usb drivers in userspace.

Bolting on HV drivers to UIO seems very odd as that is not what this
framework is supposed to be providing at all.  UIO was to enable "pass
through" memory-mapped drivers that only wanted an interrupt and access
to raw memory locations in the hardware.

Now you are adding ring buffer managment and all other sorts of things
just for your platform.  So make it a real subsystem tuned exactly for
what you need and NOT try to force it into the UIO interface (which
should know nothing about ring buffers...)

> > And finally, if this is going to replace the fcopy driver, then it should be part of
> > this series as well, removing it to show that you really mean it when you say it
> > will be deleted, otherwise we all know that will never happen.
> 
> I was hesitant about disrupting the backward compatibility, but I suppose I could
> rename the new fcopy daemon to match the old one.

If you can't drop the driver today due to backwards compatibility, then
you will not be able to drop it in the future either.

Please work to come up with a sane framework if you are going to insist
on writing drivers in userspace for your platform, that works well and
it not bolted onto the UIO api.  Consider this a chance to fix the
issues that the UIO api currently has that we can't change due to
compatiblity reasons :)

thanks,

greg k-h
