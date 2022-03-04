Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF534CD88A
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Mar 2022 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiCDQFM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Mar 2022 11:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiCDQFK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Mar 2022 11:05:10 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10351B84E8;
        Fri,  4 Mar 2022 08:04:14 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id j26so3006244wrb.1;
        Fri, 04 Mar 2022 08:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0BQ+ho49KUdsDoNFJ3jj03vMIB+LJ0uwZ+l2Q2jypGU=;
        b=U738rrsw9z1UC3LxpBaw2aq8nVnsv5t/RF2gpGMpzodF+aVjU8TPztFHYR1XWnsKah
         qCWVC0YTlRWA0tN5VhDXyDPo/+UbaYB69dkvJoas60QxUbYsyfLcvoyGBBvrVwx5TBf5
         vsbYm0vudpLbZvhIwd6OaxcvIdKpE3tz1nATfV8O23kpG6ApnJSapBvu3+kQ/c7rq/n3
         dhpXgXtBmKD5Mfy6YEavHq+RJO2wbfA9Dpd/WkiUqPTi/DAg57g7cL5jY6ShxCJk4T4p
         k0jnmWEgblatYguw59EvGZxyX3aKDiVtuCVtWUoO64OfINCqae/DJyv6NtOu8jb7W0TA
         hN0A==
X-Gm-Message-State: AOAM533QWvG/s/Z2aH/02UvjX8Fa6TQGlgOvkv07N6hcddTGhD2ffdU9
        7iwsdztp3f1XcAq5Fu39CX/muQMov9g=
X-Google-Smtp-Source: ABdhPJwIzMIMHCkjZNSSeHzpFAX8nkgHBw9YRRg0U281+a7HjN25BQqqTC21g3XSGDRxqvhdNn47cg==
X-Received: by 2002:adf:e288:0:b0:1e3:36c0:91cc with SMTP id v8-20020adfe288000000b001e336c091ccmr30275426wri.41.1646409852988;
        Fri, 04 Mar 2022 08:04:12 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b00381807bd920sm5957464wmq.28.2022.03.04.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:04:11 -0800 (PST)
Date:   Fri, 4 Mar 2022 16:04:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Iouri Tarassov <iourit@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <20220304160410.zbdbds6wh3omi5mk@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
 <c848ade1-48e4-1868-b890-9c3401cff9de@linux.microsoft.com>
 <YiDBGFJcQXfx/hwG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDBGFJcQXfx/hwG@kroah.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 03, 2022 at 02:22:32PM +0100, Greg KH wrote:
> On Wed, Mar 02, 2022 at 05:09:21PM -0800, Iouri Tarassov wrote:
> > 
> > On 3/1/2022 11:53 PM, Greg KH wrote:
> > > On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > > > > +struct dxgglobal *dxgglobal;
> > > > > 
> > > > > No, make this per-device, NEVER have a single device for your driver.
> > > > > The Linux driver model makes it harder to do it this way than to do it
> > > > > correctly.  Do it correctly please and have no global structures like
> > > > > this.
> > > > > 
> > > > 
> > > > This may not be as big an issue as you thought. The device discovery is
> > > > still done via the normal VMBus probing routine. For all intents and
> > > > purposes the dxgglobal structure can be broken down into per device
> > > > fields and a global structure which contains the protocol versioning
> > > > information -- my understanding is there will always be a global
> > > > structure to hold information related to the backend, regardless of how
> > > > many devices there are.
> > >
> > > Then that is wrong and needs to be fixed.  Drivers should almost never
> > > have any global data, that is not how Linux drivers work.  What happens
> > > when you get a second device in your system for this?  Major rework
> > > would have to happen and the code will break.  Handle that all now as it
> > > takes less work to make this per-device than it does to have a global
> > > variable.
> > >
> > > > I definitely think splitting is doable, but I also understand why Iouri
> > > > does not want to do it _now_ given there is no such a model for multiple
> > > > devices yet, so anything we put into the per-device structure could be
> > > > incomplete and it requires further changing when such a model arrives
> > > > later.
> > > > 
> > > > Iouri, please correct me if I have the wrong mental model here.
> > > > 
> > > > All in all, I hope this is not going to be a deal breaker for the
> > > > acceptance of this driver.
> > >
> > > For my reviews, yes it will be.
> > >
> > > Again, it should be easier to keep things in a per-device state than
> > > not as the proper lifetime rules and the like are automatically handled
> > > for you.  If you have global data, you have to manage that all on your
> > > own and it is _MUCH_ harder to review that you got it correct.
> > 
> > Hi Greg,
> > 
> > I do not really see how the driver be written without the global data. Let's review the design.
> 
> I see it the other way around.  It's easier to make it without a static
> structure, it is more work to keep it as you have done so here.  Do it
> correctly to start with and you will not have any of these issues going
> forward.
> 

