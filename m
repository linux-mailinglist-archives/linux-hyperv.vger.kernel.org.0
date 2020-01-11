Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA8138263
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2020 17:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgAKQ37 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jan 2020 11:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgAKQ37 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jan 2020 11:29:59 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF0F2072E;
        Sat, 11 Jan 2020 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578760198;
        bh=/wlKCThrzNJPzZekL3yESpjJlP5RxW4MwHyG6+SnY1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmhf/bzIdrvM3mWAMr0lt5BRE0JT4yQNn34Yqr5VNyOHa0cHOHoClVhmddExtTFak
         0Vuq/UahvfhT8PUf50VWKT5hIY6tjvsbEbzM5iglCRVDxF3BK7L3XfDToEyurfPNyM
         B0yF3W4MCZSgbjR5a7DEL0XZ/h9Vdgb6Yz1/n9UI=
Date:   Sat, 11 Jan 2020 11:29:57 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        b.zolnierkie@samsung.com, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.co, weh@microsoft.com
Subject: Re: [PATCH][RESEND] video: hyperv_fb: Fix hibernation for the
 deferred IO feature
Message-ID: <20200111162957.GK1706@sasha-vm>
References: <1578350511-130150-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1578350511-130150-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 06, 2020 at 02:41:51PM -0800, Dexuan Cui wrote:
>fb_deferred_io_work() can access the vmbus ringbuffer by calling
>fbdefio->deferred_io() -> synthvid_deferred_io() -> synthvid_update().
>
>Because the vmbus ringbuffer is inaccessible between hvfb_suspend()
>and hvfb_resume(), we must cancel info->deferred_work before calling
>vmbus_close() and then reschedule it after we reopen the channel
>in hvfb_resume().
>
>Fixes: a4ddb11d297e ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
>Fixes: 824946a8b6fb ("video: hyperv_fb: Add the support of hibernation")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Wei Hu <weh@microsoft.com>
>---
>
>This is a RESEND of https://lkml.org/lkml/2019/11/20/73 .
>
>The only change is the addition of Wei's Review-ed-by.
>
>Please review.
>
>If it looks good, Sasha Levin, can you please pick it up via the
>hyperv/linux.git tree, as you did last time for this driver?

Like with the input driver, if the relevant maintainers here are okay
with this type of patches going through the hyperv tree I'll be happy to
do it, otherwise I need an explicit ack from them on this patch.

-- 
Thanks,
Sasha
