Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B663DF596
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 21:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhHCT1X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 15:27:23 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40726 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbhHCT1X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 15:27:23 -0400
Received: from [192.168.1.115] (unknown [223.178.56.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id EDFA320B36E0;
        Tue,  3 Aug 2021 12:27:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDFA320B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628018831;
        bh=ufOXnrjNoj2jj0kO6jzQg5CG4x+xLFn4fbpBWTIdmX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OX10tiq7r0BPbyCoVbcJjWb/k50fZHx/RdYxNchK4NRW4Su3VSgQRuV8t9tBkqyWo
         ojLU/CFXlv8LLCa1um144zvr3MDdxV6ay00ss+I1+mUrApYEZDVHoBZLFQMQqnMU5p
         jHL1/2iAHRnNbksIWXb73QDhByRCjDGY0yxgBAv4=
Subject: Re: [RFC v1 8/8] mshv: add vfio bridge device
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-9-wei.liu@kernel.org>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <b400d536-632e-9212-a06d-6e41af8a6fe5@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 00:57:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-9-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 09-07-2021 17:13, Wei Liu wrote:
> +
> +static int mshv_vfio_set_group(struct mshv_device *dev, long attr, u64 arg)
> +{
> +	struct mshv_vfio *mv = dev->private;
> +	struct vfio_group *vfio_group;
> +	struct mshv_vfio_group *mvg;
> +	int32_t __user *argp = (int32_t __user *)(unsigned long)arg;
> +	struct fd f;
> +	int32_t fd;
> +	int ret;
> +
> +	switch (attr) {
> +	case MSHV_DEV_VFIO_GROUP_ADD:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +
> +		f = fdget(fd);
> +		if (!f.file)
> +			return -EBADF;
> +
> +		vfio_group = mshv_vfio_group_get_external_user(f.file);
> +		fdput(f);
> +
> +		if (IS_ERR(vfio_group))
> +			return PTR_ERR(vfio_group);
> +
> +		mutex_lock(&mv->lock);
> +
> +		list_for_each_entry(mvg, &mv->group_list, node) {
> +			if (mvg->vfio_group == vfio_group) {
> +				mutex_unlock(&mv->lock);
> +				mshv_vfio_group_put_external_user(vfio_group);
> +				return -EEXIST;
> +			}
> +		}
> +
> +		mvg = kzalloc(sizeof(*mvg), GFP_KERNEL_ACCOUNT);
> +		if (!mvg) {
> +			mutex_unlock(&mv->lock);
> +			mshv_vfio_group_put_external_user(vfio_group);
> +			return -ENOMEM;
> +		}
> +
> +		list_add_tail(&mvg->node, &mv->group_list);
> +		mvg->vfio_group = vfio_group;
> +
> +		mutex_unlock(&mv->lock);
> +
> +		return 0;
> +
> +	case MSHV_DEV_VFIO_GROUP_DEL:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +
> +		f = fdget(fd);
> +		if (!f.file)
> +			return -EBADF;

Can we move these both checks above switch statement and do fdput accordingly under both case statement accordingly?

> +
> +		ret = -ENOENT;
> +
> +		mutex_lock(&mv->lock);
> +
> +		list_for_each_entry(mvg, &mv->group_list, node) {
> +			if (!mshv_vfio_external_group_match_file(mvg->vfio_group,
> +								 f.file))
> +				continue;
> +
> +			list_del(&mvg->node);
> +			mshv_vfio_group_put_external_user(mvg->vfio_group);
> +			kfree(mvg);
> +			ret = 0;
> +			break;
> +		}
> +
> +		mutex_unlock(&mv->lock);
> +
> +		fdput(f);
> +
> +		return ret;
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static int mshv_vfio_set_attr(struct mshv_device *dev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_GROUP:
> +		return mshv_vfio_set_group(dev, attr->attr, attr->addr);
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static int mshv_vfio_has_attr(struct mshv_device *dev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_GROUP:
> +		switch (attr->attr) {
> +		case MSHV_DEV_VFIO_GROUP_ADD:
> +		case MSHV_DEV_VFIO_GROUP_DEL:
> +			return 0;
> +		}
> +
> +		break;

do we need this break statement ? If not, lets remove it.
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static void mshv_vfio_destroy(struct mshv_device *dev)
> +{
> +	struct mshv_vfio *mv = dev->private;
> +	struct mshv_vfio_group *mvg, *tmp;
> +
> +	list_for_each_entry_safe(mvg, tmp, &mv->group_list, node) {
> +		mshv_vfio_group_put_external_user(mvg->vfio_group);
> +		list_del(&mvg->node);
> +		kfree(mvg);
> +	}
> +
> +	kfree(mv);
> +	kfree(dev);

We are freeing up dev. Please ignore my comment in caller patch. Thanks.

> +}
> +
> +static int mshv_vfio_create(struct mshv_device *dev, u32 type);
> +
> +static struct mshv_device_ops mshv_vfio_ops = {
> +	.name = "mshv-vfio",
> +	.create = mshv_vfio_create,
> +	.destroy = mshv_vfio_destroy,
> +	.set_attr = mshv_vfio_set_attr,
> +	.has_attr = mshv_vfio_has_attr,
> +};

Regards,

~Praveen.
