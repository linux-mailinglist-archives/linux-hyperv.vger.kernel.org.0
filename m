Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A553C2785
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIQaT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 12:30:19 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:43608 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIQaT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 12:30:19 -0400
Received: by mail-wm1-f47.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so6643812wmc.2;
        Fri, 09 Jul 2021 09:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I99DluO6hRqkgYSy9adeh6Pd3SK+vpKFazlB7IMMB7o=;
        b=hNpkF8hEgtbdgqV1iqAyS6wrfxT8je1AIHSjuFb0Vfap47sdtdvwCIdZ4LtaxrCa+m
         hmPeV9O1Qgo9jfFAweVfqM9J8k6GHwP1IDXtwiDhFzqWYoDlPOcW8GoMhZlnzGGEQO5l
         e4zIxQJ3V8bHR2o5c5z9BJ6oAYFJ+ubTgYm35aXhpAFx5dxnIH9wxt31K0Y3YqN4ThAz
         OTJcCb/nqaw441+RkPSB9BA3yGbNDkwwVMQ+gA8a29V8rVJL4bm/FuMR9ZkSRcpfYSq9
         5s6wmagrt/kVQTHedWqhXPu3kwDHPXEjSGL7SYwxfg4XqO/TXiNKt0gfhiLAEsBnpOzr
         Kbbg==
X-Gm-Message-State: AOAM530GjU0fMFsqssRYtpDLwjk3IHAkFEc17oIkj1w8TcJnIskvU69L
        c8PHXkap/uGF4rd3kTalMQ0=
X-Google-Smtp-Source: ABdhPJxWLVC5j6MOmWZdXOvzxW78iECo/y3MWcrXmouKrum9LKBYkGrdroMu/zQ7rohPFrbnB+R1qw==
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr41149353wmq.116.1625848054552;
        Fri, 09 Jul 2021 09:27:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n5sm5604124wri.31.2021.07.09.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 09:27:34 -0700 (PDT)
Date:   Fri, 9 Jul 2021 16:27:32 +0000
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
Message-ID: <20210709162732.hnyzpf3uofzc7xqs@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
 <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
 <YOhsIDccgbUCzwqt@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOhsIDccgbUCzwqt@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 04:32:48PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 09, 2021 at 01:50:13PM +0000, Wei Liu wrote:
> > On Fri, Jul 09, 2021 at 02:02:04PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jul 09, 2021 at 11:43:38AM +0000, Wei Liu wrote:
> > > > +static long
> > > > +mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> > > > +	void __user *user_args)
> > > > +{
> > > [...]
> > > > +	mshv_partition_get(partition);
> > > > +	r = anon_inode_getfd(ops->name, &mshv_device_fops, dev, O_RDWR | O_CLOEXEC);
> > > > +	if (r < 0) {
> > > > +		mshv_partition_put_no_destroy(partition);
> > > > +		list_del(&dev->partition_node);
> > > > +		ops->destroy(dev);
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	cd->fd = r;
> > > > +	r = 0;
> > > 
> > > Why return the fd in memory instead of returning the fd as the return
> > > value from the ioctl?
> > > 
> > > > +	if (copy_to_user(user_args, &tmp, sizeof(tmp))) {
> > > > +		r = -EFAULT;
> > > > +		goto out;
> > > > +	}
> > > 
> > > ... this could then disappear.
> > 
> > Thanks for your comment, Matthew.
> > 
> > This is intentionally because I didn't want to deviate from KVM's API.
> > The fewer differences the better.
> 
> Then don't define your own structure.  Use theirs.

I specifically mentioned in the cover letter I didn't do it because I
was not sure if that would be acceptable. I guess I will find out.

Wei.
