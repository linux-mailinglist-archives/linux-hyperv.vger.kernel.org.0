Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC148E16C
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 01:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiANATm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 19:19:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43912 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiANATm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 19:19:42 -0500
Received: from [192.168.1.17] (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id E537C20B8005;
        Thu, 13 Jan 2022 16:19:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E537C20B8005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642119582;
        bh=0DEm4oj1mrYK1qblKietPmGWs0EW7j+UUmyIN7Zh5bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=owfWRYhksw4CmWRPmqfgsZ595SlqgOI5rzs5YFjLHhKshscAnEofPCVmox1pt3G5V
         QPnUqtuAXsktPbp0HjDh4epCnG3vhCoP3yM4DAkt9bvnv1a6Ekp+dB3e5olyR/LCeJ
         yhy1EhX5NDboChLvSvo0FlVbG8UG55Uppo8scYgg=
Message-ID: <0c9f1d07-c9ee-5e23-e494-7198a0d0a54c@linux.microsoft.com>
Date:   Thu, 13 Jan 2022 16:19:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
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
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yd/ZHYbIHQvHp40a@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 1/12/2022 11:47 PM, Greg KH wrote:
> On Wed, Jan 12, 2022 at 11:55:13AM -0800, Iouri Tarassov wrote:
> > Implement various WDDM IOCTLs.
> > 
> Again, break this up into smaller pieces.  Would you want to review all
> of these at the same time?
>
> Remember, you write code for people to review and understand first, and
> the compiler second.  With large changes like this, you are making it
> difficult for people to review, which is your target audience.
>
> I'll stop here, please fix up this patch series into something that is
> reviewable.

Hi Greg,

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
states that "only post say 15 [patches] or so at a time and wait for 
review and integration".
The IOCTLs here are simple and I tried to keep the number of patches smaller
than 15. Is it ok to have more than 15 patches in a submission, or I 
need to
submit the driver is several chunks (some of which would be not fully 
functional)?

Thanks
Iouri

