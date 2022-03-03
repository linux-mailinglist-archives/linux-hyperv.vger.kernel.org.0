Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC53E4CBEDF
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiCCNaQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Mar 2022 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiCCNaQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Mar 2022 08:30:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01116188A1D;
        Thu,  3 Mar 2022 05:29:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C74161A73;
        Thu,  3 Mar 2022 13:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79078C004E1;
        Thu,  3 Mar 2022 13:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646314170;
        bh=QoUIlhSX3DrEFyg4qhjbuIqMXNXDasSJRxk9hH0m6j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmKdCLVpinz8bEgJHV5HTEpQUTAzDN+edwGCFQi+VVI0Q+BcwI/EDC3vwvn8f3VGk
         KOrQGAJmf7uOBF/y/7/C3dzAv31bNiXuWfYCLKPKYl3Fo38qeq/I8Ay8+2Arwky3jm
         dZSkADJEcpeNNymgGDoYkr6qKUHZ8XIJ/H7mFL38=
Date:   Thu, 3 Mar 2022 14:29:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <YiDCt05zLvRetoMM@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <7e696255-fba5-614b-81b5-a5f7e0877a83@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e696255-fba5-614b-81b5-a5f7e0877a83@linux.microsoft.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 02:59:13PM -0800, Iouri Tarassov wrote:
> Hi Greg,
> 
> Thanks a lot for reviewing the patches.
> 
> I appreciate the very detailed comments. I my reply I omitted the
> comments, which I agree with and will address in subsequent patches.
> 
> On 3/1/2022 12:45 PM, Greg KH wrote:
> 
> >
> > > +long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
> > > +
> > > +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> > > +{
> > > +	*luid = *(struct winluid *)&guid->b[0];
> >
> > Why is the cast needed?  Shouldn't you use real types in your
> > structures?
> 
> 
> The VMBus channel ID, which is GUID, is present in the PCI config space
> of the compute device. The convention is that the lower part of the GUID
> is LUID (local unique identifier). This function just converts GUID to
> LUID. I am not sure what is the ask here.

You need to documen the heck out of what you are doing here as it looks
very very odd.

> > > +/*
> > > + * The interface version is used to ensure that the host and the guest use the
> > > + * same VM bus protocol. It needs to be incremented every time the VM bus
> > > + * interface changes. DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION is
> > > + * incremented each time the earlier versions of the interface are no longer
> > > + * compatible with the current version.
> > > + */
> > > +#define DXGK_VMBUS_INTERFACE_VERSION_OLD		27
> > > +#define DXGK_VMBUS_INTERFACE_VERSION			40
> > > +#define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
> >
> > Where do these numbers come from, the hypervisor specification?
> 
> 
> The definitions are for the VMBus interface between the virtual compute
> device in the guest and the Windows host. The interface version is
> updated when the VMBus protocol is changed. These are specific to the
> virtual compute device, not to the hypervisor.

That's not ok, you can not break the user/kernel interface from this
moment going forward forever.  You can't just have version numbers for
your protocol, you need to handle it correctly like all of Linux does.

> > > +#define DXGKRNL_VERSION			0x2216
> >
> > What does this mean?
> 
> 
> This is the driver implementation version. There are many Microsoft
> shipped Linux kernels, which include the driver. The version allows to
> quickly determine, which level of functionality or bug fixes is
> implemented in the current driver.

That number means nothing once the driver is in the kernel tree as your
driver is part of a larger whole and you have no idea what people have,
or have not, backported to your portion of the driver or the rest of the
kernel anymore.  Just drop this, it's not going to be used ever again,
and will always be out of date and wrong.

In-kernel drivers do NOT need a version number.  I have worked to remove
almost all of them, but have not finished that task, which is why you
see a few remaining.  Do not copy bad examples.

> > > +/*
> > > + * Part of the PCI config space of the vGPU device is used for vGPU
> > > + * configuration data. Reading/writing of the PCI config space is forwarded
> > > + * to the host.
> > > + */
> >
> > > +/* DXGK_VMBUS_INTERFACE_VERSION (u32) */
> >
> > What is this?
> 
> 
> This comment explains that the value of DXGK_VMBUS_INTERFACE_VERSION is
> located at the offset DXGK_VMBUS_CHANNEL_ID_OFFSET in the PCI config space.

Then please explain that.

> > > +#define DXGK_VMBUS_VERSION_OFFSET	(DXGK_VMBUS_CHANNEL_ID_OFFSET + \
> > > +					sizeof(guid_t))
> >
> > offsetof() is your friend, please use it.
> 
> 
> There is no structure definition for the PCI config space of the device.
> Therefore, offsets are computed by using data size.

That's odd, why not just use a structure on top of the memory location?
That way you get real structure information if things change and you
don't have to cast anything.

> > > +/* Luid of the virtual GPU on the host (struct winluid) */
> >
> > What is a "luid"?
> 
> 
> LUID is "Locally Unique Identifier". It is used in Windows and its value
> is guaranteed to be unique until the computer reboots.

What about vm lifespans?  VM cloning?  Why does the Linux kernel care
about this value?

> > > +	ret = vmbus_driver_register(&dxg_drv);
> > > +	if (ret) {
> > > +		pr_err("vmbus_driver_register failed: %d", ret);
> > > +		return ret;
> > > +	}
> > > +	dxgglobal->vmbus_registered = true;
> > > +
> > > +	pr_info("%s  Version: %x", __func__, DXGKRNL_VERSION);
> >
> > When drivers work, they are quiet.
> >
> > Also, in-kernel modules do not have a version, they are part of the
> > kernel tree, and that's the "version" they have.  You can drop the
> > individual version here, it makes no sense anymore.
> 
> 
> Microsoft develops many Linux kernels when the dxgkrnl driver is
> included (EFLOW, Android, WSL). The kernels are built at different times
> and might include a different version of the driver. Printing the
> version allows to quickly determine what functionality and bug fixes are
> included in the driver.

Again, see above why your driver version is not needed.  Please remove
this line as well.

> I see that other in-tree drivers print some information during
> init_module (like nfblock.c).

Some older ones do, yes.  Please be good and follow the proper rules and
be quiet when booting.

> This is done for convenience. So instead of tracking multiple kernel
> versions, we can track the dxgkrnl driver version. I am ok to remove it
> if it really hurts something. It is only a single line per driver load.

The driver version _IS_ the kernel version once it is merged into the
kernel tree, as you rely on the whole of the kernel for your proper
functionality.  Drivers do not need individual versions.

Again, work with the experienced Linux developers at your company for
this type of thing.  They know this already, you don't need me to find
basic problems like this in your code :)

thanks,

greg k-h
