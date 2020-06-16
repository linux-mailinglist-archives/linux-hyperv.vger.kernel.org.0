Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7473A1FB906
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbgFPQAX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 12:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732614AbgFPQAV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 12:00:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584D620882;
        Tue, 16 Jun 2020 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592323220;
        bh=nhtRihdq0ZnRFzRQVLYSMJPsEUezpVlbdISEsa2u8F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwvcb5lGhEbAtTjUKYtG+m/I0Vwuvkg8ZwXwxUy/bdqyWvbARwe+nPbeVmI45HELY
         k32Drk1lwyA1R4DgzpmrRhwMQlZjKM1yiKXnfWlV1syy8bYMgCU/PyQWMQedOAzL/O
         SQnIfmHT3qkfUTsuJbwEYKQrubysqHO7QnSE1Kws=
Date:   Tue, 16 Jun 2020 12:00:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com,
        chris@chris-wilson.co.uk, ville.syrjala@linux.intel.com,
        Hawking.Zhang@amd.com, tvrtko.ursulin@intel.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-ID: <20200616160019.GQ1931@sasha-vm>
References: <20200519163234.226513-1-sashal@kernel.org>
 <55c57049-1869-7421-aa0f-3ce0b6a133cf@suse.de>
 <20200616105112.GC1718@bug>
 <20200616132819.GP1931@sasha-vm>
 <20200616144122.GA18447@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200616144122.GA18447@duo.ucw.cz>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 04:41:22PM +0200, Pavel Machek wrote:
>On Tue 2020-06-16 09:28:19, Sasha Levin wrote:
>> On Tue, Jun 16, 2020 at 12:51:13PM +0200, Pavel Machek wrote:
>> > Hi!
>> >
>> > > > The driver creates the /dev/dxg device, which can be opened by user mode
>> > > > application and handles their ioctls. The IOCTL interface to the driver
>> > > > is defined in dxgkmthk.h (Dxgkrnl Graphics Port Driver ioctl
>> > > > definitions). The interface matches the D3DKMT interface on Windows.
>> > > > Ioctls are implemented in ioctl.c.
>> > >
>> > > Echoing what others said, you're not making a DRM driver. The driver should live outside
>> > > of the DRM code.
>> > >
>> >
>> > Actually, this sounds to me like "this should not be merged into linux kernel". I mean,
>> > we already have DRM API on Linux. We don't want another one, do we?
>>
>> This driver doesn't have any display functionality.
>
>Graphics cards without displays connected are quite common. I may be
>wrong, but I believe we normally handle them using DRM...

This is more similar to the accelerators that live in drivers/misc/
right now.

>> > And at the very least... this misses API docs for /dev/dxg. Code can't really
>> > be reviewed without that.
>>
>> The docs live here: https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/
>
>I don't see "/dev/dxg" being metioned there. Plus, kernel API

Right, this is because this entire codebase is just a pipe to the API
I've linked, it doesn't implement anything new on it's own.

>documentation should really go to Documentation, and be suitably
>licensed.

While I don't mind copying the docs into Documentation, I'm concerned
that over time they will diverge from the docs on the website. This is
similar to how other documentation (such as the virtio spec) live out of
tree to avoid these issues.

w.r.t the licensing, again: this was sent under GPL2 (note the SPDX tags
in each file), and the patches carry a S-O-B by someone who was a
Microsoft employee at the time the patches were sent.

-- 
Thanks,
Sasha
