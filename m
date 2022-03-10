Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A274D4453
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Mar 2022 11:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiCJKOg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Mar 2022 05:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiCJKOf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Mar 2022 05:14:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8412E17D;
        Thu, 10 Mar 2022 02:13:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D696AB82459;
        Thu, 10 Mar 2022 10:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7927DC340E8;
        Thu, 10 Mar 2022 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646907211;
        bh=vb23eZjkJRRkXZ+NmzNNETFecFoFtxf5oa/vPHK83Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knZVqLoHVq4/BHuBuyy1aBydG2sVwKkhT5rprVFGfvX2qf4tM9S3G8B5+J/KXn+JE
         EnibOi5amBiGhYAt+GCn5mo5nTpmNJX82EPyjrtXNUThQQyU2tLTNHM9Fxs4DWlJAs
         mEsfYrdx3UAIncUlThdVSjr8Qt61KFoKidYV54j8=
Date:   Thu, 10 Mar 2022 11:13:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steve Pronovost <spronovo@linux.microsoft.com>
Cc:     Iouri Tarassov <iourit@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <YinPR66ekfKWHR0R@kroah.com>
References: <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
 <20220302115334.wemdkznokszlzcpe@liuwe-devbox-debian-v2>
 <6ac1dd87-3c78-66ca-c526-d1f6cf253400@linux.microsoft.com>
 <Yh/Rq9PwWZAN8Mu2@kroah.com>
 <78df3646-4df6-5e2b-2f6e-e14824b08d85@linux.microsoft.com>
 <YiC/k1pKTUV12APe@kroah.com>
 <932dce51-c868-d0e8-ef4c-bc7c8c58d997@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <932dce51-c868-d0e8-ef4c-bc7c8c58d997@linux.microsoft.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 09, 2022 at 03:14:24PM -0800, Steve Pronovost wrote:
