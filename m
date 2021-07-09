Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4C3C23E9
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhGINFF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 09:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhGINFE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 09:05:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B6BC0613DD;
        Fri,  9 Jul 2021 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tf2SqeGSrDZMCCTM8CYLzkNNDskM5g3U5XmDMVPfYxg=; b=QCxP0xW+GMne1FeOeWigUwFFQU
        gCzkCHtzvH87Ef2OzhfSBF2zR8IzSSl1WVWn0ORHedDsAMfkIJGl4UhpL68a+BPjiF4Kx0mEpY5l+
        vZnt1GfzjXbL8vGSfEZC7vk3JuRz8QsSzi4gvmeBhUiDgQHVQbuMHqTUqCr6VGoPeXLk7gzKQbaVH
        8wz4m2m3IHK9ZgbkbSqbxqOX2d0zc18GgLtrdDvsVF++lohd0hWJpYfLu2jOtN1zrukUGSyrPSdDl
        UV6xi77F0Wh1hsI+/uHUX5MXjY1KQsLVB4YQYdUzhD588MPFViUliB3IzCCHG7Y6G2oSOapoRGzLb
        9NiZd2wQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1q8q-00EWCS-Av; Fri, 09 Jul 2021 13:02:08 +0000
Date:   Fri, 9 Jul 2021 14:02:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        Muminul Islam <muislam@microsoft.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
Message-ID: <YOhIzJVPN9SwoRK0@casper.infradead.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709114339.3467637-8-wei.liu@kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 11:43:38AM +0000, Wei Liu wrote:
> +static long
> +mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> +	void __user *user_args)
> +{
[...]
> +	mshv_partition_get(partition);
> +	r = anon_inode_getfd(ops->name, &mshv_device_fops, dev, O_RDWR | O_CLOEXEC);
> +	if (r < 0) {
> +		mshv_partition_put_no_destroy(partition);
> +		list_del(&dev->partition_node);
> +		ops->destroy(dev);
> +		goto out;
> +	}
> +
> +	cd->fd = r;
> +	r = 0;

Why return the fd in memory instead of returning the fd as the return
value from the ioctl?

> +	if (copy_to_user(user_args, &tmp, sizeof(tmp))) {
> +		r = -EFAULT;
> +		goto out;
> +	}

... this could then disappear.

