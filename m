Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103974C9EAF
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiCBHzf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 02:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiCBHzd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 02:55:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461065FF0D;
        Tue,  1 Mar 2022 23:54:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 723AC60B45;
        Wed,  2 Mar 2022 07:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6432EC004E1;
        Wed,  2 Mar 2022 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646207688;
        bh=qND4m24OAJFwvcNEssXhOx4OQt2rnFACAB2LZWje+2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4LjV/Hyr2OiWBr9mwQ4RKoqXZDcAKMID4zS1jS47xL7nzp6mgRuwjazDoHZLoOZO
         gE+67XIvBkhYsPDnm9pUqJDXlH6M6muj9rONx5kEOd5Vg8w/3K4G+TF0fvK3VFYmYo
         z65k1n6R+K57f3cpZK6wlACzu4qv7utauthsJvBg=
Date:   Wed, 2 Mar 2022 08:54:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <Yh8iwwKBZMXhcc2H@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <208d42df-3dbf-a9b0-6c68-7cded8e2007d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208d42df-3dbf-a9b0-6c68-7cded8e2007d@linux.microsoft.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 02:47:28PM -0800, Iouri Tarassov wrote:
> On 3/1/2022 2:23 PM, Wei Liu wrote:
> > On Tue, Mar 01, 2022 at 09:45:41PM +0100, Greg KH wrote:
> > > On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> > > > - Create skeleton and add basic functionality for the
> > > > hyper-v compute device driver (dxgkrnl).
> > > > > > - Register for PCI and VM bus driver notifications and
> > > > handle initialization of VM bus channels.
> > > > > > - Connect the dxgkrnl module to the drivers/hv/ Makefile and
> > Kconfig
> > > > > > - Create a MAINTAINERS entry
> > > > > > A VM bus channel is a communication interface between the
> > hyper-v guest
> > > > and the host. The are two type of VM bus channels, used in the driver:
> > > >   - the global channel
> > > >   - per virtual compute device channel
> > > > > > A PCI device is created for each virtual compute device,
> > projected
> > > > by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
> > > > id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
> > > > arrival of such devices. The PCI config space of the virtual compute
> > > > device has luid of the corresponding virtual compute device VM
> > > > bus channel. This is how the compute device adapter objects are
> > > > linked to VM bus channels.
> > > > > > VM bus interface version is exchanged by reading/writing the PCI
> > config
> > > > space of the virtual compute device.
> > > > > > The IO space is used to handle CPU accessible compute device
> > > > allocations. Hyper-v allocates IO space for the global VM bus channel.
> > > > > > Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
> > > > Please work with internal developers to get reviews from them first,
> > > before requiring the kernel community to point out basic issues.  It
> > > will save you a lot of time and stop us from feeling like we are having
> > > our time wasted.
> > > > Some simple examples below that your coworkers should have caught:
> > > > > --- /dev/null
> > > > +++ b/drivers/hv/dxgkrnl/dxgkrnl.h
> > > > @@ -0,0 +1,119 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +/*
> > > > + * Copyright (c) 2019, Microsoft Corporation.
> > > > It is now 2022 :)
> > > > > +void init_ioctls(void);
> > > > That is a horrible global function name you just added to the
> > kernel's
> > > namespace for a single driver :(
> > > > > +long dxgk_unlocked_ioctl(struct file *f, unsigned int p1,
> > unsigned long p2);
> > > > +
> > > > +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> > > > +{
> > > > +	*luid = *(struct winluid *)&guid->b[0];
> > > > Why is the cast needed?  Shouldn't you use real types in your
> > > structures?
> > > > > +/*
> > > > + * The interface version is used to ensure that the host and the guest use the
> > > > + * same VM bus protocol. It needs to be incremented every time the VM bus
> > > > + * interface changes. DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION is
> > > > + * incremented each time the earlier versions of the interface are no longer
> > > > + * compatible with the current version.
> > > > + */
> > > > +#define DXGK_VMBUS_INTERFACE_VERSION_OLD		27
> > > > +#define DXGK_VMBUS_INTERFACE_VERSION			40
> > > > +#define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
> > > > Where do these numbers come from, the hypervisor specification?
> > > > > +/*
> > > > + * Pointer to the global device data. By design
> > > > + * there is a single vGPU device on the VM bus and a single /dev/dxg device
> > > > + * is created.
> > > > + */
> > > > +struct dxgglobal *dxgglobal;
> > > > No, make this per-device, NEVER have a single device for your
> > driver.
> > > The Linux driver model makes it harder to do it this way than to do it
> > > correctly.  Do it correctly please and have no global structures like
> > > this.
> > >
> > 
> > This may not be as big an issue as you thought. The device discovery is
> > still done via the normal VMBus probing routine. For all intents and
> > purposes the dxgglobal structure can be broken down into per device
> > fields and a global structure which contains the protocol versioning
> > information -- my understanding is there will always be a global
> > structure to hold information related to the backend, regardless of how
> > many devices there are.
> > 
> > I definitely think splitting is doable, but I also understand why Iouri
> > does not want to do it _now_ given there is no such a model for multiple
> > devices yet, so anything we put into the per-device structure could be
> > incomplete and it requires further changing when such a model arrives
> > later.
> > 
> > Iouri, please correct me if I have the wrong mental model here.
> > 
> > All in all, I hope this is not going to be a deal breaker for the
> > acceptance of this driver.
> > 
> > Thanks,
> > Wei.
> 
> I agree with Wei that there always be global driver data.

Why?

> The driver reflects what the host offers and also it must provide the same
> interface to user mode as the host driver does. This is because we want the
> user mode clients to use the same device interface as if they are working on
> the host directly.

That's fine, put that state in the device interface.

> By design a single global VMBus channel is offered by the host and a single
> /dev/dxg device is created. The /dev/dxg device provides interface to enumerate
> virtual compute devices via an ioctl.

You have device data for each vmbus channel given to the driver, use
that.

> If we are to change this model, we would need to make changes to user mode
> clients, which is a big re-design change, affecting many hardware vendors.

This should not be visible to userspace at all.  If so, you are really
doing something odd.

thanks,

greg k-h
