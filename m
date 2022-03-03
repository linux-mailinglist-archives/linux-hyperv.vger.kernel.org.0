Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5E4CBEA9
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiCCNRV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Mar 2022 08:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiCCNRU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Mar 2022 08:17:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6D186BBB;
        Thu,  3 Mar 2022 05:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF115B82541;
        Thu,  3 Mar 2022 13:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76ADC004E1;
        Thu,  3 Mar 2022 13:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646313366;
        bh=UaYaEq+pX/N3FkTVSSi0NSINkxW2/wj3aygGq0naqdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxPFm9Gbp/VMWnlo+La5qqdWFdPTBBvGyZVtnhF4vF3D66Q3Q2JrO4nA6t76l3qyl
         ttqUonv074fY1l+GJ5piObSJmFOzVyn/JKp+oxTi6BXoRfNz4AC7FEkPH8HFm7vqJS
         NEq//pdy0Fa6m/3YcD70oeClS44vyEnBrhBdh5iI=
Date:   Thu, 3 Mar 2022 14:16:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <YiC/k1pKTUV12APe@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
 <20220302115334.wemdkznokszlzcpe@liuwe-devbox-debian-v2>
 <6ac1dd87-3c78-66ca-c526-d1f6cf253400@linux.microsoft.com>
 <Yh/Rq9PwWZAN8Mu2@kroah.com>
 <78df3646-4df6-5e2b-2f6e-e14824b08d85@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78df3646-4df6-5e2b-2f6e-e14824b08d85@linux.microsoft.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 02:27:05PM -0800, Iouri Tarassov wrote:
> 
> On 3/2/2022 12:20 PM, Greg KH wrote:
> > On Wed, Mar 02, 2022 at 10:49:15AM -0800, Iouri Tarassov wrote:
> > > On 3/2/2022 3:53 AM, Wei Liu wrote:
> > > > On Wed, Mar 02, 2022 at 08:53:15AM +0100, Greg KH wrote:
> > > > > On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > > > > > > +struct dxgglobal *dxgglobal;
> > > > > > > 
> > > > > > > No, make this per-device, NEVER have a single device for your driver.
> > > > > > > The Linux driver model makes it harder to do it this way than to do it
> > > > > > > correctly.  Do it correctly please and have no global structures like
> > > > > > > this.
> > > > > > > 
> > > > > > 
> > > > > > This may not be as big an issue as you thought. The device discovery is
> > > > > > still done via the normal VMBus probing routine. For all intents and
> > > > > > purposes the dxgglobal structure can be broken down into per device
> > > > > > fields and a global structure which contains the protocol versioning
> > > > > > information -- my understanding is there will always be a global
> > > > > > structure to hold information related to the backend, regardless of how
> > > > > > many devices there are.
> > > > > 
> > > > > Then that is wrong and needs to be fixed.  Drivers should almost never
> > > > > have any global data, that is not how Linux drivers work.  What happens
> > > > > when you get a second device in your system for this?  Major rework
> > > > > would have to happen and the code will break.  Handle that all now as it
> > > > > takes less work to make this per-device than it does to have a global
> > > > > variable.
> > > > > 
> > > >
> > > > It is perhaps easier to draw parallel from an existing driver. I feel
> > > > like we're talking past each other.
> > > >
> > > > Let's look at drivers/iommu/intel/iommu.c. There are a bunch of lists
> > > > like `static LIST_HEAD(dmar_rmrr_units)`. During the probing phase, new
> > > > units will be added to the list. I this the current code is following
> > > > this model. dxgglobal fulfills the role of a list.
> > > >
> > > > Setting aside the question of whether it makes sense to keep a copy of
> > > > the per-VM state in each device instance, I can see the code be changed
> > > > to:
> > > >
> > > >     struct mutex device_mutex; /* split out from dxgglobal */
> > > >     static LIST_HEAD(dxglist);
> > > >     
> > > >     /* Rename struct dxgglobal to struct dxgstate */
> > > >     struct dxgstate {
> > > >        struct list_head dxglist; /* link for dxglist */
> > > >        /* ... original fields sans device_mutex */
> > > >     }
> > > >
> > > >     /*
> > > >      * Provide a bunch of helpers manipulate the list. Called in probe /
> > > >      * remove etc.
> > > >      */
> > > >     struct dxgstate *find_dxgstate(...);
> > > >     void remove_dxgstate(...);
> > > >     int add_dxgstate(...);
> > > >
> > > > This model is well understood and used in tree. It is just that it
> > > > doesn't provide much value in doing this now since the list will only
> > > > contain one element. I hope that you're not saying we cannot even use a
> > > > per-module pointer to quickly get the data structure we want to use,
> > > > right?
> > > >
> > > > Are you suggesting Iouri use dev_set_drvdata to stash the dxgstate
> > > > into the device object? I think that can be done too.
> > > >
> > > > The code can be changed as:
> > > >
> > > >     /* Rename struct dxgglobal to dxgstate and remove unneeded fields */
> > > >     struct dxgstate { ... };
> > > >
> > > >     static int dxg_probe_vmbus(...) {
> > > >
> > > >         /* probe successfully */
> > > >
> > > > 	struct dxgstate *state = kmalloc(...);
> > > > 	/* Fill in dxgstate with information from backend */
> > > >
> > > > 	/* hdev->dev is the device object from the core driver framework */
> > > > 	dev_set_drvdata(&hdev->dev, state);
> > > >     }
> > > >
> > > >     static int dxg_remove_vmbus(...) {
> > > >         /* Normal stuff here ...*/
> > > >
> > > > 	struct dxgstate *state = dev_get_drvdata(...);
> > > > 	dev_set_drvdata(..., NULL);
> > > > 	kfree(state);
> > > >     }
> > > >
> > > >     /* In all other functions */
> > > >     void do_things(...) {
> > > >         struct dxgstate *state = dev_get_drvdata(...);
> > > >
> > > > 	/* Use state in place of where dxgglobal was needed */
> > > >
> > > >     }
> > > >
> > > > Iouri, notice this doesn't change anything regarding how userspace is
> > > > designed. This is about how kernel organises its data.
> > > >
> > > > I hope what I wrote above can bring our understanding closer.
> > > >
> > > > Thanks,
> > > > Wei.
> > > 
> > > 
> > > I can certainly remove dxgglobal and keep the  pointer to the global
> > > state in the device object.
> > > 
> > > This will require passing of the global pointer to all functions, which
> > > need to access it.
> > > 
> > > 
> > > Maybe my understanding of the Greg's suggestion was not correct. I
> > > thought the suggestion was
> > > 
> > > to have multiple /dev/dxgN devices (one per virtual compute device).
> >
> > You have one device per HV device, as the bus already provides you.
> > That's all you really need, right?  Who would be opening the same device
> > node multiple times?
> > > This would change how the user mode
> > > clients enumerate and communicate with compute devices.
> >
> > What does userspace have to do here?  It should just open the device
> > node that is present when needed.  How will there be multiple userspace
> > clients for a single HV device?
> 
> 
> Dxgkrnl creates a single user mode visible device node /dev/dxg.