> > Dxgkrnl acts as the aggregator of all virtual compute devices, projected by the host. It needs to do operations, which do not belong to a particular compute device. For example, cross device synchronization and resource sharing.

Hey Iouri, please fix your text wrapping.

Greg, I have to admit I only started paying close attention to this
series a few days ago, so I don't claim I know a lot.

> 
> Then hang your data off of your device node structure that you
> created. Why ignore that?
> 
> > A PCI device device is created for each virtual compute device.
> > Therefore, there should be a global list of objects and a mutex to
> > synchronize access to the list.
> 
> Woah, what?  You create a fake PCI device for each virtual device?  If
> so, great, then you are now a PCI bus and create the PCI devices
> properly so that the PCI core can handle and manage them and then
> assign them to your driver.  You should NEVER have a global list of
> these devices, as that is what the driver model should be managing.
> Not you!
> 

No, there is no fake PCI device. The device object is still coming from
the PCI core driver. There is code to match against PCI vendor ID and
device ID, and follow the usual way of managing PCI device.

Iouri understands device specific state should be encapsulated in the
private data field in their respective device. And I believe the code
can perhaps be rewritten to better conform to Linux kernel's model.

That should address the issue ...

> > A VMBus channel is offered by the host for each compute device. The
> > list of the VMBus channels should be global.
> 
> The vmbus channels are already handled by the driver core.  Use those
> devices that are given to you.  You don't need to manage them at all.
> 

here ...

> > A global VMBus channel is offered by the host. The channel does not
> > belong to any particular compute device, so it must be global.
> 
> That channel is attached to your driver, use the device given to your
> driver by the bus.  It's not "global" in any sense of the word.
> 

here ...

> And what's up with your lack of line wrapping?
> 
> > IO space is shared by all compute devices, so its parameters should
> > be global.
> 
> Huh?  If that's the case then you have bigger problems.  Use the aux
> bus for devices that share io space.  That is what it was created for,
> do not ignore the functionality that Linux already provides you by
> trying to go around it and writing your own code.  Use the frameworks
> we have already debugged and support.  This is why your Linux driver
> should be at least 1/3 smaller than drivers for other operating
> systems.
> 

To be fair, auxiliary bus was only added in 5.11, while this series was
written long before that. Unfortunately one only has so much time to
follow Linux kernel development closely. I admit this is the first time
I hear about it. :-)

> > Dxgkrnl needs to maintain a list of processes, which opened compute
> > device objects. Dxgkrnl maintains private state for each process and
> > when a process opens the /dev/dxg device, Dxgkrnl needs to find if
> > the process state is already created by walking the global process
> > list.
> 
> That "list" is handled by the device node structure that was opened.
> It's not "global" at all.  Again, just like any other device node in
> Linux, this isn't a new thing or anything special at all.
> 

Again, the state can be associated with the `private_data` field in
struct file.

> > Now, where to keep this global state? It could be kept in the
> > /dev/dxg private device structure. But this structure is not
> > available when, for example, dxg_pci_probe_device() or
> > dxg_probe_vmbus() is called.
> 
> Then your design is wrong.  It's as simple as that.  Fix it.
> 
> > Can there be multiple /dev/dxg devices? No. Because the /dev/dxg
> > device represents the driver itself, not a particular compute
> > device.
> 
> Then fix this.  Make your compute devices store the needed information
> when they are created.  Again, we have loads of examples in the kernel,
> this is nothing new.
> 

At this point, I think Iouri and I have settled on more encapsulation is
needed. Yet there is something I don't know how to square yet. That is,
devices (either from vmbus or pci) don't form a clear hierarchy. If
there isn't a linked list or some sort to organize them it would be
difficult to cross-reference. This then goes back to what I wrote
earlier in <20220302115334.wemdkznokszlzcpe@liuwe-devbox-debian-v2>. I
hope you won't be against using that pattern -- it is used in a lot of
places in tree.

Thanks,
Wei.
