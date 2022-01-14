Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0748F264
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 23:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiANW0i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jan 2022 17:26:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43168 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiANW0h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jan 2022 17:26:37 -0500
Received: from [192.168.1.17] (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 65CAB20B8028;
        Fri, 14 Jan 2022 14:26:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65CAB20B8028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642199197;
        bh=If7C7a508dnCJ0DiCHfoafWzl0CdQjH4vbUyslN3bD8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FX2cF4aJTzR9Hal31tgXlpTLHoAUBGpCi62nLeI+6p2ZEQyP0ydOgj+IFm5hNT1mr
         Z3L5DSekagUeVEEaAd5JHZIr407nRuTIjqgYUngwiPXg1m2yT+q9F74kg8oHpG4YN1
         Fhxd+xWV36UmaALuDQ+NJb0v8Lpxt3v1ZiVZTTSA=
Message-ID: <a89bcbae-bf8f-533a-8e72-3d39a72cf040@linux.microsoft.com>
Date:   Fri, 14 Jan 2022 14:26:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 9/9] drivers: hv: dxgkrnl: Implement DXGSYNCFILE
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <e04c8e820bc166d9d4fe8e388aace731bb3255b0.1641937420.git.iourit@linux.microsoft.com>
 <Yd/Xvd147eh+OWlQ@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yd/Xvd147eh+OWlQ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 1/12/2022 11:41 PM, Greg KH wrote:
> On Wed, Jan 12, 2022 at 11:55:14AM -0800, Iouri Tarassov wrote:
> > Implement the LX_DXCREATESYNCFILE IOCTL (D3DKMTCreateSyncFile).
>
> Your subject line does not describe what this is doing at all, as we
> have no clue what DXGSYNCFILE is.

Hi Greg,

I do not understand this comment. The full description is:
"
     drivers: hv: dxgkrnl: Implement DXGSYNCFILE

     Implement the LX_DXCREATESYNCFILE IOCTL (D3DKMTCreateSyncFile).

     dxgsyncfile is built on top of the Linux sync_file object and
     provides a way for the user mode to synchronize with the execution
     of the device DMA packets.

     The IOCTL creates a dxgsyncfile object for the given GPU synchronization
     object and a fence value. A sync_object file descriptor is returned to
     the caller. The caller could wait for the object by using poll().
     When the GPU synchronization object is signaled on the host, the host
     sends a message to the virtual machine and the sync_file object is
     signaled.
"
Is this not enough?

Thanks
Iouri