> 
> On 3/3/22 05:16, Greg KH wrote:
> > On Wed, Mar 02, 2022 at 02:27:05PM -0800, Iouri Tarassov wrote:
> >> On 3/2/2022 12:20 PM, Greg KH wrote:
> >>> On Wed, Mar 02, 2022 at 10:49:15AM -0800, Iouri Tarassov wrote:
> >>>> On 3/2/2022 3:53 AM, Wei Liu wrote:
> >>>>> On Wed, Mar 02, 2022 at 08:53:15AM +0100, Greg KH wrote:
> >>>>>> On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> >>>>>>>>> +struct dxgglobal *dxgglobal;
> >>>>>>>> No, make this per-device, NEVER have a single device for your driver.
> >>>>>>>> The Linux driver model makes it harder to do it this way than to do it
> >>>>>>>> correctly.  Do it correctly please and have no global structures like
> >>>>>>>> this.
> >>>>>>>>
> >>>>>>> This may not be as big an issue as you thought. The device discovery is
> >>>>>>> still done via the normal VMBus probing routine. For all intents and
> >>>>>>> purposes the dxgglobal structure can be broken down into per device
> >>>>>>> fields and a global structure which contains the protocol versioning
> >>>>>>> information -- my understanding is there will always be a global
> >>>>>>> structure to hold information related to the backend, regardless of how
> >>>>>>> many devices there are.
> >>>>>> Then that is wrong and needs to be fixed.  Drivers should almost never
> >>>>>> have any global data, that is not how Linux drivers work.  What happens
> >>>>>> when you get a second device in your system for this?  Major rework
> >>>>>> would have to happen and the code will break.  Handle that all now as it
> >>>>>> takes less work to make this per-device than it does to have a global
> >>>>>> variable.
> >>>>>>
> >>>>> It is perhaps easier to draw parallel from an existing driver. I feel
> >>>>> like we're talking past each other.
> >>>>>
> >>>>> Let's look at drivers/iommu/intel/iommu.c. There are a bunch of lists
> >>>>> like `static LIST_HEAD(dmar_rmrr_units)`. During the probing phase, new
> >>>>> units will be added to the list. I this the current code is following
> >>>>> this model. dxgglobal fulfills the role of a list.
> >>>>>
> >>>>> Setting aside the question of whether it makes sense to keep a copy of
> >>>>> the per-VM state in each device instance, I can see the code be changed
> >>>>> to:
> >>>>>
> >>>>>     struct mutex device_mutex; /* split out from dxgglobal */
> >>>>>     static LIST_HEAD(dxglist);
> >>>>>     
> >>>>>     /* Rename struct dxgglobal to struct dxgstate */
> >>>>>     struct dxgstate {
> >>>>>        struct list_head dxglist; /* link for dxglist */
> >>>>>        /* ... original fields sans device_mutex */
> >>>>>     }
> >>>>>
> >>>>>     /*
> >>>>>      * Provide a bunch of helpers manipulate the list. Called in probe /
> >>>>>      * remove etc.
> >>>>>      */
> >>>>>     struct dxgstate *find_dxgstate(...);
> >>>>>     void remove_dxgstate(...);
> >>>>>     int add_dxgstate(...);
> >>>>>
> >>>>> This model is well understood and used in tree. It is just that it
> >>>>> doesn't provide much value in doing this now since the list will only
> >>>>> contain one element. I hope that you're not saying we cannot even use a
> >>>>> per-module pointer to quickly get the data structure we want to use,
> >>>>> right?
> >>>>>
> >>>>> Are you suggesting Iouri use dev_set_drvdata to stash the dxgstate
> >>>>> into the device object? I think that can be done too.
> >>>>>
> >>>>> The code can be changed as:
> >>>>>
> >>>>>     /* Rename struct dxgglobal to dxgstate and remove unneeded fields */
> >>>>>     struct dxgstate { ... };
> >>>>>
> >>>>>     static int dxg_probe_vmbus(...) {
> >>>>>
> >>>>>         /* probe successfully */
> >>>>>
> >>>>> 	struct dxgstate *state = kmalloc(...);
> >>>>> 	/* Fill in dxgstate with information from backend */
> >>>>>
> >>>>> 	/* hdev->dev is the device object from the core driver framework */
> >>>>> 	dev_set_drvdata(&hdev->dev, state);
> >>>>>     }
> >>>>>
> >>>>>     static int dxg_remove_vmbus(...) {
> >>>>>         /* Normal stuff here ...*/
> >>>>>
> >>>>> 	struct dxgstate *state = dev_get_drvdata(...);
> >>>>> 	dev_set_drvdata(..., NULL);
> >>>>> 	kfree(state);
> >>>>>     }
> >>>>>
> >>>>>     /* In all other functions */
> >>>>>     void do_things(...) {
> >>>>>         struct dxgstate *state = dev_get_drvdata(...);
> >>>>>
> >>>>> 	/* Use state in place of where dxgglobal was needed */
> >>>>>
> >>>>>     }
> >>>>>
> >>>>> Iouri, notice this doesn't change anything regarding how userspace is
> >>>>> designed. This is about how kernel organises its data.
> >>>>>
> >>>>> I hope what I wrote above can bring our understanding closer.
> >>>>>
> >>>>> Thanks,
> >>>>> Wei.
> >>>>
> >>>> I can certainly remove dxgglobal and keep the  pointer to the global
> >>>> state in the device object.
> >>>>
> >>>> This will require passing of the global pointer to all functions, which
> >>>> need to access it.
> >>>>
> >>>>
> >>>> Maybe my understanding of the Greg's suggestion was not correct. I
> >>>> thought the suggestion was
> >>>>
> >>>> to have multiple /dev/dxgN devices (one per virtual compute device).
> >>> You have one device per HV device, as the bus already provides you.
> >>> That's all you really need, right?  Who would be opening the same device
> >>> node multiple times?
> >>>> This would change how the user mode
> >>>> clients enumerate and communicate with compute devices.
> >>> What does userspace have to do here?  It should just open the device
> >>> node that is present when needed.  How will there be multiple userspace
> >>> clients for a single HV device?
> >>
> >> Dxgkrnl creates a single user mode visible device node /dev/dxg.
> > When you do that, you have a device to put all of your data on.  Use
> > that.
> >
> >> It has
> >> nothing to do with a specific hardware compute device on the host. Its
> >> purpose is to provide services (IOCTLs) to enumerate and manage virtual
> >> compute devices, which represent hardware devices on the host. The VMBus
> >> devices are not used directly by user mode clients in the current design.
> > That's horrid, why not just export the virtual compute devices properly
> > through individual device nodes instead?
> >
> > In essence, you are creating a new syscall here to manage and handle
> > devices for just your driver with the use of this ioctl.  That's
> > generally a bad idea.
> >
> >> Virtual compute devices are shared between processes. There could be a
> >> Cuda application, Gimp and a Direct3D12 application working at the same
> >> time.
> > Why are all of those applications sharing anything?  How are they
> > sharing anything?  If you need to share something across processes, use
> > the existing inter-process ways of sharing stuff that we have today (12+
> > different apis and counting).  Don't create yet-another-one just for
> > your tiny little driver here.  That's rude to the rest of the kernel.
> >
> >> This is what I mean by saying that there are multiple user mode
> >> clients who use the /dev/dxg driver interface. Each of this applications
> >> will open the /dev/dxg device node and enumerate/use virtual compute
> >> devices.
> > That seems like an odd model to follow.  How many virtual devices do you
> > support?  Is there a limit?  Why not just enumerate them all to start
> > with?  Or if there are too many, why not do it like the raw device and
> > have a single device node that is used to create the virtual devices you
> > wish to use?
> >
> >> If we change the way how the virtual compute devices are visible to user
> >> mode, the Cuda runtime, Direct3D runtime would need to be changed.
> > We do not care about existing userspace code at this point in time, you
> > are trying to get the kernel api correct here.  Once you have done that,
> > then you can go fix up your userspace code to work properly.  Anything
> > that came before today is pointless here, right?  :)
> >
> >> I think we agreed that I will keep the global driver state in the device
> >> object as Wei suggested and remove global variables. There still will be
> >> a single /dev/dxg device node. Correct?
> > I do not know, as I can't figure out your goals here at all, sorry.
> >
> > Please go work with some experienced Linux developers in your company.
> > They should be the ones answering these questions for you, not me :)
> >
> > thanks,
> >
> > greg k-h
> Thanks Greg and folks for all the feedback. The userspace API provided  
> by this driver is specifically designed to match the Windows compute  
> device abstraction in order to light up a large eco-system of graphics  
> and compute APIs in our various virtualized Linux environment. This is  
> a pretty critical design point as this is the only way we can scale to  
> such a vast eco-system of APIs and their related tools. This enables  
> APIs and framework which are available natively on Linux, such as  
> CUDA, OpenGL, OpenCL, OpenVINO, OneAPI/L0, TensorFlow, Pytorch, soon  
> Vulkan and more in the future and allows them to share the host GPU or  
> compute device when run under our hypervisor. Most of these APIs sit  
> directly on top of our userspace API and changing that abstraction  
> would have major implications. Our D3D/DML userspace components are  
> only implementation details for a subset of those APIs.

