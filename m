Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907814CB24A
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 23:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiCBW1z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 17:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiCBW1w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 17:27:52 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A311E686F;
        Wed,  2 Mar 2022 14:27:07 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA9F020B7178;
        Wed,  2 Mar 2022 14:27:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA9F020B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646260026;
        bh=bZ99YO6zuQH4/j369PIclhSB2RK/e1v5SRNGWRV8xGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JtD0w+tgrDHO3HW13HVeNFLILxO+UMB4pqLcC+agYcu2JTvbIxMRSbqF2MGntDqxi
         JQyA90UmSC3xBoQeOeTSagYERupQ+m1P/wBVRx89eps8dKVxBS0kTcNMU1Gal88VxP
         3/zIydXeccen8tNvQZOArq7RFzEIeaiPZ07osNQc=
Message-ID: <78df3646-4df6-5e2b-2f6e-e14824b08d85@linux.microsoft.com>
Date:   Wed, 2 Mar 2022 14:27:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
 <20220302115334.wemdkznokszlzcpe@liuwe-devbox-debian-v2>
 <6ac1dd87-3c78-66ca-c526-d1f6cf253400@linux.microsoft.com>
 <Yh/Rq9PwWZAN8Mu2@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yh/Rq9PwWZAN8Mu2@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 3/2/2022 12:20 PM, Greg KH wrote:
> On Wed, Mar 02, 2022 at 10:49:15AM -0800, Iouri Tarassov wrote:
> > On 3/2/2022 3:53 AM, Wei Liu wrote:
> > > On Wed, Mar 02, 2022 at 08:53:15AM +0100, Greg KH wrote:
> > > > On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > > > > > +struct dxgglobal *dxgglobal;
> > > > > > 
> > > > > > No, make this per-device, NEVER have a single device for your driver.
> > > > > > The Linux driver model makes it harder to do it this way than to do it
> > > > > > correctly.  Do it correctly please and have no global structures like
> > > > > > this.
> > > > > > 
> > > > > 
> > > > > This may not be as big an issue as you thought. The device discovery is
> > > > > still done via the normal VMBus probing routine. For all intents and
> > > > > purposes the dxgglobal structure can be broken down into per device
> > > > > fields and a global structure which contains the protocol versioning
> > > > > information -- my understanding is there will always be a global
> > > > > structure to hold information related to the backend, regardless of how
> > > > > many devices there are.
> > > > 
> > > > Then that is wrong and needs to be fixed.  Drivers should almost never
> > > > have any global data, that is not how Linux drivers work.  What happens
> > > > when you get a second device in your system for this?  Major rework
> > > > would have to happen and the code will break.  Handle that all now as it
> > > > takes less work to make this per-device than it does to have a global
> > > > variable.
> > > > 
> > >
> > > It is perhaps easier to draw parallel from an existing driver. I feel
> > > like we're talking past each other.
> > >
> > > Let's look at drivers/iommu/intel/iommu.c. There are a bunch of lists
> > > like `static LIST_HEAD(dmar_rmrr_units)`. During the probing phase, new
> > > units will be added to the list. I this the current code is following
> > > this model. dxgglobal fulfills the role of a list.
> > >
> > > Setting aside the question of whether it makes sense to keep a copy of
> > > the per-VM state in each device instance, I can see the code be changed
> > > to:
> > >
> > >     struct mutex device_mutex; /* split out from dxgglobal */
> > >     static LIST_HEAD(dxglist);
> > >     
> > >     /* Rename struct dxgglobal to struct dxgstate */
> > >     struct dxgstate {
> > >        struct list_head dxglist; /* link for dxglist */
> > >        /* ... original fields sans device_mutex */
> > >     }
> > >
> > >     /*
> > >      * Provide a bunch of helpers manipulate the list. Called in probe /
> > >      * remove etc.
> > >      */
> > >     struct dxgstate *find_dxgstate(...);
> > >     void remove_dxgstate(...);
> > >     int add_dxgstate(...);
> > >
> > > This model is well understood and used in tree. It is just that it
> > > doesn't provide much value in doing this now since the list will only
> > > contain one element. I hope that you're not saying we cannot even use a
> > > per-module pointer to quickly get the data structure we want to use,
> > > right?
> > >
> > > Are you suggesting Iouri use dev_set_drvdata to stash the dxgstate
> > > into the device object? I think that can be done too.
> > >
> > > The code can be changed as:
> > >
> > >     /* Rename struct dxgglobal to dxgstate and remove unneeded fields */
> > >     struct dxgstate { ... };
> > >
> > >     static int dxg_probe_vmbus(...) {
> > >
> > >         /* probe successfully */
> > >
> > > 	struct dxgstate *state = kmalloc(...);
> > > 	/* Fill in dxgstate with information from backend */
> > >
> > > 	/* hdev->dev is the device object from the core driver framework */
> > > 	dev_set_drvdata(&hdev->dev, state);
> > >     }
> > >
> > >     static int dxg_remove_vmbus(...) {
> > >         /* Normal stuff here ...*/
> > >
> > > 	struct dxgstate *state = dev_get_drvdata(...);
> > > 	dev_set_drvdata(..., NULL);
> > > 	kfree(state);
> > >     }
> > >
> > >     /* In all other functions */
> > >     void do_things(...) {
> > >         struct dxgstate *state = dev_get_drvdata(...);
> > >
> > > 	/* Use state in place of where dxgglobal was needed */
> > >
> > >     }
> > >
> > > Iouri, notice this doesn't change anything regarding how userspace is
> > > designed. This is about how kernel organises its data.
> > >
> > > I hope what I wrote above can bring our understanding closer.
> > >
> > > Thanks,
> > > Wei.
> > 
> > 
> > I can certainly remove dxgglobal and keep the  pointer to the global
> > state in the device object.
> > 
> > This will require passing of the global pointer to all functions, which
> > need to access it.
> > 
> > 
> > Maybe my understanding of the Greg's suggestion was not correct. I
> > thought the suggestion was
> > 
> > to have multiple /dev/dxgN devices (one per virtual compute device).
>
> You have one device per HV device, as the bus already provides you.
> That's all you really need, right?  Who would be opening the same device
> node multiple times?
> > This would change how the user mode
> > clients enumerate and communicate with compute devices.
>
> What does userspace have to do here?  It should just open the device
> node that is present when needed.  How will there be multiple userspace
> clients for a single HV device?


Dxgkrnl creates a single user mode visible device node /dev/dxg. It has
nothing to do with a specific hardware compute device on the host. Its
purpose is to provide services (IOCTLs) to enumerate and manage virtual
compute devices, which represent hardware devices on the host. The VMBus
devices are not used directly by user mode clients in the current design.

Virtual compute devices are shared between processes. There could be a
Cuda application, Gimp and a Direct3D12 application working at the same
time.This is what I mean by saying that there are multiple user mode
clients who use the /dev/dxg driver interface. Each of this applications
will open the /dev/dxg device node and enumerate/use virtual compute
devices.

If we change the way how the virtual compute devices are visible to user
mode, the Cuda runtime, Direct3D runtime would need to be changed.

I think we agreed that I will keep the global driver state in the device
object as Wei suggested and remove global variables. There still will be
a single /dev/dxg device node. Correct?


Thanks

Iouri

