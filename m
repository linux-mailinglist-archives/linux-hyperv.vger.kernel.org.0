Return-Path: <linux-hyperv+bounces-4586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5CA6752E
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF23189CB20
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8843020CCF2;
	Tue, 18 Mar 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cY1YWrZz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A920C47B;
	Tue, 18 Mar 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304607; cv=none; b=oDL06DLpMTFiwW1lSG2Pvb+1qG0Sx6nkUMK9PhElsSyv3JfvmQtY81PY3Drj0oxhn3frzPj4Ln466DxwZ2uV1C8X5J4G+8ykp0E0eC9UR03sBm6SRxIoaXid/jMsHPOLgIc20R15eTMlQZpGKLgmVEgMkMBGStPouaab/TSAZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304607; c=relaxed/simple;
	bh=mDVrv+ZGtwsPbLusk7fCoVYkuo/yPrEWMMSYpMxxbRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT0W4ibxrVbRTQkPAlJ/nLW9Tq5BJPappCTKgV/OjTMGDlwB31FhQUg4hmGcrTLo7Z0ndbEgtv2+GYDZJg5ItYdNGhcCq+shoiLpEfQYLr8Acr6L2njy1+EiESyvQOcX1XJDJvYPnjkb1paKtR9Oa5KLVpdiGqjcuy6ua0y7dVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cY1YWrZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAD0C4CEDD;
	Tue, 18 Mar 2025 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742304607;
	bh=mDVrv+ZGtwsPbLusk7fCoVYkuo/yPrEWMMSYpMxxbRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cY1YWrZzX88C8qKZ+uA8ixLBsd3LpQ/t6t2ieODZ8EUlbNmYSX1nGa7QAf82LXAtn
	 FUpL6bVyx7ID2zAlBfIzbEPbbLrFqyMrZy3MbCObLEoFS3yF2rECuzwTxdL7HQ3R5a
	 pdzg5b8hNvlN+zrLNoSOyfOgtVlsWw/ktYKzXqdI=
Date: Tue, 18 Mar 2025 14:28:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <2025031859-overwrite-tidy-f8ef@gregkh>
References: <20250318061558.3294-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318061558.3294-1-namjain@linux.microsoft.com>

On Tue, Mar 18, 2025 at 11:45:58AM +0530, Naman Jain wrote:
> On regular bootup, devices get registered to vmbus first, so when
> uio_hv_generic driver for a particular device type is probed,
> the device is already initialized and added, so sysfs creation in
> uio_hv_generic probe works fine. However, when device is removed
> and brought back, the channel rescinds and device again gets
> registered to vmbus. However this time, the uio_hv_generic driver is
> already registered to probe for that device and in this case sysfs
> creation is tried before the device gets initialized completely.
> 
> Fix this by moving the core logic of sysfs creation for ring buffer,
> from uio_hv_generic to HyperV's vmbus driver, where rest of the sysfs
> attributes for the channels are defined. While doing that, make use
> of attribute groups and macros, instead of creating sysfs directly,
> to ensure better error handling and code flow. While at it, configure
> size of ring sysfs based on ring buffer's actual size and not 2MB default.

When you say stuff like "while at it..." that's a huge hint that the
patch should be broken up into smaller pieces and made a patch series.

> Problem path:
> vmbus_device_register
>     device_register
>         uio_hv_generic probe
>                     sysfs_create_bin_file (fails here)

Why does it fail?

>         kset_create_and_add (dependency)
>         vmbus_add_channel_kobj (dependency)

I don't understand this "graph", sorry.

> +/*
> + * hv_create_ring_sysfs - create ring sysfs entry corresponding to ring buffers for a channel
> + */

Kerneldoc?

> +int hv_create_ring_sysfs(struct vmbus_channel *channel,
> +			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
> +						    struct vm_area_struct *vma))
> +{
> +	struct kobject *kobj = &channel->kobj;
> +
> +	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
> +	channel->ring_sysfs_visible = true;
> +	return sysfs_update_group(kobj, &vmbus_chan_group);
> +}
> +EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);

You just raced userspace and created a file without telling it that it
showed up, right?  Something still feels really wrong here.

greg k-h

