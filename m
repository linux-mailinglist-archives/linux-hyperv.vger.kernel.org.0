Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BD730996
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jun 2023 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFNVNY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jun 2023 17:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFNVNX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jun 2023 17:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521751FFA;
        Wed, 14 Jun 2023 14:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2BB76188F;
        Wed, 14 Jun 2023 21:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3F0C433C8;
        Wed, 14 Jun 2023 21:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686777201;
        bh=L5664x2EhR80tmvLjgh0nUfR6UTHRdkmKD/8m8GpjUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w4F6xr+Dgm9kyWMLQVvfofUgVARTg7eZzX1uQyrdHVSIy0e0AWGVCljNO290LPaVk
         Tc4Cnal9bFOnYtvobyXmaTOumDUP8ayMqMIcgnGYr8pnKh0+sJQPepj1cjz4p43MM3
         INFnW9PoNC13qhXG/69ZSp+f+MDiUME6HJizdG+Q=
Date:   Wed, 14 Jun 2023 23:13:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] uio: Add hv_vmbus_client driver
Message-ID: <2023061419-probe-velocity-b276@gregkh>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686766512-2589-2-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 14, 2023 at 11:15:08AM -0700, Saurabh Sengar wrote:
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -153,6 +153,13 @@ Contact:	Stephen Hemminger <sthemmin@microsoft.com>
>  Description:	Binary file created by uio_hv_generic for ring buffer
>  Users:		Userspace drivers
>  
> +What:		/sys/bus/vmbus/devices/<UUID>/ring_size
> +Date:		June. 2023

No need for the "."

> +KernelVersion:	6.4

6.4 will be released without this, sorry.

> +Contact:	Saurabh Sengar <ssengar@microsoft.com>
> +Description:	File created by uio_hv_vmbus_client for setting device ring buffer size
> +Users:		Userspace drivers
> +
>  What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_full
>  Date:           February 2019
>  KernelVersion:  5.0
> diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
> index 907ffa3b38f5..33b67f876b96 100644
> --- a/Documentation/driver-api/uio-howto.rst
> +++ b/Documentation/driver-api/uio-howto.rst
> @@ -722,6 +722,52 @@ For example::
>  
>  	/sys/bus/vmbus/devices/3811fe4d-0fa0-4b62-981a-74fc1084c757/channels/21/ring
>  
> +Generic Hyper-V driver for low speed devices
> +============================================
> +
> +The generic driver is a kernel module named uio_hv_vmbus_client. It
> +supports slow devices on the Hyper-V VMBus similar to uio_hv_generic
> +for faster devices. This driver also gives flexibility of customized
> +ring buffer sizes.
> +
> +Making the driver recognize the device
> +--------------------------------------
> +
> +Since the driver does not declare any device GUID's, it will not get
> +loaded automatically and will not automatically bind to any devices, you
> +must load it and allocate id to the driver yourself. For example, to use
> +the fcopy device class GUID::
> +
> +        DEV_UUID=eb765408-105f-49b6-b4aa-c123b64d17d4
> +        driverctl -b vmbus set-override $DEV_UUID uio_hv_vmbus_client

Why are you adding a dependancy on a 300 line bash script that is not
used by most distros?

Why not just show the "real" commands that you can use here that don't
require an external tool not controlled by the kernel at all.

> --- /dev/null
> +++ b/drivers/uio/uio_hv_vmbus_client.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * uio_hv_vmbus_client - UIO driver for low speed VMBus devices
> + *
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Authors:
> + *   Saurabh Sengar <ssengar@microsoft.com>
> + *
> + * Since the driver does not declare any device ids, you must allocate
> + * id and bind the device to the driver yourself.  For example:
> + * driverctl -b vmbus set-override <dev uuid> uio_hv_vmbus_client

Again, no need to discuss driverctl.

> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/uio_driver.h>
> +#include <linux/hyperv.h>
> +
> +#define DRIVER_AUTHOR	"Saurabh Sengar <ssengar@microsoft.com>"
> +#define DRIVER_DESC	"Generic UIO driver for low speed VMBus devices"

You only use these defines in one place, so why not just spell them out
there, no need for 2 extra lines, right?

> +
> +#define DEFAULT_HV_RING_SIZE	VMBUS_RING_SIZE(3 * HV_HYP_PAGE_SIZE)
> +static int ring_size = DEFAULT_HV_RING_SIZE;

You only use that #define in one place, why have it at all?

And you are defining a "global" variable that can be modified by an
individual sysfs file for ANY device bound to this driver, messing with
the other device's ring buffer size, right?  This needs to be
per-device, or explain in huge detail here why not.

