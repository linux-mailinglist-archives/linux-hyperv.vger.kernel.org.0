Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF86F79F6
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2019 18:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKR36 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Nov 2019 12:29:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39030 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKR35 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Nov 2019 12:29:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id 29so9859089pgm.6
        for <linux-hyperv@vger.kernel.org>; Mon, 11 Nov 2019 09:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fA7Fsg1gpMy56Uu36LA4owNDl1Jh20vv8x7SlaV4qs8=;
        b=iacXhPkc9FGy32VeGcUizlaxp9TQyTa3YCq/Mk6DC1chJi3XqsDkHLsbxG5ogjF7mL
         cHrCAE9nMRbY1ne2C3sr4IhOPaWJ2BRnmockFOBbL70I54EDazU88zBM3JO+CpK73UQ3
         PodZNDoDnD8qH1DoJ1oiFoNgNkaTTyEFmoesB2/PI8l9OtBr5MTXGwh0+SkMxIIiKwBD
         oKc631VrVtl2JSu7Nt5yTatGHrE46KsgfPCuwoSyITvpyvrCJXb6MU68VvMyD0GnQNeq
         2XLnaTQkBqfugUlXoMFeoT1nyAYH8VQDHPUEw3yCqSvvMO9cPzry4w02tpH4rmIb0xCh
         76HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fA7Fsg1gpMy56Uu36LA4owNDl1Jh20vv8x7SlaV4qs8=;
        b=PjDnlt30ifNWLVO8dwyqw2w/XQibEi7ymldz1tOjKFMG6EqTcmHa5aCIUmh+SFC8fq
         OJlwj5k0UBokpfdXPSg6PC+I4CWhmKMaor758ySHS+UwdBztyF/q5CwRHh6zgkl8xssQ
         xvM6BxtxnWgxLQrbBsBFl/5nKBeuBQTH/TT7sp3lNg5RnDnvWXnOhkWNhy/wZavyXBQB
         i7iEtpeV9I4+1s9d/Byw9ICrNmbAYVjs510LmiaelHhsozxS5puhfSdzZN5nDcA1+srH
         6liGTJFZ+w84vthb5KQrMeURxc+oljwTkP8Fk9RI7dhTp6nGZK56UaCUZa4hBu1pcXBM
         QUCA==
X-Gm-Message-State: APjAAAWpP9t0tVhkLNzEF3i2IQsso55faSHx7oMWk+mXzXjW8fRkRgRi
        9xVguNSM2roGGMNsAHnoKiJXrw==
X-Google-Smtp-Source: APXvYqz/ZDi0j4sGOiniVLuzA+Rs8BpMrp5miPmhe+9uGIOTxXjJNz7l6UCNqvoKgWBmZet2LW3hWA==
X-Received: by 2002:a63:7015:: with SMTP id l21mr27824906pgc.200.1573493397028;
        Mon, 11 Nov 2019 09:29:57 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r184sm17589538pfc.106.2019.11.11.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 09:29:56 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:29:48 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lantianyu1986@gmail.com, alex.williamson@redhat.com,
        cohuck@redhat.com, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, sashal@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net, robh@kernel.org,
        Jonathan.Cameron@huawei.com, paulmck@linux.ibm.com,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH] VFIO/VMBUS: Add VFIO VMBUS driver support
Message-ID: <20191111092948.047f1708@hermes.lan>
In-Reply-To: <20191111172322.GB1077444@kroah.com>
References: <20191111084507.9286-1-Tianyu.Lan@microsoft.com>
        <20191111094920.GA135867@kroah.com>
        <20191111084712.37ba7d5a@hermes.lan>
        <20191111172322.GB1077444@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 11 Nov 2019 18:23:22 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Nov 11, 2019 at 08:47:12AM -0800, Stephen Hemminger wrote:
> > On Mon, 11 Nov 2019 01:49:20 -0800
> > "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >   
> > > > +	ret = sysfs_create_bin_file(&channel->kobj,    
> > > &ring_buffer_bin_attr);  
> > > > +	if (ret)
> > > > +		dev_notice(&dev->device,
> > > > +			   "sysfs create ring bin file failed; %d\n",    
> > > ret);  
> > > > +    
> > > 
> > > Again, don't create sysfs files on your own, the bus code should be
> > > doing this for you automatically and in a way that is race-free.
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > The sysfs file is only created if the VFIO/UIO driveris used.  
> 
> That's even worse.  Again, sysfs files should be automatically created
> by the driver core when the device is created.  To randomly add/remove
> random files after that happens means userspace is never notified of
> that and that's not good.
> 
> We've been working for a while to fix up these types of races, don't
> purposfully add new ones for no good reason please :)
> 
> thanks,
> 
> greg k-h

The handler for this sysfs file is in the vfio (and uio) driver.
How would this work if bus handled it?
