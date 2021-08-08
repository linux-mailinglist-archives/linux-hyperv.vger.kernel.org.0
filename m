Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7672D3E38F2
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Aug 2021 07:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhHHFPW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 8 Aug 2021 01:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhHHFPV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 8 Aug 2021 01:15:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD2ED60F38;
        Sun,  8 Aug 2021 05:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628399703;
        bh=r409KvyNgLbyfYI1tePdR3Fn6jngjHs4GuZ52QDGYW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXaZWx+jEEFDknjNvDH/ZpiTRbEA+YwNxqFY6NSHsrrXBX26RK2hiL6lej1aHNrBm
         U/tyz+1uA3ldYaa5lHZ945pr1Anh+tqG/mGG0hdP156kvDb0CQjPjQlxOcOB6LD6Sv
         Ogm4uQtfoY8H9qTf40aoJS4CD0PpeCVeZdzY8Kls=
Date:   Sun, 8 Aug 2021 07:14:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
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
Message-ID: <YQ9oTBSRyHCffC2k@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Aug 07, 2021 at 06:29:06PM +0000, Long Li wrote:
> > I still think this "model" is totally broken and wrong overall.  Again, you are
> > creating a custom "block" layer with a character device, forcing all userspace
> > programs to use a custom library (where is it at?) just to get their data.
> 
> The Azure Blob library (with source code) is available in the following languages:
> Java: https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/storage/azure-storage-blob
> JavaScript: https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/storage/storage-blob
> Python: https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/storage/azure-storage-blob
> Go: https://github.com/Azure/azure-storage-blob-go
> .NET: https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/storage/Azure.Storage.Blobs
> PHP: https://github.com/Azure/azure-storage-php/tree/master/azure-storage-blob
> Ruby: https://github.com/azure/azure-storage-ruby/tree/master/blob
> C++: https://github.com/Azure/azure-sdk-for-cpp/tree/main/sdk/storage#azure-storage-client-library-for-c

And why wasn't this linked to in the changelog here?

In looking at the C code above, where is the interaction with this Linux
driver?  I can't seem to find it...

> > There's a reason the POSIX model is there, why are you all ignoring it?
> 
> The Azure Blob APIs are not designed to be POSIX compatible. This driver is used
> to accelerate Blob access for a Blob client running in an Azure VM. It doesn't attempt
> to modify the Blob APIs. Changing the Blob APIs will break the existing Blob clients.

There are no Blob clients today on Linux given that this code is not
merged into the kernel yet, so there is nothing to "break".

I still don't see a good reason why this can't just be a block device,
or a filesystem interface and why you need to make this a custom
character device ioctl.

thanks,

greg k-h
