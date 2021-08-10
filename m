Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3783E589A
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Aug 2021 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbhHJKwg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Aug 2021 06:52:36 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46634 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhHJKwf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Aug 2021 06:52:35 -0400
Received: by mail-wr1-f52.google.com with SMTP id f5so9860873wrm.13;
        Tue, 10 Aug 2021 03:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KeSmCevLwIJ8fZ+xxo6RcyEVfCZToPuvdtR55Ou6S5w=;
        b=pG73GTs2FPZ5oFdcknQqbPOPYWPMd9Q7eD3BH7qDNjx9KVfOY6wRUk7aZEaNxcA0Ij
         GpwUxQjbFnMsAq9FO1iP9zyRxovviELbi0ld4P/zEcLpbbpK62zkqZw7sHdaoMoEEnZ0
         Wjtk6M7OocJMcEmEQ4cQKFAwkl3EaFBcK2B+4mPpYy8Xe0Rs/UgAeN1ebP3lZ1HmSw5M
         krLQNFhbkx5nZKzKV4MYHoZz6equuRPRmbgApbRIG3vDax1FOmYi5/vcUPPIoWWve7Cz
         w5NIWzDdnFOahkh37qo9r/6xYJk7Ua4pQtqKCqhbR1lRaSiq+J1PufeTGNXv2eAEvEgt
         POGw==
X-Gm-Message-State: AOAM532AL7yOOOVwkKtzdglkT5cSyItfhPENq+3qMiteNK0QzM9t2S9E
        AlxHy011cfWNZg8bGkkOgzg=
X-Google-Smtp-Source: ABdhPJxQsW2yUnnHWcCEx6iGI7RTyyMiHTt1WFk7VlM1GJbQ8l1cMinnUMZ0cbsUDRVU35cq3iaibA==
X-Received: by 2002:a5d:4b8c:: with SMTP id b12mr29771414wrt.39.1628592733148;
        Tue, 10 Aug 2021 03:52:13 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y21sm2425423wma.38.2021.08.10.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:52:12 -0700 (PDT)
Date:   Tue, 10 Aug 2021 10:52:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [RFC v1 8/8] mshv: add vfio bridge device
Message-ID: <20210810105211.zzaamjqmcq3jecmn@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-9-wei.liu@kernel.org>
 <b400d536-632e-9212-a06d-6e41af8a6fe5@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b400d536-632e-9212-a06d-6e41af8a6fe5@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 04, 2021 at 12:57:03AM +0530, Praveen Kumar wrote:
> On 09-07-2021 17:13, Wei Liu wrote:
> > +
> > +static int mshv_vfio_set_group(struct mshv_device *dev, long attr, u64 arg)
> > +{
> > +	struct mshv_vfio *mv = dev->private;
> > +	struct vfio_group *vfio_group;
> > +	struct mshv_vfio_group *mvg;
> > +	int32_t __user *argp = (int32_t __user *)(unsigned long)arg;
> > +	struct fd f;
> > +	int32_t fd;
> > +	int ret;
> > +
> > +	switch (attr) {
> > +	case MSHV_DEV_VFIO_GROUP_ADD:
> > +		if (get_user(fd, argp))
> > +			return -EFAULT;
> > +
> > +		f = fdget(fd);
> > +		if (!f.file)
> > +			return -EBADF;
> > +
> > +		vfio_group = mshv_vfio_group_get_external_user(f.file);
> > +		fdput(f);
> > +
> > +		if (IS_ERR(vfio_group))
> > +			return PTR_ERR(vfio_group);
> > +
> > +		mutex_lock(&mv->lock);
> > +
> > +		list_for_each_entry(mvg, &mv->group_list, node) {
> > +			if (mvg->vfio_group == vfio_group) {
> > +				mutex_unlock(&mv->lock);
> > +				mshv_vfio_group_put_external_user(vfio_group);
> > +				return -EEXIST;
> > +			}
> > +		}
> > +
> > +		mvg = kzalloc(sizeof(*mvg), GFP_KERNEL_ACCOUNT);
> > +		if (!mvg) {
> > +			mutex_unlock(&mv->lock);
> > +			mshv_vfio_group_put_external_user(vfio_group);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		list_add_tail(&mvg->node, &mv->group_list);
> > +		mvg->vfio_group = vfio_group;
> > +
> > +		mutex_unlock(&mv->lock);
> > +
> > +		return 0;
> > +
> > +	case MSHV_DEV_VFIO_GROUP_DEL:
> > +		if (get_user(fd, argp))
> > +			return -EFAULT;
> > +
> > +		f = fdget(fd);
> > +		if (!f.file)
> > +			return -EBADF;
> 
> Can we move these both checks above switch statement and do fdput
> accordingly under both case statement accordingly?

Fair point. This can be done, albeit at the cost of having a rather
different code structure.

I was waiting to see if we should somehow merge this with KVM's
implementation so the code was deliberately kept close. If there is no
further comment I can of course make the change you suggested.

> 
> > +
> > +		ret = -ENOENT;
> > +
> > +		mutex_lock(&mv->lock);
> > +
> > +		list_for_each_entry(mvg, &mv->group_list, node) {
> > +			if (!mshv_vfio_external_group_match_file(mvg->vfio_group,
> > +								 f.file))
> > +				continue;
> > +
> > +			list_del(&mvg->node);
> > +			mshv_vfio_group_put_external_user(mvg->vfio_group);
> > +			kfree(mvg);
> > +			ret = 0;
> > +			break;
> > +		}
> > +
> > +		mutex_unlock(&mv->lock);
> > +
> > +		fdput(f);
> > +
> > +		return ret;
> > +	}
> > +
> > +	return -ENXIO;
> > +}
> > +
> > +static int mshv_vfio_set_attr(struct mshv_device *dev,
> > +			      struct mshv_device_attr *attr)
> > +{
> > +	switch (attr->group) {
> > +	case MSHV_DEV_VFIO_GROUP:
> > +		return mshv_vfio_set_group(dev, attr->attr, attr->addr);
> > +	}
> > +
> > +	return -ENXIO;
> > +}
> > +
> > +static int mshv_vfio_has_attr(struct mshv_device *dev,
> > +			      struct mshv_device_attr *attr)
> > +{
> > +	switch (attr->group) {
> > +	case MSHV_DEV_VFIO_GROUP:
> > +		switch (attr->attr) {
> > +		case MSHV_DEV_VFIO_GROUP_ADD:
> > +		case MSHV_DEV_VFIO_GROUP_DEL:
> > +			return 0;
> > +		}
> > +
> > +		break;
> 
> do we need this break statement ? If not, lets remove it.

Will do.

Wei.
