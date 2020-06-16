Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5E1FB1E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 15:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgFPNVd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 09:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPNVd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 09:21:33 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1472D206F1;
        Tue, 16 Jun 2020 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592313692;
        bh=NzmkbhpV6gQ0cqf7U1NrQrUNv6zLElTT90CV/gT2kXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofTlfOUw8BPhx2Iu5uPfykNaA7iGUrhxxKy/hPpiDlwfnFVJh00fKYFJlUK9WaU7g
         wWH/Kw5fsg5b0N0Iee63zhTBNEd4mQraUaXU3u+9ASbhkS64YuHwRgqAi0NryX6IRJ
         YgEi0dom95iZDI/5Z8TMtN4r7+AjR9G/CHQGGiOM=
Date:   Tue, 16 Jun 2020 09:21:30 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dave Airlie <airlied@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ville Syrj??l?? <ville.syrjala@linux.intel.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        linux-hyperv@vger.kernel.org, sthemmin@microsoft.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        haiyangz@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        spronovo@microsoft.com, wei.liu@kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        iourit@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-ID: <20200616132130.GO1931@sasha-vm>
References: <20200519163234.226513-1-sashal@kernel.org>
 <CAPM=9txZpiCGkv3jiBC1F8pTe4A2pqWpQDyjRBXk2roFqw+0+Q@mail.gmail.com>
 <CAPM=9tx4wh-Lk6Dffsdh-7mYvXx+GX2AxhrGqFgyN8-AWJvP6A@mail.gmail.com>
 <20200616105156.GE1718@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200616105156.GE1718@bug>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:51:56PM +0200, Pavel Machek wrote:
>> > Having said that, I hit one stumbling block:
>> > "Further, at this time there are no presentation integration. "
>> >
>> > If we upstream this driver as-is into some hyperv specific place, and
>> > you decide to add presentation integration this is more than likely
>> > going to mean you will want to interact with dma-bufs and dma-fences.
>> > If the driver is hidden away in a hyperv place it's likely we won't
>> > even notice that feature landing until it's too late.
>> >
>> > I would like to see a coherent plan for presentation support (not
>> > code, just an architectural diagram), because I think when you
>> > contemplate how that works it will change the picture of how this
>> > driver looks and intergrates into the rest of the Linux graphics
>> > ecosystem.
>> >
>> > As-is I'd rather this didn't land under my purview, since I don't see
>> > the value this adds to the Linux ecosystem at all, and I think it's
>> > important when putting a burden on upstream that you provide some
>> > value.
>>
>> I also have another concern from a legal standpoint I'd rather not
>> review the ioctl part of this. I'd probably request under DRI
>> developers abstain as well.
>>
>> This is a Windows kernel API being smashed into a Linux driver. I don't want to be
>> tainted by knowledge of an API that I've no idea of the legal status of derived works.
>> (it this all covered patent wise under OIN?)
>
>If you can't look onto it, perhaps it is not suitable to merge into kernel...?
>
>What would be legal requirements so this is "safe to look at"? We should really
>require submitter to meet them...

Could you walk me through your view on what the function of the
"Signed-off-by" tag is?

-- 
Thanks,
Sasha
