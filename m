Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B94C987C
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 23:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiCAWsO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 17:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiCAWsM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 17:48:12 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 774EE1006;
        Tue,  1 Mar 2022 14:47:30 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id CF2DB20B7178;
        Tue,  1 Mar 2022 14:47:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF2DB20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646174849;
        bh=S6SRPI0pzF1hjnbAwFpvZmH6Qkngwy3kEvZqlm+bSFo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hkYuRV0F3NwZHInUasPgj0Ci4zD8mGkLdNzsFT/8FMJlEhd10EXkNT4hmxYng6BOU
         WT7Tzf/oK6ykIVhyQI88ohiXEMHKBRG3TJ/GmfvjD2nzytddUWQNSEOYMA0p6jAi1F
         lB6qGtln2/xGSsR5XpPrAPhUrw0HHpmbziJEEJIQ=
Message-ID: <208d42df-3dbf-a9b0-6c68-7cded8e2007d@linux.microsoft.com>
Date:   Tue, 1 Mar 2022 14:47:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/1/2022 2:23 PM, Wei Liu wrote:
> On Tue, Mar 01, 2022 at 09:45:41PM +0100, Greg KH wrote:
> > On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> > > - Create skeleton and add basic functionality for the
> > > hyper-v compute device driver (dxgkrnl).
> > > 
> > > - Register for PCI and VM bus driver notifications and
> > > handle initialization of VM bus channels.
> > > 
> > > - Connect the dxgkrnl module to the drivers/hv/ Makefile and Kconfig
> > > 
> > > - Create a MAINTAINERS entry
> > > 
> > > A VM bus channel is a communication interface between the hyper-v guest
> > > and the host. The are two type of VM bus channels, used in the driver:
> > >   - the global channel
> > >   - per virtual compute device channel
> > > 
> > > A PCI device is created for each virtual compute device, projected
> > > by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
> > > id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
> > > arrival of such devices. The PCI config space of the virtual compute
> > > device has luid of the corresponding virtual compute device VM
> > > bus channel. This is how the compute device adapter objects are
> > > linked to VM bus channels.
> > > 
> > > VM bus interface version is exchanged by reading/writing the PCI config
> > > space of the virtual compute device.
> > > 
> > > The IO space is used to handle CPU accessible compute device
> > > allocations. Hyper-v allocates IO space for the global VM bus channel.
> > > 
> > > Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
> > 
> > Please work with internal developers to get reviews from them first,
> > before requiring the kernel community to point out basic issues.  It
> > will save you a lot of time and stop us from feeling like we are having
> > our time wasted.
> > 
> > Some simple examples below that your coworkers should have caught:
> > 
> > > --- /dev/null
> > > +++ b/drivers/hv/dxgkrnl/dxgkrnl.h
> > > @@ -0,0 +1,119 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Copyright (c) 2019, Microsoft Corporation.
> > 
> > It is now 2022 :)
> > 
> > > +void init_ioctls(void);
> > 
> > That is a horrible global function name you just added to the kernel's
> > namespace for a single driver :(
> > 
> > > +long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
> > > +
> > > +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> > > +{
> > > +	*luid = *(struct winluid *)&guid->b[0];
> > 
> > Why is the cast needed?  Shouldn't you use real types in your
> > structures?
> > 
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
> > 
> > > +/*
> > > + * Pointer to the global device data. By design
> > > + * there is a single vGPU device on the VM bus and a single /dev/dxg device
> > > + * is created.
> > > + */
> > > +struct dxgglobal *dxgglobal;
> > 
> > No, make this per-device, NEVER have a single device for your driver.
> > The Linux driver model makes it harder to do it this way than to do it
> > correctly.  Do it correctly please and have no global structures like
> > this.
> > 
>
> This may not be as big an issue as you thought. The device discovery is
> still done via the normal VMBus probing routine. For all intents and
> purposes the dxgglobal structure can be broken down into per device
> fields and a global structure which contains the protocol versioning
> information -- my understanding is there will always be a global
> structure to hold information related to the backend, regardless of how
> many devices there are.
>
> I definitely think splitting is doable, but I also understand why Iouri
> does not want to do it _now_ given there is no such a model for multiple
> devices yet, so anything we put into the per-device structure could be
> incomplete and it requires further changing when such a model arrives
> later.
>
> Iouri, please correct me if I have the wrong mental model here.
>
> All in all, I hope this is not going to be a deal breaker for the
> acceptance of this driver.
>
> Thanks,
> Wei.

I agree with Wei that there always be global driver data.

The driver reflects what the host offers and also it must provide the same
interface to user mode as the host driver does. This is because we want the
user mode clients to use the same device interface as if they are working on
the host directly.

By design a single global VMBus channel is offered by the host and a single
/dev/dxg device is created. The /dev/dxg device provides interface to enumerate
virtual compute devices via an ioctl.

If we are to change this model, we would need to make changes to user mode
clients, which is a big re-design change, affecting many hardware vendors.

Thanks
Iouri
  

