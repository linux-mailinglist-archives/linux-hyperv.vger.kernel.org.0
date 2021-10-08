Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64528426898
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbhJHLVy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 07:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240374AbhJHLVx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 07:21:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 973A760F5B;
        Fri,  8 Oct 2021 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633691998;
        bh=EsG1ef6GR6X+pt65HqJvECGs8yv4SUBeNoFGBIyukg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fdm9Y4i3UiEqQ0q8vB8fFguL9tfo7jIFd2R3JL9ef76f/bnmEz0AsVpz6I40Y13TD
         V6zD+blofHlgA5wxO6dsLiv7ZR26zJaFMjvLnLxA7Yfk6nHCuRJkiD/HkXf5zHkpTU
         aCa3+wiVVRJfYjo9x+4ycP5iqdN7Z0Xhiw8z2sFw=
Date:   Fri, 8 Oct 2021 13:19:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Long Li <longli@microsoft.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Message-ID: <YWApWbYeGqutoDMG@kroah.com>
References: <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com>
 <87fstb3h6h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fstb3h6h.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 08, 2021 at 01:11:02PM +0200, Vitaly Kuznetsov wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> ...
> >
> > Not to mention the whole crazy idea of "let's implement our REST api
> > that used to go over a network connection over an ioctl instead!"
> > That's the main problem that you need to push back on here.
> >
> > What is forcing you to put all of this into the kernel in the first
> > place?  What's wrong with the userspace network connection/protocol that
> > you have today?
> >
> > Does this mean that we now have to implement all REST apis that people
> > dream up as ioctl interfaces over a hyperv transport?  That would be
> > insane.
> 
> As far as I understand, the purpose of the driver is to replace a "slow"
> network connection to API endpoint with a "fast" transport over
> Vmbus.

Given that the network connection is already over vmbus, how is this
"slow" today?  I have yet to see any benchmark numbers anywhere :(

> So what if instead of implementing this new driver we just use
> Hyper-V Vsock and move API endpoint to the host?

What is running on the host in the hypervisor that is supposed to be
handling these requests?  Isn't that really on some other guest?

confused,

greg k-h
