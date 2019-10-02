Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16ADC88CE
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Oct 2019 14:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfJBMkF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Oct 2019 08:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfJBMkF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Oct 2019 08:40:05 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 430082133F;
        Wed,  2 Oct 2019 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570020003;
        bh=C27WP3WjY83XjqK00FA77hEI/TbJNxmgHsX3G7ohuJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1ISHHmlUa3ArxhsAN1rIrYFbdp7E9Nft088x4rC2BWSc1rug9fMRZiNAEvlaN9sk
         psxK5zJ4K0fRIworDS+q3PHxoLSWsTxwjQE2GdAQfEPZ2BVH804MSe+aysCm4f7xwy
         KNwsXlVW8+wyrVavZo30CoO4tzHc6UVNjBTRJcfA=
Date:   Wed, 2 Oct 2019 08:40:02 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "info@metux.net" <info@metux.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Message-ID: <20191002124002.GL17454@sasha-vm>
References: <20190918060227.6834-1-weh@microsoft.com>
 <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
 <20191001184828.GF8171@sasha-vm>
 <PU1P153MB0169811097EA55DF795888B2BF9C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169811097EA55DF795888B2BF9C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 02, 2019 at 08:09:41AM +0000, Dexuan Cui wrote:
>> -----Original Message-----
>> From: Sasha Levin <sashal@kernel.org>
>> Sent: Tuesday, October 1, 2019 11:48 AM
>>
>> On Fri, Sep 20, 2019 at 05:26:34PM +0000, Michael Kelley wrote:
>> >From: Michael Kelley <mikelley@microsoft.com>  Sent: Wednesday,
>> September 18, 2019 2:48 PM
>> >> >
>> >> > Without deferred IO support, hyperv_fb driver informs the host to refresh
>> >> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
>> >> > is screen update or not. This patch supports deferred IO for screens in
>> >> > graphics mode and also enables the frame buffer on-demand refresh. The
>> >> > highest refresh rate is still set at 20Hz.
>> >> >
>> >> > Currently Hyper-V only takes a physical address from guest as the starting
>> >> > address of frame buffer. This implies the guest must allocate contiguous
>> >> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
>> >> > accept address from MMIO region as frame buffer address. Due to these
>> >> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
>> >> > in the guest. This means one more copy of the dirty rectangle inside
>> >> > guest when doing the on-demand refresh. This can be optimized in the
>> >> > future with help from host. For now the host performance gain from
>> deferred
>> >> > IO outweighs the shadow copy impact in the guest.
>> >> >
>> >> > Signed-off-by: Wei Hu <weh@microsoft.com>
>> >
>> >Sasha -- this patch and one other from Wei Hu for the Hyper-V frame buffer
>> >driver should be ready.  Both patches affect only the Hyper-V frame buffer
>> >driver so can go through the Hyper-V tree.  Can you pick these up?  Thx.
>>
>> I can't get this to apply anywhere, what tree is it based on?
>>
>> --
>> Thanks,
>> Sasha
>
>Hi Sasha,
>Today's hyperv/linux.git's hyperv-next branch's top commit is
>    48b72a2697d5 ("hv_netvsc: Add the support of hibernation").
>
>Please pick up two patches from Wei Hu:
>#1: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
>#2: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver

Ah, I guess I was missing the first one. I've queued both for
hyperv-next, thanks!

--
Thanks,
Sasha
