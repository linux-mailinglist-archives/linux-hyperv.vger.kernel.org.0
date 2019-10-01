Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A9C405E
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfJASsa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Oct 2019 14:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJASsa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 14:48:30 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F3120B7C;
        Tue,  1 Oct 2019 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955709;
        bh=GNgNrUswTuvHulo9vmyBNdCcYSawvC+U+jdWFB0IKyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erK6Grjo4aC6WkHaCceBQ+bGig2oyXgyMli+uxdawFNMuoPz3ptlHI20zYnrieCdU
         DH7OOYU9vc/9njBGuy7uy4PfYeLd9Uh8a+RY1FFmytt9TO1CwQHXQsyOdJ04V8Ogsu
         DpqPyFfJN64LOCdPZCl/4MKpJVDaxghK2+7Ki9Hw=
Date:   Tue, 1 Oct 2019 14:48:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Hu <weh@microsoft.com>,
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
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Message-ID: <20191001184828.GF8171@sasha-vm>
References: <20190918060227.6834-1-weh@microsoft.com>
 <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 20, 2019 at 05:26:34PM +0000, Michael Kelley wrote:
>From: Michael Kelley <mikelley@microsoft.com>  Sent: Wednesday, September 18, 2019 2:48 PM
>> >
>> > Without deferred IO support, hyperv_fb driver informs the host to refresh
>> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
>> > is screen update or not. This patch supports deferred IO for screens in
>> > graphics mode and also enables the frame buffer on-demand refresh. The
>> > highest refresh rate is still set at 20Hz.
>> >
>> > Currently Hyper-V only takes a physical address from guest as the starting
>> > address of frame buffer. This implies the guest must allocate contiguous
>> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
>> > accept address from MMIO region as frame buffer address. Due to these
>> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
>> > in the guest. This means one more copy of the dirty rectangle inside
>> > guest when doing the on-demand refresh. This can be optimized in the
>> > future with help from host. For now the host performance gain from deferred
>> > IO outweighs the shadow copy impact in the guest.
>> >
>> > Signed-off-by: Wei Hu <weh@microsoft.com>
>
>Sasha -- this patch and one other from Wei Hu for the Hyper-V frame buffer
>driver should be ready.  Both patches affect only the Hyper-V frame buffer
>driver so can go through the Hyper-V tree.  Can you pick these up?  Thx.

I can't get this to apply anywhere, what tree is it based on?

--
Thanks,
Sasha
