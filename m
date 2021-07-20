Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB763D0172
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhGTRgc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 13:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232555AbhGTRf2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 13:35:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 106746101B;
        Tue, 20 Jul 2021 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626804966;
        bh=qtVSgG+A7D7xSwJx0othdtiD/Ap1K//pwigS721/SdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exWEcznwBv5PYBDFJUMGm142uvKdPXgvphn/JOQbPq9biO7F1Sp1tkKcA9EqPNXjz
         7DGjpoKu4TVGCrgAnwCGCp/0oekEAZ1nktojKVGGkC62l5dyKgZZyFWA9xtO/Lwkcb
         bkMiOzAeu0IY4pP90uGwbK739Fa/1Y1sasmy7tZc=
Date:   Tue, 20 Jul 2021 20:16:03 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Message-ID: <YPcS41v9x6+VlQXt@kroah.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
 <YPZmtOmpK6+znL0I@infradead.org>
 <DM6PR21MB15138B5D5C8647C92EA6AB99CEE29@DM6PR21MB1513.namprd21.prod.outlook.com>
 <115d864c-46c2-2bc8-c392-fd63d34c9ed0@acm.org>
 <BY5PR21MB1506822C71ED70366E1B1BCBCEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506822C71ED70366E1B1BCBCEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 05:33:47PM +0000, Long Li wrote:
> > Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
> > access to Microsoft Azure Blob
> > 
> > On 7/20/21 12:05 AM, Long Li wrote:
> > >> Subject: Re: [Patch v4 0/3] Introduce a driver to support host
> > >> accelerated access to Microsoft Azure Blob
> > >>
> > >> On Mon, Jul 19, 2021 at 09:37:56PM -0700, Bart Van Assche wrote:
> > >>> such that this object storage driver can be implemented as a
> > >>> user-space library instead of as a kernel driver? As you may know
> > >>> vfio users can either use eventfds for completion notifications or polling.
> > >>> An interface like io_uring can be built easily on top of vfio.
> > >>
> > >> Yes.  Similar to say the NVMe K/V command set this does not look like
> > >> a candidate for a kernel driver.
> > >
> > > The driver is modeled to support multiple processes/users over a VMBUS
> > > channel. I don't see a way that this can be implemented through VFIO?
> > >
> > > Even if it can be done, this exposes a security risk as the same VMBUS
> > > channel is shared by multiple processes in user-mode.
> > 
> > Sharing a VMBUS channel among processes is not necessary. I propose to
> > assign one VMBUS channel to each process and to multiplex I/O submitted to
> > channels associated with the same blob storage object inside e.g. the
> > hypervisor. This is not a new idea. In the NVMe specification there is a
> > diagram that shows that multiple NVMe controllers can provide access to the
> > same NVMe namespace. See also diagram "Figure 416: NVM Subsystem with
> > Three I/O Controllers" in version 1.4 of the NVMe specification.
> > 
> > Bart.
> 
> Currently, the Hyper-V is not designed to have one VMBUS channel for each process.

So it's a slow interface :(

> In Hyper-V, a channel is offered from the host to the guest VM. The host doesn't
> know in advance how many processes are going to use this service so it can't
> offer those channels in advance. There is no mechanism to offer dynamic
> per-process allocated channels based on guest needs. Some devices (e.g.
> network and storage) use multiple channels for scalability but they are not
> for serving individual processes.
> 
> Assigning one VMBUS channel per process needs significant change on the Hyper-V side.

What is the throughput of a single channel as-is?  You provided no
benchmarks or numbers at all in this patchset which would justify this
new kernel driver :(

thanks,

greg k-h