This feels odd to me as I was only discussing the in-kernel apis, and
how this driver does not follow them correctly at all (global device
state, odd device creation, etc.)  That should have nothing to do with
the user/kernel api at all.  And surely CUDA and the like never have
defined a specific user/kernal api that must be followed, right?

Yes, the existing user/kernel api in this driver is a bit odd, but
really, we haven't even started to review that.  For you all to just
cut-and-run at the first sign of a detailed in-kernel code review is
strange, why are you giving up now?

> We have millions of developers experiencing and enjoying various Linux  
> distributions through our Windows Subsystem for Linux (WSL) and this  
> gives them a way to get hardware acceleration in a large number of  
> important scenarios. WSL makes it trivial for developers to try out  
> Linux totally risk free on over a billion devices, without having to  
> commit to a native install upfront or understand and manually manage  
> VMs. We think this is a pretty valuable proposition to both the  
> Windows and the Linux community and one which has definitely been  
> quite popular.

This has nothing to do with how this tiny driver uses the in-kernel apis
for creating and managing devices.  You are discussing userspace
applications here, which is a nice marketing discussion about how many
developers you have, but means nothing when it comes to how the kernel
code works.  So why mention it at all?

> That being said, we recognize that our virtualization approach makes  
> some folks in the community uncomfortable and the resulting userspace  
> API exposed by our driver will look a bit different than typical Linux  
> driver. Taking into consideration feedback and reception, we decided  
> to pause our upstream effort for this driver. We will keep our driver  
> open source and available in our downstream kernel tree for folks who  
> wants to leverage it in their private kernel.

The problems I am pointing out here are how your kernel driver is
interacting with the kernel driver model.  It has almost nothing to do
with the user/kernel api at all.

And even if it did concern the user/kernel api, you already have a
userspace library that has to talk to this driver, all you need to do is
modify that to handle the expected changes that will happen when you
actually get experienced kernel developers to review your code and apis.

I don't understand what you all were expecting here.  Did you not want
to fit into the kernel tree and take advantage of using the proper
functions and interfaces that have been created already?  That should
enable your users to be able to rely on a more stable and secure and
widespread driver for everyone to use.

Instead you are saying that you don't appreciate the time and energy we
spent on trying to help you improve your code for your users, and wish
to just ignore our help?

By doing this, you are telling all community members that they should
not waste their time in reviewing your company's code submissions as
they are not appreciated or wanted unless they are just a rubber-stamp
approval.  That's going to ensure that no one ever reviews your
contributions again in the future, which is an odd request, don't you
think?

Oh well, it's easy to add a filter to just ignore any future code
submissions from your email domain.  I'll recommend that all other
kernel developers and maintainers do the same as we all have changes to
review from companies and developers that actually want our feedback.

best of luck!

greg k-h
