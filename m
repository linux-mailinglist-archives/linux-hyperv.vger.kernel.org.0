Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85D429633
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Oct 2021 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJKSAo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Oct 2021 14:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhJKSAn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Oct 2021 14:00:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF7F760C49;
        Mon, 11 Oct 2021 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633975123;
        bh=rs3EhQu/IN/0OssK+/JCwtTgQL5fH+Kl8haINYwQDm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5TndyVcgOQ3ztEg3QFjvkUdC78SxenUDcwWYQu995ccPf0Y1IES0pSMXmbAv++Sd
         a+EZ2ZvyJ5/mijMxHsI2vYL5cKMZ2C1sUIm76VYMoufWrPRX8ewcjYzcA854zrxNnk
         +0Th0v195jkgt3H4eBkAv/5T0QO8IOwjmHYncfoQ=
Date:   Mon, 11 Oct 2021 19:58:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>,
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
Message-ID: <YWR7TuGNaMJLXdVr@kroah.com>
References: <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com>
 <87fstb3h6h.fsf@vitty.brq.redhat.com>
 <BY5PR21MB150612332F31358E4031A080CEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB150612332F31358E4031A080CEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 11, 2021 at 05:46:48PM +0000, Long Li wrote:
> > Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated access
> > to Microsoft Azure Blob for Azure VM
> > 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > 
> > ...
> > >
> > > Not to mention the whole crazy idea of "let's implement our REST api
> > > that used to go over a network connection over an ioctl instead!"
> > > That's the main problem that you need to push back on here.
> > >
> > > What is forcing you to put all of this into the kernel in the first
> > > place?  What's wrong with the userspace network connection/protocol
> > > that you have today?
> > >
> > > Does this mean that we now have to implement all REST apis that people
> > > dream up as ioctl interfaces over a hyperv transport?  That would be
> > > insane.
> > 
> > As far as I understand, the purpose of the driver is to replace a "slow"
> > network connection to API endpoint with a "fast" transport over Vmbus. So
> > what if instead of implementing this new driver we just use Hyper-V Vsock and
> > move API endpoint to the host?
> 
> Hi Vitaly,
> 
> We looked at Hyper-V Vsock when designing this driver. The problem is that the Hyper-V device model of Vsock can't support the data throughput and scale needed for Blobs. Vsock is mostly used for management tasks.
> 
> The usage of Blob in Azure justifies an dedicated VMBUS channel (and sub-channels) for a new VSP/VSC driver.

Why not just fix the vsock code to handle data better?  That way all
users of it would benefit.

thanks,

greg k-h
