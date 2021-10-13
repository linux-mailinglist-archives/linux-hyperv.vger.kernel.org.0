Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34E42B85C
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Oct 2021 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhJMHFZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Oct 2021 03:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232006AbhJMHFY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Oct 2021 03:05:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E0F660EDF;
        Wed, 13 Oct 2021 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634108601;
        bh=WtQf4uvFVelVyj+Fi3La0+7A9K3Xt2zv88Vm2szQP8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAHFnm2FPdV8mEaG1hwpaoqbvu0HkRq1jYkctN7rGixAeb6MC6p7GbLOwUQVXgM1a
         Unj51UuhdA+8csfVeSIwO7ASyQMoa8Uo7ueVucIYPm65eHPerxtI68f5mAn0gKa2Wo
         Zo1T0YMPuyuA55v5a7zKS6QP8+06ElGLH1jQQVwo=
Date:   Wed, 13 Oct 2021 09:03:19 +0200
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
Message-ID: <YWaEtzc7I4LxBV2Q@kroah.com>
References: <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com>
 <87fstb3h6h.fsf@vitty.brq.redhat.com>
 <YWApWbYeGqutoDMG@kroah.com>
 <87a6jj3asl.fsf@vitty.brq.redhat.com>
 <BY5PR21MB15065897C3D2461637986D60CEB59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB150659133AE67AC7CA79A78CCEB79@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB150659133AE67AC7CA79A78CCEB79@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 13, 2021 at 12:58:55AM +0000, Long Li wrote:
> > Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerated access
> > to Microsoft Azure Blob for Azure VM
> > 
> > > Subject: Re: [Patch v5 0/3] Introduce a driver to support host
> > > accelerated access to Microsoft Azure Blob for Azure VM
> > >
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > >
> > > > On Fri, Oct 08, 2021 at 01:11:02PM +0200, Vitaly Kuznetsov wrote:
> > > >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > > >>
> > > >> ...
> > > >> >
> > > >> > Not to mention the whole crazy idea of "let's implement our REST
> > > >> > api that used to go over a network connection over an ioctl instead!"
> > > >> > That's the main problem that you need to push back on here.
> > > >> >
> > > >> > What is forcing you to put all of this into the kernel in the
> > > >> > first place?  What's wrong with the userspace network
> > > >> > connection/protocol that you have today?
> > > >> >
> > > >> > Does this mean that we now have to implement all REST apis that
> > > >> > people dream up as ioctl interfaces over a hyperv transport?
> > > >> > That would be insane.
> > > >>
> > > >> As far as I understand, the purpose of the driver is to replace a "slow"
> > > >> network connection to API endpoint with a "fast" transport over
> > > >> Vmbus.
> > > >
> > > > Given that the network connection is already over vmbus, how is this
> > > > "slow" today?  I have yet to see any benchmark numbers anywhere :(
> > > >
> > > >> So what if instead of implementing this new driver we just use
> > > >> Hyper-V Vsock and move API endpoint to the host?
> > > >
> > > > What is running on the host in the hypervisor that is supposed to be
> > > > handling these requests?  Isn't that really on some other guest?
> > > >
> > >
> > > Long,
> > >
> > > would it be possible to draw a simple picture for us describing the
> > > backend flow of the feature, both with network connection and with
> > > this new driver? We're struggling to understand which particular
> > > bottleneck the driver is trying to eliminate.
> > 
> > Thank you for this great suggestion. I'm preparing some diagrams for describing
> > the problem. I will be sending them soon.
> > 
> 
> Please find the pictures describing the problem and data flow before and after this driver.
> 
> existing_blob_access.jpg shows the current method of accessing Blob through HTTP.
> fastpath_blob_access.jpg shows the access to Blob through this driver.
> 
> This driver enables the Blob application to use the host native network to get access directly to the Data Block server. The host networks are the backbones of Azure. The networks are RDMA capable, but they are not available for use by VMs due to security requirements.

Please wrap your lines when responding...

Anyway, this shows that you are trying to work around a crazy network
design by adding lots of kernel code and a custom user/kernel api.

Please just fix your network design instead, put the network that you
want this "blob api" on the RDMA network so that you will get the same
throughput as this odd one-off ioctl will provide.

That way you also get the proper flow control, error handling,
encryption, and all the other goodness that a real network connection
provides you.  Instead of this custom, one-off, fragile, ioctl command
that requires custom userspace code to handle and needs to be maintained
for the next 40+ years by yourself.

Do it right please, do not force the kernel and userspace to do foolish
things because your network designers do not want to do the real work
here.

thanks,

greg k-h
