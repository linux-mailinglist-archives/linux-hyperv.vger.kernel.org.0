Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4781148D32D
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiAMHrr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 02:47:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56606 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiAMHrq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 02:47:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9554FB82017;
        Thu, 13 Jan 2022 07:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBA3C36AE3;
        Thu, 13 Jan 2022 07:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642060064;
        bh=PNI1wR8PywomuwsCo1freT7oONikPeK6ZUeKJnQrX28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olrL8MG7JIeoUKVM1oCgJXPiToNvnr/DnYF1YMo6AHywywcHpImfYnVZdUPX4Wv9W
         iCvAo2ivoM6D4R1NBHf/aj/eaLrmlnzsYJRCxpYpj1T9pDrfR6DEGvVagnvHOltTqP
         ++eAAlPZsZ8xezdFYuA5tZ0gmvZsWZ2GhkcruXC4=
Date:   Thu, 13 Jan 2022 08:47:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v1 8/9] drivers: hv: dxgkrnl: Implement various WDDM
 ioctls
Message-ID: <Yd/ZHYbIHQvHp40a@kroah.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <b3abd5afcf0f46b261064fd0aa4c33a708fbb66b.1641937420.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3abd5afcf0f46b261064fd0aa4c33a708fbb66b.1641937420.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 12, 2022 at 11:55:13AM -0800, Iouri Tarassov wrote:
> Implement various WDDM IOCTLs.
> 
> - IOCTLs to handle GPU virtual addressing (VA):
>    LX_DXRESERVEGPUVIRTUALADDRESS (D3DKMTReserveGpuVertualAddress)
>    LX_DXFREEGPUVIRTUALADDRESS (D3DKMTFreeGpuVertualAddress)
>    LX_DXMAPGPUVIRTUALADDRESS (D3DKMTMapGpuVertualAddress)
>    LX_DXUPDATEGPUVIRTUALADDRESS (D3DKMTUpdateGpuVertualAddress)
> 
>    WDDM supports a compute device to use GPU virtual addresses when
>    accessing allocation memory. A GPU VA could be reserved or mapped
>    to a GPU allocation. The video memory manager on the host updates
>    GPU page tables for the virtual addresses.
> 
> - IOCTLs to manage residency of GPU accessing allocations:
>    LX_DXMAKERESIDENT (D3DKMTMakeResident)
>    LX_DXEVICT (D3DKMTEvict)
> 
>    An allocation is resident when GPU is setup to access it. The
>    current WDDM design does not support on demand GPU page faulting.
>    An allocation must be resident (be in the local device memory or
>    in non-pageable system memory) before GPU is allowed to access it.
> 
> - IOCTLs to offer/reclaim alloctions:
>    LX_DXOFFERALLOCATIONS {D3DKMTOfferAllocations)
>    LX_DXRECLAIMALLOCATIONS2 (D3DKMTReclaimAllocations)
> 
>    When a user mode driver does not need an allocation, it can
>    "offer" it. This means that the allocation is not in use and it
>    local device memory could be reclaimed and given to another allocation.
>    When the allocation is again needed, the caller can "reclaim" the
>    allocations. If the allocation is still in the device local memory,
>    the reclaim operation succeeds. If not the called must restore the
>    content of the allocation before it can be used by the device.
> 
> - LX_DXESCAPE (D3DKMTEscape)
>   This IOCTL is used to send/receive private data between user mode
>   driver and kernel mode driver. This is an extension of the WDDM APIs.
> 
> - LX_DXGETDEVICESTATE (D3DKMTGetDeviceState)
>   The IOCTL is used to get the current execution state of the dxgdevice
>   object.
> 
> - LX_DXMARKDEVICEASERROR (D3DKMTMarkDeviceAsError)
>   The IOCTL is used to bring the dxgdevice object to the error state.
>   Subsequent calls to use the device object will fail.
> 
> - LX_DXQUERYSTATISTICS (D3DKMTQuerystatistics)
>   The IOCTL is used to query various statistics from the compute device
>   on the host.
> 
> - IOCTLs to deal with execution context priorities
>   LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY
>   LX_DXGETCONTEXTSCHEDULINGPRIORITY
>   LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY
>   LX_DXSETCONTEXTSCHEDULINGPRIORITY
> 
> Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
> ---
>  drivers/hv/dxgkrnl/dxgkrnl.h  |    2 +
>  drivers/hv/dxgkrnl/dxgvmbus.c | 1466 ++++++++++++++++++++++++++++---
>  drivers/hv/dxgkrnl/dxgvmbus.h |   15 +
>  drivers/hv/dxgkrnl/ioctl.c    | 1524 ++++++++++++++++++++++++++++++++-
>  4 files changed, 2831 insertions(+), 176 deletions(-)

Again, break this up into smaller pieces.  Would you want to review all
of these at the same time?

Remember, you write code for people to review and understand first, and
the compiler second.  With large changes like this, you are making it
difficult for people to review, which is your target audience.

I'll stop here, please fix up this patch series into something that is
reviewable.

thanks,

greg k-h
