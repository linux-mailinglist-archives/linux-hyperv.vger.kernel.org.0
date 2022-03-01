Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06764C973E
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 21:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiCAUq3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 15:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiCAUq3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 15:46:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558E25549F;
        Tue,  1 Mar 2022 12:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A62DB81D16;
        Tue,  1 Mar 2022 20:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28887C340EE;
        Tue,  1 Mar 2022 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646167544;
        bh=U94uoRe0ExqFxX5KcLf2A78DvXVhL0rQ+fYsok4xSeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mkpCiDjBhly0MMlY+jnJ94vJ+2hl/+agt+NoGzb/N3fnn9QyRoXc3N9a2R1+m20K
         O/aYQQUD0U3pnxnBxGTbRKOkyxbjZzyyrbYo5XU70rvQMz+5FVXumoU9yUSCUsvt0D
         Lv8EnNG6Ft8/wyrm+CvYxMZS6BkmAQ1BzTF6aDEQ=
Date:   Tue, 1 Mar 2022 21:45:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <Yh6F9cG6/SV6Fq8Q@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> - Create skeleton and add basic functionality for the
> hyper-v compute device driver (dxgkrnl).
> 
> - Register for PCI and VM bus driver notifications and
> handle initialization of VM bus channels.
> 
> - Connect the dxgkrnl module to the drivers/hv/ Makefile and Kconfig
> 
> - Create a MAINTAINERS entry
> 
> A VM bus channel is a communication interface between the hyper-v guest
> and the host. The are two type of VM bus channels, used in the driver:
>   - the global channel
>   - per virtual compute device channel
> 
> A PCI device is created for each virtual compute device, projected
> by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
> id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
> arrival of such devices. The PCI config space of the virtual compute
> device has luid of the corresponding virtual compute device VM
> bus channel. This is how the compute device adapter objects are
> linked to VM bus channels.
> 
> VM bus interface version is exchanged by reading/writing the PCI config
> space of the virtual compute device.
> 
> The IO space is used to handle CPU accessible compute device
> allocations. Hyper-v allocates IO space for the global VM bus channel.
> 
> Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>

Please work with internal developers to get reviews from them first,
before requiring the kernel community to point out basic issues.  It
will save you a lot of time and stop us from feeling like we are having
our time wasted.

Some simple examples below that your coworkers should have caught:

> --- /dev/null
> +++ b/drivers/hv/dxgkrnl/dxgkrnl.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2019, Microsoft Corporation.

It is now 2022 :)

> +void init_ioctls(void);

