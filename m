Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4703529F09
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 May 2019 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfEXTYw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 May 2019 15:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732102AbfEXTYv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 May 2019 15:24:51 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91E6217F9;
        Fri, 24 May 2019 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558725891;
        bh=v5VkPZdMrsfOk5vdtZkpEzgkmscmF3h9SK1vV1by7M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+iUHQgP0tFqAaWHFjwpUpqORkPASPti3JX0npCzmYQTWd6aHptNZ/AqaD81UMS1w
         wzPagk4dqgcwQ3hL6UWAwpNLjjm2J8IXKmtkoBQ/YiYVKi9ltJQw3GN+d8toxDXNlO
         66nzpQyW2iIXYFvE6VWfJ1kup7+De8HVxYEJVeWE=
Date:   Fri, 24 May 2019 15:24:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V commits for 5.2
Message-ID: <20190524192449.GC12898@sasha-vm>
References: <20190506033111.A3EBA205F4@mail.kernel.org>
 <20190524182802.GA7887@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190524182802.GA7887@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 24, 2019 at 08:28:02PM +0200, Greg KH wrote:
>On Sun, May 05, 2019 at 11:31:04PM -0400, Sasha Levin wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
>>
>>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed
>>
>> for you to fetch changes up to a3fb7bf369efa296c1fc68aead1b6fb3c735573b:
>>
>>   drivers: input: serio: Add a module desription to the hyperv_keyboard driver (2019-04-23 15:41:40 -0400)
>>
>> - ----------------------------------------------------------------
>> Adding module description to various hyper-v modules
>>
>> - ----------------------------------------------------------------
>> Joseph Salisbury (3):
>>       drivers: hid: Add a module description line to the hid_hyperv driver
>>       drivers: hv: Add a module description line to the hv_vmbus driver
>>       drivers: input: serio: Add a module desription to the hyperv_keyboard driver
>>
>>  drivers/hid/hid-hyperv.c              | 2 ++
>>  drivers/hv/vmbus_drv.c                | 1 +
>>  drivers/input/serio/hyperv-keyboard.c | 2 ++
>
>This should go through the different subsystems, for the different
>drivers, not just through me.

I was hoping to avoid that for these trivial commits...

I'll resend them.

--
Thanks,
Sasha
