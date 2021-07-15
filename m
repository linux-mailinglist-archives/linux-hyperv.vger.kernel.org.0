Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577D53C9A65
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhGOIWX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 04:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232568AbhGOIWW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 04:22:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77D1561183;
        Thu, 15 Jul 2021 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626337170;
        bh=x0erQbbigJxy9Ld3NKrtzpD/jdcxjRhm1Tqxclbap+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+iQv3zsW/c+md095zgIbme+FPYBlWFYh1qTW+6+Llku7chqjHOhjZgs6JELrJfR1
         r5GJgzXGSbkTbOwN51DL/sqOuM+FdLiqw0dKDVTYpEjpZx5dBqPiLWfDX0gfZs540l
         VPKubJT+iTLhwBJ4JejDlrR/T7IYKAVh3UOCnIgE=
Date:   Thu, 15 Jul 2021 10:19:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
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
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YO/vjkTD2UA5qJqG@kroah.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <YO8deHGP7GBYQp5x@kroah.com>
 <BY5PR21MB1506BDE89848097EF2488FB9CE139@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506BDE89848097EF2488FB9CE139@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 14, 2021 at 09:14:13PM +0000, Long Li wrote:
> > Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
> > 
> > On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > Azure Blob storage provides scalable and durable data storage for Azure.
> > >
> > (https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fazu
> > > re.microsoft.com%2Fen-
> > us%2Fservices%2Fstorage%2Fblobs%2F&amp;data=04%7
> > >
> > C01%7Clongli%40microsoft.com%7C950a81a410c54c2475a308d946ec0c09%7C
> > 72f9
> > >
> > 88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637618801920394272%7CUnk
> > nown%7C
> > >
> > TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> > CJXVC
> > >
> > I6Mn0%3D%7C1000&amp;sdata=iLDP6EYsoCDlLvToJB31hIQxW3NdCnR0UH31
> > FRDwvRI%
> > > 3D&amp;reserved=0)
> > >
> > > This driver adds support for accelerated access to Azure Blob storage.
> > > As an alternative to REST APIs, it provides a fast data path that uses
> > > host native network stack and secure direct data link for storage server
> > access.
> > 
> > So it goes around the block layer?  Why?
> 
> Azure Blob is object-oriented storage solution designed for cloud environments.
> While it's entirely possible to go through block layer, it's not as efficient as using
> its native APIs for data access. Some of the security features (authentication, 
> tokens, lifecycle management) are not easily integrated into block layer. The
> object model in Azure Blob is designed to be scalable and doesn't have many
> limitations that block layer enforces (e.g. number of sectors).

What does the kernel's filesystem and block developers and maintainers
think about this end-run around that subsystem?  Do they agree with this
one-off-custom-ioctl api?  Who has reviewed this api to assure you that
it is sane and actually works properly?

And are you sure that the block layer is not efficient?  You just lost
all use of caching and io_uring and loads of other kernel infrastructure
that has been developed and relied on for decades.  You also just
abandoned the POSIX model and forced people to use a
random-custom-library just to access their storage devices, breaking all
existing programs in the world.

What programs today use this new api?  Where is the api published and
what ensures that it will remain stable?  What happens when it changes
over time, do we have to rebuild all userspace applications?  What
happens to the kernel code over time, how do you handle changes to the
api there?

You are going to need a lot of people to agree that this is ok to
circumvent in order to allow this to be accepted, have you done that
yet?

> Please refer to this link for different storage models in Azure:
> https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction#core-storage-services

Links are not good for changelogs as the kernel changelog is for
forever, while random company urls we have no control over.

thanks,

greg k-h
