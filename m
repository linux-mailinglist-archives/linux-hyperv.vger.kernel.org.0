Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62B94CB365
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 01:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiCCAR7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 19:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiCCARq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 19:17:46 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA7A41342C1;
        Wed,  2 Mar 2022 16:17:01 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 104A020B7188;
        Wed,  2 Mar 2022 14:59:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 104A020B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646261954;
        bh=7OPbxgXO7od9T1sz9he8vgrLJGoiIVLtkm+eDwYj+BE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jvy1qvkflpZ+78wScRyMqoYB/zUG/eKu8U9IW20ZiEY/zF3BkNM/x548el3VXw7Ow
         Bh9Fo+nT/i2QT/PLUDd7JVtgtt8rkq80Yzg3yus5xcHYWdX31oOtV5LW0rAcLYjBMc
         yuadSzHKR45v0EdNC2iKJ1welM2osk5ViJ+wbAZI=
Message-ID: <7e696255-fba5-614b-81b5-a5f7e0877a83@linux.microsoft.com>
Date:   Wed, 2 Mar 2022 14:59:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yh6F9cG6/SV6Fq8Q@kroah.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Greg,

Thanks a lot for reviewing the patches.

I appreciate the very detailed comments. I my reply I omitted the
comments, which I agree with and will address in subsequent patches.

On 3/1/2022 12:45 PM, Greg KH wrote:

>
> > +long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
> > +
> > +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> > +{
> > +	*luid = *(struct winluid *)&guid->b[0];
>
> Why is the cast needed?  Shouldn't you use real types in your
> structures?


The VMBus channel ID, which is GUID, is present in the PCI config space
of the compute device. The convention is that the lower part of the GUID
is LUID (local unique identifier). This function just converts GUID to
LUID. I am not sure what is the ask here.


> > +/*
> > + * The interface version is used to ensure that the host and the guest use the
> > + * same VM bus protocol. It needs to be incremented every time the VM bus
> > + * interface changes. DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION is
> > + * incremented each time the earlier versions of the interface are no longer
> > + * compatible with the current version.
> > + */
> > +#define DXGK_VMBUS_INTERFACE_VERSION_OLD		27
> > +#define DXGK_VMBUS_INTERFACE_VERSION			40
> > +#define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
>
> Where do these numbers come from, the hypervisor specification?


The definitions are for the VMBus interface between the virtual compute
device in the guest and the Windows host. The interface version is
updated when the VMBus protocol is changed. These are specific to the
virtual compute device, not to the hypervisor.


> > +/*
> > + * Pointer to the global device data. By design
> > + * there is a single vGPU device on the VM bus and a single /dev/dxg device
> > + * is created.
> > + */
> > +struct dxgglobal *dxgglobal;
>
> No, make this per-device, NEVER have a single device for your driver.
> The Linux driver model makes it harder to do it this way than to do it
> correctly.  Do it correctly please and have no global structures like
> this.


This will be addressed in the next version of patches.


> > +#define DXGKRNL_VERSION			0x2216
>
> What does this mean?


This is the driver implementation version. There are many Microsoft
shipped Linux kernels, which include the driver. The version allows to
quickly determine, which level of functionality or bug fixes is
implemented in the current driver.


> > +
> > +/*
> > + * Interface with the PCI driver
> > + */
> > +
> > +/*
> > + * Part of the PCI config space of the vGPU device is used for vGPU
> > + * configuration data. Reading/writing of the PCI config space is forwarded
> > + * to the host.
> > + */
>
> > +/* DXGK_VMBUS_INTERFACE_VERSION (u32) */
>
> What is this?


This comment explains that the value of DXGK_VMBUS_INTERFACE_VERSION is
located at the offset DXGK_VMBUS_CHANNEL_ID_OFFSET in the PCI config space.


> > +#define DXGK_VMBUS_VERSION_OFFSET	(DXGK_VMBUS_CHANNEL_ID_OFFSET + \
> > +					sizeof(guid_t))
>
> offsetof() is your friend, please use it.


There is no structure definition for the PCI config space of the device.
Therefore, offsets are computed by using data size.


> > +/* Luid of the virtual GPU on the host (struct winluid) */
>
> What is a "luid"?


LUID is "Locally Unique Identifier". It is used in Windows and its value
is guaranteed to be unique until the computer reboots. This is similar
to GUID, but is it not globally unique. Dxgkrnl on the host uses LUIDs
to identify compute adapter objects.
I added a comment to the definition in the header.


> > +	ret = vmbus_driver_register(&dxg_drv);
> > +	if (ret) {
> > +		pr_err("vmbus_driver_register failed: %d", ret);
> > +		return ret;
> > +	}
> > +	dxgglobal->vmbus_registered = true;
> > +
> > +	pr_info("%s  Version: %x", __func__, DXGKRNL_VERSION);
>
> When drivers work, they are quiet.
>
> Also, in-kernel modules do not have a version, they are part of the
> kernel tree, and that's the "version" they have.  You can drop the
> individual version here, it makes no sense anymore.


Microsoft develops many Linux kernels when the dxgkrnl driver is
included (EFLOW, Android, WSL). The kernels are built at different times
and might include a different version of the driver. Printing the
version allows to quickly determine what functionality and bug fixes are
included in the driver.

I see that other in-tree drivers print some information during
init_module (like nfblock.c).

This is done for convenience. So instead of tracking multiple kernel
versions, we can track the dxgkrnl driver version. I am ok to remove it
if it really hurts something. It is only a single line per driver load.


Thanks

Iouri