That is a horrible global function name you just added to the kernel's
namespace for a single driver :(

> +long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
> +
> +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> +{
> +	*luid = *(struct winluid *)&guid->b[0];

Why is the cast needed?  Shouldn't you use real types in your
structures?

> +/*
> + * The interface version is used to ensure that the host and the guest use the
> + * same VM bus protocol. It needs to be incremented every time the VM bus
> + * interface changes. DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION is
> + * incremented each time the earlier versions of the interface are no longer
> + * compatible with the current version.
> + */
> +#define DXGK_VMBUS_INTERFACE_VERSION_OLD		27
> +#define DXGK_VMBUS_INTERFACE_VERSION			40
> +#define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16

Where do these numbers come from, the hypervisor specification?

> +/*
> + * Pointer to the global device data. By design
> + * there is a single vGPU device on the VM bus and a single /dev/dxg device
> + * is created.
> + */
> +struct dxgglobal *dxgglobal;

No, make this per-device, NEVER have a single device for your driver.
The Linux driver model makes it harder to do it this way than to do it
correctly.  Do it correctly please and have no global structures like
this.

> +#define DXGKRNL_VERSION			0x2216

What does this mean?

> +#define PCI_VENDOR_ID_MICROSOFT		0x1414
> +#define PCI_DEVICE_ID_VIRTUAL_RENDER	0x008E
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)	"dxgk: " fmt

Use the dev_*() print functions, you are a driver, and you always have a
pointer to a struct device.  There's no need to ever call pr_*().

> +
> +//
> +// Interface from dxgglobal
> +//

You mix /* */ and // styles for large comment blocks like this.  Pick
one and use it consistently.

> +
> +struct vmbus_channel *dxgglobal_get_vmbus(void)
> +{
> +	return dxgglobal->channel.channel;
> +}

Again, no globals.

> +/*
> + * File operations for the /dev/dxg device
> + */
> +
> +static int dxgk_open(struct inode *n, struct file *f)
> +{
> +	return 0;
> +}
> +
> +static int dxgk_release(struct inode *n, struct file *f)
> +{
> +	return 0;
> +}

If you do not need open/release, do not provide them.

> +
> +static ssize_t dxgk_read(struct file *f, char __user *s, size_t len,
> +			 loff_t *o)
> +{
> +	pr_debug("file read\n");

ftrace is your friend, please remove.

> +	return 0;
> +}
> +
> +static ssize_t dxgk_write(struct file *f, const char __user *s, size_t len,
> +			  loff_t *o)
> +{
> +	pr_debug("file write\n");
> +	return len;
> +}
> +
> +const struct file_operations dxgk_fops = {
> +	.owner = THIS_MODULE,
> +	.open = dxgk_open,
> +	.release = dxgk_release,
> +	.write = dxgk_write,
> +	.read = dxgk_read,
> +};
> +
> +/*
> + * Interface with the PCI driver
> + */
> +
> +/*
> + * Part of the PCI config space of the vGPU device is used for vGPU
> + * configuration data. Reading/writing of the PCI config space is forwarded
> + * to the host.
> + */
> +
> +/* vGPU VM bus channel instance ID */
> +#define DXGK_VMBUS_CHANNEL_ID_OFFSET 192

No tab?  Why not?

> +/* DXGK_VMBUS_INTERFACE_VERSION (u32) */

What is this?

> +#define DXGK_VMBUS_VERSION_OFFSET	(DXGK_VMBUS_CHANNEL_ID_OFFSET + \
> +					sizeof(guid_t))

offsetof() is your friend, please use it.

> +/* Luid of the virtual GPU on the host (struct winluid) */

What is a "luid"?

> +#define DXGK_VMBUS_VGPU_LUID_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
> +					sizeof(u32))

Again, offsetof() please.

> +/* The guest writes its capavilities to this adderss */

Odd spelling :(

> +#define DXGK_VMBUS_GUESTCAPS_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
> +					sizeof(u32))

offsetof().

> +static int dxg_probe_vmbus(struct hv_device *hdev,
> +			   const struct hv_vmbus_device_id *dev_id)
> +{
> +	int ret = 0;
> +	struct winluid luid;
> +	struct dxgvgpuchannel *vgpuch;
> +
> +	mutex_lock(&dxgglobal->device_mutex);

Lock the device's mutex, not the global.

> +
> +	if (uuid_le_cmp(hdev->dev_type, id_table[0].guid) == 0) {
> +		/* This is a new virtual GPU channel */
> +		guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
> +		pr_debug("vGPU channel: %pUb",
> +			    &hdev->channel->offermsg.offer.if_instance);
> +		vgpuch = vzalloc(sizeof(struct dxgvgpuchannel));
> +		if (vgpuch == NULL) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +		vgpuch->adapter_luid = luid;
> +		vgpuch->hdev = hdev;
> +		list_add_tail(&vgpuch->vgpu_ch_list_entry,
> +			      &dxgglobal->vgpu_ch_list_head);
> +	} else if (uuid_le_cmp(hdev->dev_type, id_table[1].guid) == 0) {
> +		/* This is the global Dxgkgnl channel */
> +		pr_debug("Global channel: %pUb",
> +			    &hdev->channel->offermsg.offer.if_instance);
> +		if (dxgglobal->hdev) {
> +			/* This device should appear only once */
> +			pr_err("global channel already present\n");
> +			ret = -EBADE;
> +			goto error;
> +		}
> +		dxgglobal->hdev = hdev;
> +	} else {
> +		/* Unknown device type */
> +		pr_err("probe: unknown device type\n");

dev_err().

> +		ret = -EBADE;

-ENODEV


> +		goto error;

No need for this goto.

> +	}
> +
> +error:
> +
> +	mutex_unlock(&dxgglobal->device_mutex);
> +
> +	if (ret)
> +		pr_debug("err: %s %d", __func__, ret);

dev_dbg()

Also, pr_debug() and dev_dbg() already provide you with the function
name, you never need to add it again.

> +	return ret;
> +}
> +
> +static int dxg_remove_vmbus(struct hv_device *hdev)
> +{
> +	int ret = 0;
> +	struct dxgvgpuchannel *vgpu_channel;
> +
> +	mutex_lock(&dxgglobal->device_mutex);
> +
> +	if (uuid_le_cmp(hdev->dev_type, id_table[0].guid) == 0) {
> +		pr_debug("Remove virtual GPU channel\n");
> +		list_for_each_entry(vgpu_channel,
> +				    &dxgglobal->vgpu_ch_list_head,
> +				    vgpu_ch_list_entry) {
> +			if (vgpu_channel->hdev == hdev) {
> +				list_del(&vgpu_channel->vgpu_ch_list_entry);
> +				vfree(vgpu_channel);
> +				break;
> +			}
> +		}
> +	} else if (uuid_le_cmp(hdev->dev_type, id_table[1].guid) == 0) {
> +		pr_debug("Remove global channel device\n");
> +		dxgglobal_destroy_global_channel();
> +	} else {
> +		/* Unknown device type */
> +		pr_err("remove: unknown device type\n");
> +		ret = -EBADE;
> +	}
> +
> +	mutex_unlock(&dxgglobal->device_mutex);
> +	if (ret)
> +		pr_debug("err: %s %d", __func__, ret);
> +	return ret;
> +}
> +
> +MODULE_DEVICE_TABLE(vmbus, id_table);
> +
> +static struct hv_driver dxg_drv = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = id_table,
> +	.probe = dxg_probe_vmbus,
> +	.remove = dxg_remove_vmbus,
> +	.driver = {
> +		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		    },

