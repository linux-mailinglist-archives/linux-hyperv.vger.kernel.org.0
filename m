Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07523E1B64
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbhHESek (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241264AbhHESek (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:34:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E5360F22;
        Thu,  5 Aug 2021 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628188466;
        bh=UtExKdknJwWELP42Tar44N0iPU1hu7Jrdi3rzGZLrrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAfG2mch9mi5g4KuL8Ia+7debgTpvSZerbxw7ILeONpZ5TbMAHzGYfZMrRlVu44ia
         pfZUbZwaVbvtzzIabtos6dA0pC3wpowLzlc3bv0o6iFDPX3xhA7Xiybhwa/6573Oax
         TcWGVSkv3nELwIW6KfKIvKr5cGq9dculb4Mb8Fqg=
Date:   Thu, 5 Aug 2021 20:34:23 +0200
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
Message-ID: <YQwvL2N6JpzI+hc8@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 05, 2021 at 06:24:57PM +0000, Long Li wrote:
> > Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
> > access to Microsoft Azure Blob for Azure VM
> > 
> > On 8/5/21 12:00 AM, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > Azure Blob storage [1] is Microsoft's object storage solution for the
> > > cloud. Users or client applications can access objects in Blob storage
> > > via HTTP, from anywhere in the world. Objects in Blob storage are
> > > accessible via the Azure Storage REST API, Azure PowerShell, Azure
> > > CLI, or an Azure Storage client library. The Blob storage interface is
> > > not designed to be a POSIX compliant interface.
> > >
> > > Problem: When a client accesses Blob storage via HTTP, it must go
> > > through the Blob storage boundary of Azure and get to the storage
> > > server through multiple servers. This is also true for an Azure VM.
> > >
> > > Solution: For an Azure VM, the Blob storage access can be accelerated
> > > by having Azure host execute the Blob storage requests to the backend
> > > storage server directly.
> > >
> > > This driver implements a VSC (Virtual Service Client) for accelerating
> > > Blob storage access for an Azure VM by communicating with a VSP
> > > (Virtual Service
> > > Provider) on the Azure host. Instead of using HTTP to access the Blob
> > > storage, an Azure VM passes the Blob storage request to the VSP on the
> > > Azure host. The Azure host uses its native network to perform Blob
> > > storage requests to the backend server directly.
> > >
> > > This driver doesn't implement Blob storage APIs. It acts as a fast
> > > channel to pass user-mode Blob storage requests to the Azure host. The
> > > user-mode program using this driver implements Blob storage APIs and
> > > packages the Blob storage request as structured data to VSC. The
> > > request data is modeled as three user provided buffers (request,
> > > response and data buffers), that are patterned on the HTTP model used
> > > by existing Azure Blob clients. The VSC passes those buffers to VSP for Blob
> > storage requests.
> > >
> > > The driver optimizes Blob storage access for an Azure VM in two ways:
> > >
> > > 1. The Blob storage requests are performed by the Azure host to the
> > > Azure Blob backend storage server directly.
> > >
> > > 2. It allows the Azure host to use transport technologies (e.g. RDMA)
> > > available to the Azure host but not available to the VM, to reach to
> > > Azure Blob backend servers.
> > >
> > > Test results using this driver for an Azure VM:
> > > 100 Blob clients running on an Azure VM, each reading 100GB Block Blobs.
> > > (10 TB total read data)
> > > With REST API over HTTP: 94.4 mins
> > > Using this driver: 72.5 mins
> > > Performance (measured in throughput) gain: 30%.
> > >
> > > [1]
> > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
> > > .microsoft.com%2Fen-us%2Fazure%2Fstorage%2Fblobs%2Fstorage-blobs-
> > intro
> > >
> > duction&amp;data=04%7C01%7Clongli%40microsoft.com%7C6ba60a78f4e74
> > aeb0b
> > >
> > b108d95833bf53%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376
> > 378015
> > >
> > 92577579%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luMzIiL
> > >
> > CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ab5Zl2cQdmUhdT3l
> > SotDwMl
> > > DQuE0JaY%2B1REPQ0%2FjXa4%3D&amp;reserved=0
> > 
> > Is the ioctl interface the only user space interface provided by this kernel
> > driver? If so, why has this code been implemented as a kernel driver instead
> > of e.g. a user space library that uses vfio to interact with a PCIe device? As an
> > example, Qemu supports many different virtio device types.
> 
> The Hyper-V presents one such device for the whole VM. This device is used by all processes on the VM. (The test benchmark used 100 processes)
> 
> Hyper-V doesn't support creating one device for each process. We cannot use VFIO in this model.

I still think this "model" is totally broken and wrong overall.  Again,
you are creating a custom "block" layer with a character device, forcing
all userspace programs to use a custom library (where is it at?) just to
get their data.

There's a reason the POSIX model is there, why are you all ignoring it?

greg k-h