> +
> +struct uio_hv_vmbus_dev {
> +	struct uio_info info;
> +	struct hv_device *device;
> +};
> +
> +/* Sysfs API to allow mmap of the ring buffers */
> +static int uio_hv_vmbus_mmap(struct file *filp, struct kobject *kobj,
> +			     struct bin_attribute *attr, struct vm_area_struct *vma)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct hv_device *hv_dev = container_of(dev, struct hv_device, device);
> +	struct vmbus_channel *channel = hv_dev->channel;
> +	void *ring_buffer = page_address(channel->ringbuffer_page);
> +
> +	return vm_iomap_memory(vma, virt_to_phys(ring_buffer),
> +			       channel->ringbuffer_pagecount << PAGE_SHIFT);
> +}
> +
> +static const struct bin_attribute ring_buffer_bin_attr = {
> +	.attr = {
> +		.name = "ringbuffer",
> +		.mode = 0600,
> +	},
> +	.mmap = uio_hv_vmbus_mmap,
> +};
> +
> +/*
> + * This is the irqcontrol callback to be registered to uio_info.
> + * It can be used to disable/enable interrupt from user space processes.
> + *
> + * @param info
> + *  pointer to uio_info.
> + * @param irq_state
> + *  state value. 1 to enable interrupt, 0 to disable interrupt.
> + */
> +static int uio_hv_vmbus_irqcontrol(struct uio_info *info, s32 irq_state)
> +{
> +	struct uio_hv_vmbus_dev *pdata = info->priv;
> +	struct hv_device *hv_dev = pdata->device;
> +
> +	/* Issue a full memory barrier before triggering the notification */
> +	virt_mb();
> +
> +	vmbus_setevent(hv_dev->channel);
> +	return 0;
> +}
> +
> +/*
> + * Callback from vmbus_event when something is in inbound ring.
> + */
> +static void uio_hv_vmbus_channel_cb(void *context)
> +{
> +	struct uio_hv_vmbus_dev *pdata = context;
> +
> +	/* Issue a full memory barrier before sending the event to userspace */
> +	virt_mb();
> +
> +	uio_event_notify(&pdata->info);
> +}
> +
> +static int uio_hv_vmbus_open(struct uio_info *info, struct inode *inode)
> +{
> +	struct uio_hv_vmbus_dev *pdata = container_of(info, struct uio_hv_vmbus_dev, info);
> +	struct hv_device *hv_dev = pdata->device;
> +	struct vmbus_channel *channel = hv_dev->channel;
> +	int ret;
> +
> +	ret = vmbus_open(channel, ring_size, ring_size, NULL, 0,
> +			 uio_hv_vmbus_channel_cb, pdata);
> +	if (ret) {
> +		dev_err(&hv_dev->device, "error %d when opening the channel\n", ret);
> +		return ret;
> +	}
> +	channel->inbound.ring_buffer->interrupt_mask = 0;
> +	set_channel_read_mode(channel, HV_CALL_ISR);
> +
> +	ret = device_create_bin_file(&hv_dev->device, &ring_buffer_bin_attr);
> +	if (ret)
> +		dev_err(&hv_dev->device, "sysfs create ring bin file failed; %d\n", ret);
> +
> +	return ret;
> +}
> +
> +/* VMbus primary channel is closed on last close */
> +static int uio_hv_vmbus_release(struct uio_info *info, struct inode *inode)
> +{
> +	struct uio_hv_vmbus_dev *pdata = container_of(info, struct uio_hv_vmbus_dev, info);
> +	struct hv_device *hv_dev = pdata->device;
> +	struct vmbus_channel *channel = hv_dev->channel;
> +
> +	device_remove_bin_file(&hv_dev->device, &ring_buffer_bin_attr);
> +	vmbus_close(channel);
> +
> +	return 0;
> +}
> +
> +static ssize_t ring_size_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", ring_size);
> +}
> +
> +static ssize_t ring_size_store(struct device *dev, struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	unsigned int val;
> +
> +	if (kstrtouint(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val < HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	ring_size = val;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(ring_size);
> +
> +static struct attribute *uio_hv_vmbus_client_attrs[] = {
> +	&dev_attr_ring_size.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(uio_hv_vmbus_client);
> +
> +static int uio_hv_vmbus_probe(struct hv_device *dev, const struct hv_vmbus_device_id *dev_id)
> +{
> +	struct uio_hv_vmbus_dev *pdata;
> +	int ret;
> +	char *name = NULL;
> +
> +	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	name = kasprintf(GFP_KERNEL, "%pUl", &dev->dev_instance);
> +
> +	/* Fill general uio info */
> +	pdata->info.name = name; /* /sys/class/uio/uioX/name */
> +	pdata->info.version = "1";
> +	pdata->info.irqcontrol = uio_hv_vmbus_irqcontrol;
> +	pdata->info.open = uio_hv_vmbus_open;
> +	pdata->info.release = uio_hv_vmbus_release;
> +	pdata->info.irq = UIO_IRQ_CUSTOM;
> +	pdata->info.priv = pdata;
> +	pdata->device = dev;
> +
> +	ret = uio_register_device(&dev->device, &pdata->info);
> +	if (ret) {
> +		dev_err(&dev->device, "uio_hv_vmbus register failed\n");
> +		return ret;
> +	}
> +
> +	hv_set_drvdata(dev, pdata);
> +
> +	return 0;
> +}
> +
> +static void uio_hv_vmbus_remove(struct hv_device *dev)
> +{
> +	struct uio_hv_vmbus_dev *pdata = hv_get_drvdata(dev);
> +
> +	if (pdata)
> +		uio_unregister_device(&pdata->info);
> +}
> +
> +static struct hv_driver uio_hv_vmbus_drv = {
> +	.driver.dev_groups = uio_hv_vmbus_client_groups,
> +	.name = "uio_hv_vmbus_client",
> +	.id_table = NULL, /* only dynamic id's */

No need to set this if it's NULL.

thanks,

greg k-h