When you do that, you have a device to put all of your data on.  Use
that.

> It has
> nothing to do with a specific hardware compute device on the host. Its
> purpose is to provide services (IOCTLs) to enumerate and manage virtual
> compute devices, which represent hardware devices on the host. The VMBus
> devices are not used directly by user mode clients in the current design.

That's horrid, why not just export the virtual compute devices properly
through individual device nodes instead?

In essence, you are creating a new syscall here to manage and handle
devices for just your driver with the use of this ioctl.  That's
generally a bad idea.

> Virtual compute devices are shared between processes. There could be a
> Cuda application, Gimp and a Direct3D12 application working at the same
> time.

Why are all of those applications sharing anything?  How are they
sharing anything?  If you need to share something across processes, use
the existing inter-process ways of sharing stuff that we have today (12+
different apis and counting).  Don't create yet-another-one just for
your tiny little driver here.  That's rude to the rest of the kernel.

> This is what I mean by saying that there are multiple user mode
> clients who use the /dev/dxg driver interface. Each of this applications
> will open the /dev/dxg device node and enumerate/use virtual compute
> devices.

That seems like an odd model to follow.  How many virtual devices do you
support?  Is there a limit?  Why not just enumerate them all to start
with?  Or if there are too many, why not do it like the raw device and
have a single device node that is used to create the virtual devices you
wish to use?

> If we change the way how the virtual compute devices are visible to user
> mode, the Cuda runtime, Direct3D runtime would need to be changed.

We do not care about existing userspace code at this point in time, you
are trying to get the kernel api correct here.  Once you have done that,
then you can go fix up your userspace code to work properly.  Anything
that came before today is pointless here, right?  :)

> I think we agreed that I will keep the global driver state in the device
> object as Wei suggested and remove global variables. There still will be
> a single /dev/dxg device node. Correct?

I do not know, as I can't figure out your goals here at all, sorry.

Please go work with some experienced Linux developers in your company.
They should be the ones answering these questions for you, not me :)

thanks,

greg k-h
