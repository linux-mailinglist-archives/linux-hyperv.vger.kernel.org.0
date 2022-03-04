Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B64CDB6F
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Mar 2022 18:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiCDR4P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Mar 2022 12:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiCDR4O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Mar 2022 12:56:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4F41BB72C;
        Fri,  4 Mar 2022 09:55:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A06960AC9;
        Fri,  4 Mar 2022 17:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F257C340F2;
        Fri,  4 Mar 2022 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646416526;
        bh=J6hloWIO/6m3VRXucz1U/coFUk2wFv7ErlZ9Bs+z3oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSfNaKKMGCBtztEnASWwH28GmNY/S0ATzomDddon4T/3U66LGD1lOaBaSMHV+60KY
         8g3g2qcSMtbzMSqlofD6zTHjH3ijEau9SqIz3lBEMfxS0Yt5AQas3K5pVLNt1nmIEX
         nMY3080xaAvikH3M9NI51gINxube5j6pmzeefVBs=
Date:   Fri, 4 Mar 2022 18:55:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <YiJSh4WRmVdWvUc8@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
 <c848ade1-48e4-1868-b890-9c3401cff9de@linux.microsoft.com>
 <YiDBGFJcQXfx/hwG@kroah.com>
 <20220304160410.zbdbds6wh3omi5mk@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304160410.zbdbds6wh3omi5mk@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 04, 2022 at 04:04:10PM +0000, Wei Liu wrote:
> > > A PCI device device is created for each virtual compute device.
> > > Therefore, there should be a global list of objects and a mutex to
> > > synchronize access to the list.
> > 
> > Woah, what?  You create a fake PCI device for each virtual device?  If
> > so, great, then you are now a PCI bus and create the PCI devices
> > properly so that the PCI core can handle and manage them and then
> > assign them to your driver.  You should NEVER have a global list of
> > these devices, as that is what the driver model should be managing.
> > Not you!
> > 
> 
> No, there is no fake PCI device. The device object is still coming from
> the PCI core driver. There is code to match against PCI vendor ID and
> device ID, and follow the usual way of managing PCI device.

So it is a real PCI device?  Why the confusion?

> Iouri understands device specific state should be encapsulated in the
> private data field in their respective device. And I believe the code
> can perhaps be rewritten to better conform to Linux kernel's model.

It has to follow the Linux kernel model, to think otherwise is quite
odd.

> > > IO space is shared by all compute devices, so its parameters should
> > > be global.
> > 
> > Huh?  If that's the case then you have bigger problems.  Use the aux
> > bus for devices that share io space.  That is what it was created for,
> > do not ignore the functionality that Linux already provides you by
> > trying to go around it and writing your own code.  Use the frameworks
> > we have already debugged and support.  This is why your Linux driver
> > should be at least 1/3 smaller than drivers for other operating
> > systems.
> > 
> 
> To be fair, auxiliary bus was only added in 5.11, while this series was
> written long before that. Unfortunately one only has so much time to
> follow Linux kernel development closely. I admit this is the first time
> I hear about it. :-)

5.11 was over a year ago.  We do not take "old" drivers into the kernel
tree, and if this series has not been touched for over a year, um, you
all have bigger problems here and are just wasting our time :(

> > Then fix this.  Make your compute devices store the needed information
> > when they are created.  Again, we have loads of examples in the kernel,
> > this is nothing new.
> > 
> 
> At this point, I think Iouri and I have settled on more encapsulation is
> needed. Yet there is something I don't know how to square yet. That is,
> devices (either from vmbus or pci) don't form a clear hierarchy.

That is because devices don't care where they are in the larger kernel
tree of devices, they are independant.  To try to claim there is a
needed hierarchy is quite odd and will cause lots of problems when that
heirachy changes by the underlying system.

> If
> there isn't a linked list or some sort to organize them it would be
> difficult to cross-reference.

You should never be touching another device from another one.  There are
a few rare exceptions but they are rare and you should not use them at
all.  And if you do have to do so, you better get the reference counting
logic correct.

good luck!

greg k-h
