Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316013C2541
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhGINxA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 09:53:00 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34636 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhGINxA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 09:53:00 -0400
Received: by mail-wr1-f44.google.com with SMTP id p8so12288720wrr.1;
        Fri, 09 Jul 2021 06:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GoDqQzDQbxqFmqbu69TknlhRgwp/b+vsLpDJzZkaLpI=;
        b=A7u/m/LMbrIXNThlyol64Vsn/TgD/P73G3UBPGZ981KTBK+fNByDp/tre4HLU1cBla
         T6zjLLyZLuB5OuFVcOxs/14QJF2ezPzoFI8t0r478NSkgsuaVuqZ9CT7lJmySowoxM9x
         yyf7ur2tjxFQAaeeINmXfqJtL4x61i42rCQFFRW/ogy+jRXW2HGcj6gE0gA8Uc8c2rws
         Dx03anX0kXN5E9E32Oo20AqM+eRm0L9r5uaN0ZRFrnJV0o5YAdifIF2snIokxM/2p76J
         lKNHh5TCVso4XhyegPY/TxSv25r7Swmphd1M4bY/0eqi2K3m3e5dSX1flv/0L0E/Yq9c
         tO6w==
X-Gm-Message-State: AOAM532L45xRDRn1I4LAUIOJ7bCp825ayw43ZNFAQmJnS52RLAUi7VGe
        x6A2hEHXjJSIdCGqr2ZEPbU=
X-Google-Smtp-Source: ABdhPJzqIo3dbkRJ9yXT6zzK0Z3dgsbYWCZD7236whK5CFs6O9bGHzd+llyNLK5mKQUsA9bpaYQxYg==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr16659403wrw.235.1625838615682;
        Fri, 09 Jul 2021 06:50:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g3sm5416303wrv.64.2021.07.09.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:50:15 -0700 (PDT)
Date:   Fri, 9 Jul 2021 13:50:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
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
Message-ID: <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOhIzJVPN9SwoRK0@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 02:02:04PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 09, 2021 at 11:43:38AM +0000, Wei Liu wrote:
> > +static long
> > +mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> > +	void __user *user_args)
> > +{
> [...]
> > +	mshv_partition_get(partition);
> > +	r = anon_inode_getfd(ops->name, &mshv_device_fops, dev, O_RDWR | O_CLOEXEC);
> > +	if (r < 0) {
> > +		mshv_partition_put_no_destroy(partition);
> > +		list_del(&dev->partition_node);
> > +		ops->destroy(dev);
> > +		goto out;
> > +	}
> > +
> > +	cd->fd = r;
> > +	r = 0;
> 
> Why return the fd in memory instead of returning the fd as the return
> value from the ioctl?
> 
> > +	if (copy_to_user(user_args, &tmp, sizeof(tmp))) {
> > +		r = -EFAULT;
> > +		goto out;
> > +	}
> 
> ... this could then disappear.

Thanks for your comment, Matthew.

This is intentionally because I didn't want to deviate from KVM's API.
The fewer differences the better.

Wei.


> 
