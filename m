Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA733DF524
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 21:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhHCTMn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 15:12:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbhHCTMm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 15:12:42 -0400
Received: from [192.168.1.115] (unknown [223.178.56.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id D6EA3208AB15;
        Tue,  3 Aug 2021 12:12:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D6EA3208AB15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628017951;
        bh=VeMNB2LQ/RnX7E0TmrfsNXJwAX0bjbcHvyH2rDJsnM4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bTFhBNMeXyLt6AJslFgKK9aY4RhQGqquYNGaEau7V3RhBdgbLq4NlBjgnvQbdq1AJ
         hAbpkz7gW15uKiXKOASLYewsj/XuDus6GSYMGodd+s5pnYc9gfveeijs6aWjtBuEo2
         NPNMC5M3sGevcsX3Fpc2Ox5QI7gBoZS27PRKT8U4=
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        Muminul Islam <muislam@microsoft.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <4c851046-35f8-28aa-03dd-859f2ade3446@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 00:42:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-8-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 09-07-2021 17:13, Wei Liu wrote:
> This is basically the same code adopted from KVM. The main user case is
> the future MSHV-VFIO bridge device. We don't have any plan to support
> in-kernel device emulation yet, but it wouldn't hurt to make the code
> more flexible.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  Documentation/virt/mshv/api.rst |  12 +++
>  drivers/hv/mshv_main.c          | 181 ++++++++++++++++++++++++++++++++
>  include/linux/mshv.h            |  57 ++++++++++
>  include/uapi/linux/mshv.h       |  36 +++++++
>  4 files changed, 286 insertions(+)
> 
> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
> index 56a6edfcfe29..7d35dd589831 100644
> --- a/Documentation/virt/mshv/api.rst
> +++ b/Documentation/virt/mshv/api.rst
> @@ -170,4 +170,16 @@ Can be used to get/set various properties of a partition.
>  Some properties can only be set at partition creation. For these, there are
>  parameters in MSHV_CREATE_PARTITION.
>  
> +3.12 MSHV_CREATE_DEVICE
> +-----------------------
> +:Type: partition ioctl
> +:Parameters: struct mshv_create_device
> +:Returns: 0 on success
> +
> +Can be used to create an in-kernel device.
> +
> +If the MSHV_CREATE_DEVICE_TEST flag is set, only test whether the
> +device type is supported (not necessarily whether it can be created
> +in the current vm).
>  
> +Currently only supports VFIO type device.
> diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
> index 4cbc520471e4..84c774a561de 100644
> --- a/drivers/hv/mshv_main.c
> +++ b/drivers/hv/mshv_main.c
> @@ -20,6 +20,8 @@
>  #include <linux/random.h>
>  #include <linux/mshv.h>
>  #include <linux/mshv_eventfd.h>
> +#include <linux/hyperv.h>
> +#include <linux/nospec.h>
>  #include <asm/mshyperv.h>
>  
>  #include "mshv.h"
> @@ -33,6 +35,7 @@ static int mshv_vp_release(struct inode *inode, struct file *filp);
>  static long mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
>  static struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
>  static void mshv_partition_put(struct mshv_partition *partition);
> +static void mshv_partition_put_no_destroy(struct mshv_partition *partition);
>  static int mshv_partition_release(struct inode *inode, struct file *filp);
>  static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
>  static int mshv_dev_open(struct inode *inode, struct file *filp);
> @@ -912,6 +915,172 @@ mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
>  	return ret;
>  }
>  
> +static int mshv_device_ioctl_attr(struct mshv_device *dev,
> +				 int (*accessor)(struct mshv_device *dev,
> +						 struct mshv_device_attr *attr),
> +				 unsigned long arg)
> +{
> +	struct mshv_device_attr attr;
> +
> +	if (!accessor)
> +		return -EPERM;
> +
> +	if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
> +		return -EFAULT;
> +
> +	return accessor(dev, &attr);
> +}
> +
> +static long mshv_device_ioctl(struct file *filp, unsigned int ioctl,
> +			      unsigned long arg)
> +{
> +	struct mshv_device *dev = filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_SET_DEVICE_ATTR:
> +		return mshv_device_ioctl_attr(dev, dev->ops->set_attr, arg);
> +	case MSHV_GET_DEVICE_ATTR:
> +		return mshv_device_ioctl_attr(dev, dev->ops->get_attr, arg);
> +	case MSHV_HAS_DEVICE_ATTR:
> +		return mshv_device_ioctl_attr(dev, dev->ops->has_attr, arg);
> +	default:
> +		if (dev->ops->ioctl)
> +			return dev->ops->ioctl(dev, ioctl, arg);
> +
> +		return -ENOTTY;
> +	}

Have seen some static analyzer tool cribbing here of not returning any error.
If you feel OK, please move the 'return -ENOTTY' down after switch block. Thanks.

> +}
> +
> +static int mshv_device_release(struct inode *inode, struct file *filp)
> +{
> +	struct mshv_device *dev = filp->private_data;
> +	struct mshv_partition *partition = dev->partition;
> +
> +	if (dev->ops->release) {
> +		mutex_lock(&partition->mutex);
> +		list_del(&dev->partition_node);
> +		dev->ops->release(dev);
> +		mutex_unlock(&partition->mutex);
> +	}
> +
> +	mshv_partition_put(partition);
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_device_fops = {
> +	.unlocked_ioctl = mshv_device_ioctl,
> +	.release = mshv_device_release,
> +};
> +
> +static const struct mshv_device_ops *mshv_device_ops_table[MSHV_DEV_TYPE_MAX];
> +
> +int mshv_register_device_ops(const struct mshv_device_ops *ops, u32 type)
> +{
> +	if (type >= ARRAY_SIZE(mshv_device_ops_table))
> +		return -ENOSPC;
> +
> +	if (mshv_device_ops_table[type] != NULL)
> +		return -EEXIST;
> +
> +	mshv_device_ops_table[type] = ops;
> +	return 0;
> +}
> +
> +void mshv_unregister_device_ops(u32 type)
> +{
> +	if (type >= ARRAY_SIZE(mshv_device_ops_table))
> +		return;
> +	mshv_device_ops_table[type] = NULL;
> +}
> +
> +static long
> +mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> +	void __user *user_args)
> +{
> +	long r;
> +	struct mshv_create_device tmp, *cd;
> +	struct mshv_device *dev;
> +	const struct mshv_device_ops *ops;
> +	int type;
> +
> +	if (copy_from_user(&tmp, user_args, sizeof(tmp))) {
> +		r = -EFAULT;
> +		goto out;
> +	}
> +
> +	cd = &tmp;
> +
> +	if (cd->type >= ARRAY_SIZE(mshv_device_ops_table)) {
> +		r = -ENODEV;
> +		goto out;
> +	}
> +
> +	type = array_index_nospec(cd->type, ARRAY_SIZE(mshv_device_ops_table));
> +	ops = mshv_device_ops_table[type];
> +	if (ops == NULL) {
> +		r = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (cd->flags & MSHV_CREATE_DEVICE_TEST) {
> +		r = 0;
> +		goto out;
> +	}
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL_ACCOUNT);
> +	if (!dev) {
> +		r = -ENOMEM;
> +		goto out;
> +	}
> +
> +	dev->ops = ops;
> +	dev->partition = partition;
> +
> +	r = ops->create(dev, type);
> +	if (r < 0) {
> +		kfree(dev);
> +		goto out;
> +	}
> +
> +	list_add(&dev->partition_node, &partition->devices);
> +
> +	if (ops->init)
> +		ops->init(dev);
> +
> +	mshv_partition_get(partition);
> +	r = anon_inode_getfd(ops->name, &mshv_device_fops, dev, O_RDWR | O_CLOEXEC);
> +	if (r < 0) {
> +		mshv_partition_put_no_destroy(partition);
> +		list_del(&dev->partition_node);
> +		ops->destroy(dev);

I hope ops->destroy will free dev as well ?

> +		goto out;
> +	}
> +
> +	cd->fd = r;
> +	r = 0;
> +
> +	if (copy_to_user(user_args, &tmp, sizeof(tmp))) {
> +		r = -EFAULT;

I don't think we will be cleaning up anything ? Or do we need to?
> +		goto out;
> +	}
> +out:
> +	return r;
> +}
> +

Regards,

~Praveen.
