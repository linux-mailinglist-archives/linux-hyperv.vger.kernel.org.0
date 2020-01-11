Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43FC138261
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2020 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgAKQ1A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jan 2020 11:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgAKQ07 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jan 2020 11:26:59 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB7742072E;
        Sat, 11 Jan 2020 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578760019;
        bh=Lm/dzwnqk+gKnieQ7A6Z4s9GBTYaGC56Kq2TS5W+4IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxmxpJnNXr8/koHGDhQZ17ryncVVp95IEGCDLoePQ7dCEW5oqjG7g6B59wFBoeR/J
         9Arp1JNXpRxN7Q+vCYqzUWnxjA5sIzoWcke+sh9KxSH9vLgRV22wwaC16doWvGkUpy
         r9yIVd4d/iNNtaywxaSjkCq51XkuZETg7NuMFSZA=
Date:   Sat, 11 Jan 2020 11:26:57 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, Alexander.Levin@microsoft.com
Subject: Re: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of
 hibernation
Message-ID: <20200111162657.GJ1706@sasha-vm>
References: <1578350444-129991-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1578350444-129991-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 06, 2020 at 02:40:44PM -0800, Dexuan Cui wrote:
>Add suspend() and resume() functions so the Hyper-V virtual keyboard
>can participate in VM hibernation.
>
>Note that the keyboard is a "wakeup" device that could abort an in-progress
>hibernation if there is keyboard event.  No attempt is made to suppress this
>behavior.  If desired, a sysadmin can disable the keyboard as a wakeup device
>using standard mechanisms such as:
>
>echo disabled > /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
>(where XXX is the device's GUID)
>
>Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>This is a RESEND of https://lkml.org/lkml/2019/11/24/115 .
>
>Please review.
>
>If it looks good, Sasha Levin, can you please pick it up via the
>hyperv/linux.git tree, as you did last time for this driver?

This will need an ack from the input driver maintainers, unless they
want to give a blanket ack to this type of patches.

-- 
Thanks,
Sasha
