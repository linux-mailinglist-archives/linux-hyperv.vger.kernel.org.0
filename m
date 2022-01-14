Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAD48E3D1
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 06:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiANFk5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jan 2022 00:40:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39740 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiANFk4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jan 2022 00:40:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7647D61B96;
        Fri, 14 Jan 2022 05:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD44C36AE9;
        Fri, 14 Jan 2022 05:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642138855;
        bh=5ynOtxpC/iRlH/SpvjqDeqkPdDCbd0uMSJZvuowCo0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vra0REH2HiRvsiMCKnd/+8jqBhnII4z99Zx8onwrV/tcHLtnzcqMui+Xv/0m/1UPv
         Catj9Ebb3Ym1AgrgbfEk9OKf5KULtj4lFn1q0pIUbfqJCNX0etxyKvNU6zotVDN5Ij
         Tm454mlC1116JyITvypig6OLkJjKSbl/vTh4QXl0=
Date:   Fri, 14 Jan 2022 06:40:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v1 1/9] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <YeEM5asW5XtqD0Pi@kroah.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
 <Yd/YvU5RQOAvLOhC@kroah.com>
 <19e524e6-d0fc-20a7-03c6-c1094681a2a6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e524e6-d0fc-20a7-03c6-c1094681a2a6@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 13, 2022 at 04:08:07PM -0800, Iouri Tarassov wrote:
> 
> On 1/12/2022 11:46 PM, Greg KH wrote:
> > On Wed, Jan 12, 2022 at 11:55:06AM -0800, Iouri Tarassov wrote:
> > > +	dev_dbg(dxgglobaldev, "%s: %x:%x %p %pUb\n",
> > > +		    __func__, adapter->luid.b, adapter->luid.a, hdev->channel,
> > > +		    &hdev->channel->offermsg.offer.if_instance);
> > 
> > When I see something like "global device pointer", that is a HUGE red
> > flag.
> > 
> > No driver should ever have anything that is static to the driver like
> > this, it should always be per-device.  Please use the correct device
> > model here, which does not include a global pointer, but rather unique
> > ones that are given to you by the driver core.  That way you are never
> > tied to only "one device per system" as that is a constraint that you
> > will have to fix eventually, might as well do it all correctly the first
> > time as it is not any extra effort to do so
> Hi Greg,
> 
> dxgglobaldev is a pointer to the global driver data. By design there is a
> single hyper-v VM bus and a single corresponding /dev/dxg device.

That's fine, but use the pointer that you create based on your bus
device, not some static pointer please.

> Virtual GPU adapters are present on the VM bus. /dev/dxg device is used
> to enumerate all virtual GPUs, which are accessible only via IOCTLs
> to /dev/dxg. dxgglobaldev has a list of all vGPU adapters and
> other global driver state. This follows the design on Windows where a single
> global object in dxgkrnl.sys driver is used to enumerate and access all
> GPU devices. This is also how the public D3DKMT interface to dxgkrnl is
> structured.

First off, remember this isn't Windows, let's not make the same mistakes
they have made there please :)

Secondly, this isn't the problem, the issue is that you have a
non-dynamic device here, which is not how Linux drivers should ever
work.  It's fine to have a "mux" device like this, but create it
properly, based on the device that the driver core gives you as you must
respect that lifetime, not the lifetime of a static pointer embedded in
a module.

thanks,

greg k-h
