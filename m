Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5974CBEC9
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 14:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiCCNXY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Mar 2022 08:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiCCNXX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Mar 2022 08:23:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A54C34BBA;
        Thu,  3 Mar 2022 05:22:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32460B8246E;
        Thu,  3 Mar 2022 13:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACC0C340ED;
        Thu,  3 Mar 2022 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646313754;
        bh=WA+6m6yzwvFz/6tJbyG3UMbdVTSlsfS1c83kcIEFxWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pyf8b66awp9tbUHuOQVCaZJZ7TWxejy6MOWy8/1EDACDVYuzmng785Pltu4FO0wVf
         zhSV6XGjpf0yNymkNk70LSl/LmsF4AYHWIam6SAZk7729mFhZ5jGwf3uE65/AnFkIV
         BW4/z8ZhxBQkDvUKTx+QJ1x3ALjtR3zZFkjzBE88=
Date:   Thu, 3 Mar 2022 14:22:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <YiDBGFJcQXfx/hwG@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
 <c848ade1-48e4-1868-b890-9c3401cff9de@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c848ade1-48e4-1868-b890-9c3401cff9de@linux.microsoft.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 05:09:21PM -0800, Iouri Tarassov wrote:
> 
> On 3/1/2022 11:53 PM, Greg KH wrote:
> > On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > > > +struct dxgglobal *dxgglobal;
> > > > 
> > > > No, make this per-device, NEVER have a single device for your driver.
> > > > The Linux driver model makes it harder to do it this way than to do it
> > > > correctly.  Do it correctly please and have no global structures like
> > > > this.
> > > > 
> > > 
> > > This may not be as big an issue as you thought. The device discovery is
> > > still done via the normal VMBus probing routine. For all intents and
> > > purposes the dxgglobal structure can be broken down into per device
> > > fields and a global structure which contains the protocol versioning
> > > information -- my understanding is there will always be a global
> > > structure to hold information related to the backend, regardless of how
> > > many devices there are.
> >
> > Then that is wrong and needs to be fixed.  Drivers should almost never
> > have any global data, that is not how Linux drivers work.  What happens
> > when you get a second device in your system for this?  Major rework
> > would have to happen and the code will break.  Handle that all now as it
> > takes less work to make this per-device than it does to have a global
> > variable.
> >
> > > I definitely think splitting is doable, but I also understand why Iouri
> > > does not want to do it _now_ given there is no such a model for multiple
> > > devices yet, so anything we put into the per-device structure could be
> > > incomplete and it requires further changing when such a model arrives
> > > later.
> > > 
> > > Iouri, please correct me if I have the wrong mental model here.
> > > 
> > > All in all, I hope this is not going to be a deal breaker for the
> > > acceptance of this driver.
> >
> > For my reviews, yes it will be.
> >
> > Again, it should be easier to keep things in a per-device state than
> > not as the proper lifetime rules and the like are automatically handled
> > for you.  If you have global data, you have to manage that all on your
> > own and it is _MUCH_ harder to review that you got it correct.
> 
> Hi Greg,
> 
> I do not really see how the driver be written without the global data. Let's review the design.

I see it the other way around.  It's easier to make it without a static
structure, it is more work to keep it as you have done so here.  Do it
correctly to start with and you will not have any of these issues going
forward.

> Dxgkrnl acts as the aggregator of all virtual compute devices, projected by the host. It needs to do operations, which do not belong to a particular compute device. For example, cross device synchronization and resource sharing.

Then hang your data off of your device node structure that you created.
Why ignore that?

> A PCI device device is created for each virtual compute device. Therefore, there should be a global list of objects and a mutex to synchronize access to the list.

Woah, what?  You create a fake PCI device for each virtual device?  If
so, great, then you are now a PCI bus and create the PCI devices
properly so that the PCI core can handle and manage them and then assign
them to your driver.  You should NEVER have a global list of these
devices, as that is what the driver model should be managing.  Not you!

> A VMBus channel is offered by the host for each compute device. The list of the VMBus channels should be global.

The vmbus channels are already handled by the driver core.  Use those
devices that are given to you.  You don't need to manage them at all.

> A global VMBus channel is offered by the host. The channel does not belong to any particular compute device, so it must be global.

That channel is attached to your driver, use the device given to your
driver by the bus.  It's not "global" in any sense of the word.

And what's up with your lack of line wrapping?

> IO space is shared by all compute devices, so its parameters should be global.

Huh?  If that's the case then you have bigger problems.  Use the aux bus
for devices that share io space.  That is what it was created for, do
not ignore the functionality that Linux already provides you by trying
to go around it and writing your own code.  Use the frameworks we have
already debugged and support.  This is why your Linux driver should be
at least 1/3 smaller than drivers for other operating systems.

> Dxgkrnl needs to maintain a list of processes, which opened compute device objects. Dxgkrnl maintains private state for each process and when a process opens the /dev/dxg device, Dxgkrnl needs to find if the process state is already created by walking the global process list.

That "list" is handled by the device node structure that was opened.
It's not "global" at all.  Again, just like any other device node in
Linux, this isn't a new thing or anything special at all.

> Now, where to keep this global state? It could be kept in the /dev/dxg private device structure. But this structure is not available when, for example, dxg_pci_probe_device() or dxg_probe_vmbus() is called.

Then your design is wrong.  It's as simple as that.  Fix it.

> Can there be multiple /dev/dxg devices? No. Because the /dev/dxg device represents the driver itself, not a particular compute device.

Then fix this.  Make your compute devices store the needed information
when they are created.  Again, we have loads of examples in the kernel,
this is nothing new.

> I am not sure what design model you have in mind when saying there should be no global data. Could you please explain keeping in mind the above requirements?

Please see all of my responses above, and please use more \n characters
in the future :)

good luck!

greg k-h
