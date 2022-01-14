Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A817C48F02B
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 19:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiANSwv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jan 2022 13:52:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46200 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiANSwu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jan 2022 13:52:50 -0500
Received: from [192.168.1.17] (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 585EC20B8024;
        Fri, 14 Jan 2022 10:52:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 585EC20B8024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642186370;
        bh=NCMbrHqFj2MyzpHXcUuqs6OiEPKcTmD11XGMhrTo38s=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=IZQFahiniKkrDfzd4bRCZPv+w1Ef5v3dAqYgH+5/PM0QikFb++z8qRbMuvkY8M2ki
         6ZEOlBKkloGv29s0+3KpxZAd2EHf4F+EmDx4x6b00suVnFpkqQM4A7BGB9nf0axCL8
         aztsg6PWoTTHbuvLYX/Sfds5XeE4hmuuEfnVe9Fo=
Message-ID: <e472cbe8-44ec-110a-1ad7-bc561cd0be88@linux.microsoft.com>
Date:   Fri, 14 Jan 2022 10:52:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 9/9] drivers: hv: dxgkrnl: Implement DXGSYNCFILE
Content-Language: en-US
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        jenatali@microsoft.com
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <e04c8e820bc166d9d4fe8e388aace731bb3255b0.1641937420.git.iourit@linux.microsoft.com>
 <YeG6+Crv/Bg4h3u1@phenom.ffwll.local>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <YeG6+Crv/Bg4h3u1@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 1/14/2022 10:03 AM, Daniel Vetter wrote:
> Hi all,
>
> On Wed, Jan 12, 2022 at 11:55:14AM -0800, Iouri Tarassov wrote:
> > Implement the LX_DXCREATESYNCFILE IOCTL (D3DKMTCreateSyncFile).
> > 
> > dxgsyncfile is built on top of the Linux sync_file object and
> > provides a way for the user mode to synchronize with the execution
> > of the device DMA packets.
> > 
> > The IOCTL creates a dxgsyncfile object for the given GPU synchronization
> > object and a fence value. A sync_object file descriptor is returned to
> > the caller. The caller could wait for the object by using poll().
> > When the GPU synchronization object is signaled on the host, the host
> > sends a message to the virtual machine and the sync_file object is
> > signaled.
> > 
> > Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
>
> Adding dri-devel, which get_maintainers.pl should have done automatically
> with the dma_fence wildcard match. Not sure why that didn't happen.
>
> > +struct dxgsyncpoint {
> > +	struct dxghostevent	hdr;
> > +	struct dma_fence	base;
>
> This doesn't work unfortuntately. For better or worse memory fences like
> monitored fences from wddm have completely different semantics from
> dma_fence. You could probably hack this to be self-consistent for hyper-v,
> but the problem is that then hv would have incompatible locking/nesting
> rules compared to everything else, and dma_fence matter for memory
> management so this includes whether you're allowed to kmalloc(GFP_KERNEL)
> or not, and that's just a bit too much.
>
> I discussed this quickly with Jesse on irc and it sounds like the reason
> you want the dma_fence is just to emulate the sync_file interface for
> android. I think the correct solution here is to create a hv_dxg_sync_file
> fd, which emulates the exact ioctls that Android needs, but with a wddm
> monitored fence underneath instead of a dma_fence underneath.
>
> This way we guarantee that no one ever accidentally mixes these
> incompatible concepts up in the kernel, and Android should still be able
> to happily run under hyperv.
>
> Thoughts?
>
> Also pls cc me on this sync work since even if you drop dma_fence use
> completely I'd like to follow this a bit.

Hi Daniel,

Thank you for the review and feedback.
I will get this addressed.

Iouri

