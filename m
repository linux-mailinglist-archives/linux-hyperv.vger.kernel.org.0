Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F60149800
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2020 22:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgAYVpv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 16:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgAYVpu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 16:45:50 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922B720716;
        Sat, 25 Jan 2020 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579988749;
        bh=keOy4GRQhyXRTP/uhH/nLH96KFaq+Sid+s3TTEP9b/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8GDHX7MNYQlUe4RjDIHaJzDlzlesYuLGOvW8lO6ElTcfdwu/Jw/CYhQnQJeV9b0N
         +DLEHIQnQVJ4BAewHnFPj20dEbTxrVb40917yLeKR8Cm1mIfmfFTLcI44gT6yxHQtY
         n3hdH6FrK4KMNyoWc/1OANUSHq3dRcDypPED/kSI=
Date:   Sat, 25 Jan 2020 16:45:48 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of
 hibernation
Message-ID: <20200125214548.GA11467@sasha-vm>
References: <1578350444-129991-1-git-send-email-decui@microsoft.com>
 <20200111162657.GJ1706@sasha-vm>
 <KU1P153MB01505A56BACA9DA4AF0E7BABBF370@KU1P153MB0150.APCP153.PROD.OUTLOOK.COM>
 <HK0P153MB01489C2ABCFF40822EC8B695BF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <HK0P153MB01489C2ABCFF40822EC8B695BF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jan 25, 2020 at 01:59:03AM +0000, Dexuan Cui wrote:
>> From: linux-hyperv-owner@vger.kernel.org
>> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
>> Sent: Wednesday, January 15, 2020 11:53 AM
>> > ...
>> > On Mon, Jan 06, 2020 at 02:40:44PM -0800, Dexuan Cui wrote:
>> > >Add suspend() and resume() functions so the Hyper-V virtual keyboard
>> > >can participate in VM hibernation.
>> > >
>> > >Note that the keyboard is a "wakeup" device that could abort an in-progress
>> > >hibernation if there is keyboard event.  No attempt is made to suppress
>> > this
>> > >behavior.  If desired, a sysadmin can disable the keyboard as a wakeup
>> > device
>> > >using standard mechanisms such as:
>> > >
>> > >echo disabled >
>> > /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
>> > >(where XXX is the device's GUID)
>> > >
>> > >Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
>> > >Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> > >---
>> > >
>> > >This is a RESEND of https://lkml.org/lkml/2019/11/24/115 .
>> >
>> > >Please review.
>> > >
>> > >If it looks good, Sasha Levin, can you please pick it up via the
>> > >hyperv/linux.git tree, as you did last time for this driver?
>> >
>> > This will need an ack from the input driver maintainers, unless they
>> > want to give a blanket ack to this type of patches.
>> >
>> > Thanks,
>> > Sasha
>>
>> Hi Dmitry,
>> May I have your Acked-by for this patch?
>>
>> Thanks
>> -- Dexuan
>
>It looks Dmitry may be on leave and there is no ACK from any input driver
>maintainers. :-(
>
>Sasha, for this patch, I would suggest it may as well go directly through the
>Hyper-V tree because
>1. It's really small and it's a pure Hyper-V change.
>2. This is for a new functionality and it can not break any existing code.
>3. I'm pretty sure it can not cause any merge conflict or build failure.
>
>It's still wonderful to get an Ack or some comment from the input driver
>maintainer(s), so maybe let's wait more time (e.g. a week?) and then I
>suggust we proceed.

I'll queue it up via the hyperv tree, if anyone has any objections
please let me know.

-- 
Thanks,
Sasha