Odd indentation :(

> +};
> +
> +/*
> + * Interface with Linux kernel

What was the code above this???

> + */
> +
> +static int dxgglobal_create(void)
> +{
> +	int ret = 0;

No need for this variable.

> +
> +	dxgglobal = vzalloc(sizeof(struct dxgglobal));
> +	if (!dxgglobal)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&dxgglobal->plisthead);
> +	mutex_init(&dxgglobal->plistmutex);
> +	mutex_init(&dxgglobal->device_mutex);
> +
> +	INIT_LIST_HEAD(&dxgglobal->vgpu_ch_list_head);
> +
> +	init_rwsem(&dxgglobal->channel_lock);
> +
> +	pr_debug("dxgglobal_init end\n");
> +	return ret;
> +}
> +
> +static void dxgglobal_destroy(void)
> +{
> +	if (dxgglobal) {
> +		if (dxgglobal->vmbus_registered)
> +			vmbus_driver_unregister(&dxg_drv);
> +
> +		dxgglobal_destroy_global_channel();
> +
> +		if (dxgglobal->pci_registered)
> +			pci_unregister_driver(&dxg_pci_drv);
> +
> +		vfree(dxgglobal);
> +		dxgglobal = NULL;
> +	}
> +}
> +
> +/*
> + * Driver entry points

????  Entry into what?

> + */
> +
> +static int __init dxg_drv_init(void)
> +{
> +	int ret;
> +
> +

Too many blank lines.

> +	ret = dxgglobal_create();
> +	if (ret) {
> +		pr_err("dxgglobal_init failed");
> +		return -ENOMEM;
> +	}
> +
> +	ret = vmbus_driver_register(&dxg_drv);
> +	if (ret) {
> +		pr_err("vmbus_driver_register failed: %d", ret);
> +		return ret;
> +	}
> +	dxgglobal->vmbus_registered = true;
> +
> +	pr_info("%s  Version: %x", __func__, DXGKRNL_VERSION);

When drivers work, they are quiet.

Also, in-kernel modules do not have a version, they are part of the
kernel tree, and that's the "version" they have.  You can drop the
individual version here, it makes no sense anymore.

> +#ifndef _D3DKMTHK_H
> +#define _D3DKMTHK_H
> +
> +/* Matches Windows LUID definition */

That does not describe much :(

> +struct winluid {
> +	__u32 a;
> +	__u32 b;

No kernel doc documentation?  What is "a"?  "b"?

I'll stop here in the patch series.

Again, have your coworkers review this first and have them put their
names as part of the signed-off-by chain so that we know they agree with
the submission.

thanks,

greg k-h
