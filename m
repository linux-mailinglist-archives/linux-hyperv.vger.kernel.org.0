Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E748F45A
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jan 2022 03:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiAOCQE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jan 2022 21:16:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41216 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiAOCQD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jan 2022 21:16:03 -0500
Received: from [192.168.1.17] (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8807820B8028;
        Fri, 14 Jan 2022 18:16:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8807820B8028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642212963;
        bh=Vfy21Sal+oJpXNlzjKEFjoKc+BDoy2jczgNx/+aa3jw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XDILwQh/RUzgsYdiuxzegJoDivO6Ox8iWbayOvWlB0gwGDzLJ0nDVBSrZzwhd2GwB
         LjcRuzX3FG/dK1uQBQr5D1I4gBWNDeyt6szWa1Zyf/MAqnB4Mm7zeCAV6/HDiWHjW2
         fQuo3p2WAErAMGH8COSZkYWqJRSmBfiwACVt0vD8=
Message-ID: <01c98da0-749c-7293-a783-2048772a81df@linux.microsoft.com>
Date:   Fri, 14 Jan 2022 18:16:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 8/9] drivers: hv: dxgkrnl: Implement various WDDM
 ioctls
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <b3abd5afcf0f46b261064fd0aa4c33a708fbb66b.1641937420.git.iourit@linux.microsoft.com>
 <Yd/ZHYbIHQvHp40a@kroah.com>
 <0c9f1d07-c9ee-5e23-e494-7198a0d0a54c@linux.microsoft.com>
 <YeEMTGqDI1UApH81@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <YeEMTGqDI1UApH81@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 1/13/2022 9:38 PM, Greg KH wrote:
> On Thu, Jan 13, 2022 at 04:19:41PM -0800, Iouri Tarassov wrote:
> > 
> > On 1/12/2022 11:47 PM, Greg KH wrote:
> > > On Wed, Jan 12, 2022 at 11:55:13AM -0800, Iouri Tarassov wrote:
> > > > Implement various WDDM IOCTLs.
> > > > Again, break this up into smaller pieces.  Would you want to review
> > > all
> > > of these at the same time?
> > > 
> > > Remember, you write code for people to review and understand first, and
> > > the compiler second.  With large changes like this, you are making it
> > > difficult for people to review, which is your target audience.
> > > 
> > > I'll stop here, please fix up this patch series into something that is
> > > reviewable.
> > 
> > Hi Greg,
> > 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> > states that "only post say 15 [patches] or so at a time and wait for review
> > and integration".
> > The IOCTLs here are simple and I tried to keep the number of patches smaller
> > than 15. Is it ok to have more than 15 patches in a submission, or I need to
> > submit the driver is several chunks (some of which would be not fully
> > functional)?
>
> We get patch series that are much longer all the time, that's fine.  How
> many do you feel would be needed to properly break this out?

Hi Greg,

I think there could be 20-25 patches.

Implementation of many IOCTLs follow the same pattern:
- add the IOCTL definition to the ioctl table
- implement a function to send the corresponding VM bus message to the host
- implement a function to handle the IOCTL input data, call the function to send
message to the host and copy results back to the caller.

I tried to combine several such implementations to a single patch.
I think the patch is logically simple and it would be easy to review.

What is your opinion?

Thanks
Iouri

