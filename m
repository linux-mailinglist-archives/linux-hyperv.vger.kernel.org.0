Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4723DF733
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Aug 2021 00:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhHCWEg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 18:04:36 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36515 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhHCWEf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 18:04:35 -0400
Received: by mail-wm1-f43.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso2661730wms.1;
        Tue, 03 Aug 2021 15:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnTtsqdysP7j6xWlrzTSrClyF+8RVyZ5meC0MIgorOc=;
        b=VHXiH/uybxgoBRzVI0AHzPbvkzQLxX/Cv5Fn0gbcSIWvxtNUkrwmC8ifjVH/McrKCM
         H5CcIaznbtbzmizU+z9m7Vsw1ZpenJ3VtlUKiSkmEsIeafidaSZ/NiD+SUBH8X0t9Ixz
         hA58nFlAUd+s1zkVmTd2sybncDg3h6kRPxWT7rNmllewp51MAECj5E/aVQFzUm8kc/+6
         fblFi/zMx82VGsVtHkgGb2p7t7pEKP5zFFdbQEmyEJAJOQFwfu/F475IqAxMUmDrbI+T
         E+mA7BA7UFl8E7qNF0d8EM5mL+IkPzHOd3G88tgPfc/ya/EvtDJUWu2xBneR6Hc1dyo+
         Vggw==
X-Gm-Message-State: AOAM530g93bTQ3mT09UxfZbYdBT8sA+v7sWe5dZp6mPu/MbpctOZ3ymq
        P+CzGCC1R7bIW3X78ixXLC8=
X-Google-Smtp-Source: ABdhPJxaqBnrWnWTRd4oknQAV9RFFw18JtAxfIQLhJcR0OreP+lEfQT6PYjdmbpgSo/q0mkSEgwguQ==
X-Received: by 2002:a1c:a94f:: with SMTP id s76mr6092879wme.17.1628028262413;
        Tue, 03 Aug 2021 15:04:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 9sm211847wmf.34.2021.08.03.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 15:04:21 -0700 (PDT)
Date:   Tue, 3 Aug 2021 22:04:20 +0000
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
        pasha.tatashin@soleen.com, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        Muminul Islam <muislam@microsoft.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
Message-ID: <20210803220420.am5oqulaahiahyrd@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <4c851046-35f8-28aa-03dd-859f2ade3446@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c851046-35f8-28aa-03dd-859f2ade3446@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 04, 2021 at 12:42:22AM +0530, Praveen Kumar wrote:
> On 09-07-2021 17:13, Wei Liu wrote:
[...]
> > +static long mshv_device_ioctl(struct file *filp, unsigned int ioctl,
> > +			      unsigned long arg)
> > +{
> > +	struct mshv_device *dev = filp->private_data;
> > +
> > +	switch (ioctl) {
> > +	case MSHV_SET_DEVICE_ATTR:
> > +		return mshv_device_ioctl_attr(dev, dev->ops->set_attr, arg);
> > +	case MSHV_GET_DEVICE_ATTR:
> > +		return mshv_device_ioctl_attr(dev, dev->ops->get_attr, arg);
> > +	case MSHV_HAS_DEVICE_ATTR:
> > +		return mshv_device_ioctl_attr(dev, dev->ops->has_attr, arg);
> > +	default:
> > +		if (dev->ops->ioctl)
> > +			return dev->ops->ioctl(dev, ioctl, arg);
> > +
> > +		return -ENOTTY;
> > +	}
> 
> Have seen some static analyzer tool cribbing here of not returning any error.
> If you feel OK, please move the 'return -ENOTTY' down after switch block. Thanks.
> 

Fair point. I will make the change.

> > +}
> > +
[...]
> > +static long
> > +mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> > +	void __user *user_args)
> > +{
> > +	long r;
> > +	struct mshv_create_device tmp, *cd;
> > +	struct mshv_device *dev;
> > +	const struct mshv_device_ops *ops;
> > +	int type;
> > +
> > +	if (copy_from_user(&tmp, user_args, sizeof(tmp))) {
> > +		r = -EFAULT;
> > +		goto out;
> > +	}
> > +
> > +	cd = &tmp;
> > +
> > +	if (cd->type >= ARRAY_SIZE(mshv_device_ops_table)) {
> > +		r = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	type = array_index_nospec(cd->type, ARRAY_SIZE(mshv_device_ops_table));
> > +	ops = mshv_device_ops_table[type];
> > +	if (ops == NULL) {
> > +		r = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	if (cd->flags & MSHV_CREATE_DEVICE_TEST) {
> > +		r = 0;
> > +		goto out;
> > +	}
> > +
> > +	dev = kzalloc(sizeof(*dev), GFP_KERNEL_ACCOUNT);
> > +	if (!dev) {
> > +		r = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	dev->ops = ops;
> > +	dev->partition = partition;
> > +
> > +	r = ops->create(dev, type);
> > +	if (r < 0) {
> > +		kfree(dev);
> > +		goto out;
> > +	}
> > +
> > +	list_add(&dev->partition_node, &partition->devices);
> > +
> > +	if (ops->init)
> > +		ops->init(dev);
> > +
> > +	mshv_partition_get(partition);
> > +	r = anon_inode_getfd(ops->name, &mshv_device_fops, dev, O_RDWR | O_CLOEXEC);
> > +	if (r < 0) {
> > +		mshv_partition_put_no_destroy(partition);
> > +		list_del(&dev->partition_node);
> > +		ops->destroy(dev);
> 
> I hope ops->destroy will free dev as well ?

Yes. It is clearly written in the preceding comment of that hook. I hope
that's prominent enough.

> 
> > +		goto out;
> > +	}
> > +
> > +	cd->fd = r;
> > +	r = 0;
> > +
> > +	if (copy_to_user(user_args, &tmp, sizeof(tmp))) {
> > +		r = -EFAULT;
> 
> I don't think we will be cleaning up anything ? Or do we need to?

No need. Whatever residuals left will be cleaned up once the VM is
destroyed.

Wei.

> > +		goto out;
> > +	}
> > +out:
> > +	return r;
> > +}
> > +
> 
> Regards,
> 
> ~Praveen.
